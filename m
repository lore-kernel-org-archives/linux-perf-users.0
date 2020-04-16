From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v10 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
Date: Thu, 16 Apr 2020 13:23:09 -0300
Message-ID: <20200416162309.GH2650@kernel.org>
References: <20200416162058.201954-1-irogers@google.com>
 <20200416162058.201954-2-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416162058.201954-2-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhoujian <yuzhoujian>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 16, 2020 at 09:20:55AM -0700, Ian Rogers escreveu:
> This will allow parent makefiles to pass values to asciidoc.

Thanks, applied
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
> index 31824d5269cc..6e54979c2124 100644
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -48,7 +48,7 @@ man5dir=$(mandir)/man5
>  man7dir=$(mandir)/man7
>  
>  ASCIIDOC=asciidoc
> -ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
> +ASCIIDOC_EXTRA += --unsafe -f asciidoc.conf
>  ASCIIDOC_HTML = xhtml11
>  MANPAGE_XSL = manpage-normal.xsl
>  XMLTO_EXTRA =
> @@ -59,7 +59,7 @@ HTML_REF = origin/html
>  
>  ifdef USE_ASCIIDOCTOR
>  ASCIIDOC = asciidoctor
> -ASCIIDOC_EXTRA = -a compat-mode
> +ASCIIDOC_EXTRA += -a compat-mode
>  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
>  ASCIIDOC_EXTRA += -a mansource="perf" -a manmanual="perf Manual"
>  ASCIIDOC_HTML = xhtml5
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

-- 

- Arnaldo
