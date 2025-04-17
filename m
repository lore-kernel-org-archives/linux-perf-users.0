Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30204154C0D;
	Thu, 17 Apr 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855212; cv=none; b=LxGuC+rYKaAMq6E38sF7Er7nCJB3WJWBURFk1DtsI9tslJw6QoENOn0B9Uw6QlCAp+0mw/tLIN9JeA5QvbVIeKev6KRXbtALWb2G4QBwsbg7El7RVp+tVpy3dBUNFkbUdYK6pSJA3WjXYRE622/aUFSMl1tmsS3gpc69U+EbOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855212; c=relaxed/simple;
	bh=SNHQCgYPPuktylCF1w4UKYr5L1ItGqxSFhQnyoMe0wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCtu1Zoc7Ncgs0UPzPNjm7/SMT6jZtQKGbb1GgulFuWfOpTwVn3uYPv/ZaTUYf07mOzt5RnT6Fn5JwUrXGthB0c7CthPSZBGDYz73P/KsQ8x9qoKHHWC4QvOfDK94q3GFCWrirQ4BTTfuf6/89v6bL+kNMao/RZSWDjaOnamhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiKQAkZN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiKQAkZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744855212; x=1776391212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SNHQCgYPPuktylCF1w4UKYr5L1ItGqxSFhQnyoMe0wo=;
  b=CiKQAkZNQ9TU3y4RaXEpDc3Nv+mPP/+yPa9CKJb9ZsaQa09LEoqH/AJZ
   ndApLXYH9u1SMRR1R9tnK8FvR0uN79+UmCLEh0dXT69D5HWQrHx31WO1y
   6hbwy5Xumw/7B3MwiS5mtleezxLXE9CgYYxPs1HuHlpbDMYVqY8eHxaVJ
   7cIId9BK1MPu2E+t2KAR7vGtXXeujbo03raomS+aU0v2UcJD2UbZlOqf8
   YQVdxesItthSJeDOZF69IaAIH/2IUMqeIAmYRtkbpCL7kI2DAXEUyFj9C
   BbdbbOaFIW6pcT1qshqvK5RajA9g4r6xwt1G5kWyNwSqfWWTOyGeJ/Z0A
   w==;
X-CSE-ConnectionGUID: OKRLOK14Sn2i6mNx/rYN9Q==
X-CSE-MsgGUID: KB+gfqDySKq1Vppt2IbVpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50236329"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="50236329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:00:09 -0700
X-CSE-ConnectionGUID: F7ZYATMxSgCgCK7sXXbNpg==
X-CSE-MsgGUID: owziaZAiTN+1EC2LITxSWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="135476179"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:00:02 -0700
Message-ID: <486ac73c-f409-4b56-8d54-dcd3a73d155e@linux.intel.com>
Date: Thu, 17 Apr 2025 10:00:00 +0800
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

If only considering x86 XMM/YMM/ZMM registers, it should be enough since
higher width vector registers always contain the lower width vector
registers on x86 platforms, but I'm not sure if we can have such assumption
for other archs. If not, then it's not enough since user may hope to sample
multiple vector registers with different width at the same time.
Furthermore, considering there could be more other registers like APX
registers need to be supported in the future, we'd better define a more
generic and easily extended interface. That's why I suggest to add a bitmap
like above"sample_regs_intr_ext" which can represent multiple kinds of
registers simultaneously.


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

Yes, we need it. Users may need to sample interrupt registers and user
space registers simultaneously although it sounds a little bit weird.


