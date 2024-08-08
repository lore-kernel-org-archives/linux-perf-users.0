Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCE13D8A2;
	Thu,  8 Aug 2024 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148831; cv=none; b=J6uSZVE3+zj3lcwsyFogYAPxnUgCaa1HRig8IlpXynX4ZZlUf4xs8knLydX327+NBFBrPklAODOeEkuwQg+Pc70P5+zaLh3sxUZx8zRh9E0iGRJk2VN2y1KiUW5U0OkwEPUJofmeLoTtJOFXiWxmHtyrth79yQn5ocs2WVX54dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148831; c=relaxed/simple;
	bh=SEETdzXsGLJjBMachZ8uZP2L2aFsUOCJw1Br58Y+dtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUcaf1lKTzyRGeot/JSjy28cVcEUndWUxfBP+p7gzwiohkz4RvoiffYa76d6KCHOyYDRTCSCDU8YfGolODiOrlrgGXUj1XVWdlwjKYor+h/5/cASZkXD/6tTIVQUeLO+3zB1x/+0WwBjXN7OTDgvGUi69qhdZLhiwww3r16bJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9dnm7KE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9dnm7KE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148830; x=1754684830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEETdzXsGLJjBMachZ8uZP2L2aFsUOCJw1Br58Y+dtU=;
  b=Q9dnm7KEQjMxHt7SAExhfaIN77PR6TRV5jF1bKfNvoqz7IiheZPtSWYB
   v93RdpvnLX9zb/jFiRjJhRNr23BJEGel4LKLhRvxZL+RbdHLWjL//yZjM
   jNEl0148g0bijLB1wBK1zWJMjeRTHN9RBtZzF4nhB6Olx47laPPw/atcb
   s+Z1SI9Git1Mln+WG5bWK3FqNJnYOOcmdN11Ruj7QOpTAdEIr6dpQtDzy
   gB8r/EciQ4jxZQlvefrD2nctq2XhaED/TukpLGsx2Nz+8bQ4PWfrQBgti
   w4EfYJee8AkmNYB8tVuQEcn9IFNuixuzz5ubMj0jNuuEERnHqT2fxjMVh
   w==;
X-CSE-ConnectionGUID: yrS834X9SdCW8qTNn5Kndg==
X-CSE-MsgGUID: +8OxnxjzQYyBlh3LCQMAGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32448888"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="32448888"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:27:09 -0700
X-CSE-ConnectionGUID: XaiJ0b99Sq2lAZZiX3khBg==
X-CSE-MsgGUID: gZWBjUzcQBelj7nZaDyR8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57306104"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:27:08 -0700
Date: Thu, 8 Aug 2024 13:27:06 -0700
From: Andi Kleen <ak@linux.intel.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
	peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com, eranian@google.com
Subject: Re: [PATCH V2 0/9] Support branch counters in block annotation
Message-ID: <ZrUqGkXkf7x1cCm-@tassilo>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>

For the series

Reviewed-by: Andi Kleen <ak@linux.intel.com>
