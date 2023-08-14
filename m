Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF0C001DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 17:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjHNRg1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjHNRgV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 13:36:21 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915F10D0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 10:36:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so23271cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034579; x=1692639379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nezIMeQVI/coqQm4cEiygAngrUHrjvD9ah/qFQLbofg=;
        b=RY6OAETd5OfPN1mjkKSF54kvhlpncn28oQRxkYqxBww9vv/fazE9jfmV0o4mHE8yTH
         SRbtH6W++lKf7SBz3oql3p65RzUZvftNHlFlanbDFkdILu0tBG7uiX74Qp0Z2agGNkKN
         9akPDEuRsmIEVzcUHU61bmJJTacJBPXYkgOeXU9y/3a3UuN8hbSpVL6udI/vKyxsV5eB
         CInQe0Q8XPxRycYvGqNNavRuDsMaIA8EJq6hVDaYWHxnJKg96spxXctcrrkxqmtJOHj0
         wNpfyNsqkwHaGhfhf2jP2Cs35chxM4T0+D7lsL9wuhD1WO+rkqcJKu/HjF0Sp9HMwmeO
         MPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034579; x=1692639379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nezIMeQVI/coqQm4cEiygAngrUHrjvD9ah/qFQLbofg=;
        b=UDrYsGMVoYx6mqvO95ACdIKzDb8ceXKVRpVOuz0BIqSn/PFFnUBUxQLCPnfSv4bI5l
         H2yTBS9+m0ALTJaJC4F+MHBdWJo013sUn6uJhwrY7xD00JFZ8kgw6HKcgC8VQSsQre6V
         U9NbarvkbOW/AZ9O/4qFYZTn2JJ6dZ20awp+yeYgm/AuYAzzo4MIFAwMi3ZLiWFh1yVl
         mFKr15H7rLFhMFVkN6jLmWcWHv1+A7LfHQRfnknccdi4DE+Nk38v7/cCIHlse7DfGQGP
         SVzvDesq6R1zJ5+mdEpn+FpWUp3srzNjRYNJPqk94SOtkAU/XYcNg0iW+BfcAw5lUqu+
         kaTQ==
X-Gm-Message-State: AOJu0YwgWbctoaWjLgzoOv75Wzs1SChoK4mi2OTzGsy8HKHzhO8V9awa
        kmXlT81B42W35Jbs7R5k87AAvaKAx4A+UTNemSUJJw==
X-Google-Smtp-Source: AGHT+IGc+G4K6OEf6vdlaaKeywz8co8Q6qYJYXMlr+M6vLVyR+QtiyiLz1zjwnmqetqLdt01dD0x7HNbJXFWr9v7qa4=
X-Received: by 2002:a05:622a:1b8c:b0:403:e1d1:8b63 with SMTP id
 bp12-20020a05622a1b8c00b00403e1d18b63mr602344qtb.24.1692034579524; Mon, 14
 Aug 2023 10:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
 <20230803211331.140553-2-ilkka@os.amperecomputing.com> <9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com>
In-Reply-To: <9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 10:36:08 -0700
Message-ID: <CAP-5=fX2uE=B_Vb90nn5EV0mw+AJBpjDecP9w29OUn=j7HKPPg@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf vendor events arm64: Remove L1D_CACHE_LMISS from
 AmpereOne list
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 4, 2023 at 4:02=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 03/08/2023 22:13, Ilkka Koskinen wrote:
> > amperene/cache.json file tried to include L1D_CACHE_LMISS while it
> > doesn't exist in common-and-microarch.json. While this bug doesn't seem=
 to
> > cause issue in newer kernels with jevents.py script, it prevents buildi=
ng
> > older perf tools with the backported patch.

Fwiw, newer perf tool on old kernel should always be fine. But I
understand that if you are trying to build a tree with backports in
it...

>
> jevents.py needs to be improved so it errors on these events which
> cannot be fixed up, like it used to. I'll look to do that when I get a
> chance.
>
> >
> > Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU =
events")
> > Reported-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> > Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/76bb2e4=
7-ce44-76ae-838e-53279047084d@oracle.com/__;!!ACWV5N9M2RV99hQ!IlO3yUW8jhm6w=
p8BJalODmD7WjzJleyREtTWS2pdn90Af5BD3P7g0fTGldbw15pSn49ycWiKpWDysjXw_ECS4Xbb=
JQ$
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >   tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.js=
on b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > index fc0633054211..7a2b7b200f14 100644
> > --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
> > @@ -92,9 +92,6 @@
> >       {
> >           "ArchStdEvent": "L1D_CACHE_LMISS_RD"
> >       },
> > -    {
> > -        "ArchStdEvent": "L1D_CACHE_LMISS"
> > -    },
> >       {
> >           "ArchStdEvent": "L1I_CACHE_LMISS"
> >       },
>
