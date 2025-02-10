Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FC22257B;
	Mon, 10 Feb 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207520; cv=none; b=GcnzFdfZ3KIsmd1Jg8xCR+2RcRs5QnYoeFTzhdio3hT7oq6SVaSe9nwJxWZt+e1r2ERJ00W3NX0SsjkeUsGpyY20tTgLu4ORCrqMKG+WDRLsgLxBre30TxHiCzIZX3Ksv6IyYckv+JcmEu7iFiFNL7UHh83Ea5zHnHfLk6tES1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207520; c=relaxed/simple;
	bh=3Wlb7khK2RbVA75NTw7l5pF8Wl1C+60qurP7o9q/Oss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7RTzS4BwzniJGOy1V7ZELL1/OKKn06TcnE7e5G11xMnoTz5t1VUEkkXOVbbsAOF5SkMwASPq8iucHXcwGnIvB++r77sgw5f6pIADGS0FCZDfDE41C1qItJRYFyBUXTyMOZNgbB0mMB56OiUnTk1ixiHvakJ57TpUo049I/18no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2TGZtT6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2TGZtT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739207519; x=1770743519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Wlb7khK2RbVA75NTw7l5pF8Wl1C+60qurP7o9q/Oss=;
  b=D2TGZtT6TwXg8wD0pRtSKr4r5B9M8coJoktbk8r0NI/css8AMWDj3CZ3
   Wnw4ZRqccvVRJ1Xwf6BVdUjU4RrkmXrPi8F+ZRhSmANEjRsAv+LKo/S+Q
   GPt4bV6SGrIEHerugdku1cb3OpBTtWr70g+3siIS4l5rinRyIrUcu7z5x
   SfhWj3cGBf56yiRii8p+TNT3sLDD85K4d8w+QasPy1MP7gXSkHHpTAcq3
   y3G3ibXYFGpTYqQZ+Oz30ee020rFpmGEq2s30eI3lI25G1YNYYKctZCNh
   zcPd0r0MKr8NLU82ntvGkKDUTAXQ93O8u8Ej16i/aEiAxiFnvIkTvFiZ4
   Q==;
X-CSE-ConnectionGUID: BC0IfMEhRBiY6MR2LeM4uQ==
X-CSE-MsgGUID: 7gjiP4qSRJyRlg2+eQsyew==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43725140"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="43725140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:11:59 -0800
X-CSE-ConnectionGUID: HrDfM2QaQPiJX4/hK/iTsg==
X-CSE-MsgGUID: y14rqQ0dQ9GxkcwHAuAw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="112001703"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:11:59 -0800
Date: Mon, 10 Feb 2025 09:11:57 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
Message-ID: <Z6ozXeOaZJMNRy3x@tassilo>
References: <cover.1738772628.git.dvyukov@google.com>
 <87ldujkjsi.fsf@linux.intel.com>
 <CACT4Y+awFXT2j+HMeAy2RKnoBzb--+heFzJUoBZWp9iJevy1Dw@mail.gmail.com>
 <Z6ZRVeoFxT0NV9yb@tassilo>
 <CACT4Y+bOVd4hw2fkE4ahJnbyAuc_=wMu_HMkAUbAhL--dTxBiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bOVd4hw2fkE4ahJnbyAuc_=wMu_HMkAUbAhL--dTxBiA@mail.gmail.com>

> > But yes that perf has too many options and is not intuitive and most
> > people miss most of the features is an inherent problem. I don't have
> > a good solution for that unfortunately, other than perhaps better
> > documentation.
> 
> I don't think this is a solution :(
> 
> I provided lots of rationale for making this latency profiling enabled
> by default in this patch series for this reason. If we just capture
> context switches, then we can show both overhead and latency, even if
> we sort by overhead by default, people would still see the latency
> column and may start thinking/asking questions.
> But this is not happening, so mostly people on this thread will know about it :)

Maybe something that could be done is to have some higher level configurations
for perf report that are easier to understand.

This kind of already exists e.g. in perf mem report which is just a
wrapper around perf report with some magic flags.

In this case you could have perf latency report (or maybe some other
syntax like perf report --mode latency) 

There are a few others that would make sense, like basic time series
or disabling children aggregation.

Another possibility would be to find a heuristic where perf report
can detect that a latency problem might be there (e.g. varying
usage of CPUs) and suggest it automatically.

-Andi
