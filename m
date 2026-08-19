Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A3218EBA
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155891; cv=none; b=QzRAREmm3PN6ks9zLmiEU3ldzhT/sISM3LyxIhPB4ZnKYr7a3CPSZZ02eeOwwz6Y+MefoN7GmMZ4EZFv4l5k7Nwvx/AchFnHkE6nhmubK3atzgVqeeNECf2X5shxAvDNOACRkhNuOXiho9O63Fm+8m+Fw0JNaE5sAZrg6IJi2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155891; c=relaxed/simple;
	bh=dP0nitOCRz7KUQJXwgR3E7OsZ+KbistS+AH8BWrxyzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su+KeKYVr2JVgeL2tp+voD206ObD30g36VO917s74TME/Zvz+oECrRs9p0StwsnubFyUZIP6f8Ow1bjFZoco9KZX6MFlrDdladUqW/hpyG4xnATSuwX+BG6ckeOJPefzbf4epHFk+d6tEdirDRBwZf/ghj13dcSs6CU97qhjJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHdmkn0h; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHdmkn0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787155888; x=1818691888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dP0nitOCRz7KUQJXwgR3E7OsZ+KbistS+AH8BWrxyzM=;
  b=VHdmkn0hv5/rhqC7GKUqlN2NXRBB8WOO/eILCMhwN+fQQrNdzhx0oWme
   Nts6kkP7Z5XxIFI9qGPxowxBu097S2VRCJCB3xpqUQRFORJHTbrDg8L71
   jja2W1KD4ligxQzAS0Q2MvWlANn4/OXyj4upmNSwA/aYAaAvL/kTREVOu
   mAm1efLFAThwIIASTSlsv4H6uKk4DThtQIl45Sb29dh9ntPEqzRdM0R5U
   4/2t8QpH10bQau7jLoh+Ky5gEX0Ez+we32igipzZXN8uJiCtpFdLcDRBm
   a1dID9i9ok3o3Ot7ke1nKvpUCm6A9UEMEICTYx6upc7jykc/x42hhvlRy
   g==;
X-CSE-ConnectionGUID: lWUV0v0fQ3qE6DXJOMacdA==
X-CSE-MsgGUID: P/RDlEdxSuuq1dimbN2i1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99203555"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99203555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:11:27 -0700
X-CSE-ConnectionGUID: lEw3p8C2R92kdAgtw8c/XQ==
X-CSE-MsgGUID: tIQahMYrSPKoXBlHr59AeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="289101332"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:11:26 -0700
Date: Wed, 19 Aug 2026 09:11:24 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, namhyung@kernel.org, acme@kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
Message-ID: <aoXVrD-Qbhi5qd2D@tassilo>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo>
 <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
 <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org>
 <CAP-5=fXLe9tqR7wHh9auRxqX82Fw6zYh1EoTOXjPhOXcRXB92A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXLe9tqR7wHh9auRxqX82Fw6zYh1EoTOXjPhOXcRXB92A@mail.gmail.com>

> With frequency scaling, doesn't IPC remain relatively constant with
> frequency when ignoring external factors like memory? The IPC on an
> e-core is expected to be lower than on a p-core.

For most workloads you cannot ignore memory.

Also the e-core IPC is often not lower than p-core, it's 
actually quite competitive in many things. It just has
a much lower frequency ceiling.

> So I was in a presentation today where someone claimed that larger
> cycle counts translated to memory system overhead, but they could be
> unique :-) In my two loop example the lower IPC core's loop would show
> a greater number of cycles than the higher-IPC core's loop. This would
> make it appear higher in `perf top`, leading the user to drill into it
> assuming more time was spent there due to issues with the code. As I'm
> hypothesizing the code is identical then the higher `perf top` is down
> to being scheduled on the e-core and its lower IPC. Having identical
> code where by default in perf one appears worse than the other doesn't
> strike me as desirable as the same behavior wouldn't happen on a
> non-hybrid system.

Yes performance analysis is hard and a lot of people get it wrong.

> 
> > > How can we merge non-legacy events? On ARM there is no PMU with a type
> > > number file with TYPE_HARDWARE.
> >
> > Very few people use top with anything other than cycles, so it's
> > probably
> > not a very urgent problem.  I suppose you could push the problem to
> > the user with some configuration file.
> 
> So I think users (and me) don't like the choose your event thing at
> the beginning of `perf top`. I think the work in the histogram code to

I'm not sure what you're proposing here. You want to make 
merging default to off?


-Andi
