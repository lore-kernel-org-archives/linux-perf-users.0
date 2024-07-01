Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BEC14AD35;
	Mon,  1 Jul 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836918; cv=none; b=OS9CW6oXQejF6I3vRABvj/+gLKKpgeBKIIuLCRs3uiN471QtZANNxTclAvC6cGqncI1/uM81YuYvHU4iDVjMK7wRaYt7+5GceH05f7SE0TQXts7fIzEV2qL8VqkE2iW2mbR9PEIN5PVxD15WPcuhpOcw1KZdSHhXbBAfrlnPff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836918; c=relaxed/simple;
	bh=8Vnkb5Sj5ahbf41xkdp3RVrVWg6PtFAl5M0wAYACncE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQmQAinyHH/iwzJ35/9YYXIfk3+Cej8KmsMZ1kk98s+4dDG8+5KC18nqO7JWtKUDvIrQlbSXtkvyKt0xhvliksU9XJeEzkEnijwMl9Ab4ui0VM6pG+7beSsJXFKeCAHqEY2DwQ9n94fRgmc3in5UhZaZaig3qhbfoBr1fbgMpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rWaKaeeM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWaKaeeM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8oU0Zu0hDmII2BWlQyeY+sS/zbhKwqsdmTyUNdLjFLw=; b=rWaKaeeM62/4xfdNeq12ulT6j0
	eM/tVbxIVLV1fLS8qF3Y22M/+BE4PeVV3bYgfkQ7riY8EB9PL9Lv3akdElWLc1VtHaEQb7RI+0RAG
	yP1yHBCzLwmDHcTw8KmX84Ar45mUZi4IijsS/HP+rAgt/maXp+3OcHLqbjw8dSJN4FP1gjV6sZNtX
	ePIebCfbb1bckXA1gvimUrHTSOgOOUOWOm0nWS9erJoO/pJ/DTxzvzNikL287q59gi3TweEh7Gvl5
	wrbVw/zYmZZUQc5UiRqOR6lAzSii2c264GqHTmn4PSkKVUTA2951K35ckS5Gh9rsMKW5Hz2gIY3xR
	1qH4rsiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOG90-0000000HK3p-1Djh;
	Mon, 01 Jul 2024 12:28:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A977300694; Mon,  1 Jul 2024 14:28:29 +0200 (CEST)
Date: Mon, 1 Jul 2024 14:28:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20240701122829.GE20127@noisy.programming.kicks-ass.net>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624152732.1231678-3-bigeasy@linutronix.de>

On Mon, Jun 24, 2024 at 05:15:15PM +0200, Sebastian Andrzej Siewior wrote:
> @@ -9735,18 +9719,28 @@ static int __perf_event_overflow(struct perf_event *event,
>  
>  		if (regs)
>  			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> -		if (!event->pending_sigtrap) {
> -			event->pending_sigtrap = pending_id;
> +
> +		if (!event->pending_work &&
> +		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
> +			event->pending_work = pending_id;
>  			local_inc(&event->ctx->nr_pending);

task_work_add() isn't NMI safe, at the very least the
kasan_record_aux_stack() thing needs to go. But the whole
set_notify_resume() thing also needs an audit.
