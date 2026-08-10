Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BD395AC5;
	Mon, 10 Aug 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364335; cv=none; b=bqlaUlhscUr0x0+wFhnhk7pSWyod1FHAap+NThRtqK383B1KusVcAFMGatIF6Rbh1rU5YZhFF4EPRIykxZ1R8mwUUWzug4VpReLP99miZutSFF/vf+lLPjsS5SaV5cXbAAHtQ80Dki07a4HGF1auwPpy14e9noAyZbucE2QgH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364335; c=relaxed/simple;
	bh=qwCq30mFDN5vEft5VYQLRelZirPN58cl7CY1o1TpEuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5B2JWmdtpo7C6IhCRs4HwxQzqE7y2NXByUP1q6VJNLlt7p5tpUhSSzGMqx6fa/acNM4wqyeHDiu8NZqSyjW/bs3PcfY0NyIEnbkq9afDcISZr27xOFA5MJcVAb6Y3qkOoHGZoWJJzQupyxBfGjzLgLvvlm+jQUV6kv6XZxBIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O/jQq+gm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/jQq+gm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s9sk6viumbPq/Bpgr/sr0RNIxnC72sksnDmgM/w1rjk=; b=O/jQq+gm9+TuKXxW3W14s+wo6f
	+/YOjX2xJKNQeqCfWO0qtyBoRSGP5iH5RVE5QqhWzNPVPpaFwrIeyEnJRvweK46IhmBWg6AuEa99k
	OjKIKlI/RUKNnAMM7vFt/STuDJI3KHtpbkgyJ+VwAVCdLNG9uH/YSyrfVsFuFDPMCH9ztP7Pe7jN+
	YAOV4glkxaL6DbW5E8m0smlI9UobvQWO98oA0i/eaJrKDkVlNpm+9XyFGT8fqTmYEUMKtQuxuK2K7
	b1B0f698/1ByNl9SJBVLYHjemPqLX25+HB4i2vSteqQWCAJ0enfCB/mjO8lVngD/e6AXzV9k/F3RJ
	iIgJa5LA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtOxo-0000000Dm0w-0Bj0;
	Mon, 10 Aug 2026 12:18:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21AC030019A; Mon, 10 Aug 2026 14:18:42 +0200 (CEST)
Date: Mon, 10 Aug 2026 14:18:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v3 6/8] perf/x86/intel: Fix intel_cap handling on hybrid
 PMUs
Message-ID: <20260810121842.GW776954@noisy.programming.kicks-ass.net>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717080342.1879573-7-dapeng1.mi@linux.intel.com>

On Fri, Jul 17, 2026 at 04:03:40PM +0800, Dapeng Mi wrote:
> +	/*
> +	 * The Perf Metric (Bit 15) is always cleared on P-core of
> +	 * RPL and MTL. Details can be found in RPL018 erratum.
> +	 * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processor-specification-update/errata-details/
> +	 */

Typically intel.com URLs are unstable and not worth the effort of
including anywhere. I'll strip this out, its probably easy enough to
google the erratum number.
