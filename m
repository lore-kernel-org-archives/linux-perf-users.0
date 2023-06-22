Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C2EB64D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 18:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFVS5l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjFVS5l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 14:57:41 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C2A2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 11:57:40 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bcde2b13fe2so7290417276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687460259; x=1690052259;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MvmTjnIu2S+sLoo1DauiYgLla8jnxFoFuKuikSeRVV8=;
        b=an9VzTlZ+cePg9EAsJL8IklXlBq9F625yyXj76FQFbG4EcojJZVgRyFIMkDvCRyUn0
         bdEPGMD4NND5xE7BnP4aye/hrJasOUtPYhwwQdBkvKkf30QSm8syxvEf/iTYDO+Be7cC
         x9iWJwdmxnvmKru+/1goAJjo7hqDgPUA8I6OC/8Lzr1K9yMN7o0xKbvuDgZeOFqYNu12
         KLY1kItR7mz7qqX9PRMQbQUnNzrc6gu16g3c77ExEG1gD0Wnzma5Kizc8C0XMo0Ly4yx
         D7bjP4StbtQbvvZmi0wkArbyo7CrzGgl4AtWBGIJuG5qGBnaxrqiuDTb6mFxk2sgTbwt
         W+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460259; x=1690052259;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvmTjnIu2S+sLoo1DauiYgLla8jnxFoFuKuikSeRVV8=;
        b=TTPrZTiAaHY//brBWPouEfiPg32PEvfgRSRhL41eL+xjpz095ZVngxyxyStCQ269HO
         DQ/rQsD/bivw97IzCteBBRZj3naHrIYWwIXaSOVLuK9QVVZZNCrUYiBEVNvw7gOeKBSY
         +xKZQJXN6Bp6yBwS3/dOIaeLA6W/Qf9I6zT0ILn/eYMF+e60E6s9TLo3briKfBJBn+tv
         THdtmk0RK+ZhJJbZO3O5meyxVGFybCb58+SCR89qCAngUvFWMKsaQ9Xy6QMiguifohZh
         w2VFiZWyju60fhMzy/CH+xzH+w3ZAAgAsy/R+/jY8O4ieWrcBdfeWjrTFxiQqLF2r8lr
         2MYA==
X-Gm-Message-State: AC+VfDzVYvSxlyMr11u4kQaFkm2hXj+vmMAEnuZu7ywruy/euSKheWVO
        qqku6WXDdPLQU/s5mDQH10pVCAtbLB/hVONbmow=
X-Google-Smtp-Source: ACHHUZ5geYHqUz5a/U/cLIslQ7SIpX25m+Rvh5SVhoRdNs2ZhuTGjv2lsOfkuBscEZFDa0fXky3YICS0UDqqshhaB4k=
X-Received: by 2002:a25:b102:0:b0:bcd:1e83:2467 with SMTP id
 g2-20020a25b102000000b00bcd1e832467mr15267706ybj.33.1687460259402; Thu, 22
 Jun 2023 11:57:39 -0700 (PDT)
MIME-Version: 1.0
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 22 Jun 2023 11:57:28 -0700
Message-ID: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
Subject: perf-tools-next: Request for testing hybrid changes
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

In this development cycle, we've got a big change in how to handle
heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
but caused some troubles on others.  So I'd like to confirm it works
on major platforms without problems.  Especially on ARM64 as it has
the big.LITTLE CPUs.

Also we are transitioning from Arnaldo's tree to new repositories in
git.kernel.org:

 * kernel/git/perf/perf-tools (for the fixes on the current dev cycle)
 * kernel/git/perf/perf-tools-next (for new features for the next cycle)

There is a branch with the same name.  Please check out
perf-tools-next and play with it.

Thanks,
Namhyung
