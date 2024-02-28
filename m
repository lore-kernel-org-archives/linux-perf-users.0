Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525C13D311
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163040; cv=none; b=PRrzy5yqVnz+aeiXyMCEQ1RkilWC9sCOmrSY+4rM1CMJhCryqkbkSbecwNOpUjaHoDO651h6JCTaPrZD7tyLI+jpDvvzRXJ6yTl1UcsNSnJtDiZkSVx3cVnUPyshXPLMKHuhhlP7br8cc0KyA0ha66qAI/Ifza01bWBleSnQKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163040; c=relaxed/simple;
	bh=a+4b0Z8GzICaBeK4aOYG9OD+qDjLz3dJHna5KJ3oivs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvh6UfNaElaB1mBkoBThEDS+I4BH3K4QW0B+KNGet8R9lHcynQXXOy2qMvhU6NXeeUpH6JP7Nr2aZhrrm++DNj8oXfPazLntzWTOdaCLC6UAIc5/DfuX+ABiDbE0sMsDe2VIiDUrpPDZdTV+OhzbPvfIQywMDtYE3q2ui1gCmXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+VoYCxN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+VoYCxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709163039; x=1740699039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a+4b0Z8GzICaBeK4aOYG9OD+qDjLz3dJHna5KJ3oivs=;
  b=d+VoYCxNkwu4BLVGX/kNs0PMDnwJPQmJoqD28nD7YRkW68ollzbmEJeU
   qBgyqa5TvQsNQuduwAw7RpsrVRQJEsujC7Mg4na9dkLcubZXNu+MTiyp3
   UmWl3nCRdxnBPTEixHX3lxzF7ygf/cEezlC3ipgsfFybJuZFfq+Jgk1xL
   w2UOSHvAZfjgcUHHpCLNnJTOfOfjKNyK7ib8jMZxCenDpki3dJM5z3I6/
   io7tCiE376GrckOJ0c3+nRAAcfOGlouj6sV0B7bQHReS+ash3oa+OU2K/
   kOoG1o38E9h43m2sIiYOWGixw0BmF0atfkHmxk3+8F9rR7E4i4h0nhm4C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21143249"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21143249"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="38633878"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:30:37 -0800
Date: Wed, 28 Feb 2024 15:30:36 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, changbin.du@huawei.com
Subject: Re: [PATCH 1/2] perf, capstone: Support 32bit code under 64bit OS
Message-ID: <Zd_CHC8NOW5Ig7SE@tassilo>
References: <20240227234806.82694-1-ak@linux.intel.com>
 <7ca41f7f-28b2-4f3c-8c04-1dba110d3135@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca41f7f-28b2-4f3c-8c04-1dba110d3135@intel.com>

> > +	bool is64bit = machine__is(machine, "x86_64");
> > +	struct dso *dso;
> > +
> > +	addr_location__init(&al);
> > +	if (thread__find_map(thread, sample->cpumode, sample->ip, &al) &&
> > +		(dso = map__dso(al.map)) != NULL &&
> > +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
> > +		map__load(al.map);
> > +		is64bit = dso->is_64_bit;
> > +	}
> > +	addr_location__exit(&al);
> 
> Maybe 'al' could be passed down through perf_sample__fprintf_insn()
> 

These are different addresses -- one is for the IP and the other is for
the immediate. It seems cleaner to support separate ones.

-Andi
