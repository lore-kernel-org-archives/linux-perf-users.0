Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9453AB277;
	Fri, 10 Apr 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809072; cv=none; b=tWOzNG3f6z7w9/MXGQKEdpeRtfvW2R9fDO6o5BuV7WXcIz6sdHACWxfLG90uv0yCirRUXF7RLSw9eKMR5HuViKwOESymzYCkK4OlGKQaiAD3MZlREzWnrVw8wyhHCdUvJ04AllNyM7Y57U1Xt0iFo1DwhT3Cl+6jMh8EyBN+IEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809072; c=relaxed/simple;
	bh=7yPJy8+ELAbFCHiuiVyLdoOmHG1RhYqgN6WN3B5/QzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7Iwf79XTwKjM3ZfxCCXd6diFDkULs6Ts437a3Hqk9n8gwGn4m8VPqehIz/iA/IZ8TMcJY5O124aDmU0QTKwb9Cn0uGmhe0f414QDHE91v1NCbleqKVDdKtVzgu8WK68ejGeo99heRUv44hgamEiCDZ+Fac6DiYN0L/ELxOLo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsV6K1TYwzKHMMx;
	Fri, 10 Apr 2026 16:17:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B04C940561;
	Fri, 10 Apr 2026 16:17:46 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgAnBVIosthpE+cXEA--.45623S2;
	Fri, 10 Apr 2026 16:17:46 +0800 (CST)
Message-ID: <4e38389d-b74a-4d50-b499-1fd76d9573ee@huaweicloud.com>
Date: Fri, 10 Apr 2026 16:17:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] perf arm64: Support data type profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <adSkpI9AoTNgISU5@z2> <5fa89ec2-122e-4937-bec6-fe5dbe3ae07f@huaweicloud.com>
 <adif9rnXtvUm7W8T@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adif9rnXtvUm7W8T@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnBVIosthpE+cXEA--.45623S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1Uuw4xXF1xWFWrJFW8WFg_yoWfAFb_u3
	y7KF1kCry5Gw4vk3WfGrnIqa9Y9rsrJry8XayFqF9ay34kJF9rZw4kurn7CwnxZr48tF4q
	g3W5C34rA34avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/10 15:00, Namhyung Kim wrote:
> On Wed, Apr 08, 2026 at 07:35:22PM +0800, Tengda Wu wrote:
>> Hi Namhyung,
>>
>> Thank you for the feedback.
>> I have received your comments and will get back to this as soon as I can.
>  
> Thanks, I've reviewed the instruction tracking part.
> 
> Basically my concern is that you should invalidate unknown or unhandled
> cases so that it should strictly maintain the correct states of
> registers and stack slots.  Otherwise it would contain many incorrect
> results.
> 
> Also, please take a look at sashiko reviews which spotted many things.
> 
> https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40huaweicloud.com
> 
> Thanks,
> Namhyung

Much appreciate the thorough review.

There is a lot of valuable input here. I will take some time to deep-dive into
each comment and ensure all concerns are properly addressed in V2.

Thanks,
Tengda

