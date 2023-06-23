Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AABEB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 18:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFWSAy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFWSAw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 14:00:52 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5621D2710;
        Fri, 23 Jun 2023 11:00:42 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bfe97b3752bso790063276.1;
        Fri, 23 Jun 2023 11:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543241; x=1690135241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZbee8Wrt4IHu56BKlWH9qLpUr7swFliaPouDguQe8A=;
        b=Ac4rAUn1KBRPZG+KGv5vJjnU98oyScav49dhu59mNDw8Q/zri41NmTys521IgBIte+
         9gopcy5m3lAY1XA1NyPNkLfidWRdkRdHRsL9zjFx0bV/XZeU1dpMyB4/Ck8ZYiQ0ydsV
         RTLHi+6YyErv7rhGtlScw3Z/cELVhxFM+veqDX79Juk4xyb1tIpjeVXuKGh2UjkhAJPl
         7Zc52VpzdOsJ5yXGqe+jd3EZLzOqCCVB7z3QTy6HHAqI7iwNFo3dC17dvtokyDjda3/u
         VaY2xweVRh0wx/8HSJxTET2pyhVesFQgrR5R7ZntlIfro9heMxZsUoThGUcy2tEL/NvR
         6NpQ==
X-Gm-Message-State: AC+VfDweVz4zq/YKQwmKLJSxmdfnpNhEcoVcMU9Kl3fY9ExjDDdLwTxI
        h1wXEEwPVfTwMETFpm3NWsP2na34iRqPJA9X5ls=
X-Google-Smtp-Source: ACHHUZ41z34vizvwiSSfkU+v+p7VGIx6uqBh25Dli5GXlHanAkugPcDGZHJ3hDPKtDzbEpU9+CllDsLjAFqnYRebGF8=
X-Received: by 2002:a25:fc28:0:b0:bac:ff9d:dc63 with SMTP id
 v40-20020a25fc28000000b00bacff9ddc63mr18167897ybd.9.1687543241330; Fri, 23
 Jun 2023 11:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230622101809.2431897-1-james.clark@arm.com> <2b1cec46-52a9-21f1-bfcd-fbb4298f072a@web.de>
In-Reply-To: <2b1cec46-52a9-21f1-bfcd-fbb4298f072a@web.de>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 11:00:30 -0700
Message-ID: <CAM9d7ciTZGuoT=D2i+uYG8mcNdFVnYi-Rvue5sbDZAyb24eRrA@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Fix test_arm_callgraph_fp variable expansion
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, spoorts2@in.ibm.com,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 9:56 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> …
> > At the same time silence the shellcheck warning for that line and fix
> > two more shellcheck errors at the end of the script.
>
> Does such a wording really fit to the known requirement “Solve only one problem per patch.”?

Maybe not, but I think it still falls into the shellcheck category.
I don't mind having those trivial fixes together.

Applied to perf-tools-next, thanks!

>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc7#n81
