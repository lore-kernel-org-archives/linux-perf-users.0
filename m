Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10C23236D;
	Tue, 30 Sep 2025 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200277; cv=none; b=r1zUJ8X+B636WtfP9fnqHh1nS+Yfp9I3+KTmRz2zgTQCDfeTWvPz3l52uKvfn9lprZVjsKCNY1UanmYje68zMtGlNNzMGWWy+V/6Gjg4EQLFKeFM8S9Mop2xTdvvSmer3oUcXwJMIDHK8SHusatB+KRi9RPT1P8IRycFDyW5dhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200277; c=relaxed/simple;
	bh=7gvc8OwlLG19YrvxDOuz9EAntE6Gl9mCNplKm48kbg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlRyXj5IfTZ2VABzz2fwpYcDzHrgKRedLaowXvpmSG2HG48eh4YoEwYvFE7wZ91QgVHKzWYOTAqDg4VqPT27HgagNSRcLBHj3pul99EKh5T3jLQ+qXwgS0G29MZx/+zTECfwuENCSmS8kxmjVopg02TVO/w/cfY8Zy6HuB3Z8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYXpqlxu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYXpqlxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759200276; x=1790736276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7gvc8OwlLG19YrvxDOuz9EAntE6Gl9mCNplKm48kbg4=;
  b=bYXpqlxu9Jk0X4oB1BYkqdKiFR76Lr6FwmKS2BJbjkRfCQ1kU8gQRGnT
   NoQC1iKWOrLhFRWUFs4RURlzf3uPikVaYCXuOj4zeW391oPtounxHcVPB
   NOnXK3TZyXdy/YZJBjnLfcVpNRQkB0QdmdjQIWQB7uBVpx3jl1PimNBQ+
   LIwxhqdcqZ/qzsPJkt2Skhi8BYg5knYaEaPwCESZauY69LSCjoeB0o8in
   nvCCc2mmTkNx3n4ubdD7GizwMqEOzs+nL7pfOapuNSwRsJQTyWXsUcGXG
   X/4/altZjFdWAvBseBGL0bhK1n10EhrLksIav4g7M+h9g70+8co9klK6L
   g==;
X-CSE-ConnectionGUID: WtY3SPqAQQCgN6C3zCyoMw==
X-CSE-MsgGUID: bzsUUnqkTHybq6Uot3205Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="71696049"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="71696049"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:44:35 -0700
X-CSE-ConnectionGUID: HndwY5sYQAeKhaFUgxZ7qA==
X-CSE-MsgGUID: xLWUd3usT9ud2imC2HN/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="177519176"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:44:30 -0700
Message-ID: <146dd8a2-b1e4-43e2-8bd6-93f18eea4402@linux.intel.com>
Date: Tue, 30 Sep 2025 10:44:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 03/17] x86/fpu/xstate: Add xsaves_nmi
To: Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
 <20250925061213.178796-4-dapeng1.mi@linux.intel.com>
 <bc8a902f-549a-482f-bf24-04cf5f38a379@intel.com>
 <8476ee65-546a-47ff-951c-5b2a24995ccf@linux.intel.com>
 <3921d500-36ce-409c-8730-6be86a40e334@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <3921d500-36ce-409c-8730-6be86a40e334@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/30/2025 3:01 AM, Dave Hansen wrote:
> On 9/27/25 22:31, Mi, Dapeng wrote:
>>> Also, what supervisor components are involved here? Aren't we just
>>> talking about [XYZ]MM's?
>> Besides the SIMD registers [XYZ]MM, the CET_USR (only SSP) and APX eGPRs
>> would be supported as well.
> We should think long and hard about whether to use XSAVE for the CET
> SSP. I'm not convinced it's worth it.

Yeah, It's indeed inefficient to read a ONLY SSP register by using xsaves
instruction. Do you think if it's safe enough to directly read IA32_PL3_SSP
MSR by using rdmsr instruction?

IMO, It seems good enough to read IA32_PL3_SSP directly with rdmsr in NMI
context since we just need to know the real value in IA32_PL3_SSP when NMI
hits. Thanks.


