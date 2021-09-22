Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE5EC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333226120C
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhIVGax (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232670AbhIVGax (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/tHH9wLLtazV94QpN+BmGuu66vagS3lkpjDcUcpVzA=;
        b=PGPf9ZzB33LZyiZilg2aozwZm5TDj5p0O5vz/gJCSjvz+UFxd649DuOMY96TZ0C7Yhswar
        Jo7WK7EKH7drHXehvlque90NgI8miKqAqdhI8I3mYPRJ1+VBPU59VAOBjhjFTrRdyNQnyy
        WXSIXoeyFvkhHyhwswuM+UhVvVnYRvw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-3J-98IDAOGmDoIytmXedrQ-1; Wed, 22 Sep 2021 02:29:22 -0400
X-MC-Unique: 3J-98IDAOGmDoIytmXedrQ-1
Received: by mail-wr1-f71.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso1106741wrw.22
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/tHH9wLLtazV94QpN+BmGuu66vagS3lkpjDcUcpVzA=;
        b=3H2JqqWovYlS0QX7P5+4WxGvSdtj02wUHUsBaYr797Cb8wwSyugqIMd6HwebH2V3mW
         PXktrSwtOASj173D+IC/jMnt9v3+LanSmjaNWjUy3cWVFrxlrVmwTacZLdsKlu+iMutE
         mlvjV6r1Lq2VO8hHCQQZCcTFSB2InaxSH5NAyQMHqK95/M2HadH25DiZ+/6BWTqsoCSG
         eaeuC/puBCHdJcNB94ka5HDTwIOD8saW8TbnVIcdu70WLkKd5Rv+hvV3HFVZnyrW41oC
         6a6B491QR9MkhfKH7MNH8zPvcRBNMmweH1Wi/W/eW+wmGu+7D7+UPY5Ln0GJkpo4TGyH
         W3GQ==
X-Gm-Message-State: AOAM530/pbY1+YBYSpzyV2gsqQpfX+bV5pV6R9RsG5Eo9gyecLh3aPaH
        9PP5qo1BznxDaVJ66kM3OAUwPGSKHaFRizQ38e0+/puJp5H0J9icSiOCrcD9DbD1HQiFeuQ5MoY
        rJTw5VZORQZcxp1BDSlkqyAMdwcK2Ow==
X-Received: by 2002:a5d:64a7:: with SMTP id m7mr39506093wrp.171.1632292161046;
        Tue, 21 Sep 2021 23:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhBqcw62XwXR9WbHiblbcM9n6+4WHbybrr5/MkhCq7T4dnVdh+qdYz2KsHuqdWFBJH3F6z5Q==
X-Received: by 2002:a5d:64a7:: with SMTP id m7mr39506073wrp.171.1632292160784;
        Tue, 21 Sep 2021 23:29:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n26sm4980232wmi.43.2021.09.21.23.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:29:20 -0700 (PDT)
Subject: Re: [PATCH v3 16/16] perf: Drop guest callback (un)register stubs
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
 <20210922000533.713300-17-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74d2e94f-fbd3-522e-8fc5-da5a0a575838@redhat.com>
Date:   Wed, 22 Sep 2021 08:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-17-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Drop perf's stubs for (un)registering guest callbacks now that KVM
> registration of callbacks is hidden behind GUEST_PERF_EVENTS=y.  The only
> other user is x86 XEN_PV, and x86 unconditionally selects PERF_EVENTS.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/perf_event.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d582dfeb4e20..20327d1046bb 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1505,11 +1505,6 @@ perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
>   static inline void
>   perf_bp_event(struct perf_event *event, void *data)			{ }
>   
> -static inline void perf_register_guest_info_callbacks
> -(struct perf_guest_info_callbacks *cbs)					{ }
> -static inline void perf_unregister_guest_info_callbacks
> -(struct perf_guest_info_callbacks *cbs)					{ }
> -
>   static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
>   
>   typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

