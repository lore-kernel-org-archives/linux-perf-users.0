Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C37440658
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201140; cv=none; b=B9XCXCrULlSF25n570m8WEQs+cNHBbeYma9mdXb0cOtAxDWXAm1gcRkcZl4Qsm8vODhusjSXx6Ggnx7JAgt4AiN6JqgkzY6CxPl9MNOTvsyCGt+3QYsY5ZlZtW5uSOjiVFeKGAi0ZDwH7k6+uz0Bf/LddJ+Ib5aNSdlzQXJ5b+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201140; c=relaxed/simple;
	bh=PyI1G3T4D6VeQE6PkuVihP1gMvjVuAhGk2hxqN9VmLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azBZy62OsvNgCsNXd8FdSANkWF2qFppn/eBaqSO+Y4dwdib1DdIi79YaD/O6tOb0LUN5sA4neG3qyknjg765IKWOf2xX5NXxneZW5dMTeEtZyqGHvYMIazfGX5IOa+SrIjuGwcyoXg/6quFqgMs6xarPxmjWVc5EZH1Yt5NZIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kf0PTUlT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kf0PTUlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788201139; x=1819737139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyI1G3T4D6VeQE6PkuVihP1gMvjVuAhGk2hxqN9VmLc=;
  b=Kf0PTUlTgJ5+rer/dgUuH4bdv8bJcqkoN7JQowItQZRRkHNzw0gE3WbL
   GqK9w+7/HjkkpcuP3Q0ojmxZJ4fofdAMG178W7mDWsaZQG3r76oJFb1v2
   5zHhAYD5fXsjKPdtnhmEZLnnS7O+/8kT3BYDUsl5yj0eRWdsC76LGD2YP
   +cbn6sD5DIUg+jPL/hXdZEuJtHjjOZGUAsSElP4ja3oBFTC0muzh4s0GU
   wQp3mz+LPZNH3dJGc0i8ELZmoY9mg3+gZ0bCa7gdEVqyQCJND+dBFGvIj
   BpRooPc42I+/tgcT8jvhUh4wN13f4I6IBcHb3GY0ZDJiCCeyhR4ZidViz
   Q==;
X-CSE-ConnectionGUID: oOjGQ2j8QUqoGjol88Y9Yg==
X-CSE-MsgGUID: gRDrQq/VQAGrhy9bHK3EHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99968233"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="99968233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 11:32:18 -0700
X-CSE-ConnectionGUID: 89TrJ4A0Rrai0xKKDMqn5w==
X-CSE-MsgGUID: gV4CphbmRGm0AJF5F8LBAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="266285562"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 11:32:18 -0700
Date: Mon, 31 Aug 2026 11:32:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 4/4] perf tools: Add test for weight annotation
Message-ID: <apXIsKodLYUnxzLk@tassilo>
References: <20260830193459.2840519-1-ak@linux.intel.com>
 <20260830193459.2840519-5-ak@linux.intel.com>
 <20260830195633.BAAC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830195633.BAAC31F000E9@smtp.kernel.org>

> > +# mem-loads:pu requests a precise user PEBS event whose sample weight should
> > +# be populated by -W. Unsupported PEBS/weight PMUs are skipped below.
> > +if ! perf record -W -e mem-loads:pu -o "${perfdata}" -- perf test -w thloop \
> > +	> /dev/null 2> "${record_log}"; then
> > +	echo "[SKIP] precise PEBS weight sampling is unavailable"
> > +	exit 2
> > +fi
> 
> [Severity: Medium]
> If the inner workload (perf test -w thloop) crashes or otherwise fails to
> execute, does this conditional block improperly catch the failure and report 
> it as an unsupported hardware feature? 
> 
> It looks like any non-zero exit status from the child process will result 
> in a skipped test, which might mask underlying environment or test suite bugs.


There are other tests for this, so this is acceptable.

> 
> [ ... ]
> > +	echo "[SKIP] PEBS weight sampling produced no nonzero weights"
> > +	exit 2
> > +fi
> > +
> > +perf annotate --stdio -i "${perfdata}" --symbol "${testsym}" \
> > +	> "${annotate_out}" 2> "${record_log}"
> > +
> > +grep -q 'Percent Weight' "${annotate_out}"
> 
> [Severity: Medium]
> Since set -e is enabled at the top of the script, will this isolated grep 
> command cause an abrupt and silent exit if the 'Percent Weight' header is 
> missing from the annotation output? 
> 
> If the string is missing, grep will exit with code 1, which might instantly 
> abort the script without printing diagnostic output, making regressions harder 
> to debug.

it will exit with 1 which makes perf test fail I believe.




-Andi
