From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf report: Fix arm64 gap between kernel start and
 module end
Date: Mon, 30 Mar 2020 10:11:29 -0300
Message-ID: <20200330131129.GB31702@kernel.org>
References: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kemeng Shi <shikemeng@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ndesaulniers@google.com, irogers@google.com, tmricht@linux.ibm.com, hushiyuan@huawei.com, hewenliang4@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 30, 2020 at 03:41:11PM +0800, Kemeng Shi escreveu:
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 393b9895c..37cbfa5e9 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -2,6 +2,7 @@ libperf-y += header.o
>  libperf-y += tsc.o
>  libperf-y += sym-handling.o
>  libperf-y += kvm-stat.o
> +libperf-y += machine.o

You made the patch against an old perf codebase, right? This libperf-y
above was changed to perf-y here:

commit 5ff328836dfde0cef9f28c8b8791a90a36d7a183
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Feb 13 13:32:39 2019 +0100

    perf tools: Rename build libperf to perf

----

I'm fixing this up, please check my perf/core branch later to see that
all is working as intended.

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

Thanks,

- Arnaldo
