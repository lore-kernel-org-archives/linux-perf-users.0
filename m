Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135653264F1;
	Tue, 11 Aug 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430015; cv=none; b=uKZ1EtNaLGysF9OZjjXenIB5RNtU5iFhNWhvanFbHM21kxGa5r4bK0QU17X4VGHHMrbzxP9Ax1J1K4kOqfnErMqtURWh5t6G/i4yKfeH/QHc4A2TNjjywpjKO8cxIM7Xn/ETf1V71D1q9zLq76KdI2wscFNiJNiZ6+N76CN/tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430015; c=relaxed/simple;
	bh=m3Qbe75JbAe/WQ7pJMJF0xUrfyW1YPSMjsh1fo5KP+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur4r2ZJ2trI6Zwa7YGcKLvefbztjxzNZkEtEPo94ckoZBlvxgwPkc2oZaEfpPMOIcbAh+8LjIl2VHSxcSZa1VvY+LyTyMH+Go93o5F/dKj5LNmJyJ17dmHASzGQsv8JyS1SeQ1/usnguc/x6q4L2OmJT1G+OGpX+2BWsywCCPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bbq0H8GT; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bbq0H8GT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786430004; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SUHabi4+/mXpps0/lo/jkNYxqLlc5wUDWOEA+Q9bMOo=;
	b=bbq0H8GTXLLSXTIQijpmCjp3Wez3atDcx+emSSjdvWYSweAAcMT9qcJMqNBsgWIDOQ5Wvwz3YA1aqPaC4U73oLhnzRQP3PNPbcUdNstbPeyvpvn32XvI9j0IjgPWCxdJQ5e5dcRm5OyKuoUs6flKWc8T/T0StX92fdznKJBkIxE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nOJT3_1786430001;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nOJT3_1786430001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 14:33:22 +0800
Message-ID: <1d2e807f-5ced-4af5-86c8-9cd3e89a7ba2@linux.alibaba.com>
Date: Tue, 11 Aug 2026 14:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
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
 <20260808122400.2961238-7-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-7-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Currently, arch__dwarf_regnum() assumes that all architectures use a
> register prefix character (e.g., '%' for x86) defined by
> arch->objdump.register_char, and uses it to match register names in
> objdump output. However, this assumption does not hold for arm64,
> where assembly syntax uses bare register names like 'x0', 'w1'
> without any prefix.
> 
> As a result, arm64 builds may fail to correctly recognize register
> names from objdump disassembly, leading to incomplete or incorrect
> annotation output.
> 
> To address this:
> 
> - Make the register prefix check optional, allowing architectures
>    without a prefix character to be parsed correctly.
> 
> - Extend the delimiter set in strpbrk() to include the closing square
>    bracket ']'. In arm64 assembly, memory operands often use bracketed
>    syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
>    extraction of register names like 'x2' without trailing characters.
> 
> - Remove the 'static' qualifier from arch__dwarf_regnum() so that it
>    can be reused by other architecture-specific profiling components
>    in future changes.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   tools/perf/util/annotate.c | 14 ++++++++------
>   tools/perf/util/annotate.h |  2 ++
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index df70e95a8470..9d8b4d6b859b 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2472,21 +2472,23 @@ int annotate_check_args(void)
>   	return 0;
>   }
>   
> -static int arch__dwarf_regnum(const struct arch *arch, const char *str)
> +int arch__dwarf_regnum(const struct arch *arch, const char *str)
>   {
> -	const char *p;
> +	const char *p = str;
>   	char *regname, *q;
>   	int reg;
>   
> -	p = strchr(str, arch->objdump.register_char);
> -	if (p == NULL)
> -		return -1;
> +	if (arch->objdump.register_char) {
> +		p = strchr(str, arch->objdump.register_char);
> +		if (p == NULL)
> +			return -1;
> +	}
>   
>   	regname = strdup(p);
>   	if (regname == NULL)
>   		return -1;


Keeping the early -1 return here is correct, but it exposes an
inconsistency in this function's failure values. This is the only path
that returns -1; when the lookup itself fails the tail returns whatever
get_dwarf_regnum() produced (-ENOENT on arm64, -EINVAL/-ENOENT on x86).
The callers only check

     if (op_loc->reg1 == -1)

so the early return is caught while a real parse failure slips through
with a negative reg1. Today that is harmless because every consumer
guards with has_reg_type(), whose unsigned compare rejects negative
values, but the error propagation is effectively broken and arm64 adds
more inputs that fail parsing (prfm ops, PC-relative addresses).

Could you normalise the tail to keep the "success or -1" contract?

     reg = get_dwarf_regnum(regname, arch->id.e_machine,
                    arch->id.e_flags);
     free(regname);
     return reg < 0 ? -1 : reg;

Thanks.
Shuai
