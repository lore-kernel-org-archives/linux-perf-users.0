Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A3210F59;
	Wed, 23 Jul 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290861; cv=none; b=ZZLE1voUQdXiBXUxUKWCF+nvyt4yyMSb5Cv4tUWOUL7nplJMLf7LoxP4qvTdvTEGysvjgv7QeUG6MWBwO6oXn4GTajwqMCz9H2fjOHINbwraiZbnl2aXQ30ZHLjXh1xsPQZQlCt47hRcUCS4tvX1DILmGq2lJNKaRiNhrZt5Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290861; c=relaxed/simple;
	bh=QEhVG7UaEQoCsOv4KhYFV0ONxI+PWKVznJXkzpHUNlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkKShNvqLlAR3pwz7guMb7Yw9M0tEAQazsNNamjpTefIChY0hWb5HWTZ1MoLdqeP3TQIHFTHy1gWXphnYoE3WSV4k3s8RwBiJkvBE7P+mru9g3bi8EKaaCamlMYN0BC9/MCmtvkLe8vt9d8189Gf4QG0KZRpneYgGKKu9Goexpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45DEA22C7;
	Wed, 23 Jul 2025 10:14:12 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD85D3F66E;
	Wed, 23 Jul 2025 10:14:17 -0700 (PDT)
Message-ID: <2a6e1c4b-e8b0-49e2-896c-65c55103b017@arm.com>
Date: Wed, 23 Jul 2025 12:14:17 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] arm64: uaccess: Add additional userspace GCS
 accessors
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-5-jeremy.linton@arm.com> <aICwaQZxK5Spjj8G@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <aICwaQZxK5Spjj8G@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


Thanks for looking at this.

On 7/23/25 4:50 AM, Catalin Marinas wrote:
> On Fri, Jul 18, 2025 at 11:37:36PM -0500, Jeremy Linton wrote:
>> +/*
>> + * Unlike put_user_gcs() above, the use of copy_from_user() may provide
>> + * an opening for non GCS pages to be used to source data. Therefore this
>> + * should only be used in contexts where that is acceptable.
>> + */
> 
> Even in user space, the GCS pages can be read with normal loads, so
> already usable as a data source if one wants to (not that it's of much
> use). So not sure the comment here is needed.

Right, but userspace isn't using it in a privileged context to emulate 
operations that have a permission check performed as part of the read 
when performed by the HW.

This comment was added in V2 following a number of conversations about 
whether this was an actual risk or something that is only a problem if a 
long set of pre-conditions hold true. Conditions which can be summarized 
as "it is too late anyway".

Hence the comment to remind people that this routine isn't assuring the 
page is correctly marked.

I will reword it a bit if that is ok.


> 
>> +static inline u64 load_user_gcs(unsigned long __user *addr, int *err)
> 
> Nitpick: name this get_user_gcs() for symmetry with put_user_gcs().
> 
>> +{
>> +	unsigned long ret;
>> +	u64 load = 0;
>> +
>> +	gcsb_dsync();
> 
> Might be worth a comment here, see the one in gcs_restore_signal().

Sure,

> 
>> +	ret = copy_from_user(&load, addr, sizeof(load));
>> +	if (ret != 0)
>> +		*err = ret;
>> +	return load;
>> +}
> 
> Otherwise the patch looks fine:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

