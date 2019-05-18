From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tools/headers: Synchronize kernel ABI headers
Date: Sat, 18 May 2019 19:12:57 +0200
Message-ID: <20190518171257.GA50600@gmail.com>
References: <20190517193611.4974-1-acme@kernel.org>
 <20190518084223.GB85914@gmail.com>
 <20190518133923.GA7969@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190518133923.GA7969@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>, Donald Yandt <donald.yandt@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Guo Ren <ren_guo@c-sky.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Mao Han <han_mao@c-sky.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Stanislav Kozina <skozina@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Richter <tmricht@linux.ibm.com>, Tzvetomir
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Sat, May 18, 2019 at 10:42:23AM +0200, Ingo Molnar escreveu:
> > Pick up the latest v5.2-to-be kernel ABI headers and synchronize them with tooling:
> > 
> >  - arch/x86/entry/syscalls/syscall_64.tbl   => tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  # new syscalls
> >  - arch/x86/include/asm/cpufeatures.h       => tools/arch/x86/include/asm/cpufeatures.h           # new CPUID flags
> >  - include/uapi/drm/drm.h                   => tools/include/uapi/drm/drm.h                       # new 'syncobj' DRM ABI
> >  - include/uapi/drm/i915_drm.h              => tools/include/uapi/drm/i915_drm.h                  # new extensible DRM ABI
> >  - include/uapi/linux/fcntl.h               => tools/include/uapi/linux/fcntl.h                   # new AT_RECURSIVE
> >  - include/uapi/linux/fs.h                  => tools/include/uapi/linux/fs.h                      # new SYNC_FILE_RANGE_WRITE_AND_WAIT
> >  - include/uapi/linux/mount.h               => tools/include/uapi/linux/mount.h                   # new VFS system calls: fspick, fsmount, fsconfig, fsopen, move_mount, open_tree
> >  - include/uapi/linux/sched.h               => tools/include/uapi/linux/sched.h                   # new CLONE_PIDFD
> > 
> > All of these are new ABI additions with no impact on existing tooling,
> 
> There is some impact in a number of them, for instance:
> 
> [acme@quaco perf]$ diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
> --- tools/perf/arch/x86/entry/syscalls/syscall_64.tbl	2019-05-13 14:46:03.915894924 -0300
> +++ arch/x86/entry/syscalls/syscall_64.tbl	2019-05-18 10:27:04.273395657 -0300
> @@ -343,6 +343,12 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> +335	common	open_tree		__x64_sys_open_tree
> +336	common	move_mount		__x64_sys_move_mount
> +337	common	fsopen			__x64_sys_fsopen
> +338	common	fsconfig		__x64_sys_fsconfig
> +339	common	fsmount			__x64_sys_fsmount
> +340	common	fspick			__x64_sys_fspick
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
> [acme@quaco perf]$
> 
> These will enable 'perf trace' to know about these syscalls, i.e. we
> will be able to say:
> 
>     perf trace -e fs*
> 
> And have it trace just those fsopen, fsconfig, fsmount and fspick
> syscalls (or any other that starts with fs, that is). Looking at this
> makes one think if we should have a new syscall group like we have here:
> 
> [acme@quaco perf]$ ls -la tools/perf/trace/strace/groups/
> total 16
> drwxrwxr-x. 2 acme acme 4096 May 13 14:46 .
> drwxrwxr-x. 3 acme acme 4096 Apr 10 10:20 ..
> -rw-rw-r--. 1 acme acme  136 May 13 14:46 file
> -rw-rw-r--. 1 acme acme  584 May 13 14:46 string
> [acme@quaco perf]$ 
> 
> One for file oriented syscalls, the other for syscalls that operate on
> strings (pathnames, etc).

Good point, I missed that!

> So I'll check that tools/perf/trace/beauty/drm_ioctl.sh is sane wrt any
> new additions to that header, ditto for the other headers, I'll go thru
> them soon.

Thanks!

	Ingo
