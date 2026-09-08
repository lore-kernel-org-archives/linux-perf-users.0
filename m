Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2733A7193;
	Tue,  8 Sep 2026 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854425; cv=none; b=hKcduYdC8XSze8PKkGsmBqsLIggMEauPVwT3i6UyQOKzdyzuykqNYewJP4YMc3bwyWf2p2um+M63hb9Yw6+4rOgFpcxBwQvlW1BPWJ1B1D8UiLupWYczBNdBhIJKGRIGvCV0/7TEfUFwqtZnHyc72WEGsXsTNaThKK9XTuofo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854425; c=relaxed/simple;
	bh=S/Lz+xHDUUf0g02gnrz++amUF5ofMaisuGHvWYpOAkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFiVEVdb/xhSQ8KVEpComzU+r9ZVHO7tJsC71kjAQYoW6uJSddykOhJf75luI0nuv4EzLrZ416zZdZWhqqR0Ykn1ew3/FHBabzwRo6rTCLumRjZoGp41mZF89a8gVx8k8EzuVyUdpsegoJUE3EnV313QgzmOIkirrO0X8g0QnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k2pFIpeN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k2pFIpeN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uxn7PT+EAVFsbAjdQ2z3LbyFBgdM3inwgwbxduT95vI=; b=k2pFIpeNykpDXUpgGP6rmLNoV1
	v/gsW08BVVUZfDPnDaCOYq/EPmKDFUni7x5/8twmANTmNfp5sQYO6M5iMkWl7C/Yj8eByFi0NSjP5
	+pKn3gZs8uXX5sMu1Rwbj/XeNHpvtcP2iheVMIB9c8X8dDZWr122N2kazWTQ16RAvx+Ca1sHX+TFH
	ZtTLGhonByGtkYC2q3cf/86RHDlQDw9Ts/EgBNsL7k3mrWZZKvQpqmnPtBKewzJQHfSco39iq1brj
	m7SiZUcp6mag/2vpZ39mmJo8N3iPN8A5fDIP7p9oxcTGE7fua+tmzCqrAI/TrTSDeYeaqTt9EuUlm
	zRqHERBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51328)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1x3qkT-00000000835-1isj;
	Tue, 08 Sep 2026 09:00:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1x3qkO-000000003sU-2C7X;
	Tue, 08 Sep 2026 09:00:04 +0100
Date: Tue, 8 Sep 2026 09:00:04 +0100
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
Message-ID: <ap_AhKXlAWecV3BI@shell.armlinux.org.uk>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
 <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
 <20260908075455.OffmMhrB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908075455.OffmMhrB@linutronix.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Tue, Sep 08, 2026 at 09:54:55AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-07 15:46:09 [+0100], Russell King wrote:
> > On Fri, Sep 04, 2026 at 05:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-09-03 13:31:46 [-0400], Steven Rostedt wrote:
> > > > On Thu, 3 Sep 2026 17:47:24 +0100
> > > > Russell King <linux@armlinux.org.uk> wrote:
> > > > 
> > > > > What do you expect to happen with this? Which arch maintainer should
> > > > > apply this patch that affects three different independently maintained
> > > > > architectures?
> > > 
> > > Well, if you as the ARM person are fine with ARM part, an ACK would be
> > > appreciated. If you have something to object, it would be nice to let me
> > > know so I can adjust accordingly.
> > 
> > First, I only just looked at the email - you may have noticed I'm not
> > very active with the kernel anymore, as I'm a full-time carer at the
> > moment.
> > 
> > Second, I'm not fine with the patch as-is, because it's not clear how
> > it could be merged in its current form. It would be inappropriate to
> > give an Ack, because an Ack means I'm fine with it. I'm not.
> > 
> > Third, I haven't actually reviewed the patch itself (see first point).
> > 
> > Looking deeper now, I see nothing in the linked report, nor in your
> > write-up that identifies what is responsible for the context being
> > inappropriate to deliver the SIGTRAP. See the first point - I'm not
> 
> The linked report shows a backtrace by "BUG: sleeping function"
> originating from el0_breakpt() -> perf_bp_event() following by sending a
> signal force_sig_fault() followed by rt_spin_lock() and
> __might_resched(). It also contains a reproducer.
> 
> The first sentence has the part
> | The hardware event is
> | delivered with disabled interrupts and perf intrastrucure expects
> | disabled interrupts while the overflow callback is invoked.

*Where* are interrupts disabled?

> 
> This is what happens, followed by 
> 
> | The callback then sends a SIGTRAP signal for which it acquires
> | sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> | must not be acquired in atomic context.
> 
> This is not really specific to PREEMPT_RT as we enforce to not allow
> raw_spinlock_t -> spinlock_t on !PREEMPT_RT via lockdep, too.
> 
> > able to read lots of code to work that out, and presumably you've
> > already done that ground work to come up with a fix. This is *vital*
> > information when someone looks back at why this change was made as
> > it helps to understand how the problem occurs. This is, after all,
> > the whole point of commit messages - to help people look back and
> > understand why a change was made. The "what the changes are" part
> > is already covered by the patch showing what the changes were. It's
> > the stuff that *isn't* in the patch that needs to be in the commit
> > message.
> > 
> > So... don't describe the code changes in a commit message.
> 
> I think both parts (describing the issue and the change) are part of the
> commit message.
> 
> > So no, an Ack is not appropriate.
> 
> Sebastian
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
