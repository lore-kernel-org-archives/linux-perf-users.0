Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452694;
	b=ZQ4xGVNgfYZH2+L4CKonsLDwhG4PbdJqoUxI8cUxKNlrrS1HfsegLgqApqf09m6JYwAv
	 d/YX1U3qnh4i979lwnO2nuK4iUBzRsH0r3RPatB9aVVb41aV5EWGBvdOp5rpXUf0ZtwB3
	 ujC+4l4+j44ADuweVBz6BuzFLi0ypa6xrOApf9vt55gcjemXASbulUnqQpDS3/03dtjAZ
	 2k6yPXV3O5wALuwQ+OkhbhB+OnzP9jmakZvQU3IgO/qk4HriFfXrAlS2MrPQqJSoUnrk7
	 Q3LRqKnPRFABYmFpnV89G1O2tORjI7tlnJt/JoXt7azIcqUDWYJLz7trqrg4Np7KZaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452694;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7TA+hrkPDDb8JZWxcPTsZ5GEG+PXQrcHlypH5xP8lCg=;
	b=tZigxtkQjyrhakgRqEp+Ff2XAAzKTMA8KqM5K2T/2uV7hLCq7R/sWYr96tntmmzg+ho4
	 WSRi0ZNlSEdyfZGTg7YrJnZoD7iew08LFoatYeKf1pLNDy2PqCbpnD6jQcwDTXJv951yM
	 +2+KHsbvF1rZ7Y7w2vD5YJabKd7Z2Lh6lFWo+2blRhhNxLOdqrZ2MKtRXs7oycIxXvUiq
	 t1rFySedgznMDn5U4WKoJ5gscViqSvwdv2q2RAexyPVJYfFfV6i+zx+HfExM7h936f6hN
	 NJjyctDB+wdHxJmc34z1K14Q80c48d/INK6hUcB/ZPL2YBwaD6g7qzwz/nH7JW2HBzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="bteBHr/k";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D5606A319;
	Mon, 19 Oct 2026 23:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771D5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bteBHr/k
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DD70152B;
	Mon, 19 Oct 2026 16:31:28 -0700 (PDT)
Received: from [192.168.20.17] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C539D3F7B4;
	Mon, 19 Oct 2026 16:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792452691; bh=9CUwL2WVEd9WXW4yxmN0gNoDtRPpE6I8GkVOyVYsn34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bteBHr/kfSx/g9ZxGmYRvZkndSzSxUx//TzCZtREdgkrfzkw5eI+dW3ryNaQu2u1s
	 KVSuPUEVfnHEe5Edm/1yHaiZ024N/60uIO4IKydxleXtH0Y1EqB2BnfPVFZmmEJwNd
	 jEeBGh/97oF4u+/6r02BOD0ounY7kHowd68inuko=
Message-ID: <6f0d3ab6-52ab-458a-b44d-0bce36320e94@arm.com>
Date: Mon, 19 Oct 2026 18:31:07 -0500
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
To: Johnny Fan <johnny.fan@cixtech.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, james.clark@linaro.org,
 leo.yan@arm.com, cix-kernel-upstream@cixtech.com, bob.zhang@cixtech.com,
 jie.fu@cixtech.com, fugang.duan@cixtech.com
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org> <atC+lsWALy6ueGAB@JohnnyFan>
 <14d16970-915b-4c86-afeb-bfc3058564df@arm.com> <atGl/ZTg49t/VfVj@JohnnyFan>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <atGl/ZTg49t/VfVj@JohnnyFan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/15/26 11:20 PM, Johnny Fan wrote:
> On Thu, Oct 15, 2026 at 10:58:10AM -0500, Jeremy Linton wrote:
>> I don't think the GICC is sufficient, you have to consider actual
>> heterogeneous machines that have differing SPE implementations with the
>> same PMSVer, which mean you have to keep the PPTT hetid check, and set
>> the mask based on both it and the GSIV. Then, like DT create multiple
>> platform devices. Which is true with the current patch as well, the
>> hetid still needs to be there even if you have differing PPI's because
>> it could have more than two differing implementations.
> 
> Following that direction, the question on ACPI is how each registered
> SPE device gets its supported_cpus: the platform devices are created
> without an fwnode, so platform_get_irq_affinity() falls back to
> cpu_possible_mask today, regardless of which CPUs actually implement
> SPE. That's the plumbing question I asked Marc about -- would be good
> to know if you have a preference here too.


I may not be fully understanding what your asking, but you could just 
attach a cpumask via platform_device_add_data(), or similar method, then 
retrieve it in the driver(s) and use it to set the affinity.


