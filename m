Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F11E504;
	Mon, 12 Aug 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474987; cv=none; b=PZKoZ7u0GDrY8fJK83YA784XQhBDKvZ6YfYxKFAWUEQyPn2YMX4ZhqEzJUoQYLEMjM/M8QnWCt8vRZSxjYQxc1YQnsA8sQr9+NPdsxBQ2sdWojwzlm/n75EIiFe0Oo3DD2fdz4ApWLTiHKfFNxae7ttRpt7exymI0yaKzwMt8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474987; c=relaxed/simple;
	bh=Yz6vzlKsg5IFj7gvXAZtzKGs6/KLRUCKPFOZS12iaJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGdC6necSNOcQUHRaO1kM4nhbuGZ85S/iCBetnqgQUNkPabwEit8tkSqdzkvgGZKL+v4dBy0w25NdqY0n5P2Rmw9fVwI82KcaFGwu4O+o8y45KJRWh89EgI8ac7BGVmjNoAojfLE3WDK5HlJPmZayHfjnWUh63pvvqiTpWQxGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BEkaR623; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BEkaR623"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1yhxhgCYYOrwxsZ9RN1iHvPLJeTvcqO7DlVfRzQWTsw=; b=BEkaR623v2rziDJGx6ZQEKKpcw
	6DHbyjk75aeOToNg7g50KeTGLjwLISxXBBCx4Tkxtz9iTDA/riYYrbghBQn+OW3C8cajLFQTa9JBi
	rkfXBoUWOlaO7SG58iulnLSRUtNpONK+A/rBxhzg9JYvGoMNnKFreUVRY5dndPA1YrWX+LtrG9uog
	RG8NdLKVjhocOnR52qngGLvgwJ6umNTYlPgdajSc3URdsgO7AQYCcnopQk3o1HXmaC6Zldp/NM0/E
	iWeQH/O0v+4VnGiO93026j/mX+7BrzR7knvyxCRpQqZogGXauMDNhluRTh5Jkeu1Cy2gUFoev3jyb
	RJczd7IQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sdWYp-00046l-0y;
	Mon, 12 Aug 2024 16:02:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sdWYn-0000YY-RA; Mon, 12 Aug 2024 16:02:13 +0100
Date: Mon, 12 Aug 2024 16:02:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, will@kernel.org, arnd@arndb.de,
	afd@ti.com, linus.walleij@linaro.org, akpm@linux-foundation.org,
	masahiroy@kernel.org, eric.devolder@oracle.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] ARM: stacktrace: Add USER_STACKTRACE support
Message-ID: <Zroj9aRA/fr33M9I@shell.armlinux.org.uk>
References: <20240730021532.1752582-1-ruanjinjie@huawei.com>
 <ZqzHgFB2t+SWy5o9@shell.armlinux.org.uk>
 <d7b9116e-bddc-2ab2-06eb-6191612fe16b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b9116e-bddc-2ab2-06eb-6191612fe16b@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 12, 2024 at 02:45:40PM +0800, Jinjie Ruan wrote:
> 
> 
> On 2024/8/2 19:48, Russell King (Oracle) wrote:
> > On Tue, Jul 30, 2024 at 10:15:32AM +0800, Jinjie Ruan wrote:
> >> Currently, userstacktrace is unsupported for ARM. So use the
> >> perf_callchain_user() code as blueprint to implement the
> >> arch_stack_walk_user() which add userstacktrace support on ARM.
> >> Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
> >> of perf_callchain_user().
> >>
> >> A ftrace test case is shown as below:
> >> 	# cd /sys/kernel/debug/tracing
> >> 	# echo 1 > options/userstacktrace
> >> 	# echo 1 > options/sym-userobj
> >> 	# echo 1 > events/sched/sched_process_fork/enable
> >> 	# cat trace
> >>
> >> 	......
> >> 	              sh-100     [000] .....    51.779261: sched_process_fork: comm=sh pid=100 child_comm=sh child_pid=108
> >> 	              sh-100     [000] .....    51.779285: <user stack trace>
> >> 	 => /lib/libc.so.6[+0xb3c8c]
> >> 	 => /bin/busybox[+0xffb901f1]
> >>
> >> Also a simple perf test is ok as below:
> >> 	# perf record -e cpu-clock --call-graph fp top
> >> 	# perf report --call-graph
> >>
> >> 	.....
> >> 	  [[31m  65.00%[[m     0.00%  top      [kernel.kallsyms]  [k] __ret_fast_syscall
> >>
> >> 	            |
> >> 	            ---__ret_fast_syscall
> >> 	               |
> >> 	               |--[[31m30.00%[[m--__se_sys_getdents64
> >> 	               |          iterate_dir
> >> 	               |          |
> >> 	               |          |--[[31m25.00%[[m--proc_pid_readdir
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > 
> > Do you have a use case for this feature?
> 
> To my knowledge, user stack trace is used in both uprobes and ftrace.
> 
> > 
> > Given that userspace is free to do whatever it likes with stack frames,
> > I think this is going to be hit and miss whether it works.
> 
> To be honest, I referred to the implementation of ARM64. Does anyone
> have suggestions for improvements or modifications?

So you're lifting code from Arm64 and dropping it into Arm32 in the hope
that it's suitable.

Here's a couple of examples - I've just used objdump on Debian Stable's
/bin/cat which contains functions where the prologue and epilogue are:

    1a2c:       b508            push    {r3, lr}
    ...
    1a56:       bd08            pop     {r3, pc}

    1de4:       b570            push    {r4, r5, r6, lr}
    ...
    1dea:       b084            sub     sp, #16
    ...
    1e18:       b004            add     sp, #16
    1e1a:       bd70            pop     {r4, r5, r6, pc}

These kinds of stack frames can not be unwound by the kernel - there
is no frame pointer there, and the only way it can be unwound is with
unwind information specific to the code objects concerned.

If I look at Arm64, then:

    26b0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
    26b4:       910003fd        mov     x29, sp
...
    26f0:       a8c27bfd        ldp     x29, x30, [sp], #32
    26f4:       d65f03c0        ret

So, x29 appears to be frame pointer like, creating a linked list of
stack frames. If this is part of the Arm64 ABI, then yes, the kernel
can use the guarantee that user programs will have this stack structure
and thus can walk the stack.

However, as has been shown, this is not true of 32-bit Arm - there is
no guarantee that userspace has any regular structure to its stack
frames, and thus there is no guarantee that the stack frames can be
walked by the kernel.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
