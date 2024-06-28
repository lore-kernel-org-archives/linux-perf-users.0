Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0714A85;
	Fri, 28 Jun 2024 04:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719550532; cv=none; b=lyf07cr7itvaukuhZ3mopVnGWW6nVa+dVjwAZeReyb6vgWGjOLj7knxlWiMIP0BaSfH8IntoThWcgk0QRxq2Bn81khGEUGlB+HTcP+uhjleg620PT5WyZwnAosuBr1XTMD3E+QIJc4cgkT6H3xXsC8euUY7ROTjk81rIeAWLTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719550532; c=relaxed/simple;
	bh=qPily2vNcjUCKxyzaRd/7YcLkUbD8qnthkRccsCu3DE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3sg0uCzYvhwzjOWGFyIjaBb6KJvyHclqjdNO1zWk02vhwkkbVd9Z1RJibcP050mnjihH8w3sPzqFechsYDemgK88Tv+s7j+gATsNp9tsCehRpTY/+PEcnttbW04fxKt1+eR5oXRkH0gia5BHkXeCOg90MhmKH1TvWeje9oWriY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om1pvslR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om1pvslR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719550530; x=1751086530;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPily2vNcjUCKxyzaRd/7YcLkUbD8qnthkRccsCu3DE=;
  b=Om1pvslR9aTujhybJTfFBQXg2no3ImwqvqpfDgj6dlAO9q9VIpGYSd8y
   btB/9U2/3FMMn6c0eHCufJa1lS/1SM+jKaXA2GN7vsqxK5AYX8foqX3ZH
   y2N24xn9cuGEhcRS1KUPNLTbDRCyhAYiuhRvXYXu7h+93VqrXxCYRnvsa
   h3q8O8CjB+2KpeB9n39e6CwSVu6o4xxI6/9FfsY656i+tZQAL8qpQ2v+5
   o6MCmP01mLmjpS9TBZtXJ9acnQLoMq50/WnwIgLCKZ2E2cxLroF1GC7Gn
   eTlxig8ypanDKXD6cKk8IkoIpgk7mJq9hoQdUvp/wfWOz5d+HJL7jTG2i
   w==;
X-CSE-ConnectionGUID: sfzK3gxUT5i62uobVJXUeA==
X-CSE-MsgGUID: 2s65ghChSD6K0w6R/wA3QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="42136769"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="42136769"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 21:55:29 -0700
X-CSE-ConnectionGUID: gEwBv7+AQ5+WaNbDXI02Lw==
X-CSE-MsgGUID: u9Rc2cosT+CJ+TJr9ANRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44456092"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 21:55:29 -0700
Date: Thu, 27 Jun 2024 22:00:40 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Xin Li <xin@zytor.com>, "X86 Kernel" <x86@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 <linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
Message-ID: <20240627220040.1897cde7@jacob-builder>
In-Reply-To: <5c1f24aa-79f0-4142-80b2-f13c41b91d76@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
	<20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
	<de99f490-8b8d-4ae9-9f87-e0336e563aba@zytor.com>
	<5c1f24aa-79f0-4142-80b2-f13c41b91d76@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Fri, 21 Jun 2024 16:00:47 -0700, Sohil Mehta <sohil.mehta@intel.com>
wrote:

> >> +config X86_NMI_SOURCE  
> > 
> > Lets reuse X86_FRED instead of adding another hard config option. See
> > below.
> >   
> 
> I mostly agree with the suggestion here but there seems to be a bit of
> confusion regarding feature availability and feature activation.
> 
> Availability and activation of X86_FEATURE_NMI_SOURCE depends on FRED
> but not the other way around.
> 
> In other words, CONFIG_X86_NMI_SOURCE would only be useful if someone
> wants to disable NMI_SOURCE even if both X86_FEATURE_FRED and
> X86_FEATURE_NMI_SOURCE are available on a platform.
> 
> This seems unlikely to me. Reusing CONFIG_X86_FRED seems reasonable.
agreed, will remove CONFIG_X86_NMI_SOURCE


Thanks,

Jacob
