Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8DF4C61B
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632305; cv=none; b=f7+U7NNprtMs/KHTdYuMSSjcBzvDr8glxercxIsnLCnoU18+Zz6piCgMKmk2qB47bUaWJJmsGY9mcmAhaLI/bJyJ73wc6I+1kSJTkfgzrW3JEPkNduZm4Mi8ry0ovmvqGvtD2UpQDv6pf/FDg3Cz3PJiPI12zNcKvq0ipp6TOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632305; c=relaxed/simple;
	bh=z9nvhuouETIH65JXPX3MjDpO0lm6OqHMzFfA0ilf68s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKx67QJfnUqat3qofW+ZciCWEUJQ8ZbksXCHfy7B6ZmAPhN31BCsYaMipwXjx1YDuLGcJO59ouIcpdidGIUQymFr4mQil+r7U7Oc8B9nH+sISZ7ESqahId/FmyhVeR9obEuFOD1SP2jO8iK6YHDza9FpbMGt4OxyfBZLPo1uWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEu/IISO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEu/IISO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722632304; x=1754168304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9nvhuouETIH65JXPX3MjDpO0lm6OqHMzFfA0ilf68s=;
  b=DEu/IISORWtcOfLA9usVokEe5dTnXiClXZTc5dyEBrC0lZjy24vEa+8L
   mA7909T8iXNbRpUT4MGLFzwH2m+RCLfxW5RzY2Lld++ctAv2yBq7eAgXD
   s8eFgMbh15rt3mnn0ZuBuHGEi3bglQvQURTmA/5Dbaae2oQYULh/nSNzU
   9rzkEjj7r3usBLyCd+uDHW+IQWUGiYo5PlVxiU4PsHNRW/dzz6TVRaxLF
   kRYna1XESSvUFs98KsiPgEKN+pisf0V1FGb11e+c8XO8zii0vKZblYZ2y
   K+uTcDYJ0kXJW2pHySuXg4bOgw5GcPXfcHrFOwZqFsQPn4nh7kOOKdF/7
   g==;
X-CSE-ConnectionGUID: OYfrIdxZQAikHGVkqH+cXg==
X-CSE-MsgGUID: 3HQp0DbkRWahqZLNz0OqyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20803176"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20803176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 13:58:23 -0700
X-CSE-ConnectionGUID: loK9uErqThiTqULTzbUA5g==
X-CSE-MsgGUID: KAqR289TRgCww85V6yMDVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="60364249"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 13:58:22 -0700
Date: Fri, 2 Aug 2024 13:58:21 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Fix perf script -F +metric
Message-ID: <Zq1IbXj7oxBd7S82@tassilo>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-3-ak@linux.intel.com>
 <ZqLuWGKZjdUrkd0L@google.com>
 <ZqqRTKW80JJpNpRj@tassilo>
 <Zq0k1pRHZWB4N94a@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq0k1pRHZWB4N94a@google.com>

> > Not with leader sampling because the group is contiguous and output
> > after its end, with all the previous values forgotten then.
> > The other cases don't really work anyways as multiple people pointed
> > out.
> 
> Right, but we cannot prevent people to do that..  Maybe we can disable
> metric with a warning if leader sampling is not used?  Or at least add
> a comment in the code that it's only intended for the use case.

Yes I did that in the version I posted yesterday. It prints a one
time warning and disables metric output.

-Andi
