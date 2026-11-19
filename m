Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090167;
	b=M92AMUU+aSp8IjO8kmfP5myP5ThMejx4gqZV51mwbzfagxXyi2KmvoF1kaNNsSLPG9GA
	 wYY+Io0EGyf6fLYqlnOqBU16EiyuSzWwU7j7udArvtyoeHkDMJALtpM5q5pZhCleom27m
	 PmGNvLIBdtLGPaBfMzfwjMOJ5BNwbRrzoCyLC7bHmxL1eDjjvVkzwR60aV0n5Pl996cQQ
	 nrsCGDD5n0OjqOWmNBv93gDzraiDIZ241sK5O9Rn/0fC0z9YmZ1K58KubI/L9Tny+kZLa
	 D51ZsgLL0Np8Dh0T+b0F92jDiKIVjV30hKKbmqcWAA6MxvhglCWXDbqSPqwSHB0Vqwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090167;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=13JLKby77r602NBIpRXOjznKNZZf82pMBw6OJAVlHkU=;
	b=LECVef+X0T/BbHtNsA+HYI7F1YZD1u6oxxiwg4b0/5c7dn0inAMsSYQ3pPJOSUUaNQtc
	 KfkGnDw1/f6fl03J9tAfOf87f0OUXGeOju2oysfZKqNFBc8O0/tkX7A6TPPpFkjsSfKka
	 UN+8rwfGB2iiIoiX4Dv9hgTMk/SB8pGGM2qFY0AQ+Jqd5jkVkI93vvXSLTn8F+g00Es6P
	 pxFtbQ4xNmnmaBICZ5LZorQo3wCiPpqcuN48Rnbp5SwCllr0MMdzsrSLzwr3j1ifXM7gk
	 EMYXIkPIC0DnyMWp+IcY96eG0llAbLUZ3BZ7261PZkfpQfbgIWOrHjWQp/EbNys//iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A50606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A50606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jVcgd6Wbwz1yDw
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 20:08:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1C66A40598
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 20:09:23 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3wNXx5v5qJcCUEw--.43601S2;
	Thu, 19 Nov 2026 20:09:23 +0800 (CST)
Message-ID: <cd37e569-8e6f-4b77-a87d-b97f53e3b8f8@huaweicloud.com>
Date: Thu, 19 Nov 2026 20:09:21 +0800
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
Subject: Re: [PATCH v4 2/2] perf/core: Disable context fast-swap for sigtrap
 events
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <cover.1794914794.git.wutengda@huaweicloud.com>
 <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
 <sashiko-outbox-218736@kernel.org>
 <e940e69e-f7f6-4c37-a2f9-7caeaf9fb7c4@huaweicloud.com>
 <20261119114850.2dEaCmX1@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261119114850.2dEaCmX1@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3wNXx5v5qJcCUEw--.43601S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5P7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Sebastian,

On 2026/11/19 19:48, Sebastian Andrzej Siewior wrote:
> On 2026-11-18 10:52:41 [+0800], Tengda Wu wrote:
>> Hi Sebastian, what do you think?
> 
> The bot might has a point. I don't see how a pending event is removed. I
> would prefer to keep this part.
> 

I sent out v5 which restores the removal of the pending event that was
dropped.

https://lore.kernel.org/all/cover.1795053619.git.wutengda@huaweicloud.com/

It would be an honor to have your Reviewed-by if you find it acceptable.

Thanks,
Tengda

