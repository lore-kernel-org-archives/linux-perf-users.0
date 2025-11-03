Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC431E0FD;
	Mon,  3 Nov 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198195; cv=none; b=TAY8neyKQ4cJs01wfaZZDbZb+eyd5s9L+/1lNrW20Buvzgt0dRPfGlnVTBbLLCuk6wIxA/Oj+VyVLjIdKUC4VBnEJxoOuevq3AMk7oQORmq/A74mJDiLXeDk/OYJCVFcwgV5iiKnwRobuc6dCDKk/wC9lmGgDoMlTzBFHli2Or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198195; c=relaxed/simple;
	bh=fRx6PAs2XVngndFqMA4/GPWLhaxYxm4Mi2HGbQkkd2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynw07AYGHlbT91VlH1CDykTgeQE6KJGJ2JXygyTH52XXtzn9O6sPWEMCSwFk7gyio4mzqHXWh0H2NVAKjlAiBRGi72U1dFTIT4rdJZYKxVlSOC9Zu6N6ysJP09Gk+k+Sa9GSn9mfkfTEvYcElBDbxAGnWB8oQVyJH703113sq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fUiglO4K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fUiglO4K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fRx6PAs2XVngndFqMA4/GPWLhaxYxm4Mi2HGbQkkd2k=; b=fUiglO4KZgrtER9VCvAYhp+N4t
	ZA9yLPTrbxF/7Oyx0sYrcuUUQuO3xiTdHELm+YBfs6ITCqoZUkuTGRweaZTYoxd72/Canx4Pmn4Dw
	WE0bjBSyfBg5wdr1wc+5GKhxd4okiwlCFgufC/d4Lrsyez30cF5gt9Lar0BBudLDT2LqoMy0ku028
	2syGtzANn/Zi8d17nB5OzFfSnz8/8nujDXR43+uI3aNotz4JJ6gNYstqmPu2TfwsMrfqeNE/8v4zP
	VbOkQl6jow4P2jNjrsqnE1fbSyHKlzui4UdQ+PQo/HHkRXOBabOtItXSUtrVnMctnNWHSTSYXjt4n
	Nyz76tEw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0FQ-0000000G51u-06Gy;
	Mon, 03 Nov 2025 19:29:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBF3D300230; Mon, 03 Nov 2025 20:29:48 +0100 (CET)
Date: Mon, 3 Nov 2025 20:29:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add James Clark as a perf tools reviewer
Message-ID: <20251103192948.GK3419281@noisy.programming.kicks-ass.net>
References: <aQjCEfiFLJwApdlj@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjCEfiFLJwApdlj@x1>

On Mon, Nov 03, 2025 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Just FYI, I'm carrying this on the perf tools tree.

Thanks!
