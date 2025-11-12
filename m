Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1723D7D7
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762918095; cv=none; b=EuEZlljRxrMWVjYoE6tI1r1dYiy8xidFy/k+/Q527DJe7jQSptgt+k6UtS1ZAxlpe+FxZBeh7QcDfa27i57NWt5ZXx4IPV/s5Flug5rMK52dTdcVKiyT7HvNl+9BFY6cSYTPyvT/IYrgqpvs3SeCFc9rhDM5VJqADlqH5Oivfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762918095; c=relaxed/simple;
	bh=fV2iMTMramtjmMeD00HnxbCHxEQvqSmy+lvFzGovXXc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e/ZLvF3mG+0DnQgxHzXvjgl3FJShcbZnBTaPeuJjpN+mcobQ1LNttc0nPRLcaTT/TW1gf5cF4tAqlO1h6CtMAPqALe3IQEpIXNWtMttzXs7rUi4anuVP53ex2xRfED10cZIq0AiY7aIDI/opAJKM8PrJurTlFvq5o3XV6WHoIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aYbAzKEa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aYbAzKEa"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso221910a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 19:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762918093; x=1763522893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MvXqIM2Kx1gC5Q1+jYgAsgab/53O5lp19dTKMbp8FHM=;
        b=aYbAzKEayV9u9ZGSTcM/+lnl91Bx9q71av84J4Dkf+oiHoc4KX2MboRZEZc+Kc355g
         isCReynfavRg84I5UPjxcZRvgSPcUmJ+eVUe4nAWKtLtL9jR7t0+E23TvORtdwd24LHv
         gcB26mq3TlgIzUMBQJgBXUV38/5S0O5rUdLrg7t2pp7K2navVP6ITs9fsDdCdZGgsxuK
         +8TryJvvkZgCgxKtV78rNZcUkfJscgnfh35Kb7hRLjRGnEtubUeoz59m3srvaWdMiiEE
         Ng96TQijtWgog2dy0tn/eMP+hFGwmrp+KJDknyDPn+YeUw2jvgG/nb9rJ3Uun8iC6e8U
         y2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762918093; x=1763522893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvXqIM2Kx1gC5Q1+jYgAsgab/53O5lp19dTKMbp8FHM=;
        b=aF0jRkxP9/2hdQp6MBLZk+Q3ANKlZ374QmMhd/1cs05+kTXNhrVz3KjEKw9aPm3pGG
         rmHTGMQt7s7nGD7lTA2r7CMoUwwsqFMfI47UO378Nx5K4pfEVuNoOcNatHbTrDCnNXqR
         7wxqBb38qoHhqz/EjIGBnEZnfnhDqjRZC8q6JgUS467PtMEbFso5UPKjKcpfSpx6MfFV
         Z7WvZ4wblUKkdjf6BAJSl3q3k/TItDfF6ikPyaKoiOL6SjbCl8jyUlScJMh3kDYxXORd
         w9Lv1m1x5C/XbaBnJ0rwDNYIFxOxol6M8ViioJ6Bwc+6M8S9+XxA9oSevmUgMl9jQAPd
         kvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpswgyf0wPWUXBJt/YWK+pprJGblzEmk841YIlDav4rjmWSNn+39lb6ej5oF0LBC/jXwzY+2fTD3SIse+xer4f@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuom3LWkxJylA4vC7TTj2RjvAHiIJTz6mZR1dx63Bp88UK2aQ
	xpmZJMj5AkNJMxtzlE2KRZIHBtpmA2Rg581oUXVskyWRd6/qg54ZSKbHZNS1ZNff0vzKZUshIue
	NEVM2
X-Gm-Gg: ASbGncuH5NxuXYckXouCbb+5LTDeoZlmk6vminprQuGu1/hOAqwmhCLtPzb+w7fGNAW
	jZYkz0py+lTkvcSHo1iKcbfBWC8J7ae1J1vPCZyKP+G6a+aKyZLKFBGIphOBj2YnTwZatE0bdrD
	W/xsl4syJOE6HZrDhQ5/dmb+5uw/SqAvcrKAejQ6raipEfbnX8XG4lZomRIKR5BR5MkDuJy0zEs
	PAivyFeTXtDemOKv2fqJ3AyvXfWYjOpKpV3Ad5G5E97ENNYaGVL4o4nfMgGTm5Ysl5KQlqffad+
	nc1gcuKUE06rNPbY1pbjmJVwkD7KgiKkwdGkAt0CA+ae5Ao/78bIQLjxsV5Biw1PeJvHBZ5RPQS
	Q1zGVn7ejylIa965sIBj05uaQ0+0D1M/gV9KSNLmpG995R0tiIfLpq1/c/kExXcWExn4DVkOezU
	sOPm+/zNvPQ4mbD2SvfVHre8mcIQ9YjEtNDRWbH23X9Hp8K29z790ZyQ==
X-Google-Smtp-Source: AGHT+IHjQamBj3bCLsY01rrfJ1JjY59qu2CtviaxITwggjQ7mKKSi5jsY53X1IycsXPEkh4PpaYpUQ==
X-Received: by 2002:a17:903:fa7:b0:27e:f018:d312 with SMTP id d9443c01a7336-2984ed2b587mr20220615ad.1.1762918092891;
        Tue, 11 Nov 2025 19:28:12 -0800 (PST)
Received: from ?IPV6:fdbd:ff1:ce00:1b26:822:3294:d7ca:6065? ([2001:c10:ff04:0:1000:0:1:d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0c41sm12843415ad.87.2025.11.11.19.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 19:28:12 -0800 (PST)
From: Liangyan <liangyan.peng@bytedance.com>
X-Google-Original-From: Liangyan <liangyan.peng@google.com>
Message-ID: <b079b4f1-4d11-4137-8204-16935dc12129@google.com>
Date: Wed, 12 Nov 2025 11:28:05 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] perf/core: Fix pending work re-queued
 in __perf_event_overflow
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Liangyan <liangyan.peng@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, zengxianjun@bytedance.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251109103253.57081-1-liangyan.peng@bytedance.com>
 <20251109164122.80138-1-liangyan.peng@bytedance.com>
 <20251111133023.YqDNgQak@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251111133023.YqDNgQak@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/11/11 21:30, Sebastian Andrzej Siewior wrote:
> On 2025-11-10 00:41:22 [+0800], Liangyan wrote:
>> We got warning below during perf test.
> …
>>
>> A race condition occurs between task context and IRQ context when
>> handling sigtrap tracepoint event overflows:
>>
>> 1. In task context, an event is overflowed and its pending work is
>>    queued to task->task_works
>> 2. Before pending_work is set, the same event overflows in IRQ context
>> 3. Both contexts queue the same perf pending work to task->task_works
>>
>> This double queuing causes:
>> - task_work_run() enters infinite loop calling perf_pending_task()
>> - Potential warnings and use-after-free when event is freed in
>> perf_pending_task()
>>
>> Fix the race by disabling interrupts during queuing of perf pending work.
> 
> Makes sense. Lets it does not overflow in NMI, too.
> Either way I suggest to trim the commit message and remove the
> backtrace as it probably does not add any value.
> 
> Sebastian

Got it, I will remove the backtrace in the following version.

