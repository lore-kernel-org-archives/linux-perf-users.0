Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E3C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2256D61178
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhIVGaa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232635AbhIVGaa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJ7mY3KGJnt0GGObf9665ZCn7DQvGIxKlz9Hgzfe7VE=;
        b=VphQDZrWgRkSUxYbkIRDJ0JXqa2y5hC8WCe6/aFxI7TfyoGqzt2sVbPMKyHzaGAKYXi41M
        Il9flX7m1T7O/fvFIjs14x2V/mNCoo8ftL0bPqVSrX6fbdhWApDj3ridN9sl4rry9hM5oZ
        ZaqBtWnw/jnwZGQPLpHTIx7crPx+jQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-QC5N5_ZDP4i85xmbY2p7eA-1; Wed, 22 Sep 2021 02:28:58 -0400
X-MC-Unique: QC5N5_ZDP4i85xmbY2p7eA-1
Received: by mail-wr1-f69.google.com with SMTP id j16-20020adfa550000000b0016012acc443so1128452wrb.14
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJ7mY3KGJnt0GGObf9665ZCn7DQvGIxKlz9Hgzfe7VE=;
        b=RvSXqK+NNVYjO/CuVj7UPerXDWKkctIn6Ji72auNs9Ixkhq1IiGsMtUyELZgolu79b
         dmFc3gu5+jDmsjeaKHciEmUdS1oQcG7N7lzY7pgl1aanyr1pP3NITHJWkn/RUWBMfTKb
         9TgsJpDtuYt2a7+oD5wkH6rmtYgsmFzFaGLvCjD76jVVw20WmrHo5008CHAmU2DjnoLx
         vxNz8EBAGqUCMWjKCtPsGDVG0cCuCCjW2ytFRC7ORbW4xcIpY7GeNaOLjFjJ+sEffOXW
         X4HRgqYiIWM9RKo6T0oc7/lx6NBOSG+2W5E3wAmkcV0BGnRq4RswDpmCpv1NA//t5LTi
         Drzg==
X-Gm-Message-State: AOAM53123me6nvq4GHvLFQJog+R/Bpf+PnA9IIidMNJG5Jt7iWvb805/
        5bY3WVyr3vsE4lyG035+kTY6PO8gSDcp+MDLSk7UonSfho4XTWrg+nPiHQ4pfo87mR3SF6Wakf0
        2xigrdL/vcmaXG0NVip3ftzsB7VeduA==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr8722431wms.35.1632292137444;
        Tue, 21 Sep 2021 23:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGUh0clwu4unN1cIXXPNEQKf8qlYc4JIONnRibnq73sMmW8cPrqysrS+MXk+0qjWI0DZnAvw==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr8722395wms.35.1632292137204;
        Tue, 21 Sep 2021 23:28:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i18sm1136021wrn.64.2021.09.21.23.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:28:56 -0700 (PDT)
Subject: Re: [PATCH v3 06/16] perf/core: Rework guest callbacks to prepare for
 static_call support
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6636ab49-e21c-601f-9d2c-34e681c14faa@redhat.com>
Date:   Wed, 22 Sep 2021 08:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> To prepare for using static_calls to optimize perf's guest callbacks,
> replace ->is_in_guest and ->is_user_mode with a new multiplexed hook
> ->state, tweak ->handle_intel_pt_intr to play nice with being called when
> there is no active guest, and drop "guest" from ->is_in_guest.

... from ->get_guest_ip.  Code-wise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

