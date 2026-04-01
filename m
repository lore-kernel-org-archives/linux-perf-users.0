Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BA35DA5B;
	Wed,  1 Apr 2026 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030483; cv=none; b=RcUYqyYqPB8qutVFNFX9xArB/B0l8DQyxp5aSy9U+jO7zEC2EtPMQQNaISU4Tbtr0dBUeCVuNrrXbKVTrOR0bDLsFyLhpWMCNphMsslgJwDnfiR/wLcm5vp7YAb1neYiiKm4dYVsGeNC9azsgQvNZxttBv6eyK67CY4CSsUd74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030483; c=relaxed/simple;
	bh=4KPcHQaH2A+EIsW/2xhQ1DgUyBDKAUpbyJcONff9D4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gf5i6JwCnfblSZ3QceGcP1tSU0Ks1uoKfGOvE/VRrCOZS1quLF/8s1xprbWJqhxoVGX5TGq8POJMdbJ4EHzRjXIJyzITT5jVcO/0xIfhe1wXZcS3Hh43xRYk/amvya2oWTJegFEkGzS0VI092vhJCM4vLrEa2se+IQ3Q9HY5ISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/BI9vzq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/BI9vzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775030482; x=1806566482;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4KPcHQaH2A+EIsW/2xhQ1DgUyBDKAUpbyJcONff9D4w=;
  b=E/BI9vzqDgg8vqfcsG4PsOIZjZP3ivgAkAR+ecvPCkuAar6vKOGFOa8k
   rg6PBtnQieWGheoRzps4XPOSDCStjfQLpGtqnZMzLaHHZAeCESB4HuuLx
   nwGeAfxx/AJgZFZJDtmeKZ5Z7EMyGRD8Wd00IjAMWfO0ZOScXpNAKRcN2
   ckF4HVT0LF7bmTjY26wRznFISimsHALoaCfumNWCJTkd55ys2sF3k++ae
   RKNgyl1HuOZb6lcjPW68VAWprlgMm1zgKMFTubzzbcT/jb/Uu8Ai+mWcr
   LonPT/fC1PdpUX8Rb5dFPL7YLFc8RMuVthlcpq25wsBYwp1DBr1p0VweJ
   Q==;
X-CSE-ConnectionGUID: jCRtpvLKQemjmmW6phx7Yg==
X-CSE-MsgGUID: HbByzR/aT1ODto1Sx5QS1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86363841"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86363841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:01:21 -0700
X-CSE-ConnectionGUID: XfbOVKFJT6iKwii3eVtcsQ==
X-CSE-MsgGUID: 9OKPY4FESdub/5FB3tfE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="264536738"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2026 01:01:21 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id D5F61302965; Wed, 01 Apr 2026 01:01:20 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org,  linux-perf-users@vger.kernel.org,
  x86@kernel.org,  Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar
 <mingo@redhat.com>,  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung
 Kim <namhyung@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
  Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Ian Rogers <irogers@google.com>,  Adrian Hunter
 <adrian.hunter@intel.com>,  James Clark <james.clark@linaro.org>,  Thomas
 Gleixner <tglx@kernel.org>,  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] Two semi-related perf throttling fixes
In-Reply-To: <cover.1774969692.git.calvin@wbinvd.org> (Calvin Owens's message
	of "Tue, 31 Mar 2026 08:25:48 -0700")
References: <cover.1774969692.git.calvin@wbinvd.org>
Date: Wed, 01 Apr 2026 01:01:20 -0700
Message-ID: <87y0j7w1m7.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Owens <calvin@wbinvd.org> writes:

> Hi all,
>
> In the course of investigating [1], I set out to understand why this
> sequence of messages is printed every boot, even when nobody is using
> perf at all:

I don't think i've ever seen that just from the NMI watchdog. I wonder
what is different on your machines. And of course the PMU based NMI
watchdog is on the way out.

But the fixes make sense to me.

Reviewed-by: Andi Kleen <ak@kernel.org>
