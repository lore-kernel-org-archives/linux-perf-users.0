Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D2407CCF;
	Tue, 11 Aug 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436171; cv=none; b=FzbRAEZs8FwK2q5kuP+aKqrTvd2I3AJhSZMYj9DcTXIGQEzKh58Vcj5Hf7yWtk7dJIHgxD1DWX3CJc2pDIQHgT8ioNCeVCtEO4rT/SQuMRgGmr2SLo403iGL53Jwb7D736vZfavHEG4FIRWMeA1lU7MRp8ojz7zXOpDG/2YrIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436171; c=relaxed/simple;
	bh=RgtUv4fH7brGCg7Om6rrPQZs2AUg+s2gH/HI8v02yJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD9s1t0BfG4KmMJ6X/wwNy3mtWqqdp/YMG7ZZZblZ+SqvXUCLC06fm4k6qCWdOFg9IA1oZ9iXE6/IgbWKJRScEw7DQTStnmSfByHSemIEIFgJl3X4aTkSm1Eq0Bl9DKJJJBrIVeRXnADtK1ypffbuT77LyCIMcbXIqg89iTtUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pC1JI9Ay; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pC1JI9Ay"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786436165; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eP3m0HTYV+unjAOWZeJIknn2a8XQLBdPGdXKRx+SfjI=;
	b=pC1JI9AyWTa6w7LvocLqbi1BkqBsYC8a21g16F2rE+2QQdlztf3ODIxwKPvaq8kqr8rGrviBoOU8oW8LLzpAfjEEtd+7DC3RlQuIOMmvMQwvy8JoHWY1ydg7VWaLKzv1sf2dpk3A8kOuk5HJfwFc1UWeoZWZE6+8APbb9Ol1IlQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8ndp3v_1786436162;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8ndp3v_1786436162 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:16:03 +0800
Message-ID: <8bdc13c7-5277-4489-a5d1-9cae14f88beb@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:16:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/23] perf annotate-data: Track imm_value for stack
 variables
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
 <20260808122400.2961238-18-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-18-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Currently, imm_value are tracked in registers but dropped when values

Nit: s/imm_value are tracked/imm_value is tracked/ in the changelog.

> are saved to or loaded from stack variables during type profiling.
> If a register of type TSR_KIND_CONST is stored to the stack, its value
> will be lost.
> 
> Add an imm_value field to struct type_state_stack and update
> set_stack_state() and findnew_stack_state() to accept and preserve the
> immediate value when updating stack state.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   tools/perf/util/annotate-arch/annotate-x86.c |  8 ++++++--
>   tools/perf/util/annotate-data.c              | 13 +++++++------
>   tools/perf/util/annotate-data.h              |  5 +++--
>   3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> index eec3d8ce00b8..995117525e7d 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -591,6 +591,7 @@ static void update_insn_state_x86(struct type_state *state,
>   				tsr->type = stack->type;
>   				tsr->kind = stack->kind;
>   				tsr->offset = stack->ptr_offset;
> +				tsr->imm_value = stack->imm_value;
>   				tsr->ok = true;
>   			} else if (die_get_member_type(&stack->type,
>   						       offset - stack->offset,
> @@ -598,6 +599,7 @@ static void update_insn_state_x86(struct type_state *state,
>   				tsr->type = type_die;
>   				tsr->kind = TSR_KIND_TYPE;
>   				tsr->offset = 0;
> +				tsr->imm_value = 0;
>   				tsr->ok = true;
>   			} else {
>   				invalidate_reg_state(tsr);
> @@ -773,10 +775,12 @@ static void update_insn_state_x86(struct type_state *state,
>   				 */
>   				if (!stack->compound)
>   					set_stack_state(stack, offset, tsr->kind,
> -							&tsr->type, tsr->offset);
> +							&tsr->type, tsr->offset,
> +							tsr->imm_value);
>   			} else {
>   				findnew_stack_state(state, offset, tsr->kind,
> -						    &tsr->type, tsr->offset);
> +						    &tsr->type, tsr->offset,
> +						    tsr->imm_value);
>   			}
>   
>   			if (dst->reg1 == fbreg) {
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index c51b20a7af9b..9dcdc3c7e688 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -590,7 +590,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
>   }
>   
>   void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
> -			    Dwarf_Die *type_die, int ptr_offset)
> +			    Dwarf_Die *type_die, int ptr_offset, u64 imm_value)
>   {
>   	int tag;
>   	Dwarf_Word size;
> @@ -607,8 +607,9 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>   	stack->offset = offset;
>   	stack->ptr_offset = ptr_offset;
>   	stack->kind = kind;
> +	stack->imm_value = imm_value;
>   
> -	if (kind == TSR_KIND_POINTER) {
> +	if (kind == TSR_KIND_POINTER || kind == TSR_KIND_CONST) {
>   		stack->compound = false;
>   		return;
>   	}
> @@ -629,18 +630,18 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>   struct type_state_stack *findnew_stack_state(struct type_state *state,
>   						    int offset, u8 kind,
>   						    Dwarf_Die *type_die,
> -						    int ptr_offset)
> +						    int ptr_offset, u64 imm_value)
>   {
>   	struct type_state_stack *stack = find_stack_state(state, offset);
>   
>   	if (stack) {
> -		set_stack_state(stack, offset, kind, type_die, ptr_offset);
> +		set_stack_state(stack, offset, kind, type_die, ptr_offset, imm_value);
>   		return stack;
>   	}
>   
>   	stack = malloc(sizeof(*stack));
>   	if (stack) {
> -		set_stack_state(stack, offset, kind, type_die, ptr_offset);
> +		set_stack_state(stack, offset, kind, type_die, ptr_offset, imm_value);
>   		list_add(&stack->list, &state->stack_vars);
>   	}
>   	return stack;
> @@ -935,7 +936,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>   				continue;
>   
>   			findnew_stack_state(state, offset, TSR_KIND_TYPE,
> -					    &mem_die, /*ptr_offset=*/0);
> +					    &mem_die, /*ptr_offset=*/0, /*imm_value=*/0);
>   
>   			if (var->reg == state->stack_reg) {
>   				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 91b83e94c51b..06fc4dbfb35c 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -199,6 +199,7 @@ struct type_state_stack {
>   	int size;
>   	bool compound;
>   	u8 kind;
> +	u64 imm_value;
>   };
>   
>   /*
> @@ -253,9 +254,9 @@ bool has_reg_type(struct type_state *state, int reg);
>   struct type_state_stack *findnew_stack_state(struct type_state *state,
>   						int offset, u8 kind,
>   						Dwarf_Die *type_die,
> -						int ptr_offset);
> +						int ptr_offset, u64 imm_value);
>   void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
> -				Dwarf_Die *type_die, int ptr_offset);
> +				Dwarf_Die *type_die, int ptr_offset, u64 imm_value);
>   struct type_state_stack *find_stack_state(struct type_state *state,
>   						int offset);
>   void invalidate_reg_state(struct type_state_reg *reg);


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

