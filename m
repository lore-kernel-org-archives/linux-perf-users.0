Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5CFEEC3
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033107; cv=none; b=HRdZuRNH0uuSHF2L9rBjWGc5CU+wzyKzyQIgWD099RcRcKUlaOgJt1WfVGdhCfjoXqWYSXSkcIF6LPDwrcC5lam5t07WUvtC13knuhOCq9hbTB85dlNs1GXwq4Tbqqj+QpfTODd42GS7SqlTdL+/cfzeJ1JU0CmmGfQzdwDBtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033107; c=relaxed/simple;
	bh=SGKOVBuXPO+O90y+X/h/bGjWaW/mk7og8AWHApp8lTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwwYuM4usD/2bxgWO5E9XYglLjQhE2+FixwMY6nstynOc674PEcSvY72ly21kQHxMfAO+zzUSfmYcGKpTj+xVwlBA8EtJRtD5ngN9pA/Ff2AMYdQCiQr2f8T8uOZeyrhRvAbP/kOXh98brCGGMfpZe7vLLZ6xrcxes5/g05SW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5Tnr3/g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5Tnr3/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725033105; x=1756569105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGKOVBuXPO+O90y+X/h/bGjWaW/mk7og8AWHApp8lTU=;
  b=E5Tnr3/gGl+JPCTSHJRIXAceg0fKnUU/wnDVN35FX266qJoteimQmcYQ
   vRGMKRkeFsHDN+UjGboQHc06hDMdaTMoOULjxWwvkXdfGvCNwbO79Yzkj
   Zv5i8IiXEnrmlavv8aWMf4dJouj6ARyCZb1CN+ftZi6XQLgGX6BAyWHt3
   H3UvMcxK95WN6I7ABlGnfxjxTqgf6MRny4p/z9cKf9AUu9j75KzlBUr7X
   hPbXbka7+EtItxVH6qCjOzXI8Yx0X0vyL69yvcJjHsb2IoPcXAcy+xDBO
   rOyqWVTH5+810xWfXiwr5ETXpOCTgmEWQW7pvb2AJTAGyHnnDKaR8mBwK
   Q==;
X-CSE-ConnectionGUID: gkmg7xQTQXqCbno8nq/SDA==
X-CSE-MsgGUID: kvS8PrG0Qcy4dfyor5xPDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23246873"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23246873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:51:45 -0700
X-CSE-ConnectionGUID: uPa+i5OBSk6tzDhiVEXUMA==
X-CSE-MsgGUID: F5mPNWbZSeu87dQYex1mWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63552872"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:51:44 -0700
Date: Fri, 30 Aug 2024 08:51:43 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [PING] Re: [PATCH v2] perf, script: Minimize "not reaching
 sample" for brstackinsn
Message-ID: <ZtHqj6Rl1jdHJFKl@tassilo>
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

Yes.

> 
> Adrian,
> 
> With that in may I have your Acked-by or Reviewed-by?

It looks like the patch was never applied. Thanks for Kan to reminding
me.

Please apply it.


-Andi
