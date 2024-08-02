Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25D1DC47C;
	Fri,  2 Aug 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599335; cv=none; b=a57bbbjxHjnIO+Af7/b5EAde5Iqki2OXl+WFJDa0XlRgj6ceUhhFwBlK7iJV5fnAzuyQCWz2+Pe98wWe5EqmVNgdvNnrWsfuJNn0HvFacwqx0BXbNwegNDUsZj8EGdl9Cy7iqq6sL6iop13Khu6pD545Wc9EyitfKgEsfUAawII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599335; c=relaxed/simple;
	bh=r0PBu7i1fBNUm4nsFB95n5iEiMDj0DMIApKvigJxyI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtVdPBnbJqITDUNhph7RRONtsN0Y5mHWrsjKoID3zsBlHGTkCdGBDZUYYjUTq7g7vHzZWK0DQq0ws3651tRA2yb25k2p6RBqTEuSlT3lixG+clDCApbxyN/lmuu3F9ViMRqAUGesnspQeq3PWGwyzUa4nh15Mo/oKfbwZuH35zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aItMhQlV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aItMhQlV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C0f6zaBUcyynt6mE21QnYBPj0vbkgaV+m6pHO44i/nk=; b=aItMhQlVxwVTBIVvetxVf2Nb6t
	LEFmNrkyUb605nYSbbJLQXSU5oLvAfvUPXlSTiS/Q3nU52ruCvrVvb9ZZ8ULeIl80cjp1zG3JIsV+
	tTa5USLcUB4wi1feuwCHaUl34riumZoi1ZBVMV4PzpZv9ouh2C1P87iBXVS7gS2z74NfqsGP0Tqo4
	M105kYItz+KzrcJaKYKRS/bcP9ueIJO2bCEEkCCUwzGSSEb2wlLuDvLYu3nRx0bnLWMF7r3TGy5Cg
	sFNpwMuB3qbAfktXt04AchzVftu7vBoybY7RVOJ+/LlcASt8Tbrnf8T45yY/6SuBCCT3R2NcM0Nld
	VD8wc5zg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41882)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZqla-0006dk-2M;
	Fri, 02 Aug 2024 12:48:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZqlc-00080u-9P; Fri, 02 Aug 2024 12:48:16 +0100
Date: Fri, 2 Aug 2024 12:48:16 +0100
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
Message-ID: <ZqzHgFB2t+SWy5o9@shell.armlinux.org.uk>
References: <20240730021532.1752582-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730021532.1752582-1-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 10:15:32AM +0800, Jinjie Ruan wrote:
> Currently, userstacktrace is unsupported for ARM. So use the
> perf_callchain_user() code as blueprint to implement the
> arch_stack_walk_user() which add userstacktrace support on ARM.
> Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
> of perf_callchain_user().
> 
> A ftrace test case is shown as below:
> 	# cd /sys/kernel/debug/tracing
> 	# echo 1 > options/userstacktrace
> 	# echo 1 > options/sym-userobj
> 	# echo 1 > events/sched/sched_process_fork/enable
> 	# cat trace
> 
> 	......
> 	              sh-100     [000] .....    51.779261: sched_process_fork: comm=sh pid=100 child_comm=sh child_pid=108
> 	              sh-100     [000] .....    51.779285: <user stack trace>
> 	 => /lib/libc.so.6[+0xb3c8c]
> 	 => /bin/busybox[+0xffb901f1]
> 
> Also a simple perf test is ok as below:
> 	# perf record -e cpu-clock --call-graph fp top
> 	# perf report --call-graph
> 
> 	.....
> 	  [[31m  65.00%[[m     0.00%  top      [kernel.kallsyms]  [k] __ret_fast_syscall
> 
> 	            |
> 	            ---__ret_fast_syscall
> 	               |
> 	               |--[[31m30.00%[[m--__se_sys_getdents64
> 	               |          iterate_dir
> 	               |          |
> 	               |          |--[[31m25.00%[[m--proc_pid_readdir
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Do you have a use case for this feature?

Given that userspace is free to do whatever it likes with stack frames,
I think this is going to be hit and miss whether it works.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
