Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56224B28;
	Mon, 13 Jan 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774300; cv=none; b=pncd8ETklTwPOYGkLSrE6RvA80iyZcWegUTGGd0f3nYuaVKYK5KjZDU76RswzttKraQqf0uH6YLYCsRQg1Lmlh9N8S90aiHarAlmSn7vBSkT+6s6jyNQsA46HzjfvdhIHkXCcHxiodUytAZOmV3+RQP47RjviR3XKKzdYlR7Vw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774300; c=relaxed/simple;
	bh=SsZu8YcLzTbYaJPMHqsBgmhGNcErqFfYYIu7dhWopwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow79rVyGjTXYdaXm/tsiJpLEPnDAzJXBQoG+1I3T9TKru/QT51BWpm6xO5wrn0l4BJeytmg1oZzTwc5UhG901kMmBWK58GyqoAnewDl5qUG5e7DNC4j4Tx9JlUmcjZNa51PdDw4BO4wzV+ah6yu5by9b7N+j2vh6hw4qvpdUE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQ4SGs9K; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQ4SGs9K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gYlgEsWSfO33bKZLTvDkNRe3cAN19cwynMw/uti7Rfo=; b=JQ4SGs9KrpKcZtlnzlpDD+MCxE
	0VcVtobTRv+t4oZ7KE6jToquy3iUl8tMR95HlMN43pid6Bk8OtjKZecj9PyTJa7TyNTdniy+G4X8R
	vqkghcqZuHtdMROQSlN2yurnGUFoTZ3AywlPRU2kQORPlu1p/N98ApqGtpxlXsl16GTXdyWzXEg3w
	gIjN1bvtkIitdJhCLG5M3iUBoNFEs8taKFFBsgwcAGDNIUKxP3BKWhQUgl4cgKDz9tB5OjQaicZnB
	CIwSA+BdPtMPQKXPAnhXQkAIPo9yplbud1CnZczO+6XIHaIr6PL++AlYkWa62J9FXXgF5t5OO4Zhe
	49+h1JnA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXKKa-0000000AIDO-2N3c;
	Mon, 13 Jan 2025 13:18:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A7F530057A; Mon, 13 Jan 2025 14:18:12 +0100 (CET)
Date: Mon, 13 Jan 2025 14:18:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Atish Patra <atishp@rivosinc.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Message-ID: <20250113131812.GB8362@noisy.programming.kicks-ass.net>
References: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
 <20250106-perf_set_event_limit-v3-1-dbde0e90ddde@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106-perf_set_event_limit-v3-1-dbde0e90ddde@rivosinc.com>

On Mon, Jan 06, 2025 at 08:07:32PM -0800, Charlie Jenkins wrote:
> PERF_EVENT_IOC_REFRESH immediately enables after incrementing
> event_limit.  Provide a new ioctl flag that allows programs to increment
> event_limit without enabling the event. A usecase for this is to set an
> event_limit in combination with enable_on_exec.


Utter lack of WHY.
