Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57AF361DA9;
	Mon, 13 Jul 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947566; cv=none; b=g603H9BlhCQvr/i2QTDaVFh2R3miuE3lWxhxnAP4u8rJDcJ6P6aYmMS89mRe7EIQNRaPKOf5ktPFGHwzDQUo8Ycz9zJ8JY1/mMGpWPpDb9ErHMtF7f5goMBh0jo+IAqF1IAlwDmC15uiCxYv6ijE9G0eq7kFwGXdSx34jIFEdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947566; c=relaxed/simple;
	bh=wcDXfVk32FROq/lsYLAGJRHnaY0Qj6QchI6Y5Vyq/C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUb/K7vqFAr5HvJ5IgiSMAxPiqTbXuS1zRcWAnp5q0d1Ump0CiJLG9365DjRE6RWX7qZ88JnCKIekH/dkFw1sv57rDmcYmO4QfII4kmQDTy0tM+JbPTje2nZjtupLk4JIdkfXqd5FcF/puT2sKvFrF9juAyNWZ6R1JExmJePmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mpoy6yjf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mpoy6yjf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1327C1576;
	Mon, 13 Jul 2026 05:59:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AEBE3F93E;
	Mon, 13 Jul 2026 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783947564; bh=wcDXfVk32FROq/lsYLAGJRHnaY0Qj6QchI6Y5Vyq/C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mpoy6yjfXl0ZeCqb5O1TZ4YuxzIzKqDu4hB7IX1z9ziCRBAIkr0gTaXpVbpYMqarj
	 7YCGMjEbRC3yqK/A96DojrSn1xFU7x0teIh6lIPzGTJsD5M/Ar5eX2spERBUL6FNkC
	 P/oUkIQNzx6Dju8nKwEfhzT2t8yJrhn3QLFSvbYM=
Message-ID: <3f3e6dec-9e37-4731-8de1-bd9f3cee9b80@arm.com>
Date: Mon, 13 Jul 2026 13:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: perf: Add Arm Bus Monitor Unit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: will@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1783439341.git.robin.murphy@arm.com>
 <1cd17d9c07e9695e1dffdeaa5409f0a1db8ccb81.1783439341.git.robin.murphy@arm.com>
 <20260713-noble-jade-wapiti-20ba9d@quoll>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260713-noble-jade-wapiti-20ba9d@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2026 8:26 am, Krzysztof Kozlowski wrote:
> On Thu, Jul 09, 2026 at 08:22:07PM +0100, Robin Murphy wrote:
>> +required:
>> +  - compatible
>> +  - reg
>> +  - label
>> +
>> +additionalProperties: false
> 
> You need an example DTS, unless this is a subdevice and part of other device as
> subschema.

I still fundamentally disagree with the necessity of "validating" my 
ability to understand my own trivial 3-property binding that I wrote, 
but whatever... v2 can have this which I've made up out of thin air 
since I have no real-world reference to hand:

examples:
   - |
     pmu@12340000 {
         compatible = "arm,bus-monitor-unit";
         reg = <0x12340000 0x40000>;
         label = "ddr_ch_1_2";
     };

Thanks,
Robin.
