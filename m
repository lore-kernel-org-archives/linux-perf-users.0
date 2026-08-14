Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167C47986F
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718720; cv=none; b=UG0x6VWqbz53Hov0bOiyfncDR1o0FnnPm4rkSfnlQBRxhe7M0Uiy6Gjot2hRI+7kOZHH1v6xsZ2Vcwfsoce5rmjNEINhzCSLYGIEsO89QEWFW6L8kAj9mZ3LoC8FwvL1Q5Y/7LnN2nYFgfQl2/Gaq+Nqnjhd5o5jXgypvWQ69Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718720; c=relaxed/simple;
	bh=b7SmUPSVfIeIPMsN8rEHaGk86HsCl83fKaFtKrwwyDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhWaU/b2yIWmfNyguAPc5OzExGPOZO1ZChhTkmBbtyxduQEqSOTOScE3SaDCLDZAMkkCV8U5xtg/p2k4ok2jakS5KlNKoICLUJCFaVQZImMv2Mh5aYXHWkUuUnNHtp7oTR/66fNjH0QNp9p3ZRbithd1y8lgj2PjptGFGSeXMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEaTYJ0M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEaTYJ0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786718718; x=1818254718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b7SmUPSVfIeIPMsN8rEHaGk86HsCl83fKaFtKrwwyDc=;
  b=aEaTYJ0MciorCAqjgHz+RV0YYMd2Wkm3mufRpFMvcORBdufWYfBghFA2
   LV7V3fJHl0vtBaMw3ka+JCP1wejA6/PnQr0yGVhC4KC8OW7uE2xnFDnYB
   82vZH27UtMxP2Yj+7C8UxMpPTJnfpgXitPYkLXidtvTfeI1QwSFCMyvGL
   VuCKwXcqQq8hpDQMzyMEHje/6ReFNFRiytQbbpihEG/1K0QI6m5F5u79f
   rWDK9Ir+ZNZMgVdE4bREJshyjxQNnjm5fNHcN2IQxHcYbvbh6SfOZOmZj
   bW6hBnCRl1c5kcWaXEtjQ/MM4ZiM2ArtsuDI+UAwuA0jnOEnPqopGacV9
   Q==;
X-CSE-ConnectionGUID: x4WfE0CzRcWzsvHZaMYhRQ==
X-CSE-MsgGUID: zv+erP5KRdSqFtpKciLrCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="89816560"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89816560"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:45:17 -0700
X-CSE-ConnectionGUID: dkW8iPjdTFKBcdcEe2Irfg==
X-CSE-MsgGUID: +dWphkaNQcmelDIXKY3xMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262911040"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:45:17 -0700
Date: Fri, 14 Aug 2026 07:45:15 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf tools: Add support for displaying weights in
 annotate
Message-ID: <an8p-1D0jNgE8P4T@tassilo>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-4-ak@linux.intel.com>
 <an6zgXlyzPZ_2pI-@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an6zgXlyzPZ_2pI-@google.com>

On Fri, Aug 14, 2026 at 03:19:45PM +0900, Namhyung Kim wrote:
> >  	 * symbol and are missed.
> > @@ -719,6 +720,8 @@ int cmd_annotate(int argc, const char **argv)
> >  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
> >  #endif
> >  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
> > +	OPT_BOOLEAN(0, "no-weights", &symbol_conf.hide_weight,
> > +		    "Hide weight columns in annotation"),
> 
> Can it be just "weights"?  Then we would get --no-weights for free. :)
> Of course, the help message needs to say differently.

Sure I can rename it.

BTW this was the v2 with the broken white space hunks, please ignore or look at v3.

-Andi

