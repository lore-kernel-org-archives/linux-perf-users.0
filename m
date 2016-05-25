From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: perf trace & vfs_getname
Date: Wed, 25 May 2016 14:00:22 -0400
Message-ID: <y0m1t4qqaq1.fsf@fche.csb>
References: <3503612.0WeV8glAT3@agathebauer>
	<20160524222107.GA8857@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52733 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755003AbcEYSAV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 May 2016 14:00:21 -0400
In-Reply-To: <20160524222107.GA8857@kernel.org> (Arnaldo Carvalho de Melo's message of "Tue, 24 May 2016 19:21:07 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org


acme wrote:

> [...]
>> I just wanted to try out your ongoing work to get file names printed in perf 
>> trace:
>> 
>> $ perf trace -e open ls builtin-trace.c
>>      0.007 ( 0.007 ms): ls/26364 open(filename: 0x2a1b0d20, flags: CLOEXEC
>> ) = -1 ENOENT No such file or directorybuiltin-trace.c
>> [...]

> For 'perf trace' to be a superset of strace it needs to pretty print
> syscall args other than integers, and for that we need things like the
> vfs_getname, or to go and look at several places where those syscalls
> are copied to the kernel (move_addr_to_kernel, gename_flags), and back
> (move_addr_to_user), etc.

In systemtap's case, we copy from userspace & pretty-print right from
the event where we detect the system call, not via a secondary
tracepoint like vfs_getname that would need to have its values
saved/coordinated.


> [...]  Arch? I never tried it, would have to google for instructions
> on how to use, say, systemtap [...]

FYI, Arch is (in)famous for dropping debuginfo completely.  Systemtap
can work out-of-the-box based on symbol table info only, but many
users end up recompiling their kernel with CONFIG_DEBUG_INFO=1 to get
the full capabilities.

Just as demo, this may work for you (including file names):

# stap -e '
probe nd_syscall.* { printf("%s/%d %s(%s) ", execname(), tid(), name, argstr) }
probe nd_syscall.*.return { printf("-> %s\n", retstr) }
'

... which is the core of what

     /usr/share/doc/systemtap*/examples/*/strace.stp

does, sans process-filtering and other goodies.


- FChE
