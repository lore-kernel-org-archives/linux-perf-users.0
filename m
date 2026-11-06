Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958717;
	b=sq4Ea9qVkCn8rkZVywvk5vlij7QT6e3Wp542lIES3ZKRUDRhsLnJs7gEcT8cbV3JKc22
	 Fln1kzLfFNl8awAG6V52jdhYddVe6HPJNW1gqkUuaNtYFl72csY+E8tb4idcGDt6MuGFD
	 bRwAJxeSAK9DwzIcXkZXgvDGOHoe1yRHP8WUViyZ3QEP/Y+BDaHCjlmrfDuUdRHAEk8X5
	 WHtqE12ITTTvxyl2kwGhm4NjHoYuUzX9fv+mxPXfTyJJjav/cv04LTJ0xSJt3EzQpNEYN
	 womb1pmScKAmmEoxBIDKKQLlC2pM3jTCGHrcbVsjZYBunn0RZH4wCvIkltyk5DE+VrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958717;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=gbUYFO1GQ14u1DHN0T1ERQGs+tAoXo7YRe7M2+DS1tQ=;
	b=og+YkQ7Ndaq2bC9GKJFisLlttpOtlE/gu4kRboI4zWntR5G19I5N4+MGHjhfpwOFIP9P
	 gP0eK7y+paOW07LXOD+UT8NMm/2BmjwPUwsyNLHk3ET8cpHqSvM4wq/9cUyyCr9dnfoXU
	 j0pKOutI/w0PAm1NdQkcxSR+7erxdgb3ehb5x2l2+VPr1Du2xFw5ETSKgMcqDGS0CLm5q
	 DiSv+YhORhuol4zl07aIDwPMbKZIMRCjpZ33qLJxxQnq0VOu7hxg2DoL4g85wD058jiRz
	 9EoNmWwMtYxMaPat9omAUB+mvn05ef1NTetbzYVUWwFQEwpkQ3GJoi8g8AFpt3EOzUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB9606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 09:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BB9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxntI3o+1q8wcdAA--.18228S3;
	Fri, 06 Nov 2026 17:51:51 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c0no+1qb8IyAA--.38726S2;
	Fri, 06 Nov 2026 17:51:36 +0800 (CST)
Subject: Re: [PATCH v1 1/2] perf tests: Assign return value of ioctl in
 wp_modify test
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20261106092808.6914-1-yangtiezhu@loongson.cn>
 <20261106092808.6914-2-yangtiezhu@loongson.cn>
 <sashiko-outbox-201127@kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <79708703-7e59-315b-04f6-9d24a694eece@loongson.cn>
Date: Fri, 6 Nov 2026 17:51:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-201127@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJAx2c0no+1qb8IyAA--.38726S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
	v_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UiiSdUUUUU=

On 11/6/26 5:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:

...

> [Severity: Low]
> This fixes a missing return value assignment introduced when the
> watchpoint test was added.  Should the commit message include a Fixes
> tag?
> 
>    Fixes: 2e85d5979e8d ("perf test: Add watchpoint test")

This is just a simple test case fix, so I'll let the maintainers
decide if a Fixes tag is necessary when applying the patch.

Thanks,
Tiezhu

