Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED313AD18;
	Thu,  6 Feb 2025 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810649; cv=none; b=QsZpDwlBq+YWwL821GIwwQJh9vALbB1oNN3Hz9iNdmVEiuoYnnza0k/JL8xAiddY9o/eASqkzqWf6k5Ja15kP7Z/aCBCBvLWmKDgCjVGpqCQCA54aewfi/H2nAp6Mh11p+qAjEeK5WwAmQl822d7DtAer9sKc5rwh6Ql2MMpXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810649; c=relaxed/simple;
	bh=iy6jIH4U54qu9X/c+xTUMCfGm9LV9nkbKu493Cy1nj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMg/UTYyWJp+DMlwOIMUSaEwVAIcS9vowR/Ot7Ooi5jrogCblkxPAPUJaN+JevVwniUbs1RUU1vUImXMV5RgON+W+HqhI7jdHko2HltJWzUlMSzN/VKazL3aGnbeazFqkBUjJ6+7ORUuLbnqYqySbvg1rHcAomMXgKaXwIBxlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFHoV0qI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFHoV0qI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738810647; x=1770346647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iy6jIH4U54qu9X/c+xTUMCfGm9LV9nkbKu493Cy1nj4=;
  b=XFHoV0qIwq5ZKldCsmBTTdClypZ+lL1LwSg9c5RIhQym9oJ/1O7iTiOd
   LozjME3bvd5B7szjjIwiCpFvuQORIP/d0S2LS4J0yPCSdzrfj9W7yrHN+
   BR1s1f29cz+2Cfc8a5sT5cNbIX0xAloKZxpKmq0qJpzRTvY5n/ffP11Np
   pJN2lQdrQ3dUY5FSIJIjap2nDvJI+neRp6E6E+jymq1OfgwTpvxh/Isd1
   m23HR126QY7IahyPb/pqXvFTp8odBAGU4Qmscprvqzjup5eDO7gQ387wr
   Gog4LORYpUGQy8xhPqqkKsMDrjZCjo+B6gQr7+YTfcxycOmpfopM0fyLW
   g==;
X-CSE-ConnectionGUID: N6Ihh7pLTkuJ9qFDU0bnmg==
X-CSE-MsgGUID: DE50dm7NSPeIXx/RYd+fiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50386137"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="50386137"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:57:27 -0800
X-CSE-ConnectionGUID: 33bgTqiEQ0i8/TCFOISRew==
X-CSE-MsgGUID: SJ4mgJijT1KG3E0T4QPKAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115159985"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:57:19 -0800
Message-ID: <539d243b-ca9e-4849-be81-e755dc4ba528@linux.intel.com>
Date: Thu, 6 Feb 2025 10:57:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] perf tools: Support to show SSP register
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-18-dapeng1.mi@linux.intel.com>
 <CAP-5=fV-+3dU1CtUAYazv5L6VfNwDxv1C9Q=tQXzve9nqpaqrw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV-+3dU1CtUAYazv5L6VfNwDxv1C9Q=tQXzve9nqpaqrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/24/2025 12:15 AM, Ian Rogers wrote:
> On Wed, Jan 22, 2025 at 10:21 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Add SSP register support.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/arch/x86/include/uapi/asm/perf_regs.h    | 4 +++-
>>  tools/perf/arch/x86/util/perf_regs.c           | 2 ++
>>  tools/perf/util/intel-pt.c                     | 2 +-
>>  tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
>>  4 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
>> index 7c9d2bb3833b..158e353070c3 100644
>> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
>> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
>> @@ -27,9 +27,11 @@ enum perf_event_x86_regs {
>>         PERF_REG_X86_R13,
>>         PERF_REG_X86_R14,
>>         PERF_REG_X86_R15,
>> +       PERF_REG_X86_SSP,
> nit: Would it be worth a comment here? SSP may not be apparent to
> everyone. Perhaps something like:
> ```
> /* Shadow stack pointer (SSP) present on Clearwater Forest and newer models. */

Sure.


> ```
>>         /* These are the limits for the GPRs. */
>>         PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>> -       PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
>> +       PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
>> +       PERF_REG_INTEL_PT_MAX = PERF_REG_X86_R15 + 1,
> nit: It's a little peculiar to me the "+1" here - but that's
> pre-existing. Perhaps comments above here too:
> ```
> /* The MAX_REG_X86_64 used generally, for PEBS, etc. */
> PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
> /* The MAX_REG_INTEL_PT ignores the SSP register. */
> PERF_REG_INTEL_PT_MAX = PERF_REG_X86_R15 + 1,
> ```
> Otherwise:
> Reviewed-by: Ian Rogers <irogers@google.com>

Sure. Thanks.


>
> Thanks,
> Ian
>
>>         /* These all need two bits set because they are 128bit */
>>         PERF_REG_X86_XMM0  = 32,
>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
>> index 12fd93f04802..9f492568f3b4 100644
>> --- a/tools/perf/arch/x86/util/perf_regs.c
>> +++ b/tools/perf/arch/x86/util/perf_regs.c
>> @@ -36,6 +36,8 @@ static const struct sample_reg sample_reg_masks[] = {
>>         SMPL_REG(R14, PERF_REG_X86_R14),
>>         SMPL_REG(R15, PERF_REG_X86_R15),
>>  #endif
>> +       SMPL_REG(SSP, PERF_REG_X86_SSP),
>> +
>>         SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
>>         SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
>>         SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index 30be6dfe09eb..86196275c1e7 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -2139,7 +2139,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
>>         u32 bit;
>>         int i;
>>
>> -       for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
>> +       for (i = 0, bit = 1; i < PERF_REG_INTEL_PT_MAX; i++, bit <<= 1) {
>>                 /* Get the PEBS gp_regs array index */
>>                 int n = pebs_gp_regs[i] - 1;
>>
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> index 708954a9d35d..9a909f02bc04 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> @@ -54,6 +54,8 @@ const char *__perf_reg_name_x86(int id)
>>                 return "R14";
>>         case PERF_REG_X86_R15:
>>                 return "R15";
>> +       case PERF_REG_X86_SSP:
>> +               return "ssp";
>>
>>  #define XMM(x) \
>>         case PERF_REG_X86_XMM ## x:     \
>> --
>> 2.40.1
>>
