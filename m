Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707045;
	b=XaJuS6VUjWM0rtuXZXKTtv/mUIr3FKpAhPw0IMt2Z8cBxTs6HNINLNmGtVvCVZqpkFmJ
	 QGv0xdPFOWrW1lW1j2wuF/Wi4te1SuzIj1tDUrNHU7CjTM+BjNwEPCpiByNCf8JGGjcRV
	 asQFrT9qQZZbhMgjqb3lL6Npc5xWCfIjecvGb6FoLdFobh6QY/33soQjdHUdhljSdeP0O
	 vU5Hhmzo63OqSnKcozPJ7VWRMjNmHEOakIOnRHarvgyymY5yaHZtXi10eGS0CHs1XIPEF
	 pwfABWl8eoU3uaWkC8F4yGjdC1bYbQ3jl9Vdx9lqpYXOCef7NSLrTktMfScuCVzEVHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707045;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=w1KWZdIYXri7x+WAfZ+wzjIo79CyjgSJE/6p11j2cKk=;
	b=SMiNwrMLb65oZro0ZnePB4SC/x0cgKi20B6cUDUkxGrEG5qBCNvcfnvMmE6wrJi+tQSz
	 djaxyh2Y4x8ciiXv8e5VcXz+oOyX+xRCc39yKsFcFSz87xMDsH079v3JMgBh0Fd0TENAv
	 m1a1hUQ23TbUFQGQxsm4ZevR8brZvYTM9XAZbsuryKdNYVZBbk9JRgt1/zvXpa7jbGTsZ
	 iDwPL842YUO+NCEGKyv5V3PNbhz2IlpiolwDECETD7QgmAd8apCemlwc2j0P1Baxg5jUv
	 Niz+4sls4OuFpiEYhwoUPgOs9QC0dc6hIfj88kodM6lDjsygtMeJLDlICEfGc3VWaiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pGW95Suf;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF6606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 15:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pGW95Suf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w1KWZdIYXri7x+WAfZ+wzjIo79CyjgSJE/6p11j2cKk=; b=pGW95Sufdqyu5+FVwjuwHMGXvl
	6L5rvY3xt4iyDYa+TG4MymcCXfSXSVvwwHPXfeZP0edOPZIrfXp0LJXir2gELElTredgGpcw/7wbl
	MICWnDjxlCsEFQ3G0tYzh5/RIawsAkdWCBOap+P3analNBP+Y12wuDfF+y+CIrMvHqOOwrzULMgdr
	tJOfK+0r4QCgYPwi9fFpnwiHmnLIW5ulWfkACrEyAxeCAFvvYTwX8FiW7SfHO3rzgr13qEG3S2DAt
	kyC3hA4Z7BHccI2YpaSBgXLfSEmeiC6WlxkKCTY2gRUe6pgL61TsEf3qsPxWC9SQTPbCc8RcUFpQE
	Sj1j6QAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbQo-00000006PHc-2tB6;
	Thu, 26 Nov 2026 15:30:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3BBC303082; Thu, 26 Nov 2026 16:30:41 +0100 (CET)
Date: Thu, 26 Nov 2026 16:30:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dominik Maier <dmnk@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Marco Elver <elver@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	dmnk+artist@google.com
Subject: Re: [PATCH] perf/hw_breakpoint: fix ctx->mutex vs perf_event_mutex
 inversion on attr modify
Message-ID: <20261126153041.GI49833@noisy.programming.kicks-ass.net>
References: <20261119192228.2661266-1-dmnk@google.com>
 <20261120115601.GQ2668564@noisy.programming.kicks-ass.net>
 <20261124181148.144716-1-dmnk@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124181148.144716-1-dmnk@google.com>

On Tue, Nov 24, 2026 at 06:11:48PM +0000, Dominik Maier wrote:
> Hi Peter,
> 
> Thanks for checking. I'll switch the second Fixes tag to 82aad7ff7ac2.
> 
> For the lock: since perf_event_modify_attr() walks child_list inside
> ctx->mutex, hoisting each target task's perf_event_mutex out doesn't
> look workable. Would you prefer a dedicated mutex on task_struct under
> CONFIG_HAVE_HW_BREAKPOINT, or a larger cacheline-aligned hash table?

I'm not sure; you're at google and should have access to both very
large machines and the workload Marco and co have created this stuff
for.

Did you run your patch on that workload?
