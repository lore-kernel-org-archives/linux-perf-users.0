From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/27] perf/core improvements and fixes
Date: Wed, 25 Jul 2018 22:34:16 +0200
Message-ID: <20180725203416.GA3142@gmail.com>
References: <20180725180001.15108-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@fb.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Daniel Borkmann <daniel@iogearbox.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, kernel-team@lge.com, Kim Phillips <kim.phillips@arm.com>, Leo Yan <leo.yan@linaro.org>, linux-arm-kernel@lists.in
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, I'm now investigating why these failed:
> 
>   38: LLVM search and compile                               :
>   38.1: Basic BPF llvm compile                              : Ok
>   38.2: kbuild searching                                    : Ok
>   38.3: Compile source for BPF prologue generation          : Ok
>   38.4: Compile source for BPF relocation                   : FAILED!
>   40: BPF filter                                            :
>   40.1: Basic BPF filtering                                 : Ok
>   40.2: BPF pinning                                         : Ok
>   40.3: BPF prologue generation                             : Ok
>   40.4: BPF relocation checker                              : FAILED!
> 
> 	I think these failures are not related to changes in this patch
> kit. Details about the test environment, versions, etc.

Ok!

> The following changes since commit 1d59d16e9b4d5be80c9786a8b129c0f2af0e9522:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-07-24 14:34:32 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180725

>  52 files changed, 1456 insertions(+), 109 deletions(-)

Pulled, thanks a lot Arnaldo!

Could we please also fix these before v4.18 is released, which trigger in 
perf/urgent:

Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

?

Thanks!

	Ingo
