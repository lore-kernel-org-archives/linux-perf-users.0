Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF411EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jul 2023 18:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGESMo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGESMo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 14:12:44 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F0173F
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2023 11:12:43 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso7712101276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jul 2023 11:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580762; x=1691172762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUbJVrXykPtTwLEN35bp+YMF5Iwo0jRebaoRjMV9YYA=;
        b=G9vNDiDNh3hspaXEUqCskBfReWdPYhIIc/Wxezu0rpe+O4mLAH8cE8UC2/Y7kPhfGC
         QRFlOxqSlqBDJiQ81TxBl5BL6eL9FCxY2/xfW0suEVGJdXwgIEcN1WPGBoMJPw5I2A22
         fk2v3nwAkf1wumXM3/R5QdPi6J9LPlP73U4MHGV7L+7A2x1l5+bY0AHLzT3+PUsosEFi
         zFMUTnXP9zdxfSJckC/JymPeut0pRLqbbyCeGerEhyB5zs4g5bIXcUZ7zmCiyi9Bn25e
         LmP/Ki688zSwZptcjDrLkYx9AF+i8miYJ4DmBQ5IsRL5a3I5CwGhY6fZ6y9bPixEb4Qu
         seRA==
X-Gm-Message-State: ABy/qLZyaqPhYE1mMC+xz2jeXXsXswBz5XYr5Ag7XxwxHd+BaYZTnI61
        X/Ah1LH3U8gvoMFcplnw7g2bkcMg8N5uX0041yY=
X-Google-Smtp-Source: APBJJlGcCUd3OPl6x4E/KJ1bM1hcGmH0AfrHrP6WKUTWzS9wXHW/TUeQksD1seTwutGj57E0TY7DVsFceNN1APE9OeY=
X-Received: by 2002:a25:4ac8:0:b0:c63:8058:f4a3 with SMTP id
 x191-20020a254ac8000000b00c638058f4a3mr1645891yba.58.1688580762285; Wed, 05
 Jul 2023 11:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050353.14979-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230704050353.14979-1-atrajeev@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 11:12:31 -0700
Message-ID: <CAM9d7cidXVFN41-jAtnJsw8EfrqCa1rYypJk0sj4WnYzfGC_6Q@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Fix objdump in Object code reading test
 to look for all sections
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, ak@linux.intel.com,
        irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 3, 2023 at 10:04 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Object code reading test fails intermittently with below logs:
>
>    Reading object code for memory address: 0xc008000001dd34fc
>    File is: /lib/modules/6.3.0-rc7+/kernel/fs/xfs/xfs.ko
>    On file address is: 0x11359c
>    Objdump command is: objdump -z -d --start-address=0x1134fc --stop-address=0x11357c /lib/modules/6.3.0-rc7+/kernel/fs/xfs/xfs.ko
>    objdump read too few bytes: 128
>    test child finished with -1
>    ---- end ----
>    Object code reading: FAILED!
>
> This issue happens ramdomly depending on the sample ip
> captured during the test run. In some cases, the same ip falls
> in the xfs module. The test does an objdump on the xfs.ko file and
> compares it with the dump from the dso that perf captures. But
> since the range of ip address falls in debug info section, it fails

This is strange.  Why did it fall into the debug section?

Thanks,
Namhyung


> to find the address range with objdump. Fix the objdump option so
> as to disasseble all sections to check the address range.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/code-reading.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index ed3815163d1b..02132478856a 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -184,7 +184,7 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
>         FILE *f;
>         int ret;
>
> -       fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
> +       fmt = "%s -z -D --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
>         ret = snprintf(cmd, sizeof(cmd), fmt, "objdump", addr, addr + len,
>                        filename);
>         if (ret <= 0 || (size_t)ret >= sizeof(cmd))
> --
> 2.35.3
>
