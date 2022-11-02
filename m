Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255BC43217
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Nov 2022 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBRTh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKBRTg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Nov 2022 13:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262227B3A
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667409521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bHZ6RhzwZqcFqy+ASS3SxP9gnDv328z5/6b9PXyycI=;
        b=KdG5/u3vXjO1WdxS6SJ0FMJB+hpFfTGICFTaTH3CV5O/Bp2INmfAVakTBQfy457biuaPY2
        Q+pvwoGwtayP8caKaSndGsktDS7q0ayIou/7OgUWR1JzpaPm/ViqI6rzxU91q10StKV9am
        RBWcfd6tf15Czlg/0C5N/JTLpVxzz9M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-OhvOSc1yO_WJWHc5tFJ-og-1; Wed, 02 Nov 2022 13:18:40 -0400
X-MC-Unique: OhvOSc1yO_WJWHc5tFJ-og-1
Received: by mail-ed1-f70.google.com with SMTP id z11-20020a056402274b00b00461dba91468so12322151edd.6
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 10:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bHZ6RhzwZqcFqy+ASS3SxP9gnDv328z5/6b9PXyycI=;
        b=qdmOzH9BNP48UR1IRc4rJM0bYuPyQV7y+T2IpKE1sMjNiG2Ag1glxe9KPt9RVuCoKk
         KeRsNfWUBc2kcMvH6NV5tNhYDNUZ5FncskcLZsayDE4uCM/9uem+Xfw2kc3ALI4caf1z
         JY3TB8HV7+c+4C/1rbIYcqyP1V67c7H8rWkutLu60J4bH/FYLhBwwjT0ihO6yTONNgUE
         F4qvs1Q6574k9F1kt7FBR6XzB7NEQxKti2bK9QskB4HqeLbMJ3TJv2+82z9hEwNdTHnV
         aepMBp00qS/0s9VkWrzKucBYNQZqr0xjmgunjQtGcH/P7rbiDYQTWN+seIl1tzImEp5O
         5uPg==
X-Gm-Message-State: ACrzQf0JfLYN2TzgktAhnXcCollwF6CMdXmhDInk34CcJCSZR9mDcr/9
        Kd/8moiwHERS62lwpnM1gVz4QMwha7JNfPZ70T/XQ5Wi+b9ytI+ARXnhRm1BAaq2dqnwdV2Xc8j
        R3HAAE/BA1RHw9HZzGAXaAfDE2fuxaA==
X-Received: by 2002:aa7:ce8d:0:b0:461:50fd:e358 with SMTP id y13-20020aa7ce8d000000b0046150fde358mr25568801edv.194.1667409518908;
        Wed, 02 Nov 2022 10:18:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4/x6PwTbAurOsVP1zVclwSL+Yxg9TvaRFUydU5orfswpNxKcJmxdeZGEr7BJDb268QdsewlQ==
X-Received: by 2002:aa7:ce8d:0:b0:461:50fd:e358 with SMTP id y13-20020aa7ce8d000000b0046150fde358mr25568766edv.194.1667409518634;
        Wed, 02 Nov 2022 10:18:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id d7-20020aa7ce07000000b004589da5e5cesm6056704edv.41.2022.11.02.10.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:18:37 -0700 (PDT)
Message-ID: <a817ec49-adae-50b5-6c3e-8e4e91d91e93@redhat.com>
Date:   Wed, 2 Nov 2022 18:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 0/8] KVM: x86: Intel LBR related perf cleanups
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
References: <20221006000314.73240-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/6/22 02:03, Sean Christopherson wrote:
> PeterZ, I dropped your ACK from v4 because the perf patches were completely
> broken.
> 
> Fix a bug where KVM incorrectly advertises PMU_CAP_LBR_FMT to userspace if
> perf has disabled LBRs, e.g. because probing one or more LBR MSRs during
> setup hit a #GP.
> 
> The non-KVM patch cleans up a KVM-specific perf API to fix a benign bug
> where KVM ignores the error return from the API.
> 
> The remaining patches clean up KVM's PERF_CAPABILITIES mess, which makes
> everything far more complex than it needs to be by
> 
> v5:
>   - Drop perf patches that removed stubs.  The stubs are sadly necessary
>     when CPU_SUP_INTEL=n && KVM_INTEL={m,y}, which is possible due to
>     KVM_INTEL effectively depending on INTEL || CENTAUR || ZHAOXIN.
>     [hint provided by kernel test robot].
>   - Add a patch to ignore guest CPUID on host userspace MSR writes.
>   - Add supported PERF_CAPABILITIES to kvm_caps to simplify code for all
>     parties.
> 
> v4
>   - https://lore.kernel.org/all/20220901173258.925729-1-seanjc@google.com:
>   - Make vmx_get_perf_capabilities() non-inline to avoid references to
>     x86_perf_get_lbr() when CPU_SUP_INTEL=n. [kernel test robot]
> 
> v3:
>   - https://lore.kernel.org/all/20220831000051.4015031-1-seanjc@google.com
>   - Drop patches for bug #1 (already merged).
>   - Drop misguided "clean up the capability check" patch. [Like]
> 
> v2:
>   - https://lore.kernel.org/all/20220803192658.860033-1-seanjc@google.com
>   - Add patches to fix bug #2. [Like]
>   - Add a patch to clean up the capability check.
>   - Tweak the changelog for the PMU refresh bug fix to call out that
>     KVM should disallow changing feature MSRs after KVM_RUN. [Like]
> 
> v1: https://lore.kernel.org/all/20220727233424.2968356-1-seanjc@google.com
> 
> Sean Christopherson (8):
>    perf/x86/core: Zero @lbr instead of returning -1 in x86_perf_get_lbr()
>      stub
>    KVM: VMX: Advertise PMU LBRs if and only if perf supports LBRs
>    KVM: VMX: Fold vmx_supported_debugctl() into vcpu_supported_debugctl()
>    KVM: VMX: Ignore guest CPUID for host userspace writes to DEBUGCTL
>    KVM: x86: Track supported PERF_CAPABILITIES in kvm_caps
>    KVM: x86: Init vcpu->arch.perf_capabilities in common x86 code
>    KVM: x86: Handle PERF_CAPABILITIES in common x86's
>      kvm_get_msr_feature()
>    KVM: x86: Directly query supported PERF_CAPABILITIES for WRMSR checks
> 
>   arch/x86/events/intel/lbr.c       |  6 +---
>   arch/x86/include/asm/perf_event.h |  6 ++--
>   arch/x86/kvm/svm/svm.c            |  3 +-
>   arch/x86/kvm/vmx/capabilities.h   | 37 ----------------------
>   arch/x86/kvm/vmx/pmu_intel.c      |  1 -
>   arch/x86/kvm/vmx/vmx.c            | 51 +++++++++++++++++++++++--------
>   arch/x86/kvm/x86.c                | 14 ++++-----
>   arch/x86/kvm/x86.h                |  1 +
>   8 files changed, 52 insertions(+), 67 deletions(-)
> 
> 
> base-commit: e18d6152ff0f41b7f01f9817372022df04e0d354

Queued, with patches 2-4 destined to kvm/master.

Paolo

