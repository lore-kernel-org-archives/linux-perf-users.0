Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66735304BBD;
	Wed, 21 Jan 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961028; cv=none; b=Yh/IlI4n45IvHzet4flZE0D459jau271f5AzYHOJsGLTKmxzjFrfQMtSHAjJ9PpSTRB1a6zQijtJqHesHyRcRm/WjHzn+19hQJTdpvJj4iAllVw3i2Diil7AowmL/nxB8bX2Qkq7VQlI3tLeLuXwtLjDmAHGKgQf16ABJvJhxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961028; c=relaxed/simple;
	bh=DZroDWZv33YlPa0EquZ6KGi7WO2SlhkGQ3Hz0DLf7Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqJ7qQmmWeSFJAiAZCgoeiocbA3Nf0pXGi1Wyu1Ji5rSiFh/iIgEtaU/VOR0hDy1xYhdeOiUG1oPHSQwvw1eEcUY3z9s+YNLPTa9hxu/yx5uBDFw9u/2hQGKsyOKtdB/IyEl74E1UlZtW3C4t5wJ0qr8aYxKTEWe4HW7rsvLj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlcmxxd7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlcmxxd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768961022; x=1800497022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DZroDWZv33YlPa0EquZ6KGi7WO2SlhkGQ3Hz0DLf7Gs=;
  b=hlcmxxd7u49LNnA9FV+KnNpIpnArOyZGHdHhWl1xwauSDLArZDwTEbix
   n683E78Ug7yFQOia9WZS+TBFfLpf9bRQPU+TTb/hTNNy0gHPwvGCSOJ5v
   3OBr7lBCtkKfrv8MSCMXBzU+51sW0p0mL1rDNDHaTgSUdHb1IUdG0x5iY
   7XB/1oIfy9YzHEjfa+jn7ZymgOp3kOaGnt4nFyrZ5WmvlXIAMa+kTHofI
   u+q2Uu8kHRfIq9YNkw+Z++C37FuPLHusM2DknBcdcH8CFDUO5sbMtpL7J
   x5g9diJ73HnJkruM5K13aZ4x3sR7YqBM6Yd3+hMopZJLiVnAA4w7XuHIa
   g==;
X-CSE-ConnectionGUID: oN3S1YjyTl2bHlAnijYjxQ==
X-CSE-MsgGUID: BhFZGIsnRpm46GRYdUKc0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80489316"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80489316"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 18:03:37 -0800
X-CSE-ConnectionGUID: vdjDw6mdQdCtKCE8Ao6dpA==
X-CSE-MsgGUID: Z04YA7pMTGKzxvRcT5TYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206341816"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 18:03:31 -0800
Message-ID: <c255f088-5992-45d4-92d7-cdbc9b5e446d@linux.intel.com>
Date: Wed, 21 Jan 2026 10:03:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 17/19] perf headers: Sync with the kernel headers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-18-dapeng1.mi@linux.intel.com>
 <CAP-5=fWPgdiRve_xk_t04wr_p1tccRu1eU7C3v+=yvc4OD4PVg@mail.gmail.com>
 <9b429aa8-d269-4af8-9236-350cb9543f2a@linux.intel.com>
 <CAP-5=fXQOTXhcuUjHSnMDQzi+u+kja2pNJSwziY7WZo7iLpqng@mail.gmail.com>
 <a5b8d05b-44db-46f7-8b3f-3b4f125480ed@linux.intel.com>
 <CAP-5=fWHmTeb7SAvpmMVvi8p_otqU6iSaRO29svyPi3MjhT4Mw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWHmTeb7SAvpmMVvi8p_otqU6iSaRO29svyPi3MjhT4Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/21/2026 2:11 AM, Ian Rogers wrote:
> On Tue, Jan 20, 2026 at 1:22 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/20/2026 4:00 PM, Ian Rogers wrote:
>>> On Mon, Jan 19, 2026 at 11:43 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> On 1/20/2026 3:16 PM, Ian Rogers wrote:
>>>>> On Tue, Dec 2, 2025 at 10:59 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>
>>>>>> Update include/uapi/linux/perf_event.h and
>>>>>> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
>>>>>>
>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> ---
>>>>>>  tools/arch/x86/include/uapi/asm/perf_regs.h | 62 +++++++++++++++++++++
>>>>>>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++--
>>>>>>  2 files changed, 103 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
>>>>>> index 7c9d2bb3833b..f3561ed10041 100644
>>>>>> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
>>>>>> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
>>>>>> @@ -27,9 +27,34 @@ enum perf_event_x86_regs {
>>>>>>         PERF_REG_X86_R13,
>>>>>>         PERF_REG_X86_R14,
>>>>>>         PERF_REG_X86_R15,
>>>>>> +       /*
>>>>>> +        * The EGPRs/SSP and XMM have overlaps. Only one can be used
>>>>>> +        * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
>>>>>> +        * utilize EGPRs/SSP. For the other ABI type, XMM is used.
>>>>>> +        *
>>>>>> +        * Extended GPRs (EGPRs)
>>>>>> +        */
>>>>>> +       PERF_REG_X86_R16,
>>>>>> +       PERF_REG_X86_R17,
>>>>>> +       PERF_REG_X86_R18,
>>>>>> +       PERF_REG_X86_R19,
>>>>>> +       PERF_REG_X86_R20,
>>>>>> +       PERF_REG_X86_R21,
>>>>>> +       PERF_REG_X86_R22,
>>>>>> +       PERF_REG_X86_R23,
>>>>>> +       PERF_REG_X86_R24,
>>>>>> +       PERF_REG_X86_R25,
>>>>>> +       PERF_REG_X86_R26,
>>>>>> +       PERF_REG_X86_R27,
>>>>>> +       PERF_REG_X86_R28,
>>>>>> +       PERF_REG_X86_R29,
>>>>>> +       PERF_REG_X86_R30,
>>>>>> +       PERF_REG_X86_R31,
>>>>>> +       PERF_REG_X86_SSP,
>>>>>>         /* These are the limits for the GPRs. */
>>>>>>         PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>>>>>>         PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
>>>>>> +       PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
>>>>>>
>>>>>>         /* These all need two bits set because they are 128bit */
>>>>>>         PERF_REG_X86_XMM0  = 32,
>>>>>> @@ -54,5 +79,42 @@ enum perf_event_x86_regs {
>>>>>>  };
>>>>>>
>>>>>>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
>>>>>> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
>>>>>> +
>>>>>> +enum {
>>>>>> +       PERF_REG_X86_XMM,
>>>>>> +       PERF_REG_X86_YMM,
>>>>>> +       PERF_REG_X86_ZMM,
>>>>>> +       PERF_REG_X86_MAX_SIMD_REGS,
>>>>>> +
>>>>>> +       PERF_REG_X86_OPMASK = 0,
>>>>>> +       PERF_REG_X86_MAX_PRED_REGS = 1,
>>>>>> +};
>>>>>> +
>>>>>> +enum {
>>>>>> +       PERF_X86_SIMD_XMM_REGS      = 16,
>>>>>> +       PERF_X86_SIMD_YMM_REGS      = 16,
>>>>>> +       PERF_X86_SIMD_ZMMH_REGS     = 16,
>>>>>> +       PERF_X86_SIMD_ZMM_REGS      = 32,
>>>>>> +       PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
>>>>>> +
>>>>>> +       PERF_X86_SIMD_OPMASK_REGS   = 8,
>>>>>> +       PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
>>>>>> +};
>>>>>> +
>>>>>> +#define PERF_X86_SIMD_PRED_MASK                GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
>>>>>> +#define PERF_X86_SIMD_VEC_MASK         GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
>>>>>> +
>>>>>> +#define PERF_X86_H16ZMM_BASE           PERF_X86_SIMD_ZMMH_REGS
>>>>>> +
>>>>>> +enum {
>>>>>> +       PERF_X86_OPMASK_QWORDS   = 1,
>>>>>> +       PERF_X86_XMM_QWORDS      = 2,
>>>>>> +       PERF_X86_YMMH_QWORDS     = 2,
>>>>>> +       PERF_X86_YMM_QWORDS      = 4,
>>>>>> +       PERF_X86_ZMMH_QWORDS     = 4,
>>>>>> +       PERF_X86_ZMM_QWORDS      = 8,
>>>>>> +       PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
>>>>>> +};
>>>>>>
>>>>>>  #endif /* _ASM_X86_PERF_REGS_H */
>>>>>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>>>>>> index d292f96bc06f..f1474da32622 100644
>>>>>> --- a/tools/include/uapi/linux/perf_event.h
>>>>>> +++ b/tools/include/uapi/linux/perf_event.h
>>>>>> @@ -314,8 +314,9 @@ enum {
>>>>>>   */
>>>>>>  enum perf_sample_regs_abi {
>>>>>>         PERF_SAMPLE_REGS_ABI_NONE               = 0,
>>>>>> -       PERF_SAMPLE_REGS_ABI_32                 = 1,
>>>>>> -       PERF_SAMPLE_REGS_ABI_64                 = 2,
>>>>>> +       PERF_SAMPLE_REGS_ABI_32                 = (1 << 0),
>>>>>> +       PERF_SAMPLE_REGS_ABI_64                 = (1 << 1),
>>>>>> +       PERF_SAMPLE_REGS_ABI_SIMD               = (1 << 2),
>>>>>>  };
>>>>>>
>>>>>>  /*
>>>>>> @@ -382,6 +383,7 @@ enum perf_event_read_format {
>>>>>>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sample_size */
>>>>>>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data */
>>>>>>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 */
>>>>>> +#define PERF_ATTR_SIZE_VER9                    168     /* Add: sample_simd_{pred,vec}_reg_* */
>>>>>>
>>>>>>  /*
>>>>>>   * 'struct perf_event_attr' contains various attributes that define
>>>>>> @@ -545,6 +547,25 @@ struct perf_event_attr {
>>>>>>         __u64   sig_data;
>>>>>>
>>>>>>         __u64   config3; /* extension of config2 */
>>>>>> +
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Defines set of SIMD registers to dump on samples.
>>>>>> +        * The sample_simd_regs_enabled !=0 implies the
>>>>>> +        * set of SIMD registers is used to config all SIMD registers.
>>>>>> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
>>>>>> +        * config some SIMD registers on X86.
>>>>>> +        */
>>>>>> +       union {
>>>>>> +               __u16 sample_simd_regs_enabled;
>>>>>> +               __u16 sample_simd_pred_reg_qwords;
>>>>>> +       };
>>>>>> +       __u32 sample_simd_pred_reg_intr;
>>>>>> +       __u32 sample_simd_pred_reg_user;
>>>>>> +       __u16 sample_simd_vec_reg_qwords;
>>>>>> +       __u64 sample_simd_vec_reg_intr;
>>>>>> +       __u64 sample_simd_vec_reg_user;
>>>>>> +       __u32 __reserved_4;
>>>>>>  };
>>>>>>
>>>>>>  /*
>>>>>> @@ -1018,7 +1039,15 @@ enum perf_event_type {
>>>>>>          *      } && PERF_SAMPLE_BRANCH_STACK
>>>>>>          *
>>>>>>          *      { u64                   abi; # enum perf_sample_regs_abi
>>>>>> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>>>>>> +        *        u64                   regs[weight(mask)];
>>>>>> +        *        struct {
>>>>>> +        *              u16 nr_vectors;
>>>>>> +        *              u16 vector_qwords;
>>>>>> +        *              u16 nr_pred;
>>>>>> +        *              u16 pred_qwords;
>>>>>> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>>>>>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>>>>> Why can't these values be taken from the perf_event_attr? The abi is
>>>>> needed as there could be both 32-bit and 64-bit samples for the same
>>>>> event - presumably x32 appears as 64-bit. If the ABI has SIMD within
>>>>> it (implied by the "} && (abi & PERF_SAMPLE_REGS_ABI_SIMD)" below)
>>>>> then why can't we just use the perf_event_attr values? For example,
>>>>> data could be "data[weight(sample_simd_vec_reg_user) *
>>>>> sample_simd_vec_reg_qwords + weight(sample_simd_pred_reg_user) *
>>>>> sample_simd_pred_reg_qwords]".
>>>> The main reason is that the sampled SIMD regs could only be a subset of the
>>>> requested SIMD regs in perf_event_attr, so we need to show the bitmask and
>>>> qwords length explicitly in the sample record.
>>> But this doesn't happen in any other register sampling, why in this case?
>>>
>>> Perhaps add comments along the lines:
>>> u16 nr_vectors;  // weight(sample_simd_vec_reg_user) except when ...
>>>
>>> My random guess as to why the value differs from the weight would be
>>> some kind of optimization around register values of 0. And even if the
>>> number of registers is reduced, why is the number of qwords being
>>> altered?
>> Yes. E.g., the user may want to sample ZMM registers (ZMM0 ~ ZMM31), but
>> the result is that only XMM registers (XMM0 ~ XMM15) are sampled at some
>> time, so both the registers number and qwords length are not identical with
>> the perf_event_attr values in some sampling records. Thus we need to
>> explicitly indicates the sampled registers number and length.
>>
>> Besides, containing these 4 fields in sampling records makes the sampling
>> records be parsed more easily and don't need to retrieve information from
>> corresponding perf_event_attr. Thanks.
> Sgtm (well you still need to look at the perf_event_attr for
> regs[weight(mask)] immediately before this, but anyway). Can we add
> comments to that effect? Something like:
> ```
>        *              u16 nr_vectors;  # 0..weight(sample_simd_vec_reg_user)
>        *              u16 vector_qwords; # 0..sample_simd_vec_reg_qwords
>        *              u16 nr_pred; # 0..weight(sample_simd_pred_reg_user)
>        *              u16 pred_qwords; 0..sample_simd_pred_reg_qwords
> ```
> At least this hints at an optimization rather than a duplication bug.

Sure. Thanks.


>
> Thanks,
> Ian
>
>>> Thanks,
>>> Ian
>>>
>>>>>> +        *      } && PERF_SAMPLE_REGS_USER
>>>>>>          *
>>>>>>          *      { u64                   size;
>>>>>>          *        char                  data[size];
>>>>>> @@ -1045,7 +1074,15 @@ enum perf_event_type {
>>>>>>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
>>>>>>          *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
>>>>>>          *      { u64                   abi; # enum perf_sample_regs_abi
>>>>>> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>>>>>> +        *        u64                   regs[weight(mask)];
>>>>>> +        *        struct {
>>>>>> +        *              u16 nr_vectors;
>>>>>> +        *              u16 vector_qwords;
>>>>>> +        *              u16 nr_pred;
>>>>>> +        *              u16 pred_qwords;
>>>>>> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>>>>>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>>>>> Same comment.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> +        *      } && PERF_SAMPLE_REGS_INTR
>>>>>>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>>>>>>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>>>>>>          *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>>>>>> --
>>>>>> 2.34.1
>>>>>>
