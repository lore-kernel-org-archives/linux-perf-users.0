Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094405;
	b=roefEclfFGh+B3uD7Jn5UHpx3R0aviLJi6Ny8mw1vovsI2cGthyr3hVgzfOD6HnpsI8D
	 kz40dz01h4iotQe1kJzRdjorXHHS6gdRxMoMxqBEI4h6vm5Er2FNTGOQm2+ZJ7DUCNNqF
	 hLnWwe9zUadhIEPDYtOFlMfjRkoNSIURmBfhLxiuh4+mVD09FyfgtChxC6MPFdMXpTTiQ
	 Dq5OUb3+T0sv39A7CJFtEfv43hgn4cpmqCt6myIIclHqxNac2SagMi/URdRibfpRaNpQz
	 x1ljskb6aJRwtf+cbMZNIZ832uHW+rSEu62UMATiF2v7mpeiXufRexQyiXpE17Iwjaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094405;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=MjGjSKlQ0KK+uxJoHRAH4eUzsVoaq/D03gp40Ks1rEY=;
	b=ZsEvRJss1dgYQIv+ijFckx/AdDguek9HHrlOCIVpIxBRsFc05JCsEksQgaWJ3GBOcojA
	 d8VU7n7Xq+J0SnUKgbn4a5WNHwmsD5rBgQyc1K1A3Yyy7UNW7KnF5cY14oTaUjh6V36lT
	 e9Vn29fJFZtDOXdx9H0a7EAwSNpA3gJ16BoUk30hw7Yeh9jZCJ9oNKy+lG+nbvmo52jRL
	 0fDjvPbAPwKQYgYUp4iM7TEgECBgBcK4B9PnR9dRzunktfF3ElOSFeXYhndoZHYAro57j
	 dnxO3Wzpqw72OIoyPtihGEB9T+rFdLKmIiKQFg8XQ+zk1/pcer6CIW2e5g/QHTWgNMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29F606A326;
	Thu, 19 Nov 2026 13:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA29F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jVfF71L4sz1xs2;
	Thu, 19 Nov 2026 21:19:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 751A040BF4;
	Thu, 19 Nov 2026 21:20:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBHfu1_9_5qERTkEw--.43018S2;
	Thu, 19 Nov 2026 21:20:00 +0800 (CST)
Message-ID: <0aa4bf03-57a8-48d8-b8db-4246716c48fc@huaweicloud.com>
Date: Thu, 19 Nov 2026 21:19:59 +0800
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
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
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
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261119121143.pJrJE7qs@linutronix.de>
 <cc76ea5a-545a-4560-a039-ceed1de7ff3e@huaweicloud.com>
 <20261119130704.A5iZtay-@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261119130704.A5iZtay-@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHfu1_9_5qERTkEw--.43018S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry8Zw4ftw4rCw4fAw13Jwb_yoWxKFXEvF
	48Kr95Jr4fAFy2qr4xKF4SvrnYk347Jr1qgwnYqry2kw43K393uFs7urn3A3W3Wa1aqr9F
	gas0qr4Sqa429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/19 21:07, Sebastian Andrzej Siewior wrote:
> On 2026-11-19 20:17:20 [+0800], Tengda Wu wrote:
>> There is a test case, see this:
>> https://lore.kernel.org/all/d1b24bbf-9111-4766-87c8-ff97adcac727@huaweicloud.com/
> 
> Now I remember. Would it make sense to include it to
> 	tools/testing/selftests/perf_events/sigtrap_threads.c
> 
> ?
> 

Well, because the trigger window is very short, it is not easy to reproduce.
The test case I provided above must be stress-tested through multiple
rounds of a while loop. Is it inappropriate to put this kind of test,
which requires a while loop and has a certain degree of randomness, into
deterministic test cases like sigtrap_threads.c?

Thanks,
Tengda

