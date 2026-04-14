Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E443E5566
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174701; cv=none; b=SNbp+WBAS5pgUi4A7uu8W5qOuWHNnTXpgq38ZPqiuJJfQ6JjJw2S5n/b7YbCxpEZZvQP3DFHfVsxlCqE6TgolU0PuQywrf06LnVcxqDqwABz15J1P2k7sOC9yG3Bk08mVifD/9NfUOuC4pQUAY0VyFqminWlNveZ1XRJ3aKHQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174701; c=relaxed/simple;
	bh=NLSlLrSMZI3cUmOb7DTz8GAbCCesV31zq8QSjsFga28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+HEQDPoAjyCMY047HxdMcQQRp9b0DndFDBlGMHyduUi8E8mblncSg67L/o2XGSvYM90Ve3uCUOidGE9/YotMJ9LXeZ5j4nGvVSZexk5+cXqP0cypWpCfDCaSzgsivuhV9j6OSnGOhrxfsl38yqd5Y7A/WXsobJjTGw8Mr9Yo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h3/wEMVJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3/wEMVJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so1356832a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776174696; x=1776779496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPz3m1xG2VmGGvoQqOrcAUr+iF4l5uhVzIGYSCshb3I=;
        b=h3/wEMVJkWbz+89wn8Ii8e+UR/2q0q1rIm4uCj+0Q/5ItE/45/glu+NMSvsIJOv6zB
         Oanq/whHNAKAxlkcOlXYLAXoSInnEWZevFuEqu0ha/0WiV5Fq3MJcVQx0iDX3yWgWbTy
         Pkig5iHFGExaT5LcKNL/P/+xAm86J/o/c73jOPJogXGvA3DCGrF4Cc0IsY91BoyD9tZ6
         RgV+AZvzLTBTUjaZQCZuG6O5YZy425j4kI/6Vc4jprOUD1L6ZMie9IWVg33xl4DZoS6a
         N5saTSSoa7yGom7ELSJWFqaal43fnbYuCQOxeWdRY3dj8OMXC518sy0gZ8jpwqPP3wz8
         5hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174696; x=1776779496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPz3m1xG2VmGGvoQqOrcAUr+iF4l5uhVzIGYSCshb3I=;
        b=YJtakFKbunul66H68EWYCKfPpXL13fK2PdBtdJgReCxuWDC/nS4kgQMHHyAld8nmOh
         UCe4wqrR/oUrxpeC9MXQRXeAEHKrHw5D9V255kFtS/DMYDgIIwH16oKKtJTa/RQXhxfJ
         2dBJloGkaOQfEJy1bpzUu2P+E56kapoQY2/RbvauMHjeX0S9UFSLA6EYLzE5e9h09e7p
         eyRUadU9NNyNJhw5fKuxIAbXru+8oHMs80lq4J3Gw1ueCld7kOIK+CSKm5JGiSES4djy
         0y1MxRhB6g9w6w6bCAFmSVmskEsRfpJaBv1H5IME6UwEHJVRSHt6f0PNbqcrgehmwnCb
         eqpA==
X-Forwarded-Encrypted: i=1; AFNElJ9VcsOYsMfSR3zfPKa7j9hAsRBovJ+AGOrIqDbNoZfEA80aC2cYoNBb+zAYR58mvGFBv9zbxUQhT1AVVcffhVR1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7ic+wL5f1PaQbfviPrGJKPRJS6l8js85Q+TxyeUE3/gP5Lcy
	CGCm3OEoht0qflYdiAfdKngDD69HxhsRHm10BacTraFTfaWm7Kaev/B/rau+AqrCM1c=
X-Gm-Gg: AeBDiesRe0ivLon39NyHXlbVMTZq/lcZq5oTQbZf79bhGLlaeTVvhOnPwyUs01dTDMz
	ivQZ1iYFfgmc0geUK+wBmC7vZwm5WbGm4oJWsJ+t3XBjzq0vLEta2xXbJj4v9T/skICL+KbBa5O
	FUBUEQkbbXhhgbgFB6PUK+AOcag0os2KK5Yreyjq55LRkvxvMjNdhQ4grDkuR+Btphm3qSpNZ+5
	d7zVxdNbnJ7rUzmshXN58FEMYW9XL/OJvwbulXlKn13fHBspjXy2Ib8SLwC7ZQJL0jKAvTlhYZF
	DquAqdewrc327x4Z1VnwbUsBWX88+OSXd2BQyadIMZfCTNT9GoGuxEgiMMw7JI4DM5BCD9DCl6K
	NauZMNSPzSDJvJfCJu7qw+HbIeuCPnYTfaX+0ytYWbI+2JCXwKq+HDmiIBAby9Npgx+N1kOmmQS
	wqx4Dk0+vMP2ZU8jGPIil0qRqBkwgPat2UmQPLi7Bt
X-Received: by 2002:a05:6402:46cd:b0:670:2678:680f with SMTP id 4fb4d7f45d1cf-670786a3684mr5764211a12.5.1776174696416;
        Tue, 14 Apr 2026 06:51:36 -0700 (PDT)
Received: from [172.17.16.20] ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-670703f1340sm3248786a12.10.2026.04.14.06.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:51:35 -0700 (PDT)
Message-ID: <774cb091-cc24-420d-8cc6-88780746bceb@linaro.org>
Date: Tue, 14 Apr 2026 14:51:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-3-wutengda@huaweicloud.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260403094800.1418825-3-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/04/2026 10:47, Tengda Wu wrote:
> The jump and adrp instructions parsed by libcapstone currently lack
> symbolic representation and use a '#' prefix for addresses. This
> format is inconsistent with objdump's output, which causes subsequent
> parsing in jump__parse() and arm64_mov__parse() to fail.
> 
> Example mismatch:
>    Current: b #0xffff8000800114c8
>    Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>
> 
>    Current: adrp x18, #0xffff800081f5f000
>    Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
> 
> Fix this by implementing extended formatting for these arm64
> instructions during symbol__disassemble_capstone(). This ensures
> the output matches objdump's expected style, including the raw
> address and the associated <symbol+offset> suffix.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   tools/perf/util/capstone.c | 107 ++++++++++++++++++++++++++++++++-----
>   tools/perf/util/disasm.c   |   5 ++
>   tools/perf/util/disasm.h   |   1 +
>   3 files changed, 101 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 25cf6e15ec27..1d8421d2d98c 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -255,10 +255,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>   	struct map *map = args->ms->map;
>   	struct symbol *sym;
>   
> -	/* TODO: support more architectures */
> -	if (!arch__is_x86(args->arch))
> -		return;
> -
>   	if (insn->detail == NULL)
>   		return;
>   
> @@ -305,6 +301,98 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>   	}
>   }
>   
> +static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
> +				     size_t len, struct annotate_args *args,
> +				     u64 addr)
> +{
> +	int printed;
> +
> +	printed = scnprintf(buf, len, "       %-7s %s",
> +			    insn->mnemonic, insn->op_str);
> +	buf += printed;
> +	len -= printed;
> +
> +	print_capstone_detail(insn, buf, len, args, addr);
> +}
> +
> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> +				       size_t len, struct annotate_args *args,
> +				       u64 addr)
> +{
> +	struct map *map = args->ms->map;
> +	struct symbol *sym;
> +	char *last_imm, *endptr;
> +	u64 orig_addr;
> +
> +	scnprintf(buf, len, "       %-7s %s",
> +		  insn->mnemonic, insn->op_str);
> +	/*
> +	 * Adjust instructions to keep the existing behavior with objdump.
> +	 *
> +	 * Example conversion:
> +	 * From: b #0xffff8000800114c8
> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
> +	 */
> +	switch (insn->id) {
> +	case ARM64_INS_B:
> +	case ARM64_INS_BL:
> +	case ARM64_INS_CBNZ:
> +	case ARM64_INS_CBZ:
> +	case ARM64_INS_TBNZ:
> +	case ARM64_INS_TBZ:
> +	case ARM64_INS_ADRP:

Hi Tengda,

Is this supposed to be an exhaustive list of branches? If so using 
something like an is_branch() function might help make it work for new 
instructions with only an update to capstone. I don't know if capstone 
has a function like that but I did see it had instruction group types:

	// Generic groups
	// all jump instructions (conditional+direct+indirect jumps)
	ARM64_GRP_JUMP,	///< = CS_GRP_JUMP
	ARM64_GRP_CALL,
	ARM64_GRP_RET,
	ARM64_GRP_INT,
	ARM64_GRP_PRIVILEGE = 6, ///< = CS_GRP_PRIVILEGE
	ARM64_GRP_BRANCH_RELATIVE, ///< = CS_GRP_BRANCH_RELATIVE

> +		/* Extract last immediate value as address */
> +		last_imm = strrchr(buf, '#');
> +		if (!last_imm)
> +			return;
> +
> +		orig_addr = strtoull(last_imm + 1, &endptr, 16);
> +		if (endptr == last_imm + 1)
> +			return;
> +
> +		/* Relocate map that contains the address */
> +		if (dso__kernel(map__dso(map))) {
> +			map = maps__find(map__kmaps(map), orig_addr);
> +			if (map == NULL)
> +				return;
> +		}
> +
> +		/* Convert it to map-relative address for search */
> +		addr = map__map_ip(map, orig_addr);
> +
> +		sym = map__find_symbol(map, addr);
> +		if (sym == NULL)
> +			return;
> +
> +		/* Symbolize the resolved address */
> +		len = len - (last_imm - buf);
> +		if (addr == sym->start) {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
> +				  orig_addr, sym->name);
> +		} else {
> +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
> +				  orig_addr, sym->name, addr - sym->start);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void format_capstone_insn(struct cs_insn *insn, char *buf, size_t len,
> +				 struct annotate_args *args, u64 addr)
> +{
> +	/* TODO: support more architectures */
> +	if (arch__is_x86(args->arch))
> +		format_capstone_insn_x86(insn, buf, len, args, addr);
> +	else if (arch__is_arm64(args->arch))
> +		format_capstone_insn_arm64(insn, buf, len, args, addr);
> +	else {
> +		scnprintf(buf, len, "       %-7s %s",
> +			  insn->mnemonic, insn->op_str);

This is the same in three places. Maybe it could be a 
print_default_format() function.

> +	}
> +}
> +
>   struct find_file_offset_data {
>   	u64 ip;
>   	u64 offset;
> @@ -381,14 +469,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>   
>   	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
>   	for (i = 0, offset = 0; i < count; i++) {
> -		int printed;
> -
> -		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
> -				    "       %-7s %s",
> -				    insn[i].mnemonic, insn[i].op_str);
> -		print_capstone_detail(&insn[i], disasm_buf + printed,
> -				      sizeof(disasm_buf) - printed, args,
> -				      start + offset);
> +		format_capstone_insn(&insn[i], disasm_buf,
> +				     sizeof(disasm_buf), args,
> +				     start + offset);
>   
>   		args->offset = offset;
>   		args->line = disasm_buf;
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 40fcaed5d0b1..988b2b748e11 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -202,6 +202,11 @@ bool arch__is_powerpc(const struct arch *arch)
>   	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
>   }
>   
> +bool arch__is_arm64(const struct arch *arch)
> +{
> +	return arch->id.e_machine == EM_AARCH64;
> +}
> +
>   static void ins_ops__delete(struct ins_operands *ops)
>   {
>   	if (ops == NULL)
> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> index a6e478caf61a..d3730ed86dba 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -111,6 +111,7 @@ struct annotate_args {
>   const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
>   bool arch__is_x86(const struct arch *arch);
>   bool arch__is_powerpc(const struct arch *arch);
> +bool arch__is_arm64(const struct arch *arch);
>   
>   extern const struct ins_ops call_ops;
>   extern const struct ins_ops dec_ops;

