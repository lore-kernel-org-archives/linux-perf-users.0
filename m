Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A4318BA8;
	Fri, 17 Jul 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304981; cv=none; b=YT3nAQnMQ3QK4UueXgL468HzfuxL3HnPHlbeiX5x8e/0/TYePsbaHBHQwF8cD5TJJCiClrSnQGTpDFHZC0B8ft7v/HlBwetY4l4aLxVSXrt0kYRk1+F+YpKlLlYHivf1GA/9d6c532p8pK8cpv4bMS6iAsIqaJ3g5X4JLPYG9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304981; c=relaxed/simple;
	bh=w0Zi2BWh5dfpwiy/hOSW/MU5kOPYrXvW79sibZvRp7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABI4NHdG5LI9zuuiCAhr+5sA7feUqDH+irvJMP5wx6uekZs+kSvOE8Pcnh9IB6xKU/6XoTVrJUeK2xsXrBdB7IjY2ZkKh5vjBZFX686CHYFvsBnltTofcNXSAWZF9VHU6kFCjPQ0jVGE2QE/BZbvG3GAjN3QsCkiJoohuWRckOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WhaAS9rW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WhaAS9rW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4FEA1476;
	Fri, 17 Jul 2026 09:16:15 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971193F905;
	Fri, 17 Jul 2026 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784304979; bh=w0Zi2BWh5dfpwiy/hOSW/MU5kOPYrXvW79sibZvRp7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WhaAS9rWsloxlgUl+kgCy5WI/pibMFWNf2PDA9a4K1EjbZ2/EltFDFM0s4BMTk+UY
	 eEX1EbCTHmD0dkZbQTmEO1dxoauio5NpiTONH9RTSYFyohj2UJuLGHL+G8zwcGMhDt
	 D8gyXwjswL9P3HVbPlDGYr+Jtk1+wJjH2dJuY/cM=
Message-ID: <aee1da04-3909-43d2-8cf0-82c9de323c0e@arm.com>
Date: Fri, 17 Jul 2026 17:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] perf/arm_cspmu: Improve sub-module error reporting
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 ilkka@os.amperecomputing.com, bwicaksono@nvidia.com,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <cover.1784213435.git.robin.murphy@arm.com>
 <256bcb4c8c98dc95bfdf295adb66b917545c919b.1784213435.git.robin.murphy@arm.com>
 <20260716171213.000026c7@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260716171213.000026c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2026 1:12 am, Jonathan Cameron wrote:
> On Thu, 16 Jul 2026 15:56:36 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> When waiting for a sub-module to register, we return a bare
>> -EPROBE_DEFER that ends up showing the end user:
>>
>>    platform arm-cs-arch-pmu.1: deferred probe pending (no reason)
>>
>> wherein it's not necessarily clear that they might need to take some
>> action to ensure the appropriate module is available to load. Let's use
>> dev_err_probe() here so we can show exactly what we're waiting for.
>>
>> Similarly, in the case where something's gone horribly wrong with an
>> already-registered module, we can use dev_WARN() to standardise the
>> device/driver attribution rather than just open-coding "arm_cspmu".
>>
>> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Hi Robin,
> 
> Maybe sprinkle some cleanup.h magic and use a guard(mutex)() and direct
> returns.  Simplifies this function that you are touching anyway.
> 
> Looking more broadly it'd either take a scoped_guard() or some refactoring
> if you want to go that way cross the file.

Heh, feel free to try some cosmetic refactoring if you fancy - for 
starters, "if (!match) return 0" would save a whole needless level of 
indentation here - but this patch is purely about a functional 
improvement to the user-visible logging. I'd rather not tangle that up 
in subjective non-functional changes.

(And to be brutally honest I'm not much of a fan of the cleanup.h stuff 
anyway - maybe for complex nested resource acquisition, but it's not 
like there are any gotos here, so for the sake of ~3 lines I'd 
personally rather have locking that looks like locking...)

Thanks,
Robin.

> 
> Jonathan
> 
>>
>> ---
>> v2: No change
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 8c2dda17d73e..caad9a36651d 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -437,13 +437,15 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>>   				if (ret)
>>   					module_put(match->module);
>>   			} else {
>> -				WARN(1, "arm_cspmu failed to get module: %s\n",
>> +				dev_WARN(cspmu->dev, "Failed to get module: %s\n",
>>   					match->module_name);
>>   				ret = -EINVAL;
>>   			}
>>   		} else {
>>   			request_module_nowait(match->module_name);
>> -			ret = -EPROBE_DEFER;
>> +			ret = dev_err_probe(cspmu->dev, -EPROBE_DEFER,
>> +					    "Waiting for module %s to load\n",
>> +					    match->module_name);
>>   		}
>>   
>>   		mutex_unlock(&arm_cspmu_lock);
> 

