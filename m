From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5] perf tools: add support for libpfm4
Date: Tue, 24 Mar 2020 11:26:48 +0100
Message-ID: <20200324102648.GP1534489@krava>
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

> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 7ac0d8088565..573072d32545 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -67,7 +67,9 @@ FILES=                                          \
>           test-llvm.bin				\
>           test-llvm-version.bin			\
>           test-libaio.bin			\
> -         test-libzstd.bin
> +         test-libzstd.bin			\
> +         test-libpfm4.bin
> +
>  
>  FILES := $(addprefix $(OUTPUT),$(FILES))
>  
> @@ -321,6 +323,9 @@ $(OUTPUT)test-libaio.bin:
>  $(OUTPUT)test-libzstd.bin:
>  	$(BUILD) -lzstd
>  
> +$(OUTPUT)test-libpfm4.bin:
> +	$(BUILD) -lpfm

also please move the libpfm4 detection into separated patch

thanks,
jirka
