Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FE142E8F;
	Mon,  6 May 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994902; cv=none; b=qHHSaxYrKogrAvbMJ8ghYu9Q5M+m4BpgeeaHHw81zWsVqlUPG3lO3KAD/mwbv+7PpOfxjChw2DJNF1/DHYfACnLAvnz8o1mVo9XoXxPq/+b4XM3NQ4d1vhrRuJk3sxRp3dilvjpRTyrXWB+mtbgKSyCGAgqRlhHhyvlcTNzh4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994902; c=relaxed/simple;
	bh=8VT02Cplsv5SbgjU47mcWoqY++8UyIgndGhQEg+ULN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh4j6UnFI22HTlCM1I4spSfsg3fGDY3ws65h3fkGvQrpIOfL7Ug1hcdbGaTCIAYUX9eNpqHWH43hkQnk5Otv00fwTrTbfhj6LwGNFCtzcokMIDIJMpx9vC5QMuE/0qcUMKfetq+NHN6QMDFu6Jd/0Y5xi6ZJ5UB1C3/JdgLSXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXzfz1nxJz4f3l8N;
	Mon,  6 May 2024 19:28:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7C6C11A06D6;
	Mon,  6 May 2024 19:28:16 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAvNvjhm9aLKMA--.42285S3;
	Mon, 06 May 2024 19:28:14 +0800 (CST)
Message-ID: <c85cf47c-c972-4c11-a103-8811fe0b4680@huaweicloud.com>
Date: Mon, 6 May 2024 19:28:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/2] Fix small negative period being ignored
Content-Language: en-US
To: peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnmAvNvjhm9aLKMA--.42285S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJ
	UUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Ping.

The previous link is : 
https://lore.kernel.org/all/20240116083915.2859302-1-luogengkun2@huawei.com/

On 2024/4/17 19:54, Luo Gengkun wrote:
> v1 -> v2:
> 1. Add reviewed by for perf/core: Fix small negative period being ignored
> 2. Add perf/core: Fix incorrected time diff in tick adjust period
>
> Luo Gengkun (2):
>    perf/core: Fix small negative period being ignored
>    perf/core: Fix incorrected time diff in tick adjust period
>
>   include/linux/perf_event.h |  1 +
>   kernel/events/core.c       | 21 +++++++++++++++++----
>   2 files changed, 18 insertions(+), 4 deletions(-)
>

