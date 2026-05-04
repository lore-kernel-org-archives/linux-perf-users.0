Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527E3161A4;
	Mon,  4 May 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882129; cv=none; b=OyKmTvKrCdR8ELopzIhX/gGvZ5lVC+tfviANpS8AyORHjaum+ik1DOfnfktk7mQLWmc5VC/6GgVuXmCaz9v9Pbv6msJ7NKnHvGhvu4dLURd/xVgFlXLbVntbg8wmO23NHfuQ73huBRCZ4W74Do2yNeRq0fDPieyvYBo/itr0B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882129; c=relaxed/simple;
	bh=9dIzJh9Zw3F3XU3KZm8lkUUKdTm6HZobHY4M8stjq0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbD5ly7UOo7JRYwDJMXBFtCutdaZJ1QjUDd2Y3puxxOrRsIT/kTWIxLJKtCw2mz4syBSCwM2BSE03r2yFqoKaYRym5o2l21liDakOoylmRnvRI9xV4N2M4d5zG7VJpsyPOu8UR8gawraSxD4Cqf/QLSaI71Foxub4LwVjPuWqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ecidJycS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecidJycS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Klf0p3eIPGxCIWpPyFCDL5orM4JukkiJ8FkZnNfn+lM=; b=ecidJycSkBoLAOW5CImi3lg91z
	dZKqEWZUmtqCOr5d6xTAdCyIbMexrMzzulXtE51TAm3otT0rrsDWLRLQiJfAaGwdrUdtjYOcwMZqI
	m2ACO//6JLwVBhBYJLxD/L27sPTLnFPqkEDzho7K0MvHM/L4GXYt7NGAgC1EvS2dERRFBTMjcQh0c
	TDYNL94RXp8Qem5KZQvZKJ3C/GT47UH1iF16sle/8u7QwxtLIs2a2Vqw9odar7hkQoH7nQLdjYvo/
	ZRiuyRlskO9tgsCheG8QI2l1oTpGm8gq/C6CjnwPLT7uzCh+yqMg8UkUZktzMkGprSN4AbTw4pv+U
	2Q6/e1wg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJoLy-0000000B78V-2Dpg;
	Mon, 04 May 2026 08:08:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D360F3013A0; Mon, 04 May 2026 10:08:32 +0200 (CEST)
Date: Mon, 4 May 2026 10:08:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Minwoo Ahn <mwahn402@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jinkyu Jeong <jinkyu@yonsei.ac.kr>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf/core: Fix sampling period inconsistency across
 CPU migration
Message-ID: <20260504080832.GO3126523@noisy.programming.kicks-ass.net>
References: <20260429095134.10049-1-mwahn402@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429095134.10049-1-mwahn402@gmail.com>

On Wed, Apr 29, 2026 at 09:51:34AM +0000, Minwoo Ahn wrote:
> 
> When per-task software events are sampled, period_left is not
> managed consistently when task migration happens. The perf_event
> may observe a different hw_perf_event::period_left on the new CPU,
> breaking the sampling periodicity. Even if a task was near its
> sampling point, it would use a stale period_left after migration.

How? This is just vague words, not actually saying anything of
substance.

> Introduce struct perf_task_context as a per-task container to

How can you propose a solution to a non-defined problem?
