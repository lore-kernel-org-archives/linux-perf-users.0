Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17A30D405;
	Fri, 16 Oct 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113267; cv=none; b=WjhLJvm8t7YPt+HuBH7Us4UUEuJz52Fgo/+WcgySshwkY6sl2b3em9hAVs6XLS1BOlu/mVAba7Z+Io1jXEEnaQ1dmFG5ClU0DHhdNCCi6d/Q2JdN4xdIxLz8UzzMPxygpwjQ7s3Ov/AbWmFnydzXMm1tNrRJkzy++8s1Q7ATFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113267; c=relaxed/simple;
	bh=utYDO2knyr3kTzqHGy2mLzrgeNKbg7RW6hWzjUnMa+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyfyByWvNmjXx5p3UeRu5pRiANSO2+/9Cr/336MkMdumhaBX4iY3xkLxp60j/JmV0cXGNZuknImBv8WreBAMB4hZKi3ePoVP+gdi9DSXZZrBOCZ2jMbCpWVV1RoUhC/+fFv2paGhuBgNrM0bdANKU+W+QoKy+mKmE+eTVmrPy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j5RlM2PQszYQts3;
	Fri, 16 Oct 2026 09:13:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E3F9340577;
	Fri, 16 Oct 2026 09:14:14 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBnav1letFqppRiAg--.4825S2;
	Fri, 16 Oct 2026 09:14:14 +0800 (CST)
Message-ID: <71090bb4-dd82-415c-a0cd-5ce11841e261@huaweicloud.com>
Date: Fri, 16 Oct 2026 09:14:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/15] perf annotate-arm64: Support store instruction
 tracking
To: Namhyung Kim <namhyung@kernel.org>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>
 <atFbbrGdobp83fgA@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <atFbbrGdobp83fgA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnav1letFqppRiAg--.4825S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF17WFWxGr18uw15tF4UCFg_yoW5CrWkpr
	Z8C3W5KF4Utr4IgFnxXF4j9r9I9a1Sgws0kr9rt397AF42yrn3Krs5Ka13KFWrJrZxuw1U
	ta1DKr1DGayjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/16 7:02, Namhyung Kim wrote:
> On Tue, Oct 13, 2026 at 01:28:04PM +0000, Tengda Wu wrote:
>> Extend update_insn_state_arm64() to handle standard store instructions
>> (str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are omitted
>> as they exhibit different operand semantics.
>>
>> Unlike load instructions, a store instruction sets a value in the struct
>> within the memory where the destination register resides, and does not
>> alter its type. Therefore, no processing is required for the transfer.
> 
> But the target location also can be stack which requires type info,
> right?  Oh, I think you have a patch later to handle that.

Yes, this is supported in the subsequent patch 10 for stack-related loads
and stores.

Thanks,
Tengda

> 
> Thanks,
> Namhyung
> >>
>> The only point to note is that store instructions support pre-index and
>> post-index addressing modes, so calling adjust_reg_index_state() is still
>> necessary to handle their addressing.
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 25 +++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index fb48bf95b32f..54d9928b536f 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -661,6 +661,20 @@ static void update_load_insn_state(struct type_state *state,
>>  	adjust_reg_index_state(state, dloc, dl, src);
>>  }
>>  
>> +/*
>> + * Match standard store variants (str, stur, stlr, stp) that follow
>> + * straightforward store semantics: source registers on the left (read-only)
>> + * and memory target on the right. Excludes exclusive stores (stxr, stxp, etc.)
>> + * which have status/result register side effects.
>> + */
>> +static bool is_standard_store_insn(const char *name)
>> +{
>> +	return !strncmp(name, "str", 3)  ||  /* str, strb, strh */
>> +	       !strncmp(name, "stur", 4) ||  /* stur, sturb, sturh */
>> +	       !strncmp(name, "stlr", 4) ||  /* stlr, stlrb, stlrh */
>> +	       !strncmp(name, "stp", 3);     /* stp */
>> +}
>> +
>>  static void update_insn_state_arm64(struct type_state *state,
>>  				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>>  				    struct disasm_line *dl)
>> @@ -742,6 +756,17 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	/* Memory to register transfers */
>>  	if (is_standard_load_insn(dl->ins.name))
>>  		update_load_insn_state(state, dloc, dl, src, dst);
>> +	/* Register to memory transfers */
>> +	else if (is_standard_store_insn(dl->ins.name)) {
>> +		/*
>> +		 * Ignore transfers since it'd set a value in a struct
>> +		 * and won't change the type.
>> +		 *
>> +		 * Needs to update the pre-index and post-index addressing
>> +		 * modes for the destination register.
>> +		 */
>> +		adjust_reg_index_state(state, dloc, dl, dst);
>> +	}
>>  }
>>  #endif
>>  
>> -- 
>> 2.34.1
>>

