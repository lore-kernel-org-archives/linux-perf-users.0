Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341D713D315
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162808; cv=none; b=R+voFMEbglkpaL8f+0Gh5AWq1be4Nb+nvKAXQ9kTEoJK+qrv5bQOimluDyAkhv43WhUnlOEYFoc/3j3YY5RPPYtKx0NfK5qJW3ntdKXIvx+RBJL2S/xlEJqL7I9NJMjnHj7suCXtuZNd07uvJik1CkHv0qwPhEwLR1WmaOYyo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162808; c=relaxed/simple;
	bh=65w+YzgVXun3m8u8ykD6rH1JZ5H7FTJU/qDyh/F7L1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeq+1Nhz/YSkm13UY3P6vda9gvUy9PvLcmVSmzP7GVdzlLd40u+Yg8FoLGcCfbug+RLgVzv6jpDI7ZQwqwObMWPLJI9r7mEfoDdUsGuK7UwPfCFmNPr8dwL3LUcRUk5tp6okDklZkwZYbCdXaKlfcoXT5obrunzSvtu8YzejgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuY+ExYO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuY+ExYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709162808; x=1740698808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=65w+YzgVXun3m8u8ykD6rH1JZ5H7FTJU/qDyh/F7L1E=;
  b=MuY+ExYO3KKSZFzlQuFHdq67Fxsaz7jsTBQGU56tmV5HsDUBqzelS2rX
   +bjOJX/A1qcNVpKI+iSgld6HUnnE1+oTMssRqh6mJ/XxJUy94IrVlqIZB
   tBR0HRKOVZdWVKmpy5uss0eP+E9K4/CDDWvsAyiNNrwMsjK+nqT7qZMGI
   yl4ZOtLaAxyxb0uU6SWrYqNCNO57sg8k4u1le4W5jxNmJH8R5tsPzKpTQ
   h3lOvxvyBVN65fqX4GjhUroSqjEzmxBUsfu8UIjaBb1OyHEZzUPkm6gUr
   7P14j46jiRAMFpuSyl9s0vqI8WoVnp3z13hspQVkfvRyyblsZS90KnqkJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="15042366"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="15042366"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7546928"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:26:46 -0800
Date: Wed, 28 Feb 2024 15:26:45 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [PATCH 2/2] perf, capstone: Support capstone for -F +brstackinsn
Message-ID: <Zd_BNTUXymIpPiPV@tassilo>
References: <20240227234806.82694-1-ak@linux.intel.com>
 <20240227234806.82694-2-ak@linux.intel.com>
 <20240228110534.mradyavqgzfln5mg@M910t>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228110534.mradyavqgzfln5mg@M910t>

On Wed, Feb 28, 2024 at 07:05:34PM +0800, Changbin Du wrote:
> On Tue, Feb 27, 2024 at 03:48:05PM -0800, Andi Kleen wrote:
> > Support capstone output for the -F +brstackinsn branch dump.
> > It is only enabled when -F +disasm is specified.
> > This was possible before with --xed, but now also allow
> > it for users that don't have xed using the builtin capstone support.
> By this, 'disasm' acts as a flag but not a field any mor

Yes that was intentional. 

You would prefer to define brstackdisasm instead?

-And
