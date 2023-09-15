Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02BEED61A
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Sep 2023 16:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjIOQpO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjIOQop (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2023 12:44:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B9118
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2023 09:44:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-415155b2796so326391cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2023 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694796280; x=1695401080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAaNqDt8loxFoD4Fj0m2Bu+PsHN+sjNAs6RZ2+mokt0=;
        b=tm4XIuBdQcXqDgj2q8jenrysfghe3tZlgeNsxTY2XMCj0qA3AxudG84feqvBv3DmaX
         5Jx+ztuvZ5fEy1Fvhx1u7RY4Gc/mdhHlDhwCT0me8UJZFN0fjjh7M6wEgQISZA/Mc19S
         cuGLj44Ddn3ewlFKr85bFvES3RECvvSABLq97J+uO81YZfHDwMadVL4iGnEWaBbkpnJ+
         ZRq9paAu6SzTpBpnRjNCd12eNLyRAkYNyqi0yQ1nx/1RulQOyRuqUzhoRRvjhOlJwadl
         ROVw3+qZuhSAyXI04ubQv/XE7pJe0COOTYye/EST0CxUGDIM6/JUteD0Vb9JPVpxjLuo
         wAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796280; x=1695401080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAaNqDt8loxFoD4Fj0m2Bu+PsHN+sjNAs6RZ2+mokt0=;
        b=ilxUqRpNYjVDIOxk+nXrg9umBqVURuYaET/xAfP14/a5kVvmzqv6PVDdiNGk1LveoP
         9B9ynfizuecDZdg6ztiesivXus1rddkxmn/Jynzp7eQ5hfkYlpLjfDtR894PUd1z00bS
         jlM7XLm5RYZ2MlC4GgqqrVaJw7Yq5Gu7ZnhxA9/YUdvkxV2DltrgPOj7mmyajIHsrGmQ
         PYMkJ1+VHtTZGevH5nr7FEur/cthp2bPHv96fK+Qh4AE/RbKFbn9YMGxIO3VIarXxka7
         O4DQU2Riok4YgDqkjxAaO+7ZR1neWEjRiaHz6GUJ5h0LmPQmmxZddm8Q6ooPd3exTmFd
         7zAw==
X-Gm-Message-State: AOJu0Yw8lRoTkX0qkfzV0rNipIZq/XoXvtt0nD5XBbHCfNQZmTT/hZx7
        iPb2qDXbODkji0b9KfP4iStjYx/aG2bp2PBiXxscOA==
X-Google-Smtp-Source: AGHT+IEyEJpko9v/1zsAayp7DJpFP9c+FUOlL/e7aASqNAwVhc9BhpW5GLT4zlXwQM7cRrDLPwIQ2gJgCsAwRuv9VhQ=
X-Received: by 2002:ac8:7d4f:0:b0:415:1484:2263 with SMTP id
 h15-20020ac87d4f000000b0041514842263mr238062qtb.25.1694796280178; Fri, 15 Sep
 2023 09:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230915090910.30182-1-colin.i.king@gmail.com>
In-Reply-To: <20230915090910.30182-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Sep 2023 09:44:28 -0700
Message-ID: <CAP-5=fVwyt+VriYacj3nmGZbfqVZciRwozr2sJQSPpHhoyxAaA@mail.gmail.com>
Subject: Re: [PATCH][next] perf kwork: Fix spelling mistake "COMMMAND" -> "COMMAND"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 15, 2023 at 2:09=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a literal string. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-kwork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 04b966801643..7e8dd35d764b 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -1629,7 +1629,7 @@ static void top_print_header(struct perf_kwork *kwo=
rk __maybe_unused)
>
>                      PRINT_CPU_USAGE_WIDTH, "%CPU",
>                      PRINT_RUNTIME_HEADER_WIDTH + RPINT_DECIMAL_WIDTH, "R=
UNTIME",
> -                    PRINT_TASK_NAME_WIDTH, "COMMMAND");
> +                    PRINT_TASK_NAME_WIDTH, "COMMAND");
>         printf("\n ");
>         print_separator(ret);
>  }
> --
> 2.39.2
>
