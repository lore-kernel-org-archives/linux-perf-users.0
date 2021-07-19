Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7537FC07E9D
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C946113A
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbhGSWfI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:35:08 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:33579 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385226AbhGSSwe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 14:52:34 -0400
Received: by mail-lf1-f52.google.com with SMTP id g22so20174910lfu.0;
        Mon, 19 Jul 2021 12:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8F6ulf3Oh3gKHX57xk/lTLRVi9bCHRita1SLlYmKUo=;
        b=Aof+KgD+fDeC35ox94/DXlEK01YjITyBhD4ZOrtSGWsStAcn7Hl5WEemh3Od15tOfx
         BY3GqSD9dPr0A4MumqDpJcilyhOK35wRWB2Q1T8hTshwNVNWjVlaneuJ+9PDDKcWYFul
         dUGQ8WzfrQ1iG1L+DuQ3tikXFDatdgrTO3XrS0Qhmd5Q9KFXKKt1O7gnJMmNw9+ZDKrX
         CpUSvA7PKu3S4mRZziePbMraxenIKTTfBs23mO5ddxFvfYFk88GUHrxAdass35jibpsN
         YDjj7f7wjcE/gEeK69672OQzgQPZSsKcYhJVwIOdDHQdozT934JfKq2kf/neHwehl2iN
         nunw==
X-Gm-Message-State: AOAM533CCGo+YL0WLFG8oot3/dFXBZLX0BBPJTr6WHHiBWI1KAxWfj79
        1qf6CZTSLd+67W2uAXG2Q1QDWV4KD6zeIFYZLn0=
X-Google-Smtp-Source: ABdhPJzotHGXypU5oLdAcWzF9OxM5vACZopyDPo94F0gQN7a7o7Xhm4pQ4I1TU8eVAqdzMif6MY2igKpK0wC+PkcxWQ=
X-Received: by 2002:ac2:46fc:: with SMTP id q28mr19176592lfo.300.1626723177938;
 Mon, 19 Jul 2021 12:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 19 Jul 2021 12:32:46 -0700
Message-ID: <CAM9d7cjfRx89AHaC7ngvA2rFQ5wFxk95opUw1D3+mcBadLksaA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Tidy perf Documentation build
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Wed, Jul 14, 2021 at 6:33 PM Ian Rogers <irogers@google.com> wrote:
>
> Perf's Documenation Makefile is based off git's, but some parts of it
> were never completed. 'make info' also fails. These patches fix 'make
> info' and do some related tidy up. Two missing files are added from git.
>
> Ian Rogers (7):
>   perf doc: Fix perfman.info build
>   perf doc: Fix doc.dep
>   perf doc: Remove references to user-manual
>   perf doc: Add info pages to all target.
>   perf doc: Remove cmd-list.perl references
>   perf doc: Remove howto-index.sh related references.
>   perf doc: Reorganize ARTICLES variables.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/Documentation/Makefile          | 74 +++-------------------
>  tools/perf/Documentation/build-docdep.perl | 46 ++++++++++++++
>  tools/perf/Documentation/cat-texi.perl     | 46 ++++++++++++++
>  3 files changed, 100 insertions(+), 66 deletions(-)
>  create mode 100755 tools/perf/Documentation/build-docdep.perl
>  create mode 100755 tools/perf/Documentation/cat-texi.perl
>
> --
> 2.32.0.402.g57bb445576-goog
>
