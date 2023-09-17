Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBFCD37B4
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Sep 2023 05:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjIQF3b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Sep 2023 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjIQF3Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Sep 2023 01:29:24 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F41A3;
        Sat, 16 Sep 2023 22:29:16 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7955636f500so138437939f.1;
        Sat, 16 Sep 2023 22:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928555; x=1695533355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO3U4MkwPd1ZUK0WSQVObxv6NbOdmKj2lLfEiVm8580=;
        b=E9aXUrbaPpMP78ypzkuxyIU4n89xCuFpvvEXyXNB72ZWXcezxG34gl2IKLF5cEsvRN
         ntGrUMDs/KpWOGj78RhQvLKQXYUxkzcvqaClAakp7YbHwh6O3JMFvHny/eXN4AdQyqgb
         PM9LdeD3I+yHV3lJeF5PGhswIQGZixrRPOsPMIjx+3H4laQ2zxMCUBJldQHjNoaDV/9p
         ohLmfhf3SCv/Da7bLVUu4CjaxHf0Cf1dKVGZQNkA36NlYchv1Lc2V5DeEyYgehpWTTBo
         jW4m6DanYVWU6Efbkb2sUKCPUzEBcH9J2HId/5LnPoTyK85awxpLAoEvlNwYiJjL1mfb
         3w2w==
X-Gm-Message-State: AOJu0Yy7YTiO+4WaJlSzrDcNWnrrKenbOKZiiOncQzDlxQAR20HRl8YM
        GyxQVrnMl6coV+2dUwVnEuQhkZ3ikN9YikSRdSY=
X-Google-Smtp-Source: AGHT+IEkSbO1hLi6q7TLvuSj7lJ+g1/xH8NcMBo4K609RZukhsb+GQd9qrz0ixRW01njruP7lpnhmCPUZbEgkp3FFX0=
X-Received: by 2002:a6b:e805:0:b0:785:cfa1:fcac with SMTP id
 f5-20020a6be805000000b00785cfa1fcacmr6395338ioh.20.1694928555425; Sat, 16 Sep
 2023 22:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230914044233.1550195-1-irogers@google.com>
In-Reply-To: <20230914044233.1550195-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:29:03 -0700
Message-ID: <CAM9d7cgMwX_HuO-Yv6neoDjbCseu=EsobXPcfX_0U+ZjGBQR+Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Avoid an undefined behavior warning
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 13, 2023 at 9:42 PM Ian Rogers <irogers@google.com> wrote:
>
> The node (nd) may be NULL and pointer arithmetic on NULL is undefined
> behavior. Move the computation of next below the NULL check on the
> node.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Namhyung
