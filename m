Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD91CA8A
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892505; cv=none; b=d7aQpJUZcFfvre4FPBtD846tQZDz0LCdOR9CgxXY86sg/pxbEOfKPWPmH54SGdIhqSaqLIRS+KmbI5GcUt7GCFZX9mWilZCtM9uFwKMVHNgL3aVu7BkubrZfH57SuuVgRcJtLxG9vQQVHa1z2yzZAh4B0BLXU2+yNf0r+73J3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892505; c=relaxed/simple;
	bh=Z+2V3Ndg/bCH6gMS/oF+TywxpgnLQJwrP9k7jldiRpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnZzo3yZmWY3EhTtm6rbSrDZI6NvRTSPAA8/ejW02ohIqKJRGrL4rMj3n1LCazmYdlZLYV8kx8EqDlWozTimw+I3CRwNnnLwzuiADsqK+zc9oua4F8q2wfJ0l2lMrdwoGH6wD8FpTQKuR/ux3ayqTpXUzWg3yA0h6j8TwEurtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqZl0dem; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqZl0dem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721892504; x=1753428504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+2V3Ndg/bCH6gMS/oF+TywxpgnLQJwrP9k7jldiRpc=;
  b=AqZl0demYfqPFWZfziURnWzFTA902q6JDrOcPDt8iOmTyXNP3YyAhcaw
   YpndplqtR6TuJa3QbRe8DIu/JGn1t3pRKIhXJMduLPGlJZecHXUg7pcBQ
   I4/8kvSiAGQz5t/SGeXu4LJ2Gwnt/V8RIns7DQ9g3WgMJKRSPRVnIzfj/
   BifHA6PVNy0wZ+0HBBwKfXGvE6g70yrpI/J9C10NS3Owh0/icDVzNjkTb
   P/cSwM4nUsZdSmgxc3wMRy8Z/P+N0Ef124Rs0VmQad8ngMa9ILh1cW96W
   UnxNdMqdx8NLxbkG97FgiSBaKOLftCm4WDpMnXAs3yMbrgRNtlnZS5IGl
   A==;
X-CSE-ConnectionGUID: WLlY+DfAQW2uaPT2rEOD1w==
X-CSE-MsgGUID: qUs0yaYiR3elEZox/9/u+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="31000806"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="31000806"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:28:23 -0700
X-CSE-ConnectionGUID: trKVy5vsS02fYia6F2dECA==
X-CSE-MsgGUID: 78SphmipRyeAjoM4oS3EoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="52710139"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:28:22 -0700
Date: Thu, 25 Jul 2024 00:28:20 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Create source symlink in perf object dir
Message-ID: <ZqH-lAF_ztetHZIH@tassilo>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>
 <ZqF2xhZuchmnq3Bc@tassilo>
 <CAP-5=fXh4P64Un9CMnoA-RrYGg9LNUw+zwkY9qAYyJdKa9WTEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXh4P64Un9CMnoA-RrYGg9LNUw+zwkY9qAYyJdKa9WTEw@mail.gmail.com>

> > On some reflection your changes went into the wrong direction
> > because it ignored the (useful) single group property. Aggregation
> > on time really needs to be in perf report not here.
> 
> Still don't understand this. You are sampling, that's why you use the
> period, how can both samples happen at the same time? Why can't

It's leader sampling ({}:S) , so only one event samples and the others
in the group get collected/reset at the time the sample happens.
So all the events in the group measure the same time interval.

Think of it as a much faster and more efficient (but also more limited)
way to do perf stat -I ..., driven by the leader event.

> something sample twice in the period where 1 thing samples? You assign
> to the counter not accumulate in it, but the whole gnum would be
> broken in that case. Why can't samples be interleaved? What I did was

There's only one sample -- the leader -- each time.

-Andi
