Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396661;
	b=ySMXryBjFV8m71ew9BYffjlBnErNXebIBNR1gltN6tBGcEnQ5JVJ3SXUOk/+HRkg24cY
	 zFFU2Kvz8qPZBdmctQ8LE7ZHEa6THMFP5pF9YgPiktXWGhrAoAdfC+/MNGCxtP2JuO0BC
	 TIla5/f+xGTXy8Ngp67J4Jlyl/SXezXTjvECE3a80a9AtzPt0O0nMvsqdJWVbiixxZcKa
	 r3A5uF58hNHia1Cen/3qZEn/ObRynorjxln6C6ObW4DqI/EKuxhoU7hPET+pW7+4lffGA
	 QzWKVivlt52/7lNYk/2LZnf9cb6BDMvvi33phS6eQbY3PcBLHat0kg10sBLRo93co/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396661;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=SORymCjbMCFkb6rdzGj9ji2mQ7C8CsoXg/OHwL7/WCY=;
	b=ajDEcmF3IXxazWFUYeYThkezypbXCAF3dujEgPDcYHjUQcF71+waaonk5VkxHnwAmKla
	 9e0ZBUn5F9hixF3R19a7AuJv4ixGClvy7QwomE70u/oyGbh1kWeZ/JXkPqrpzM9DsIbfk
	 k/7rFdIIu0mWitah82tMavv97ixvBIXKx1HOOJVcPHYMJe64LKZpKNbmCddQjeffreLBc
	 NM9d5UMnxrUfnZLmIxcXiOFQwZ/KpsxuZkA5alkeEpOc4ZJVrjtYpQgWMLV3U1HsB89gW
	 660JexHb4+xRz0PdY1zpP/O+WWkIZuumLFOHa5z6y8Tve2iqq0SpyyWqh/tly1BxJDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48027606A333;
	Mon, 23 Nov 2026 01:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48027606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jXp1T5m85z1rqWm;
	Mon, 23 Nov 2026 09:16:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5A09E40574;
	Mon, 23 Nov 2026 09:17:30 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAXbtMolANrEoJnFQ--.47197S2;
	Mon, 23 Nov 2026 09:17:29 +0800 (CST)
Message-ID: <90ab8953-a2e8-432f-a338-ce216136e22d@huaweicloud.com>
Date: Mon, 23 Nov 2026 09:17:28 +0800
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
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261120172831.5XwELZY5@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXbtMolANrEoJnFQ--.47197S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYa7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84
	ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI
	0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/21 1:28, Sebastian Andrzej Siewior wrote:
> On 2026-11-20 17:26:04 [+0100], Peter Zijlstra wrote:
>> Also, sending signals on software events seems utterly insane. But I
>> don't support we can go limit that now :-(
> 
> Tengda: Is this an actual valid use case that you have here or did an AI
> figured out that this broken?
> 
> Sebastian

Sorry for the late reply. No AI involved, this was produced by running
syzkaller. I've turned it into C code.

Tengda

