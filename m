Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2C54EED1;
	Tue,  8 Sep 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880254; cv=none; b=oV+ibeeFKTRzuedEuiAklwiQd8S6wrd4HhZGvUNzoD6DyrjNmweW1UShjWMYZtd8KByBSTQWAi7QmHis5fr2VRBIWGLUDPxHbLDD1OYskbLmXOAXFPz1p2c7+oNPY+osTUdHwJCtyAvHwQmq/bk5W7mbO5CBreXR55zade6FbGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880254; c=relaxed/simple;
	bh=9QYQ9nMM/aKr2UyVmYnvFe7I9uWr76ewhQhCJOV1OVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKSl6CAYLGONTD7RSptOATxD/fxNvjvUmjyevGvJcabSF49cNSxhXxbXdI/hhtvw3+U//NT8S/1uIQBxL4oGCOhOS2K5ylgETsaxRCf779DylGIYIG6s5NtR6qJDeb2qENn1RDa+BYUt+js+ObN+rDiQrWSofflOMRXtj2zDgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROTEQw1k; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROTEQw1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788880251; x=1820416251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QYQ9nMM/aKr2UyVmYnvFe7I9uWr76ewhQhCJOV1OVw=;
  b=ROTEQw1kXHEsWw/La6w8vP2gYjSi/wzCHWvW//tlQAZSdo/Ei/kFf0eO
   wopb0f5iCOXr7wSTcuoXxn4w7LOhVUq43fDKIZOVr7yv8FcOgHwU0M132
   e+jfZZEPMRgOs7tscIsK1WWPZ/WK//ggSEUb+AyRp4OW2KWJG+0FHKGaW
   bT+vK7aFOGvemkgmIKva/hxaWHsER6k3wHQQNVh2M78v1FH4sDZzTVsVW
   wE/egR/dySez/pxhL4IluFtcoOHTAqydhoBwYU90jUuvHJ5BIqAgiairv
   IQeqZgZlH1D2uAxcBYnpgVTF2zpCBmXcQylkd8JWdkHb2nhz3QGZHy0kI
   w==;
X-CSE-ConnectionGUID: A1xXS2sKQSqHFcPxTLlDCA==
X-CSE-MsgGUID: eIjtY2BQQNGBfieZ5pGzFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93149851"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="93149851"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:10:48 -0700
X-CSE-ConnectionGUID: Pk0RRqcaQY++2luieP1cAA==
X-CSE-MsgGUID: KhrH9Xc2QWWldh3dxIAXrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="264828051"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:10:47 -0700
Date: Tue, 8 Sep 2026 08:10:45 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Gennady Kupava <gennady.kupava@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
Message-ID: <aqAlddsFPYJvRhFr@tassilo>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>

> That's what we already do, no? I have distinct memories of making the
> stack unwind use the NMI regs rather then the PEBS regs.
> 
> > In my opinion, it could even make the thing worse. User
> > requires to get precise samplings, but perf silently returns imprecise
> > records, this would mislead user. 
> 
> Mostly just the unwind might be off a little, the rest is accurate. This
> has been the case 'forever'. Performance analysis isn't for silly
> people, if they can't deal with a little fuzz then perhaps they're in
> the wrong business.

Is the main problem that the stack doesn't agree? Perhaps there
could be a check for regs->rsp == pebs->user rsp (if in user space)
to detect problematic samples.

The question is how to report it and who should do the checking. 

It may need new fields in the ABI either to communicate the extra PEBS RSP
or a bit to indicate that there might be a mismatch.

I guess checking in the kernel and reporting an error might be simpler
and maybe cleaner, but it would likely limit more advanced recovery
possibilities.

Are there other mismatches that break the unwinding? Perhaps the same
for RBP?

-Andi
