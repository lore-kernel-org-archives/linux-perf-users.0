Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AD55C29;
	Mon, 11 Nov 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326944; cv=none; b=su8vLMnSUtSaoygFJXJ0Cb6s7oKEGy3LUzt2pZNtPW6mdUeo+o7zZKeEzNiSs/ZAkBvAUpn/63AZqXVprUlDz1RG8IODO4Fa0MeTjf31ouxLYn4ja6uBXcJsZyXVEv9gGHB46ZtcZzlrloSDoBl4lHTyj7YSSGnzDY6dVAa7xsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326944; c=relaxed/simple;
	bh=DIW+TkZZltCh8IP3a/tVKlRlRPbJzpnZ2XEG15Z1scQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJyAQCwcMZbW0fmviB1FFpgcxwrEF9QjKEX13JZH6i+L1qzxVxJuoV+LY2kpnJ9NQCVuQsdbkTg64W+A+Lr6GSMVWMq30HdJa+BFypuatPzmDC+7fsLrwMENwBsEf8NkWp7/ScsZq8JKLRmm0cofxzMvGUUIb0XDLDpT/cHJbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRyBUeiD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zp8Py/Tm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRyBUeiD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zp8Py/Tm"
Date: Mon, 11 Nov 2024 13:08:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731326939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3pctUoeQeEvpMMz5ZcdubkrOFvovsPeScLjbuDtiBg=;
	b=QRyBUeiDvrOUOnA7E9x0julKW7aSepRPTIxTVI0mnvkGAR0qNd/rDkk8hCMgrH7e5nZvNP
	1RYx7KE5fE0veS5U8Z30z+GkPCZlD6U8EmB6r2IIXhYJS1Is0xN26TivyJ6LJrw/cFWf4Q
	QClugEX0BeNo29Zl7D55v1/1AjqCGwVVJURK/IhURzlmLNdWo0Bs7hcPBL+PNRfqZLR5hi
	SYUTJNevr2mj9nZ24BEXDRtXiNISUpl4FRVwlDfTzAA5PLYCEyhDbxzYWliVqonlW5foHT
	37kI/1dsihoe2hrrtNMTrcMBP2g0lqfEo2B41rF3i9eYvDQ2o3AKIg1+2i0FCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731326939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3pctUoeQeEvpMMz5ZcdubkrOFvovsPeScLjbuDtiBg=;
	b=Zp8Py/TmNxj6NnPmjLwu+NcM/Z5ohQx8TShaoX3UfLzf6DiEJgP5dus2s//5TkFEGn1JV3
	j+CPdnF9OceQ+JBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, "Lai, Yi" <yi1.lai@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20241111120857.5cWFpNkJ@linutronix.de>
References: <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy6QHHakztIXvudC@pavilion.home>

On 2024-11-08 23:26:36 [+0100], Frederic Weisbecker wrote:
> > Please see
> > https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/
> > and the whole thread.

Thank you for this Oleg.

> > I don't think raw_spin_lock_irq + cmpxchg for each work is a good
> > idea, but quite possibly I misunderstood this change.
> 
> I did not realize there could be gazillion files released in a row. So there
> could be noticeable performance issues I guess...

I made a testcase to open 2M (2 *10^6) files and then exit. This led
task_work_run() run 2M + 3 callbacks (+ stdin/out/err) for the task.

Running 70 samples on the "orig" kernel:
- avg callback time 1.156.470,3 us
- 63 samples are starting with 11 (1,1 sec) avg: 1.128.046,7 us
- 6 samples are starting with 14 (1,4 sec) avg: 1.435.294,8us

Running 70 samples on the "patched" kernel:
- avg callback time 1.278.938,8 us
- 59 samples are starting with 12 (1,2 sec) avg: 1.230.189,1 us
- 10 samples are starting with 15 (1,5sec) avg: 1.555.934,5 us

With the extra lock the task_work_run() runtime extends by approximately
~122ms for the 2M invoked callbacks. 
The spike 1,1sec -> 1,4sec or 1,2sec -> 1,5 sec is due to context
switching (there are few cond_resched()/ might_sleep()).

It is not that bad, is it?

> Thanks.
> > 
> > Oleg.

Sebastian
