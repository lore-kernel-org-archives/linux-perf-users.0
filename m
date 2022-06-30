Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEBC43334
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Jun 2022 21:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiF3VAJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiF3VAJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Jun 2022 17:00:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239934D154
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jun 2022 14:00:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so304113wra.9
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jun 2022 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1/852Kpl379DkY8IyHRAhEAKB1VElvfB/9xeoKwddc=;
        b=g5iaMxpsnZVPeiR6mp8wdabUx6Wei2zb1VMqZvBvpOVmyciM0fiy4UUa5xEf2Df6Cn
         E+nnCdIAShcZOvGltX2sMdz3ldP3j1u8XNXQ3FYnKg6LE31KqIMXjaPLmRHkqVBrKP6c
         mr7KABDhIh5XDVPz2IIpQl6S20UeM0J9mI0/kCmvsdtZ3pplt91D3pDbdSyKl2xjZFoo
         DuBxPIFD3H4kLhrg7c/gqphG4YuiaTl/HOAFU0nupdkrR4Z+qFbppe4JGKy2lQySMXmE
         GJSfC1tet0saTgMCOGN0TRWCeBhN0O+X1KIh7vUMyNdD6KDhNmA+KJQTr3oT8bog1ZGO
         UVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1/852Kpl379DkY8IyHRAhEAKB1VElvfB/9xeoKwddc=;
        b=Y0TQLHc7TepkKnpNY8yCgjT0W/Ce58f0JWDQr5Pft504IlG+zgVuiniW19eVS5W17O
         1wbwQbRVFoeJJZqaHocspgDhyKPbgq9FPXsHi2nC4YOsZZmHOqxuixe2iM1cYErbQQ4r
         43bN6JFA3lMoPWHlAp3oa+9fqjCkmbprT8HruFOvGgwPbm2/6Hzj5BxnvLe7bg9qxde1
         9Z8XgEBJ1bTSshuz3/oz/iXXK9LDgUJnKSfRHav18l3dBQ0DTEDWRuLzwwyLzUmxAOwf
         pZGD/2TZpIX8p8PKRoPrFPT1F2hLsyZ+5tAhkr6zrH0JaNlbkJ1J93/gaGge9Xli/Lwi
         iiTQ==
X-Gm-Message-State: AJIora90HvkegxnMeuFfxN2APjDwNIFCwsQecF+0hJ96iZw2k5+sKXO7
        sOR+bfyqwUweOVDrCmO89Hel1KPgJg5T3NFs85TepA==
X-Google-Smtp-Source: AGRyM1tK4gBdtJYZ7ivkabtQEl5FWGBcZiAP8LVIytEjl138vvcvZTC5U8ID7obXg4LJdMhrl/X8V0UWvdpSphlUT9U=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr10592230wri.654.1656622806498; Thu, 30
 Jun 2022 14:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220629034007.332804-1-irogers@google.com> <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
In-Reply-To: <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Jun 2022 13:59:54 -0700
Message-ID: <CAP-5=fXRxvSB9WrcTEM+2rnALuzPBdPz=v+WGhvN_SS2Ba2MTw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip for paranoid 3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 30, 2022 at 2:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 28, 2022 at 08:40:07PM -0700, Ian Rogers wrote:
> > Add skip tests for paranoid level being 3.
> > Rather than skipping lines starting "Failed", skip lines containing
> > "failed" - making the behavior consistent with the previous python
> > version.
>
> paranoid 3 is an out of tree patch.

Thanks, what is the right way to resolve this? My desktop appears to
be carrying the patch and I'd like the tests to be as green as
possible.

Thanks,
Ian
