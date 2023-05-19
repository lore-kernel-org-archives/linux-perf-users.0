Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EF4C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 17:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjESRbh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjESRb2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 13:31:28 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C3172A
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:30:25 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-783f7e82f28so1089297241.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684517424; x=1687109424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7bXuAl2er6jMvvw+SQdriEgYnLYrf51RQ1JCNcE4RU=;
        b=bgCIdICPWkt3FCRRsGc/NFJUgqeEDLKK4rgNm0pY6Tm8FoLFBw7HPJ158fzzn51jOS
         EXlDccb8uEQxTbRzcwErWxlcv/ZgEUa/ZzBhXlmQqtVOO0tWuhgkdoA5El1hXRlEk4+Z
         9JmQ1xuSX8t3SUOCr4wp+RHMsWovUeKKIrFqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517424; x=1687109424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7bXuAl2er6jMvvw+SQdriEgYnLYrf51RQ1JCNcE4RU=;
        b=N8E9AiPQ8PfcfRT8XlsslLMuKUkV9DH1nrObtTBrclF6x2AfW/WrUKValGYqAMvJY6
         EtJGzEii4Lxoyb+TJEl0qYn/EdZ0FBr0d55fehOLILZjslMg/fYNUno8XGQ320QBVb7X
         ++RPxPWCvMisDN8PxBZBJPeH5318dNOS9SALS3RnMCK/biGQujnu/5OPax4BOGVEcwbR
         bTzRUXqaA7i2cw5CiDEMf5XsMW7X4lxDEUOK3HlFukA5tbdZ2ZzQY51boo4ZVXbuDbku
         50mOBHWnCqsT5jtxk1Wt2Xh/gtwVPXNAHyzai0iGnCPVv9PTQOyr6ylvBe7a2LmpJBjN
         3Lzg==
X-Gm-Message-State: AC+VfDxFEGF8EtSmqqfsssWHHNL8uSKGUNsuM445xPEGpD4uvJOE9ExZ
        IgJph27TOmkgyAtVpAn1nWX2EshIBD11r575cSI=
X-Google-Smtp-Source: ACHHUZ5CGRgV+mZ5Tb6Q3BC+ah3NjmcHvrzzyO+GzYIgwU2/DnDpYEYaP9Q+KUwknpAYNURKMaBz3Q==
X-Received: by 2002:a05:6102:18c:b0:42f:edd9:6f2e with SMTP id r12-20020a056102018c00b0042fedd96f2emr37723vsq.10.1684517423782;
        Fri, 19 May 2023 10:30:23 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id i16-20020a67c210000000b0043930c70cfasm144981vsj.17.2023.05.19.10.30.23
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:30:23 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-783e5c64d29so782089241.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:30:23 -0700 (PDT)
X-Received: by 2002:a05:6602:1548:b0:76c:e93a:e2a with SMTP id
 h8-20020a056602154800b0076ce93a0e2amr7743221iow.8.1684516998834; Fri, 19 May
 2023 10:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CSDZSKA38AEF.FY7J3JXBJX4I@wheely> <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
 <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely> <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
In-Reply-To: <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 May 2023 10:23:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X53VnS37YXkGUT7W=1ekS1YgznCbOiBQBSHuZLqpHa_A@mail.gmail.com>
Message-ID: <CAD=FV=X53VnS37YXkGUT7W=1ekS1YgznCbOiBQBSHuZLqpHa_A@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Colin Cross <ccross@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Mon, May 8, 2023 at 8:52=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hmmm, but I don't think you really need "all-to-all" checking to get
> the stacktraces you want, do you? Each CPU can be "watching" exactly
> one other CPU, but then when we actually lock up we could check all of
> them and dump stacks on all the ones that are locked up. I think this
> would be a fairly easy improvement for the buddy system. I'll leave it
> out for now just to keep things simple for the initial landing, but it
> wouldn't be hard to add. Then I think the two SMP systems  (buddy vs.
> all-to-all) would be equivalent in terms of functionality?

FWIW, I take back my "this would be fairly easy" comment. :-P ...or,
at least I'll acknowledge that the easy way has some tradeoffs. It
wouldn't be trivially easy to just snoop on the data of the other
buddies because the watching processors aren't necessarily
synchronized with each other.

That being said, if someone really wanted to report on other locked
CPUs before doing a panic() and was willing to delay the panic, it
probably wouldn't be too hard to put in a mode where the CPU that
detects the first lockup could do some extra work to look for lockups.
Maybe it could send a normal IPI to other CPUs and see if they respond
or maybe it could take over monitoring all CPUs and wait one extra
period.

In any case, I'm not planning on implementing this now, but at least
wanted to document thoughts. ;-)

> With my simplistic solution
> of just allowing the buddy detector to be enabled in parallel with a
> perf-based detector then we wouldn't have this level of coordination,
> but I'll assume that's OK for the initial landing.

I dug into this more as well and I also wanted to note that, at least
for now, I'm not going to include support to turn on both the buddy
and perf lockup detectors in the common core. In order to do this and
not have them stomp on each other then I think we need extra
coordination or two copies of the interrupt count / saved interrupt
count and, at least at this point in time, it doesn't seem worth it
for a halfway solution. From everything I've heard there is a push on
many x86 machines to get off the perf lockup detector anyway to free
up the resources. Someone could look at adding this complexity later.

-Doug
