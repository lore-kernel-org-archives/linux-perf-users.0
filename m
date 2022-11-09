Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E6C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 01:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKIBfp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 20:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKIBfo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 20:35:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CD60379
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 17:35:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i5-20020a1c3b05000000b003cfa97c05cdso293425wma.4
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 17:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgZcpnnS6jFiy53mvb4fnTvOCCqRJfW+5InA+MbQqyc=;
        b=YN4HBuXK5uaQvKP9tkjWDHuu9kUveWlJq7pmW30IyiWiRUYXkVzrdPJVoRTTuN4wwL
         vraxwoeBfsYUZM0kydZJSNC8GdMoYJXXfBosYpagw7equK0D79Tm0nKAeVXtqjYI59KK
         uhpv1xfQ2pokPo733P5v1Fv3DgznFdxlyviZDe5HxRcqDdHB6LNMf3JURFxxzOzRMeVc
         7jmIBKfDrF2gPYbCYMDJJKIGQxRQq2IvFtK+vbftKe0R1kcwEr4JUjJSZA+dD3YKdJW8
         erMy1+Jr1eSfwOOnniu+wEHLQF1O2TcCedFVm7Au8sjEcUxwI3oCV9iswwPkjByaKG1j
         0V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgZcpnnS6jFiy53mvb4fnTvOCCqRJfW+5InA+MbQqyc=;
        b=CHRCeEqmb9NKRXIWsCVLq2IrbCftvfQHEUZeWTzbV9Cni029mFSZXXCHjbQ+Bp74Ei
         CUarrC1oid49M4JJGLOF6N5eqk1+ogRSb9hnZ0vgF6n+RTRVHfxO/U0A3XDyqi4k67fY
         YcErqPvBjF7LpEOJQKxR6XivMmXetZcx45AV0d1ypVh0bCku4v+t21zzBSCowBwfF01S
         mr9Lw/81as7j5rSYvz/E0w4bJMtfv3P1JTSs2FD3LMfM6dqoQ3bQKE6r4ERkiV113dfc
         AaUhkvxsqZrVfBAbSAMq+qgE+oAaBSLLxSQvZ2hwRiaa2Poxn7wkXyspX+lODomMBO8t
         VWkQ==
X-Gm-Message-State: ACrzQf1B0JKfz2ncFKlO2T1h0l79loQ8zIelAPaNjhE+SyFiNgKnxfe+
        ogmDrE9GMP5AFzUjCsyiAZ+Dk3RnbKl3UgcyfUIvdg==
X-Google-Smtp-Source: AMsMyM728if3sjhSn5CaoHbXsQeD2Jd4YIz9kNhgDYXrC2w4pKPxujhbNps+Krbi88bPbZzZVeI3ubN2je6bfH4PEU0=
X-Received: by 2002:a05:600c:2194:b0:3cf:7065:99e5 with SMTP id
 e20-20020a05600c219400b003cf706599e5mr33021992wme.174.1667957741635; Tue, 08
 Nov 2022 17:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20221108190019.19265-1-9erthalion6@gmail.com>
In-Reply-To: <20221108190019.19265-1-9erthalion6@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 17:35:28 -0800
Message-ID: <CAP-5=fXgO4ai5EvsYHw+_F2FUYqBRkBzXuBOZg_wHK0=_ymgFg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf data: Add fields when converting to json
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 8, 2022 at 11:00 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> When converting recorded data into json format, perf data omits probe
> variables. Add them to the output in the format "field name": "field value"
> using tep_print_field:
>
>     $ perf data convert --to-json output.json
>
>     // output.json
>     {
>         "linux-perf-json-version": 1,
>         "headers": { ... },
>         "samples": [
>             {
>             "timestamp": 29182079082999,
>             "pid": 309194,
>                     [...]
>             "__probe_ip": "0x93ee35",
>             "query_string_string": "select 2;",
>             "nxids": "0"
>             }
>         ]
>     }
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data-convert-json.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 613d6ae82663..d30816eafb2f 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -217,6 +217,26 @@ static int process_sample_event(struct perf_tool *tool,
>         }
>         output_json_format(out, false, 3, "]");
>
> +       if (sample->raw_data) {
> +               int i;
> +               struct tep_format_field **fields;
> +
> +               fields = tep_event_fields(evsel->tp_format);
> +               if (fields != NULL) {

nit: just "if(fields) {" as you did above with sample->raw_data

> +                       i = 0;
> +                       while (fields[i]) {
> +                               struct trace_seq s;
> +
> +                               trace_seq_init(&s);
> +                               tep_print_field(&s, sample->raw_data, fields[i]);
> +                               output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
> +
> +                               i++;
> +                       }
> +                       free(fields);
> +               }
> +       }
> +
>         output_json_format(out, false, 2, "}");
>         return 0;
>  }
> --
> 2.27.0
>
