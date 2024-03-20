Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D515B3
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894937; cv=none; b=fLv2wR/sdjfQ8ecjIJIhmAOL3lO/Agk2nqipUPqhByR73f215aR7cvbeGphH6fzCmBZloAQACvYLL1XHYYbPr9e0Cw3X7N1FqXN64B0D3VFm4TjGUFQIY1niMnkfSEF4l61rmz11mNtJZTgb1o1cb+cTi/2OTJZXpXFEyK4P5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894937; c=relaxed/simple;
	bh=1ekwuOjckgT/DWJAorZ2U6shHkcN9zxUZXtFIZbO6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwDIDfSdv8X0GQqZzHN/CCpUNnMSBT62g+ZPHFhcwPbqnUIar70u6asqB7RQhvy9a0YxWzGB0ShDPctTLD4qiE637dbfSlQBYzPXpgokUH13hbRyDWGns2deG4bpraJylWJ6Wp/IMDFKCjMP24dQrfMU2y+YbEYK8qFyh9EX4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXc8uLlP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXc8uLlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710894938; x=1742430938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ekwuOjckgT/DWJAorZ2U6shHkcN9zxUZXtFIZbO6aY=;
  b=DXc8uLlPVJWjy2tp+BqfBCVXEro3tPir9muiqw7/ZkVQFitDEFD+D2zG
   4BYKuMP4ZvPSOkmqcZBf7+19aPu10nicK7v9tTiSeeksR1C/vIQCeCcgK
   7qquGenbbjX05GCWLb70Rxuvf77alXzHYP8oTWa40ONLg9u8mRR5Pydfz
   WRjho2SrypGUpSi8fVMSO0tM3ogM1oW8W4NdarpXtJShD3AeehEhiXzqW
   WZobFP9kIkUnQi1Oll1AvTgGJ4RixDm0P/VKm0XAWjCM13X3DTyKdbemY
   0CEF6RJAoqzxdcRKoepGWZHW1ncm4VYPX4CZszPXn7QFD0QivIJlRlrgl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16345327"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="16345327"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="18567091"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:35:35 -0700
Date: Tue, 19 Mar 2024 17:35:34 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, changbin.du@huawei.com
Subject: Re: [PATCH v4 2/2] perf, script, capstone: Add support for -F
 +brstackdisasm
Message-ID: <ZfovVgjCm5oDbze9@tassilo>
References: <20240308170611.719794-1-ak@linux.intel.com>
 <20240308170611.719794-2-ak@linux.intel.com>
 <bd71b8f5-bf56-4af5-bd55-deb12cc01415@intel.com>
 <Zfi6vkODkhWQpHJJ@tassilo>
 <fcdb6a82-30bf-4da5-a898-bba3c0bbc592@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdb6a82-30bf-4da5-a898-bba3c0bbc592@intel.com>

On Tue, Mar 19, 2024 at 08:52:33AM +0200, Adrian Hunter wrote:
> On 19/03/24 00:06, Andi Kleen wrote:
> >> Better to factor out a function that does not depend on "sample"
> >> e.g. see fprintf_insn_asm() below.
> > 
> > this doesn't work because it completely ignores the need of the
> > cs_dump_insn caller for the path that i actually need for my feature,
> > which requires to return a string.  I didn't apply it.
> 
> I would probably change the call sites because they already have a
> file descriptor, but output to memory is doable:

> 	FILE *fp = fmemopen(x->out, sizeof(x->out), "w+");

I considered using this at some point, but I'm sure there is some non glibc,
that people build perf with, that doesn't have fmemopen, so I didn't.

Can we just use my version for now and if you prefer more refactor
please submit a follow on cleanup patch?

-andi

