Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814354AA03A;
	Mon, 28 Sep 2026 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595322; cv=none; b=AArzXII93Sfsy4cXyg6rjYCOZc+hgyj389vNwVXuruGUr9qH2g9s4BMBd/3uuNLS0RnA94bNyjb8dAUNDM8dwcC+N9zQbN8Z9l70prdx4I5/Ys59bRzwNjdFZOiq7Uk6yJMKv0hRSN9qnj/rzSYBW7gWKDoSoCLi1CSmLEkiyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595322; c=relaxed/simple;
	bh=5Mt9i6FKuVRyZRqfPs2gaFhgsD2PUofZrDsH8fx76qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USJirsa4kMjyVBv4vbRU16Z/Ds0xB4ujeTPKNuMULoeVyQgIXwjvtt5vZkybCs+tn+UsXzcGYOHDGoH5lix8+cQcCGPKmUM6rPw4dOmLvRR4kZCtTPm3ctmCQ2rtatPO7NqkQERNyJe8IuEOStK2HK4qr6nTWVpks7iMNB3Yu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YhQNRxqR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhQNRxqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=khmPjeN+u+APZhVACT8SI8Ta/vWWuWX5CS8JMTHJ/H0=; b=YhQNRxqRRqtj3X3Qe4oz00EEVe
	mFh2UA6TiDB4QlTZpKvkaH+EcDglF+DKukhzPWKTcZJzuwhAutS5Ea+v9uUOtAj7i53NoZdGUr9Ig
	Jzor2K3TgNxxsLBl+MnjKERAQ9luNzdXvr57gKsqcy6DL8ExdnDWrqbXjNV540k/VOruYMcXf05yw
	BtMDhFfclrjksawNFgXvZaFmgfjInUs1szmB9eiV8QkJrRpDbpaR6E16p72LLQd+d/3OpO1zZAon2
	ajzRiFFqjDvHU0TzI2rXW6Se3UiQ7+ocRxYOwOCWpYEAhN40varSK0m79QHDKI/rO9FboWVSESxhm
	jXhV9g0A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB9dV-00000006QJ4-1Hn1;
	Mon, 28 Sep 2026 11:35:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F0A95300754; Mon, 28 Sep 2026 13:35:07 +0200 (CEST)
Date: Mon, 28 Sep 2026 13:35:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>, Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/3] perf/core: Export perf_event_itrace_started()
Message-ID: <20260928113507.GA776954@noisy.programming.kicks-ass.net>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
 <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>

On Tue, Sep 01, 2026 at 05:36:15PM +0100, Leo Yan wrote:
> Since Arm SPE and CoreSight drivers can be built as modules, export
> perf_event_itrace_started() so that it can be used by these modules.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a311042afab6b65814a84c67b87ba929b..8afe89179a62127eebae0f38f29cde045ba56251 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10560,6 +10560,7 @@ void perf_event_itrace_started(struct perf_event *event)
>  {
>  	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
>  }
> +EXPORT_SYMBOL_GPL(perf_event_itrace_started);
>  
>  static void perf_log_itrace_start(struct perf_event *event)
>  {
> 
> -- 
> 2.34.1
> 
