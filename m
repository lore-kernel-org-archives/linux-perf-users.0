Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42A1C46467
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Jan 2023 19:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjADTG2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 14:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjADTG2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Jan 2023 14:06:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5841929D
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Jan 2023 11:06:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id az7so9631916wrb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jan 2023 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ef48NZZOyLTJmvsKcxl0j1f+YUFvaKmNOdYNZPwUkM=;
        b=jIoUoHMTIDUZ27HZuHgFt9n3wmtwVI2W7i2diaYIMRDPXIdC2vH0px3/nu8LWvQo94
         lCkCXh/sOyFaqeS/gtyGPr+QsKpA4t/rogw9pfhkgjSWiClA6UqsPcMW8LRe0BLYbjic
         mFVvrEs0LCt7/7YsicrciPu6ZIphx0Orl9Tn5V89IcFaUMMrmudm+6XDVYUFxsdNRi/i
         x9SMdxxlPIQTQr8GnQW7j49NooBye3XKTYTsIBNDKuoK0NHnkCZwyGk2SglO1RyWjHKw
         UoM9xihM3zPcn3iW0BSqRla6r/U/gmcxyHpf/aYG+5ciUqDmyxAFLoh9+WzQUMGLtsL1
         hL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ef48NZZOyLTJmvsKcxl0j1f+YUFvaKmNOdYNZPwUkM=;
        b=58I02GplBkKDvHvfWoxiq41PdY/OdOBC9CTOQHaJ0ogZ7FjC8UwVXauDbf1jix+cd7
         LT3d+uFGeCap8Sd6uMB2jZUhQFIy8qRZi77Xk6ExvUtVUPlgw/yJ1Am+FvkBGqMmK31D
         I9lHberd5/mfL/ekvMRqtSzV6zhY0KpqwJalkLMTacZSLBUEPr4ZfxQ3Ric0vMqxG1aM
         kH/DF39T1JdNqU7pGOKPh/GIsjpvbFbPfkZW7KNzGHvN7mRyoNAvE5psj3RwKiBxHFlD
         QPS6LdHIwYsPhJG+tMLV7+h8qVHEvorw6zUm1RGKe38VLjzuLry597iux8GI0OXJbXL5
         n1Nw==
X-Gm-Message-State: AFqh2komIQMY9/XCjhKWt6XueegeZ/7s++w1n+cju0c6jhRltOljwCcy
        CEMGmGoU5pX2oH8F7GdpWE/h7s0HcmapoUn+ueXKAw==
X-Google-Smtp-Source: AMrXdXvPv7suAgyrm/H1f+8JYayP5Zkx1Al06mcHdumDSAp525Q8vihSgAxL7evHufTaU0062/2UQ2XguyJEUj9UU+s=
X-Received: by 2002:a5d:4590:0:b0:27e:cf2e:ca4e with SMTP id
 p16-20020a5d4590000000b0027ecf2eca4emr711540wrq.343.1672859183174; Wed, 04
 Jan 2023 11:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20230104182313.3164736-1-jesussanp@google.com>
In-Reply-To: <20230104182313.3164736-1-jesussanp@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 4 Jan 2023 11:06:11 -0800
Message-ID: <CAP-5=fWXsuh84WN_4dC_ydZCfmXgJrns+OKG+f_D6YqWiioDCA@mail.gmail.com>
Subject: Re: [PATCH] perf: Add missing sys/types.h include
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jan 4, 2023 at 10:23 AM Jesus Sanchez-Palencia
<jesussanp@google.com> wrote:
>
> Not all libc implementations define ssize_t as part of stdio.h like
> glibc does since the standard only requires this type to be defined by
> unistd.h and sys/types.h. For this reason the perf build is currently
> broken for toolchains based on uClibc, for instance.
>
> Include sys/types.h explicitly to fix that. This is a follow up to
> commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").
>
> Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/trace-event.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index add6c5d9531c..9b3cd79cca12 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -4,6 +4,7 @@
>
>  #include <stdbool.h>
>  #include <stdio.h>
> +#include <sys/types.h>
>  #include <linux/types.h>
>
>  struct evlist;
> --
> 2.39.0.314.g84b9a713c41-goog
>
