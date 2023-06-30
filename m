Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A05C001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF3RFn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjF3RFg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:05:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C83593
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 10:05:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40345bf4875so14161cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688144734; x=1690736734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D1NO22NTJu1MOBGY7tF3xo48poE1uDp3veIeBVnBlI=;
        b=GYacckAkcPnWUplTlaekkOtdSFaf+lNU/SG0cw+5dp7yjaMMg9+c4+ymm4dQCO38Dz
         PdeHc8X6R5JAfcDF9pEpC+6ajTif3DHmMt3oQ1pnGmB4z6t4fZVtcvQDOywzhYQjNY4N
         ZrsLZi88nhs+AOGpef+VHTEBPVP+iJGc7S8ob7082O/VQlMOcC/mPJNjmHtq7Uxhg12+
         y1/8ti9u6rVypzIy6UFRV8AuNWz4nuRxB/b4IEi4uWs6Sj6ETn2sFI+QWnZNX9r+PsIY
         BgyRUFrSoyM296nO3MvEJ1qKgV7N6SlOdXyMnqVHJ9ROIGBfM5BXuc6Z2zFdnGTqm3As
         OZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144734; x=1690736734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D1NO22NTJu1MOBGY7tF3xo48poE1uDp3veIeBVnBlI=;
        b=OvimEJO3eh0C9V0ofW/BW+21mYNtc1GOWa59ldw2kgO3/+Z8ZH5xf0Pxq0LTsUKxtW
         BXZKUKRquZ8WNOHhrDpBti+SmYI/YovKHn+A7BW8W+VnfB5ujluKqMwNJq60KPV02SQh
         i360Ns2gj4ITd3szoPiO9c+pYgG/odkpSZFH+hRCAgwI0qdfDe818ZIy/koqs4jEyKFM
         xwcFK4sa3nJp5/yL/XnZpFjiK2D2ZipFNWm/bjI+k04pz7KAq/XNHXKfBJiMhNfDr9VT
         x9koQI/L6yyTNac090Swo2kXg+8ZP9eIt1T+3kpo77Lp4KSZV+N4oKV6ijS/4ZVHevKz
         S/MQ==
X-Gm-Message-State: ABy/qLZXePG5LmFtbEbQ2Wt4iwh2rbJds3rUiOCPlNnv3pc01J4GmaQX
        WZ8yJN0nNyd9Zkp+MoNZD0S7K0bGMBhX9T2qAVFopA==
X-Google-Smtp-Source: APBJJlGFZH6uDfeEmQHjFg3l+Gr3kdJYkA2pz6Pf7n9i4u6wu+eAR+6jecdfSxzaXV6WzHsdQukovl+kgImmO77aQTU=
X-Received: by 2002:a05:622a:208:b0:3f7:ff4a:eae5 with SMTP id
 b8-20020a05622a020800b003f7ff4aeae5mr3290qtx.12.1688144733661; Fri, 30 Jun
 2023 10:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
In-Reply-To: <8dab7522-31de-2137-7474-991885932308@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 10:05:22 -0700
Message-ID: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 9:35=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> > PMUs before parsing").
>
> Will the chances ever grow to add another imperative change suggestion?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4#n94


Sorry, I can't parse this.

Thanks,
Ian

> Regards,
> Markus
