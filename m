Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A3C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC00610A8
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 12:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhITMHI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhITMHI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Sep 2021 08:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632139541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8wAH/IsmVnI2ydhQ1BFoaOBGT1C6T31sGkkhWrMszg=;
        b=E5O5IYb3E/Ra/xlxED0QOc8QrPeCDxCsIi9ztHhZjYBOh6ejFUGPudbBXxiS/wHIdenNep
        qIFlUvG5zJwA+fqK3RXonYrssqDunAdP9q4HaYuW0GkV6Qxp86eISEvTcccX4DFIPFEpFG
        Kuo6tHq2RiDnvU1gHyMflYXobeoveWY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-lFMIRaL6PwCyyoZSezjccg-1; Mon, 20 Sep 2021 08:05:40 -0400
X-MC-Unique: lFMIRaL6PwCyyoZSezjccg-1
Received: by mail-wr1-f71.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso5885318wra.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Sep 2021 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q8wAH/IsmVnI2ydhQ1BFoaOBGT1C6T31sGkkhWrMszg=;
        b=DOhXf3M4ViWP/c6uuJC+erFFFLYtFYVagojeKSDlg3/kYdLwkV/QvBY1tpvpOCZJgH
         PWRkmcjMG9T152WOTpSmYyZTzSE0FusIgjdFIrwhme0NSUD93DZ022xg9ZNWq/6vzC1c
         Vd9TyvkKPvPVlVUhmT/XCKLeW+XIjWpbQ5ekQg17jRZ4m8TC3V9PgVzmQCy1gJCPqEHA
         SQs6X5vQ6ZfA2gScZaJibAUQjTnUk+sTYWEDG+BIaRltwLuvpi0NJHAGNPPsA36Ymm1h
         CCWE4l+0RyqfE4aiJL3y8OarBnY7B9dht52vZ+JD0NfBl8sfc5NtD7eZiB9Ra9Qxc2Rf
         R+AA==
X-Gm-Message-State: AOAM53357Uc5/lJWol98QRDerilWD88UPI0qLVW+ep9YTKBbRLM3WZFN
        7HrZNXR0YLQx/ypgMuASyIturociTgx5AMu/HqkCy3quXjvyjgaFeX6ahOOqBZHq1CUY1RCufDY
        RJ4WGSwL4Zj1/TDnxsZEYbY+bLthHeA==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr28038955wrq.136.1632139538950;
        Mon, 20 Sep 2021 05:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz64XIPtY2fM12srCDcTMCwDqENNrjhBUdJzYmop3FKDPBAPZx+uh9ah7Isb2beeBqNbwRMJw==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr28038880wrq.136.1632139538580;
        Mon, 20 Sep 2021 05:05:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l15sm19128605wme.42.2021.09.20.05.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:05:37 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828201336.GD4353@worktop.programming.kicks-ass.net>
 <YUO5J/jTMa2KGbsq@google.com>
 <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/13] perf: KVM: Fix, optimize, and clean up callbacks
Message-ID: <662e93f9-e858-689d-d203-742731ecad2c@redhat.com>
Date:   Mon, 20 Sep 2021 14:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/09/21 09:28, Peter Zijlstra wrote:
>> In theory, I like the idea of burying intel_pt inside x86 (and even in
>> Intel+VMX code for the most part), but the actual implementation is a
>> bit gross.  Because of the whole "KVM can be a module" thing,
> 
> ARGH!! we should really fix that. I've heard other archs have made much
> better choices here.

I think that's only ARM, and even then it is only because of limitations 
of the hardware which mostly apply only if VHE is not in use.

If anything, it's ARM that should support module build in VHE mode 
(Linux would still need to know whether it will be running at EL1 or 
EL2, but KVM's functionality is as self-contained as on x86 in the VHE 
case).

Paolo

