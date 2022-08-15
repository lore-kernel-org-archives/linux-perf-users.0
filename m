Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F3DC25B06
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Aug 2022 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiHOO45 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiHOO4w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Aug 2022 10:56:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254120F6E
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 07:56:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so9328430wrp.10
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SNEwN3qf4cTPak4P3uJkYoBDFHuw13WWi+vOH5Zd4Ac=;
        b=c2TeqN6ajJt/R05lUrbaU/cW8aitjSNIIkCewNDl9j/5olXm2dAggQ54HiQFhIB8xS
         1ysjI8wb6P7OKswHBtc5qRHgXGxD5U1N3Lq2ahjJYLVjKcVtLLiadcyNH/srISGGBO8+
         3BCm9zqYR3CXLNeOGkg6aeBVRQ3Srveh6jLH0jNLmUbfxcsR5AizhVzcoCQdKYKcBCt5
         Ir9452ZyBgHg8qj0k4zMJ1Bk2GZsxUT8+XHyYwZWz7Ia5CwCyQ1bjkDYzOOZ0bm4LtaS
         aPBFWV3AKAmFuEJxPj4JSKanWag4vyc3FqbGTpPICfePrxdbII1Xv/KNA+6DN5wMT7Px
         sSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SNEwN3qf4cTPak4P3uJkYoBDFHuw13WWi+vOH5Zd4Ac=;
        b=SJJ4tES/KQAuNvYqKC8woaeyazXW2iT0YU8ComrSHtEwNlQbHsEc+BogfXpQhsQ4Mj
         bBAcL7QGhvoQhuPdfE6tv5ZWaGg9ZJbMxTdC6qX4IoA71O3GN9Cb/MORx5PAFOsNyJaq
         mFn6DhBaWg2hxW/HiI0UANqR7ep4Pazwwbv7/e4JNq0mxjv6t1QReA4enVU8k+OisgKC
         zjB8nyUiLZLu5relIKvtTCCIIf+kjcFzdwLwB4diA7BMFNJlV/Vj7FGOPnHMINl6tLTW
         PNzgs3x6mQ9SkKR0tGbyFUwr6HxitBpHGdYHmpgRLsP4JuS7MTGCsqm0GBSXY3gSTqEZ
         rsSw==
X-Gm-Message-State: ACgBeo1EUAYz4dA8UYqEe7mxzrtqX85zd1k/dmC8tsNLyvZSqda0zsF/
        Gq7qrxS2jPwtCt25pwCRPcgVb0GX5Mh1mUL2fWfPpw==
X-Google-Smtp-Source: AA6agR4wiUckDTDALcDEn5Dgm86gur7YVyasP8WtZkwG8dhPc2lAvm+1sKa+ebt8tKnqTv0xrMMcQVySwm4DVH24oNU=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr8679323wri.300.1660575406510; Mon, 15
 Aug 2022 07:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
In-Reply-To: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 Aug 2022 07:56:34 -0700
Message-ID: <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> I notice man pages on man7.org e.g.
>
>         https://www.man7.org/linux/man-pages/man1/perf.1.html
>
> do not get updated every release, and I wondered if the perf tools
> man pages should also be under:
>
>         https://docs.kernel.org/tools/index.html
>
> Thoughts?

Sounds good to me. I'm assuming it would be some kind of build step
that would take the man pages and add them to what linux-doc needs?

Fwiw, there has been some effort to try to improve the wiki:
https://perf.wiki.kernel.org/index.php/Main_Page
For example, the useful links are now broken apart and have more
links, there is a work-in-progress glossary. Perhaps there can be some
guidance on what to capture and where.

Thanks,
Ian

> Regards
> Adrian
