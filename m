Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7C679E5
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Aug 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724605107; cv=none; b=tcDxyqaxLVwTuwi53QCOSrhU+LS04D84sTPlQSStl7PxI9AK0rJw4YVEk1FgQSO+njR29HJoT1b1pWVyWZCrS/h6rLwD+KU+IcBUnuFovrm2pcTlrJN/0Pr/Pm8s9JOkkDk6ZrvIHd+6Lg671EzX+XqCnqv6L5vA7w6sSO5wcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724605107; c=relaxed/simple;
	bh=F9cQdm8eJsRPy/H3dOmOUrspDiEDxY2pFqLkpjgMPYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVfseQ6Vxwt6FCn4bCEPKom95M9ytARkQ78K4RQ4tbaIeMo648bnLFA8xh3JqgFF03BkReQnEk/PRCzhQtFyDrgN1R7t0v2tDBe8N8xEGY9cbUl+j0eD7zzRiOtk9Vwjza+UvcYLgpBtl4WkZL+sRVNSq40wPRorkobWG9OzALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGGoCmw5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGGoCmw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724605106; x=1756141106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F9cQdm8eJsRPy/H3dOmOUrspDiEDxY2pFqLkpjgMPYA=;
  b=QGGoCmw5r+zRlKnjoRVWQa2nQVjQDp5CMGS+ENK90GOnKynOxPU8tcaC
   479yBrdgp+uUj5ykb20q3+xPEIu3HW9MaF6GOMZmwZqq0FAfQqA4c8/zT
   CioJe09pxbmxTUL7t6ALba6za1rDCrFU9xI8ecE1OmhbL/ICavumq2evA
   wNDQZRIxz67ldkZ8PyvKSUNg6NawPLtJRnLiwkVLohAPj19/y3fXVJ1lU
   +rVbifrYBa+YSybwKaiUW48ccaODCppYD6W0CLr/LdeEGMYbshsbw/ItM
   OPLm1mXh5Zk31WtanNVRwJUuiAXXsv2c7VOA9M+/NtNwYZuGfvHDlhWYU
   g==;
X-CSE-ConnectionGUID: glPGMXyqQkebTUMypAZdSw==
X-CSE-MsgGUID: IDyr4CT3SbmJtG8ghgjVwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22914822"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22914822"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:58:25 -0700
X-CSE-ConnectionGUID: QMIanCVxSHyBnLDjD0eTtg==
X-CSE-MsgGUID: shiXB/8MQdWxiJalcAaqHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="66611348"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:58:25 -0700
Date: Sun, 25 Aug 2024 09:58:23 -0700
From: Andi Kleen <ak@linux.intel.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
Message-ID: <Zstiry-K_v51oDC4@tassilo>
References: <20240813213651.1057362-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813213651.1057362-1-ak@linux.intel.com>


Arnaldo,
can you please apply the patchkit? This fixes a regression.

-Andi
