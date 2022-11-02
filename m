Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F598C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Nov 2022 17:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiKBRi1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiKBRiS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Nov 2022 13:38:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E32E9EC
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 10:38:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y69so27596871ede.5
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7ABouFgHj5ByNLmtwAswNa0h/Rt+M2oBytR/Rw8uLA=;
        b=QpvQxcSUTA1O6xF55mulqkLaZsShG+Sff81BNMiM9v5YKPDWuzOnTREHmMnu+iTF/D
         w/dbC1a2HGnnuyux7lkTNV2qaXQWqv7qBl8VEJUfj+n/upmlt6Ja2PdDrNIA8WISq9mS
         UHJstI54PIB7jAzDPZkswyD/xookUkhC7RM/jFEc/bvGK6oNv8ky6RfS+6VkFvJHeq5w
         3RT+nYj4MsWdM4hyCEFipLfFd8+DL8nDnF7NMzzoiojb00OFIhutrGya7HsVvz/HQCO6
         4HFUlULQAkvmNX+p0BBBKYUeoVx8crQlt5JmxjWOy3OkYVOTmA8zIGX5atwpKzldYhgW
         g5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7ABouFgHj5ByNLmtwAswNa0h/Rt+M2oBytR/Rw8uLA=;
        b=KdWMxAp5xMMbKkQKdKscwOxGl7kIh76kyji2gylzjWuWdQZ46NzsJqNCuTK8OoEMnB
         iukq6VF3mBwdl4IAfcLQC7OrnVCwLzI/cbfql3fnwgsfpxbx6vfn+LK4MTR61qzGNUVE
         4I5S3Qfu5kmUuKZRz6mAnagpMwn78M2XWaEg94H/8PUu34tnJz7lp/cNtuP83L9Wq2Dd
         tk7rcDb93lvQoAhABYsmh8vKIDJvfo9XsaKNeDTXXaXaCvVNYFBF2yIp3waXRfL23at6
         HdT8SUimORqxA4rswOulDu8m0PVWkU6PuBXhnJxURxYJIqCUVDdOA0RJJ9KeXvzExCKK
         xT6A==
X-Gm-Message-State: ACrzQf2TlK8sGB4fD8SfPVALalcuHK7gZqTNFohcRzkoKgLJhBgY1vSG
        5QIef9bO1DFc7t/uTL+6geA4rxn5OIJmQGAntxFWJQ==
X-Google-Smtp-Source: AMsMyM4oBTrJV7DcVnahMpuWfOJgDLYhbj61/lrNgSjXLaA5ap6eQgOpfZt9WT33sE6fp3lkT4INWWRy88dkV8zNmoI=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr26154062edb.46.1667410695620; Wed, 02
 Nov 2022 10:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221026141040.1609203-1-davidgow@google.com> <CAGS_qxrd7kPzXexF_WvFX6YyVqdE_gf_7E7-XJhY2F0QAHPQ=w@mail.gmail.com>
 <CANpmjNOgADdGqze9ZA-o8cb6=isYfE3tEBf1HhwtwJkFJqNe=w@mail.gmail.com>
In-Reply-To: <CANpmjNOgADdGqze9ZA-o8cb6=isYfE3tEBf1HhwtwJkFJqNe=w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 2 Nov 2022 10:38:04 -0700
Message-ID: <CAGS_qxr3dRQ8hUwA9LaFrbH9u4mdxjgfqtCByQ7kWCk-U2L-sg@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies unmet
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 2, 2022 at 3:23 AM Marco Elver <elver@google.com> wrote:
>
> Hi David, Daniel,
>
> On Wed, 26 Oct 2022 at 20:31, Daniel Latypov <dlatypov@google.com> wrote:
> [...]
> > > -               return -EINVAL;
> > > +               kunit_skip(test, "not enough cpus");
> >
> > The only minor nit I have is that I'd personally prefer something like
> >   kunit_skip(test, "need >=2 cpus");
> > since that makes it clearer
> > a) that we must only have 1 CPU by default
> > b) roughly how one might address this.
> >
> > Note: b) is a bit more complicated than I would like. The final
> > command is something like
> > $ ./tools/testing/kunit/kunit.py run --arch x86_64 --qemu_args='-smp
> > 2' --kconfig_add='CONFIG_SMP=y'
> >
> > But that's orthogonal to this patch.
>
> Was there going to be a v2 to address (a), or is this patch ready to
> be picked up?
>
> I assume (unless I hear otherwise), this patch shall also go through -tip?

Just noting for the record:
I'm totally fine with this version going in, esp. if Peter is already
planning on picking it up.

This patch makes it so `kunit.py run --arch=x86_64` doesn't have test
failures, so I don't want it delayed due to just my small nit.

Daniel
