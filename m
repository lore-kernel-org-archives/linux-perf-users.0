Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C027C3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 17:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjHYRIM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbjHYRHn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 13:07:43 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536741FFE;
        Fri, 25 Aug 2023 10:07:40 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-48d165bd108so451380e0c.0;
        Fri, 25 Aug 2023 10:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692983259; x=1693588059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1tb0geUFc8vx6LoGbp7WpYKxucMfBPgZmEVnQBECGM=;
        b=WPtfGQZFGqevpbmAXqvNyRtzskR4NehZGTJGGoVbAVCkomgnsMnfo/c0lQU3UPMZMP
         7TTEMjG2l5ZpLzrBMAnl/QbrwiSbCLs7vGcw+NHuLScyTbMR5yDKDSAl2rG9ElrM4d1Y
         jKP/pyDJn3I2m8Ma4ZM5Ip2Ul4di3jZKUoMQJd7801ewaIz+bNpR3SEdwnuMDOqPouFS
         vr4DLZcyokHilrbJx/eMTjSvlkzg4D/ehSt74oEEiV/ATHZ2bT9mVFygqLOeqmQ+a/OC
         xKaLhWUMfhagUx++m8LubNCHwO7zNyKr40kb3FKiUoccbm9nhkEEN1XX7ZCwRrK6uR/w
         hM1g==
X-Gm-Message-State: AOJu0YwObJECZHyHVZ6QJWCEnsTHLmuXa6VyagOzkUQxxF6t7Tv8yDCb
        kCiEBPUMqP8PE5rehXnTUi+EWHnGttXDTkEAadk=
X-Google-Smtp-Source: AGHT+IHHMQTF6wZqahiLTvUCQVLIE1slzY2m3zzfelSbCQPBO+HE+MRoryx8Bb0jAzcfqavyslqZxq3UpUHf5i3RGEo=
X-Received: by 2002:a1f:ca83:0:b0:48f:af58:b160 with SMTP id
 a125-20020a1fca83000000b0048faf58b160mr7443301vkg.9.1692983259107; Fri, 25
 Aug 2023 10:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230825061125.24312-1-adityag@linux.ibm.com>
In-Reply-To: <20230825061125.24312-1-adityag@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 25 Aug 2023 10:07:28 -0700
Message-ID: <CAM9d7cgBJ1WHRuVcZ4FArm=pctbs-npLB2Q8PLZWmdfaK3dCzg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Introduce perf build subcommand
To:     Aditya Gupta <adityag@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Thu, Aug 24, 2023 at 11:11 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> The Problem
> ===========
>
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>
>     perf version --build-options | grep " on .* HAVE_FEATURE"
>
> Proposed solution
> =================
>
> As suggested by contributors in:
> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
>
> Introduce a subcommand "perf build --has", with which
> scripts can test for presence of a feature, such as:
>
>     perf build --has HAVE_FEATURE
>
> The usage of "perf version --build-options | grep" has been replaced in two
> tests, with "perf build --has" command

I'm not sure 'perf build' is a good name, it sounds like it needs to build
something.  Maybe 'perf check --feature XXX' ?

Then we can extend the perf check command to *check* system
settings like perf_event_paranoid, kptr_restrict, nmi_watchdog
and so on, and possibly provides some advice or even change
the values easily.

What do you think?

Thanks,
Namhyung


>
> Also, to not duplicate the same feature list at multiple places, a new global
> 'supported_features' array has been introduced in builtin.h, so both commands
> 'perf build --has' and 'perf version --build-options' use the same array
>
> 'supported_features' feature is an array of 'struct feature_support', which
> also has the name of the feature, macro used to test it's presence, and a
> is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
>
> Architectures Tested
> ====================
> * x86_64
> * ppc64le
>
> Git tree
> ========
>
> Git tree with this patch series applied for testing:
> https://github.com/adi-g15-ibm/linux/tree/perf-build-has
>
> Aditya Gupta (3):
>   perf build: introduce build subcommand
>   perf version: update --build-options to use 'supported_features' array
>   perf tests task_analyzer: check perf build for libtraceevent support
>
> Athira Rajeev (1):
>   tools/perf/tests: Update probe_vfs_getname.sh script to use perf build
>     --has
>
>  tools/perf/Build                              |  1 +
>  tools/perf/builtin-build.c                    | 94 +++++++++++++++++++
>  tools/perf/builtin-version.c                  | 39 ++------
>  tools/perf/builtin.h                          | 47 ++++++++++
>  tools/perf/perf.c                             |  1 +
>  .../perf/tests/shell/lib/probe_vfs_getname.sh |  4 +-
>  .../shell/record+probe_libc_inet_pton.sh      |  5 +-
>  .../shell/record+script_probe_vfs_getname.sh  |  5 +-
>  tools/perf/tests/shell/test_task_analyzer.sh  |  4 +-
>  9 files changed, 163 insertions(+), 37 deletions(-)
>  create mode 100644 tools/perf/builtin-build.c
>
> --
> 2.41.0
>
