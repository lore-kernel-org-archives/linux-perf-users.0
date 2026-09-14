Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325445563C;
	Mon, 14 Sep 2026 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388114; cv=none; b=hhy+IiTAT7DWrytHMqOS8LDs8fwhECsKq+xizOkteoP+O8rAPu5DugHXHxcby33ikh0DlnPbVuqR9GhghXSuQuE53OCWdV5VJaDwyHcc+eWCzVLI+kkaIhyqpINNs5opVMZUadcELqn87Nz67aKBmOEJbTBBeRwzmSTQSdDz4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388114; c=relaxed/simple;
	bh=V4v29hqphf71drKAKxNYS2bGk7KT06PPuG3ckTO1o2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7jOmxU1+1BHiL7tG2x1peslm4+ORIt9k3QV/MHn0YNa/i2PjFq1VSagZo6dvnsLZlENnu3X4VWk4cgf7Br0+PgszF8r3gpQW4ARhNYQkdo3+NUirdlkUIkADozraqmDfR1/5a9VJWviCcBXO4aoDhjubXd08QeaAibIKpjCuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hk3xL4TcZzKHMWL;
	Mon, 14 Sep 2026 20:14:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B1EBA4056D;
	Mon, 14 Sep 2026 20:14:57 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC3eG1A5adqaVsSAQ--.53660S2;
	Mon, 14 Sep 2026 20:14:57 +0800 (CST)
Message-ID: <a8320365-6bf9-4db4-b05e-7776a6089a98@huaweicloud.com>
Date: Mon, 14 Sep 2026 20:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
 Yanbo Zhao <yzhao62@ncsu.edu>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-3-namhyung@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260914064535.1671939-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3eG1A5adqaVsSAQ--.53660S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4UtrWrtFy5XFWruw4kZwb_yoWrGr43pF
	4UCw13Ar4UGF4Ikw1fX3Z5u3yrt3yxXFWFya93C34xAry7XF17uF97Kr1Ygw4rKr4DAw4I
	kr1DGw4UGan7XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/14 14:45, Namhyung Kim wrote:
> The die_has_flex_array() returns true when the given type is a compound
> type and contains an array at the end.  To prevent an infinite recursion
> add a depth field to the internal function.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 77 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  3 ++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7ab3..465824e6513eb0ac 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -2180,3 +2180,80 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
>  
>  	return die_get_member_type(&type_die, offset, die_mem);
>  }
> +
> +static bool is_flex_array_member(Dwarf_Die *mb_die)
> +{
> +	Dwarf_Die type_die;
> +	Dwarf_Word size;
> +
> +	/* get the type of the member */
> +	if (die_get_real_type(mb_die, &type_die) == NULL)
> +		return false;
> +
> +	if (dwarf_tag(&type_die) != DW_TAG_array_type)
> +		return false;
> +
> +	return dwarf_aggregate_size(&type_die, &size) < 0 || size == 0;
> +}
> +
> +#define MAX_FLEX_ARRAY_RECURSION  256  /* arbitrary */
> +
> +static bool die_has_flex_array_recurse(Dwarf_Die *parent_die, int depth)
> +{
> +	Dwarf_Die die_mem, last_mb;
> +	int tag = dwarf_tag(parent_die);
> +
> +	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type)
> +		return false;
> +
> +	/* prevent infinite recursion */
> +	if (depth > MAX_FLEX_ARRAY_RECURSION)
> +		return false;
> +
> +	if (dwarf_child(parent_die, &die_mem))
> +		return false;
> +
> +	do {
> +		if (dwarf_tag(&die_mem) != DW_TAG_member)
> +			continue;
> +
> +		if (tag == DW_TAG_union_type) {
> +			if (is_flex_array_member(&die_mem))
> +				return true;
> +
> +			if (die_get_real_type(&die_mem, &last_mb) &&
> +			    die_has_flex_array_recurse(&last_mb, depth + 1))
> +				return true;
> +		}
> +
> +		if (tag == DW_TAG_structure_type)
> +			memcpy(&last_mb, &die_mem, sizeof(last_mb));
> +
> +	} while (dwarf_siblingof(&die_mem, &die_mem) == 0);
> +
> +	if (tag == DW_TAG_structure_type) {
> +		if (is_flex_array_member(&last_mb))

Not sure if this case can actually happen, but adding a check for whether
last_mb is valid is probably better. (I see Sashiko flagged this too.)

Thanks,
Tengda

> +			return true;
> +
> +		if (die_get_real_type(&last_mb, &die_mem))
> +			return die_has_flex_array_recurse(&die_mem, depth + 1);
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * die_has_flex_array - Check if the given type has a flex-array at the end
> + * @parent_die: a pointer to type DIE
> + *
> + * This function returns %true iff @parent_die is a struct type and has an
> + * array at the end.  Note that the flex-array has no element, it should have
> + * no size and the parent size doesn't include the flex-array.  So it should
> + * locate at the offset of the parent size.
> + *
> + * For simplicity, it assumes the parent size of aligned with the flex-array.
> + */
> +bool die_has_flex_array(Dwarf_Die *parent_die)
> +{
> +	return die_has_flex_array_recurse(parent_die, 0);
> +}
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 161f0bf980b6ee6a..9b662db710220522 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -189,4 +189,7 @@ void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types)
>  /* Get the frame base information from CFA */
>  int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
>  
> +/* Check whether given type has a flex array */
> +bool die_has_flex_array(Dwarf_Die *parent_die);
> +
>  #endif /* _DWARF_AUX_H */

