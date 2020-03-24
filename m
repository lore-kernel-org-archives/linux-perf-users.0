From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5] perf tools: add support for libpfm4
Date: Tue, 24 Mar 2020 11:26:20 +0100
Message-ID: <20200324102620.GO1534489@krava>
References: <20200323235846.104937-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200323235846.104937-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 23, 2020 at 04:58:46PM -0700, Ian Rogers wrote:

SNIP

>  INTERACTIVE PROMPTING KEYS
>  --------------------------
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 80e55e796be9..571aa6b1af40 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -999,6 +999,18 @@ ifdef LIBCLANGLLVM
>    endif
>  endif
>  
> +ifndef NO_LIBPFM4
> +  ifeq ($(feature-libpfm4), 1)
> +    CFLAGS += -DHAVE_LIBPFM
> +    EXTLIBS += -lpfm
> +    ASCIIDOC_EXTRA = -aHAVE_LIBPFM=1
> +    $(call detected,CONFIG_LIBPFM4)

you don't use CONFIG_LIBPFM4

but I was wondering if we should put it all in separate
object like util/pfm.c to get rid of some of those ifdefs

jirka
