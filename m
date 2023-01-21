Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE4BC004D4
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Jan 2023 17:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjAURyI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Jan 2023 12:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjAURyH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Jan 2023 12:54:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CA252A1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Jan 2023 09:54:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l8so6239007wms.3
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Jan 2023 09:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e+XTeR27qU4Z1bYsWfJyKy77EFMyC9xXES37vb4VMzs=;
        b=XgEyXn6gyUZ+grBUqR3Mnvh6rJ0YOqP26TsvfmzL4dJQxN4JVN9ay3CEeFGL5tcWK1
         MjB+8ZfpUBJx/HsIv6+W2Coz6Ltm/Rpj7LKP06caKOborx9XPnypAnZot2z6ONbuo2CY
         xNt2xF3+ff2jO2b0JwxxF44uj8D2tt8WC/edgYK3EESFyXNUBL+LGyUebYBurkjZ1/1w
         3Uj3vGRaZgerGgrZeuJaVli2nqHB2GyiIdOtpjKCq4NnmgIQ1QKgmF6hYRyspNuX8dOX
         PW0abVuYbnqoQM8BZ2P4/mhWOejNkp985pY4pTIbU8lkXfvs1mK3DY2AL0bBNqyfb1J0
         fyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+XTeR27qU4Z1bYsWfJyKy77EFMyC9xXES37vb4VMzs=;
        b=LW4pp73OFrr4jubOhMd4KcJFJNfEpcC/u9zV+meXJl8IkLlnOZctP2y/n2xgpPiPpv
         T/ns1xk9m9HrjmGq46FtSPCQHgMkwWvugSPBeVXr7ar69MMnJ5LD0U+wr/QYtPeKh92i
         GRBRInm6xv7bbEE6fwBPl09OO9bTmFP4khqj7XoPEw/7gQpoUz6a7A99hFsbsQR8CYkL
         9GGiLlBX7/akXGATUE5Nq2Lvy9HfPOMc9VUZ564icQjQb3qezjsD52yA5zEl+BO6pLul
         oEdIMOWzGBKirZZ+kR9kjLDSgsnRftUb29i1fZrlnlCM3WZIlQezYS36STIvrZqhTGqx
         X9RQ==
X-Gm-Message-State: AFqh2kr1zpB5YhVdfwWT6TJSCSuC3waZyu2PiKbh2W7Hv4lQgtfpeBj/
        rpJeC0WLe0ur2IDUOcu+qZM0kOvvxtehniebCYP/BgLl+J0O65Ef
X-Google-Smtp-Source: AMrXdXvumznX0IJWX+6wVNOQuRANyu8tvnYD0KInYoEu8z+rzrY4jS9f7iFeI09k2JiFBPQvSbSL15tf2/bO139+3Qs=
X-Received: by 2002:a1c:7404:0:b0:3da:b40f:c734 with SMTP id
 p4-20020a1c7404000000b003dab40fc734mr1555607wmc.115.1674323645209; Sat, 21
 Jan 2023 09:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20230120123456.12449-1-adrian.hunter@intel.com>
In-Reply-To: <20230120123456.12449-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 21 Jan 2023 09:53:53 -0800
Message-ID: <CAP-5=fUwkghLbz7O4peCSMbt2LjAtUwi+tB3_wgnZrjkg9jn9w@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf symbols: Improve dso__synthesize_plt_symbols()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 20, 2023 at 4:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> This is the first of 2 patchsets to improve dso__synthesize_plt_symbols().
> This patchset is really preparation for the 2nd patchset, which focuses
> on getting rid of unknown symbols that show up in Intel PT traces.
> The 2nd patchset is still under development.
>
> These patches are small and staightforward. Only the new Symbols test is
> slightly interesting because it provides a way to see what symbols
> perf discovers for any given dso. The test fails initially, but
> should pass after patch 7 "perf symbols: Add symbol for .plt header".
>
>
> Adrian Hunter (10):
>       perf test: Add Symbols test
>       perf symbols: Factor out get_plt_sizes()
>       perf symbols: Check plt_entry_size is not zero
>       perf symbols: Add dso__find_symbol_nocache()
>       perf symbols: Slightly simplify 'err' usage in dso__synthesize_plt_symbols()
>       perf symbols: Do not check ss->dynsym twice
>       perf symbols: Add symbol for .plt header
>       perf symbols: Allow for .plt entries with no symbol
>       perf symbols: Combine handling for SHT_RELA and SHT_REL
>       perf symbols: Check SHT_RELA and SHT_REL type earlier

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/Documentation/perf-test.txt |   3 +
>  tools/perf/tests/Build                 |   1 +
>  tools/perf/tests/builtin-test.c        |   3 +
>  tools/perf/tests/symbols.c             | 150 ++++++++++++++++++++++++++
>  tools/perf/tests/tests.h               |   3 +
>  tools/perf/util/symbol-elf.c           | 190 +++++++++++++++++----------------
>  tools/perf/util/symbol.c               |   5 +
>  tools/perf/util/symbol.h               |   1 +
>  8 files changed, 262 insertions(+), 94 deletions(-)
>  create mode 100644 tools/perf/tests/symbols.c
>
>
> Regards
> Adrian
