Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D45C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiECPQk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiECPQj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 11:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 231403A5DE
        for <linux-perf-users@vger.kernel.org>; Tue,  3 May 2022 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651590783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NUbQ9yWtqpo0VvAgqEBwOM8q51whPE1UMGmRuUeo40=;
        b=f04ksNcTYv/gXOYiHYuevMgv1js0z80sa0H3LxH55gpZwAQ+eTlCtYKgMGqhONTqOI1pGv
        Nl7dJypXq2sKpGjno/AEQcJBvrzxLgNHpehlagYDRadv8emgAiOw7A0GA69jDFNT3R9ziu
        PWEP3OXtSnhzlgBbeeqCAjAF1QHuFm8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-IRt36Z-cMsa7qVTC4Y0GKQ-1; Tue, 03 May 2022 11:04:29 -0400
X-MC-Unique: IRt36Z-cMsa7qVTC4Y0GKQ-1
Received: by mail-lf1-f72.google.com with SMTP id g2-20020a0565123b8200b004725c7af360so3824878lfv.19
        for <linux-perf-users@vger.kernel.org>; Tue, 03 May 2022 08:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6NUbQ9yWtqpo0VvAgqEBwOM8q51whPE1UMGmRuUeo40=;
        b=C6SU8CWJRi6O+1/Iy82a2jWre8S0A7XER+j28XRsKbVnfL7ning9CVD4pH8HJR+ifL
         We4p4m0r60GwalFbSwh6bErizuE4lZdSxcKcg6P3bUd4SuFIyQBCAUYIKiWyRv/lW9PW
         k/OpW9l8Y2oCkuZw3CxU5vg1mYGYEX5owQvcWPK6kTsgwfpYVFodrNGOOG9NY5cPYV7N
         lqLh0VQnbcPPtMOnqiS0FpYP5DttLxQH356/+rmrsJu4edET3tPMtMyWiJnuHZ5DfhxA
         1bXg5izUxi3Lmq4uMLlGNXPdUP2c0rCIaUgf8dQXUogqLAGEvWkt43nic6jqFzesKCEI
         ubsA==
X-Gm-Message-State: AOAM533yMO30ENNkhTtinCdOz48wuEwstU+wT20tEfvhNyBcc9/4Y3y8
        ANmvPIjd3AT9N7pwRWwjl+S1Yjtt9u6bv2fKkivpKq6Ll63w96qjw1z40iv2c/kLt/JKt1FDjfK
        Sp5lKcd8YE0xFKUlGM2l574s07AaOCA==
X-Received: by 2002:a5d:554a:0:b0:20a:d511:c514 with SMTP id g10-20020a5d554a000000b0020ad511c514mr12301996wrw.347.1651579447287;
        Tue, 03 May 2022 05:04:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE9ZcONNlXgG46lfEm8iYAXKm9tIfYloMqtc6BAlvfRCOkFt0SEGeMTdmBS0sIb9y7I0J6XA==
X-Received: by 2002:a5d:554a:0:b0:20a:d511:c514 with SMTP id g10-20020a5d554a000000b0020ad511c514mr12301971wrw.347.1651579447072;
        Tue, 03 May 2022 05:04:07 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id a25-20020adfb519000000b0020c5253d920sm11988545wrd.108.2022.05.03.05.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:04:06 -0700 (PDT)
Message-ID: <68a3c5b5-cb02-a22b-d05b-a141c41a9cad@redhat.com>
Date:   Tue, 3 May 2022 14:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>,
        Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        like.xu.linux@gmail.com, eranian@google.com, puwen@hygon.cn,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1651058600.git.sandipan.das@amd.com>
 <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
 <CALMp9eSdUW6et2Us1if-j2Do6cv9ssyT4C2KPiyomFd7i_Dc1Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eSdUW6et2Us1if-j2Do6cv9ssyT4C2KPiyomFd7i_Dc1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 5/3/22 01:50, Jim Mattson wrote:
> On Wed, Apr 27, 2022 at 4:34 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> On some x86 processors, CPUID leaf 0xA provides information
>> on Architectural Performance Monitoring features. It
>> advertises a PMU version which Qemu uses to determine the
>> availability of additional MSRs to manage the PMCs.
>>
>> Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
>> the same, the kernel constructs return values based on the
>> x86_pmu_capability irrespective of the vendor.
>>
>> This leaf and the additional MSRs are not supported on AMD
>> and Hygon processors. If AMD PerfMonV2 is detected, the PMU
>> version is set to 2 and guest startup breaks because of an
>> attempt to access a non-existent MSR. Return zeros to avoid
>> this.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 4b62d80bb22f..e66ebb747084 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>                  union cpuid10_eax eax;
>>                  union cpuid10_edx edx;
>>
>> +               if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
> 
> Should this be checking kvm_cpu_cap_has(X86_FEATURE_ARCH_PERFMON) instead?

Ah, it cannot because X86_FEATURE_ARCH_PERFMON is a synthetic feature. 
kvm_cpu_cap_has only works with features that are backed by CPUID bits.

Paolo

