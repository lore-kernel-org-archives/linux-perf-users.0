Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC970044
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163206; cv=none; b=A1mgXfbXoxNId89/Eu3lGKHDXzeG5RE9cVQwt27e4JcZajgSjRi7KhDY/OdnLzboqVDQcC3k0P1t/xia9kKr0Ex8lw2sdbee4twvASoa+cx6YjCgjKYHNo+GrBFEdFGGaa8yaFiyfczTc5GSw06veI5PPra3zDfso34jxPJOYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163206; c=relaxed/simple;
	bh=DYxzrlfhic/zi4aOTjZraFfrOWPY6p+SeeqZWFxEK30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmMbwJCJ3wHihPkCLusk/kp9tILgMV2e+Pu3DA7Sjy1qGNDelSGXCvO0SnaATspDoVtnigZHUnGpWPEwgQ5M7MIPJsYsMHOD8NIO61esToF/icB9/WW0whO7YL405Wd35baZDdj3GHgA2MlRcLQJgZqjUP6n61QGBZ+lb2/k2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJSXhgkH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJSXhgkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709163205; x=1740699205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DYxzrlfhic/zi4aOTjZraFfrOWPY6p+SeeqZWFxEK30=;
  b=HJSXhgkHmCgG3DAsa7z57wMomwbeE8KsPaVYR+YBf5hFfsHvW6M61y1s
   eMBZzWRuABUhAxxIIRPHqF07pQ/d922JxBQBVOj2Ld2EDBZNtADDoqRfI
   vJJqsAXJRylPTuy6PfD7DnAIU4xxxz2uBt5GnVxub4Oa2fxIrR4EuVYNo
   YlS5GcVyoP7UbxbyIROrV8JvB3E1op6b5voftT9fNNh7+dX0O1bBpWjaC
   EL1OIiMWxK49R38g906wueaujEg8qRwkpDxhKrRJmmOy56UqmHM+jy5+H
   H3c1bsmO+GO4ZYnPZU16eagpWJ4+545xHwTqZgYIto1DlSBbLl+5Jfm1k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21059890"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21059890"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="45131385"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:33:25 -0800
Date: Wed, 28 Feb 2024 15:33:23 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf, script: Minimize "not reaching sample" for
 brstackinsn
Message-ID: <Zd_Cw6QeuGx-Dblm@tassilo>
References: <20240227183910.55824-1-ak@linux.intel.com>
 <ceb7d039-5088-45e7-b7ea-8f2056f5f7dc@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb7d039-5088-45e7-b7ea-8f2056f5f7dc@intel.com>

> > There are two common cases where the message is bogus:
> > - The LBR only logs taken branches, but the branch might be a
> > conditional branch that is not taken (that is the most common
> > case actually)
> 
> How do you know it is not a taken branch that missed the LBR update?

I don't, but the not taken case is totally valid (and also common)
so it doesn't make sense to have a mere sanity check make a common
case unusable.

> 
> > - The LBR sampling uses a filter ignoring some branches,
> > but the perf script check checks for all branches.
> 
> Not understanding this case.  Do you mean you expect not to reach
> the sample, so there is no point printing the message?

If the LBR is e.g. filtered on far branches it makes no sense to 
check for non far branches. There are lot of filtering cases here which
would be very complicated to handle for a mere sanity check,
so the best way is to not do the bogus sanity check.

-Andi
