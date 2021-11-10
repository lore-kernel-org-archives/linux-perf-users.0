Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B80C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 11:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC35610D2
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 11:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKJLK4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:10:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231383AbhKJLKv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 06:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636542483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48dRn8RRnq7Fx6Bqaf9CAoNN40en8LqbHxW41Xnziw0=;
        b=EFLxKrE+jeaePvlU1wgZU0B/9DICax5RznaeSReppas2casZUc9TDo9SGgmg0pxJopt/yz
        bO9hiYNWsC2S6hA3PjmGHe3avLbZ6qStB0WQ00oRB+0v1nPrgIzXFMgXEtC9IU89hFLhpF
        zyP9rMr6rAg4oiLZpkdU3MIZCZAfQRo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-tB20dHCmPOa4arfkXMEdmQ-1; Wed, 10 Nov 2021 06:08:00 -0500
X-MC-Unique: tB20dHCmPOa4arfkXMEdmQ-1
Received: by mail-ed1-f72.google.com with SMTP id s6-20020a056402520600b003e2dea4f9b4so2009029edd.12
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 03:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=48dRn8RRnq7Fx6Bqaf9CAoNN40en8LqbHxW41Xnziw0=;
        b=YYMmhdDuv+NPLEzHNoXDGyHeOARBfn6NTsVNMCHoyQ9iq2HeXfzTzhvXg3D5NjK5if
         4Bg2r76NPqQbMiQzUpVD9ZFBJ5rrfJW7m0UOkahi0Yb9jt+AAw2/ggNphIx/FssXIU59
         tU4s5RBUi0KghQQhToE65Pd+BZYYloBQs2CR/rbcCX5dg/u0XjXHIzRf0xxfOCVzzkIo
         VaWqZ3MQb/eHsW82ibPoRCl0fYMoQ/z7+9nIij7k1J7hdTuwMxCeVn3FiC1gTviL3hTw
         AH9udIaAcfcMcuqdd3guj5VIQ4Yp1HYCddNZzO8wb0V+x/fIU58fRs0ZOS225Ks1Evaq
         mJCQ==
X-Gm-Message-State: AOAM533OpKwvw+k57xV3LoeforCmVIN98+iu5CZdr68gFucSKwzllIAj
        QpXQAvGMscFWBsxawDgrne5tl6taKCVAmsQz3zrUj7thqK6ErPWMaKnyWeYCDEdWY3puiEG+/0/
        3TJkmPKM3zDJohNSXnF9jjygj4WYPfA==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr18779872ejc.286.1636542479457;
        Wed, 10 Nov 2021 03:07:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIY9E3GGXDTMKNhG94s7x2qpu4nLPlWqmcyoHulhCMNs+PGo9+5ZlP1mG10EA68G9ox4DyaA==
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr18779839ejc.286.1636542479231;
        Wed, 10 Nov 2021 03:07:59 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id g21sm9257171edb.89.2021.11.10.03.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:07:58 -0800 (PST)
Message-ID: <f86fe9cb-bf4b-1c10-e0da-276fbb3f62ee@redhat.com>
Date:   Wed, 10 Nov 2021 12:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 01/16] perf: Ensure perf_guest_cbs aren't reloaded
 between !NULL check and deref
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marc Zyngier <maz@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-2-seanjc@google.com>
 <77e3a76a-016b-8945-a1d5-aae4075e2147@gmail.com>
 <YYPrst2CUBXLYc9h@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YYPrst2CUBXLYc9h@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/4/21 15:18, Sean Christopherson wrote:
> If I'm interpeting Paolo's suggestion
> correctly, he's pointing out that oustanding stores to the function pointers in
> @cbs need to complete before assigning a non-NULL pointer to perf_guest_cbs,
> otherwise a perf event handler may see a valid pointer with half-baked callbacks.
> 
> I think smp_store_release() with a comment would be appropriate, assuming my
> above interpretation is correct.
> 

Yes, exactly.  It should even be rcu_assign_pointer(), matching the 
synchronize_rcu() in patch 1 (and the change can be done in patch 1, too).

Paolo

