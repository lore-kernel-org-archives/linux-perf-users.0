Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C3EB64DD
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 16:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjGLQu4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjGLQuz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 12:50:55 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B345310CB
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 09:50:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40371070eb7so5031cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689180652; x=1691772652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrWeWmJCdvVgXyliZ1/YegMmsWAccO5WW3YyUUW2YD0=;
        b=IpcxfUaPhWIprdj58vlbq3Z4pHWo7awEFaOMX5Cz4OFgWAi2gKPPCiJual0yQ9u8sg
         /a55byZ0FxaAopfV5C8STDKQkBvP9SiNsd3OT2cLEXa55Bw9yzx1iokE2waI5xwjhhZw
         zM5Kit2HleHVUllHn4r06zhGqQMvETkyvyA0TP/XUaR1DfB70gkygOrLq4fhWpWlThmx
         4pkUeFHZD6BlFTzwAmF+GK9GEXg1TUFhDPOplDMt+GU7AizElJ/aJ6u6f/Q0p3KM1RgZ
         VLW1jj90B+3hh47KlKqF1jtHvPJ2OM5Ikk2kmKsXcO+SmnjB3Z1+wC4PEtMDtYi6/xe1
         pBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180652; x=1691772652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrWeWmJCdvVgXyliZ1/YegMmsWAccO5WW3YyUUW2YD0=;
        b=elMKXc87nC4WLXbm3m+okfT2TvNylVYL4LOtJGEefi2sVv8e7EKT5d+oyXavMKxfLU
         Rr82qFeMhUOdTUAv4CizwspVHGls/YzjwwBUsI6nknEKgfsNKBEXgl3G983DNfWtvidl
         PCfZ466miCVFpsNNV9GzHKC3fd7s/xhgRcLqr5sPlWAnZHy76Aglk14fo+2tDt8PGN5u
         ZEineUm7Rm48e8Tv1tMV7VWFvbz3I+rg5CV6oXTfXBOSayqQuho4Zw+ct/IaTiHANkr9
         qC7N37GsGObxRrexKfelR3L4smxaj2PE8AoixkmmkWDvwubcq5sNt5rHSYXhuiUbYQyw
         E8nQ==
X-Gm-Message-State: ABy/qLaYuFG0vO69Ot8icorW35gyErxF8Ql6YeIXItGfEhgapJTi/MP3
        ZGbis8OJIjsk8Si0tf6hUDuqpM4pIbJMlZO5XikPxg==
X-Google-Smtp-Source: APBJJlEztjmUyjsWFZ4IEfvg9IBdi/gDtMFRQkWvxvmVGzdXKUk5DLCWCCvuDzrA3PB8n19PX96Lbav8HaMnPCc07xs=
X-Received: by 2002:a05:622a:38a:b0:3f5:2006:50f1 with SMTP id
 j10-20020a05622a038a00b003f5200650f1mr293662qtx.12.1689180651668; Wed, 12 Jul
 2023 09:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <5d3727bacffa331cd81a059fc3122cfb3f43dabd.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <5d3727bacffa331cd81a059fc3122cfb3f43dabd.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 09:50:40 -0700
Message-ID: <CAP-5=fVOTstw=V2dsyfqQV1NB24ePOkqxUtF1g==5TGk5i3Phg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] scripts: python: Add initial script file with imports
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

On Mon, Jul 10, 2023 at 4:09=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> Added the necessary modules, including the Perf-Trace-Util
> library, and defines the required functions and variables.
> It leverages the perf_trace_context and Core modules for
> tracing and processing events. Also added usage information.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  .../scripts/python/firefox-gecko-converter.py | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> new file mode 100644
> index 000000000000..5b342641925c
> --- /dev/null
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -0,0 +1,28 @@
> +# firefox-gecko-converter.py - Convert perf record output to Firefox's g=
ecko profile format
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# The script converts perf.data to Gecko Profile Format,
> +# which can be read by https://profiler.firefox.com/.
> +#
> +# Usage:
> +#
> +#     perf record -a -g -F 99 sleep 60
> +#     perf script firefox-gecko-converter.py > output.json
> +
> +import os
> +import sys
> +import json
> +from functools import reduce
> +

nit: technically some of these imports should be added when necessary
in the code.

> +# Add the Perf-Trace-Util library to the Python path
> +sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> +       '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +
> +from perf_trace_context import *
> +from Core import *
> +
> +def trace_end():
> +       pass
> +
> +def process_event(param_dict):

nit: (this is likely addressed in later patches) you can add return
and parameter types here to aid understanding of the code. Function
comments are also useful.

> +       pass
> --
> 2.34.1
>
