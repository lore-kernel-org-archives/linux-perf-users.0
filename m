Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF7EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjF3Rew (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjF3ReZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:34:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708849CD
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 10:33:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401d1d967beso23031cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688146422; x=1690738422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncRHJ/UjJWTzqrYWhnAQ1Z9WL/dnndbkb23KvFYFj98=;
        b=13KZgM3bZReYnp+zOtCRTMwq6znHdRzyNpuw2EhU6x6AQh/Fijhf2oEQUsl4Yp56j7
         g7H9t/Rhkxb+wiC85UNdsnTRJ2UMs+3WirehMCQO5un7lXy4PQZsvqvdp1d696RbtO1d
         v08UtmF2JugycqatrqL8deE/ZbUZlTL/OZmDgF3iUVqg27fv8cM9OpOKgx3eap0JId6B
         0XV+UdR48exs/vgI1mP66mgQQ6ICA1FxzRGozGzyyo7ZEsipPffmn2koTfb+pAKfHYst
         ysyrNrM5NpZgPAmvEa+oS74M+gXicqCXywZAcqRRCeYtx4MfoYMS20UkW9geSEHJbm6g
         rheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146422; x=1690738422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncRHJ/UjJWTzqrYWhnAQ1Z9WL/dnndbkb23KvFYFj98=;
        b=ceOi2NsMJfOSGhRu188RCs0gJDm1xwfKxGs1pvkO7+siDg3GbswqsL3DdcpGMsJFJe
         4T8LlAVrF2hiCwdl6s8MvrdvRv4H6ou0sQnZqBRvy98OjRrMsHdka+CSJn2niLAvJl1v
         8dQ3J/2LvYQahlInY8KADrLPFpG59CZo+MmX8u2Cy0MHvDjWGs7TPhwcHfcGO1763xdF
         8hyFX0mYQE7BnNK7O6CPXM+HMvMGt6qLj5F5hIGvgh16/2l+WqJxuVTl9Epx700ipqSr
         tjQs+GfjyJNlJD16YAed4IrnJLYdqZTBTFpNM/ygFpxPXiVVfc+14tjxVW65pxk+3vky
         1VDQ==
X-Gm-Message-State: ABy/qLZrqofq8LDd06Q///YXKaCA2mJYUyY05QhXv4ZNdBuzOKdNkPIa
        NILRwJC4y32+rLUmSjn4mhC9N3CF3+5Y9yk1OIIaOg==
X-Google-Smtp-Source: APBJJlFblHu7nuYcdkIa70v0NVLCYtL+USy8nv1lip1niNa3ugQEr7gvuJTaaG87EHBpbYmr/6JI0Muoa3EKO3w9IjU=
X-Received: by 2002:ac8:5a05:0:b0:3f9:a73b:57bb with SMTP id
 n5-20020ac85a05000000b003f9a73b57bbmr8915qta.4.1688146422404; Fri, 30 Jun
 2023 10:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
 <59e92b31-cd78-5c0c-ef87-f0d824cd20f7@web.de> <CAP-5=fX8-2USHn8M4KPfwLz3=AG9kc8=9KdjayMsRexZ87R_EA@mail.gmail.com>
 <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de>
In-Reply-To: <44d77ec3-9a19-cfd5-4bba-4a23d0cd526b@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 10:33:31 -0700
Message-ID: <CAP-5=fXjXBSFVDYXw6fXUf35hLDMqS-C4DRC4LWXUcsMNP6gdw@mail.gmail.com>
Subject: Re: [v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 10:23=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>>>> Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> >>>>> PMUs before parsing").
> >>>>
> >>>> Will the chances ever grow to add another imperative change suggesti=
on?
> >>>>
> >>>> See also:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/submitting-patches.rst?h=3Dv6.4#n94
> >>>
> >>>
> >>> Sorry, I can't parse this.
> >>
> >> Can you take the requirement =E2=80=9CDescribe your changes in imperat=
ive mood=E2=80=9D
> >> into account for any more descriptions?
> >
> > Yep, still doesn't parse.
>
> Does this feedback really indicate that you stumble still on understandin=
g difficulties
> for the linked development documentation?
>
> Can the mentioned patch review concern be adjusted with wording alternati=
ves
> for improved commit messages?

Sorry, checked with a colleague and kernel contributor, we don't know
what is being requested here, "imperative mood" makes no sense, as
such I don't have a fix for what you're requesting.

Thanks,
Ian

> Regards,
> Markus
