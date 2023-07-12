Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32010EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 17:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGLR25 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLR24 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 13:28:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B11BF5
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:28:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40371070eb7so19031cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689182935; x=1691774935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf6jn4Tmh6XLNjLqmxZGPisxyJ73A2eJOVy3NQS6PLk=;
        b=gImBrw0t0mlBNIdvg2GkS2g94nraaakeN5+Br49MJyHjrMvlJK5XCtmIDFedMbMdd1
         ujJikBSb04kucgbR5hZkIqpv8jA/t3CMQyLI3K+4QhmH9qGNWSh7w3PpSVGdyYGJoq4G
         0fhFBjjWSJEY6ebihsAmdhf9vk/S1IcqokulaBoFu/OKxrVTUvvazboA0alD6VQwddug
         IKGSr5C8Ot53Js+sFpnigfBxJjmby/JwF0ZQU+nLCFtoru0GpULYlm+Hti5PMMOvbuHh
         uUY/aL8JW0OyCMoLRr3CF3W0Wa6Pz88G+JoaocPc9364U+XPy+DdLnXbWytx/BaVzBFU
         mP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689182935; x=1691774935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jf6jn4Tmh6XLNjLqmxZGPisxyJ73A2eJOVy3NQS6PLk=;
        b=jBOzBtfhEZvvA74mUM4Kg3nwPh2W2Z2Vc+3xNMGmLHSJa2vismi5K3nVJf7xRxAxei
         lHzPQZv290zrXhPr2g8LJ7NGUFGpIBKiGxwPJchr4c4g7l8oy+ZzcPPQJlyVTF9g1hPh
         C/U38avISBwmF7t81azrubpyH1zFWNw6YcmIdN+bKYpqV2ijmv2ehb5s0brtMDi1LNIW
         8iYXGjwAqcsNVGPE0mQt2WDg+mCvFaZfO+CdV/k/G/R4x+tDgqIe/9+hg6a0w/Pp5p1X
         1fODdxFolvcXOTsiblwZpiiUs2x7YQhynG7vYygbiqNgeGoAfn86OCakbkVvMh1quRTR
         jIPw==
X-Gm-Message-State: ABy/qLYgY1xXvjL7UAdvx8okb8jgJhfvG/5G1ldzWzQ0obdq9V5obnJ8
        Ra8T6eE6YUdmJoBuADRlAhOzejc753Ocw54+Gqfv8w==
X-Google-Smtp-Source: APBJJlFiEd58mMKPb53D3NFQACKs9rJ08QTBvtKayfJE2Kg/fvO/VuY1W/RjrtlNPXdR7s0pQ4k5iqg4njFJFhYd770=
X-Received: by 2002:ac8:5e0d:0:b0:3ed:6bde:9681 with SMTP id
 h13-20020ac85e0d000000b003ed6bde9681mr344009qtx.0.1689182934850; Wed, 12 Jul
 2023 10:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <11543b39f97a7e2f9eac76c1233f1b1caa3f2c48.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:28:42 -0700
Message-ID: <CAP-5=fXT3a4JE6u8zXf3=xFbOGTre3WD63SMPrA_iSVpgHjDVA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] scripts: python: Add trace end processing and JSON output
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 10, 2023 at 4:13=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> Inside the trace end function the final output will be dumped
> to standard output in JSON gecko format. Additionally, constants
> such as USER_CATEGORY_INDEX, KERNEL_CATEGORY_INDEX, CATEGORIES, and
> PRODUCT are defined to provide contextual information.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  .../scripts/python/firefox-gecko-converter.py | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 0b8a86bdcab1..39818a603265 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -24,8 +24,40 @@ from Core import *
>  thread_map =3D {}
>  start_time =3D None
>
> +# Follow Brendan Gregg's Flamegraph convention: orange for kernel and ye=
llow for user
> +CATEGORIES =3D [
> +    {'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> +    {'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> +]

A follow up could be to make these command line options, defaulting to
orange and yellow.

Thanks,
Ian

> +
> +# The product name is used by the profiler UI to show the Operating syst=
em and Processor.
> +PRODUCT =3D os.popen('uname -op').read().strip()
> +
>  def trace_end():
> -       pass
> +    thread_array =3D thread_map.values()))
> +
> +    result =3D {
> +        'meta': {
> +            'interval': 1,
> +            'processType': 0,
> +            'product': PRODUCT,
> +            'stackwalk': 1,
> +            'debug': 0,
> +            'gcpoison': 0,
> +            'asyncstack': 1,
> +            'startTime': start_time,
> +            'shutdownTime': None,
> +            'version': 24,
> +            'presymbolicated': True,
> +            'categories': CATEGORIES,
> +            'markerSchema': []
> +            },
> +        'libs': [],
> +        'threads': thread_array,
> +        'processes': [],
> +        'pausedRanges': []
> +    }
> +    json.dump(result, sys.stdout, indent=3D2)
>
>  def process_event(param_dict):
>         global start_time
> --
> 2.34.1
>
