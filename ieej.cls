%% ============================================================
%% ieej.cls - 電気学会全国大会 講演論文クラスファイル
%% IEEJ National Convention Paper Class (LuaLaTeX/upLaTeX)
%% ============================================================
%% Version: 1.7
%% License: MIT
%% ============================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ieej}[2024/01/01 IEEJ National Convention Paper Class]

%% ============================================================
%% エンジン判定
%% ============================================================
\RequirePackage{iftex}

%% ============================================================
%% オプション処理
%% ============================================================
\newif\if@english\@englishfalse
\DeclareOption{english}{\@englishtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% ============================================================
%% ベースクラス読み込み
%% ============================================================
\ifluatex
  \LoadClass[a4paper,10pt,twocolumn]{ltjsarticle}
\else\ifuptex
  \LoadClass[a4paper,10pt,twocolumn,uplatex]{jsarticle}
\else
  \LoadClass[a4paper,10pt,twocolumn]{jsarticle}
\fi\fi

%% ============================================================
%% パッケージ読み込み
%% ============================================================
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{url}

%% ============================================================
%% フォント設定
%% ============================================================
\ifluatex
  \RequirePackage{luatexja}
  \RequirePackage{luatexja-fontspec}
  %% 日本語フォント: MS明朝/MSゴシック（Windows）または IPAex（Linux）
  \IfFontExistsTF{MS Mincho}{%
    \setmainjfont{MS Mincho}
    \setsansjfont{MS Gothic}
    \newjfontfamily\gtfamily{MS Gothic}
  }{%
    \IfFontExistsTF{IPAexMincho}{%
      \setmainjfont{IPAexMincho}
      \setsansjfont{IPAexGothic}
      \newjfontfamily\gtfamily{IPAexGothic}
    }{%
      \newcommand{\gtfamily}{\sffamily}
    }%
  }
  %% 欧文フォント: Times系
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
\else
  \newcommand{\gtfamily}{\sffamily}
\fi

%% ============================================================
%% ページレイアウト（電気学会指定）
%% ============================================================
\RequirePackage[
  top=20mm,
  bottom=20mm,
  left=18mm,
  right=18mm,
  columnsep=8mm
]{geometry}

%% ============================================================
%% 行間設定
%% ============================================================
\RequirePackage{setspace}
\setstretch{0.95}

%% 段落間スペース
\setlength{\parskip}{0pt}

%% ============================================================
%% 全角山括弧の定義
%% ============================================================
\newcommand{\zwlangle}{＜}
\newcommand{\zwrangle}{＞}

%% ============================================================
%% セクション見出し
%% ============================================================
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection・\arabic{subsection}}

\makeatletter
% セクション（ゴシック体）
\renewcommand{\section}{%
  \@startsection{section}{1}{\z@}%
  {0.8ex plus .3ex minus .1ex}%
  {0.3ex plus .1ex}%
  {\normalfont\normalsize\gtfamily}}

% サブセクションはrunin形式（明朝体）
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
  {0.6ex plus .2ex minus .1ex}%
  {-1em}%
  {\normalfont\normalsize}}

% セクション番号フォーマット
\renewcommand{\@seccntformat}[1]{%
  \csname @seccntformat@#1\endcsname}
\newcommand{\@seccntformat@section}{\thesection ．\hspace{0.5em}}
\newcommand{\@seccntformat@subsection}{\zwlangle\thesubsection\zwrangle}
\makeatother

%% ============================================================
%% キャプション設定（和文＋英文）
%% ============================================================
\RequirePackage[font=small]{caption}

% 表キャプション用コマンド（和文＋英文）
\newcommand{\tabcaption}[2]{%
  \refstepcounter{table}%
  \par\vskip 0.5ex%
  {\small 表 \thetable\hspace{0.5em}#1}%
  \par\vskip -0.5ex%
  {\small Table \thetable.\hspace{0.5em}#2}%
  \par\vskip 0.5ex%
}

% 図キャプション用コマンド（和文＋英文）
\newcommand{\figcaption}[2]{%
  \refstepcounter{figure}%
  \par\vskip 0.5ex%
  {\small 図 \thefigure\hspace{0.5em}#1}%
  \par\vskip -0.5ex%
  {\small Fig.\thefigure.\hspace{0.5em}#2}%
  \par%
}

%% ============================================================
%% ヘッダー・フッターなし
%% ============================================================
\pagestyle{empty}

%% ============================================================
%% タイトル・著者情報用コマンド
%% ============================================================
\makeatletter
% 日本語タイトル
\def\jtitle#1{\gdef\@jtitle{#1}}
\def\@jtitle{\@latex@error{No \noexpand\jtitle given}\@ehc}

% 英語タイトル
\def\etitle#1{\gdef\@etitle{#1}}
\def\@etitle{\@latex@error{No \noexpand\etitle given}\@ehc}

% 日本語著者
\def\jauthor#1{\gdef\@jauthor{#1}}
\def\@jauthor{\@latex@error{No \noexpand\jauthor given}\@ehc}

% 英語著者
\def\eauthor#1{\gdef\@eauthor{#1}}
\def\@eauthor{\@latex@error{No \noexpand\eauthor given}\@ehc}

% 講演者マーク
\newcommand{\presenter}{${}^{*}$}

%% ============================================================
%% タイトル出力
%% ============================================================
\renewcommand{\maketitle}{%
  \twocolumn[%
    \centering
    {\Large \@jtitle\par}%
    \vskip 1ex%
    {\normalsize \@jauthor\par}%
    \vskip 1.5ex%
    {\normalsize \@etitle\par}%
    {\normalsize \@eauthor\par}%
    \vskip 2ex%
  ]%
}
\makeatother

%% ============================================================
%% 文献スタイル（電気学会形式）
%% ============================================================
% 文献番号を (1) 形式に変更
\makeatletter
\renewcommand{\@biblabel}[1]{(#1)}

% 文献見出しをセンタリング＋横線付きに変更
\renewenvironment{thebibliography}[1]{%
  \vskip 0.5ex%
  \begingroup
  \centering
  文　献\par
  \endgroup
  \vskip -1.5ex%
  \noindent\hrulefill\par%
  \vskip -0.5ex%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \topsep=0pt%
    \itemsep=0pt%
    \parsep=0pt%
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}%
  }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\makeatother

% 本文中の引用も (1) 形式に変更
\RequirePackage{cite}
\renewcommand{\citeleft}{(}
\renewcommand{\citeright}{)}

\endinput
