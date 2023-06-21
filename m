Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48DFEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 17:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjFUR1P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjFUR1L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 13:27:11 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866110A;
        Wed, 21 Jun 2023 10:27:09 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b13e2af122so4715219a34.2;
        Wed, 21 Jun 2023 10:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368428; x=1689960428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MhTlH8vHzbFj0GHoNEXbCWkZrmdxXHp7k0D25qpFIY=;
        b=iSM4ymv1QQf9c87PTCPEKNxLg0B0Eyx+OpgM4K9bVTIHNTD7sjXRkKPhvmzstro36W
         y5qyMHeQy/mVzVC6Nvfp0b6T0kkYAT/yXnj4mZdPnMjDIrCd96ZLXTCR1DDTqghKy2Iy
         QsPmXVUU88y6/UwQXFsQvMbAEx8FkRDH/alOoy/nv7rrdxxHcScoyMlTYnlVV4sQ5abu
         DtBCurYhkPMQ9T/EBdYllFHRy3GuUB+062ZpTO4mB1xL3orxeTUtWN/wd4OiSjdaSGV7
         com8ksYlmJOd0WEkdN8Hxk4cBUDDqRG87BNX/NS743YD5+8Iwl/z7AaH3V6XqxudcVYm
         55lA==
X-Gm-Message-State: AC+VfDxDunpY9RKY4GcZWO1iG99yCOhdBhXgcV1K4vByKIKqvh71KDJL
        TdNGnGxDGCCdDfAgdgJmPzDzzgO0cdajxvjd6VQ=
X-Google-Smtp-Source: ACHHUZ7CpzAA56ymr68U+nb7voKKV4Fv2xOoyYVjFCg9D7Wn8Izt7AUBpxHCWogRFm8nm+70ABUop9Jyj/qtTfJweGs=
X-Received: by 2002:a05:6359:c07:b0:12e:32a1:d83e with SMTP id
 gn7-20020a0563590c0700b0012e32a1d83emr7478466rwb.23.1687368428516; Wed, 21
 Jun 2023 10:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230619082036.410-1-lidong@vivo.com> <CAM9d7chHMH-uJryUVBYZ6emrGLVH8Huc5frDz4YqG7TU29G-6A@mail.gmail.com>
 <CA+JHD93f_c8OJf4Kg68C_Xo=_rcO669G0QJ_mjL78upLmUwfoA@mail.gmail.com> <CAM9d7cj-t-jko=7mBb_dLrXFCC7s03W0Jz7jrO4nZkWZKeJAAA@mail.gmail.com>
In-Reply-To: <CAM9d7cj-t-jko=7mBb_dLrXFCC7s03W0Jz7jrO4nZkWZKeJAAA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:26:57 -0700
Message-ID: <CAM9d7cj0HLf1YSu+Y1GbhfR_yxtS2UDGtAuPbOAQhiCwCuF9nA@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix incorrect calculation of object size by sizeof
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Li Dong <lidong@vivo.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 20, 2023 at 3:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> On Tue, Jun 20, 2023 at 3:06 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On Tue, Jun 20, 2023, 3:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> Hello,
> >>
> >> On Mon, Jun 19, 2023 at 1:21 AM Li Dong <lidong@vivo.com> wrote:
> >> >
> >> > What we need to calculate is the size of the object, not the size of the
> >> > pointer.
> >> >
> >> > Signed-off-by: Li Dong <lidong@vivo.com>
> >>
> >> Since this problem was introduced in the current dev cycle and not in the
> >> mainline yet, I think we can skip the Fixes tag.
> >>
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> >
> > I think we should have it anyway, if not for the stable guys to pick it up, for documentation sake :-)
>
> Ok, I'll add that.  Thanks for the reply while on your vacation. :)

Applied to perf-tools-next with the below tag, thanks!

Fixed: 51cfe7a3e87e ("perf python: Avoid 2 leak sanitizer issues")
