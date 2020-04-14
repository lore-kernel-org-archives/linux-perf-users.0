From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 2/4] tools feature: add support for detecting libpfm4
Date: Tue, 14 Apr 2020 17:21:16 +0200
Message-ID: <20200414152116.GD208694@krava>
References: <20200411074631.9486-1-irogers@google.com>
 <20200411074631.9486-3-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200411074631.9486-3-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Sat, Apr 11, 2020 at 12:46:29AM -0700, Ian Rogers wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> libpfm4 provides an alternate command line encoding of perf events.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/Makefile.feature       | 6 ++++--
>  tools/build/feature/Makefile       | 6 +++++-
>  tools/build/feature/test-libpfm4.c | 9 +++++++++
>  3 files changed, 18 insertions(+), 3 deletions(-)
>  create mode 100644 tools/build/feature/test-libpfm4.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 3e0c019ef297..0b651171476f 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -73,7 +73,8 @@ FEATURE_TESTS_BASIC :=                  \
>          libaio				\
>          libzstd				\
>          disassembler-four-args		\
> -        file-handle
> +        file-handle			\
> +        libpfm4

let's treat this the same way as libbpf and do not include
it in the basic check, which will fail for omst users

jirka
