Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660657;
	b=n+gIRVwAHLY/WMHxp4SzV5E9gRPXSMA+RRkLsXMfICGhomzvhhligyI173Wf7NMW8RLG
	 tsKHMlsbkWhBPGYffApo8OJcuw2UVNf48PEHv0fCNFXZeO3MTjnijPX7e01PoGpIpzfv+
	 INaOioxnZAEMnQWTQPX1iB5k2/sbh+ku2OOO/5Ck7pVzzs1jG2UNBdS+/q39DqRzFwBAt
	 co8nz7LfnZ6btbo6yT4Z+Dpx9WzP6xeZvZQVfAr48KujXqalObcMKvl8eBo1opoIwuV1G
	 TDp4hhSbKbPynywxf28lX7UnOF9b42uuP+leCIau7KbFIjZzHzBUwsH79meXsiWqqGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=Stvtmahd5i/3uuqc3lii8Wy4EZnXVDq1RllK7RSbpKw=;
	b=ThUgstgDIQnDzO6Yq6zumgCTDq5/W1qWYw+lNZvI/RNA+7/k7fw0CPW9bIrzrV/ybwkZ
	 o7hF96t2k2WlIvxUnkXTOsVUJcC50S01JPWwp4KZOeucL58lm7p5zWN2F4vKgF3NsCCpO
	 O2um7wHdY4gdSnK6Ax36aWNAkG7kRLTNM1jveBF+FZ8Sa8uUHNW6XIQia8JiwcnjfzMmJ
	 h7AbM29An+d+d2UBUnGmhyHqctMp4sI3eWQSpieL7yiOlWgjVSH15AK89N4ZRiNmz2DMi
	 T5kYE8lumlVGgvBsUUosHE+4T3/++hOqwZbKQMgb8QJcE2AuIe5COtNgPogZsd6OXZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mR4xOioC;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4D606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB4D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mR4xOioC
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36661f953e4so5543697eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793660656; x=1794265456; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Stvtmahd5i/3uuqc3lii8Wy4EZnXVDq1RllK7RSbpKw=;
        b=mR4xOioC8Z7ZVGwKjyUeiOVGYYKT7pVDPhtMMOP9fPIyHVtajO0smZJ8RY7+8Ml7Qv
         V4vcj9aMr58UAw06hb1O8CiS1QeSN9PLryW4FrIGU7EMoCNyLgRNfasJOHDxIwGlZ730
         dMoH606UL7Gt5snZH9DGyuGVTN5JBoA0jtm7savmJxWXpq2FJDbFae6psXb2S4bhpE9+
         HvuqGHAT7P3AxyEPIeOBG2xFrxIgZsC/t+SbPqLk3y8rcXCAijOhCo61aSnYZiT6A4Vw
         wbFz0YWtW6KwvGiplQAJUinzY/zbTl5lB5HMvjo21KC43m9VqUiH2KchXl/+Y7nIUtIz
         okyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660656; x=1794265456;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Stvtmahd5i/3uuqc3lii8Wy4EZnXVDq1RllK7RSbpKw=;
        b=cx+7cViMK/FifxST1i2N+KKN7+6cBdkNzrDPw/ID/M2vSfTDGvL5LNn191IDhM72Z2
         I9RWyyhet5xsXIszx1IHuXPWRstTVhVXdpQJtAFSD3FYG60rm6kup1XeYjOk+iadR9SX
         eFobgFfoPnOA5gdMzQhwC0C3NRCcjfRFOmbhvaSMh9wBPXD8iM7TBWS/gfPgTQhOxVGl
         tG9eORyxS7GDY0br1Bvk/qqcApcmCqIflSeWAPKwXXxiTyORrqTvTUteJsUtgQkxOJHg
         xSXVDghL7wPnfpM/YTFWHsGC2izzH8x8lYuUlag1dKI377qvd/FOosw2OR7GE5UsqIaY
         mLsA==
X-Gm-Message-State: APuU4Z+eDQhYCMQ1dLVyVu4jhnY3WS3Jl6U63L/OWSpH0UcVvcVve4u7
	5tmEiM+qTBb2/A9CwtxKGrYMzzsDg8tq4lyXhr/mRbQuUf8DejrqbHwfdcClYqW/sTZaL8LCynq
	Ii3XJf0lC
X-Gm-Gg: AYBFou0pIkrTW4jIwrLcR1X5NjB/8Y50OR/iJeY29PuUpnfaWZnHHBkCSOkJQ4PChV4
	l/T5sc8yMX5dHa+sf6RAUZ2LgEtJJhR5pTBmo6yfEj5zIN9K8U6QQgU6XFRFXe1ezod/YM5l/Sv
	AJGm/4SN1F30fGZ7fqqfnc4p1Q6m2fdLYwh7xDAKR7uIWzzV0ivLRwpG2J0KRqFBdZs8ENGmA9q
	OiUmrNk6oFxLEEr7PiDEB+n5vAC4rA7105qQIpcuyIRbpEQANkXJcRTmdxBwaxzQ+qjUGN7IFJK
	kgUo7mZb0v0UF3Uj1QXM7/yDl3C51QX4TWTMGZVB1irKv4hXJeB2NgWRF8peCsXkI6t1KtIGsLS
	lyJyKcAFSI3rOl/0NCKBqIh8twcGDvmJ/Dc4A6NhhA1fGErUrSrh1prL4DmA+pwZoi2zh7P1xii
	iC5crYdjbyg3GLpudR0K0y83a2kMpFGwgwn185097gm/UpaeIb+e+trauogKLe4gstzoYs9FJ5a
	mcQfO4JoHvOfkbfd3iCfe4MkZGKAiAQDD8grb3JaTUz6GzY4wkWikb+pKF/JlJaUpsrVT2FvAZS
	LogNtyooTadW8Mcj1BLO8oQ1Vud9Apdwu6Xm3A==
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id 5a478bee46e88-36a423f6947mr15717078eec.32.1793660655437;
        Mon, 02 Nov 2026 15:04:15 -0800 (PST)
Received: from bsegall27.localhost ([98.45.141.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm48932559eec.26.2026.11.02.15.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:04:14 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: skew perf_mux_hrtimer_handler firing across cpus
In-Reply-To: <sashiko-outbox-190118@kernel.org> (sashiko-bot@kernel.org's
	message of "Thu, 29 Oct 2026 23:42:33 +0000")
References: <xm265wykhyrv.fsf@google.com> <sashiko-outbox-190118@kernel.org>
Date: Mon, 02 Nov 2026 15:04:13 -0800
Message-ID: <xm26wlquhm36.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: data race on cpc->hrtimer_interval in perf_mux_hrtimer_handler()
> --
>
> commit 21db2df032d9ff638545ff8ead07c480ea100710
> Author: Benjamin Segall <bsegall@google.com>
>
> perf: skew perf_mux_hrtimer_handler firing across cpus
>
> This commit adds a per-CPU skew offset to perf_mux_hrtimer_handler() when
> the mux hrtimer interval changes so that timers across CPUs do not fire at
> the same time and contend on jiffies_lock in nohz_full configurations.
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a6c8e38a31104..80d142986eba7 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1279,6 +1279,7 @@ static enum hrtimer_restart perf_mux_hrtimer_handler(struct hrtimer *hr)
>>  {
>>  	struct perf_cpu_pmu_context *cpc;
>>  	bool rotations;
>> +	u64 offset;
>>  
>>  	lockdep_assert_irqs_disabled();
>>  
>> @@ -1286,6 +1287,17 @@ static enum hrtimer_restart perf_mux_hrtimer_handler(struct hrtimer *hr)
>>  	rotations = perf_rotate_context(cpc);
>>  
>>  	raw_spin_lock(&cpc->hrtimer_lock);
>> +	if (cpc->hrtimer_old_interval != cpc->hrtimer_interval) {
>> +		/*
>> +		 * Skew the timer to avoid contention on jiffies_lock in
>> +		 * nohz_full, whenever we change interval
>> +		 */
>> +		offset = cpc->hrtimer_interval;
>> +		do_div(offset, num_possible_cpus());
>> +		offset *= smp_processor_id(); /* we are PINNED_HARD */
>> +		hrtimer_set_expires(hr, offset);
>> +		cpc->hrtimer_old_interval = cpc->hrtimer_interval;
>> +	}
>>  	if (rotations)
>>  		hrtimer_forward_now(hr, cpc->hrtimer_interval);
>
> [Severity: Medium]
> Can a concurrent update to cpc->hrtimer_interval from
> perf_event_mux_interval_ms_store() race with perf_mux_hrtimer_handler() and
> leave the timer with a mismatched skew offset?
>
> In kernel/events/core.c, perf_event_mux_interval_ms_store() updates
> cpc->hrtimer_interval across all online CPUs from the sysfs writer CPU
> without holding cpc->hrtimer_lock or using WRITE_ONCE():
>
> 	for_each_online_cpu(cpu) {
> 		struct perf_cpu_pmu_context *cpc;
> 		cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
> 		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
>
> 		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
> 	}
>
> Meanwhile, perf_mux_hrtimer_handler() reads cpc->hrtimer_interval multiple
> times without READ_ONCE() or caching it in a local variable. Between reading
> cpc->hrtimer_interval into offset and storing cpc->hrtimer_interval into
> cpc->hrtimer_old_interval, calls such as do_div() and smp_processor_id()
> (which calls debug_smp_processor_id() out-of-line when preemption debugging
> is enabled) allow the compiler to reload cpc->hrtimer_interval from memory.
>
> If perf_event_mux_interval_ms_store() modifies cpc->hrtimer_interval in that
> window, offset can be computed from the previous interval while
> cpc->hrtimer_old_interval records the newly written interval, preventing
> subsequent timer callbacks from recomputing the skew for the new interval
> (and potentially tearing the 64-bit ktime_t load on 32-bit architectures).
>
> Should cpc->hrtimer_interval be accessed with WRITE_ONCE() and read once
> into a local variable via READ_ONCE() (or updated under cpc->hrtimer_lock)?

This is correct but a pre-existing race between updates and all the
readers. I don't know how much we care since as I understand it, it's
root config changes hitting a race with the readers, but it's easy
enough so I'll send a separate patch for it.
