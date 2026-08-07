Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7046D087
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090144; cv=none; b=Yd1r2P7kEYBCPHlf9njaF6L/7nUiYGwqya98cuTe3GsFTHQGq6azmEN6lOOHswuuUsrHNZqQ/3tzEjCeGAqgFtA7DO5RshqmKj+2Vxi6VyaCmjg9dewKdjLZwOckkX+aEISXKvpFfO0HgRX26t3VNJd0GpU8W/zWBdETK0wZykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090144; c=relaxed/simple;
	bh=80wQyHXJuolbnIhel+HB8UsTIeitYTTRLjsSu3gvihU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhVnDGcdqzLWoJeOY4gs5y14PlWzF9Q8Zs84TPj9JJ9Z/QtWdGw4Klg2K1WCzxGsM2xFi/SfMIjb1fYprhT6F8bm+5ylA3YI5cr3vtXQ1TH12ly4DD7ZOoOJCz6ZxIPNqgAp9LmhhlmI/GYd+fEItorgwfynZJCoqfRz+/6gyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jwr+UX7k; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jwr+UX7k"
Message-ID: <ba053fa1-9df5-406b-9f92-df0dcc76ff68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44gHspEmvf0KR3CCD0fyMRuJn7BHiloWc8UW7doqt4s=;
	b=Jwr+UX7kAQwiiXG1TAcIvVCf82bkavGLIbLqALxbiRmxwWKMnKvF0SZV8HxvKM3snsPVML
	NHIQ6RsVThbWqxQ56m94lU7vVuogY+4fUsqFWQQKtG2Lg3e6PkXNMRISzDCaZXZ7hzDPS3
	5pIcWN0rHxcwuMktbNiZjIbbMlElA4I=
Date: Fri, 7 Aug 2026 01:08:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 12/22] RISC-V: perf: Modify the counter discovery
 mechanism
To: Charlie Jenkins <thecharlesjenkins@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
 <178453211938.543975.7016109597042850635.b4-review@b4>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <178453211938.543975.7016109597042850635.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/20/26 12:21 AM, Charlie Jenkins wrote:
> On Wed, 01 Jul 2026 01:47:00 -0700, Atish Patra <atish.patra@linux.dev> wrote:
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 74d934238821..c20f1e33c65d 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -1599,13 +1658,23 @@ static int __init rvpmu_devinit(void)
>> [ ... skip 15 lines ... ]
>> +	 * in S-mode via Supervisor Counter delegation.
>> +	 */
>> +	if (riscv_isa_extension_available(NULL, SSCCFG) &&
>> +	    riscv_isa_extension_available(NULL, SMCDELEG) &&
>> +	    riscv_isa_extension_available(NULL, SSCSRIND))
>> +		static_branch_enable(&riscv_pmu_cdeleg_available);
> This needs to not only check that smcdeleg is supported in linux, but
> also that it is supported in the SBI implementation correct? Trying to
> boot this on OpenSBI before 6bb6b61c27eb ("lib: sbi: Add support for smcsrind and
> smcdeleg") will fail on an illegal instruction in
> rvpmu_deleg_find_ctrs() while trying to access the scountinhibit csr in
> the patch "RISC-V: perf: Implement supervisor counter delegation
> support". The proper mstateen bits need to be set for this to work
> without crashing.

Yeah. We can do trap/detect to identify if smcdeleg is actually 
available but that is bit ugly.
The firmware should make sure that it doesn't advertises an ISA 
extension if that is not avaialble
to S-mode but that model only works for newer firmware.

if you are running very old firmware with new Qemu/platform, the default 
ISA extension may have
smcdeleg while older firmware may not even know about it.

In reality, I am hoping chances of that happening are rare as OpenSBI 
patches have been available
from a long time and Linux kernel patches are yet to merge. I have not 
addressed this in v9 as I am
not sure which is the best worst approach yet :)

>
