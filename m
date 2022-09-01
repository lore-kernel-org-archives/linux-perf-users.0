Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D600C6FA81
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Sep 2022 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiIAT3D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIAT24 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Sep 2022 15:28:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C12279A4E;
        Thu,  1 Sep 2022 12:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 952C5CE2949;
        Thu,  1 Sep 2022 19:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4811EC433D7;
        Thu,  1 Sep 2022 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662060531;
        bh=wPGJi1HYQfzdkkC89+e/MCcsIJMqTVYm3fW789MbPn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y/6VIhw8ct4HHtcXOrxI4FCzZqPeilyN6llgRP5TATov6yt+nLIeApjVTlUzMUHIQ
         r8jUpPCKcxPCdvWF2J9eAdYnyH01pDUTTshLIuLCWSpDPYZAEnjC1qO26BHvR4yVug
         vy5+vaZGUih/xn22/GaUqsgG484pTKUYaCwe8vl6kTHl08PTF2yKhNPW5tFFVMJdpW
         foIJgk/Sfr2C2w57UHWSiRYgHSCTJmJ2M97gOkQuZ6of8xYW2+I0u1XwWUHmaJAbZe
         97UK0HCr/JApbF3yDxMqCM7S4solcrj4/OslwOgY4oTlBe+LhnV8QD6urV/h1dhoQx
         wAf5lWAyJWQ3g==
Received: by mail-ua1-f52.google.com with SMTP id a18so39582uat.11;
        Thu, 01 Sep 2022 12:28:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo0wW89xObdnBN5sASfkAus0QS8MUG3yKJUeNHqBZexw7tbXjiYl
        +t4+cl0UbL+a6nr6dYUB43mPmW+lUVuttwJQwg==
X-Google-Smtp-Source: AA6agR7VHuEcnFA5n4ZVUkDfVEkdIBa9x92i7DYGLhMLYv4WJB9UjEZ3YID74DSaJ8wUn2D0rPrWT2MzLZdQFo+tlIs=
X-Received: by 2002:ab0:35d4:0:b0:3a2:b85:c04b with SMTP id
 x20-20020ab035d4000000b003a20b85c04bmr4929355uat.43.1662060530264; Thu, 01
 Sep 2022 12:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220901184709.2179309-1-robh@kernel.org> <3361AE1E-778E-46F7-A51B-D143DF29FEAD@gmail.com>
In-Reply-To: <3361AE1E-778E-46F7-A51B-D143DF29FEAD@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Sep 2022 14:28:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLW=Vd=isvPd7_X3Vwp=0XUYjKqLkGYW2cztkd6JnGntQ@mail.gmail.com>
Message-ID: <CAL_JsqLW=Vd=isvPd7_X3Vwp=0XUYjKqLkGYW2cztkd6JnGntQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore format attributes with an unknown
 perf_event_attr field
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 1, 2022 at 2:22 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On September 1, 2022 3:47:10 PM GMT-03:00, Rob Herring <robh@kernel.org> wrote:
> >If the kernel exposes a new perf_event_attr field in a format attr, perf
> >will return an error stating the specified PMU can't be found. For
> >example, a format attr with 'config3:0-63' causes an error if config3 is
> >unknown to perf. This causes a compatibility issue between a newer
> >kernel and an older perf tool.
> >
> >The addition here makes any attr string up to the ':' ignored, but
> >still checks the 'bits' portion.
>
> So, can you please show what is the behavior of the tool, with an actual command line and it's output, before and after your patch?

Before this patch with a kernel adding 'config3' I get:

# perf record -e arm_spe// -- true
event syntax error: 'arm_spe//'
                     \___ Cannot find PMU `arm_spe'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

After this patch, I get:

# perf record -e arm_spe// -- true
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.091 MB perf.data ]

Rob
