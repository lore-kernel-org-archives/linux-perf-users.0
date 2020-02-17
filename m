From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v4] perf test: Fix test trace+probe_vfs_getname.sh on s390
Date: Mon, 17 Feb 2020 11:29:35 -0300
Message-ID: <20200217142935.GA19953@kernel.org>
References: <20200217102111.61137-1-tmricht@linux.ibm.com>
 <20200217211010.fa9c643c517c110abaa5b554@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200217211010.fa9c643c517c110abaa5b554@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Feb 17, 2020 at 09:10:10PM +0900, Masami Hiramatsu escreveu:
> On Mon, 17 Feb 2020 11:21:11 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> > This test places a kprobe to function getname_flags() in the kernel
> > which has the following prototype:
> > 
> >   struct filename *
> >   getname_flags(const char __user *filename, int flags, int *empty)
> > 
> > Variable filename points to a filename located in user space memory.
> > Looking at
> > commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> > the kprobe should indicate that user space memory is accessed.
> > 
> > Output before:
> >    [root@m35lp76 perf]# ./perf test  66 67
> >    66: Use vfs_getname probe to get syscall args filenames   : FAILED!
> >    67: Check open filename arg using perf trace + vfs_getname: FAILED!
> >    [root@m35lp76 perf]#
> > 
> > Output after:
> >    [root@m35lp76 perf]# ./perf test  66 67
> >    66: Use vfs_getname probe to get syscall args filenames   : Ok
> >    67: Check open filename arg using perf trace + vfs_getname: Ok
> >    [root@m35lp76 perf]#
> > 
> > Comments from Masami Hiramatsu:
> > This bug doesn't happen on x86 or other archs on which user-address
> > space and kernel address space is same. On some arch (ppc64 in this case?)
> > user-address space is partially or completely same as kernel address space.
> > (Yes, they switch the world when running into the kernel) In this case,
> > we need to use different data access functions for each spaces.
> > That is why I introduced "ustring" type for kprobe event.
> > As far as I can see, Thomas's patch is sane. Thomas, could you show us
> > your result on your test environment?
> > Thank you
> > 
> > Comments from Thomas Richter:
> > Test results included above.
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, I tested it successfully on x86-64, applying.

- Arnaldo
