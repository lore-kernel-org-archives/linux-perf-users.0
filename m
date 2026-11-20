Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136143;
	b=qHwmJAKj3p+9TRhOXe+bLqmpwVtPGLhqFRZmnJjTNlnzfyi3+dCFbdJyOe88rn0qYHe3
	 uPX68HeTE3btECTM+FrUa6RU7et1M4MlACiK9L8eaVGbhNaMWzNURFv2gKn65WwO0ZSd/
	 v6ASSTLgwhMgBc2o9rQw+rePP1d2CVZMCclD2Vy/i1S6f7fINQpeEMNYxRG1oTyorsXqN
	 xqW6F7Wmb+cSNwEB9hIPjvqnKNBqsk9FJsvsb6wnEamOEMxl6FMd4UK3YlIg9cLNZfy9S
	 iqZ+B14qupjUBXvrz1e5T9SPqp3PkYwSPQsQrFk7zKfMa0nsjnWukgyhLXEIyBHFptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136143;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=cOmNtCyywSYPb3pjKVlgzTU/s/3EYhuhoHpMV/mNAB8=;
	b=KUJPep76v7UMK6hRNzmPRqKfVQDKr3bF73WnHzKQ3263q0IhkoLTczvoJbiewtoeALFT
	 Gl8DE0g41eDWPGwRLekB31uX3eeUegUOJIyumchKa3jn/VKQLQ57hC9u4bkqcxvFMydkF
	 AgApfSzQEiaaSc/aTjdNOzOrIOtHcfdGoIdufra1tFJOoWMOU45BMCZOOcOn+zgKSLhYF
	 6z+NNMDMw9qX7JVmbIikeJ55V85FEv5NYVpMOZHnfUE8nbZMaO3WL0V74RHfU9ogy/9Ej
	 aDIAyb5lcIi9vaCN11fhEwdyR8vUTn63+i35SuFBhDUUHndwwtlJxR8eZMO7VazrTwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B31606A325;
	Fri, 20 Nov 2026 00:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B31606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jVxgm42ywz1yJT;
	Fri, 20 Nov 2026 08:54:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B078A40573;
	Fri, 20 Nov 2026 08:55:38 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCXnP+Jmv9qaE_eEw--.5251S2;
	Fri, 20 Nov 2026 08:55:38 +0800 (CST)
Message-ID: <c741b3bd-b8fc-44d8-b7c4-adf73af379b1@huaweicloud.com>
Date: Fri, 20 Nov 2026 08:55:37 +0800
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
 <0aa4bf03-57a8-48d8-b8db-4246716c48fc@huaweicloud.com>
 <20261119134824.oCI80nCj@linutronix.de>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20261119134824.oCI80nCj@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXnP+Jmv9qaE_eEw--.5251S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry5XFW8JFWDWrW7JFykuFg_yoW3GFc_XF
	4DKF9xXws3Aw1UAr42yr1S9r4DKayxJr18X397tr4YyrWxtrZ5ZF1j9wn5Zw4fZF4SqrnF
	gr15Kr4Sg343ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/19 21:48, Sebastian Andrzej Siewior wrote:
> On 2026-11-19 21:19:59 [+0800], Tengda Wu wrote:
>> Well, because the trigger window is very short, it is not easy to reproduce.
>> The test case I provided above must be stress-tested through multiple
>> rounds of a while loop. Is it inappropriate to put this kind of test,
>> which requires a while loop and has a certain degree of randomness, into
>> deterministic test cases like sigtrap_threads.c?
> 
> Then maybe not. I would have to run it myself to be able to judge it.
> However this thread has a reference to the test case should someone need
> it in a few years…
> 
>> Thanks,
>> Tengda
> 
> Sebastian

Yeah, thanks for the clarification. I'll leave it as-is then.

Best regards,
Tengda

