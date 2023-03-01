Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4FAC6FA9D
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Mar 2023 17:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCAR17 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 12:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCAR17 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Mar 2023 12:27:59 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC34692;
        Wed,  1 Mar 2023 09:27:56 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id l2so8750773ilg.7;
        Wed, 01 Mar 2023 09:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677691676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnDrSHzj0d5rZfd3ZqmVD1Vt/nu27QzrG7mUHHcfkZ8=;
        b=2VavQvw7btE3tezi/y5GGJlCztLE+WlTqJlra88wldevdNajtDinmkRgZ2M+aAjT79
         4diDBXszfyDIP9bV65cWIhfGSGUH9PiVEZMHPE7yWKVsn2oSisfi1WHweQ7iVKf/cVUT
         5WSVM+ndKjX+Otk8AhMFH0dq91AAmkVfXFmVJrjfXsh5MYvT3Ry48//0nQKZLNg1H8yD
         Bp98LRnMwsnxlmRLxUsqwjr2N0LbCEjrqchj8joPJmWZZAFllTbr2SY8gYB8SgYQToaM
         biyin9PuRZR5rFYfYTLxTFXSm7eqv+VAlvt2ZUN24OCacPlYxFe97+5trmhJcaSHw5Pu
         Ferg==
X-Gm-Message-State: AO0yUKUH/IO7/tKytB8Z8ARnxFBm6q/zIC2ItA5Pv37SB5wXRoKtQKI8
        kqFStDDdU1m9KSULddXHMRG7RygrdOAhR4kMIWc=
X-Google-Smtp-Source: AK7set83yH+1npW6gGqhuWJ31bWAt4kcjFrQR8MpvpBsv5vW8Gf/hpePfQPAmAVVVcszGMPYN6HleocwyFRH1P4J270=
X-Received: by 2002:a05:6e02:12c4:b0:316:60e4:5ac5 with SMTP id
 i4-20020a056e0212c400b0031660e45ac5mr11380215ilm.0.1677691675992; Wed, 01 Mar
 2023 09:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20230301150413.27011-1-kan.liang@linux.intel.com>
In-Reply-To: <20230301150413.27011-1-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Mar 2023 09:27:44 -0800
Message-ID: <CAM9d7cgwmuCqjdFsW6VUTLeL-BJuoP2F2N6RaWGTuThVFaGFKA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix "read LOST count failed" msg with sample read
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Kan,

On Wed, Mar 1, 2023 at 7:04 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Hundreds of "read LOST count failed" error messages may be displayed,
> when the below command is launched.
>
> perf record -e '{cpu/mem-loads-aux/,cpu/event=0xcd,umask=0x1/}:S' -a
>
> According to the commit 89e3106fa25f ("libperf: Handle read format in
> perf_evsel__read()"), the PERF_FORMAT_GROUP is only available for the
> leader. However, the record__read_lost_samples() goes through every
> entry of an evlist, which includes both leader and member. The member
> event errors out and triggers the error message. Since there may be
> hundreds of CPUs on a server, the message will be printed hundreds of
> times, which is very annoying.
>
> The message itself is correct, but the pr_err is a overkill. Other error
> messages in the record__read_lost_samples() are all pr_debug. To make
> the output format consistent, change the pr_err("read LOST count
> failed\n"); to pr_debug("read LOST count failed\n");.
> User can still get the message via -v option.
>
> Fixes: e3a23261ad06 ("perf record: Read and inject LOST_SAMPLES events")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8374117e66f6..be7c0c29d15b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1866,7 +1866,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
>         int id_hdr_size;
>
>         if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
> -               pr_err("read LOST count failed\n");
> +               pr_debug("read LOST count failed\n");
>                 return;
>         }
>
> --
> 2.35.1
>
