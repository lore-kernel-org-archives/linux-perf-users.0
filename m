Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF506FC5;
	Fri, 14 Feb 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556323; cv=none; b=XH0NSAoKijq5n58qRCi/frtnI1G9qtJ1nK/omCdcG67CSzkK3Vt/cYxXxM+MitPYczBX5bvFwGi6a6mukED5WdkVooZqjYQXGczunAJROkH5BI3yP/QBAEDiGvtnnAIbvsdaulIHQBTHXxrR6keaXUFD3AtN3bP8yHBkNvQUt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556323; c=relaxed/simple;
	bh=U/5KNCjmmxbPQLiOGusLqmw0uEnG/qtoUpSRDMK4wvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im20xbccTzlW24t9gnDFiUx7aCHaXHHDQxs3LbuAF11jsf/j2qvd8Ez5hXWJ5JzAIz+X0wdkx2rQGgoiFXCDtBy6hkk0JOMAyc6SdMKqZh8DGFCquUFsL6B2j/AYJ4lKg8f3FixFYodFMnpnU8cHpBIsuFk7PuF2yGjhg1SaRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU4EfdfM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU4EfdfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739556322; x=1771092322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U/5KNCjmmxbPQLiOGusLqmw0uEnG/qtoUpSRDMK4wvs=;
  b=PU4EfdfMQq1eeUcYmVcsXRVP/fWjhpA+rTXuv/aoWg2Oy/2hexu64Uo8
   DcVo3+oLkY8Px74rn6IR/IGKsuR0zS25CtmqeBS3CwftfkZA7i9O6YXWY
   gdaSrxBmL4xcJDZNjkDSKnvOogtnqf9gep2hu81rxuQNm+Y8SsmeMwu/g
   /cqsfSdCBjpK7Usq7adv1/mAJgElwdSm2YxEh+28t+Z2HAo2jbdks8UhP
   GddNhMbPUGjqhy0mxMZIBpdS6mWspvnBng1sVWwqdOEUs8L4KqsCt1pIf
   CDk9/D2srPbNan7aJsTXEO09KnJ6XDGn1h+mGz4q4fYkQfUYeHRsuimUc
   g==;
X-CSE-ConnectionGUID: LEvpkEnKQy6O90rsJIKIcQ==
X-CSE-MsgGUID: fl9NDyu6R9mUZVEI5VdFUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40580911"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40580911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:05:21 -0800
X-CSE-ConnectionGUID: 87SwqQWLSqWIZVoP75YXhg==
X-CSE-MsgGUID: ZEwEKscbSXqJmgxeSxIi0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113391276"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:05:20 -0800
Date: Fri, 14 Feb 2025 10:05:19 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org, irogers@google.com, acme@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/9] perf report: Add latency and parallelism profiling
Message-ID: <Z6-F35N8fkhTvagn@tassilo>
References: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>

On Thu, Feb 13, 2025 at 10:08:13AM +0100, Dmitry Vyukov wrote:
> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.

I read through it and it looks good to me.

For the patchkit.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

