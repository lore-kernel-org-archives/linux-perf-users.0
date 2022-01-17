Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F07C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jan 2022 16:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiAQQbZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jan 2022 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiAQQbZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jan 2022 11:31:25 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA5C06161C
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jan 2022 08:31:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d14so15243451ila.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jan 2022 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgfzTkoWvoIvznmTnwssdnor05qB07oVIv9rYDhQKTw=;
        b=EwGkXKiYdlcp5eUc9AKrnQ9koB+9YPPHIHliSj59oEUKBYWaPYSrMFb8XdWlX+YJcR
         cAwFzGg2CMSRrQRoQ8wa8h1BK9OK49G44qybKz/sZeJJ1nKdFi3mIyaLaX/y5P7FfMiA
         wqQfxMTtrR2RixevRWgIoqQon6moZ6hQQv+DcsM8rtR28FJkC5PFvKbK/02n/cNmOpzF
         Ojj/OTOudwKbfwFSq4wImQaQFCmQGa5WAGHPZF0A9cz5XVY+q2LU3N5OrJX5WEkh1NMt
         TmWeuh2vX0m2H8fsYt6OsXLFNXMZClCw6DaPkDPaMgI6ovKlFwxBDFsL58k9PXVwIZCc
         2Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgfzTkoWvoIvznmTnwssdnor05qB07oVIv9rYDhQKTw=;
        b=3Y0j5M9zJy83Bb7OSNs+TN5qE717LYGDJwiI8WoTAiV1c79pA7Npd6E00ETETp1VHv
         Hk98rnosM0Py9VFtWA2VdNT3kFqYjxa39XqDW8u848ku692MTZv5XKrIyYCF7eo1Em36
         hJWq8dDWI1UWFcfGxNUaDDDRv7PKkoPDgUkBqdX9YoUXH7jEn++PovXOlJyRUwc9kxrt
         aqIIHuBq9pqG699fmRAsj3ALJqAynlaL8IzqeT0Tm84YO1U6M4rJXgW+mPNAseTMRyXz
         oLZK+lvi1NVibVRXQcMBFKOvRI7Hstx7F2v82TgYXg8MNBvAGH9AL/FyVrT7qJSgNQrO
         yt4g==
X-Gm-Message-State: AOAM531+GoOkl8noMGJlGXORgbxuJF53HdI3RlLS+gGOfDHRAvd79Hhp
        I8sazSJ1MD24ei5byzZ+qXL6MjpT22/pmXMf9fa3Iw==
X-Google-Smtp-Source: ABdhPJwX9RVhMQ1p4iLcCQttEXZztwv0uzu36vIRXDGTxiUyd5NU2hURBRrHoZaJxa8CHEXq+o5J0mmUe+6tBALHbnA=
X-Received: by 2002:a92:dd87:: with SMTP id g7mr11277748iln.174.1642437084482;
 Mon, 17 Jan 2022 08:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20220117083730.863200-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220117083730.863200-1-lv.ruyi@zte.com.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jan 2022 08:31:12 -0800
Message-ID: <CAP-5=fXxwCjcsej5QJMoAz1kvoy5LLKUDMop0GzBMuj8oc3mmA@mail.gmail.com>
Subject: Re: [PATCH] perf cpumap: remove duplicate include in cpumap.h
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 17, 2022 at 12:37 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> Remove all but the first include of stdbool.h from cpumap.h.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/cpumap.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 0d3c2006a15d..240db1da370c 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -4,7 +4,6 @@
>
>  #include <stdbool.h>
>  #include <stdio.h>
> -#include <stdbool.h>
>  #include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>
> --
> 2.25.1
>
