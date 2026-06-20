Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B940D565
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781913891; cv=none; b=rhKYhVOM0WNF6nmR0n+r0SF9RdA1fWyHFaxU0PZzTwgeI84NGkHJrQvQdSGHLrUPCKQ8SavJhm2wAvR5R7tmL0HpNVL1jYPtnXIK12pVT9dDNP7OVjH2sLqfSnQ6EsI0bNzXnd5X+LDMM/Kl+pg8zYDd3K7/ejujF5q1iMCgZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781913891; c=relaxed/simple;
	bh=1zQ6MR05KiWq832d0x4+mmjporHs56IkboccBh+p4Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tzl4CVO4c/rbKkIHmPs/3xqb64jOF/1ySNfq6pdZRqgcUbr5p/g6gAElqr/beu7R3iJwpQT8ZILyBc3qksmKggvh1CYPL3VpIWUwc7g1t/JgRgeQJY26icV1qtHS5aHd7apYsHRlqZE/9Qaz8G3mQdvEyfo0ZCVQG44ju8HvRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=srM9yUeh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="srM9yUeh"
Message-ID: <94b39d53-db53-4201-8367-c2745c9530ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781913878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1YP/5vAvufKhS6Q/igOIHH4GN3rD2SRijEw2Od++PQ=;
	b=srM9yUehDRLO+E2biHB4Hj0mbJ05bIxm5j7QpkxLYXpqdZ/DPq/g4MrbnEEM2K3ZY977XK
	FCVHzv06eEJEan9aEO6kHJuH/qOFxyJWhkjLM9XakzBaS/JWWecRyN2/guqz2QFYe4itgY
	COuu8A6BGf5w41wcW0KDL3lGpQoc/Jo=
Date: Fri, 19 Jun 2026 17:04:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 21/21] TEST(do-not-upstream): fake qemu vendor JSON +
 mapfile entry for CounterIDMask path
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
References: <20260608-counter_delegation-v6-21-285b72ed65a9@meta.com>
 <20260609062023.0D53F1F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609062023.0D53F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] This patch is explicitly marked 'TEST(do-not-upstream)' and adds fake testing events, which should not be merged into the mainline kernel.
>
> Pre-existing issues:
> - [High] Unconditional NULL pointer dereference in `get_cpuid`.
> --
>
> commit d0ac889c30ab39821cba995143de6c24abe2efcc
> Author: Atish Patra <atishp@meta.com>
>
> TEST(do-not-upstream): fake qemu vendor JSON + mapfile entry for CounterIDMask path
>
> This patch adds fake QEMU vendor JSON events and a corresponding mapfile entry
> for the CounterIDMask path to test PMU masking.
>
>> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
>> index 87cfb0e0849fc..3533a8c0253f7 100644
>> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
>> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
>> @@ -24,3 +24,4 @@
>>   0x602-0x3-0x0,v1,openhwgroup/cva6,core
>>   0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
>>   0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
>> +0x0-0x0-0x0,v1,qemu/virt,core
> [Severity: Medium]
> Since this patch is explicitly marked "TEST(do-not-upstream)" and adds fake
> PMU events strictly for testing, should it be merged into the mainline
> kernel?
>
> Merging this will populate the perf tool's PMU event tables with non-existent
> hardware events.

N/A. this patch is just an example and marked explicitly not for merging.


>> diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
>> new file mode 100644
>> index 0000000000000..294c4ed645f67
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
>> @@ -0,0 +1,26 @@
>> +[
>> +  {
>> +    "EventName": "fake-json-any",
> [ ... ]
>
> While reviewing this, I also noticed a pre-existing issue in
> tools/perf/arch/riscv/util/header.c:
>
> tools/perf/arch/riscv/util/header.c:get_cpuid() {
>      ...
> 	char *cpuid = _get_cpuid();
> 	int ret = 0;
>
> 	if (sz < strlen(cpuid)) {
> 		ret = -EINVAL;
> 		goto free;
> 	}
>      ...
> }
>
> [Severity: High]
> This is a pre-existing issue, but can get_cpuid() cause a segmentation fault
> here? If _get_cpuid() returns NULL (for example, if /proc/cpuinfo is missing
> or lacks specific fields in a container or QEMU without proper emulation), it
> appears the unconditional call to strlen(cpuid) will dereference that NULL
> pointer.

Yes. I will send a separate patch series for these fixes.


