From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Fri, 29 Nov 2019 06:58:58 +0100
Message-ID: <20191129055858.GA14825@gmail.com>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrii Nakryiko <andriin@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, this has a merge with mainline to pick
> bpf stuff, and the build-test and container build tests were performed
> with two extra patches I cooked to fix libbpf issuers in some odd 32-bit
> arches and on generation of some bpf helpers headers that will hit
> mainline via the bpf/net trees.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 2ea352d5960ad469f5712cf3e293db97beac4e01:
> 
>   Merge remote-tracking branch 'torvalds/master' into perf/core (2019-11-26 11:06:19 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191128
> 
> for you to fetch changes up to 5172672da02e483d9b3c4d814c3482d0c8ffb1a6:
> 
>   perf script: Fix invalid LBR/binary mismatch error (2019-11-28 08:08:38 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf script:
> 
>   Adrian Hunter:
> 
>   - Fix brstackinsn for AUXTRACE.
> 
>   - Fix invalid LBR/binary mismatch error.
> 
> perf diff:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use llabs() with 64-bit values, fixing the build in some 32-bit
>     architectures.
> 
> perf pmu:
> 
>   Andi Kleen:
> 
>   - Use file system cache to optimize sysfs access.
> 
> x86:
> 
>   Adrian Hunter:
> 
>   - Add some more Intel instructions to the opcode map and to the perf
>     test entry:
> 
>       gf2p8affineinvqb, gf2p8affineqb, gf2p8mulb, v4fmaddps,
>       v4fmaddss, v4fnmaddps, v4fnmaddss, vaesdec, vaesdeclast, vaesenc,
>       vaesenclast, vcvtne2ps2bf16, vcvtneps2bf16, vdpbf16ps,
>       vgf2p8affineinvqb, vgf2p8affineqb, vgf2p8mulb, vp2intersectd,
>       vp2intersectq, vp4dpwssd, vp4dpwssds, vpclmulqdq, vpcompressb,
>       vpcompressw, vpdpbusd, vpdpbusds, vpdpwssd, vpdpwssds, vpexpandb,
>       vpexpandw, vpopcntb, vpopcntd, vpopcntq, vpopcntw, vpshldd, vpshldq,
>       vpshldvd, vpshldvq, vpshldvw, vpshldw, vpshrdd, vpshrdq, vpshrdvd,
>       vpshrdvq, vpshrdvw, vpshrdw, vpshufbitqmb.
> 
> perf affinity:
> 
>   Andi Kleen:
> 
>   - Add infrastructure to save/restore affinity
> 
> perf maps:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Merge 'struct maps' with 'struct map_groups', as there is a
>     1x1 relationship, simplifying code overal.
> 
> perf build:
> 
>   Jiri Olsa:
> 
>   - Allow to link with libbpf dynamicaly.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

>  66 files changed, 2230 insertions(+), 618 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
