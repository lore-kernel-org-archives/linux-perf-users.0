Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417EC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 14:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiECOLc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiECOLb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 10:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A5772FFEF
        for <linux-perf-users@vger.kernel.org>; Tue,  3 May 2022 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651586878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOZQR3NgpnivklRl2WE+IkvBWljH5ijZ+KhrlyE76Oo=;
        b=hPdnUuXM4xiNPjwIYk5Q+LyHh9hx60xGkzMCyF831pLmcGhEeev1UFZgW5OI5X5tGIUgPv
        etsd8fw1ZDtFtHBP5L+xUunWGmYHizwlVXUzXvHrlnnVK5Ki6sQP1Rsx2C439ANw1hf2/6
        ySDB8BotUQR1RZev9QZEWYEAbPP8fGM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-XVs-NrLfNuOKXM8HtAF0Yg-1; Tue, 03 May 2022 10:03:12 -0400
X-MC-Unique: XVs-NrLfNuOKXM8HtAF0Yg-1
Received: by mail-qk1-f198.google.com with SMTP id 27-20020a05620a041b00b0069fd7a60a43so4432964qkp.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 May 2022 07:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MOZQR3NgpnivklRl2WE+IkvBWljH5ijZ+KhrlyE76Oo=;
        b=jsSv9Us+4WQCJr7mMvx9GOkPewTip/hRjnB9GBqGTdBesadmYPSY8kzO3L7yQNrZsW
         IX+sZHCpd0ZdN/LKFArYD+boIZ/K82JBN3mskziGfs7QIafMKJbyI0Qij13QRw73YiUJ
         DJa3QQm3j3w/2zQIL6ej2Dir9zXgkaqfMOQsmkBC5DJoKQ7c9DcQkqOYRP9tAY5WX7XJ
         ZrHcPHnByH3esNKHvyutnMdwBwYzyWkp6PBHdVJgBwCK1LpN0WhVUWwWQeSO6E/RharS
         9ur3Yuj73kZ4mbpn3ItJ2O1ZRWzOSLORA4oYozaOPlZuBZU86b+N5KHIHWFN+xU6BnA5
         v8cA==
X-Gm-Message-State: AOAM530bIpxXg3WjLDruo9DSUBRabSAYpWd/ENBWSL9rHbpk0psXnYo2
        O9caTI0CEpvAUcZm8CQ+Cjf/4+X7VEJUjDkKOyv0KZCzbnULaHmJLGUdyQ1jw9gLtU9/USNyJhM
        Oq0V6IaLCeZYtTEuRbb7uoONNk79VSA==
X-Received: by 2002:a05:620a:1a04:b0:69f:e7f3:187 with SMTP id bk4-20020a05620a1a0400b0069fe7f30187mr5880474qkb.184.1651579284439;
        Tue, 03 May 2022 05:01:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC/8kQQ52ivaf4XcEzs5fZ/zZdcgmA1eHs6x4CXVw9nobVuQf45WCIWHqdlFql/e8rZ8Fe2A==
X-Received: by 2002:a05:620a:1a04:b0:69f:e7f3:187 with SMTP id bk4-20020a05620a1a0400b0069fe7f30187mr5880433qkb.184.1651579284037;
        Tue, 03 May 2022 05:01:24 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id b9-20020a05620a04e900b0069fc13ce20bsm5788682qkh.60.2022.05.03.05.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:01:22 -0700 (PDT)
Message-ID: <f97cb2e3-9b53-6206-4523-8b15b0ee83e4@redhat.com>
Date:   Tue, 3 May 2022 14:01:18 +0200
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

Yes, it should.  I have queued this patch for 5.18.

Paolo

