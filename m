From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Mon, 29 Jul 2019 23:24:51 +0200
Message-ID: <20190729212451.GA44602@gmail.com>
References: <20190729211456.6380-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, Numfor Mbiziwo-Tiapo <nums@google.com>, Vince Weaver <vincent.weaver@maine.edu>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 289a2d22b5b611d85030795802a710e9f520df29:
> 
>   perf/x86/intel: Mark expected switch fall-throughs (2019-07-25 15:57:03 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.3-20190729
> 
> for you to fetch changes up to 8aa259b10a6a759c50137bbbf225df0c17ca5d27:
> 
>   libbpf: fix missing __WORDSIZE definition (2019-07-29 10:18:08 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf header:
> 
>   Vince Weaver:
> 
>   - Fix divide by zero error if f_header.attr_size==0, found using a perf tool fuzzer.
> 
>   Numfor Mbiziwo-Tiapo:
> 
>   - Silence use of uninitialized value warning pointed out by clang's MSAN tool.
> 
> libbpf:
> 
>   Andrii Nakryiko:
> 
>   - Fix missing __WORDSIZE definition in some systems, such as musl libc (Alpine Linux).
> 
> tools header UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync headers to address perf build warnings:
> 
>     - syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open.
> 
>     - With new ioctls: kvm.h, drm.h and usbdevice_fs.h.
> 
>     - No tooling change: mman.h, sched.h and if_link.h.
> 
> Documentation:
> 
>   Vince Weaver:
> 
>   - Fix perf.data documentation units for memory size, its kB, not bytes.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andrii Nakryiko (1):
>       libbpf: fix missing __WORDSIZE definition
> 
> Arnaldo Carvalho de Melo (8):
>       tools include UAPI: Sync x86's syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open
>       tools headers UAPI: Update tools's copy of kvm.h headers
>       tools headers UAPI: Update tools's copy of mman.h headers
>       tools headers UAPI: Update tools's copy of drm.h headers
>       tools perf beauty: Fix usbdevfs_ioctl table generator to handle _IOC()
>       tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new ioctl
>       tools headers UAPI: Sync sched.h with the kernel
>       tools headers UAPI: Sync if_link.h with the kernel
> 
> Numfor Mbiziwo-Tiapo (1):
>       perf header: Fix use of unitialized value warning
> 
> Vince Weaver (2):
>       perf header: Fix divide by zero error if f_header.attr_size==0
>       perf tools: Fix perf.data documentation units for memory size
> 
>  tools/arch/arm/include/uapi/asm/kvm.h              |  12 ++
>  tools/arch/arm64/include/uapi/asm/kvm.h            |  10 +
>  tools/arch/powerpc/include/uapi/asm/mman.h         |   4 -
>  tools/arch/sparc/include/uapi/asm/mman.h           |   4 -
>  tools/arch/x86/include/uapi/asm/kvm.h              |  22 ++-
>  tools/arch/x86/include/uapi/asm/vmx.h              |   1 -
>  tools/include/uapi/asm-generic/mman-common.h       |  15 +-
>  tools/include/uapi/asm-generic/mman.h              |  10 +-
>  tools/include/uapi/asm-generic/unistd.h            |   8 +-
>  tools/include/uapi/drm/drm.h                       |   1 +
>  tools/include/uapi/drm/i915_drm.h                  | 209 ++++++++++++++++++++-
>  tools/include/uapi/linux/if_link.h                 |   5 +
>  tools/include/uapi/linux/kvm.h                     |   3 +
>  tools/include/uapi/linux/sched.h                   |  30 ++-
>  tools/include/uapi/linux/usbdevice_fs.h            |  26 +++
>  tools/lib/bpf/hashmap.h                            |   5 +
>  tools/perf/Documentation/perf.data-file-format.txt |   2 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   2 +
>  tools/perf/trace/beauty/usbdevfs_ioctl.sh          |   9 +-
>  tools/perf/util/header.c                           |   9 +-
>  20 files changed, 352 insertions(+), 35 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
