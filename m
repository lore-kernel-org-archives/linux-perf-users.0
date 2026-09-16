Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F428347BAF
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524345; cv=none; b=Mh5G/Sv/BbkNxqZGh/DdVcKcPH4heA19QroLjHN/K+tRVsA08xkTjjcK7so+p7f2U6bPdKnymapzucdlhZJktiEt6YXidZIJ1JUARdGltFn4huS8rQjzXEMYSb8Zz8tFnLdn23HBl+PLfgR0x5N0eYX2O7Ulym4bdGIa/xrUDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524345; c=relaxed/simple;
	bh=VBwc36yMzFKzPF0hduRvJqixJxtjxtrNnlM4IxR2oFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DayRxwnCo23HanwYnfet6M+Pw3mA2qk4WZxJ9rL9jwEE3ge61n3HZxCejeFdZUTEw6e/yj8NKQVcVNzKXY+AugFDAg5KSBdVjjuX5z/B2qKjWjMmZLBbhU0TrygvbTf5qxypWT3EwDqKkWduQ2OaKR48YXSGb/ERUVKOoz6+fcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl2K80xLLzKHMQ6
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 10:05:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C0CB44058C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 10:05:29 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXF2xo+alqKsrVAQ--.24231S2;
	Wed, 16 Sep 2026 10:05:29 +0800 (CST)
Message-ID: <32ee6f84-243b-4054-a51e-bf0e740c9a74@huaweicloud.com>
Date: Wed, 16 Sep 2026 10:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <3115e9c4253d6710aa995a2052e5b73da395726b.1789521520.git.wutengda@huaweicloud.com>
 <20260916014304.881781F00899@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260916014304.881781F00899@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBXF2xo+alqKsrVAQ--.24231S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWrWrWDuw4rWry3WFWkCrg_yoW8Zr45pF
	4ak3y7J3yDGF4YvwnxXF4xWF1fWw4fZF4rZryDK3y7GrsF9ry0q3Z3tr4Y9F48JryDJw10
	vw4Dtr10gwn7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/16 9:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: arm64 DWARF register parser misses 'lr' and 'fp' aliases
> --
> 
> commit 7f62b33196a65173a3a904647c4eb49f9a4b65f8
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
> 
> This commit replaces the static string table lookup for AArch64 DWARF
> registers with a programmatic implementation in __get_dwarf_regnum_arm64().
> This change allows resolving arm64 register names directly from raw
> instructions during annotation.
> 
>> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> index 593ca7d4fccca..425c8aa2e9840 100644
>> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> [ ... ]
>> @@ -10,3 +12,26 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
>>  
>>  	return perf_regnum;
>>  }
>> +
>> +int __get_dwarf_regnum_arm64(const char *name)
>> +{
>> +	int reg;
>> +
>> +	if (!strcmp(name, "sp"))
>> +		return 31;
>> +
>> +	if (*name != 'x' && *name != 'w')
>> +		return -ENOENT;
> 
> [Severity: Medium]
> Does this prefix check erroneously reject the standard AArch64 aliases 'lr'
> and 'fp'?
> 
> When perf annotate parses instructions where AArch64 objdump outputs 'lr'
> and 'fp' instead of 'x30' and 'x29', extract_op_location_arm64() passes these
> names to __get_dwarf_regnum_arm64(). By strictly requiring an 'x' or 'w'
> prefix (or exactly 'sp'), this rejects 'lr' or 'fp' with -ENOENT.
> 
> Can this effectively disable data type tracking for variables accessed via the
> link register or frame pointer, resulting in incomplete profiling output?
> 

This was clarified before -- it can be ignored.

Thanks,
Tengda

