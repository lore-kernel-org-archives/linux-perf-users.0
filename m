Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A528FA
	for <linux-perf-users@vger.kernel.org>; Sun, 12 May 2024 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488896; cv=none; b=h+XyEfxNqyOARfCjyIeeW1AGYQnrXhJ6yzTdzvdnMsqiyE0rfFio4U1GeKOFQyl21Y6/h0ldMSiN1BFsE8wyNkvkd8G/tz/N9SNCsKyZWcUVm8MRv49T2JmeX21S2YQ+5bxPDH8xGd9ftMUt5BJrDofCMc5xorNDWASqzftOJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488896; c=relaxed/simple;
	bh=riWyyjz+iLmdkHfcgXuNaUyjBiBRD7zzd02QjL8p4Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqEUzvlzuJLZBUPzxQllsamwQ5CBgaD+pRxU6k8guz0OpMfCNbgizGqRsgM7lwkCwv+46WZYv/ZT1KlbCEF8M2Z96ewmmRwqan0lRbN+LyDv3K3LWm58Nk2FyI9Yne+3fvQOkT5IDSZ8FLYJGwLXG4naP/lubBNBJOrNFWBmPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WupqAw0L; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WupqAw0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488895; x=1747024895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=riWyyjz+iLmdkHfcgXuNaUyjBiBRD7zzd02QjL8p4Is=;
  b=WupqAw0LTb8jIwYNRIVm8NmBFPDeZHB25i2U6Y3DJ+AomPQU7g1mIF+j
   800zNhYYHoPUhzSTJ8NwNapXcwf6YmtFt5OHrYje9577sSYuZTEG9+HDn
   gDRmhRtVq9TfVARvlnL03JMHT6pGSAdpLqzXKea/6qcxdCIOll+iUTypn
   2iF1kC1ten1kS6I4Q6JFsG5C2CSQL8gVwBLkEqIkW5ym6NgIkzxPd6MB2
   v/7wrnCC6/jXuRDiFtIsCVQekM7GjV7dGVFhJI0CGngFdRKA12/GWlsMU
   w/FyrhX3Y+Gi0i39rLoJYBB8tMDRYJDjZhJKZLC9f01GvwEW7eXa8Wpfe
   Q==;
X-CSE-ConnectionGUID: EBCmetR7QAWNupxGQXGF1A==
X-CSE-MsgGUID: dGgnifT0QRaTtcrD4QkkVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11279588"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11279588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:41:34 -0700
X-CSE-ConnectionGUID: UzlumjraQ0u4IZwTEjc7BA==
X-CSE-MsgGUID: SNnz+7H9Q8icbInRUFPJtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="29867206"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:41:34 -0700
Date: Sat, 11 May 2024 21:41:29 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [PING] Re: [PATCH v2] perf, script: Minimize "not reaching
 sample" for brstackinsn
Message-ID: <ZkBIebCF0ZCJFYe8@tassilo>
References: <20240229161828.386397-1-ak@linux.intel.com>
 <ZjvhQbZhsda_kvy6@tassilo>
 <Zj4zfpmJhbXGrqRS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj4zfpmJhbXGrqRS@x1>

On Fri, May 10, 2024 at 11:47:26AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 08, 2024 at 01:32:01PM -0700, Andi Kleen wrote:
> > Looks like this bug fix was never applied. Ping!
> 
> There was a comment by Adrian, about adding a comment with some
> explanation, may I add that to your patch while applying it?

Sure feel free to add anything.

-Andi

