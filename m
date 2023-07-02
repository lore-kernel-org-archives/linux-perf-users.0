Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7733AEB64DC
	for <linux-perf-users@archiver.kernel.org>; Sun,  2 Jul 2023 01:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGBBDX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 Jul 2023 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGBBDW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Jul 2023 21:03:22 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1081717;
        Sat,  1 Jul 2023 18:03:21 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c1061f0c282so3473275276.1;
        Sat, 01 Jul 2023 18:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688259801; x=1690851801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YISIQ4kX+3nn5eGakgs6KQe060/aOoCfkYgWQRhUhis=;
        b=GUU4MYq8JeY88O49Duth0jiWw9cuU5FTRQM7IM/ExmOIQ64jgQivBVH3+ADiFeUbD7
         3BGk9Vjdvyu5FXoCRs18NRioVNyy9bmFtYqCz165ci4Xyw+HMNCVWAr+v3ZgVtACMYCB
         TsDid6ZNSQHEW5wp/5JisCGHVgfPfT6T/vpHwnWFGmnd9/qqJU8npHju5AhzHiIYP43k
         kEBl3Z/oRo+ATx4RJp/hCbmhNqMStFbju9M5a4f+o2barddupHG00d7AXY9wmwUgjFw8
         6jWwo5NyPMYHKqMdrZoB422fP9YTEfolm2yaZe5QTfEMDMTIdfkAaCGGg394qXoZYs8Q
         X7XA==
X-Gm-Message-State: ABy/qLZaKuqgYLMfdO01Tj/zkXKnXAAz2pJg1qok+p2Cc5DIZPloNgMg
        PLswbxHyCHdN+RbCxNWZqy5Es69OaPaghD92bOA=
X-Google-Smtp-Source: APBJJlGYZBlKaynTrbK3zEsbCXsSxnOjOQU+pP12MZ1eAExGaOMFTUd6s9Zf4/VK2MZlDJ5SFBrPoA+RmQPgubRp7i0=
X-Received: by 2002:a25:69cd:0:b0:c4e:c503:d5f6 with SMTP id
 e196-20020a2569cd000000b00c4ec503d5f6mr728260ybc.64.1688259801114; Sat, 01
 Jul 2023 18:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230630-perf-libdw-symfs-v2-1-469760dd4d5b@axis.com> <CAM9d7cjF+g5Ww22bDviHqFa42dC1JjhGw1cM7POvTziY2wyCgA@mail.gmail.com>
In-Reply-To: <CAM9d7cjF+g5Ww22bDviHqFa42dC1JjhGw1cM7POvTziY2wyCgA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 18:03:09 -0700
Message-ID: <CAM9d7cgMGrmHf7b+AV7onyifJmXsPvcEg2pZuNRcXMA4F+tYcQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf: unwind: Fix symfs with libdw
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 1, 2023 at 11:13 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jun 30, 2023 at 2:11 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Pass the full path including the symfs (if any) to libdw.  Without this
> > unwinding fails with errors like this when a symfs is used:
> >
> >   unwind: failed with 'No such file or directory'"
> >
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied to perf-tools-next, thanks!
