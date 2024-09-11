Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC51AE035
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076532; cv=none; b=VzQb7SBA2o4GnTQg4R8O/fdRlL54garKgW3o/CPpu7U1tRDrEcPAVRKsXmMr7FEv296hL72KkboyQy8KJBuSlhQNOpYmmpNFdwTbCyb3jJ0P0E6sZg9Ak22qPdBDuxJ6TIYyWJV+ZwGAW9Q8duqEUTM6QUFZguA8AF8fjtZjxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076532; c=relaxed/simple;
	bh=dn939sn++fwvDrb1mRwiAH6VwkMwvdG2HxDigWI+AlQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZGcU2b3MtrJTxgVTVwRKrGXddtflOCc7trjZT2y/NjFX4MKWPZNjM7aTVPizWeRtq17PouPF1mlNGEsg2tVBGIwy1x5rXyvAzoAt/ZzGJhHb67CgKUzoZRut3hr9sDBSGSr/sC/jE9murt3/6KLJxDIP7kVQNHor1o13zisDstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJOeYiO3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJOeYiO3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b8d96aa5ebso3839487b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726076529; x=1726681329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=706YIr0bgBd+SdWWT5lCJ2ip0tLuVrI+pXTkacc4ei0=;
        b=aJOeYiO3GcI0JykcTKTC3C/OML1+gF9uFFooNCGF9VRphwK6eTGjQz1b4QxQq0wXWS
         2d7Cup/I5gv0QJcTWXJljtB2ccYrrwlOYJyz6dh+bNgm36fj+/iBfp3oVIDMES2nLfxO
         87kmbSlG+Yb74xaHd/pUfSUvcgSJF/90K+U+Bvt6DJNSB4Ia9YmUuX7YKhZ8RoOLWX/3
         336+GDiNncXmTJyjMU1nNUrZbwDmgt3z4/PoIoIrEW+5XAp0DYgxbdUn5D3SqW6Hk3SF
         MPH0WsEQbD5TwbuTs/MCSbuxAYuDG4OBIIEbevLox7jw7pSSKfhOPg6/+85WbHYGn1a8
         hw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076529; x=1726681329;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=706YIr0bgBd+SdWWT5lCJ2ip0tLuVrI+pXTkacc4ei0=;
        b=g8gJsFHq+7/9qUTyhTIFEggHf4LcjQ8Z04tVCJn9KfiBfgsXZYXen1/aCfjrYlSQNS
         CJbknS9QPVEwQMfzU+btj9pSQ4jNFsxEt/d5RV6bAnAjT6fSygaobz19y9XFUPnyeWZ6
         /XlrVbf8eisSnHcXGPSZym6DsQk7yw6rht1Jwp5FN1h3jf6YmnH0p1o2w3pliCXpp9eV
         ltDn22xbuH1Zkk27s5kRpJfKnQb66jV/QXoNu47zxVm0NzpdLeDRLwfrqJWDaxwN7rMz
         IgJu+T7zLaRr5Uj0nTvKp34LU3EFVnezPw1HqKaVqTj6MTH5WQiZzCPwsZ6G+RHrtTkT
         ZsHA==
X-Forwarded-Encrypted: i=1; AJvYcCXsdSWxkbB6Gxp7kQH9VgyUHfAl1EzEob4vE8yPQ2c2R9l1SCnD91UFI1lNFQz7XH5oyW6B4Zhv3sJjkhghpVwL@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuph7gJYd9zVlzPhazcbeHJouRAb3bJjkqdVmqkMc3R+fGErM
	G2gLYLhyw93a98uPuPuGqwWxaPDjczIO0CL8w/PPGF41oGMeyag6Imt9c3vcn/GSFHnbdkiP3qU
	+n+dhD+Wdt43HriyttE1VFQ==
X-Google-Smtp-Source: AGHT+IFvlmwQkSjQLxVucUW7uRZBOX25a6vFDWduRsiEd3MV5YuAAx1lfuAly70GDxykiYb30OJnJ7h7mzdG3bMQWg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:fd0:b0:6d6:bf07:d510 with
 SMTP id 00721157ae682-6dbb6b9d655mr6437b3.6.1726076528473; Wed, 11 Sep 2024
 10:42:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:42:07 +0000
In-Reply-To: <ZtmOENs5qveMH920@J2N7QTR9R3> (message from Mark Rutland on Thu,
 5 Sep 2024 11:55:12 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv7z2cck0.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 5/5] perf: Correct perf sampling with guest VMs
From: Colton Lewis <coltonlewis@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, will@kernel.org, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Sep 04, 2024 at 08:41:33PM +0000, Colton Lewis wrote:
>> Previously any PMU overflow interrupt that fired while a VCPU was
>> loaded was recorded as a guest event whether it truly was or not. This
>> resulted in nonsense perf recordings that did not honor
>> perf_event_attr.exclude_guest and recorded guest IPs where it should
>> have recorded host IPs.

>> Reorganize that plumbing to record perf events correctly even when
>> VCPUs are loaded.

> It'd be good if we could make that last bit a little more explicit,
> e.g.

>    Rework the sampling logic to only record guest samples for events with
>    exclude_guest clear. This way any host-only events with exclude_guest
>    set will never see unexpected guest samples. The behaviour of events
>    with exclude_guest clear is unchanged.

> [...]

Done

>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4384f6c49930..e1a66c9c3773 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6915,13 +6915,26 @@ void perf_unregister_guest_info_callbacks(struct  
>> perf_guest_info_callbacks *cbs)
>>   EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>>   #endif

>> -unsigned long perf_misc_flags(unsigned long pt_regs *regs)
>> +static bool is_guest_event(struct perf_event *event)
>>   {
>> +	return !event->attr.exclude_guest && perf_guest_state();
>> +}

> Could we name this something like "should_sample_guest()"? Calling this
> "is_guest_event()" makes it should like it's checking a static property
> of the event (and not other conditions like perf_guest_state()).

> Otherwise this all looks reasonable to me, modulo Ingo's comments. I'll
> happily test a v2 once those have been addressed.

Done

> Mark.
