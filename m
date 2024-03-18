Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B558AAF
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799568; cv=none; b=BS+6dp9qsF+x9ZMJ1Es9ndswTL3nffzo62GRGm9su7wiBguiw7k0EwmXA+MtfbrGxFlsDkf9247trHtuKqe+nVrntH2Ut72rk2M0jTAZJPK2GXjzeB/AbOUTcrCSoKu4sMjPRQONUr5G5cJpalgVAFwFXjBGNV/4OFGnOn8nmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799568; c=relaxed/simple;
	bh=tP0YxIJkoozmXOw8KR0WFvHVmVmQSOtUyea5ICfI87o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/AN/biEO1qTU4PRXUjkNUcTVX6lIyy/6QPooq++HRBChNL3c1gOriGf2ZtjkMSgdSmoSLC52iKV22nLUflH3ZJ7jhHPzw6JHmC+oMcNKbtKtoQrorAqFVea3VC/PCF6KXw0MnbKA7tjiC2YVwK+R4WOrGKqAsmLBp7Tcmv5eyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3GnJZmv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3GnJZmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799567; x=1742335567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tP0YxIJkoozmXOw8KR0WFvHVmVmQSOtUyea5ICfI87o=;
  b=L3GnJZmvJ4ymNMP516my6pWz9NdWVlWSxHqkLUIzykg7n7ZWUJxqbHpl
   4jCg4TVPHK/DDvDBIw4t8n67JnN8hVKiAtMtCA2s4YEjt8lv1xGkGzlnA
   WTqQbVlMSPrvjfjfgC3iCFPcYuDetQSGaq4qbX7RSJnq6GIGm3K+5CcsX
   p7XoKSYWnxRNnp23eJsy3QWkmdpU1z0q5xjgWde4lALAF+lWfwZmAlz5V
   hzd/+QkdvOITwFm4cv1lsOIf7DRwYWOfoTOHFrFlI7DEQYmbPCTKsEhLw
   uZ9Xj/fTQt+xIivpNcFP+pavUItf4fucy1uyw8yAwl9Xtha/F33zIoPWw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="8584263"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="8584263"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13581538"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:06:06 -0700
Date: Mon, 18 Mar 2024 15:06:01 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, changbin.du@huawei.com
Subject: Re: [PATCH v4 2/2] perf, script, capstone: Add support for -F
 +brstackdisasm
Message-ID: <Zfi6vkODkhWQpHJJ@tassilo>
References: <20240308170611.719794-1-ak@linux.intel.com>
 <20240308170611.719794-2-ak@linux.intel.com>
 <bd71b8f5-bf56-4af5-bd55-deb12cc01415@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd71b8f5-bf56-4af5-bd55-deb12cc01415@intel.com>

> Better to factor out a function that does not depend on "sample"
> e.g. see fprintf_insn_asm() below.

this doesn't work because it completely ignores the need of the
cs_dump_insn caller for the path that i actually need for my feature,
which requires to return a string.  I didn't apply it.

I did the other fixes. Please no more pointless refactors

-Andi

