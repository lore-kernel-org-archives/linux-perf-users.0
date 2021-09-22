Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CADC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EAD61206
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhIVGjw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232835AbhIVGjw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3XTCa1nu8hCtlYTFFK2GZognBOtLDAkX/kYxcYF1XA=;
        b=NUU64Xb1BcgagGpy9iPM2unKlGXmCCkRfB69KsWkLaF1CANMexfuGIRg2veNeBpU0TlP7C
        SMmoE3GhDeOg+/rY3Jky4LurhV/dNIJD+g2nyanA45uYOJKrgQ5LdF9C5yl9nWGruU4Fm5
        /Fx0zIef1Gp4HywOyr78b6+Q+MzXQk8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-fw1k3rD2O7OgXgl56NGmcg-1; Wed, 22 Sep 2021 02:38:18 -0400
X-MC-Unique: fw1k3rD2O7OgXgl56NGmcg-1
Received: by mail-wr1-f70.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso1179858wrn.4
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3XTCa1nu8hCtlYTFFK2GZognBOtLDAkX/kYxcYF1XA=;
        b=wD+JQAhx2866tolZ1tKXBPAp62z9Nbpex3u9HZFVvMINSQ5jl6BG6FBE0ao89W7XQZ
         RLKEExVt7qCZHntZwn2ytyuJuGdPq07OGGWQajiOFyBPol25khvjmzbpyhLwof4OyKoi
         rm/ZXNy6VEp2jGzXPsCc+3UKhxCuiZ6mOVRuNJELaVye/zGSxi3k59kJsSxDw7pIYvGX
         +eobinrpi8xp7DBVrM4vojwkKAaAgEbnJid9FAnevWSDeWN1muyUPDFKUE0x//XLbvB6
         PHyKXX9hu/iaHnDhIzb1/jetn2MTEXn1DOT9XuvJBVPTJ8JQC3lQmwkSK6f10Y+cYGGe
         UGGg==
X-Gm-Message-State: AOAM5314/dY2LhiFZaSchh7hlfYX25HOvbwwhkrkoQYX8YmWcea5osvA
        JCVT7z6bZuBqZWnQ4XwmBowtCfhKXHd4MIJBe2rNesLsRwal2iW81+yn5/9iE8kIsnSbMX+0/3s
        UqDciw+uf82vy1TMGwg2TR+l0Bnv3tA==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr8613999wmj.163.1632292697322;
        Tue, 21 Sep 2021 23:38:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywCmZIrNrFYOLYwz4uLurAI8KkuEnxjxQSJf2bjooMgzy2h0qoOTiWQbU4UgbH2lcfc2iQrA==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr8613976wmj.163.1632292697089;
        Tue, 21 Sep 2021 23:38:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j21sm1162153wrd.48.2021.09.21.23.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:38:16 -0700 (PDT)
Subject: Re: [PATCH v3 11/16] KVM: x86: More precisely identify NMI from guest
 when handling PMI
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
 <20210922000533.713300-12-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d444303f-7ee5-7ddc-8eae-64d1e6d4862a@redhat.com>
Date:   Wed, 22 Sep 2021 08:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-12-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Note, this also doesn't completely prevent false positives if perf
> somehow ends up calling into KVM, e.g. an NMI can arrive in host after
> KVM sets its flag.

s/calling into KVM/being called from KVM/ ?

Not sure about what you meant though.  The code is nice, so

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

