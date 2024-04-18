Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431215DBD6
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440087; cv=none; b=B8hwU6mgTbxJVKjoWOey5CvLVe9OiULmV+nHJsCjnsrMKI434Dc0rXeK7qlZMXIJ10kMhx1YoC6xYVBBrFh3bslHVlPdMap8ny6AgdXLO77luXsrFaKrhIczziYabAMzKSaLyMu4iQXXN96fr3gTCG6iw1dNzzK6pH/96b7adsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440087; c=relaxed/simple;
	bh=4zsFF5AYsxVXIzDq1hoiHWnLEdf0Cp55+HBfY2N4ydE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7A3bARzANWNhf93kfAPupDCs/W0Wk75J/PwZZDvGL1M7UaIP4XRokj6r57EsFr2wQIeprjHsV1HadUaNgRNcy+7c4e+0PHGVfSgu818mo0RdwgjpB/8fhPaVuQ8LjNadFpsJ1y/Tifx9AWAsn6YQlBj6vQBz0g+wD3RKwADKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=lOOAkxHR; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="lOOAkxHR"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-238fd648224so274058fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1713440084; x=1714044884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjCBMry39Lk6L9+ALxtldcRfwmnFxKh32JiUZIC2mus=;
        b=lOOAkxHR4lH1DjjjkioIoE5Epgohsk4P+nGV6EVL+rfG9klh+Pk/RJJ/sip5Ng3Ac8
         o7mWB/+4g+wbt2OIhPl+NrjREIaw85WaIpnhKL0mNc1QrhuISp+f93t60iU7RW40PQ+c
         oObhloSRixLtE3SqvgahB0QTvWsOY2loSCHqfbpuPZq8SL8MKEHIvy1fmRm+cj6s0Uka
         4ietJpSrzp12orXxsdF3VNF/vgEu/BtiRrxxcIvy4sbieZ8/Mhy+R4HktRBo9AyVRcz8
         7XSKoYK4ceZ3/TXPWpC8MCYjBAask99XbsjT3jdqVQpg2GxV2vyVw+UCLmIva1r4xRx/
         q5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440084; x=1714044884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qjCBMry39Lk6L9+ALxtldcRfwmnFxKh32JiUZIC2mus=;
        b=KESCXwYU5DBREbEjWCIqqDxiD8bNES/odyDVOn4+nH9YomKDri4LM1+LCfxNhhOVyg
         lBNoJRR6xu9MxWNrSrJPRWqKYiP9OzB8zJlM95+jQPsmdRZYOddhn7xCPQ0iXE4B624g
         8qJGZ3w8XOK2adXjxmYbXU4vEuxRcCPtx/gqHpZ97boDiMWywngkQp3P1aEFxznIH0rt
         1QFDIa4d0ewSX+uTy5GScv6ZZJrJCx25fzUFK47GEL1FxN56PyhZ4hJxFhx+BQ5/rgUe
         loOIglDuoIWnAcYaiPenDdRmZvCR+H2qnGWbmCv3vWM/ol5HdF1jG3tQWtpH732NIxCf
         WCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjWJUzGGa8CAAhmPWcn+gYkOD8v2N4IS5gFqH92m3ejvuSWJGV54z8rrM1Kb7VAoDM8NpaSMgaqg6XyMICKsGAYRdSKcSlpHdwMUvLpggB3g==
X-Gm-Message-State: AOJu0Yyi5qUn6XO8fBTRXiqBEfT2MeixJQqRb2YtWUcwSjIHnrYmQxQE
	UtEkSY5mkvBJ6Rxl788s35L9VBeO78DRnhHh0T1H06D3/tmk/bZgK69siNAl0lU=
X-Google-Smtp-Source: AGHT+IGY3vqQ89fwwmEVtjHhrL/KTOlD826r2HnbLbCoRyGY+no7Hm8XY8UjPWggVrNvkIOhOkmKVA==
X-Received: by 2002:a05:6870:1606:b0:233:5570:a2c6 with SMTP id b6-20020a056870160600b002335570a2c6mr3002340oae.12.1713440083694;
        Thu, 18 Apr 2024 04:34:43 -0700 (PDT)
Received: from [10.54.24.115] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e4432027d1sm1309940pfb.142.2024.04.18.04.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:34:43 -0700 (PDT)
Message-ID: <41bf4bc7-2ef6-4f48-ab93-577753d515b7@shopee.com>
Date: Thu, 18 Apr 2024 19:34:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Fix missing wakeup when waiting for context
 reference
To: Frederic Weisbecker <frederic@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240418080356.21639-1-haifeng.xu@shopee.com>
 <ZiDv1P5AHj7+E7cW@lothringen>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZiDv1P5AHj7+E7cW@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/18 18:03, Frederic Weisbecker wrote:
> On Thu, Apr 18, 2024 at 08:03:56AM +0000, Haifeng Xu wrote:
>> In our production environment, we found many hung tasks which are
>> blocked for more than 18 hours. Their call traces are like this:
>>
>> [346278.191038] __schedule+0x2d8/0x890
>> [346278.191046] schedule+0x4e/0xb0
>> [346278.191049] perf_event_free_task+0x220/0x270
>> [346278.191056] ? init_wait_var_entry+0x50/0x50
>> [346278.191060] copy_process+0x663/0x18d0
>> [346278.191068] kernel_clone+0x9d/0x3d0
>> [346278.191072] __do_sys_clone+0x5d/0x80
>> [346278.191076] __x64_sys_clone+0x25/0x30
>> [346278.191079] do_syscall_64+0x5c/0xc0
>> [346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
>> [346278.191086] ? do_syscall_64+0x69/0xc0
>> [346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
>> [346278.191092] ? irqentry_exit+0x19/0x30
>> [346278.191095] ? exc_page_fault+0x89/0x160
>> [346278.191097] ? asm_exc_page_fault+0x8/0x30
>> [346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The task was waiting for the refcount become to 1, but from the vmcore,
>> we found the refcount has already been 1. It seems that the task didn't
>> get woken up by perf_event_release_kernel() and got stuck forever. The
>> below scenario may cause the problem.
>>
>> Thread A					Thread B
>> ...						...
>> perf_event_free_task				perf_event_release_kernel
>> 						   ...
>> 						   acquire event->child_mutex
>> 						   ...
>> 						   get_ctx
>>    ...						   release event->child_mutex
>>    acquire ctx->mutex
>>    ...
>>    perf_free_event (acquire/release event->child_mutex)
>>    ...
>>    release ctx->mutex
>>    wait_var_event
>> 						   acquire ctx->mutex
>> 						   acquire event->child_mutex
>> 						   # move existing events to free_list
>> 						   release event->child_mutex
>> 						   release ctx->mutex
>> 						   put_ctx
>> ...						...
>>
>> In this case, all events of the ctx have been freed, so we couldn't
>> find the ctx in free_list and Thread A will miss the wakeup. It's thus
>> necessary to add a wakeup after dropping the reference.
>>
>> Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Hint: always ask before putting someone else's Signed-off-by tag ;-)
> And anyway you don't need it here.

Sorry, Frederic. I'll resend this with Reviewed-by tag.

Thanks!
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> 
>> ---
>> Changes since v1
>> - Add the fixed tag.
>> - Simplify v1's patch. (Frederic)
>> ---
>>  kernel/events/core.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4f0c45ab8d7d..15c35070db6a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5340,6 +5340,7 @@ int perf_event_release_kernel(struct perf_event *event)
>>  again:
>>  	mutex_lock(&event->child_mutex);
>>  	list_for_each_entry(child, &event->child_list, child_list) {
>> +		void *var = NULL;
>>  
>>  		/*
>>  		 * Cannot change, child events are not migrated, see the
>> @@ -5380,11 +5381,23 @@ int perf_event_release_kernel(struct perf_event *event)
>>  			 * this can't be the last reference.
>>  			 */
>>  			put_event(event);
>> +		} else {
>> +			var = &ctx->refcount;
>>  		}
>>  
>>  		mutex_unlock(&event->child_mutex);
>>  		mutex_unlock(&ctx->mutex);
>>  		put_ctx(ctx);
>> +
>> +		if (var) {
>> +			/*
>> +			 * If perf_event_free_task() has deleted all events from the
>> +			 * ctx while the child_mutex got released above, make sure to
>> +			 * notify about the preceding put_ctx().
>> +			 */
>> +			smp_mb(); /* pairs with wait_var_event() */
>> +			wake_up_var(var);
>> +		}
>>  		goto again;
>>  	}
>>  	mutex_unlock(&event->child_mutex);
>> -- 
>> 2.25.1
>>
