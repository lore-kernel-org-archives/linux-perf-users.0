Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1530221FD4;
	Thu, 24 Apr 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491244; cv=none; b=rQmoxGiQ3q/hOWF4bxApjMlafBUI0xzzbB4QhXTlX4IrDSg3Ygwb5XlcfxXnJ6lkBduOfqST0yIUnKOHTu+0afa1PP4yoiq6DnSCcc797dOy4P3DkNv+AHeUQxnM7ZiPGO+6ycR20E6+6zKVRxCLFOINxPBY6OFuYWbQH4/8T+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491244; c=relaxed/simple;
	bh=VfgAF5tdFF9XvVPd4mOHkk9ukH3mDa8hX3KuZyWTvrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfjwTofH/LCDXpHDz2nWcfFontXv9tI1/cmgXXcuNZ7HH7Jd8Ud57oRglI/OdmHOFfL/lumYtpMMtV+prZEMqzFi6zjNJ854QiB6d17XnZlXMIuecC9uowv09pFcc5Q0QmBAt2v5LghCsQ5tVPQzv9UfyN0Y1aUPycdy13MLFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b5ckuwSX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5ckuwSX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VfgAF5tdFF9XvVPd4mOHkk9ukH3mDa8hX3KuZyWTvrQ=; b=b5ckuwSXgvEOn919rq9fQqALbl
	dM+/bmsvO9CxaXpneQ/2p+OFVo9x/wtgn32Gt0ICw4SKpaLqh7gSD1W5e5WST7NL3QDlnktrVj6uY
	f/amEGkIFYSp+KUpXoC5esbwmft3fohEEvDFZrhyBsLjULoklw4KLzjn9bXyGPFmK7AjtYlQlBuaM
	SW9Va9uxdrf2l/FNfmlH/frKmqZhAZCpaInPgvtC/O+FwPxAO3GGq7RIHDGx+CHBIkiW6Ge62RCdl
	dvzS9JSla0yBDKG7hV4OMa9WyR/mGCp2lVew1XbZkyC4T2cwL1/h3Or10OZcw0xQCEJKupn/LKfgZ
	xw3+ow3w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7u0K-0000000BkTg-1D0W;
	Thu, 24 Apr 2025 10:40:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C4B283002CE; Thu, 24 Apr 2025 12:40:27 +0200 (CEST)
Date: Thu, 24 Apr 2025 12:40:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Baisheng Gao <baisheng.gao@unisoc.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <20250424104027.GG19534@noisy.programming.kicks-ass.net>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424025429.10942-1-baisheng.gao@unisoc.com>

On Thu, Apr 24, 2025 at 10:54:29AM +0800, Baisheng Gao wrote:
> In order to fix the race condition between exit_mmap and
> perf_output_sample below, forbidding to copy the user stack
> of an exiting process.

You cannot say "the race" and not describe the race. A stack dump is not
a description of a race.
