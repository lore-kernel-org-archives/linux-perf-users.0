Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE02837F;
	Thu, 27 Jun 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526694; cv=none; b=Yx0roPm6w3NpyE5fhOmACJi6Ndbc12bkphWzQkXOGRj7ig5PIBTxLCJYFjAnLkezrb1x4t6LoCIZEi9wzF5W6LGQvIg2PnR27SeJoHV/0s2Xz9z5UWvzWv8b5jGNiueNOhx7czo2GxJR8fEG6TDG/+/HurNYAYafTgajkNQlROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526694; c=relaxed/simple;
	bh=798SLS/Iw0zEG0OBQgbocKIte0Gk95Vl9PG1Bk3w/U0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKjeLu65TE5gBRLaxZcdPx+xBRZeyqivXNbRCx/nq5QQtAsCkZRE7omtZihRKXsR7G7TfcptccBPPNJ6eE/5Hg0RLkDfqn0g+6802fAVcGHBzUA1TblNu7KLED40cdk2wYYM/qVOm75oz+oHxKABC76Pu0vCnkUrcTI32VkkaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L46nkxfl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L46nkxfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719526692; x=1751062692;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=798SLS/Iw0zEG0OBQgbocKIte0Gk95Vl9PG1Bk3w/U0=;
  b=L46nkxfl15WPn4S5IyCOwfPiisXoK6Q6HxeHVWWkymT045Zn71FK4Cxs
   jwzll/8OgjHH3uBrkxQH9LkmkiJlHpfSW9dcw4tS5lPWpxTaIsSiyvm6k
   Q5+Lnok9LZUO36tubCVMYC3nok8mv6IZYUYM9e9btmpj0p0S2RFZsUvIf
   YrRWcoxXVyI83QHTQDWSUwLIJ0zqyvLJszVUfNwjAO7//cMWMkTQQ6cg9
   T+L1Br5HEt16ohpFebDTA5SUcPD1gIqJjchd9qdU3cv76Dd18bALn+0uE
   803AymsvmtUrhBqqo5MzOM3ivxVWFRKQoe6P6ztATD2NZ9muXeWUN59my
   w==;
X-CSE-ConnectionGUID: Jz59CrcGQ8i6xkGmjbiqQQ==
X-CSE-MsgGUID: BgeJWbpvROabnjw1WTn5iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16572803"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16572803"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 15:18:12 -0700
X-CSE-ConnectionGUID: yfUl4xnVS+qufN3l1zUNQA==
X-CSE-MsgGUID: czu3RS6BQRSCCwsTHeJP0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="82078302"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 15:18:11 -0700
Date: Thu, 27 Jun 2024 15:23:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, Dave Hansen
 <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 <linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
Message-ID: <20240627152102.592a20f5@jacob-builder>
In-Reply-To: <004f6400-0d35-4c5e-ad31-094be8860f08@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
 <b3b10d29-857e-402b-95b9-1696baa88e81@intel.com>
 <20240621164615.051217c4@jacob-builder>
 <004f6400-0d35-4c5e-ad31-094be8860f08@intel.com>
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


On Fri, 21 Jun 2024 18:08:14 -0700, Sohil Mehta <sohil.mehta@intel.com>
wrote:

> >> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
> >> b/arch/x86/kernel/cpu/cpuid-deps.c
> >> index b7d9f530ae16..39526041e91a 100644
> >> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> >> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> >> @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
> >>         { X86_FEATURE_SHSTK,                    X86_FEATURE_XSAVES
> >> }, { X86_FEATURE_FRED,                     X86_FEATURE_LKGS      },
> >>         { X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS
> >> },
> >> +       { X86_FEATURE_NMI_SOURCE,		X86_FEATURE_FRED
> >> }, {}
> >>  };  
> > If FRED is never reported by CPUID, then there would not be any calls to
> > setup_clear_cpu_cap(X86_FEATURE_FRED), so this table does not help clear
> > the dependent NMI_SOURCE, right?
> >   
> 
> I thought there was a common function for all features. I expected it to
> go through each feature and clear the ones whose dependency is missing.
> But I can't find it easily. Maybe someone else knows this better.
> 
> However, anytime do_clear_cpu_cap() is called for any feature it does
> the below and scans the cpuid_deps table to clear all features with
> missing dependencies. That would cause X86_FEATURE_NMI_SOURCE to be
> cleared one way or another.
I don't think this is true. For a simplified example:
cpuid_deps has the following feature-depends pairs.
[1, 3]
[2, 3]
now, do_clear_cpu_cap(c, 2)

Before the loop below __set_bit(feature, disable), bit 2 is set. 

Since there is no other features depend on 2, the loop below will not clear
any other features. no?

> 
> 
> 	/* Loop until we get a stable state. */
> 	do {
> 		changed = false;
> 		for (d = cpuid_deps; d->feature; d++) {
> 			if (!test_bit(d->depends, disable))
> 				continue;
> 			if (__test_and_set_bit(d->feature, disable))
> 				continue;
> 
> 			changed = true;
> 			clear_feature(c, d->feature);
> 		}
> 	} while (changed);
> 
> 
> > In the next version, I will add runtime disable if HW malfunctions.
> > i.e. no valid bitmask.
> >   
> 
> I don't think we do this for other features that have a missing
> dependency. It doesn't seem NMI source is any different from them.
> 
NMI source is an optimization with a fallback path *always* available. In
that sense, it can be disabled at runtime without losing functionality.

The closest analogy I can think of are timers for clocksources where we use
higher ranking/cheaper timers first, and only resort to other timers in
case the primary/optimal one fails.

e.g.
root@984fee003c4f:~/jacob# cat
/sys/devices/system/clocksource/clocksource0/available_clocksource  
tsc hpet acpi_pm


Thanks,

Jacob
