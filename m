Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B754BC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954B4610CD
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhHYUK0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbhHYUK0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 16:10:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85CC0613CF
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 13:09:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so240940plh.7
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZFFjML9smF7WsET9dQOV7mfQFBicnrpHkuw0z9j2oAc=;
        b=DKwaEyQ3aYPp4addUNdIXUXLbcQVxq62IyFfvLqcrqh5RCdUGg8hmIue4b5wSXn3Wd
         RXrMq9UnkzG960carDxoDjn++v9pjNBycfq2fM9L1KvMUAPc5G/zLgR9C+4EXNhNFzBI
         MAhkwRuRJwZmEgTDTaOeVxFaBBxg/heTL7w6DaGXHz0jbpV/Y3AoTaz74BEQ90VYvHtQ
         8fV2ihh+e6riAj6nviPuCwDFAmsdpqfTvUS7A8j2WZgANuDpSnOlYxki/p41zGs+3E1p
         9/mDhlgHhUyDTO9owyxaDtBGFqJ+jqkfIKtHX9hAiT56ZRFYZqoKnS/8jnHjuTlXXt+9
         ZySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFFjML9smF7WsET9dQOV7mfQFBicnrpHkuw0z9j2oAc=;
        b=D0FSP4+gcjfmQecTT95T5TgMGHp/rspKl0ww3xwbZR5mHCq/GHoquTAlO+AIrB+f8C
         Vdam1jobdgafA82y6/k4D4hac+d9ziL6FJf94FmLzKATqs7/FuMx4qAiI03fIFNqj43O
         kRKyCgMCtI3uP4W9y/xn3e/P77hcOau7dXAhR2X0cEVArtmNZu7/9DURKJKLakTeolno
         Te3qyCytMpp89dcDVLLkIinOHQTSvN+VBU1JWZp1XZsKIL57zcBz+0aeN895BcC7OIyK
         of9v+e/Ysr4fgh43Lh+flwh301CE66bb6yGSfnCj5ouRcolHbEc1CA23yDwA2pfKZino
         o4tw==
X-Gm-Message-State: AOAM5304YTEtHrgpLlkiZ0H4aB2kD+GhzgolejPnMswRMqVWoO6PuPZi
        6w9grR054zcZeJpSl4UjWOj/OQJxGjvxig==
X-Google-Smtp-Source: ABdhPJwF/oxCbdIBThueC+vdJjv3Rsb+QwC2K8FdOyywgM5pIfWZzcgW/d8Ou21uA0W/B1kRQnrR1A==
X-Received: by 2002:a17:90b:120a:: with SMTP id gl10mr69115pjb.234.1629922179122;
        Wed, 25 Aug 2021 13:09:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u24sm554378pfm.85.2021.08.25.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 13:09:38 -0700 (PDT)
Date:   Wed, 25 Aug 2021 20:09:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Artem Kashkanov <artem.kashkanov@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] KVM: x86: Register Processor Trace interrupt hook
 iff PT enabled in guest
Message-ID: <YSajfuw7P2wacTGY@google.com>
References: <20210823193709.55886-1-seanjc@google.com>
 <20210823193709.55886-3-seanjc@google.com>
 <3021c1cc-a4eb-e3ab-d6b7-558cbaefd03b@gmail.com>
 <YSZa7dkw6t7yN6vL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZa7dkw6t7yN6vL@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 25, 2021, Sean Christopherson wrote:
> On Wed, Aug 25, 2021, Like Xu wrote:
> > On 24/8/2021 3:37 am, Sean Christopherson wrote:
> > > @@ -11061,6 +11061,8 @@ int kvm_arch_hardware_setup(void *opaque)
> > >   	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
> > >   	kvm_ops_static_call_update();
> > > +	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
> > > +		kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
> > 
> > Emm, it's still buggy.
> > 
> > The guest "unknown NMI" from the host Intel PT can still be reproduced
> > after the following operation:
> > 
> > 	rmmod kvm_intel
> > 	modprobe kvm-intel pt_mode=1 ept=1
> > 	rmmod kvm_intel
> > 	modprobe kvm-intel pt_mode=1 ept=0
> > 
> > Since the handle_intel_pt_intr is not reset to NULL in kvm_arch_hardware_unsetup(),
> > and the previous function pointer still exists in the generic KVM data structure.
> 
> Ooof, good catch.  Any preference between nullifying handle_intel_pt_intr in
> setup() vs. unsetup()?  I think I like the idea of "unwinding" during unsetup(),
> even though it splits the logic a bit.

Never mind, I figured out a way to clean all this up and land the PT interrupt
handler in vmx.c where it belongs.  Getting there is a bit of a journey, but it's
very doable.  That means unwinding in unsetup() is the preferred approach,
otherwise there would be potential for leaving a dangling pointer if a different
vendor module was succesfully loaded.
