Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C929411F9E;
	Tue, 11 Aug 2026 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435224; cv=none; b=pexwx01zFQHUYdM6IIEgP23sHLaxnBQRTyJfI9wKphfQZu5YoX5FKVAlSoskI0vYfDCrITr5ABv29H8m84WkOX9mQu8H6LPW4DnKiXTKSfUOoXVoU8BMy7pgYsRGgLwxFAsMPYEvC8Ung/sdQZP65+h86CGXL89rKjU51Me62P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435224; c=relaxed/simple;
	bh=Aco5T2ui+aYcCewJlzNQiSVYc+VsUxN0/c2MM2L1THM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhcGgUWMrPNy58QNlC+o77JjGD+OClnPw/kw6+KndzM7MqSD89FlnTuiS9Kuaxz6N/udO8CP3//gGxW7lrWPslHk2FEa9x5kbBjndi7nOpwI2jytjdpS+Z8xuI+Re6MTHesM9Zy9hqU5cB0FWfzFgOuZ3paIrY8uwMWut88AIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eP++POMm; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eP++POMm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786435210; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FhmoGottEGhESaL5bhl8XY8JUHiobeIh5KjvbQLXFN4=;
	b=eP++POMm2qixr4tnQqZSTuxYJrHR98wm22cA8gL0fSSFigVCMp/0V+U9A1l2hILCVmusMlei3zcmBKkPj4JY7HEt5gvr7CVybAh/pyxHJA2Piw4946gFPgOfyZ5O9pY7pujdDJAhZVKk14QGPza6MnSAdrT1RNqM/ucRdKeNlGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nhmBY_1786435207;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nhmBY_1786435207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:00:08 +0800
Message-ID: <0b47de5a-b46a-4904-93a1-f6d315336a30@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:00:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/23] perf annotate-arm64: Support store instruction
 tracking
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
 <20260808122400.2961238-16-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-16-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to handle store (STR) instructions.
> 
> Unlike load instructions, a store instruction sets a value in the struct
> within the memory where the destination register resides, and does not
> alter its type. Therefore, no processing is required for the transfer.
> 
> The only point to note is that store instructions support pre-index and
> post-index addressing modes, so calling adjust_reg_index_state() is still
> necessary to handle their addressing.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   tools/perf/util/annotate-arch/annotate-arm64.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 6557c0ad11b2..ed0f0ef2877d 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -560,7 +560,7 @@ static void update_insn_state_arm64(struct type_state *state,
>   	 * prevent stale type info from propagating to subsequent instructions.
>   	 */
>   	if (has_reg_type(state, dst->reg1) &&
> -	    strncmp(dl->ins.name, "ld", 2)) {
> +	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
>   		pr_debug_dtp("%s [%x] invalidate reg%d",
>   			     dl->ins.name, insn_offset, dst->reg1);
>   		invalidate_reg_state(&state->regs[dst->reg1]);
> @@ -575,6 +575,17 @@ static void update_insn_state_arm64(struct type_state *state,
>   	/* Memory to register transfers */
>   	if (!strncmp(dl->ins.name, "ld", 2))
>   		update_load_insn_state(state, dl, src, dst);
> +	/* Register to memory transfers */
> +	else if (!strncmp(dl->ins.name, "st", 2)) {
> +		/*
> +		 * Ignore transfers since it'd set a value in a struct
> +		 * and won't change the type.
> +		 *
> +		 * Needs to update the pre-index and post-index addressing
> +		 * modes for the destination register.
> +		 */
> +		adjust_reg_index_state(state, dst, "str", insn_offset);
> +	}
Two points on this call:

First, adjust_reg_index_state() gets post-index with a register
writeback amount wrong, e.g. str x1, [x0], x2. There the memory
operand has multi_regs set (x0 and x2), so reg2 gets the offset
register and op_loc->offset stays 0. The adjustment then degenerates
to offset += 0, and the base keeps its old type and offset while in
reality it moved by an unknown amount - every later access through it
resolves to the wrong struct field. Pre-index is fine since
[base, reg]! isn't a valid encoding, but the post-index register form
should fall back to invalidating the base:

     if (op_loc->multi_regs) {
         invalidate_reg_state(tsr);
         return;
     }

This applies to the load path too since it shares
adjust_reg_index_state().

Second, a nit: the insn name is hardcoded to "str", so stp/stlr and
pre/post-indexed variants all print as "str" in the debug output.
Pass dl->ins.name instead.


Thanks.
Shuai
