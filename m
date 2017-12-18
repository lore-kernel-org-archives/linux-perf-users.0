From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/5] perf/urgent fixes
Date: Mon, 18 Dec 2017 18:11:59 +0100
Message-ID: <20171218171159.j4zlcmutdtuf7iw3@gmail.com>
References: <20171218143912.6036-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218143912.6036-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Potapenko <glider@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ben Gainey <ben.gainey@arm.com>, Colin King <colin.king@canonical.com>, Daniel Borkmann <daniel@iogearbox.net>, Darren Hart <dvhart@infradead.org>, David Ahern <dsahern@gmail.com>, Dmitriy Vyukov <dvyukov@google.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kim Phillips <kim>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	This was ready already before my short vacations, and get things
> building on the recently released fedora 27 and make 'perf test' pass
> all entries, so please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 34c9ca37aaec2e307b837bb099d3b44f0ea04ddc:
> 
>   tooling/headers: Synchronize updated s390 and x86 UAPI headers (2017-12-06 22:45:24 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.15-20171218
> 
> for you to fetch changes up to 38ab834165924bf86fe7ee67bb5dbea56240b03f:
> 
>   x86/asm: Allow again using asm.h when building for the 'bpf' clang target (2017-12-15 12:30:16 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix up build in hardened environments, such as fedora 27 (Jiri Olsa)
> 
> - Do not include header files from the kernel sources for the s/390 arch,
>   fixing the detached tarball building (Arnaldo Carvalho de Melo)
> 
> - Allow again using asm.h when building for the 'bpf' clang target,
>   guarding x86 specific bits under ifndef __BPF__ (Arnaldo Carvalho de Melo)
> 
> - Generate correct debug information for inlined code when generating
>   ELF images for JITted java programs (Ben Gainey)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools arch s390: Do not include header files from the kernel sources
>       x86/asm: Allow again using asm.h when building for the 'bpf' clang target
> 
> Ben Gainey (1):
>       perf jvmti: Generate correct debug information for inlined code
> 
> Jiri Olsa (2):
>       perf tools: Use shell function for perl cflags retrieval
>       perf tools: Fix up build in hardened environments
> 
>  arch/x86/include/asm/asm.h                   |   2 +
>  tools/arch/s390/include/uapi/asm/perf_regs.h |  43 ++++++++
>  tools/perf/Makefile.config                   |   9 +-
>  tools/perf/arch/s390/include/perf_regs.h     |   2 +-
>  tools/perf/check-headers.sh                  |   1 +
>  tools/perf/jvmti/jvmti_agent.c               |  16 +--
>  tools/perf/jvmti/jvmti_agent.h               |   7 +-
>  tools/perf/jvmti/libjvmti.c                  | 147 ++++++++++++++++++++++-----
>  8 files changed, 185 insertions(+), 42 deletions(-)
>  create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h

Pulled, thanks a lot Arnaldo!

	Ingo
