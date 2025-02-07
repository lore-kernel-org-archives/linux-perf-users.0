Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6219C558;
	Fri,  7 Feb 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953050; cv=none; b=VjU9QgbOa9qS/Xvip0JaMn60pUbejdRKWoJNF8dxoWI8fgWQZCwvzrmlo1xcxLVhi+aLz0bgcYxejq7uoTxpKnCDcEDTpIRlU9EsA8SLl7EIDU6dsPFYU/ndSaGedhfd9p3GRfUj+rMTa0FFFc8aK7mpQ4V6DixKQ1z+o6327f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953050; c=relaxed/simple;
	bh=T3uQGNokuebOj0LHVuD5bDQu/1lgO4nWEJSqc0c4zfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkrZyy/IjHGho1jtfLi8fF7+/Z6wAuRqo8LalqgBMLz3G6DvC2YOKsrUuCTrrutwOiC2IaI63NRoDXfguD5Z8/UrnxJccRqjDFHNMIucc/Yc+NT7jGZ6bNd/m8sIkBgW53IOBChVMkuf2Wh4SaXBdsNikvhogI07WHtL2lgQRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKZOGqF1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKZOGqF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738953049; x=1770489049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3uQGNokuebOj0LHVuD5bDQu/1lgO4nWEJSqc0c4zfw=;
  b=fKZOGqF12MGvCLbfO+HYStbEqLimUF7XS7IKmW6y9By+7tomJzDiku4g
   IBNU4cK/VyVf8Hbm/E/ketVXNHy51JRFbhWbuZ4WVaw29sSELVTyq0Hsl
   4cUk8CBJ1XDJ7gLVvzgc6fjOTdd3e6OqdO8TiXCiMNg7BqEbN3+2jldHv
   qibD8Wda8IzUTSna3cnmBnkUYedSVnTlDIeIjEy7hwbnnMz+PoQmav99z
   eaR4Cddq46yITwA0k7ITctSoFs9LRkZhdIzf8aNHMCRFqcqUdTqteVqQX
   Qm+iRLORc79EmDCSfZis9DXjLKuLJ8hgKw0x+nHuGMWqBhHIfJoc3/rt/
   g==;
X-CSE-ConnectionGUID: jKvo8mF/R9S3w36xouAC4w==
X-CSE-MsgGUID: HbIqD1DFQvqmUiZ7Go2HoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38836722"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="38836722"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 10:30:48 -0800
X-CSE-ConnectionGUID: Y8x3+kBRSFqwhbweTwaEtg==
X-CSE-MsgGUID: Q+VFW2RSTKusbNZYu7qd2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="116603371"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 10:30:47 -0800
Date: Fri, 7 Feb 2025 10:30:45 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
Message-ID: <Z6ZRVeoFxT0NV9yb@tassilo>
References: <cover.1738772628.git.dvyukov@google.com>
 <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+awFXT2j+HMeAy2RKnoBzb--+heFzJUoBZWp9iJevy1Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+awFXT2j+HMeAy2RKnoBzb--+heFzJUoBZWp9iJevy1Dw@mail.gmail.com>

> > I assume it just works, but might be worth checking.
> 
> Yes, it seems to just work as one would assume. Things just combine as intended.

Great.

> 
> > It was intended to address some of these issues too.
> 
> What issue? Latency profiling? I wonder what approach you had in mind?

The problem with gaps in parallelism is usually how things change
over time. If you have e.g. idle periods they tend to look different
in the profile. with the full aggregation you don't see it, but with
a time series it tends to stand out.

But yes that approach usually only works for large gaps. I guess
yours is better for more fine grained issues.

And I guess it might not be the most intutive for less experienced
users.

This is BTW actually a case for using a perf data GUI like hotspot or
vtune which can visualize this better and you can zoom arbitrarily.
Standard perf has only timechart for it, but it's a bit clunky to use
and only shows the reschedules.

> Also (1) user still needs to understand the default profile is wrong,
> (2) be proficient with perf features, (3) manually aggregate lots of
> data (time slicing increases amount of data in the profile X times),
> (4) deal with inaccuracy caused by edge effects (e.g. slice is 1s, but
> program phase changed mid-second).

If you're lucky and the problem is not long tail you can use a high
percentage cut off (--percent-limit) to eliminate most of the data.

Then you just have "topN functions over time" which tends to be quite
readable. One drawback of that approach is that it doesn't show
the "other", but perhaps we'll fix that one day.

But yes that perf has too many options and is not intuitive and most
people miss most of the features is an inherent problem. I don't have
a good solution for that unfortunately, other than perhaps better
documentation.

> 
> But it does open some interesting capabilities in combination with a
> latency profile, e.g. the following shows how parallelism was changing
> over time.
> 
> for perf make profile:

Very nice! Looks useful.

Perhaps add that variant to tips.txt too.

> 
> perf report -F time,latency,parallelism --time-quantum=1s
> 
> # Time           Latency  Parallelism
> # ............  ........  ...........
> #
>   1795957.0000     1.42%            1
>   1795957.0000     0.07%            2
>   1795957.0000     0.01%            3
>   1795957.0000     0.00%            4
> 
>   1795958.0000     4.82%            1
>   1795958.0000     0.11%            2
>   1795958.0000     0.00%            3
> ...
>   1795964.0000     1.76%            2
>   1795964.0000     0.58%            4
>   1795964.0000     0.45%            1
>   1795964.0000     0.23%           10
>   1795964.0000     0.21%            6
> 
> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
> 
> Here it finally started running on more than 1 CPU.


-Andi
