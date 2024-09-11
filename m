Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471741B29A2
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075460; cv=none; b=G+mILFbpWzChsTusTqQ32T85wyizaperAXlKZvA8LTLLBRFz+d4yt7PA2JeUHunQcW13j7DdV2F3c/NYcI5Rbfc/eVTlXyL/e8GHtV9k2i2jrd77pWNco9TzOKdbc9SGFfnsbUGZGJHWBMgvFwg1ej1GVVxJzk8Z33x8ddjbTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075460; c=relaxed/simple;
	bh=XFs0Nh/hOrp5kuukoiTsZ1BajDbH+w0gqLETXRYqyHo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=tQIEYotxpcPPE/Y9CMgEuv6ajpyU4Qhpve6cpqpju4k2mMVncHcJ4td0hVVTyYr8P1FS/J0Lh38w+9Lfhp7cIalFh2P77Y68HPUwakhXa739tdvdRc5bfQUDy0RfmlOfMRYlteGhXx+cJUtSi8t8MIHKczKEd3XNimi55KOkAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jpfr9b8O; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jpfr9b8O"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e11368fa2e3so235231276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726075458; x=1726680258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SaSesydasxzfbVhVncU6hEY4UY7i9QKYOocGcFq6lVw=;
        b=Jpfr9b8O7aI/k+j93LNwHynWn6CaJe3d9RqwHdfQaVrNvLtB2TQEmL9GPRFSHY3YHv
         wWqIWyspltFStFntlCG5UrOIclxAXXuBtSfmlsxGrucb9KSuXarCO6fUd3gDodlkR8j0
         Rp28ReoTZ5F7lgJ+KkT5xXU01zxR0INIZQn5ZmIABMnlCkJhsaM35VuymCxwS0c8tL07
         QtKSyVhpBeiUUoNMWvs8e963C+3H8wxfGLdYql70FK8yTWsqcyJ0V7PGsBPk8tHl3Wbj
         14NHeTZFBnOa/nMysLOEO7+aUJp3JFQ5uyMCGpEkolLozilOYUfArgwm80M/2ocAJhZd
         iEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075458; x=1726680258;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaSesydasxzfbVhVncU6hEY4UY7i9QKYOocGcFq6lVw=;
        b=wM7ChvkYyZryNiDAQ1kMSlEV6p3OKoLXf+3RQ3wKw+/kj1u3surzn1AniscM/isGc4
         snohIFwS9jQip6k7zchCGNOkq79TBwGmAaeuqR8/Bx+uEPT8oxhkxCRtSOc166QD1+/m
         eQbOBVcCmXUVCGpsgit1FwXlb2mujjVdytV3qzdWtrDqUp/hUa+/sjSVSvQ/LA21gGJd
         XQZvMU9klWRpjqr9f+udec534OrFWu+sWGP+aZMUOHBJOCJu0+/jj6EgIurXy+DlwIdJ
         7qRml0lfSqUIU1/nJHottmOIsdbltt0AygkjaS00cgx+3HCZIRw0iTIHr10YGcs0D4/Q
         0cJw==
X-Forwarded-Encrypted: i=1; AJvYcCV3/pNSnBuIbWC7xf5l5KwZ6rL2cSxF/eIt4a/GVisuKs9keR7yjRDI1sNP4qP6sFRs/MW7wTDN/zTmOvEN81R6@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZdgYp3W3xEnRTy30EPvyh4QgSt9fGz3UurADD80Be/92luVb
	OV7TmAb49hIKbRzH5liil0IfhMDwQc40YT1ZzvB6aTqZlDoXT8PB0cl538EamKQd+CgJJhc7T4l
	Nq3zF/2yykLREszwthyYJrw==
X-Google-Smtp-Source: AGHT+IF0bUdUbcCOClt0/WYli3uuDRUJs0keADgBT2fi3kki6SRriwc15ZsmXxjB7diodiG4JkONa9BVdzmH2TzP6g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:529:b0:e1d:96a7:c9b1 with
 SMTP id 3f1490d57ef6-e1d9dc2cfd7mr203276.6.1726075457958; Wed, 11 Sep 2024
 10:24:17 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:24:17 +0000
In-Reply-To: <ZtmHBuggqUr3ncw6@J2N7QTR9R3> (message from Mark Rutland on Thu,
 5 Sep 2024 11:25:10 +0100)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnty13ycddq.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 1/5] arm: perf: Drop unused functions
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

> On Wed, Sep 04, 2024 at 08:41:29PM +0000, Colton Lewis wrote:
>> perf_instruction_pointer() and perf_misc_flags() aren't used anywhere
>> in this particular perf implementation. Drop them.

> I think it'd be better to say that arch/arm's implementation of these is
> equivalent to the generic versions in include/linux/perf_event.h, and so
> arch/arm doesn't need to provide its own versions. It doesn't matter if
> arch/arm uses them itself since they're being provided for the core perf
> code.

> With words to that effect:

Done

> Acked-by: Mark Rutland <mark.rutland@arm.com>

> Mark.


>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm/include/asm/perf_event.h |  7 -------
>>   arch/arm/kernel/perf_callchain.c  | 17 -----------------
>>   2 files changed, 24 deletions(-)

>> diff --git a/arch/arm/include/asm/perf_event.h  
>> b/arch/arm/include/asm/perf_event.h
>> index bdbc1e590891..c08f16f2e243 100644
>> --- a/arch/arm/include/asm/perf_event.h
>> +++ b/arch/arm/include/asm/perf_event.h
>> @@ -8,13 +8,6 @@
>>   #ifndef __ARM_PERF_EVENT_H__
>>   #define __ARM_PERF_EVENT_H__

>> -#ifdef CONFIG_PERF_EVENTS
>> -struct pt_regs;
>> -extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
>> -extern unsigned long perf_misc_flags(struct pt_regs *regs);
>> -#define perf_misc_flags(regs)	perf_misc_flags(regs)
>> -#endif
>> -
>>   #define perf_arch_fetch_caller_regs(regs, __ip) { \
>>   	(regs)->ARM_pc = (__ip); \
>>   	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
>> diff --git a/arch/arm/kernel/perf_callchain.c  
>> b/arch/arm/kernel/perf_callchain.c
>> index 1d230ac9d0eb..a2601b1ef318 100644
>> --- a/arch/arm/kernel/perf_callchain.c
>> +++ b/arch/arm/kernel/perf_callchain.c
>> @@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx  
>> *entry, struct pt_regs *re
>>   	arm_get_current_stackframe(regs, &fr);
>>   	walk_stackframe(&fr, callchain_trace, entry);
>>   }
>> -
>> -unsigned long perf_instruction_pointer(struct pt_regs *regs)
>> -{
>> -	return instruction_pointer(regs);
>> -}
>> -
>> -unsigned long perf_misc_flags(struct pt_regs *regs)
>> -{
>> -	int misc = 0;
>> -
>> -	if (user_mode(regs))
>> -		misc |= PERF_RECORD_MISC_USER;
>> -	else
>> -		misc |= PERF_RECORD_MISC_KERNEL;
>> -
>> -	return misc;
>> -}
>> --
>> 2.46.0.469.g59c65b2a67-goog

