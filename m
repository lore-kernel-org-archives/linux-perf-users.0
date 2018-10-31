From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/24] perf/urgent improvements and fixes
Date: Wed, 31 Oct 2018 22:56:01 +0100
Message-ID: <20181031215601.GA3843@gmail.com>
References: <20181031164508.4784-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Peterson <benjamin@python.org>, coresight@lists.linaro.org, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Don Zickus <dzickus@redhat.com>, Eric Leblond <eric@regit.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Jin Yao <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, next ones should be concentrating just
> on bug fixes, been busy with some, so some were left in the queue,
> flushing them now.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 28fa741c27e6d57f6bf594ba3c444ce79e671e09:
> 
>   perf/core: Clean up inconsisent indentation (2018-10-30 09:51:58 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.20-20181031
> 
> for you to fetch changes up to 5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5:
> 
>   perf intel-pt/bts: Calculate cpumode for synthesized samples (2018-10-31 12:56:26 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent improvements and fixes:
> 
> - Fixes dealing with the removal of the fallback to looking up samples
>   marked as userspace in the kernel maps, done recently:
> 
>   - For intel-pt, that was setting the synthesized header misc field
>     as PERF_RECORD_MISC_USER, depending thus on the fallback to take
>     place, now it sets as USER or KERNEL according to x86 specific
>     knowledge. Also now it inserts the PERF_CONTEXT_{USER,KERNEL} into
>     the PERF_SAMPLE_CALLCHAINs it synthesizes from hw traces (Adrian Hunter)
> 
>   - Similar fixes for the cs-etm ARM HW trace code, that used the Intel PT
>     model as a starting point (Leo Yan)
> 
>   - For the "caller" callchain order, where the callchain returned by the
>     kernel was simply reversed without taking into account the
>     PERF_CONTEXT_{USER,KERNEL,etc} markers from where to define if an entry
>     was for kernel or userspace, working just because the map lookup fallback
>     was in place (David S. Miller)
> 
> - Allow for selecting if 'overwrite' mode should be used in 'perf top' and
>   make the default for it not to be used. This is due to problems with the
>   current implementation where the pausing used ends up making 'perf top'
>   miss PERF_RECORD_{MMAP,FORK,EXEC,etc} events, which with short lifetime
>   threads workloads leads quickly to many "unknown" maps (and thus symbols)
>   to appear in the UI. Workloads with long thread lifetimes and with few
>   metadata events can still use --overwrite to take advantage of the
>   overwrite mode (Arnaldo Carvalho de Melo)
> 
> - Start 'perf top''s display thread earlier, so that the screen doesn't
>   remain blank for too long at tool start (David S. Miller)
> 
> - Don't clone maps from parent when synthesizing forks, to avoid the inevitable
>   flurry of overlapping maps as we process the synthesized MMAP2 events that get
>   delivered shortly thereafter. (David S. Miller)
> 
> - Take pgoff into account when reporting elf to libdwfl, now the unwinding
>   results are the same with elfutils's libdwfl and libunwind (Milian Wolff)
> 
> - Update lotsa kernel ABI headers (Arnaldo Carvalho de Melo)
> 
> - 'perf trace' syscall arg beautification improvements to allow for
>   handling args such as mount's 'flags', where maks have to be ignored
>   before considering what is left, that, if only zeroes, is suppressed
>   like other args without such masks (Arnaldo Carvalho de Melo)
> 
> - Beautify mount's 'source' and 'flags' args (Arnaldo Carvalho de Melo)
> 
> - Generate mmap's flags bit constants from linux/mman.h and all the
>   arch specific mman.h files, so that no changes in the main 'perf trace'
>   source files is required when new flags get added (Arnaldo Carvalho de Melo)
> 
> - Consider syscall aliases, so that 'perf trace -e umount' works and we don't
>   have to use 'umount2' (that works as well, just not required) (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf intel-pt: Insert callchain context into synthesized callchains
>       perf intel-pt/bts: Calculate cpumode for synthesized samples
> 
> Arnaldo Carvalho de Melo (21):
>       tools include uapi: Grab a copy of linux/fs.h
>       perf beauty: Add a generator for MS_ mount/umount's flag constants
>       perf beauty: Switch from GPL v2.0 to LGPL v2.1
>       perf beauty: Introduce strarray__scnprintf_flags()
>       perf trace beauty: Allow syscalls to mask an argument before considering it
>       perf trace beauty: Beautify mount/umount's 'flags' argument
>       perf trace: Consider syscall aliases too
>       perf trace: Beautify the umount's 'name' argument
>       perf trace: Beautify mount's first pathname arg
>       perf top: Allow disabling the overwrite mode
>       perf top: Do not use overwrite mode by default
>       tools include uapi: Update linux/fs.h copy
>       tools arch uapi: Update asm-generic/unistd.h and arm64 unistd.h copies
>       tools include uapi: Update asound.h copy
>       perf beauty: Add a generator for MAP_ mmap's flag constants
>       perf beauty: Wire up the mmap flags table generator to the Makefile
>       perf trace beauty: Use the mmap flags table generated from headers
>       tools include uapi: Update linux/mmap.h copy
>       tools headers: Sync the various kvm.h header copies
>       tools headers uapi: Update linux/netlink.h header copy
>       tools headers uapi: Update linux/if_link.h header copy
> 
> David Miller (2):
>       perf top: Start display thread earlier
>       perf tools: Don't clone maps from parent when synthesizing forks
> 
> David S. Miller (1):
>       perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}
> 
> Leo Yan (1):
>       perf cs-etm: Correct CPU mode for samples
> 
> Milian Wolff (1):
>       perf unwind: Take pgoff into account when reporting elf to libdwfl
> 
>  include/uapi/linux/perf_event.h                    |   2 +
>  tools/arch/arm64/include/uapi/asm/unistd.h         |   1 +
>  tools/arch/powerpc/include/uapi/asm/kvm.h          |   1 +
>  tools/arch/s390/include/uapi/asm/kvm.h             |   2 +
>  tools/arch/x86/include/uapi/asm/kvm.h              |   6 +-
>  tools/include/uapi/asm-generic/unistd.h            |   2 +
>  tools/include/uapi/linux/fs.h                      | 393 +++++++++++++++++++++
>  tools/include/uapi/linux/if_link.h                 |   1 +
>  tools/include/uapi/linux/kvm.h                     |  21 +-
>  tools/include/uapi/linux/mman.h                    |   2 +
>  tools/include/uapi/linux/netlink.h                 |   1 +
>  tools/include/uapi/linux/perf_event.h              |   2 +
>  tools/include/uapi/sound/asound.h                  |   2 +-
>  tools/perf/Documentation/perf-top.txt              |  10 +
>  tools/perf/Makefile.perf                           |  19 +
>  tools/perf/builtin-top.c                           |  21 +-
>  tools/perf/builtin-trace.c                         |  48 ++-
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/trace/beauty/Build                      |   1 +
>  tools/perf/trace/beauty/beauty.h                   |   7 +
>  tools/perf/trace/beauty/clone.c                    |   3 +-
>  tools/perf/trace/beauty/drm_ioctl.sh               |   1 +
>  tools/perf/trace/beauty/eventfd.c                  |   2 +-
>  tools/perf/trace/beauty/fcntl.c                    |   3 +-
>  tools/perf/trace/beauty/flock.c                    |   2 +-
>  tools/perf/trace/beauty/futex_op.c                 |   2 +-
>  tools/perf/trace/beauty/futex_val3.c               |   2 +-
>  tools/perf/trace/beauty/ioctl.c                    |   3 +-
>  tools/perf/trace/beauty/kcmp.c                     |   3 +-
>  tools/perf/trace/beauty/kcmp_type.sh               |   1 +
>  tools/perf/trace/beauty/kvm_ioctl.sh               |   1 +
>  tools/perf/trace/beauty/madvise_behavior.sh        |   1 +
>  tools/perf/trace/beauty/mmap.c                     |  50 +--
>  tools/perf/trace/beauty/mmap_flags.sh              |  32 ++
>  tools/perf/trace/beauty/mode_t.c                   |   2 +-
>  tools/perf/trace/beauty/mount_flags.c              |  43 +++
>  tools/perf/trace/beauty/mount_flags.sh             |  15 +
>  tools/perf/trace/beauty/msg_flags.c                |   2 +-
>  tools/perf/trace/beauty/open_flags.c               |   2 +-
>  tools/perf/trace/beauty/perf_event_open.c          |   2 +-
>  tools/perf/trace/beauty/perf_ioctl.sh              |   1 +
>  tools/perf/trace/beauty/pid.c                      |   3 +-
>  tools/perf/trace/beauty/pkey_alloc.c               |  30 +-
>  .../perf/trace/beauty/pkey_alloc_access_rights.sh  |   1 +
>  tools/perf/trace/beauty/prctl.c                    |   3 +-
>  tools/perf/trace/beauty/prctl_option.sh            |   1 +
>  tools/perf/trace/beauty/sched_policy.c             |   2 +-
>  tools/perf/trace/beauty/seccomp.c                  |   2 +-
>  tools/perf/trace/beauty/signum.c                   |   2 +-
>  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |   1 +
>  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |   1 +
>  tools/perf/trace/beauty/sockaddr.c                 |   2 +-
>  tools/perf/trace/beauty/socket.c                   |   2 +-
>  tools/perf/trace/beauty/socket_ipproto.sh          |   1 +
>  tools/perf/trace/beauty/socket_type.c              |   2 +-
>  tools/perf/trace/beauty/statx.c                    |   3 +-
>  tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |   1 +
>  tools/perf/trace/beauty/waitid_options.c           |   2 +-
>  tools/perf/util/cs-etm.c                           |  39 +-
>  tools/perf/util/event.c                            |   1 +
>  tools/perf/util/intel-bts.c                        |  17 +-
>  tools/perf/util/intel-pt.c                         |  28 +-
>  tools/perf/util/machine.c                          |  54 ++-
>  tools/perf/util/thread-stack.c                     |  44 ++-
>  tools/perf/util/thread-stack.h                     |   2 +-
>  tools/perf/util/thread.c                           |  13 +-
>  tools/perf/util/thread.h                           |   2 +-
>  tools/perf/util/unwind-libdw.c                     |   4 +-
>  68 files changed, 837 insertions(+), 142 deletions(-)
>  create mode 100644 tools/include/uapi/linux/fs.h
>  create mode 100755 tools/perf/trace/beauty/mmap_flags.sh
>  create mode 100644 tools/perf/trace/beauty/mount_flags.c
>  create mode 100755 tools/perf/trace/beauty/mount_flags.sh

Pulled, thanks a lot Arnaldo!

	Ingo
