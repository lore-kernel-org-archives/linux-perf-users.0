Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9F7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 23:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D9160E53
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Sep 2021 23:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbhIHABC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhIHABC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Sep 2021 20:01:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9DC061757
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Sep 2021 16:59:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u17so417225ilm.13
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Sep 2021 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKEqiH61GNvTizsuqwHMlFfrJQRSeQBmCpOvsRSSlMI=;
        b=s5GamzllpZ2NXrqK3akabmDh2KGGe4aVrb2BOgYLVpoEE8i9cIt6IPz+Qf+bNEL6AC
         wxIxDnUPJKzSyEZEXK35UWb9RJMmD9znxRnxHP6zZ4qxQQARAii3yyMTgyWP4WC6Bx6A
         XlnAHVCIVWJ6cTBS7fl6jCO3MxhnaImd6wZZbD2O7DYW0wlyRrDkuqZw8XzkHHb9r4fK
         TCLL2FQJtNp17LUxM6sPdx2ZpAVisbPeEb5Ucj8VwmGcPcWidq9j97XQ5zBEi9NxSClO
         NaI9CAmj6pVurZao2oOvekDI/wo3q9OkebD5ovOeJG4tLyeY3wc8gDsXvan01FA6EIDj
         2Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKEqiH61GNvTizsuqwHMlFfrJQRSeQBmCpOvsRSSlMI=;
        b=aMagIavAJ3Kq2qaIG2lf4ywkcjsuhy7ryapn/sC3MgUbEonrpEDkzYPyaGdO3W5/hr
         B5WRKD55Ubi8QAQd7vqRINzLJ4JT6ikBhCk+Hvm2oGQSYMv4PrM5cpJTK+r+1HR44c9S
         sIEZ1IiB9Y2jo2xomgPN+Xu7kr+UftWHSeU5FRfPcNMJE1kynAGtiy++K/bkY/O0DlT2
         gbAdJyqp1Z1v84lypMvxDqwCaknsxtTANISUOUe+R/StdU6uR+cromb8B5dbsR8M7sPM
         BTCex2WjiXZ/HEtU8MeGP+Q1LO5BvYbevYXcWVtB9TI4SHkvHtrNj0El+X8oMF4DSGlz
         CT6Q==
X-Gm-Message-State: AOAM5314QTznyisZbsHJTVpTP/2JijXi5gwoAMcLK0EmjMZd+kvWErwk
        fEbMfEH0AvXOW5Wk9s57cEdka1MFfTw0JF+mVbsZ7w==
X-Google-Smtp-Source: ABdhPJz8ZsjXIIvwM70Cwn7aXfQGt/WD4cgPID4ZPI3J8wGYq8OxXyMDZNXB9hiFNp52j/ZC/gu2g45y5UiZ5IjiuEA=
X-Received: by 2002:a05:6e02:505:: with SMTP id d5mr689712ils.150.1631059194343;
 Tue, 07 Sep 2021 16:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-2-nakamura.shun@fujitsu.com> <YSQBI+FZLBvKr088@robh.at.kernel.org>
 <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <CAL_JsqLKD0DZT63MQ9vTumOf1bfRrU9Bt9Qa_GTb1siRsK+Z+g@mail.gmail.com>
In-Reply-To: <CAL_JsqLKD0DZT63MQ9vTumOf1bfRrU9Bt9Qa_GTb1siRsK+Z+g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Sep 2021 16:59:42 -0700
Message-ID: <CAP-5=fW_g9JHKWQoNiwNeSN8MjJ1OA7qLb3JD3ErEi1be4DEiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
To:     Rob Herring <robh@kernel.org>
Cc:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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

On Tue, Aug 31, 2021 at 5:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Aug 24, 2021 at 5:12 AM nakamura.shun@fujitsu.com
> <nakamura.shun@fujitsu.com> wrote:
> >
> > Hi, Rob
> >
> > > On Fri, Aug 20, 2021 at 06:39:06PM +0900, Shunsuke Nakamura wrote:
> > > > perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> > > > does not scale counters obtained by read() system call.
> > > >
> > > > Add processing to perf_evsel__read() to scale the counters obtained during the
> > > > read() system call when multiplexing.
> > >
> > > Which one is right though? Changing what read() returns could break
> > > users, right? Or are you implying that the RDPMC path is correct and
> > > read() was not. More likely the former case since I wrote the latter.
> >
> > perf_evsel__read() returns both the count obtained by RDPMC and the count obtained
> > by the read() system call when multiplexed with RDPMC enabled.
> >
> > That is, there is a mix of scaled and unscaled values.
> >
> > As Rob says, when this patch is applied, rescaling the count obtained from
> > perf_evsel__read() during multiplexing will break the count.
> >
> > I think the easiest solution is to change the value you get from RDPMC to not scale
> > and let the user scale it, but I thought it would be a little inconvenient.
>
> Agreed, unless someone else has an opinion. It would be good to do the
> scaling in libperf with the optimized math op, but I assume there's
> some reason the user may need unscaled values?

Hi, something I've mentioned on other threads [1] is that running may
be zero due to multiplexing but enabled be greater. This can lead to a
divide by zero when scaling. Giving the ratio to the caller gives more
information - I may be misunderstanding this thread, apologies if so.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/CAL_JsqKc_qFA59L9e-xXOhE4yBTdVg-Ea9EddimWwqj3XXxhGw@mail.gmail.com/

> Rob
