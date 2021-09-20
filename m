Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD8CC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38040604E9
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 13:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhITNUM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 09:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239261AbhITNUM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Sep 2021 09:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632143925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZbiHti4vCOqgWKM54l6a3juvV92A2baM8UIqCN0ZRQ=;
        b=TWh4Klm914ZRAxVH+aWCfOfo8pNPEGMw0LNzbmhJxb4OxvB8jouLw85kj1lKmiducQmyXj
        9HzYlpF54AiXtpAsoN1B7AbBisaPgIkU+hSJ+8gjA6P/F/PZ0W7Qy/kvk+xUChuwvGhF9X
        3b0gi1ObN36lzokCMMv7WV7vp8aVtYI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-nbvBnKP8Mfy5ZS-QMRINSw-1; Mon, 20 Sep 2021 09:18:34 -0400
X-MC-Unique: nbvBnKP8Mfy5ZS-QMRINSw-1
Received: by mail-wr1-f72.google.com with SMTP id m1-20020a056000180100b0015e1ec30ac3so6042341wrh.8
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Sep 2021 06:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XZbiHti4vCOqgWKM54l6a3juvV92A2baM8UIqCN0ZRQ=;
        b=dQC1zEYvRN2T0lv4m6Yu1ox0ZO7wRlyqjK/OBt0cL0v+tjp8hDndV+wb5oFZFWA5F3
         nPA77xZz0FqIC+5dgBvjpkny9mUqtVfeEHIgst/84nFGi7UHJBCc+Z16UlqduXHBW8Dn
         MqLj2HYUxXLoLPpQvHkIcuM3ljc7eItIUJ0GWSHuT+jOO41cxoNEsD9yDxiAHrGTkjEU
         EhJ/oY0wzqZ+g/AjRit9JuZZB406Zi20vVLzAw/hIhRNnqlNEi3DHu9fRpXBPRp6e99K
         LqK5QC265KChtCHztJPaPF7/6ZV3ogC68jiFOrZ2Kpjk0tVA51o1tlyL2XrlnlbndZra
         q8hw==
X-Gm-Message-State: AOAM533iLZSZpuGY3FpdAZNVMQVlPMsiIgfEQzM84ZwDR3WIthA7Qsll
        zxeyaf21UgfZhF2UIdviN3WtP9PrBQ4s8XllDt4e7Tu+KsKxqa6Fe89xOET9OI2vbOIQG3kFONl
        ENL2n3se7yIM0MKQvH9ff54sjkdFamQ==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr13376900wrz.439.1632143913678;
        Mon, 20 Sep 2021 06:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7N3hxz36qRlOw1/rL/DwL4aDROJ8XxG8xzFR2ylC3WRZ+AXi5MycER2AoBKQtMUNziJuirw==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr13376850wrz.439.1632143913429;
        Mon, 20 Sep 2021 06:18:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o12sm13359543wms.15.2021.09.20.06.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 06:18:32 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] perf: KVM: Fix, optimize, and clean up callbacks
To:     Marc Zyngier <maz@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
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
 <662e93f9-e858-689d-d203-742731ecad2c@redhat.com>
 <87tuifv3mb.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a5825d1-d6e9-8ac8-5df2-cce693525da7@redhat.com>
Date:   Mon, 20 Sep 2021 15:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tuifv3mb.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20/09/21 14:22, Marc Zyngier wrote:
>> I think that's only ARM, and even then it is only because of
>> limitations of the hardware which mostly apply only if VHE is not in
>> use.
>>
>> If anything, it's ARM that should support module build in VHE mode
>> (Linux would still need to know whether it will be running at EL1 or
>> EL2, but KVM's functionality is as self-contained as on x86 in the VHE
>> case).
> I don't see this happening anytime soon. At least not before we
> declare the arm64 single kernel image policy to be obsolete.

--verbose please. :)  I am sure you're right, but I don't understand the 
link between the two.

Paolo

