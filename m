Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27BC74A5B
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 13:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCQN3O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQN2m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 09:28:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810E1A256
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 06:28:41 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so2858909otv.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679059720;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgpMLag8MHdKV6jstxIR1+/70o9FTC1Xzx45b2XLchM=;
        b=Pf4EaycmZKpnK25FxhH5DneLFjGLVvka2+XQcyJfuZAEsV2rvhe3C6Q6IkrPVm21vU
         CN8dM8Fc2MiZHC5ag1uqDXDZ3+B+JYxUeucv6omjRUKQa0YHqRWQMYS0DSr+iiBHyrzd
         yGZ0+NjIP8xHWr1C3eHSu3VzxNELKZ6VeSpogO58ifAxlkKeH8t67jPOmL+vzgWxLwqm
         OZ9a7x9lP5+7GjF0Apon9D8zRBHLACVhlPjcXUhj+Izrf0VCnp3BEDzyrxjSroDVHlt9
         HpwfvXVe3pjr/47NnH9yVVHXaq2szmCveH8WmBJzZ3wLNhLCiVsahNSJlw/5TNksSnvK
         DAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679059720;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgpMLag8MHdKV6jstxIR1+/70o9FTC1Xzx45b2XLchM=;
        b=pyOAYxiwoqSxTglb/HoCJPYMbzLP7iOY2FMGo/6cjOuMX9k7/QGr/B0uYdvtG1lS2c
         YFynoU00GSMxY98Q+68NBPpdL8R3n3o1zhFIXucLUujmtdxGHCiza473HVTPA1Xfl2k5
         66CZ55AiMJ9hJWjxRJJIduY8wJZIvkdzsr2Yhdz9QWIvwrsoHXL7BxeLlngbC2rlJbwe
         Q+IhHxX+wgV5rRlrPJvsQf/DRG+ZadNeaBmqm2Sz49hfWFy/sSkzt8ADLxlwXjz5o1lC
         DIYYFBjZlNEsViv8EpLTJh4H30UgSekITpUYiQl9nPArPtBRGp+GSZnxtcCc67iyDT/T
         RLZQ==
X-Gm-Message-State: AO0yUKXI2Sl36il4EIuI0Odoi7V3IxwcM2S4qV8rRPAekcX/kNNur0zj
        BRSB+BDMXXClQUCGukmBc9DzIx3D1oM=
X-Google-Smtp-Source: AK7set/7iv9A5CgzY+Y/aKBlorM3kesitpNV08Pi9+UTbB2ZPGOUmi2kFANEiY5HCjSzPGL0T0vdnQ==
X-Received: by 2002:a05:6830:3498:b0:69d:2629:fe5d with SMTP id c24-20020a056830349800b0069d2629fe5dmr3770792otu.37.1679059720581;
        Fri, 17 Mar 2023 06:28:40 -0700 (PDT)
Received: from ?IPv6:::1? ([2804:431:cff4:5c11:95f2:3305:cfcc:450b])
        by smtp.gmail.com with ESMTPSA id d6-20020a056830004600b0069451a9274bsm958648otp.28.2023.03.17.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 06:28:40 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:28:36 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Travis Downs <travis.downs@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: Cross-arch analysis
User-Agent: K-9 Mail for Android
In-Reply-To: <CAOBGo4z=LObbQ-KRRuH__pFsC=1r1jQ2r0e3TbCTeweA9YsDxA@mail.gmail.com>
References: <CAOBGo4z=LObbQ-KRRuH__pFsC=1r1jQ2r0e3TbCTeweA9YsDxA@mail.gmail.com>
Message-ID: <01A1CCF5-C9C0-484B-A1B7-08514CE5453F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On March 17, 2023 10:02:37 AM GMT-03:00, Travis Downs <travis=2Edowns@gmai=
l=2Ecom> wrote:
>Can I run perf record against a binary running on say Arm64, then pull
>back the perf=2Edata file
>to an x86 machine and run perf report there?

Yes, and to gather DSOs with samples, use 'perf archive' or point 'perf re=
port' to a directory with the arm64 OS image using --symfs=2E

- Arnaldo=20
