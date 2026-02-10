Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E41946BC;
	Tue, 10 Feb 2026 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700921; cv=none; b=JiQ7g72TcFWrirqnPyAOMlpl8I8NN69f4MZePJbk/cX0cm3pVfWYz/wGEaaKxek+eLVx5ifadY1izPADa3/Q/r7+0V/7uXiFsYQO0nkGbUUbEeTwcOLhcOgHvWIvTc6DBY33Pk/PnWZgc0J2nV/v8Qgrnjh9hGILtRnjb4mEaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700921; c=relaxed/simple;
	bh=B0wtVLpYxsjc6vfLfb6wnnDWMsZqzw/zF0lBBuDtmZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UseUbAU2Vx8Xt3Mr4O3TRhqiACtPJgx5f99uiNwZI9TBnpqNY4G0HsJ+uYatSr42QDw/BLFK78FYXRKpHMuuJ86ZmkjB/ELKSnlNyPTgXFgaTBYvWqfi+PToy+cRkTYdkvMIFl24W/+DTbkhqsSTdghNOazvqrqo4ef6pXZ56x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpwAgpwz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpwAgpwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770700920; x=1802236920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B0wtVLpYxsjc6vfLfb6wnnDWMsZqzw/zF0lBBuDtmZE=;
  b=DpwAgpwzznfv5HoUth4fQsqOFkARcCE5wH5ZweiVLCT9DGb40ioVvvBk
   ZmwVVexg27ml9Yja28ScW4za5fCv9NVAmLbCPmBdLevXpqQkm5fgXtDCp
   H7PFwiCeHZCzQgJOOQEFjIjgmk5ypaQO2AzpYdJqN7+H54Jo9IJPpbmFq
   ix2OEqOFeLaaizV/k0Kdw1JySEXWT5KtTc4aIgg5gNLvmhv4JB7j/Wd88
   37VY4jJtUVbG1AgRrwwuEk/OvgS4vsTGVM18mV8bO3ZS0hol6IG5oGNdA
   NnT8jr1JDBJ4pqneyrUPLNmlPkrzFwZqzm9fZr3+/d37CzJUPnn46aA4h
   g==;
X-CSE-ConnectionGUID: X5eQnoqWQEuNsNXy+yBP4Q==
X-CSE-MsgGUID: hLm++Hk/S9iqPd8xkGVDZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75446618"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75446618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 21:21:59 -0800
X-CSE-ConnectionGUID: mfKmWPifTl2Aq4FuXxq6Vw==
X-CSE-MsgGUID: GMD132t4Tee3FeMsmpErSQ==
X-ExtLoop1: 1
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184]) ([10.238.1.184])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 21:21:54 -0800
Message-ID: <58607827-3f14-4807-ad9d-9dd0df089303@linux.intel.com>
Date: Tue, 10 Feb 2026 13:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 1/4] perf headers: Sync with the kernel headers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com>
 <20260209083514.2225115-2-dapeng1.mi@linux.intel.com>
 <CAP-5=fV6WRASqp=HCTF1E64cDJy_mJrESMLYiyydwj0hGoYsDQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV6WRASqp=HCTF1E64cDJy_mJrESMLYiyydwj0hGoYsDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/10/2026 6:09 AM, Ian Rogers wrote:
> On Mon, Feb 9, 2026 at 12:39 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Update include/uapi/linux/perf_event.h and
>> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/arch/x86/include/uapi/asm/perf_regs.h | 49 +++++++++++++++++++++
>>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++++++--
>>  2 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
>> index 7c9d2bb3833b..6da63e1dbb40 100644
>> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
>> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
>> @@ -27,9 +27,34 @@ enum perf_event_x86_regs {
>>         PERF_REG_X86_R13,
>>         PERF_REG_X86_R14,
>>         PERF_REG_X86_R15,
>> +       /*
>> +        * The EGPRs/SSP and XMM have overlaps. Only one can be used
>> +        * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
>> +        * utilize EGPRs/SSP. For the other ABI type, XMM is used.
>> +        *
>> +        * Extended GPRs (EGPRs)
>> +        */
>> +       PERF_REG_X86_R16,
>> +       PERF_REG_X86_R17,
>> +       PERF_REG_X86_R18,
>> +       PERF_REG_X86_R19,
>> +       PERF_REG_X86_R20,
>> +       PERF_REG_X86_R21,
>> +       PERF_REG_X86_R22,
>> +       PERF_REG_X86_R23,
>> +       PERF_REG_X86_R24,
>> +       PERF_REG_X86_R25,
>> +       PERF_REG_X86_R26,
>> +       PERF_REG_X86_R27,
>> +       PERF_REG_X86_R28,
>> +       PERF_REG_X86_R29,
>> +       PERF_REG_X86_R30,
>> +       PERF_REG_X86_R31,
>> +       PERF_REG_X86_SSP,
> nit: I think it'd be nice to comment that PERF_REG_X86_SSP and
> PERF_REG_X86_XMM0 are both 32, the meaning of the register is
> dependent on the PERF_SAMPLE_REGS_ABI_SIMD, 0 meaning XMM0 and 1
> meaning SSP (which could be the opposite of what would be expected).

PERF_REG_X86_SSP is actually 40 instead of 32 in current table. We have
added comment (above PERF_REG_X86_R16) to declare that the indexes are
overlapped. But I suppose the comment can be optimized further.


>
>>         /* These are the limits for the GPRs. */
>>         PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>>         PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
>> +       PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
>>
>>         /* These all need two bits set because they are 128bit */
>>         PERF_REG_X86_XMM0  = 32,
>> @@ -54,5 +79,29 @@ enum perf_event_x86_regs {
>>  };
>>
>>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
>> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
>> +
>> +enum {
>> +       PERF_X86_SIMD_XMM_REGS      = 16,
>> +       PERF_X86_SIMD_YMM_REGS      = 16,
>> +       PERF_X86_SIMD_ZMM_REGS      = 32,
>> +       PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
>> +
>> +       PERF_X86_SIMD_OPMASK_REGS   = 8,
>> +       PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
>> +};
>> +
>> +#define PERF_X86_SIMD_PRED_MASK        GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
>> +#define PERF_X86_SIMD_VEC_MASK GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
>> +
>> +#define PERF_X86_H16ZMM_BASE           16
>> +
>> +enum {
>> +       PERF_X86_OPMASK_QWORDS   = 1,
>> +       PERF_X86_XMM_QWORDS      = 2,
>> +       PERF_X86_YMM_QWORDS      = 4,
>> +       PERF_X86_ZMM_QWORDS      = 8,
>> +       PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
> nit: for a non-x86 audience who may think a word is more than 2 bytes,
> I think it would be nice to comment that a QWORD is 8 bytes. I don't
> see other mentions of the unit of length in the kernel headers.

sure.


>
>> +};
>>
>>  #endif /* _ASM_X86_PERF_REGS_H */
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index 72f03153dd32..ce3a14d35390 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -314,8 +314,9 @@ enum {
>>   */
>>  enum perf_sample_regs_abi {
>>         PERF_SAMPLE_REGS_ABI_NONE               = 0,
>> -       PERF_SAMPLE_REGS_ABI_32                 = 1,
>> -       PERF_SAMPLE_REGS_ABI_64                 = 2,
>> +       PERF_SAMPLE_REGS_ABI_32                 = (1 << 0),
>> +       PERF_SAMPLE_REGS_ABI_64                 = (1 << 1),
>> +       PERF_SAMPLE_REGS_ABI_SIMD               = (1 << 2),
>>  };
>>
>>  /*
>> @@ -383,6 +384,7 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 */
>>  #define PERF_ATTR_SIZE_VER9                    144     /* add: config4 */
>> +#define PERF_ATTR_SIZE_VER10                   176     /* Add: sample_simd_{pred,vec}_reg_* */
>>
>>  /*
>>   * 'struct perf_event_attr' contains various attributes that define
>> @@ -547,6 +549,25 @@ struct perf_event_attr {
>>
>>         __u64   config3; /* extension of config2 */
>>         __u64   config4; /* extension of config3 */
>> +
>> +       /*
>> +        * Defines set of SIMD registers to dump on samples.
>> +        * The sample_simd_regs_enabled !=0 implies the
>> +        * set of SIMD registers is used to config all SIMD registers.
>> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
>> +        * config some SIMD registers on X86.
> nit: I think this comment could be clearer, perhaps:
>
> If sample_simd_regs_enabled is non-zero then the following
> sampled_simd values define a set of SIMD registers to dump in all
> samples. Each register is defined as a bitmap position in
> (pred|vec)_reg_(intr|user) and the width of the register in qwords
> (8-bytes) is given in (pred|vec)_reg_qwords. If sample_simd_regs is 0
> then the vector registers may be dumped if they are in use. To
> determine if all or a subset of the registers are dumped, and the
> register width, the sample contains the values nr_vectors,
> vector_qwords, nr_pred and pred_qwords.

Sure. I would enhance the comment and make it clearer.


>
> Note, it is particularly the notion of "config all SIMD registers"
> that I'm having a hard time being clear on here.
>
>> +        */
>> +       union {
>> +               __u16 sample_simd_regs_enabled;
> nit: I wonder if "enabled" is the right name here as the value being 0
> means the vector register may be dumped. Perhaps
> sample_simd_regs_full.

Hmm, the "enabled" word could still be the best name which I can image. The
"enabled" here is to represent if the below "sample_simd_xxx" fields are
effective and should be parsed. I admit the XMM registers could be sampled
even sample_simd_regs_enabled is 0, but it has nothing to do with these
newly added "sample_simd_xxx" fields.


>
> Thanks,
> Ian
>
>> +               __u16 sample_simd_pred_reg_qwords;
>> +       };
>> +       __u16   sample_simd_vec_reg_qwords;
>> +       __u32   __reserved_4;
>> +
>> +       __u32   sample_simd_pred_reg_intr;
>> +       __u32   sample_simd_pred_reg_user;
>> +       __u64   sample_simd_vec_reg_intr;
>> +       __u64   sample_simd_vec_reg_user;
>>  };
>>
>>  /*
>> @@ -1020,7 +1041,15 @@ enum perf_event_type {
>>          *      } && PERF_SAMPLE_BRANCH_STACK
>>          *
>>          *      { u64                   abi; # enum perf_sample_regs_abi
>> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> +        *        u64                   regs[weight(mask)];
>> +        *        struct {
>> +        *              u16 nr_vectors;         # 0 ... weight(sample_simd_vec_reg_user)
>> +        *              u16 vector_qwords;      # 0 ... sample_simd_vec_reg_qwords
>> +        *              u16 nr_pred;            # 0 ... weight(sample_simd_pred_reg_user)
>> +        *              u16 pred_qwords;        # 0 ... sample_simd_pred_reg_qwords
>> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +        *      } && PERF_SAMPLE_REGS_USER
>>          *
>>          *      { u64                   size;
>>          *        char                  data[size];
>> @@ -1047,7 +1076,15 @@ enum perf_event_type {
>>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
>>          *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
>>          *      { u64                   abi; # enum perf_sample_regs_abi
>> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>> +        *        u64                   regs[weight(mask)];
>> +        *        struct {
>> +        *              u16 nr_vectors;         # 0 ... weight(sample_simd_vec_reg_intr)
>> +        *              u16 vector_qwords;      # 0 ... sample_simd_vec_reg_qwords
>> +        *              u16 nr_pred;            # 0 ... weight(sample_simd_pred_reg_intr)
>> +        *              u16 pred_qwords;        # 0 ... sample_simd_pred_reg_qwords
>> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +        *      } && PERF_SAMPLE_REGS_INTR
>>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>>          *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>> --
>> 2.34.1
>>
