From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4] perf test: Fix test trace+probe_vfs_getname.sh on
 s390
Date: Mon, 17 Feb 2020 21:10:10 +0900
Message-ID: <20200217211010.fa9c643c517c110abaa5b554@kernel.org>
References: <20200217102111.61137-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200217102111.61137-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, 17 Feb 2020 11:21:11 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> This test places a kprobe to function getname_flags() in the kernel
> which has the following prototype:
> 
>   struct filename *
>   getname_flags(const char __user *filename, int flags, int *empty)
> 
> Variable filename points to a filename located in user space memory.
> Looking at
> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> the kprobe should indicate that user space memory is accessed.
> 
> Output before:
>    [root@m35lp76 perf]# ./perf test  66 67
>    66: Use vfs_getname probe to get syscall args filenames   : FAILED!
>    67: Check open filename arg using perf trace + vfs_getname: FAILED!
>    [root@m35lp76 perf]#
> 
> Output after:
>    [root@m35lp76 perf]# ./perf test  66 67
>    66: Use vfs_getname probe to get syscall args filenames   : Ok
>    67: Check open filename arg using perf trace + vfs_getname: Ok
>    [root@m35lp76 perf]#
> 
> Comments from Masami Hiramatsu:
> This bug doesn't happen on x86 or other archs on which user-address
> space and kernel address space is same. On some arch (ppc64 in this case?)
> user-address space is partially or completely same as kernel address space.
> (Yes, they switch the world when running into the kernel) In this case,
> we need to use different data access functions for each spaces.
> That is why I introduced "ustring" type for kprobe event.
> As far as I can see, Thomas's patch is sane. Thomas, could you show us
> your result on your test environment?
> Thank you
> 
> Comments from Thomas Richter:
> Test results included above.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 7cb99b433888..c2cc42daf924 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -14,7 +14,7 @@ add_probe_vfs_getname() {
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
>  		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> -		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
>  	fi
>  }
>  
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
