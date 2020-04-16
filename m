From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v9 4/4] perf tools: add support for libpfm4
Date: Thu, 16 Apr 2020 11:50:50 +0200
Message-ID: <20200416095050.GB369437@krava>
References: <20200416063551.47637-1-irogers@google.com>
 <20200416063551.47637-5-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416063551.47637-5-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 15, 2020 at 11:35:51PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 12a8204d63c6..26167ad38a47 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1012,6 +1012,18 @@ ifdef LIBCLANGLLVM
>    endif
>  endif
>  
> +ifndef NO_LIBPFM4
> +  ifeq ($(feature-libpfm4), 1)
> +    CFLAGS += -DHAVE_LIBPFM
> +    EXTLIBS += -lpfm
> +    ASCIIDOC_EXTRA = -aHAVE_LIBPFM=1
> +    $(call detected,CONFIG_LIBPFM4)
> +  else
> +    msg := $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev);
> +    NO_LIBPFM4 := 1
> +  endif
> +endif

now when it's in FEATURE_TESTS_EXTRA it will not get detected,
unless you add the change below.. I wonder how come it was
still being detected for you.. might be bug in feature detection
stuff

jirka


---
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 26167ad38a47..b45c5d370b42 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1013,6 +1013,7 @@ ifdef LIBCLANGLLVM
 endif
 
 ifndef NO_LIBPFM4
+  $(call feature_check,libpfm4)
   ifeq ($(feature-libpfm4), 1)
     CFLAGS += -DHAVE_LIBPFM
     EXTLIBS += -lpfm
