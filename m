Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F93AEB5C;
	Tue, 11 Aug 2026 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431061; cv=none; b=jBRYsUbENrd26eGpQ76QF36GIgAS61El5mnxNFUbUNrMT1rH5m8dnbQzBJOqo+mG81+Fdg2xlbgq194v68+HivULT9B7X+1sdnV4bSCcuYFk1oVS79ShHabh32inT23UYDEkbpJql1V+JgUP5ICnfhiIxMl1ifnymGNYXDy3iTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431061; c=relaxed/simple;
	bh=crxR32He+XzYxpnKBFMgsnnLzSNSVnebE1DRVobhNV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPnYHUHUHxXyQthXrWHGc1lVosUQMAb5s/44aTWZWCxv+Uy0eE3Ge/qv2Ns3s+2I1oMODl2NrDf3+ajM1FiC86tODCbzmXifnely/QobufTlZjoJ223ZNoLafHUdd3lZNWiKJG31110/zTm7TI1O6Js20xuHqOw06YMtxQI0iSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UjsK/aUU; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UjsK/aUU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786431053; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tC8DiUQP4pMdDpx0oMc6PpZVvsRo5oGqnyN7acE838Y=;
	b=UjsK/aUUHY6v+zuMpu1DDEPDFIg0MpCRGRrQrR5JrMlbbLqTzUoMHs9ws68eDguFmSQb4HwSVFWTPTIAWM9+4t8Vsx3chd5B9ioh/WvLXP9mb2SCgcPm5I/IJt/ZGjpmToEn8CwQenJ9I1+ezTOv5WiYP0FOB2fa48xf0MDuuYA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nOQ81_1786431050;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nOQ81_1786431050 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 14:50:51 +0800
Message-ID: <1ade663e-da3a-4cc2-bbf9-21d61384dd9b@linux.alibaba.com>
Date: Tue, 11 Aug 2026 14:50:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/23] perf annotate-arm64: Implement
 extract_op_location() callback
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
 james.clark@linaro.org, Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-9-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-9-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Implement the extract_op_location() callback for the arm64 architecture
> to handle its specific assembly syntax and addressing modes.
> 
> The extractor handles:
> 1. Standalone immediate operands (e.g., #0x10).
> 2. Memory references with diverse addressing modes:
>     - Signed offset: [base{, #imm|reg}]
>     - Pre-index: [base, #imm]!
>     - Post-index: [base], #imm|reg
> 3. Multi-register operands and primary/secondary register extraction.
> 
> With this callback in place, 'perf annotate' can now resolve memory
> locations and register types on arm64, marking the initial enablement
> of data type profiling for this architecture.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   .../perf/util/annotate-arch/annotate-arm64.c  | 67 +++++++++++++++++++
>   tools/perf/util/annotate.h                    | 10 +++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 32752a3bc756..6b4f1228afa9 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -287,6 +287,72 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
>   	return ops;
>   }
>   
> +static int extract_op_location_arm64(const struct arch *arch,
> +				     struct disasm_line *dl __maybe_unused,
> +				     const char *op_str, int op_idx __maybe_unused,
> +				     struct annotated_op_loc *op_loc)
> +{
> +	const char *s = op_str;
> +	char *p = NULL;
> +
> +	if (op_str == NULL)
> +		return 0;
> +
> +	/* Handle standalone immediate operands (e.g., #0x10) */
> +	if (*s == arch->objdump.imm_char) {
> +		op_loc->offset = strtol(s + 1, &p, 0);
> +		if (p && p != s + 1)
> +			op_loc->imm = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Handle memory references, identify arm64 specific addressing modes.
> +	 * Reference: Arm Architecture Reference Manual
> +	 *            (DDI 0487), Chapter C1.3.3: Load/store addressing modes.
> +	 */
> +	if (*s == arch->objdump.memory_ref_char) {
> +		op_loc->mem_ref = true;
> +
> +		p = strchr(s, ']');
> +		if (p == NULL)
> +			return -1;
> +
> +		/* Pre-index: [base, #imm]! */
> +		if (p[1] == '!')
> +			op_loc->addr_mode = PERF_ADDR_MODE_PRE_INDEX;
> +		/* Post-index: [base], #imm|reg */
> +		else if (p[1] == ',' &&
> +			 (strchr(p + 1, arch->objdump.imm_char) ||
> +			  arm64__is_reg(skip_spaces(p + 2))))
> +			op_loc->addr_mode = PERF_ADDR_MODE_POST_INDEX;
> +		/* Signed offset: [base{, #imm|reg}] */
> +		else
> +			op_loc->addr_mode = PERF_ADDR_MODE_SIGNED_OFFSET;
> +
> +		s++;
> +	}
> +
> +	/* Extract the primary register */
> +	op_loc->reg1 = arch__dwarf_regnum(arch, s);
> +	if (op_loc->reg1 == -1)
> +		return -1;
> +
> +	/* Move to the next symbol of the operand, if any */
> +	s = strchr(s, ',');
> +	if (s == NULL)
> +		return 0;
> +	s = skip_spaces(s + 1);
> +
> +	/* Extract secondary register or immediate offset */
> +	if (op_loc->multi_regs)
> +		op_loc->reg2 = arch__dwarf_regnum(arch, s);
> +	else if (*s == arch->objdump.imm_char)
> +		op_loc->offset = strtol(s + 1, &p, 0);
> +
> +	return 0;
> +}
> +
>   const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>   				   const char *cpuid __maybe_unused)
>   {
> @@ -305,6 +371,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>   	arch->objdump.memory_ref_char	  = '[';
>   	arch->objdump.imm_char		  = '#';
>   	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
> +	arch->extract_op_location	  = extract_op_location_arm64;
>   
>   	/* bl, blr */
>   	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 11b6e4780c02..a44c933f55f5 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -494,12 +494,21 @@ int annotate_check_args(void);
>   
>   int arch__dwarf_regnum(const struct arch *arch, const char *str);
>   
> +enum annotated_addr_mode {
> +	PERF_ADDR_MODE_NONE = 0,
> +
> +	PERF_ADDR_MODE_SIGNED_OFFSET,
> +	PERF_ADDR_MODE_PRE_INDEX,
> +	PERF_ADDR_MODE_POST_INDEX,
> +};
> +
>   /**
>    * struct annotated_op_loc - Location info of instruction operand
>    * @reg1: First register in the operand
>    * @reg2: Second register in the operand
>    * @offset: Memory access offset in the operand
>    * @segment: Segment selector register
> + * @addr_mode: Addressing mode, only valid if @mem_ref is true
>    * @mem_ref: Whether the operand accesses memory
>    * @multi_regs: Whether the second register is used
>    * @imm: Whether the operand is an immediate value (in offset)
> @@ -509,6 +518,7 @@ struct annotated_op_loc {
>   	int reg2;
>   	int offset;
>   	u8 segment;
> +	u8 addr_mode;
>   	bool mem_ref;
>   	bool multi_regs;
>   	bool imm;

I've checked the addressing mode classification against DDI 0487
C1.3.3 and it looks right, including the tricky cases:

   - [x1, w0, sxtw #3] correctly falls through to SIGNED_OFFSET
     (no '#' after ']' and 'sxtw' is not a register);
   - post-index detection handles both immediate and register
     writeback forms;
   - the downstream use is consistent too: post-index accesses happen
     at the old base, so get_reg_index_offset() returning 0 there is
     correct.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

