Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FF4F30C0;
	Thu,  3 Sep 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454058; cv=none; b=eWDu/X6sxdMdM2zOU7m0YSz+uUqZ1BJXR0WVwLJM37cGd5zQ/J3u1j1EYSNxP5Ck8RcduLEbBWtE9R06xKd9kYcMathMqA53ufQcv2iMHmUI+H+blrbjQ7tk/JPbJ5ptCYlHmMBF2PKugyVikTocz9KheCqJ8GmwkOBY54fFnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454058; c=relaxed/simple;
	bh=3X4L33LAgSrzvQW+lHKTgGo36IrXujakkpx0ktUlGvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEltoon+7Px/acQGvpq7klUbGdrLEwMILtgnYeyLe1lIyjz1ZIsTw4cUTpAe85PtMXl2nAnJzd5pfRCrWJQIqByxz4fJak1K9W/8iTi/F6Co0/nKWbuZlQZ8Rhno3hipGb5Kj2JwIkkmPdQL0DOvk3G4Lb1vNTA2veUKNvmFK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I23Lcsn3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I23Lcsn3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PE4M5bZ8qa5ONlWyjoO6PT9YT/rm032gR13k1+hQA+s=; b=I23Lcsn3E+BTZqmu+d5CGfgHwK
	3qS6wiCrS19b//RLzh7QxvWrqznkylmRe1kmkX2xuzrC1DhZrPi+XVYTpkPfwh+4CAAfHo+/iPG1g
	X3wTaXN/QJ6sKW7EmH9x50yocWgsxMCxGEXX1+TQUR6JZZcSX6wGKgBaQFVQc3ZGNMOkOlRVU4bbC
	oef/ChSoq+1JtplljCZYXw/S8hk1QUnR9AHu8CzVdiMaLPu61MKtQgZt+4faKdoy0dO91k0lnwfrx
	eOOA+mxx+nnaHy7Lhg0GuOeZN9zcCmj+X+fZ09c3I5MPrQfLBT2df/qW+bDfqxrGafoaGcqBoOGhB
	m9uNY41g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43748)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1x2Ab3-0000000013P-2RN0;
	Thu, 03 Sep 2026 17:47:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1x2Aay-000000007Y3-2v7X;
	Thu, 03 Sep 2026 17:47:24 +0100
Date: Thu, 3 Sep 2026 17:47:24 +0100
From: Russell King <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Waiman Long <longman@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <apmknG55qFAn8EPf@shell.armlinux.org.uk>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903160710.vVf4gEL2@linutronix.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Thu, Sep 03, 2026 at 06:07:10PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-14 10:51:18 [+0200], To linux-arm-kernel@lists.infradead.org wrote:
> > Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> > "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> > delivered with disabled interrupts and perf intrastrucure expects
> > disabled interrupts while the overflow callback is invoked.
> > 
> > The callback then sends a SIGTRAP signal for which it acquires
> > sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> > must not be acquired in atomic context.
> > 
> > Delay the event callback until the return to userland.
> > Add perf_arch_hwbp_notify(), a generic perf callback which delayes the
> > actual callback invocation to task_work_add() callback. This callback
> > invokes the architecture defines callback arch_hwbp_send_sig().
> > This requires struct callback_head and the functions require
> > ARCH_NEED_PERF_HW_NOTIF to be defined.
> > 
> > This was reported against ARM64. ARM and LongARCH follow the same
> > pattern are also converted.
> > 
> > Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > Reported-by: Waiman Long <longman@redhat.com>
> > Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Did this get lost, should I repost it or is there something obviously
> wrong with it and nobody wanted to hurt my feelings by telling me?

What do you expect to happen with this? Which arch maintainer should
apply this patch that affects three different independently maintained
architectures?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
