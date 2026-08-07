Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F03D1A98;
	Fri,  7 Aug 2026 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083197; cv=none; b=fuZULX8DxdAvABWto3rVHHlaJc19apdAI3gZ9yrSHVC/qgtFvwFz9SQcKEkhItxa59jkz5gnac/a+QiuAfjQ9CNNHkRjRVn7K48W+n5xgqIKGwXu7zI2VYGzdqHGW1nKL4xhsSQiz96MdzzbkM6dlHFR9SBtSnrbLj5lZidw0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083197; c=relaxed/simple;
	bh=PbPeeRzn14+KCJnfW6O1nO7OzHTbgoaWYq+b/OIZqqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6/OaO18ZOwMEwlAbbbhppwdG1PU9MZChBywosYI2SgFBmkg+IAh3NZge1QUaEiVFjfO3a2M/XdGVhWkfFTiKQB9Smdac1O09ERcfO+VFRHARBFalYAtzWE5Po9CPQaOiZdGZ4/EY4EIZEaZpEAFe9h/z0X+wZvoeVelxbTKvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i44VM/pG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i44VM/pG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E21F000E9;
	Fri,  7 Aug 2026 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786083196;
	bh=JROVinj0Pfiv4Z/kZmjOk3W0QTH61jsje3SEYA+85wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i44VM/pG/vUIohc65/jZl0o3nZ4O0H8u7zkKn+zrnka3WCypXy+ME+9vii3xftfx6
	 L81A0pBupwY51gm5Ex7lsfXk5/f1sRZjldl8jb/FlIOXjldC/k7cJzKK//UEbFntly
	 qrYCSat1JRjC0JKHGzjzZMrun00YSef2X8IzoXfVPbiQ/yNNcwNiG8pTU2YhPa5B/T
	 dY5BrnYUeTO7SfixKh998vipLkJPXyrqPlqHg/epuFuz9DjpZWTgoLIp4cE2b+OGaG
	 RnGQCXJktOfzdGu3OMWman6vPQ9SAIP1JlYZesb6w5XZjVoZJ2jTsXd1kjM7AExQRi
	 yZSUcMNq7tS7A==
Date: Thu, 6 Aug 2026 23:13:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] perf c2c: add function view browser skeleton
Message-ID: <anV3eQb6SzRnRksH@google.com>
References: <20260806074217.2846596-1-jiebin.sun@intel.com>
 <20260806074217.2846596-3-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806074217.2846596-3-jiebin.sun@intel.com>

On Thu, Aug 06, 2026 at 03:42:10PM +0800, Jiebin Sun wrote:
> Add the skeleton of the c2c function view: a new TUI browser in
> tools/perf/ui/browsers/c2c-function.c reached by pressing TAB in the
> cacheline view. This commit wires up the entry point (a stub that will be
> filled in by later patches), declares perf_c2c__browse_function_view() in
> c2c.h, and adds the TAB key handler and help text to the cacheline browser.
> 
> Link c2c-function.o directly into perf rather than libperf-ui.a. The
> browser is part of the c2c command and later patches make it depend on
> state and callbacks provided by builtin-c2c.o. libperf-ui.a is also linked
> into python/perf.so under --whole-archive, without the builtin command
> objects, which would leave those command-private symbols unresolved.
> Build the browser only with CONFIG_SLANG, matching its TUI-only entry
> point.

I don't think it's a proper fix.  The c2c-function.o should belong to
libperf-ui.a.  Perhabs we can split libperf-tui.a and not link it to the
python module.  But still, it's better to move the common code into the
util directory.

Thanks,
Namhyung
