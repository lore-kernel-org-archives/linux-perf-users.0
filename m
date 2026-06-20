Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19024136358
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915754; cv=none; b=D6+IWFMZhAU5QhIVaNaGqJwtfgNAJWFLpaUuGCfZPRDOI1LBe1alRGh8hGJSjnsNAlFwkvmoFRiyTBkfeijR8MmS6UvDqydpnNsjLTHhhZ+YrJ+5Fxq82mrTVVNTJ+TX4xRrUy9jHE5tQoe25oDPfwPS/ZRO31MKV1VQt9WwcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915754; c=relaxed/simple;
	bh=RlxAjKzRt8XRO4CRmFT2F6yQjuupfM2gHD3+/l35IfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrCaJLr6eoNpPopYdKpi/kIcVftNxZmWZK7TLjZP41rzq4yeAT8uDzfVobP5rDlua0Db50tOyJatPFuu5+J4s4HX7p/kq1HFQONQ1hwYFs5LmI7USKHeyW2RFCNL8bH8PVEWmuDbah+83sY0zI4k7aud8N9K19Z9RZ15DA3SZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwZsj/nb; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwZsj/nb"
Message-ID: <389a9141-277d-4325-8099-de17eb4e19fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781915751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Erh4jwB4l3hfJMazZbrRVUERfRd67oKz+ZwQVO1+Te8=;
	b=lwZsj/nbf43DWttCMigRXCPU80SWC4TV7N9n29BmPVqA0F6PjIUMQ1X42rQebg0gGuaric
	Nz3UxfbTfpQB9It+4+FzdGeydAhCoR9W/3I7MzGDQTXrocxKQ3cLcgl4dcRXys6jf5HMiQ
	zF28q35P4TkYE3tnHDKmDWy7RqQk+No=
Date: Fri, 19 Jun 2026 17:35:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 16/21] RISC-V: perf: Add legacy event encodings via
 sysfs
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260608-counter_delegation-v6-16-285b72ed65a9@meta.com>
 <20260609062110.1D0C61F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609062110.1D0C61F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The globally scoped pmu_ctr_list array is leaked if PMU counter discovery fails, compounded by a flawed error code cast.
> --
>
> commit 7d64e724e6eff197f10e62cdd709e07f0a5c9a7d
> Author: Atish Patra <atishp@rivosinc.com>
>
> RISC-V: perf: Add legacy event encodings via sysfs
>
> Define sysfs details for the legacy events so that any tool can
> parse these to understand the minimum set of legacy events
> supported by the platform. The sysfs entry will describe both event
> encoding and corresponding counter map so that an perf event can be
> programmed accordingly.
>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 4b4f151a0744d..00b84b28117a8 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -130,7 +130,20 @@ static struct attribute_group riscv_cdeleg_pmu_format_group = {
>>   	.attrs = riscv_cdeleg_pmu_formats_attr,
>>   };
> [ ... ]
>
> [Severity: Medium]
> Does this code leak the pmu_ctr_list array if PMU counter discovery fails?
>
> In rvpmu_find_ctrs(), pmu_ctr_list is allocated via kcalloc(), but the function
> bails out without freeing it if num_sbi_counters or num_deleg_counters
> exceeds RISCV_MAX_COUNTERS:
>
> drivers/perf/riscv_pmu_sbi.c:rvpmu_find_ctrs() {
> ...
> 	pmu_ctr_list = kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
> 			       GFP_KERNEL);
> 	if (!pmu_ctr_list)
> 		return -ENOMEM;
>
> 	if (riscv_pmu_cdeleg_available_boot())
> 		num_deleg_counters = rvpmu_deleg_find_ctrs();
>
> 	/* This is required for firmware counters even if the above is true */
> 	if (riscv_pmu_sbi_available_boot())
> 		num_sbi_counters = rvpmu_sbi_find_num_ctrs();
>
> 	if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters > RISCV_MAX_COUNTERS)
> 		return -ENOSPC;
> ...
> }
>
> Also, could num_sbi_counters inadvertently capture negative error codes?
>
> rvpmu_sbi_find_num_ctrs() returns an int which can be a negative error
> code. Storing it in the u32 num_sbi_counters implicitly casts
> it to a very large positive value.
>
> This triggers the RISCV_MAX_COUNTERS check and causes the function to abort
> with -ENOSPC, losing the original error.
>
> The caller rvpmu_device_probe() then fails to clean up the leaked globally
> scoped pmu_ctr_list pointer during its error handling:
>
> drivers/perf/riscv_pmu_sbi.c:rvpmu_device_probe() {
> ...
> 	num_counters = rvpmu_find_ctrs();
> 	if (num_counters < 0) {
> 		pr_err("SBI PMU extension doesn't provide any counters\n");
> 		goto out_free;
> 	}
> ...
> out_free:
> 	kfree(pmu);
> 	return ret;
> }

valid points but same as issue raised in PATCH11. Fixed in v7.


