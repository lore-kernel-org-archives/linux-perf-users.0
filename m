Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82A412C03;
	Tue, 11 Aug 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435812; cv=none; b=q1XFb+rGfOtSKiM1vaSk7yb7A5erzBKZab4TP3BFFyMXBqM1y1JmdFTsIFMNA5bldNmByJXmRV3O7W6WOIlgaZ7Xw77g78TB9ywSGr2zKxEoaRMQNvc3PRMyyqJcRwuykzTIdFGcGT2fDutNGyPC9VB3QLINtb3bn25sAGWxvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435812; c=relaxed/simple;
	bh=gVthLqExaptrCH8/8pHTojmPlrbu/fSpte/UF3wy/ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6cmMUIa8R/tCU/XwQqSlxrByblYf1f14o76fusbW9WTrBkDGysLE1bsMEO+Z8GBShu3L+bX5r2Pn1DACOyY/CpNreng7yrlMzrl0iBpS1C734fhN4KARjdafxa+GktL0mg5x8bqLrALyokZqWb+exz8VR0SdmPB783n9f7flvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aZkU7l2N; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aZkU7l2N"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786435805; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ULRyzUzSMuZOhpoovZ69zlkbe3+TVMTW91xLI1cZab8=;
	b=aZkU7l2NdD6S2wZSzQzS1JkmPJUe2sKSM57EaF4cMkWpth6zaJSVWfiCIPZz+EgeidL0we1HmvDViOtAnrc+agDdtb+xNuRQBwYpLuckKtPaMkRS8O3CQVvESnBx5tc92ozQoXBjoSRAAoJJpnObs28X/KCktHyVzr1Lyoj6gr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nd1Ff_1786435801;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nd1Ff_1786435801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:10:03 +0800
Message-ID: <861296f2-a17e-483a-8b46-74ba777958d5@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:10:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/23] perf annotate-data: Expand type_state_reg
 imm_value to u64
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
 <20260808122400.2961238-17-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-17-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> The imm_value in struct type_state_reg is defined as u32, which limits
> the size of values it can pass.
> 
> Promote imm_value from u32 to u64 and adjust the print format specifier
> in pr_debug_dtp() accordingly.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   tools/perf/util/annotate-arch/annotate-x86.c | 2 +-
>   tools/perf/util/annotate-data.h              | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> index ee4e3e7f3209..eec3d8ce00b8 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -540,7 +540,7 @@ static void update_insn_state_x86(struct type_state *state,
>   			tsr->offset = 0;
>   			tsr->ok = true;
>   
> -			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
> +			pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
>   				     insn_offset, tsr->imm_value, dst->reg1);
>   			return;
>   		}
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 453e13bbe3e2..91b83e94c51b 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -173,7 +173,7 @@ extern struct annotated_data_stat ann_data_stat;
>    */
>   struct type_state_reg {
>   	Dwarf_Die type;
> -	u32 imm_value;
> +	u64 imm_value;
>   	/*
One subtlety this introduces: annotated_op_loc.offset is an int, and
immediates are parsed into it via strtol(), so assignments like
tsr->imm_value = src->offset now sign-extend instead of preserving
the 32-bit bit pattern. mov $0xdeadbeef used to track 0xdeadbeef,
now it tracks 0xffffffffdeadbeef, while the register actually holds
the zero-extended value. (Canonical kernel addresses happen to
sign-extend back to the right value, which masks this in the common
case.)

Relatedly, this widening doesn't actually help 64-bit immediates on
the strtol() path - movabs is still truncated to int at parse time.
The real consumers that need u64 are the arm64 adrp and stack paths,
which feed imm_value from ops.source.addr / stack state directly, so
the change is justified. But maybe worth spelling that out, and
considering a follow-up that parses immediates with strtoull() into a
dedicated u64 field instead of overloading the signed offset field.

Thanks,
