Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4064BC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiKQSAA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiKQR77 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 12:59:59 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBE27FC37
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 09:59:58 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id g16so1210571vkl.11
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dCKWOnvjQEJq4tUo9dFNFyCXfgqwWTejP/nifqG4MVw=;
        b=nlzF0FNAIehjAt0d1wDzFKJniOtpT80HzGxTOrWuENTwUSwuTiNQYYp4m/GIvX53No
         LaFZKGirDMSVpPBW/04S0TI0sjkPJveKwj+h0grCPpw0juOLe+BACCONhAMeonw/XVMf
         +zDzSHLkZekfRoEEJWERtMW5xKDz5w7cN+AUpSNeKKJK6L4zeiQnMwdR2nIHWFHaRsE5
         +OFqrymqk1qv4kmny0WrqRprK2zH7fUUOLlumVfgMs2bveD6QKryBUjGg8bGquGDx8zH
         2aji3Mm48AI71Y6OTZyAkhL/nOIu5F8k487ZFNPkGaY7cNJEDeAPSB4xeUfCu2bzmnO3
         BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCKWOnvjQEJq4tUo9dFNFyCXfgqwWTejP/nifqG4MVw=;
        b=L3pcO207pIY/y5iAaklMp9/fFBCxMAxTGeoFbD9qkTei7kUJYxAZbWLXs0hcOrlCvY
         7a4Jcq169QhqgI5pvkNmmD5dQykX9Qmg/6v5CmX8UprZkBc3SQvw1qcZchmiHDgRdw4n
         vCMSPctBr8Ym/TcBNsFU8X4Epuo+s9YrL+S8dpau6drqOuc3PMlSMwE53aGLSlZCLBx3
         VwJ87YiT24XZ4n2/6wkk33W1tdaRBvuSFhi9MAHBTmSNvLaqioGIs68d2+OGbSvkEi7P
         Z7vfWj5ZBnmQRDBscnWDR7oxykN8TmUjSACDjPnUF8c9F6KmburUG1hYsgp5YFGtqQGO
         l8KQ==
X-Gm-Message-State: ANoB5pmaLs4ET+gwHqPgRqhAzeSE7x+jbluxyluRE6Oo82oFMHMr+U7p
        8eurcNFW2b2lwRMaYCRPKcInCWc8tfo4cYza0tzztA==
X-Google-Smtp-Source: AA0mqf51xB7AnO0xFFSDWF/njP75eYwYOkGHnUr/g/pZGGxytCxiRLsm3hLySdFwAlYONeFEXlsQmTIH/EiZgXILVwI=
X-Received: by 2002:a1f:c645:0:b0:3b8:685e:22eb with SMTP id
 w66-20020a1fc645000000b003b8685e22ebmr2034444vkf.33.1668707997105; Thu, 17
 Nov 2022 09:59:57 -0800 (PST)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 09:59:46 -0800
Message-ID: <CAP-5=fWxAjEia-Qbm0RVzKOxyiod8rUOBieqaGK=DtQboDe3Qw@mail.gmail.com>
Subject: Remove traceevent from tools/lib
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Arnaldo raised defaulting BUiLD_BPF_SKEL in the perf tool build:
https://lore.kernel.org/lkml/Y3Yy5DFEoCEBv%2FQi@kernel.org/

The recent build clean up:
https://lore.kernel.org/lkml/20221109184914.1357295-1-irogers@google.com/
https://lore.kernel.org/lkml/20221116224631.207631-1-irogers@google.com/

Means that perf is cleanly(ish) separated from libraries in tools/lib.
traceevent in tools/lib is out of date (~2years - version 1.1.0 whilst
the latest is 1.6.3 [1]) . Should we delete traceevent from tools/lib
and just make LIBTRACEEVENT_DYNAMIC the only supported perf build
option? I guess this may break old distributions that may not have
libtraceevent, but even so I'm not sure that should motivate not
cleaning this up (if they are building perf they can build
libtraceevent).

Thanks,
Ian

[1] https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/Makefile
