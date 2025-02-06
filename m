Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402419F13B;
	Thu,  6 Feb 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868271; cv=none; b=S0qLs+s1/Qikdjsp68QvqjFHKd+4AmLRvUcHtXqi/GIEPjzAGBK5eaDKkwTBcR193DoE1pnbEsXhb0RFXclstI34GZQi3/IVgNuxpG9tqKF6yiRDsb/E5m17dsNYDeS70oIe9ypkqFMLUPqyAz7MdcJ1/Usl7/GMfgiYmIIevrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868271; c=relaxed/simple;
	bh=DHM/MNNzBPzxHpZ54WyXj4FW3t1bAt5L0WfNgXiYfho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIxf2ghN2eIFB/RuiSnL1rHyZKlFSi6WiGbXwewv1Fw6aB2VECMPx19m3o0BR4/asrgS0MMKl3iTxPVYqJFsrzquZkw3DU6FKV8qRvcIJcaUjfWdDPwH658q5p49iIfBCS1uOb7ZChgx3yihA19PPxbeEQt+IY1Glo6kuVinh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBaLQQqm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBaLQQqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738868271; x=1770404271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DHM/MNNzBPzxHpZ54WyXj4FW3t1bAt5L0WfNgXiYfho=;
  b=lBaLQQqmVAErb3HyfDzfeN8ZuRFNU12/W60aBedQYyOoU2o1EYrIalUN
   2GhGrsO5lyMbZ3QJIlWSWyBESwPHI7xtUNu2rzDUbKzJW3CRN8+Q8p+22
   JIl733tXf2FYqGa11dtX25vRl6+CI+p45YaQWqulTOYq2BAzCuH+l0vc6
   uvW0zFvmV9CZ/bXsIhGMgp//Q40kDkxA2RWX/UBORylj4e3m1+juTotpe
   J7vsEu9vGDZODutbrFdNM5uSi4lXt/J2zGePwx4RlquWYyasd44wtPKGT
   dlnDZQ5mzUtEY9vJIwSzwak6l4YqzqcDuQQjj1zGLTi2WPLjNsUZIV5e3
   Q==;
X-CSE-ConnectionGUID: MwPd/lRaTKWGrRaK9lSu6A==
X-CSE-MsgGUID: +6bOiuyqSrSiAJ4y/WNfTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43252820"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="43252820"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:57:50 -0800
X-CSE-ConnectionGUID: 5Q1UvcHBSayjamZFxc3BJw==
X-CSE-MsgGUID: ytJq2VRUQ22lJOeYdS3PAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115385592"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:57:50 -0800
Date: Thu, 6 Feb 2025 10:57:42 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
Message-ID: <Z6UGJuL5e5WQQL-M@tassilo>
References: <cover.1738772628.git.dvyukov@google.com>
 <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aVWH6d7kuxzvcJSarXMQB-PPDTcE5OvN2tjkOLnzmMLg@mail.gmail.com>

On Thu, Feb 06, 2025 at 07:41:00PM +0100, Dmitry Vyukov wrote:
> On Thu, 6 Feb 2025 at 19:30, Andi Kleen <ak@linux.intel.com> wrote:
> >
> > Dmitry Vyukov <dvyukov@google.com> writes:
> >
> > > There are two notions of time: wall-clock time and CPU time.
> > > For a single-threaded program, or a program running on a single-core
> > > machine, these notions are the same. However, for a multi-threaded/
> > > multi-process program running on a multi-core machine, these notions are
> > > significantly different. Each second of wall-clock time we have
> > > number-of-cores seconds of CPU time.
> >
> > I'm curious how does this interact with the time / --time-quantum sort key?
> >
> > I assume it just works, but might be worth checking.
> 
> I will check later. But if you have some concrete commands to try, it
> will help. I never used --time-quantum before.

perf report --sort time,overhead,sym 

It just slices perf.data into time slices so you get a time series
instead of full aggregation.

--time-quantum is optional, but sets the slice length,

> > >  tools/perf/util/symbol_conf.h                 |   8 +-
> >
> > We traditionally didn't do it, but in general test coverage
> > of perf report is too low, so I would recommend to add some simple
> > test case in the perf test scripts.
> 
> What of this is testable within the current testing framework?

You can write a shell script that runs it and does 
some basic sanity checking. tests/shell has a lot of examples.

If you don't do that someone will break it like it happened 
to some of my features :/

> Also how do I run tests? I failed to figure it out.

Just "perf test"


-Andi
