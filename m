Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E018A95F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914014; cv=none; b=qEk3zwNdQMOvazsSWTO4azfwn+s7R5BZ4oO9Rt2k3MLs8OeGPYkLdUc8XCZR50FCg6d9kqv4nPAWjjV1hKS+cPONMF0Yzs23N4nqZJL0uP5xvKei54K4tqBVnC3py0DvyM4oB4K3IklotC/sAkeXO87bI7PCnMkaqAqbjX6kGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914014; c=relaxed/simple;
	bh=nFla+BLl8EOTUAzWvRGBNBwgtqEibdMwosEuRj2mBeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSY4Z7PwuHAm7i6nRCdv19fRr9k/DHK5D7MVrWG/aqvQ9iSFvwhhU/roKlXuR00D5WoD4g4QPRgVpqzi+xxqibUXOxZAM80yGNPDY2wcrFnmctoneZ9T6EVFykgf7unyDq9pPIMcQAVfhfcs6HQnvdeJpONEyiiNX6yI7hxoi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52995106F;
	Mon,  9 Sep 2024 13:33:59 -0700 (PDT)
Received: from [10.57.82.33] (unknown [10.57.82.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B5A3F73B;
	Mon,  9 Sep 2024 13:33:29 -0700 (PDT)
Message-ID: <fc2870a0-3e0e-464c-b468-70c5ee4a6ebb@arm.com>
Date: Mon, 9 Sep 2024 21:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: scclevenger@os.amperecomputing.com, james.clark@linaro.org,
 mike.leach@linaro.org
Cc: ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
 <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
 <22f7ecdb-14e7-4bb1-a20a-bdb447bcb64f@arm.com>
 <723912a5-4d9a-4fe0-ad86-bbd79ccd4a45@os.amperecomputing.com>
 <22539ca0-551d-4cfc-94f9-4a291998a363@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <22539ca0-551d-4cfc-94f9-4a291998a363@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/7/2024 12:20 AM, Steve Clevenger wrote:

[...]

>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/
>>>> perf/scripts/python/arm-cs-trace-disasm.py
>>>> index 7aff02d84ffb..a867e0db02b8 100755
>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>> @@ -187,6 +187,7 @@ def process_event(param_dict):
>>>>          dso_start = get_optional(param_dict, "dso_map_start")
>>>>          dso_end = get_optional(param_dict, "dso_map_end")
>>>>          symbol = get_optional(param_dict, "symbol")
>>>> +       map_pgoff = get_optional(param_dict, "map_pgoff")
>>>
>>>
>>> I am concerned the two sentences below are inconsistence: one uses
>>> 'start_addr + map_pgoff' and the other uses 'start_addr + int(map_pgoff)'.
>>>
>>
>> Valid point. It's working fine as is, but how is it even working? I look
>> at print_disam/read_disasm, and no type conversion is done in either
>> call. The dso_start parameter for these calls is actually dso_vm_start
>> which is the dso_start integer conversion.

I agreed with you. After reading code, I have same conclusion that we don't
need to type conversion to int type.

> Python thinks the map_pgoff object is already an integer. For example,
>         map_pgoff = get_optional(param_dict, "map_pgoff")
>         print("%d" % map_pgoff.isdigit())
> 
> AttributeError: 'int' object has no attribute 'isdigit'
> Fatal Python error: handler_call die: problem in Python trace event handler
> 
> Converting map_pgoff to a string works in the print statement.
> 
> print("%d" % str(map_pgoff).isdigit())
> 1
> 
> I'm not sure, but it's possible get_optional() during some call had
> converted it to '[unknown]' which would cause a problem.
> 
> I can explicitly force to integer.

For backward compatibility, we can use below code:

   map_pgoff = get_optional(param_dict, "map_pgoff")
   if (map_pgoff == '[unknown]'):
       map_pgoff = 0

Then in the later flow, we should can always use "map_pgoff" as an int type.

I struggled for James reported issue.

The variables “map_pgoff,” “dso_start,” and “dso_end” are set together in the
Python engine. All of them should be of type int if the DSO is found, or all
should be ‘[unknown]’ if the DSO is missing. We have checked the types for
“dso_start” and “dso_end”, and if either is ‘[unknown]’ the flow will directly
bail out. Thus, in theory, “map_pgoff” will not cause trouble if it is an
‘[unknown]’ string.

One possibility is that James has applied your patches but has not built perf.
So, the field “map_pgoff” is not passed from the Python engine, which will
cause the reported error. I think the proposed above change can effectively
avoid the error.

Thanks,
Leo
