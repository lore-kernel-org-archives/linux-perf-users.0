Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A7C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 14:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiEYO2n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244944AbiEYO1t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 10:27:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C630120A1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 07:27:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t13so11195738wrg.9
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJ1ZHRktroNtOl8H5m5yxZpwDkzeUzNeSS+Jn6yJC/E=;
        b=RDQviVNxwnDPtpi7oegoJoeczxVptCjhjqG3k7e2MVyRfnEPXQK1Yh1mUiyt6PZWOT
         D5kGdb6hYRbfoJVXaQstxQAn4TVO0B4oPNhT5dYC075z4MKUbkwAqLV0yqr71Xn16XQX
         igoPgt+UJjSW3+kK+cSA/cwXZauSDLvZzvLrQTCHp2bR8oG1WtTDjgC4ZMXM64P5Q75P
         tCKHM37n6SFwIm3i5s7e2NLzGbZXghMVU7vk+S/fXnvquPunmZUEFClnPbEBtKnHF4aH
         K7luMHASgIXULLWtjmwvJKmEZmtnQwrgskARoSUNu69cp3HYxDrpSj2e70W5lhfNRAnK
         vhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJ1ZHRktroNtOl8H5m5yxZpwDkzeUzNeSS+Jn6yJC/E=;
        b=iQSckaP5gfaNGfK79W7e/xd12YTbW4kASEtqJe2tPl840cpQuDJkq3e4NpQAmS1VV2
         GYv+YI30Xf84orcX/gUbZVnnm2mi6o3OENpfZHphuHd/rVA660xsjBsAOduy12iQ7z5q
         BQPcJP8xtbKLz/eSqHdeWLmmI5V7iWCfqUiYlPwKDWzoLIVeML4Xq8kKrRQtXOhxqBtp
         0E7Qc9nczni1kl/a16ExJM599VD9Pw+5QRxnTllQgFY811Ftj8BXeo9CDee4/a7TFqf2
         G0c3TAfnDSOVk4KhDHYyrwXwGsE19o7dVXTW3ANKL+styu474SjqzpwM27HAFAW8TmlL
         vgSA==
X-Gm-Message-State: AOAM532+m+yJgstLelDY7zd65G5YbkbR2KpDVKkKMdyNdmlZSdU8WXwX
        LAJqVD4s+QuEfsi/eMOe1OvqclioUMYXGOt2bv8uAw==
X-Google-Smtp-Source: ABdhPJwO71e56s9S6gZVeAgxZJG9PM+AF+DSN8b3zz0J1VjD/KFjwSYVgU2nlpO1Jp//jjlGO0e0mGWReG0/0XrUcdc=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr27630902wrq.654.1653488840849; Wed, 25
 May 2022 07:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220525140410.1706851-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220525140410.1706851-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 May 2022 07:27:08 -0700
Message-ID: <CAP-5=fUm4G043v6-pToBiT-psxt-_r4kxtsWwkjLh=ARmhmP_A@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Fix event syntax error caused by ExtSel
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 25, 2022 at 7:04 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> In the origin code, when "ExtSel" is 1, the eventcode will change to
> "eventcode |=3D 1 << 21=E2=80=9D. For event =E2=80=9CUNC_Q_RxL_CREDITS_CO=
NSUMED_VN0.DRS",
> its "ExtSel" is "1", its eventcode will change from 0x1E to 0x20001E,
> but in fact the eventcode should <=3D0x1FF, so this will cause the parse
> fail:
>
>   # perf stat -e "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS" -a sleep 0.1
> event syntax error: '.._RxL_CREDITS_CONSUMED_VN0.DRS'
>                                   \___ value too big for format, maximum =
is 511
>
> On the perf kernel side, the kernel assumes the valid bits are continuous=
.
> It will adjust the 0x100 (bit 8 for perf tool) to bit 21 in HW.
>
> DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
>
> So the perf tool follows the kernel side and just set bit8 other than bit=
21.
>
> Fixes: fedb2b518239 ("perf jevents: Add support for parsing uncore json f=
iles")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jeve=
nts.c
> index cee61c4ed59e..e597e4bac90f 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -605,7 +605,7 @@ static int json_events(const char *fn,
>                         } else if (json_streq(map, field, "ExtSel")) {
>                                 char *code =3D NULL;
>                                 addfield(map, &code, "", "", val);
> -                               eventcode |=3D strtoul(code, NULL, 0) << =
21;
> +                               eventcode |=3D strtoul(code, NULL, 0) << =
8;
>                                 free(code);
>                         } else if (json_streq(map, field, "EventName")) {
>                                 addfield(map, &je.name, "", "", val);
> --
> 2.25.1
>
