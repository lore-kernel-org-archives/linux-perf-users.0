Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B21AC77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDMPe0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDMPeZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 11:34:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486B7687
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 08:34:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso104575e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681400062; x=1683992062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBoFGeIEOT1PxZhkmOh+OFjHzEzluv7Taz9YMgMqtK0=;
        b=g6Ot1AVQcwWRkKk+yhF75otVIioqnrkJkkxbFlj/0LiSw+CP+pGZU+BlviUfbbrGDT
         nslY+e3b1qz+oFMaCCjrCy6fB3vE+W3GilyAi0K7/MsWcXnlqvrRVaXPA4Q8HO7RyRtY
         6OzO2VWjc3xJc1tRebaTvI/twJKbZmLGDPapvYc77uwJqv+40B1JAGmPXls95PS6OhB4
         r8ThWJJ4XYNJeATFDa+gVFJpxfe80itVyva4TgRilcMYfI6N43nwrDPwPht3zzE5hFUy
         Kk2Bsi/ux78rEUqH9/O4Ol/W2QnI1RGmYhECIwej/8VKiqnREnr2J+aCHPxsgX9gqla1
         0VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400062; x=1683992062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBoFGeIEOT1PxZhkmOh+OFjHzEzluv7Taz9YMgMqtK0=;
        b=FvWUGotMONN3+UQwqbXMf81VyTWVzC/+vRH4Y5en7WXal9H5FFX596ejGFJ8DKKreu
         vXUtUzvaUxV6z/piGHwDoMJ7EhEVdnPhcHg/uQxP/r6HQQmbmO6HCgGg1oyx4d6NNIJI
         Fcm8uW6Rb1c/zX5RCFWaSjGI8E+WYd8bKORJx/7YAXn7GQAlkQkZq+/oOZD/pjhSycYZ
         aqsI16y7ZCkHI9C0PaJPpK9HIAjjsIjDGzMKDZ2CP7ZbKDGdTxUplHrvDcA66CesxwtL
         Df55kjsFpC7s6L7ydspKR5BvINBatUlKTIWAf8f4Yx7uWyNDUstgzPwMrPPBsPfX71Ts
         eB9w==
X-Gm-Message-State: AAQBX9d/HyKgprXCkg/wuNpRQElbmw2xIIA0BcsxX+SHtjBIukPk1DwG
        3plM75ByEKOB3SCHRC60yHlm7T9lJm4bcJ+hhsEDTw==
X-Google-Smtp-Source: AKy350Y+wHHwiy1487IlSLgK7VINHtD8nYIPbN2Rg84cWM5WGH4tliaAwP2uLrji81hrSAN0Nvchz8fTKCT0Hmo1yzY=
X-Received: by 2002:a05:600c:538d:b0:3e2:1a5e:b13c with SMTP id
 hg13-20020a05600c538d00b003e21a5eb13cmr747434wmb.2.1681400061671; Thu, 13 Apr
 2023 08:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com> <ZDgL1Qca7N+Wilm6@kernel.org>
In-Reply-To: <ZDgL1Qca7N+Wilm6@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Apr 2023 08:34:09 -0700
Message-ID: <CAP-5=fUiQoZCN7iSaqnvqH0V-hYWrA7njUvz7+kj5Zz6S5n40Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] Update uncore topics, 1x event updates, 2x new archs.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 13, 2023 at 7:04=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Apr 13, 2023 at 06:29:28AM -0700, Ian Rogers escreveu:
> > Update the uncore PMUs and topic classification as created by:
> > https://github.com/intel/perfmon/pull/70
> >
> > Event updates stem from:
> > https://github.com/intel/perfmon/pull/68
> > impacting alderlake, icelakex and sapphirerapids.
> >
> > Grand Ridge and Sierra Forest events stem from:
> > https://github.com/intel/perfmon/pull/69
> >
> > Changes generated by with PR70 in place:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> >
> > v3. Rebase over the update of alderlake and icelakex events.
> > v2. Adds improvements to uncore topics, uncore PMU name fixes and
> >     fixes a trigraph issue from ??? being in the json.
>
> b4 isn't liking it:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 202304=
13132949.3487664-1-irogers@google.com
> Grabbing thread from lore.kernel.org/all/20230413132949.3487664-1-irogers=
%40google.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 14 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ERROR: missing [1/21]!
>   =E2=9C=93 [PATCH v3 2/21] perf vendor events intel: Add grandridge
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 3/21] perf vendor events intel: Add sierraforest
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 4/21] perf vendor events intel: Fix uncore topics f=
or alderlake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 5/21] perf vendor events intel: Fix uncore topics f=
or broadwell
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 6/21] perf vendor events intel: Fix uncore topics f=
or broadwellde
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [7/21]!
>   ERROR: missing [8/21]!
>   =E2=9C=93 [PATCH v3 9/21] perf vendor events intel: Fix uncore topics f=
or haswell
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [10/21]!
>   =E2=9C=93 [PATCH v3 11/21] perf vendor events intel: Fix uncore topics =
for icelake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [12/21]!
>   =E2=9C=93 [PATCH v3 13/21] perf vendor events intel: Fix uncore topics =
for ivybridge
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [14/21]!
>   =E2=9C=93 [PATCH v3 15/21] perf vendor events intel: Fix uncore topics =
for jaketown
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 16/21] perf vendor events intel: Fix uncore topics =
for knightslanding
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 17/21] perf vendor events intel: Fix uncore topics =
for sandybridge
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 18/21] perf vendor events intel: Fix uncore topics =
for skylake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [19/21]!
>   ERROR: missing [20/21]!
>   =E2=9C=93 [PATCH v3 21/21] perf vendor events intel: Fix uncore topics =
for tigerlake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> Total patches: 13
> ---
> WARNING: Thread incomplete!
> Cover: ./v3_20230413_irogers_update_uncore_topics_1x_event_updates_2x_new=
_archs.cover
>  Link: https://lore.kernel.org/r/20230413132949.3487664-1-irogers@google.=
com
>  Base: not specified
>        git am ./v3_20230413_irogers_update_uncore_topics_1x_event_updates=
_2x_new_archs.mbx
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
>
> Lemme try to update it to see if it copes... nope:
>
> =E2=AC=A2[acme@toolbox b4]$ git pull
> Updating 041d10b7f628fa08..00303592f25693cb
> Fast-forward
>  b4/__init__.py                                             | 54 ++++++++=
++++++++++++++++++++++++----------------------
>  b4/command.py                                              |  4 ++--
>  b4/ez.py                                                   | 15 ++++++++=
++++---
>  b4/ty.py                                                   | 10 ++++++--=
--
>  docs/config.rst                                            | 19 ++++++++=
+++++++++++
>  man/b4.5                                                   |  6 +++++-
>  man/b4.5.rst                                               |  2 ++
>  tests/samples/trailers-followup-with-cover-ref-addlink.txt | 67 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/test___init__.py                                     |  1 +
>  9 files changed, 146 insertions(+), 32 deletions(-)
>  create mode 100644 tests/samples/trailers-followup-with-cover-ref-addlin=
k.txt
> =E2=AC=A2[acme@toolbox b4]$ git diff
> =E2=AC=A2[acme@toolbox b4]$ cd -
> /var/home/acme/git/perf-tools-next
> =E2=AC=A2[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 202304=
13132949.3487664-1-irogers@google.com
> Grabbing thread from lore.kernel.org/all/20230413132949.3487664-1-irogers=
%40google.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 14 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ERROR: missing [1/21]!
>   =E2=9C=93 [PATCH v3 2/21] perf vendor events intel: Add grandridge
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-3-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 3/21] perf vendor events intel: Add sierraforest
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-4-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 4/21] perf vendor events intel: Fix uncore topics f=
or alderlake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-5-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 5/21] perf vendor events intel: Fix uncore topics f=
or broadwell
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-6-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 6/21] perf vendor events intel: Fix uncore topics f=
or broadwellde
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-7-irogers@go=
ogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [7/21]!
>   ERROR: missing [8/21]!
>   =E2=9C=93 [PATCH v3 9/21] perf vendor events intel: Fix uncore topics f=
or haswell
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-10-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [10/21]!
>   =E2=9C=93 [PATCH v3 11/21] perf vendor events intel: Fix uncore topics =
for icelake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-12-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [12/21]!
>   =E2=9C=93 [PATCH v3 13/21] perf vendor events intel: Fix uncore topics =
for ivybridge
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-14-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [14/21]!
>   =E2=9C=93 [PATCH v3 15/21] perf vendor events intel: Fix uncore topics =
for jaketown
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-16-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 16/21] perf vendor events intel: Fix uncore topics =
for knightslanding
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-17-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 17/21] perf vendor events intel: Fix uncore topics =
for sandybridge
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-18-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   =E2=9C=93 [PATCH v3 18/21] perf vendor events intel: Fix uncore topics =
for skylake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-19-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ERROR: missing [19/21]!
>   ERROR: missing [20/21]!
>   =E2=9C=93 [PATCH v3 21/21] perf vendor events intel: Fix uncore topics =
for tigerlake
>     =E2=9C=93 Signed: DKIM/google.com
>     + Link: https://lore.kernel.org/r/20230413132949.3487664-22-irogers@g=
oogle.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> Total patches: 13
> ---
> WARNING: Thread incomplete!
> Cover: ./v3_20230413_irogers_update_uncore_topics_1x_event_updates_2x_new=
_archs.cover
>  Link: https://lore.kernel.org/r/20230413132949.3487664-1-irogers@google.=
com
>  Base: not specified
>        git am ./v3_20230413_irogers_update_uncore_topics_1x_event_updates=
_2x_new_archs.mbx
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>

Apologies for this. I think it is some size related LKML thing. All
the missing patches are > 0.5MB:

  11438  v3-0000-cover-letter.patch
1176292  v3-0001-perf-vendor-events-intel-Update-sapphirerapids-to.patch
 19044  v3-0002-perf-vendor-events-intel-Add-grandridge.patch
 19106  v3-0003-perf-vendor-events-intel-Add-sierraforest.patch
 11481  v3-0004-perf-vendor-events-intel-Fix-uncore-topics-for-al.patch
 12384  v3-0005-perf-vendor-events-intel-Fix-uncore-topics-for-br.patch
152976  v3-0006-perf-vendor-events-intel-Fix-uncore-topics-for-br.patch
720813  v3-0007-perf-vendor-events-intel-Fix-uncore-topics-for-br.patch
2415854  v3-0008-perf-vendor-events-intel-Fix-uncore-topics-for-ca.patch
 13924  v3-0009-perf-vendor-events-intel-Fix-uncore-topics-for-ha.patch
710442  v3-0010-perf-vendor-events-intel-Fix-uncore-topics-for-ha.patch
  8000  v3-0011-perf-vendor-events-intel-Fix-uncore-topics-for-ic.patch
3660614  v3-0012-perf-vendor-events-intel-Fix-uncore-topics-for-ic.patch
  8662  v3-0013-perf-vendor-events-intel-Fix-uncore-topics-for-iv.patch
516723  v3-0014-perf-vendor-events-intel-Fix-uncore-topics-for-iv.patch
299475  v3-0015-perf-vendor-events-intel-Fix-uncore-topics-for-ja.patch
 23644  v3-0016-perf-vendor-events-intel-Fix-uncore-topics-for-kn.patch
  8682  v3-0017-perf-vendor-events-intel-Fix-uncore-topics-for-sa.patch
 11676  v3-0018-perf-vendor-events-intel-Fix-uncore-topics-for-sk.patch
2398312  v3-0019-perf-vendor-events-intel-Fix-uncore-topics-for-sk.patch
2378858  v3-0020-perf-vendor-events-intel-Fix-uncore-topics-for-sn.patch
  8352  v3-0021-perf-vendor-events-intel-Fix-uncore-topics-for-ti.patch

I also see them missing on lore:
https://lore.kernel.org/lkml/20230413132949.3487664-1-irogers@google.com/

Hopefully somebody just needs to allow the patches through onto LKML.

Thanks,
Ian
