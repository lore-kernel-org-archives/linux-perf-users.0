Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9E2A1C9;
	Fri, 21 Mar 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742600614; cv=none; b=JiECF/f1vv0Id89V7bTE6MnU2BJKXHVrhxfM6dxcanhJB3R91bOkEhc1J01RLCQ+nBV/EjqfIBo1dpQoVTT4hQsvv1BvCVEMFryLilf9E9TBb/g+LsDvIqX5NdIWQwaVAdou7hzmBqbmJRsO89DG44ftcQ9fL/OjCmkyOpaa03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742600614; c=relaxed/simple;
	bh=9BMWcrvzRhGLestX25VAPEzSH1aQ6OUzo7S4ac1yvbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ei04YxrVmMUPmaoj0Y9tSFtdypF4pi1kBwzYPvWf+xNDEq2L+7xpeiXSQxUXnvAhAjEwheHibYaxUW0MsDV6aITTZxNc2UNS4DWbCcCTOODt+eX7UOi5V6Mze5Is7/GbOsgCpfo9PSqGpc/YSRqMFUc9DOwhyz7UnfljcIgmaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AA87113E;
	Fri, 21 Mar 2025 16:43:37 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F853F673;
	Fri, 21 Mar 2025 16:43:25 -0700 (PDT)
Message-ID: <e8ada81d-0e10-412b-8792-035bc63113a6@arm.com>
Date: Fri, 21 Mar 2025 18:43:23 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: uaccess: Add additional userspace GCS
 accessors
To: Mark Brown <broonie@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-4-jeremy.linton@arm.com>
 <50a0920d-3e3d-4e96-b68a-a7a0d78c3695@sirena.org.uk>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <50a0920d-3e3d-4e96-b68a-a7a0d78c3695@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/25 8:24 AM, Mark Brown wrote:
> On Tue, Mar 18, 2025 at 03:48:37PM -0500, Jeremy Linton wrote:
> 
>> +static inline u64 load_user_gcs(unsigned long __user *addr, int *err)
>> +{
>> +	unsigned long ret;
>> +	u64 load;
>> +
>> +	if (!access_ok((char __user *)addr, sizeof(load))) {
>> +		*err = -EFAULT;
>> +		return 0;
>> +	}
>> +
>> +	gcsb_dsync();
>> +	ret = copy_from_user(&load, addr, sizeof(load));
>> +	if (ret != 0)
>> +		*err = ret;
>> +	return load;
>> +}
> 
> A GCS load done by the hardware will verify that we are loading from GCS
> memory (the accesses are marked as AccessType_GCS in the pseudocode
> which is then validated in for example S1CheckPermissions()).  Sadly
> there's no equivalent of GCSSTR so we'd need to do the permission check
> ourselves to match this behaviour.

Right, except that if I grab the VMA as a placeholder for the page, 
check to see if its a VM_SHADOW_STACK under any of 
map_read_lock()/lock_vma_under_rcu()/etc and then perform the access, 
the resulting possible fault will have problems with vma locking. 
Otherwise there ends up being a few different races that at the moment 
I've not yet figured out how to fix without making a big mess. For 
example, we can reduce that possible window, by reading the 
value/locking and checking shadow stack state/dropping the 
lock/rereading the value, or some other construct but it seems pointless 
because the suggested problem is that we might be creating a way to 
bypass some of the shadow stack security. In which case, leaving a 
little race is likely the same as leaving it wide open.


Otherwise, maybe we can ignore the problem, or just refuse to allow 
probes on 'RET' instructions which seems to be the main problematic 
case. Although, given we don't really know if GCS is enabled until the 
probe is hit, SIGSEG'ing the target process is a big hammer.

Ignoring it might be a valid option. I guess it could to be one of those 
"if the user puts a uprobe on a RET some of the shadow stack security is 
reduced" footguns. If an attacker can also manipulate the address space 
in a way to exploit it then its probably game over anyway. Ideally, the 
kernel would warn on this, but per the conversation around patch 6/7 
that seems to be off the table.












