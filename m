Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E2A3D3498;
	Tue,  8 Sep 2026 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857036; cv=none; b=fg4Cnw0MhOAtB6WLrSJeXFaM6AIkLNVKnsyCu7NPlfKWeM7on+dPSJuirOXIKaKIbb0ySodEg+pNoTisvoLEO6d8jeauGX17PqXbJefdrZxBr7y6Hv7Qasg7asut9Lb4dCmZHiPcFNkIBS5gFFti/zN7tFQ7AZi9PYELns+fZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857036; c=relaxed/simple;
	bh=V3Y/tN8cv5zoIHeTOZMh11Bj4L3iOIFDlw1Nbeem3sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL4RuVjv3QrOdhrtRR426VbMOMfPpwBfMHiN0mX+Prn+aw61af3CXC3k6y/RgiMUaxGALh0XNXIUIGTj0rn6217L9z2svjjDclsy6eqrSqqNhLd23JIKdBmBsoOVztNa2D7DC9jz3RK3bvUOvWBkIQzDyWcZRW+hjVKtoLOIHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hR9qHFr3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hR9qHFr3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J92dX1oYM7IY0/1ZeLhTll1RV7mRC8e5gkuzB135nxY=; b=hR9qHFr3OSXErFC5iBesCBBeSk
	bTfXHJaXG/zjBu1aLbz1evnNftw8yA7hRKdqggMvA9ZqlZoXdEPHmHAo+5C/EWPRODdAQ7xf3zekn
	3i8AavI9NcH4Yfm6Bofi9lQG83RA6sloUe8nosSdGjIy2+2iVjirSgtmNScjUYe2x6Fm82XX8QYA+
	HPutxONOfbTqouxx47VlSWVkG12y3XeRseH60frlsUB6wqf+8kOAOO7WnpCgK14XjECBH0xJ54hbm
	QtjKh2IJeqt66MA3r6nbnc1hpr0AQj5ExsusZbNoeX+A9P2kMjdRj/OnUL8LAjfgxh1tHSLjfsQtV
	EKKJLG0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1x3rQh-0000000088V-3esd;
	Tue, 08 Sep 2026 09:43:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1x3rQd-000000003ul-3w0J;
	Tue, 08 Sep 2026 09:43:43 +0100
Date: Tue, 8 Sep 2026 09:43:43 +0100
From: Russell King <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
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
Message-ID: <ap_Kv73A8exPhK-j@shell.armlinux.org.uk>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
 <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
 <20260908075455.OffmMhrB@linutronix.de>
 <ap_AhKXlAWecV3BI@shell.armlinux.org.uk>
 <20260908083740.0qERUBOE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908083740.0qERUBOE@linutronix.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Tue, Sep 08, 2026 at 10:37:40AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-08 09:00:04 [+0100], Russell King wrote:
> > On Tue, Sep 08, 2026 at 09:54:55AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-09-07 15:46:09 [+0100], Russell King wrote:
> > > > On Fri, Sep 04, 2026 at 05:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > On 2026-09-03 13:31:46 [-0400], Steven Rostedt wrote:
> > > > > > On Thu, 3 Sep 2026 17:47:24 +0100
> > > > > > Russell King <linux@armlinux.org.uk> wrote:
> > > > > > 
> > > > > > > What do you expect to happen with this? Which arch maintainer should
> > > > > > > apply this patch that affects three different independently maintained
> > > > > > > architectures?
> > > > > 
> > > > > Well, if you as the ARM person are fine with ARM part, an ACK would be
> > > > > appreciated. If you have something to object, it would be nice to let me
> > > > > know so I can adjust accordingly.
> > > > 
> > > > First, I only just looked at the email - you may have noticed I'm not
> > > > very active with the kernel anymore, as I'm a full-time carer at the
> > > > moment.
> > > > 
> > > > Second, I'm not fine with the patch as-is, because it's not clear how
> > > > it could be merged in its current form. It would be inappropriate to
> > > > give an Ack, because an Ack means I'm fine with it. I'm not.
> > > > 
> > > > Third, I haven't actually reviewed the patch itself (see first point).
> > > > 
> > > > Looking deeper now, I see nothing in the linked report, nor in your
> > > > write-up that identifies what is responsible for the context being
> > > > inappropriate to deliver the SIGTRAP. See the first point - I'm not
> > > 
> > > The linked report shows a backtrace by "BUG: sleeping function"
> > > originating from el0_breakpt() -> perf_bp_event() following by sending a
> > > signal force_sig_fault() followed by rt_spin_lock() and
> > > __might_resched(). It also contains a reproducer.
> > > 
> > > The first sentence has the part
> > > | The hardware event is
> > > | delivered with disabled interrupts and perf intrastrucure expects
> > > | disabled interrupts while the overflow callback is invoked.
> > 
> > *Where* are interrupts disabled?
> 
> On exception entry point, that would el0t_64_sync() for arm64 as in the
> report.

Oh FFS. So why does this need to be done on ARM? Explain it. This is
what I'm trying to get out of you, but you're being very resistant
to providing the technical details. I can only think you haven't
actually done the analysis.

So, NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
