Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81DC77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEaRAZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 May 2023 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEaRAY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 May 2023 13:00:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D8BE
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 10:00:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f6c6320d4eso4381cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685552422; x=1688144422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V3lfWW5VqilelJoCyA0ZwGHDTt05WcwD13IEp2Y+dTc=;
        b=gjzg+fNgd132CkQE3VgaI7YnyJDvbSycxR/Hl26xEAnKEzJ3ZINGPlyuX//rKxaLdO
         rB/Ky0UehVuCL+QuCistNW6eoWtgd8PSdcYK7n3VANtsTS2hW9apwrUmjevwLRtiivHC
         pSicAhrhtT0L19F46fJ4csK1cJAuhZ4f6JK1PpTd5Y/r4U9R104E14byT9zpf+i1QxJc
         msDagW8xHdS4FS5ZuK47/y7dexHSIdklBt+j+Us6UxP41k4TglnHSH1eU3irXVOh1INL
         ZeNsZ+Wg6J9NgkX7WIj07XMp++c1VL5UhlzwASgoBmLCvQ1G++FOHrXZP8KNCpqfe1Mp
         1O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552422; x=1688144422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3lfWW5VqilelJoCyA0ZwGHDTt05WcwD13IEp2Y+dTc=;
        b=FVWVw5ZMoFGfBDEgYnkrKRwwURdBaTFBOSOHvja8FLdS5f0LGtxUyykBwwLHRuvy+C
         1feAbikDJawOjc92LtKOc+XQKYpCzs1OTwl3/gpZhEAZWNYeYarJtIxjAreIar7jIprT
         bJEwH/4yI++eo0QEbKEnh3I3RkTCHj0X2v+1+i4sDwbnNS144A6XYJDAcx7He+95+57/
         FbJ6JwuH7VA2jZ3lu5b8WJLQbZYnHfInr/wnSMXQR2KsjHLHl9uNngvJxgjmjz99ELvT
         6lp91Q9jA+DfOhH+meDSH6GeVVLIW/Gsz2qgYdwbLMwpazQdrEgia45Z8kPg/S1EgoXr
         rEcQ==
X-Gm-Message-State: AC+VfDwu/tnYs/gbZoqLS54ya2xyp3aS7jXCBgE0uVrvLlVuqvD/wUDB
        lOL5wfaBGsOItK66VSXFrGnWcqoWkjXtkvRCs2Y2RlY2j5j0jJ10SFlWog==
X-Google-Smtp-Source: ACHHUZ77OvZ6ZRJ/jWwRb7SGg9DtyoYDBc5O96m7J+Nfm7G/pobOx2r2A/geeslcOe03CIL14yF1D2m946jSVMFLb1U=
X-Received: by 2002:a05:622a:406:b0:3e0:c2dd:fd29 with SMTP id
 n6-20020a05622a040600b003e0c2ddfd29mr232772qtx.4.1685552422537; Wed, 31 May
 2023 10:00:22 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 May 2023 10:00:11 -0700
Message-ID: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
Subject: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Monday the Google Summer-of-Code officially started and Anup is
this summer's contributor to the Linux perf tool! We've found in the
past [1] that having office hours is a good chance for contributors to
sync and also for those interested in the Linux perf tool to also
connect and share their problems and experiences. As such we plan on
running our first office hours for this summer tomorrow, the details
are below:

Linux Perf Tool Office Hours
Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

Please ask me and I'll be more than happy to add you to the calendar
invite for this. Over the summer we can adjust the timing of the
office hours to maximize participation, etc. so please reach out and
share concerns.

Thanks,
Ian

[1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5R=3Duw4xUwBi=
N1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
