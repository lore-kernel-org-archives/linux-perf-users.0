Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB028D829;
	Wed,  4 Jun 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030151; cv=none; b=nTmnpjTZ2IaZFisGJgISy6dd3oBIaAOoatmU4RUQENEFyBpzKNlPrtPADqjj/zqu11cn2/ZgBkmTsSXbFuN1LbTRl2LIa7ZiPNFiDWBZU0pVnRL3rRCxXcUw5pvR5ZqM/lzJxLKpNdunlutIMPpydU2be98bjJkwfIQT0tPaWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030151; c=relaxed/simple;
	bh=T5+Ln4XN9sxY2gSJUt11BokxdNrJwnzj76RiwXB9b5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJebAybzq5yme1lUxYGAkqyLxs6mMacWkR/rfj8zkXhv9/E01DFapm/sTPLRpjpSxku92GbyyROzL9N0wpZGjo/LF+a6Mgc0TEEJ7yKHC5Jmfi4Wm0UZFzpTGOCay6n23fSyLwivhFd31CHiAR+agdRXkDHCBi720otR9l48fDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bC2g75BByzYQvld;
	Wed,  4 Jun 2025 17:42:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C066E1A13F7;
	Wed,  4 Jun 2025 17:42:26 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl__FEBo_8fhOQ--.23040S3;
	Wed, 04 Jun 2025 17:42:24 +0800 (CST)
Message-ID: <f3aead4e-9757-40f2-97f1-9b6f885939b3@huaweicloud.com>
Date: Wed, 4 Jun 2025 17:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/core: Fix nr_cgroups/cpuctx->cgrp is not
 updated correctly
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 davidcc@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250604033924.3914647-1-luogengkun@huaweicloud.com>
 <20250604033924.3914647-2-luogengkun@huaweicloud.com>
 <20250604091936.GG38114@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20250604091936.GG38114@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3Gl__FEBo_8fhOQ--.23040S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1rWw43CrWrtrW8GF4fuFg_yoWfZFX_ur
	4xCryvkrWqqrnxGFZrtrWYvF9Ig3yUG345tw1fKFW3uw4fXrZ5WFWF9ryfA3sIvay7AFWD
	K3WavF1kZryYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/6/4 17:19, Peter Zijlstra wrote:
> On Wed, Jun 04, 2025 at 03:39:23AM +0000, Luo Gengkun wrote:
>> Since __perf_remove_from_context updates event->state before
>> list_del_event, this prevents list_del_event from calling
>> perf_cgroup_event_disable, resulting in will not update nr_cgroups and
>> cpuctx->cgrp.
>>
>> To fix this problem, move perf_cgroup_event_disable into
>> __perf_remove_from_context as:
>>
>> commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
>>
>> did.
>>
>> Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> So I already have Yeoreum's patch for this:
>
>    https://lkml.kernel.org/r/20250603144414.GC38114@noisy.programming.kicks-ass.net
> Oh! okay. But the second patch can still be reviewd. Thanks.

