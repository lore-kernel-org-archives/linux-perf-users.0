Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19B3DA5B2;
	Mon, 10 Aug 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367335; cv=none; b=JaDDPcyZCXeNeACmAMRfHRfgi2GcTTMceoi+Xrj2HJQKfzXsUNkw9BzD140CIIHD7X/me/Cm4BjvYL7pnqGh8LQBRu/DihWcaOGT9uGn+EtFbb7LQnT7qWy2o3qXVTNFO+lHze9kGh5gtBTtTLseuzqCbsDcIe25DTBc6mj/HY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367335; c=relaxed/simple;
	bh=9JRQbZ4gs7XyP9ZQf9smFCJiXCllT5KpJ5Zl5H0sS1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kncr5afUXvxW6INGwUPNWfFAegs+bP1rWhLfwopJg46vD8Ze/XqzFLmabZJ3/vKkvzqSn7p4ZZpLRHkl9MusHnpUKpnaOcv2Jeyr8conkWPrxx6vpFpgb7AiSh+fUP+TK15Y6F/L+E++YBWK9EmXGlmsdeRzDUl4U51YXn1qkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YHgB/q5j; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YHgB/q5j"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786367318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8HFpxqi50PlxPU5HPYXDlO8V5JnkJJMznTwIpCnePtE=;
	b=YHgB/q5jG8lAC7xfBNVXiJ8QzppQTAChq35MU6pvG6udPiiseWlo3uD9QAq82fNW73z20F6HqTjcE37r3ZTgtl+OWTvV40eR7H7wQ4Yfj4Vln3uRnjLaLIQgEF2DIJTmTG9wUihzM9e91wCOvhAWd0TKDuoMFhjP5FulMH+LY1k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8jlzw3_1786367314;
Received: from 30.246.161.177(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8jlzw3_1786367314 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 21:08:36 +0800
Message-ID: <1b7e48ec-66a0-4727-b533-ff87f54df057@linux.alibaba.com>
Date: Mon, 10 Aug 2026 21:08:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
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
 <20260808122400.2961238-2-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-2-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
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
>   tools/perf/util/capstone.c | 136 +++++++++++++++++++++++++++++++++----
>   tools/perf/util/disasm.c   |   5 ++
>   tools/perf/util/disasm.h   |   1 +
>   3 files changed, 130 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 74213daf8786..fb8a2bc5558f 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -3,6 +3,7 @@
>   
>   #include <errno.h>
>   #include <inttypes.h>
> +#include <stdlib.h>
>   #include <string.h>
>   
>   #include <dlfcn.h>
> @@ -31,6 +32,10 @@
>   #define CS_MODE_RISCVC   4
>   #endif
>   
> +#if CS_VERSION_MAJOR < 4
> +#define ARM64_GRP_BRANCH_RELATIVE  7

Please add a comment explaining where '7' comes from
(CS_GRP_BRANCH_RELATIVE in capstone v3), otherwise it reads like an
arbitrary magic number.

> +#endif
> +
>   #ifdef LIBCAPSTONE_DLOPEN
>   static void *perf_cs_dll_handle(void)
>   {
> @@ -225,6 +230,12 @@ static int capstone_init(uint16_t e_machine, csh *cs_handle, bool is64, bool is_
>   		 * on x86 by investigating instruction details.
>   		 */
>   		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> +	} else if (arch == CS_ARCH_ARM64) {
> +		/*
> +		 * Same as x86: arm64 needs instruction details to resolve
> +		 * symbolic addresses.
> +		 */
> +		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>   	}
>   
>   	return 0;
> @@ -299,10 +310,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
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
> @@ -354,6 +361,116 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>   	}
>   }
>   
> +static int print_default_format(struct cs_insn *insn, char *buf, size_t len)
> +{
> +	return scnprintf(buf, len, "       %-7s %s",
> +			 insn->mnemonic, insn->op_str);
> +}
> +
> +static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
> +				     size_t len, struct annotate_args *args,
> +				     u64 addr)
> +{
> +	int printed;
> +
> +	printed = print_default_format(insn, buf, len);
> +	buf += printed;
> +	len -= printed;
> +
> +	print_capstone_detail(insn, buf, len, args, addr);
> +}
> +
> +static bool is_pc_relative_insn(struct cs_insn *insn)
> +{
> +	int i;
> +
> +	if (insn->id == ARM64_INS_ADR || insn->id == ARM64_INS_ADRP)
> +		return true;
> +
> +	if (insn->detail == NULL)
> +		return false;
> +
> +	for (i = 0; i < insn->detail->groups_count; i++) {
> +		if (insn->detail->groups[i] == ARM64_GRP_JUMP ||
> +		    insn->detail->groups[i] == ARM64_GRP_CALL ||
> +		    insn->detail->groups[i] == ARM64_GRP_BRANCH_RELATIVE)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> +				       size_t len, struct annotate_args *args)
> +{
> +	struct map *map = args->ms->map;
> +	struct symbol *sym;
> +	char *last_imm, *endptr;
> +	u64 orig_addr, addr;
> +	struct map *found_map = NULL;
> +
> +	print_default_format(insn, buf, len);
> +	/*
> +	 * Adjust instructions to keep the existing behavior with objdump.
> +	 *
> +	 * Example conversion:
> +	 * From: b #0xffff8000800114c8
> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
> +	 */
> +	if (is_pc_relative_insn(insn)) {
> +		/* Extract last immediate value as address */
> +		last_imm = strrchr(buf, '#');
> +		if (!last_imm)
> +			return;
> +
> +		orig_addr = strtoull(last_imm + 1, &endptr, 16);
> +		if (endptr == last_imm + 1)
> +			return;
> +
> +		addr = map__objdump_2mem(map, orig_addr);
> +
> +		/* Relocate map that contains the address */
> +		if (dso__kernel(map__dso(map))) {
> +			found_map = maps__find(map__kmaps(map), addr);
> +			if (found_map == NULL)
> +				return;
> +			map = found_map;
> +		}
> +
> +		/* Convert it to map-relative address for search */
> +		addr = map__map_ip(map, addr);
> +
> +		sym = map__find_symbol(map, addr);
> +		if (sym == NULL) {
> +			map__put(found_map);
> +			return;
> +		}
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
> +		map__put(found_map);


This whole sequence (objdump_2mem -> kmaps relocation -> map_ip ->
find_symbol -> scnprintf the "<sym+off>" string) is almost identical to
what print_capstone_detail() does for x86 RIP-relative operands.  Could
you factor out a common helper so the two paths don't diverge over time?

Thanks.
Shuai
