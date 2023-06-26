Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C2EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 17:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFZRkt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFZRka (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 13:40:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D630FD
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 10:39:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b5520cf4adso16895ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687801100; x=1690393100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJkVz7XfPaiiXBKEk1U5bzLHSYhr7kzJhkshlyUDZB8=;
        b=6IP+GRZjZygbvUl7rwhvTT9JaO1TZ13SneUgmoT/ueQsST6HjJhIV9RNHrL5Ivsa6Y
         XZfc5Prb1WSen3uDoGb4WdXVlDF9Hojz9khjfB0WtvgyWUByJVxXQqxOfwWMOIT44H3l
         lYIClHfDbgN58iUcol4oPfRX1Yhh5URoquP29uQAqKyiudehb7m13JoSj/E+hDLEKFKC
         MWNsDUP0dDUjRWnjJ14aySwSCQ/GNI1FKDX6PXuBlgQ1SweBzxJ9/22PySX9ZSFKlB5v
         +fsPnR7Ly3LfWHO0UL7q4iK1g6rO788kWSYWdkHcGIIFS9rabdCNZaRct7aDJowft3+9
         AbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687801100; x=1690393100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJkVz7XfPaiiXBKEk1U5bzLHSYhr7kzJhkshlyUDZB8=;
        b=cppUtWNPKZ39CRz8tN8cYPvslH4P3QNFs49741YlYFSYd3nUucjnZcpgLWu1dSyQwO
         Sv8fro8ttZcaTT9LQ84fEO+7D/STbdmMFlTRbFoiBdD0QDoi4AO5EWpQwBIzt49Lc9qg
         yMo+TYosLpFxKjAi7LRNi/oWi2o27B3hguIySwjWIQEtchQTEiaRxF7wESLBQd+yMthc
         R/WTU3wK4+e+kUBFI5fOrhngwcEHuAFOuRTZz6i/Ee9xqkI1J2OgR5bHGrdqmblyKMWu
         siA1qyVPnQvMCv9GlLgK7vz0LQD6qooyQ8lE0cFUsyW8vQBhTLuZJzqLBbgkX5URvWn+
         bC1Q==
X-Gm-Message-State: AC+VfDyKW555JCTotPrAlOEx3CVPDzTBbtHQJ7ZtXj/KyID11D1DKteC
        GIs/c4E9qlev54gPVeWN6btKnvyTrmithS5K+EE67Q==
X-Google-Smtp-Source: ACHHUZ5n/AJMMUO8b5T/oUyTb6DVv1jOQOHEMqFxc9Nvtl/RyoTr8Wag0GSpc+UHJbfjFo4oC6sUSKNNzLojrRdQK30=
X-Received: by 2002:a17:903:2301:b0:1af:e5e0:a33e with SMTP id
 d1-20020a170903230100b001afe5e0a33emr1581037plh.7.1687801099715; Mon, 26 Jun
 2023 10:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230623043107.4077510-1-irogers@google.com> <64741e8e-e81a-afb9-9ce3-9c2d6baab44a@web.de>
 <CAP-5=fVwhiGJEqTST2bfX8cUALpnTxELSHrvKtyJEPjqQjOacQ@mail.gmail.com> <35569055-0873-4d5d-8c9c-78c818e9aa26@moroto.mountain>
In-Reply-To: <35569055-0873-4d5d-8c9c-78c818e9aa26@moroto.mountain>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 26 Jun 2023 10:38:07 -0700
Message-ID: <CAP-5=fWDnLDox3apMmvXmzVurFA=+sj7SEOOD7_2fam2VrGokA@mail.gmail.com>
Subject: Re: [PATCH v2] perf unwind: Fix map reference counts
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 26, 2023 at 5:42=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Jun 23, 2023 at 10:49:36AM -0700, Ian Rogers wrote:
> > >
> > > How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?
> >
> > In general we've not been adding Fixes as there is a danger a backport
> > will introduce a use-after-free.
>
> I feel like we have been discussing issues around Perf backports
> recently.  Wasn't there some build breakage that wasn't detected?  Why
> not just ask Sasha to leave perf out of the -stable tree?
>
> Also Sasha has a tag to explain that patch AAA is included because
> patch BBB depends on it.  I feel like maybe those tags are backwards,
> it would be nicer to tag AAA as depending on BBB.  That way we could
> add the dependency tags here.
>
> I think at Linaro we have recently been testing taking the latest Perf
> tools and using them on older kernels.  I don't know the details around
> why we can't just use the perf that ships with the kernel...

Using the perf tool that ships with the kernel should be fine but the
perf tool is backward compatible with older kernels. There are new
features, such as using BPF for kernel lock analysis, that are
available in the latest perf tool and so it could be nice to have
these available/tested on older kernels.

> To tell the truth, I also don't really understand the problem for this
> patch specifically. From what I can see, the Fixes tag would have been:
>
> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")

No, the issue is fixing a long standing problem in the perf tool where
reference counting has been broken. We have implemented a poor man's
RAII using leak analysis and these patches stem from that, but the
errant code pre-dates it. Fwiw, more details on the reference count
checker is here:
https://perf.wiki.kernel.org/index.php/Reference_Count_Checking

> 1) Adding a Fixes tag would have automatically prevented any backports.
> 2) I don't see any possible use after frees.  That probably means I have
> identified the wrong Fixes tag?

You'd need tests that stress libunwind unwinding, such as "perf top
-g". Prior to the reference count checker work the code contained
unnecessary gets to avoid lowering reference counts and causing
use-after-free (a memory leak considered less bad than crashing). By
backporting the code you are taking part of the fix and potentially
creating a new problem.

Thanks,
Ian

> I'm not going to dig further than that because I don't care.  I'm just
> looking at it because Markus added kernel-janitors to the CC list.  But
> for subsystems where I'm more involved then I always look at how a bug
> is introduced.  That information is essential to me as a reviewer.  So
> if I'm writing a patch and even if it's not a bug fix but let's say it
> deletes dead code then I often include include the information under the
> --- cut off line.
>
> ---
> This dead code was introduced by commit 23423423 ("blah blah blah").
>
> regards,
> dan carpenter
