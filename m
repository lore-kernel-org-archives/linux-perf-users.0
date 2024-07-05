Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7C1474A5;
	Fri,  5 Jul 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175389; cv=none; b=gNQSLnC4TjY/GGOm1KSQ4WQEUnm313o+/cn2/qPM+7dd4STjuX4XMTiovlp0yTUgNzwcgw4Jt/iFbiOMN3CgfRuJGX5hLJhojNP7tDZuxDz7Fvk3KsJy7Ya1CNgj08prXZp1FBKzWfsX7GyrutlZ9RGdxhafj7EOgBsxyF/IkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175389; c=relaxed/simple;
	bh=KXj1jdMbrK15a0oyvR8SPf4kifJGSiZozWgQ0Zb2r+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDegUNkYKgxrN5iFyIj8sxkJWphFjorzVpfdeAxKuB78qsS1kbzqqd5WTv+7/uyp2AW6QmejkKVdhdcjwm7/CfDOa/AD17l6jGdJ7VT3vUEo2/zsNCfx6uC1udAJ0RI/8Nje1OxR/9UP3RQShU8ft5DUlcr2IDiB8F+Gaez4tOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lr0DE2Jq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lr0DE2Jq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C0jbnV0W2mx7Vi5EwRNJVaHLABpWM8AEwOaP2sOv3DA=; b=Lr0DE2Jq67LPKkM8mklvhlvB6T
	l8PlbaAmV2wBg5o9+ce267a50sAjy0aYUo8xeQCDviOvTng7uubSI+kdM82sizgNDk8mVtQamtEAj
	79OLBrT2uXlqILCQvtq+U0wyzvCw61t9v/9dWANtuBDpxkUTszNJt2HpK/6WzmQhzGOOMwpOMVIiW
	pZOilgBY47UWGPmAEFzo1qJka/AnJwBfpLipDIAc3zgGTgHjSgJhtnKTb7T0x9Ngx/aIOjgIzdDSy
	RegPMYtFHKgPwu2s2QzpWkishLtVDYezT2b4X178BQKwhgZyPcYLKNGGgjkCht5XG6i5yVP6tDNcA
	z7kTiWLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sPgBn-0008Bb-39;
	Fri, 05 Jul 2024 11:29:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sPgBn-0004oz-As; Fri, 05 Jul 2024 11:29:15 +0100
Date: Fri, 5 Jul 2024 11:29:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hw_breakpoint: Save privilege of access control
 via ptrace
Message-ID: <ZofK+7Q8+TCdKe+a@shell.armlinux.org.uk>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
 <5ab53836-5a11-a47b-042e-96c5c9e70974@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab53836-5a11-a47b-042e-96c5c9e70974@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 04, 2024 at 10:47:59PM +0800, Tiezhu Yang wrote:
> On 6/21/24 15:39, Tiezhu Yang wrote:
> > Hi all,
> > 
> > Thank you very much for your feedbacks in the v1 patch.
> > This series is based on 6.10-rc4, cross compile tested only.
> > 
> > As far as I can tell, these changes are not relevant with tools/perf,
> > on some archs such as ARM, ARM64 and LoongArch which have privilege
> > level of breakpoint, the initial aim is to make use of the value of
> > ctrl->privilege saved in decode_ctrl_reg() and then remove the check
> > whether bp virtual address is in kernel space to assign value for
> > hw->ctrl.privilege in arch_build_bp_info().
> > 
> > v2:
> >    -- Put the new member "bp_priv" at the end of the uapi
> >       struct perf_event_attr and add PERF_ATTR_SIZE_VER9.
> >    -- Update the commit message to make the goal clear.
> > 
> > Tiezhu Yang (3):
> >    perf: Add perf_event_attr::bp_priv
> >    arm: hw_breakpoint: Save privilege of access control via ptrace
> >    arm64: hw_breakpoint: Save privilege of access control via ptrace
> > 
> >   arch/arm/kernel/hw_breakpoint.c   |  4 +---
> >   arch/arm/kernel/ptrace.c          |  2 ++
> >   arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
> >   arch/arm64/kernel/ptrace.c        |  2 ++
> >   include/uapi/linux/perf_event.h   |  3 +++
> >   kernel/events/hw_breakpoint.c     |  1 +
> >   6 files changed, 11 insertions(+), 12 deletions(-)
> 
> Ping, any more comments? Is it possible to merge this series
> for the coming merge window?

Maybe someone who knows the perf stuff can review it and give an
opinion?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
