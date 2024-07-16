Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB418C8F3
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100809; cv=none; b=cgpKA+LrOE/6Kaaq+7Q7fk0SYPdp/ogAvsxNOJpNYxvxiSgiKLd27BekbmWeLFwBiSqxnrjG6aaQHw28G+7M+wXbEYuNmeMO1/kHNtGcujSM6uC7HaFs14g/o6JGiwmRiAdtOfNsmZ3sEpXQBSYKwLclj/eWW7cIyJ4COUP9hVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100809; c=relaxed/simple;
	bh=INxwcBlYxa4WxD5b24iLgys8iWpTPHDEkf8WVppDTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hESsK63xDa7aDmMsizMAuUakgmNFLU1bX4/gtYyWIUakbMmDi9JvBxsGwl7R3pdHLmEDs0TtfgrOadojHEWO/6vnCKlcXp6/MxtTDr3MJ0Lovbi2B+kc1ht4I8FkwwQO5i1tj0LSXYPUJf5t+yozKfGQ5KPnTJoUH2W2Q15TYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBbM8e79; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBbM8e79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721100808; x=1752636808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=INxwcBlYxa4WxD5b24iLgys8iWpTPHDEkf8WVppDTeQ=;
  b=aBbM8e797+uwlNy7BprHQqt9O0+SGxRxVrr3pE1h/FFpY8O4dG47GU8I
   y3fuH8dzak2TxXimDbFHhmQWe0N78vR/G2EE7xPyqmDr1TLdcy47v3HyR
   kNVN/r+q2Ea32mkIOcD9xcI/o0gsFWmJptmr2l+uU3Ris2RYEZBe6sggD
   /WFS44inwAjQUt86nzJ5cH8ecx5CUnfyCBn7JkGq9dxS0oHHLYXuTEiDP
   fm0ujUziwaIDoI9SFnhfW0QDKvh5j/RpvdOO0sq34k0H6geznjFLiExIr
   f6oX7MOyLk/oc0fjEshW6iXHjoAlMX6xvm/92zRNSoO+i6bpt9MFrmQF7
   A==;
X-CSE-ConnectionGUID: OZtPHY53Qq2QVqblQvx42g==
X-CSE-MsgGUID: VPzPzl37QWGq3O0Z6ET9Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21428867"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="21428867"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 20:33:27 -0700
X-CSE-ConnectionGUID: 0PCIfcwOTOiDlcR09jOjrA==
X-CSE-MsgGUID: u5M01J2lRlCNacocdTrviQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="73092799"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 20:33:26 -0700
Date: Mon, 15 Jul 2024 20:33:26 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf script: Fix perf script -F +metric
Message-ID: <ZpXqBqxUt8khEqgz@tassilo>
References: <20240713155443.1665378-1-ak@linux.intel.com>
 <DA123DCE-7607-45A8-987B-34F42B3D9E7B@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA123DCE-7607-45A8-987B-34F42B3D9E7B@linux.vnet.ibm.com>

> I tested this on powerpc.  It fails.
> Version 4 had worked for me. But version 5 fails with segfault

Thanks for testing. Looks like this fix is cursed. And clearly my perf
test runs are still not working. I usually try to avoid installing perf,
but you have set some symlinks manually and use a special directory
for the shell test to work and that is not reliable here.

I guess we can exclude the two cases for now (perf stat record vs -F +metric), 
although it would be better to make metrics work in both cases.
But changing the stat code to support multiple aggregations at the same
time is too much. Maybe if the perf metric code could also use
AGGR_NONE, but I don't know how to make that work.

-Andi
