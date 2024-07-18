Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CA1304AD;
	Thu, 18 Jul 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307547; cv=none; b=TFtuzuZe8mId3ycmB0qhE+/bDBVNxaKPXCYq2VmV7hPcIO0hT5JsI9cXDHA0ER2AsHLeOEJhQI2sL7ijJs06EHc52kcAQiKViJPcZdjMbpBfbCxyppw3F4JjIFyVC8gNsm9TLjIWu5C8VRRLSM5nKG4kiv0IkbZgobINeM7ZaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307547; c=relaxed/simple;
	bh=TV4rH7YQ3pFe5LfYPNrA338ztmsRtK15DRer/iiQV+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvXp141zvSqsDXES1TeX2rCHXjAZXzTZqdllhYgiUj/HwUCTRp3vzVrIbU03LTU62eV5exMCM2mTpke1h8AYR60iiPr+NCdDeYGGXlD2wKYH/5j5a2s06zmXcRsO8qeosdlyGQI1cHj0Ek59+3gZj4ykiNZfV/Wu0zMZez1upiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZHghk1oU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZHghk1oU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TV4rH7YQ3pFe5LfYPNrA338ztmsRtK15DRer/iiQV+Y=; b=ZHghk1oUmIT5w9rjTLfrFsOljq
	8RPIm9nbUJiAdDpod9pd/WOupLLZFVG5fws7HWlmgLa7IT8wiTp/8w7v5M2gSpcDZmQ4PuBDz91wF
	e8ecB5nLl8n4RV/V58ORgld8Sxgud38ykiHlwEY08VPyfHEZlJOj82jH7MVyBC7l/B1B8l90Bb2ev
	aNelhGGi9BH9wa0FvirYpr4uaSnBjlMT4ej8jy5deLI6VpBoLWl8JAx/ki3YtWbz7iyJY35Oca1+D
	HTW98vhvUXPe0efsEIzg4aaYxgBhzPyKmXXKuGZ/t3fTd6p1JeZDgEJaNayjoFx39fy2bmr5FWcrT
	ik2xve2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUQig-000000020nP-1Nnk;
	Thu, 18 Jul 2024 12:58:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ABC993006B7; Thu, 18 Jul 2024 14:58:49 +0200 (CEST)
Date: Thu, 18 Jul 2024 14:58:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20240718125849.GI28838@noisy.programming.kicks-ass.net>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
 <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
 <20240718115126.GK26750@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718115126.GK26750@noisy.programming.kicks-ass.net>

On Thu, Jul 18, 2024 at 01:51:26PM +0200, Peter Zijlstra wrote:

> OK, let me do that and make a few more edits and see if I can stare at
> that next patch some.

I pushed out a stack of patches into queue.git perf/core
Could you please double check I didn't wreck anything?
