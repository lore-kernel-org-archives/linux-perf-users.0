From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Date: Fri, 14 Feb 2020 02:01:51 +0900
Message-ID: <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
        <20200213143048.GA22170@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200213143048.GA22170@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Thomas and Arnaldo,

On Thu, 13 Feb 2020 11:30:48 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
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
> > The following patch specifies user space memory access first and if this
> > fails use type 'string' in case 'ustring' is not supported.
> 
> What are you fixing?
> 
> I haven't seen any example of this test failing, and right now testing
> it with:
> 
> [root@quaco ~]# uname -a
> Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]#

This bug doesn't happen on x86 or other archs on which user-address space and
kernel address space is same. On some arch (ppc64 in this case?) user-address
space is partially or completely same as kernel address space. (Yes, they switch
the world when running into the kernel) In this case, we need to use different
data access functions for each spaces. That is why I introduced "ustring" type
for kprobe event.
As far as I can see, Thomas's patch is sane. Thomas, could you show us your
result on your test environment?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
