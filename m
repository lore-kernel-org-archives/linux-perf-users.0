Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0A35B632;
	Fri, 10 Apr 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816990; cv=none; b=DjWGGN6pTfv/pfvw66GXhu3BAHz8xBA4aDsg6Y37skKPQqEDrLjwAqQxHcGKQt7tgNGy8Yl2gFq+8XuYdUwwrYrG7R0WSJonhXXOcp8vXHhCmszBj3PN1WiCQPCaPYsxUtKb2zqTV/AR1qhMFYUSLAU0yrXALxZ0QWRscgoQPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816990; c=relaxed/simple;
	bh=B5x3/sp0YA8MzA2xRBLjFqBMgN7zuaAM8YN8bbHFlyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z49NMRN9BOWzzRDMjA6nsA4GHSNg2NwOWJ82J2/WwoYN8cJZbPLAv+t6LLjHahxdPEZeHgjMedv/oY8nXKn9hDty79dJVm/62SbuPYYT2czz0Cc+zpuAgPAlQNeVnYmd6oZ1VZ/0011o66h7vBa4TmzzJove8sH3OsEC60l3XD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsY2b46dMzKHMK3;
	Fri, 10 Apr 2026 18:29:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3D82B4056F;
	Fri, 10 Apr 2026 18:29:45 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgAX9VEY0dhpRO0iEA--.64240S2;
	Fri, 10 Apr 2026 18:29:44 +0800 (CST)
Message-ID: <c24ede93-53e9-4508-9b27-04a306d59ab2@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:29:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] perf annotate-arm64: Enable instruction tracking
 support
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-9-wutengda@huaweicloud.com>
 <adiUKB1CTkDAGrB_@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adiUKB1CTkDAGrB_@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAX9VEY0dhpRO0iEA--.64240S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrWr17Gw4UAF15KFyfJFb_yoW8uryxp3
	yDCa4rGa1rJFs2kwnxXF43Zryaga13XrWF9rn0q3yIyF17tF9YkFn7KFWY9F1Fvr97Gr12
	yr1qvF1UXa9IkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIbyZUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/10 14:09, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:52AM +0000, Tengda Wu wrote:
>> Enable instruction tracking for the arm64 architecture in 'perf annotate'
>> to support data type profiling.
>>
>> Define ARM64_REG_SP as 31 to correctly identify the stack pointer
>> register during type state initialization. Update
>> arch_supports_insn_tracking() to include arm64, which allows
>> find_data_type_block() to process the instruction scope for arm64.
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/util/annotate-data.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
>> index 1eff0a27237d..fd6416d43a2e 100644
>> --- a/tools/perf/util/annotate-data.c
>> +++ b/tools/perf/util/annotate-data.c
>> @@ -28,6 +28,7 @@
>>  
>>  /* register number of the stack pointer */
>>  #define X86_REG_SP 7
>> +#define ARM64_REG_SP 31
>>  
>>  static void delete_var_types(struct die_var_type *var_types);
>>  
>> @@ -177,7 +178,8 @@ static void init_type_state(struct type_state *state, const struct arch *arch)
>>  		state->regs[11].caller_saved = true;
>>  		state->ret_reg = 0;
>>  		state->stack_reg = X86_REG_SP;
>> -	}
>> +	} else if (arch__is_arm64(arch))
>> +		state->stack_reg = ARM64_REG_SP;
> 
> Probably you want to setup caller-saved registers and the return
> register as well.
> 
> Thanks,
> Namhyung
> 

You're right. Thanks!

-- Tengda

> 
>>  }
>>  
>>  static void exit_type_state(struct type_state *state)
>> @@ -1421,7 +1423,8 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
>>  
>>  static int arch_supports_insn_tracking(struct data_loc_info *dloc)
>>  {
>> -	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)))
>> +	if ((arch__is_x86(dloc->arch)) || (arch__is_powerpc(dloc->arch)) ||
>> +	    (arch__is_arm64(dloc->arch)))
>>  		return 1;
>>  	return 0;
>>  }
>> -- 
>> 2.34.1
>>

