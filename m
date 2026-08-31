Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D6476CD9
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197719; cv=none; b=dlEZ/pcbaXGlv3UIneqrNG2SpYRnawIKa4k+zDqC3SY3NkM5OvR3fgd5BCrVLwFf2Hd+Jwjto+bJmc/j2V0TbHdgEbgyK0z9lDKYnwMISlq0EAPJ1EyOAPA3HrByuf4sQrk+BIuXKCI4lLInUk1ZrBRI2JiQ8ICmj5EZCIHYLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197719; c=relaxed/simple;
	bh=c1yWASdiCI0Ti3RjiShC8xPEVoNiAUP0055Sw56I8Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InnCuWRDxYkCDRQ5c2CFCLIbouYwZqtuCAZUzBHbhPpQcUXHVC9zkFtHD+iAGhTu9dLXSznYJsxK+gnXyoSrvQHBa9ePXsykfGKO3Lk4YHokuRU+UUaUVIeM0jqaz7Ll7FOj7iOtISPscOVIKgkg7Ftu5t6PGMM+6ULkaxVZ56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUX7H+zz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUX7H+zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788197718; x=1819733718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c1yWASdiCI0Ti3RjiShC8xPEVoNiAUP0055Sw56I8Qg=;
  b=PUX7H+zzTAIM+bPayt7h49FQ0Bt4OrII0VeDbH/oHphJusPKP3AJccwM
   VnCGwwumxLAiWbh59y2tuToMg+mKl/+ucJTAQO2t4H10Q/l0uxBn9SUuD
   gSVRe0ZjCoQ1IUfYDg7i/Za/09R39mIaoypO/+/4sNnyR6rJReBeGo8yg
   Xvae8iDu807Zgj2ZEiVRBcO/60IXq2apItgmKL4JZYioG3uy9JQ7SOEQf
   F32QYN9nNPU1Ibzxk4PpsUUahvf2KHFget5EIsoJnq3JfmAAtCng+is5s
   ybU4fmtmfd0vOrgkh2irqIFDKLGt3o188mO+FmpxOWBb79HGo4yobHxPU
   w==;
X-CSE-ConnectionGUID: CiD8PeoiQCKu8xLD+AlVMQ==
X-CSE-MsgGUID: h4LKmlnTThiFiJFcwb38aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88635976"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88635976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:35:17 -0700
X-CSE-ConnectionGUID: QMR8T15sSnGLmhpjGwYpQg==
X-CSE-MsgGUID: 3/JXeut0ThuOVCMgFGJRig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="293691555"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:35:17 -0700
Date: Mon, 31 Aug 2026 10:35:15 -0700
From: Andi Kleen <ak@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/4] perf tools top: Add --weight option
Message-ID: <apW7Uy6QOvWEGVSE@tassilo>
References: <20260830193459.2840519-1-ak@linux.intel.com>
 <20260830193459.2840519-3-ak@linux.intel.com>
 <20260830194358.0584A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830194358.0584A1F000E9@smtp.kernel.org>

> 
> [Severity: High]
> This is a pre-existing issue, but does this code write out of bounds or
> dereference a NULL pointer?
> 
> If reallocarray() fails, tmp is NULL, so minors->minors and minors->minors_len
> are not updated.

OOM checking in user space is generally a folly anyways because if it
ever happens you're already in russian roulette with the OOM killer
killing you.

The right fix would be to use a xreallocarray that exits on error.

But it has nothing to do with these patches.

-Andi
