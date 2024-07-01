Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2D16D4F4
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852865; cv=none; b=MBV1UvjCACbFx1fUW8oI/QgXqITHkdQfrrOq/0IApenV6sK9CIutf4c2gI0nrhzrzv8F/KjQ8v0g+/S0mvUJtIrmiCwVCVVb3111n2/SQny7m7WgHvOmZPssQwue/BQvOEUYrgUWg7+El5uA/cOBbIjzjKH67aqUvjWYn1Xs5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852865; c=relaxed/simple;
	bh=cJtzeZx28kfhlqpJ+/vtKyrGTOoCEpY6mAoitYzlwaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfPg4hwz0umABE2TmMS6s6SeGtBze1y9/Vw4eCWY31jh0W3TLNBJEjDni5FxvTOc+ueqB1fw4OZdk1nGfiA74vsw6L8GGWnqVmc0a/a8yoVkuA/uL6obMUrEX+oInPLJe7+pxPM313Be1SBaGMZcL+I+ZytuE8pIXOrrrgvtmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHt3kflP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHt3kflP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719852863; x=1751388863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJtzeZx28kfhlqpJ+/vtKyrGTOoCEpY6mAoitYzlwaM=;
  b=GHt3kflPDj7gISx6945u2fWpYFaYOBt5no45Zm4pqpu0XCp+G4da9Mvv
   Tx+RsoL7JL4Oauz8WHHNhAgV4pKt3c0a4uJ0c+UX0g+CwVe/N95yeuNlg
   Xf8Zu5nif1XWNVUTedFYd5U3KBSeJffQeyJ/P13qNfWG3Ifns9gtsJRg7
   RrbDGI+6ZF/fkBZm9iYRmR/0N3+tFC4atTO0uLBf3tzycmPCT2IhLaVur
   gi3umag5KrBxK/5R+GMY4OO5/+QbPDyH+fjIJn2fTH62OseKkOMm538QP
   NJ7JX+nJE5gRCo3uYFnvod/GgTig0ZP1kDmdXYEnGCJ64Fnte6ZUt1/3q
   A==;
X-CSE-ConnectionGUID: 03v0/LF3Qy6O4oJr4uGT7Q==
X-CSE-MsgGUID: qmVACIE2QpSoQdgUbA4CBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34535980"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34535980"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:54:23 -0700
X-CSE-ConnectionGUID: eiQXAcd8Q5iGwrNKfqrHng==
X-CSE-MsgGUID: sEL+79IiSvCW3gknJxzk4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="76764065"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:54:24 -0700
Date: Mon, 1 Jul 2024 09:54:21 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Fix perf script -F +metric
Message-ID: <ZoLfPV5-H1HQxgCj@tassilo>
References: <20240625004232.1852705-1-ak@linux.intel.com>
 <20240626090924.GA56952@alecto.usersys.redhat.com>
 <Zn8M39dHtqYpRa0o@tassilo>
 <20240701070438.GA12242@alecto.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701070438.GA12242@alecto.usersys.redhat.com>

On Mon, Jul 01, 2024 at 09:04:38AM +0200, Artem Savkov wrote:
> On Fri, Jun 28, 2024 at 12:19:59PM -0700, Andi Kleen wrote:
> > > This works, however there seems to be yet another issue on
> > > perf-tools-next branch that breaks script metrics.
> > >
> > > 617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
> > > events over legacy, 2024-04-15) changes event priority so on
> > > my host "instructions" have type PERF_TYPE_RAW instead of
> > > PERF_TYPE_HARDWARE.
> >
> > FWIW I don't see this on my build on Intel, even with that commit.
> >
> > > This results in evsel__stat_type no longer recognizing these as
> > > STAT_INSTRUCTIONS.
> >
> > I guess we could just fix evsel__stat_type to handle that case
> >
> > Does this patch work?
> 
> It does for this specific example, but there are other events as well.
> From arch/x86/events/intel/core.c:
> 
>         static u64 intel_perfmon_event_map[PERF_COUNT_HW_MAX] __read_mostly =
>         {
>                 [PERF_COUNT_HW_CPU_CYCLES]		= 0x003c,
>                 [PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
>                 [PERF_COUNT_HW_CACHE_REFERENCES]	= 0x4f2e,
>                 [PERF_COUNT_HW_CACHE_MISSES]		= 0x412e,
>                 [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c4,
>                 [PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c5,
>                 [PERF_COUNT_HW_BUS_CYCLES]		= 0x013c,
>                 [PERF_COUNT_HW_REF_CPU_CYCLES]		= 0x0300, /* pseudo-encoding */
>         };
> 
> The list is probably different on other arches.

Most of them only use the fallback "xxx per second" metric, which
should work even for raw I think. But yes some would be needed
(like cache and branches) 

Probably it needs a more generic solution then, it was somewhat
of a hack anyways.

My proposal would be to revert the original patch. Clearly
it was a bad idea.

-Andi
 
