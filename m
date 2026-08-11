Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432A3876B5;
	Tue, 11 Aug 2026 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432169; cv=none; b=pvV/wDIuXGHxjBRwacRzMb+Lg6368HDTlCaXTihaOnPizvM4XFfoczl5SZAi1Kn0uUXxt2Zn2L2kVdu2U4ReqAeqotX29Wi10wrCXZHPyaeWPITYUWEfZA3DecJ5cbLSGwT76LEn+vHZdQDfQ26rN9xxzbod6Tzhl/M1XzVjeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432169; c=relaxed/simple;
	bh=xx+N85MR4jFfZ76Syst3QGU5eQ9xTKyyuqKLk7zcJfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWbIjAgZOqkql0gugve581dpFsIaFr1PFXX7aAxD6QZtqeXGmPGVrAQsvIvNlaZ/dSttJk304g9QbTLcblxuc86lVjmyRzzg2Ai+Y4ol+v4OjfeAStwfPFdI65USQR+3hzrZNLicznabYNTkkzgaS1vEk326rgD3e7opAbE53xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JxEBiL9P; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JxEBiL9P"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786432164; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vc+BFS4WJmnN5y1n1RnmfhtyEyF1ThJwQcH0ygcdV8c=;
	b=JxEBiL9Piu1vwNN8X+/XRwTaSUiCFrmBruYaLp/yn8M03ZSTSqF2Dhom3OZ4JN241zmet73MpTUJi2xkBPWYAiz5Kw8UzUpILwIvJ4jUCUmcjkZlgvW2xMUgztt3QxJ+mlHKfN3ZEiFenvmQ4Z/OX2UWf3us9NrnSyRyaovqkKY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nOX-J_1786432161;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nOX-J_1786432161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 15:09:22 +0800
Message-ID: <e06dc849-5471-4a11-b9ab-b55077c634f3@linux.alibaba.com>
Date: Tue, 11 Aug 2026 15:09:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/23] perf annotate-data: Extract
 invalidate_reg_state() as a common helper
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
 <20260808122400.2961238-12-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-12-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> The invalidate_reg_state() function is currently static and only used
> within the x86 data type profiling implementation. To prepare for adding
> arm64 instruction tracking support, extract it as a common helper that
> can be shared across architectures.
> 
> No functional change intended.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   tools/perf/util/annotate-arch/annotate-x86.c | 9 ---------
>   tools/perf/util/annotate-data.c              | 9 +++++++++
>   tools/perf/util/annotate-data.h              | 1 +
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> index 6044a68966f1..ee4e3e7f3209 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -207,15 +207,6 @@ static int x86__cpuid_parse(struct arch *arch, const char *cpuid)
>   }
>   
>   #ifdef HAVE_LIBDW_SUPPORT
> -static void invalidate_reg_state(struct type_state_reg *reg)
> -{
> -	reg->kind = TSR_KIND_INVALID;
> -	reg->ok = false;
> -	reg->lifetime_active = false;
> -	reg->lifetime_end = 0;
> -	reg->copied_from = -1;
> -}
> -
>   static void update_insn_state_x86(struct type_state *state,
>   				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
>   				  struct disasm_line *dl)
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 4e4c58764082..104b80d471f1 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -638,6 +638,15 @@ struct type_state_stack *findnew_stack_state(struct type_state *state,
>   	return stack;
>   }
>   
> +void invalidate_reg_state(struct type_state_reg *reg)
> +{
> +	reg->kind = TSR_KIND_INVALID;
> +	reg->ok = false;
> +	reg->lifetime_active = false;
> +	reg->lifetime_end = 0;
> +	reg->copied_from = -1;
> +}
> +
>   /* Maintain a cache for quick global variable lookup */
>   struct global_var_entry {
>   	struct rb_node node;
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index c26130744260..453e13bbe3e2 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -258,6 +258,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>   				Dwarf_Die *type_die, int ptr_offset);
>   struct type_state_stack *find_stack_state(struct type_state *state,
>   						int offset);
> +void invalidate_reg_state(struct type_state_reg *reg);
>   bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
>   				u64 ip, u64 var_addr, int *var_offset,
>   				Dwarf_Die *type_die);

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

