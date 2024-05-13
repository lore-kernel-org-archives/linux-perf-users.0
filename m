Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B314882D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591318; cv=none; b=ejzmFrJOgUMVSvkQUIGDuBIe872SosyMGya9Z/Ly0c/zHhOcwIGGikayv8rfdASHWeJdBy4geiQeMobFk3qbtiSLnre+olpYWtoBuG2fconoprqD7dg79QWG1JlSYK2yvtS5nmg8L/gdfSbkj3ALmGiDtUnPpvtGarYJ3IgnoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591318; c=relaxed/simple;
	bh=2QsXDwcelsfu46sr9efR6lHGYf2IlIuBQCye7ipXK/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L11/Iuv8ozypUda5TMGTeSNI4CCmHFlzj4uhlK110JG2p9MvchnwB95HjxmDQVfl2fZ8BS0JFtMX+vs4h8wuU8sx9pZlABa2zMlGw8q8dOdefPL8GHaO68BHKB0O26bPwIu73YsDD+Joh1IowgFilRV/2G0ivkxrG9DjDIAbQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=DBEa6AXi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="DBEa6AXi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so21912815ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1715591315; x=1716196115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr22ximAHVRceMZ/0HBVL4r+nNUIEc69bm0wOS15KTw=;
        b=DBEa6AXiYOFigWXpvgZIH4qeQUtuAwJkEmF0pwxKN+lxaG597nejTVFWovL8y9jk3y
         aQNZWYOZtcOEyn3AG7nilSm9xqDh6wld5L5NA3tHy1ABjj9SHgyUWPWtLygDvlu4SEez
         huxGyq8GS6ZynI3eJ5APdlIPXvFI0V2bE4AGjoaSSruS+kf8ZlFFriNN2vzQ5f6PLcM9
         npQb8RNT5uTzfdW22z4ZKmWSMH94KNHwv+dB3lAsVHVr4ZFEFvDpY4NG5EOd2z7nx3qH
         bdl/i6NHjKWTw8CpEb0PQe2jIl0IR1vqg4lQCbF9xRLBJkgL+PgtQotx+nB7cz7kZmh9
         yX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715591315; x=1716196115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yr22ximAHVRceMZ/0HBVL4r+nNUIEc69bm0wOS15KTw=;
        b=Zj/jNyWvPcAs+PaDufwfh+2wFnSVCzw/gQC+RgQFyTxyexokGwx7BPnsjvlikkE/94
         QOXS+2pXVtiQ04y3WemIpIV4CxNcrZQ6Jc8p4HLqQ+qvZUH2Sjrh2sPdtINaJmBm9ceJ
         Ho4Mn8egEp/FH9nqasrVTQ+zDtofv0ig/Nf7krkn7XHifZcRghPRTWhkT18NGGDUfARS
         qdpQEw7LJ8uYIl4USlyzHH1BfdGUMR2cmIwlQm+DlPl8LvnemRA4az8fSDEPoQdaLHyF
         +bLoPnwivfyFBq2QHNpIii191vqATk9vE2vH8Iw0yhUtAeegU9Ub1EICKRjdRO7mcL4J
         Vr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMQhLqe532nTxKhTHBk+92EwRtovn6bLZ1MdIDHXEMnLQZ59woY2iFZrhfa2Um/Qv3CeDXPScLEdO10Yezt0JuMU8q/0nS45YaN0Aox8O0tA==
X-Gm-Message-State: AOJu0YwAuGYHCoxp45cOYeCzGPkZ2GidPIuJrZryjOY2LjBwdc9F6xCP
	TrAd9MbP3BWrmeRkqzYw7Dl9kDlstWMIrCflttpCAdPw42fVLO4kbbdM5NMMsJY=
X-Google-Smtp-Source: AGHT+IEEEvsJPkxM92hjdodHUe8faM9sXqweFuG1/9ugwLJMqHFY9fzJEdXZLRRP8Df5tuHImd2xEw==
X-Received: by 2002:a17:902:7b82:b0:1ec:585e:5363 with SMTP id d9443c01a7336-1ef43d2e2ffmr77255545ad.29.1715591315222;
        Mon, 13 May 2024 02:08:35 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d385esm76252305ad.38.2024.05.13.02.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:08:34 -0700 (PDT)
Message-ID: <ebc541b4-f115-4a15-bd07-7844463346e0@shopee.com>
Date: Mon, 13 May 2024 17:08:29 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix missing wakeup when waiting for context
 reference
To: Mark Rutland <mark.rutland@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, frederic@kernel.org,
 acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240418114209.22233-1-haifeng.xu@shopee.com>
 <ZieH-g8fWn60z-ev@FVFF77S0Q05N>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZieH-g8fWn60z-ev@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/23 18:05, Mark Rutland wrote:
> On Thu, Apr 18, 2024 at 11:42:09AM +0000, Haifeng Xu wrote:
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
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> FWIW, this looks good to me, but I haven't yet been able to write a test to
> exercise this: perf_event_free_task() is only called if
> perf_event_init_context() fails or of copy_process() fails partway through, and
> while it should be possible to make the latter fail consistently by messing
> with cgroups, I haven't had the time to work all that out.
> 

Hi, Mark.

This problem seems similar to this bug reported by syzbot.
https://lore.kernel.org/all/00000000000057102e058e722bba@google.com/T/#mbb1d50748ff3190738a9754bdff118e640fbb3a3

> So I think there's a reliable DoS here, but I haven't had the time to go write
> that myself. It would be nice if we actually had a test for this.
> 
> I reckon that in addition to the Fixes tag, this needs:
> 
> Cc: stable@vger.kernel.org
> 

Ok, I'll add this tag next version.

>> ---
>> Changes since v1:
>> - Add the fixed tag.
>> - Simplify v1's patch. (Frederic)
>>
>> Changes since v2:
>> - Use Reviewed-by tag instead of Signed-off-by tag.
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
> 
> I was a bit worrited that we're doing the wakeup with the event->child_mutex
> held; 

Actually the event->child_mutex has been released before doing the wakeup.


AFAICT that looks to be safe, but I'm not a scheduler expert.
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.

Thanks!

> 
>> -- 
>> 2.25.1
>>
