Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323C3A1E70;
	Tue, 20 Jan 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893969; cv=none; b=gjNN/PUwBR4B09HwcCcPkS7IG5js++KW3yBBWydKFYveVUE6UJCf7yqSORW1QXTjYdKmLvvothv1WW6eyuvTYylCqfiti5OQaDrsy2MOfC89H5CkMVn5pjNcxgnCVa/fX61YnmnoSHNKB5z9iRJqUCJp/rFi8DvyeHVNtFaU7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893969; c=relaxed/simple;
	bh=TeoT+ra7tMLbg3kcUb29zd8wu4w1zBKZf/LemO0ycSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKglr0rMnrDiPlManm4M+yoLlRg0AhD47DQU3v5ZZulv+5oB5Xm/JrU+e19E6gcKG6H0TqtRfedwAoTcWtOe+g4WL69t3/lPwjUtqsM1urNmYumV063cvtSh3tlSae5Ou40MUJwWLhkDpokzFuhueqNsAy96jf8CAzgD02qFWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8RRnd/y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8RRnd/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768893964; x=1800429964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TeoT+ra7tMLbg3kcUb29zd8wu4w1zBKZf/LemO0ycSc=;
  b=G8RRnd/yfIaUXhJ5kmFQj1/z1zkq/EjKhZOk5WiEn6Igh1lXKmESk3Mp
   iMPc47suaBvM5xJV6mf+7oJwnJHp05HWQvUqAmroWF8HBytscKkdSxCKv
   Fb2kEfAJA8v3YugX17To3ZZpS22DIK0HGDUIhPQUaKQ5sqt8vnAdYHwyd
   7oebACot7GISXplaCWzIwtBSb4NG/L906hKkOF5i97gGW/E7bYzztAeYE
   rmpoW26spyaWJhYyFgnnyK+vB+Hu1TbVXM9NNvh86AiTUgHwepLjdg9yh
   6qI0JpOrIhFY+Br/AFJwAWVriKGKwVBkllXnOW3GB9WAFtQKLve8ssBjq
   w==;
X-CSE-ConnectionGUID: oRID8+JJSAC15MgDxmzMJQ==
X-CSE-MsgGUID: nDT5aCjbQfSk9aUvM8x8yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70147053"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70147053"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:25:59 -0800
X-CSE-ConnectionGUID: 5RBkxZ6wQ1ajlG1NlZRkGw==
X-CSE-MsgGUID: /Vy1U+OHTlGXYYMlpc1RiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206076563"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:25:54 -0800
Message-ID: <efd54637-3a00-4b44-9056-714acdcb78a3@linux.intel.com>
Date: Tue, 20 Jan 2026 15:25:51 +0800
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
 <CAP-5=fUAOErzzU=tPk0adQkqqwnc7BU0FxNgKrXwWQUN=Qjoug@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUAOErzzU=tPk0adQkqqwnc7BU0FxNgKrXwWQUN=Qjoug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/20/2026 3:01 PM, Ian Rogers wrote:
> On Tue, Dec 2, 2025 at 10:59 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Update include/uapi/linux/perf_event.h and
>> arch/x86/include/uapi/asm/perf_regs.h to support extended regs.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/arch/x86/include/uapi/asm/perf_regs.h | 62 +++++++++++++++++++++
>>  tools/include/uapi/linux/perf_event.h       | 45 +++++++++++++--
>>  2 files changed, 103 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
>> index 7c9d2bb3833b..f3561ed10041 100644
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
>>         /* These are the limits for the GPRs. */
>>         PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>>         PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
>> +       PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
>>
>>         /* These all need two bits set because they are 128bit */
>>         PERF_REG_X86_XMM0  = 32,
>> @@ -54,5 +79,42 @@ enum perf_event_x86_regs {
>>  };
>>
>>  #define PERF_REG_EXTENDED_MASK (~((1ULL << PERF_REG_X86_XMM0) - 1))
>> +#define PERF_X86_EGPRS_MASK    GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
>> +
>> +enum {
>> +       PERF_REG_X86_XMM,
>> +       PERF_REG_X86_YMM,
>> +       PERF_REG_X86_ZMM,
>> +       PERF_REG_X86_MAX_SIMD_REGS,
>> +
>> +       PERF_REG_X86_OPMASK = 0,
>> +       PERF_REG_X86_MAX_PRED_REGS = 1,
>> +};
>> +
>> +enum {
>> +       PERF_X86_SIMD_XMM_REGS      = 16,
>> +       PERF_X86_SIMD_YMM_REGS      = 16,
>> +       PERF_X86_SIMD_ZMMH_REGS     = 16,
>> +       PERF_X86_SIMD_ZMM_REGS      = 32,
>> +       PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
>> +
>> +       PERF_X86_SIMD_OPMASK_REGS   = 8,
>> +       PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
>> +};
>> +
>> +#define PERF_X86_SIMD_PRED_MASK                GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
>> +#define PERF_X86_SIMD_VEC_MASK         GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
>> +
>> +#define PERF_X86_H16ZMM_BASE           PERF_X86_SIMD_ZMMH_REGS
>> +
>> +enum {
>> +       PERF_X86_OPMASK_QWORDS   = 1,
>> +       PERF_X86_XMM_QWORDS      = 2,
>> +       PERF_X86_YMMH_QWORDS     = 2,
>> +       PERF_X86_YMM_QWORDS      = 4,
>> +       PERF_X86_ZMMH_QWORDS     = 4,
>> +       PERF_X86_ZMM_QWORDS      = 8,
>> +       PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
>> +};
>>
>>  #endif /* _ASM_X86_PERF_REGS_H */
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index d292f96bc06f..f1474da32622 100644
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
>> @@ -382,6 +383,7 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sample_size */
>>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 */
>> +#define PERF_ATTR_SIZE_VER9                    168     /* Add: sample_simd_{pred,vec}_reg_* */
>>
>>  /*
>>   * 'struct perf_event_attr' contains various attributes that define
>> @@ -545,6 +547,25 @@ struct perf_event_attr {
>>         __u64   sig_data;
>>
>>         __u64   config3; /* extension of config2 */
>> +
>> +
>> +       /*
>> +        * Defines set of SIMD registers to dump on samples.
>> +        * The sample_simd_regs_enabled !=0 implies the
>> +        * set of SIMD registers is used to config all SIMD registers.
>> +        * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
>> +        * config some SIMD registers on X86.
>> +        */
>> +       union {
>> +               __u16 sample_simd_regs_enabled;
>> +               __u16 sample_simd_pred_reg_qwords;
>> +       };
> Shouldn't there be 16-bits of reserved data here as the next __u32
> will require it for alignment?
>
>> +       __u32 sample_simd_pred_reg_intr;
>> +       __u32 sample_simd_pred_reg_user;
>> +       __u16 sample_simd_vec_reg_qwords;
> Shouldn't there be 48-bits of reserved data here as the next __u64
> will require it for alignment?
>
> I wonder the order should be:
> ```
> union {
> __u16 sample_simd_regs_enabled;
> __u16 sample_simd_pred_reg_qwords;
> };
> __u16 sample_simd_vec_reg_qwords;
> __u32 sample_simd_pred_reg_intr;
> __u32 sample_simd_pred_reg_user;
> __u32 __reserved_4;
> __u64 sample_simd_vec_reg_intr;
> __u64 sample_simd_vec_reg_user;

Yes, Peter has raised same question and it would be fixed in next version.


> ```
>
> Thanks,
> Ian
>
>> +       __u64 sample_simd_vec_reg_intr;
>> +       __u64 sample_simd_vec_reg_user;
>> +       __u32 __reserved_4;
>>  };
>>
>>  /*
>> @@ -1018,7 +1039,15 @@ enum perf_event_type {
>>          *      } && PERF_SAMPLE_BRANCH_STACK
>>          *
>>          *      { u64                   abi; # enum perf_sample_regs_abi
>> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> +        *        u64                   regs[weight(mask)];
>> +        *        struct {
>> +        *              u16 nr_vectors;
>> +        *              u16 vector_qwords;
>> +        *              u16 nr_pred;
>> +        *              u16 pred_qwords;
>> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +        *      } && PERF_SAMPLE_REGS_USER
>>          *
>>          *      { u64                   size;
>>          *        char                  data[size];
>> @@ -1045,7 +1074,15 @@ enum perf_event_type {
>>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
>>          *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
>>          *      { u64                   abi; # enum perf_sample_regs_abi
>> -        *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>> +        *        u64                   regs[weight(mask)];
>> +        *        struct {
>> +        *              u16 nr_vectors;
>> +        *              u16 vector_qwords;
>> +        *              u16 nr_pred;
>> +        *              u16 pred_qwords;
>> +        *              u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +        *        } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +        *      } && PERF_SAMPLE_REGS_INTR
>>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>>          *      { u64                   cgroup;} && PERF_SAMPLE_CGROUP
>>          *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>> --
>> 2.34.1
>>
