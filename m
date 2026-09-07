Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143147126A;
	Mon,  7 Sep 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792387; cv=none; b=T6149sOtVBhKbb7zeFcYo6cV8NRPFJDYcld4cMBZUHM1C5i2D4SsEwmzGQeBw8657kMg5B7t40lwTIwea2uEFbFM6Nqa+So7yiUiPjtCKf9qbnByE5oDdha3X0AQzxbMukdj/TUdOQ5h954mBA6Q4FywwQam4i6hIDizos83uEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792387; c=relaxed/simple;
	bh=vTHKStO3BBgVrvFZF0syCMXokXgcbuGvDZ+bkl9UpG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d01Ts8cpcXnrkd4aKG+JufSz+rDVjvrTRMnG8ua0cgbSC+yq5TTjqkLq3ZLQ2OeUfRoMs98wYdxWEm3Jg3RPvCyKWuz81JZgCXZCl1IF49ZmkSVA+5VJ1RwNqB/1oEAnjUX42ggOCWSpsRFfae8MDFH/osbZXxDwKQHMl8HSCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hbAkk2Q2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hbAkk2Q2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xme47uO+Jf63evL4/29gr84tP1Hv+GyQrOlJltHuyMs=; b=hbAkk2Q2EognyWHMNrcyAs+Cq8
	s6Ud1Oag8AO98MG66I82FLWOADGkZ4NXz0ST5xd/MLKm9xmWwKXM00XLEUfA06z+ASWZUPZmJtQ3A
	rgcYEEw3BFBf3kIG7EZshHKjRVpslOi8Zh3r3uzowvPNxGOV7X23iZZuOIhVS7kpYXygjp2wF1Vv+
	SjDWq390303ekV68zoztlcDP0iVwdL3csh0RjwXeA4eNX1CEBdxcdrRX5Xu+ZyARu9LGcamuE/57H
	SwHrtmdM3OuP2i6lQLxA4JdvV7W49+P3Cwatzz6aqpCJMN9/HEL5CIY2ODOwLQi1N43LsS7Ijlwk6
	GbDJKdRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34342)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1x3abv-000000006zQ-150O;
	Mon, 07 Sep 2026 15:46:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1x3abp-0000000035r-22YQ;
	Mon, 07 Sep 2026 15:46:09 +0100
Date: Mon, 7 Sep 2026 15:46:09 +0100
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
Message-ID: <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904155404.ESPFg3zi@linutronix.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Fri, Sep 04, 2026 at 05:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-03 13:31:46 [-0400], Steven Rostedt wrote:
> > On Thu, 3 Sep 2026 17:47:24 +0100
> > Russell King <linux@armlinux.org.uk> wrote:
> > 
> > > What do you expect to happen with this? Which arch maintainer should
> > > apply this patch that affects three different independently maintained
> > > architectures?
> 
> Well, if you as the ARM person are fine with ARM part, an ACK would be
> appreciated. If you have something to object, it would be nice to let me
> know so I can adjust accordingly.

First, I only just looked at the email - you may have noticed I'm not
very active with the kernel anymore, as I'm a full-time carer at the
moment.

Second, I'm not fine with the patch as-is, because it's not clear how
it could be merged in its current form. It would be inappropriate to
give an Ack, because an Ack means I'm fine with it. I'm not.

Third, I haven't actually reviewed the patch itself (see first point).

Looking deeper now, I see nothing in the linked report, nor in your
write-up that identifies what is responsible for the context being
inappropriate to deliver the SIGTRAP. See the first point - I'm not
able to read lots of code to work that out, and presumably you've
already done that ground work to come up with a fix. This is *vital*
information when someone looks back at why this change was made as
it helps to understand how the problem occurs. This is, after all,
the whole point of commit messages - to help people look back and
understand why a change was made. The "what the changes are" part
is already covered by the patch showing what the changes were. It's
the stuff that *isn't* in the patch that needs to be in the commit
message.

So... don't describe the code changes in a commit message.

So no, an Ack is not appropriate.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
