Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3419BC05027
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Jan 2023 06:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAWGgS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Jan 2023 01:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWGgR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Jan 2023 01:36:17 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4A193EB
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Jan 2023 22:36:16 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 129so9569046ybb.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Jan 2023 22:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/KCTW2SI94Dm4W3SZnAv6FzvpiQDC4oOm9m6/Sh/NQ=;
        b=LwfEcx9mLlA98IJedIGAH97g+PvkXHfExHyvv9GuTUUZj4Y9D8EOfLSB1BcXZjS8ev
         qGkQlZFLR1Ab8GMPirqM/sJDExy82t9CC/YQoZEz5VOrCfEHjgSX8ltWBKZEajtJ866+
         ukpeoeI3zwDFUg9XiXwsCjYgJMCRAHeXOtIRgu/zgmVshofQyWPhe1k0uAZl1pIeP3Iu
         66nP6ZOjJQqMtXnSwFpnRL91wGPozU0Gq4FP3jQq/Wi+VIOlN5HDIEoWWrokKg2RlCci
         Spox9tMXM7uBhq4K+D8O8dyzpdWRNdh0Fx3+OyMjQgdzetMqoRh8NpgZx7LTc1Ub29IR
         ybUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/KCTW2SI94Dm4W3SZnAv6FzvpiQDC4oOm9m6/Sh/NQ=;
        b=uRqF6AB2xYaaL0rfZLmgTjbSEauA7l4vI+BN1li/+FjNM41YHywXh3M59HnIWEXBhC
         jxabc7fSeLE8zMF1IOhBc5xKt85Nt6j63AgByOlKFB9T6ki89XtiELPuoTeqpDve7L2t
         vNomVv8j2M7sCbevxmXvpKI8M/iEyZ0L5sI8T7KFr+skcpg/0NtUeqMM4BAzdNkLlID4
         dCmAK/UPzBUAxngQKZdLE5cX2g+HvSrMvvblmtlh39Qmf+g+zSvncX6o1oVNryAmMjyw
         xQvAnwKqoEGL3lwEaCBTdloCK3SdMJPiuqqSkugmWWWTJxdssjsSuyiZfeiez999edp0
         ya+A==
X-Gm-Message-State: AFqh2kqaG/SV3QUWZP3XcONzlVj6ul7PFX9MnXCapk22imHBeVS83DBL
        z2Wkg6Is/hzGDAylObLr447q4ZrYbdiLyvLxxTNjKDQn
X-Google-Smtp-Source: AMrXdXt2Tfid+YKNA9l3AfOOfbZFob90BXc+KNs/POm6euX5NrHFo2NnaZpp1J5Q+gEHA2+ulZMr1hzPKOaOVDFfIvI=
X-Received: by 2002:a25:8706:0:b0:7e1:72d3:f1b8 with SMTP id
 a6-20020a258706000000b007e172d3f1b8mr2794119ybl.478.1674455775730; Sun, 22
 Jan 2023 22:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20230120134039.17788-1-mpetlan@redhat.com> <20230120134039.17788-3-mpetlan@redhat.com>
In-Reply-To: <20230120134039.17788-3-mpetlan@redhat.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Sun, 22 Jan 2023 22:36:04 -0800
Message-ID: <CAM9d7ch-if6Ov9dT+zHtYzVOdOjGOe=YsQvmb_5AOdbK9NDmZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Fix JSON format linter test checks
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 20, 2023 at 6:00 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> The test fails on CPUs with topdown metrics, where it is common to print
> two metrics per line. Since these are included in default event set for
> `perf stat -- something`, it causes the "no args" subtest to fail due to
> unexpected member count. We need to accept 7 or 9 members in that case.
>
> Coming to that, counting commas in the JSON line and consider it a number
> of elements is incorrect and misleading. There should be +1 element than
> the count of commas, while also, commas can potentially appear in the
> event names. Count " : " substrings rather, since these better fit to
> what should be actually counted.

I'm also curious if ":" could appear in the event/metric names.
Probably more chances to have ":" than "," in the name, no?

Thanks,
Namhyung


>
> Fixes: 0c343af2a2f8 ("perf test: JSON format checking")
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  .../tests/shell/lib/perf_json_output_lint.py     | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> index d90f8d102eb9..4f1bbb3f07ec 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -40,17 +40,17 @@ def is_counter_value(num):
>    return isfloat(num) or num == '<not counted>' or num == '<not supported>'
>
>  def check_json_output(expected_items):
> -  if expected_items != -1:
> +  if expected_items:
>      for line in Lines:
>        if 'failed' not in line:
>          count = 0
> -        count = line.count(',')
> -        if count != expected_items and count >= 1 and count <= 3 and 'metric-value' in line:
> +        count = line.count(' : ')
> +        if count not in expected_items and count >= 2 and count <= 4 and 'metric-value' in line:
>            # Events that generate >1 metric may have isolated metric
>            # values and possibly other prefixes like interval, core and
>            # aggregate-number.
>            continue
> -        if count != expected_items:
> +        if count not in expected_items:
>            raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
>                               f' in \'{line}\'')
>    checks = {
> @@ -82,14 +82,14 @@ def check_json_output(expected_items):
>
>  try:
>    if args.no_args or args.system_wide or args.event:
> -    expected_items = 6
> +    expected_items = [7, 9]
>    elif args.interval or args.per_thread or args.system_wide_no_aggr:
> -    expected_items = 7
> +    expected_items = [8, 10]
>    elif args.per_core or args.per_socket or args.per_node or args.per_die:
> -    expected_items = 8
> +    expected_items = [9, 11]
>    else:
>      # If no option is specified, don't check the number of items.
> -    expected_items = -1
> +    expected_items = []
>    check_json_output(expected_items)
>  except:
>    print('Test failed for input:\n' + '\n'.join(Lines))
> --
> 2.18.4
>
