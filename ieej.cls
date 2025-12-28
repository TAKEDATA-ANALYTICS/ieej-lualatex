%% ============================================================
%% ieej.cls - 電気学会全国大会 講演論文クラスファイル
%% IEEJ National Convention Paper Class (LuaLaTeX/upLaTeX)
%% ============================================================
%% Version: 1.3
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
  %% Windowsの場合
  \IfFontExistsTF{MS Mincho}{%
    \setmainjfont{MS Mincho}
    \setsansjfont{MS Gothic}
  }{%
    %% Linux/macOSの場合: IPAexフォント
    \IfFontExistsTF{IPAexMincho}{%
      \setmainjfont{IPAexMincho}
      \setsansjfont{IPAexGothic}
    }{}%
  }
  %% 欧文フォント: Times系
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
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

%% ============================================================
%% セクション見出し
%% ============================================================
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection・\arabic{subsection}}

\makeatletter
\renewcommand{\section}{%
  \@startsection{section}{1}{\z@}%
  {1.5ex plus .5ex minus .2ex}%
  {0.5ex plus .2ex}%
  {\normalfont\normalsize\bfseries}}

\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
  {1ex plus .3ex minus .1ex}%
  {0.3ex plus .1ex}%
  {\normalfont\normalsize}}

% セクション番号フォーマット（LuaLaTeX互換）
\renewcommand{\@seccntformat}[1]{%
  \csname @seccntformat@#1\endcsname
}
\newcommand{\@seccntformat@section}{\thesection．}
\newcommand{\@seccntformat@subsection}{\textless\thesubsection\textgreater\hspace{0.5em}}
\makeatother

%% ============================================================
%% キャプション設定
%% ============================================================
\RequirePackage[labelsep=period,font=small]{caption}

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
    {\Large\bfseries \@jtitle\par}%
    \vskip 1.5ex%
    {\normalsize \@jauthor\par}%
    \vskip 1.5ex%
    {\normalsize \@etitle\par}%
    \vskip 0.5ex%
    {\normalsize \@eauthor\par}%
    \vskip 2.5ex%
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
  \begin{center}%
    \textbf{文　献}%
  \end{center}%
  \vskip -4.0ex%
  \noindent\hrulefill\par%
  \vskip -20.0ex%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
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
