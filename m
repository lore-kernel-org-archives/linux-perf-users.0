Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C00C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 May 2022 21:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiEWV3p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 May 2022 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiEWV3o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 May 2022 17:29:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D65A204C
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 14:29:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h205-20020a1c21d6000000b003972dda143eso318546wmh.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n5D4eoLrBsXPNV9vayceC9y7nrJtuDnRalRRWAgWsFk=;
        b=Qj+VqH1Vcc263/TdOV3boTN4O0P66QIQ55KIMv9gdLgjmmnLVBQ2IwJqFEv0B8K3np
         /rj2bddpL23lgef/3qXFFKsrc7msMUj6QtsxJvEA8e5U4JG/77eDoJuqmK9tYI4XBBS8
         oKklxq86iL9YuMNA7JfFkq9SveRDVSn1PY/7ZsDERlGlm2zvw4ijT7FIypeX6TSoHpGp
         hJkqeri5LpVJ7y0wfLpUQtd2lHKFPRDRwBk/tIQPc4bLQIkBcUjp96vyoKXaak0cPY/r
         h9yRG6HPp1xWsQQVyQ4aDNNLdAlK+kt3zi5gDLFuJUOVd/14o70c1RZ396eXRd3wKogN
         VG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n5D4eoLrBsXPNV9vayceC9y7nrJtuDnRalRRWAgWsFk=;
        b=EuZ7qnVQD0RdHL8NRDDc6HHuyXnQqGxfd9Y8l2r9/MuAdKDqlMCAUvxqlByaDgQyKt
         cu2k1+UxhpEGojmQ5M6ff1Kl7rKFN5rJYWNeoTfMIMV8HWDi7gYLiXYv9fAfswZsApCw
         FkCWV7RKrNc24+vKtWFH88FpZbt4L/DH8lIPs9aBWoLFcB7KhdN/pW3N/eYJFfSGVLXy
         HmBCx+NpPPlCen2EQKekQ4nJL0H/wSgOSTU97hl3LJ6ToTH+TwpJq8ylKyHLB6LKvAAb
         /D2kN6SgLXUH+cnlfCOIpIf7Te5vddCbrPBXxQT2KGYouUo6pGqfz8E2TGX//DrZ4sSd
         k5qQ==
X-Gm-Message-State: AOAM5334UOhko0CemjEj1YnAm/kZT5nfWUsEccxCisMBBaSrsFMwRJIH
        rc9HgSoo3G0/MF5MPIPiaXgAsNBhHQTJNcO/PivtCQ==
X-Google-Smtp-Source: ABdhPJy4Ye82XHhKGNUUjs10t7zCMA6rFt+ZY+zoUL0fc0QRnIyZZVtQFsa5RZb/9bdL26OX1wVyPCcC5faF0x3mcto=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr834144wme.67.1653341381709; Mon, 23 May
 2022 14:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220523144952.364370-1-german.gomez@arm.com> <Yovo33Qh7eE7pTn1@kernel.org>
In-Reply-To: <Yovo33Qh7eE7pTn1@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 May 2022 14:29:28 -0700
Message-ID: <CAP-5=fVKcL5icCEaRRZT8Lh02=OsptJtaAk9JojwHNdyqcjvkw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] perf test cs-etm: Add end-to-end tests for
 CoreSight decoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, james.clark@arm.com,
        leo.yan@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 23, 2022 at 1:05 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, May 23, 2022 at 03:49:51PM +0100, German Gomez escreveu:
> > Hi
> >
> > While discussing running more tests for CoreSight, we thought it might
> > be a good idea to upstream some EndToEnd tests for CoreSight decoding i=
n
> > order to lock down the behaviour. I am sending this as RFC to get some
> > feedback from the community first.
> >
> > The test relies on pre-geneated perf.data files that are downloaded
> > during the test. I'm not sure it's a good idea to commit those files to
> > the Linux repository, so they would have to live in an external source
> > and be downloaded during the test.
>
> That is ok, but please cache it locally, so that from the second 'perf
> test' run onwards one doesn=C2=B4t have to incur in the download delay an=
d
> also be able to run the tests while not connected.

I have some continuous tests running that don't have internet access.
Could we have an environment variable to give a path to an already
downloaded version? I may be able to fake having a cached downloaded
version. Where would such a download live?

Thanks,
Ian

> - Arnaldo
>
> > For this RFC, the files are stored in a Github repository [1]. As an
> > idea, I think we could store them in a new repo in the ARM-software
> > namespace. Any hosting suggestions are very welcome.
> >
> > Thanks,
> > German
> >
> > [1] https://github.com/ARM-software/data/tree/984cde8fb0bb22591e284826a=
80b338bb79c3655/perf/coresight
> >
> > German Gomez (1):
> >   perf test cs-etm: Add end-to-end tests for CoreSight decoding
> >
> >  tools/perf/tests/shell/lib/arm_auxtrace.sh    | 21 +++++++
> >  .../tests/shell/test_arm_coresight_decoder.sh | 57 +++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/lib/arm_auxtrace.sh
> >  create mode 100755 tools/perf/tests/shell/test_arm_coresight_decoder.s=
h
> >
> > --
> > 2.25.1
>
> --
>
> - Arnaldo
