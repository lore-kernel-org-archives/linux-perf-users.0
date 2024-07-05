Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F11BC43;
	Fri,  5 Jul 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191521; cv=none; b=MydgZ4CGg9FXJDc8C/wlpUp8AuItQ6aLCjtplxRYMfVbTgzei5HAuhkTMs0dxdm5qwGoDzFu0Z4DKxOvVatob+e2Q46icZa81xReIckVoTR9HvKhfXT5dnXhgryz8fc93VFVGEyoP44r4r83OJuC5fguSsJcKiuDm+nSRc1nYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191521; c=relaxed/simple;
	bh=h3yJr3S9q2N4HJlpYsqp8UFLwMFIi/t9QTQZkXg6oE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G63o0np2zzYPSp5Wp3aIZ9O01NU8SB5oIvGcFJVB4Da5JgDn+573gp2tgcUqVrXMvNO5Kbc2AKu55coEy4G48CmR8APOalU0tViMPZfi1CEybVSxebz+oB0mSlh87dZ/8bepXvePc4ljfgfTaRhcy2pLYaVf6lwg1RN7xIygGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TkQnEOJZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkQnEOJZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3C+rq8ia3XS8ACgGJMQdn5KVaU+65tg0RXOnpowkTYs=; b=TkQnEOJZDQ2v3hBd2+fpT+pQPZ
	22VY898I2h4hKc/HYPzYiI4Rs2Ol9oggDFmkgzyqML8Aa6P0vDPwUxgRlS3VgDdQQYO1VNCEESv7M
	VBt2ewnGJ7fvpZu8Wi+iX2TQTteyDyqhH9TniFAR6P/SPklfH6tlJGsag/U+9D2EU3AzlAVgN3i8g
	Z9pOYt0EvGGZ33b5/VfrZGoDtW5WT9EXLr3l5qmqLA8Gl2FtDsZ4593DwGBJaVN9VxxU6gU76d9ku
	hTHVslxr+1MVZimKKw9A/qsJmhYazHA5TPyqWGFpG0ybm8FPbySWTrrm7jPGmM2SqqirpTobH11iJ
	z9CV007Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPkOP-000000044fW-3Tx9;
	Fri, 05 Jul 2024 14:58:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 138D03005AF; Fri,  5 Jul 2024 16:58:29 +0200 (CEST)
Date: Fri, 5 Jul 2024 16:58:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/7] task_work: Add TWA_NMI_CURRENT as an additional
 notify mode.
Message-ID: <20240705145828.GD11386@noisy.programming.kicks-ass.net>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
 <20240704170424.1466941-3-bigeasy@linutronix.de>
 <20240705140020.J2dyu3fZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705140020.J2dyu3fZ@linutronix.de>

On Fri, Jul 05, 2024 at 04:00:20PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-07-04 19:03:36 [+0200], To linux-perf-users@vger.kernel.org wrote:
> > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > index 2134ac8057a94..05fb41fe09f5d 100644
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -1,10 +1,19 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <linux/irq_work.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/task_work.h>
> >  #include <linux/resume_user_mode.h>
> > +#include <trace/events/ipi.h>
> 
> Just noticed that this trace include does not belong here. It is a
> leftover from an earlier iteration where I intended to use
> smp_send_reschedule() instead of irq_work…
> 
> Should I repost the series, or just this one?

I'll zap it. no worries.
