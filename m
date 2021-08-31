Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623BC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68E86103A
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 12:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhHaM12 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 08:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhHaM11 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 08:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4FA86103A;
        Tue, 31 Aug 2021 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630412792;
        bh=L+wc30ZHstHOgN0d2A40H0V8qG5hqCqSseO/vjIzQeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V8KrWXSIxltiT/VmdhuBukXaYqmMi/3ARbqLpeIrF4GUjbqMJteuFzFb2KkQyhv2f
         //KfP3gntswmeRlN2zSxvVamJLDVwgEQ6zjVJr/veASS4ezbubbZsfawPmN8EeEBhX
         TeZew8nwMqiBeBOJDFDZr3DdEA6r1vKCXG+UZpf/pJc/ene1nYyCS5MTd3kBH4MMEw
         Q+G0IZbrzrw56jx0KonaEiU3+I4NfwbruK8chneFOmRniUoKhlnCQPViuqpndD1UM4
         iwcaiIvNotb9zvUSB3ZCfkvD6LEEYZ3dyXbeL0P8Kxh4fYTBUiAKExA6kNtOQYgRrj
         SgnXOVsj2cqfg==
Received: by mail-ej1-f47.google.com with SMTP id u3so38147471ejz.1;
        Tue, 31 Aug 2021 05:26:32 -0700 (PDT)
X-Gm-Message-State: AOAM533QkRosyrpGoppxQdMfK9hqcX0Z9BPxdx7nkCw95vwbuAUoE5Qc
        rGqZfPQGeS3xhzQh62JK6eBmFy3T+Ai368Xj5w==
X-Google-Smtp-Source: ABdhPJyeV22IUKccmNXHy/1A9YZQNLXAVMIiq1HJncIcD6WVk8MYff1VuGxs8piuizKl27M3iK7OEFpZCpgsxNw9hZA=
X-Received: by 2002:a17:906:b4d:: with SMTP id v13mr31303236ejg.468.1630412791360;
 Tue, 31 Aug 2021 05:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-2-nakamura.shun@fujitsu.com> <YSQBI+FZLBvKr088@robh.at.kernel.org>
 <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 Aug 2021 07:26:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLKD0DZT63MQ9vTumOf1bfRrU9Bt9Qa_GTb1siRsK+Z+g@mail.gmail.com>
Message-ID: <CAL_JsqLKD0DZT63MQ9vTumOf1bfRrU9Bt9Qa_GTb1siRsK+Z+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 24, 2021 at 5:12 AM nakamura.shun@fujitsu.com
<nakamura.shun@fujitsu.com> wrote:
>
> Hi, Rob
>
> > On Fri, Aug 20, 2021 at 06:39:06PM +0900, Shunsuke Nakamura wrote:
> > > perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> > > does not scale counters obtained by read() system call.
> > >
> > > Add processing to perf_evsel__read() to scale the counters obtained during the
> > > read() system call when multiplexing.
> >
> > Which one is right though? Changing what read() returns could break
> > users, right? Or are you implying that the RDPMC path is correct and
> > read() was not. More likely the former case since I wrote the latter.
>
> perf_evsel__read() returns both the count obtained by RDPMC and the count obtained
> by the read() system call when multiplexed with RDPMC enabled.
>
> That is, there is a mix of scaled and unscaled values.
>
> As Rob says, when this patch is applied, rescaling the count obtained from
> perf_evsel__read() during multiplexing will break the count.
>
> I think the easiest solution is to change the value you get from RDPMC to not scale
> and let the user scale it, but I thought it would be a little inconvenient.

Agreed, unless someone else has an opinion. It would be good to do the
scaling in libperf with the optimized math op, but I assume there's
some reason the user may need unscaled values?

Rob
