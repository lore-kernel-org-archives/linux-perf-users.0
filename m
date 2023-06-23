Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C1EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 18:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjFWSEn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFWSEm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 14:04:42 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC2E41;
        Fri, 23 Jun 2023 11:04:41 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bd6446528dcso748536276.2;
        Fri, 23 Jun 2023 11:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543481; x=1690135481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar+uO6yezPNwOzdQCCX6gm90eaUsHJCjNZcc1B0Jesk=;
        b=ATE45xm3TGRH1l1RQ9LiBgbSmlPmilPEr//pY720/Ebh6RmfS5grXgGeD8FpKyTM9R
         vgeTAQt88dHxd46ajKdlGsfFuL8Hk2gFwb+EgjpQ6fJg7aWjF+0U/2rF76PLAlkkSvc2
         /6fqFcqZ9VHMETknHCjlOHHo6oCCGvOven37nedD3ujoAl3UblPcg7OFydOgbBrK2gBI
         j7D2mzseRTEYcMprf3QX1G/QgqxyhhF4nhpMSazTlGb231hOAlC2fAGYJ4eHJKrL+SS0
         fbkwLuhmeFWOK1eauApLAUg1CDbxR019JKmpQPFA8eTWAczVSH4PXbKgERt8Hx2mLxyu
         3Qyw==
X-Gm-Message-State: AC+VfDx4aepZ0W4Zt264R3w0qhL/WZJSL40OOpoGIY4D0WJqOjuk4EJI
        c1CZu8hRjTvlaR+jn/emDf2FFs1eCkrkOfTJG7w=
X-Google-Smtp-Source: ACHHUZ7dnGL2XWnXJZM0y5FLeqA+/+ykJlNBJXG7O4MPk58el2BrnXMXBwXw/t1Kk5sFy55F1aUcXpsgWoyWEIdvVTk=
X-Received: by 2002:a25:b1a3:0:b0:bca:531d:dcde with SMTP id
 h35-20020a25b1a3000000b00bca531ddcdemr17325380ybj.30.1687543480780; Fri, 23
 Jun 2023 11:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230623043843.4080180-1-irogers@google.com>
In-Reply-To: <20230623043843.4080180-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 11:04:29 -0700
Message-ID: <CAM9d7cgkNzJ-18F3cg2hP+x5ME0duVKtBhsBJ_Zs-6hC4mi4jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf pmus: Add notion of default PMU for JSON events
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 22, 2023 at 9:38 PM Ian Rogers <irogers@google.com> wrote:
>
> JSON events created in pmu-events.c by jevents.py may not specify a
> PMU they are associated with, in which case it is implied that it is
> the first core PMU. Care is needed to select this for regular 'cpu',
> s390 'cpum_cf' and ARMs many names as at the point the name is first
> needed the core PMUs list hasn't been initialized. Add a helper in
> perf_pmus to create this value, in the worst case by scanning sysfs.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>
> v2. Add missing close if fdopendir fails.

Applied both to perf-tools-next after moving this v2 line, thanks!
