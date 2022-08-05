Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC8CC00140
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Aug 2022 22:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiHEWjf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiHEWje (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Aug 2022 18:39:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76871AF1D
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Aug 2022 15:39:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso2295673wmc.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Aug 2022 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a4+alUb2V+A+FrnxdAfx95t0xsifhWlq+vFrSrgmIiw=;
        b=GLKZ3acW7kyjSzl8FTgV7hTdmon7BqyPQJ9gE7JaEMFcR609IsISTVm1E2MPaaMOB2
         bDT5IiITAqvcb/od/wDtbLYaiCF/q/CPhQqI0eAhe7tVfC73sI/hqY8ewv2ZZH4iDNy/
         +q2EycnykKC1/E91JFv9KG312V+rrS9wpRWbr0H+Aai1ctTHKe6hViIDegmpPOL0fDOg
         fC0hM154DKNYySj7EEkhzp1no6yVpdNJ1t4EKTw0sY0+WwOVnpx/9SvppwkVxg9pIC7Q
         Q/U66K4J+HOeN3qfrYlHQbVGyhRsbW4PmPRoiEz4/b61aG2N4Cuzpab/ab9XCTfIeI7Y
         CfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a4+alUb2V+A+FrnxdAfx95t0xsifhWlq+vFrSrgmIiw=;
        b=fUruy6dI1z4Jt2rXcptNpqdSCdnozwwqqvZtjmZT40043Mwtymhy2MrJ+mfa2mOt7O
         ARmqWJLksggaTpx0uyl6pP9E0db6ytZUSO2qJirvf52K992/13P9iWHETmQJEF51umiS
         YZEhmAEnhObE5fXE5sJNDiYREih2enkFd4rx1D1vVxFCtgqOL3Bpqs3VC0ZmKwiEpsB7
         zDDGe/iFu6kY4KUM7OX5zmvbXJgX6L33JcLMnJb1QlRIkRDmvvAr1j8D6nziEzP3x7IC
         a7mJgzD4cqJTXPMPZHvF3DGsp/rkU2Wxu8k0e7OMqNM/A0t81S35PJmZd0ckaohRbtso
         CyvA==
X-Gm-Message-State: ACgBeo0sG+Q4c1eiQ/y74EVP1bqGta0q1lwloV51wD7Jx/jo3BQHsNyP
        BPhqLGHow1CZroJasaY5hik6r/JAKTzCaZxHiJprdA==
X-Google-Smtp-Source: AA6agR7AHekHXLe5no7RXaVKXf0rP2CNhnvxhSm2gC5BYXCEhjXzSalxmhI9FqE9JMTUwofhlW4WId6korNGY+Dg5C4=
X-Received: by 2002:a05:600c:4e86:b0:3a3:417a:2fcd with SMTP id
 f6-20020a05600c4e8600b003a3417a2fcdmr6046018wmq.149.1659739172136; Fri, 05
 Aug 2022 15:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220805220645.95855-1-brianrob@linux.microsoft.com>
In-Reply-To: <20220805220645.95855-1-brianrob@linux.microsoft.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 Aug 2022 15:39:20 -0700
Message-ID: <CAP-5=fVhwVcNqr+z+KfUrH1Rq=3sbrkwX3U1nZBbW6_ASVp13w@mail.gmail.com>
Subject: Re: [PATCH v2] perf inject jit: Ignore memfd and anonymous mmap
 events if jitdump present
To:     Brian Robbins <brianrob@linux.microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 5, 2022 at 3:06 PM Brian Robbins
<brianrob@linux.microsoft.com> wrote:
>
> Some processes store jitted code in memfd mappings to avoid having rwx
> mappings.  These processes map the code with a writeable mapping and a
> read-execute mapping.  They write the code using the writeable mapping
> and then unmap the writeable mapping.  All subsequent execution is
> through the read-execute mapping.
>
> perf inject --jit ignores //anon* mappings for each process where a
> jitdump is present because it expects to inject mmap events for each
> jitted code range, and said jitted code ranges will overlap with the
> //anon* mappings.
>
> Ignore /memfd: and [anon:* mappings so that jitted code contained in
> /memfd: and [anon:* mappings is treated the same way as jitted code
> contained in //anon* mappings.
>
> Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/jitdump.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index a23255773c60..4e6632203704 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -845,8 +845,13 @@ jit_process(struct perf_session *session,
>         if (jit_detect(filename, pid, nsi)) {
>                 nsinfo__put(nsi);
>
> -               // Strip //anon* mmaps if we processed a jitdump for this pid
> -               if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
> +               /*
> +                * Strip //anon*, [anon:* and /memfd:* mmaps if we processed a jitdump for this pid
> +                */
> +               if (jit_has_pid(machine, pid) &&
> +                       ((strncmp(filename, "//anon", 6) == 0) ||
> +                        (strncmp(filename, "[anon:", 6) == 0) ||
> +                        (strncmp(filename, "/memfd:", 7) == 0)))
>                         return 1;
>
>                 return 0;
> --
> 2.25.1
>
