Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836152236F7
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432731; cv=none; b=Du69EM2nbMU+NjbUw77as/Dapx9NkH3s3SHqcb6qvTyXUE/c3+wf2cd/cUfSEsN50QVpfD5CvlxUq/xeg3X28ScmBkj9Zf8gNUH4L/bOPEtxWNpg4b6HPzJRCv1EPp/WR+1FJ3ENSYVKE5HwEAVSWfpEGDv/jxPE/7uCDpaWpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432731; c=relaxed/simple;
	bh=hc/Oy6N15FEFtduOi7ddMMV3L+eLd0KabP3jmJMXDjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0TEKBxfFrUM92QDx+5qJ96PExIQijOIfMWmnGjcmA88GxSRIYL0qUUiotGXRtx9KPTx58k2owj9+Kx0tc9RqhxAvLTmw+nUdw58pezvG1kOLtoXb3LJTxZviiUG5kIip7CrjOKs4n+CAzwqTHggAVO23y0cQcbEIpR9DNFncA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hK2zP2NkCzYQtkV
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:18:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3E88A408F4
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:18:44 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAXB0bSzHpqPceaBw--.63125S2;
	Tue, 11 Aug 2026 15:18:44 +0800 (CST)
Message-ID: <d6324221-0fc6-40e9-9003-52c7d509daeb@huaweicloud.com>
Date: Tue, 11 Aug 2026 15:18:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-6-wutengda@huaweicloud.com>
 <20260808131253.107781F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808131253.107781F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXB0bSzHpqPceaBw--.63125S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Gw1kZryfZry5Ww4fAFb_yoW8uryfpF
	4akrW3J3y8GFyYvwnxWF1xWF15Gw1fZr4rury5t3y7KrsF9Fy0qw1ftF4Y9FW8GryDAa10
	yw4DKr109rn5ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The programmatic DWARF register lookup __get_dwarf_regnum_arm64() fails to support the standard AArch64 'lr' (link register) and 'fp' (frame pointer) aliases.
> --
> 
> --- Patch [5]: [PATCH v4 05/23] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64 ---
> commit 7e82be98e18ee79f31ad73b727e21d33b0a6f30d
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
> 
> This patch replaces the static string table lookup for arm64 DWARF registers
> with a programmatic implementation. This change allows resolving arm64
> register names directly into their corresponding DWARF register numbers
> during annotation parsing.
> 
>> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> index 593ca7d4fccca..720c863d18696 100644
>> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> 
> [ ... ]
> 
>> @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
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
> Will this strict prefix check inadvertently reject standard AArch64 aliases
> like lr and fp?
> 
> These architectural aliases are frequently emitted by objdump and were
> previously handled by the old static table. When perf annotate attempts
> to look up lr or fp, this programmatic DWARF register lookup in
> __get_dwarf_regnum_arm64() will fail because the name does not start with
> x or w.
> 

Currently, I have not seen such aliases in AArch64 disassembly output,
nor are they documented in the manual. Therefore, I will not change this
and will keep it as-is.

