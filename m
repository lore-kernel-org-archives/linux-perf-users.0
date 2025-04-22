Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5F196;
	Tue, 22 Apr 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291122; cv=none; b=ifqk23xi15001B+I36g1gJkg2P0UYIR14OSJcapFiNR42XhsY7zFfnuMRhO+raimpVajIkO0DgvALR/VjDLQrI9rjaf6+YY9MnCT0lRzYiznC5gQZ46CpNqds+Pk11UY54H2aRkovqbKZtPeG9qfG8P2BYC5F8SNgsMY4bFB74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291122; c=relaxed/simple;
	bh=If54DspNqfshq1hJDXNPcwFEPnFU21I2Wa6Wm2egSek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0gDE1McBtDx6h9zViLMz8NHkTiIFKE7IIOzXovBJV8Lw5CdiLKjKBAAz91VwRwsTeHYhOwDn2ITjOy+cw0HMlfn0EvVbQjScfyHuIK8IAxxu+SCywIuub3yHBLKh+u2awxovZGx2x+Q6/1q2/h9jQLPcOgh5f+CoDFA6AJNUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBVk/HsO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBVk/HsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745291121; x=1776827121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=If54DspNqfshq1hJDXNPcwFEPnFU21I2Wa6Wm2egSek=;
  b=hBVk/HsOSfJYL9MzL410DaLXfa1LDCjbGaSOM+M+Eq3Guh9b7zHF6aQG
   eWkSqupLg0IEHjA43OlhdFq4Lau/+5Dtft4H8AJg+TXXo1G1fOAA9Ts85
   FqqnBKEK2sCq3y2Yaym4Iu6wXds2yLciKrDTZuS/6dugI0sDONWrbHIKM
   WcVZhrA4B91UnIea76SksoClcVt6+OQO0VrfoVGpgp1Cp5Uc80HDiVeUd
   X92GhWpppmZ1Ugf3JiQdn1axJJkNfn+YgVx30opXlGbw5qfnoFri+rMzd
   fBLfaUyUusIYBqnueWkWuJX1DaAUOnSE84RchvfWVVjOjmjG9y0C7CgbU
   g==;
X-CSE-ConnectionGUID: Zd1L23iISPSO4xA60e0V3A==
X-CSE-MsgGUID: i4kqQ1VkSGmc8f+22fdFJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="57021651"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="57021651"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 20:05:18 -0700
X-CSE-ConnectionGUID: oSSK54WRTuqYl6gRvBh3OQ==
X-CSE-MsgGUID: isIWnMFgQbGktNJfHUUkiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="135970525"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 20:05:14 -0700
Message-ID: <5906dfa9-3fca-4e29-b6ab-abd2c02ae9fe@linux.intel.com>
Date: Tue, 22 Apr 2025 11:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 16/22] perf/core: Support to capture higher width
 vector registers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-17-dapeng1.mi@linux.intel.com>
 <20250415143626.GF4031@noisy.programming.kicks-ass.net>
 <26799b7e-c3a6-4de2-afd1-7bda0639fa37@linux.intel.com>
 <20250416155327.GD17910@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250416155327.GD17910@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/16/2025 11:53 PM, Peter Zijlstra wrote:
> On Wed, Apr 16, 2025 at 02:42:12PM +0800, Mi, Dapeng wrote:
>
>> Just think twice, using bitmap to represent these extended registers indeed
>> wastes bits and is hard to extend, there could be much much more vector
>> registers if considering AMX.
> *Groan* so AMX should never have been register state :-(
>
>
>> Considering different arch/HW may support different number vector register,
>> like platform A supports 8 XMM registers and 8 YMM registers, but platform
>> B only supports 16 XMM registers, a better way to represent these vector
>> registers may add two fields, one is a bitmap which represents which kinds
>> of vector registers needs to be captures. The other field could be a u16
>> array which represents the corresponding register length of each kind of
>> vector register. It may look like this.
>>
>> #define    PERF_SAMPLE_EXT_REGS_XMM    BIT(0)
>> #define    PERF_SAMPLE_EXT_REGS_YMM    BIT(1)
>> #define    PERF_SAMPLE_EXT_REGS_ZMM    BIT(2)
>>     __u32    sample_regs_intr_ext;
>>     __u16    sample_regs_intr_ext_len[4];
>>     __u32    sample_regs_user_ext;
>>     __u16    sample_regs_user_ext_len[4];
>>
>>
>> Peter, how do you think this? Thanks.
> I'm not entirely sure I understand.
>
> How about something like:
>
> 	__u16 sample_simd_reg_words;
> 	__u64 sample_simd_reg_intr;
> 	__u64 sample_simd_reg_user;
>
> Then the simd_reg_words tell us how many (quad) words per register (8 for
> 512) and simd_reg_{intr,user} are a simple bitmap, one bit per actual
> simd reg.
>
> So then all of XMM would be:
>
>   words = 2;
>   intr = user = 0xFFFF;
>
> (16 regs, 128 wide)
>
> Whereas ZMM would be:
>
>   words = 8
>   intr = user = 0xFFFFFFFF;
>
> (32 regs, 512 wide)
>
>
> Would this be sufficient? Possibly we can split the words thing into two
> __u8, but does it make sense to ask for different vector width for
> intr and user ?

Hi Peter,

Discussed with Kan offline, it sounds to be a real requirement for user to
sample multiple different kinds of SIMD registers, such as user may hope to
sample OPMASK and ZMM registers simultaneously. So to meet the requirement
and make the interface more flexible, we enhance the interface to this.

    /* Bitmap to represent SIMD regs. */
    __u64 sample_simd_reg_intr;
    __u64 sample_simd_reg_user;
    /*
     * Represent each kind of SIMD reg size (how many u64 words are needed)
     * in above bitmap order, e.g., x86 YMM regs are 256 bits and occupy 4
u64 words.
     */
    __u8 sample_simd_reg_size[4];

sample_simd_reg_intr/sample_simd_reg_user represents SIMD regs bitmap, e.g.
on x86 platform, bit[7:0] represents OPMASK[7:0], bit[23:8] represents
YMM[15:0], bit[55:24] represents ZMM[31:0].

sample_simd_reg_size[] represents how many u64 words are needed in above
bitmap order for each kind of SIMD regs, e.g., sample_simd_reg_size[0] = 1,
which represents each OPMASK occupies 1 u64 word, sample_simd_reg_size[1] =
4, which represents YMM occupies 4 u64 words and ample_simd_reg_size[2] =
8, which represents each ZMM occupies 8 u64 words.

How do you think this interface? Thanks.

Dapeng Mi

