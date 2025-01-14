Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF28493;
	Tue, 14 Jan 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888518; cv=none; b=NnaZnUk7G0yv6NUWhkDgBrCjiG/cUO53u8Tme0lYdFmFab35mIqkK1eyasfuZJAVoe1bASQENiYSTt4MG1oKM+rZeKAtu63w9VyTzB/p5OlYrxlBctNPx5pF0iMRJi1pBxrul2d1E6JvG5vVnvaujmFsj0/OVwIJ4wGZ792c1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888518; c=relaxed/simple;
	bh=oRhBJSFplA4girqQpFmXn2lpdwxmXMmYVYqFN7a/EOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyQsymiq7VY/9d3we5arpcX4JlCqlHPVxDdx5meQOyjVY3tMPAad3a/JofLsSGG8d9Nw/ctZFuaWVj/XuL/e+4wXHZ5ltVJXnM7oq9/CYfnGcVi8wcZMiErzERKQAFvMhBVdRcZAbUg4rl9803ZDJter4/2SmkjIIlELiNnn0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXlUaoEq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXlUaoEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736888517; x=1768424517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRhBJSFplA4girqQpFmXn2lpdwxmXMmYVYqFN7a/EOQ=;
  b=iXlUaoEqtei7oHblrmoDprdeMj0qBdOAKpKiIShSDMMnKbZShTEKl9TV
   xcKrkYwTJaEkKYAVEZp4NXPJnrMOYWPIe8PvGRGCYLRpfU2S1pmYvns8v
   vrclpqk2hVgi1jQQR+/5lMcdykeORvlLFFBxRd9re++hrpQ3P2u0KRU6l
   X15aGEJ083JvYKfbu7WDGng19djcwQYdCpBj2dnRnfwYdTGL6eEZFJ5hA
   bxq6CWwuYvaOXk6smoi8ZQRdXqR0IW/6saijCr/dMeII1Lf70qQ62ThtL
   74glbwivFF4uUB9+koCKQx9CdRWglEYXJvEgGH+p1LeRN7UOJFikLpyda
   w==;
X-CSE-ConnectionGUID: MBIq7SesQC2MR+dIbL6vUA==
X-CSE-MsgGUID: gHpVe2EKSoCfeUhz8vQO+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37361508"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37361508"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 13:01:56 -0800
X-CSE-ConnectionGUID: ACZNSe65S3uCWIbFc7+OPw==
X-CSE-MsgGUID: wlw/x9/7TbyWokH9SCrAzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109548224"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 13:01:55 -0800
Date: Tue, 14 Jan 2025 13:01:53 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Tavian Barnes <tavianator@tavianator.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH v1] perf sample: Make user_regs and intr_regs optional
Message-ID: <Z4bQwTL5VK6jGDZz@tassilo>
References: <20250113194345.1537821-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113194345.1537821-1-irogers@google.com>

On Mon, Jan 13, 2025 at 11:43:45AM -0800, Ian Rogers wrote:
> The struct dump_regs contains 512 bytes of cache_regs, meaning the two
> values in perf_sample contribute 1088 bytes of its total 1384 bytes
> size. Initializing this much memory has a cost reported by Tavian
> Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> script --itrace=i0`:
> https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com/
> 
> Adrian Hunter <adrian.hunter@intel.com> replied that the zero
> initialization was necessary and couldn't simply be removed.

A much easier fix is to keep a global/heap allocate perf event
around that has these parts zeroed and only override the fields
needed and clear them afterwards.

(similar strategy as a slab constructor in the kernel)

-Andi
