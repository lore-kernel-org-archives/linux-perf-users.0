From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/urgent fixes for 5.2
Date: Tue, 28 May 2019 23:17:56 +0200
Message-ID: <20190528211756.GA46600@gmail.com>
References: <20190528175020.13343-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Shawn Landden <shawn@git.icu>, Thomas Richter <tmricht@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, that is a trimmed down set from
> yesterday's pull req, with just fixes.
> 
> 	The other stuff, mostly acting on the warnings for the UAPI
> changes are being packaged into a perf/core pull request I'll send for
> 5.3.
> 
> 	I had it mostly done earlier, but then I noticed the fix for
> the syscall numbers, and backtracked to avoid sending yet another pull
> req, got too late in the -rc game, so 5.3 they go.
> 
> 	I'm not reposting them, the only change was adding an Acked-by
> for one of the UAPI syncs, the drm.h one.
> 
>         I did all the tests again, find them below, after the new signed
> tag.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 5bdd9ad875b6edf213f54ec3986ed9e8640c5cf9:
> 
>   Merge tag 'kbuild-fixes-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2019-05-20 17:22:17 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.2-20190528
> 
> for you to fetch changes up to a7350998a25ac10cdca5b33dee1d343a74debbfe:
> 
>   tools headers UAPI: Sync kvm.h headers with the kernel sources (2019-05-28 09:52:23 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> BPF:
> 
>   Jiri Olsa:
> 
>   - Fixup determination of end of kernel map, to avoid having BPF programs,
>     that are after the kernel headers and just before module texts mixed up in
>     the kernel map.
> 
> tools UAPI header copies:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Update copy of files related to new fspick, fsmount, fsconfig, fsopen,
>     move_mount and open_tree syscalls.
> 
>   - Sync cpufeatures.h, sched.h, fs.h, drm.h, i915_drm.h and kvm.h headers.
> 
> Namespaces:
> 
>   Namhyung Kim:
> 
>   - Add missing byte swap ops for namespace events when processing records from
>     perf.data files that could have been recorded in a arch with a different
>     endianness.
> 
>   - Fix access to the thread namespaces list by using the namespaces_lock.
> 
> perf data:
> 
>   Shawn Landden:
> 
>   - Fix 'strncat may truncate' build failure with recent gcc.
> 
> s/390
> 
>   Thomas Richter:
> 
>   - Fix s390 missing module symbol and warning for non-root users in 'perf record'.
> 
> arm64:
> 
>   Vitaly Chikunov:
> 
>   - Fix mksyscalltbl when system kernel headers are ahead of the kernel.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (8):
>       tools include UAPI: Update copy of files related to new fspick, fsmount, fsconfig, fsopen, move_mount and open_tree syscalls
>       tools arch x86: Sync asm/cpufeatures.h with the with the kernel
>       tools headers UAPI: Sync linux/sched.h with the kernel
>       tools headers UAPI: Sync linux/fs.h with the kernel
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel
>       tools headers UAPI: Sync drm/drm.h with the kernel
>       perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
>       tools headers UAPI: Sync kvm.h headers with the kernel sources
> 
> Jiri Olsa (1):
>       perf machine: Read also the end of the kernel
> 
> Namhyung Kim (2):
>       perf namespace: Protect reading thread's namespace
>       perf session: Add missing swap ops for namespace events
> 
> Shawn Landden (1):
>       perf data: Fix 'strncat may truncate' build failure with recent gcc
> 
> Thomas Richter (1):
>       perf record: Fix s390 missing module symbol and warning for non-root users
> 
> Vitaly Chikunov (1):
>       perf arm64: Fix mksyscalltbl when system kernel headers are ahead of the kernel
> 
>  tools/arch/arm64/include/uapi/asm/kvm.h           |  43 ++++
>  tools/arch/powerpc/include/uapi/asm/kvm.h         |  46 ++++
>  tools/arch/s390/include/uapi/asm/kvm.h            |   4 +-
>  tools/arch/x86/include/asm/cpufeatures.h          |   3 +
>  tools/include/uapi/asm-generic/unistd.h           |  14 +-
>  tools/include/uapi/drm/drm.h                      |  37 ++++
>  tools/include/uapi/drm/i915_drm.h                 | 254 +++++++++++++++-------
>  tools/include/uapi/linux/fcntl.h                  |   2 +
>  tools/include/uapi/linux/fs.h                     |   3 +
>  tools/include/uapi/linux/kvm.h                    |  15 +-
>  tools/include/uapi/linux/mount.h                  |  62 ++++++
>  tools/include/uapi/linux/sched.h                  |   1 +
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |   2 +-
>  tools/perf/arch/s390/util/machine.c               |   9 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   6 +
>  tools/perf/tests/vmlinux-kallsyms.c               |   9 +-
>  tools/perf/util/data-convert-bt.c                 |   2 +-
>  tools/perf/util/machine.c                         |  27 ++-
>  tools/perf/util/session.c                         |  21 ++
>  tools/perf/util/thread.c                          |  15 +-
>  20 files changed, 481 insertions(+), 94 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
