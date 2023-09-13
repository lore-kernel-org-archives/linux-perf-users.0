Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD21EDEC6A
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 14:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjIMOeN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjIMOeM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 10:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C94EC91
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694615573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESzwCydIFjiNRdd0bOfzMWA1mjRG44ZNgNm8U9oO6+4=;
        b=R9eq0/R6vv+ep7Heojgwa5k4obJLp22Gpa553Zu50PPA4G3h6GFoPxmPpr4zxFbvrk6XJs
        7rCznJSNWZ7BajmXG02PWfgdacFIRv7Fm+PAur2uQU04S3FUgToRlnuypUOFQJquHXM3mv
        8yu+yGajZp5GnAOJoC2HwAc+7/XduNY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-GminY1RnP9ak_s_N6OQ8mA-1; Wed, 13 Sep 2023 10:31:22 -0400
X-MC-Unique: GminY1RnP9ak_s_N6OQ8mA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b710c5677eso79225081fa.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 07:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615456; x=1695220256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESzwCydIFjiNRdd0bOfzMWA1mjRG44ZNgNm8U9oO6+4=;
        b=NEoKdYqD6OXCroIZTb/pwrkGY96ZskkjiUnfist9qrKTyOhIh3BZ8q2wHhaPqejOjp
         8GKylKFGaEccAUF+GisIsc+4eBBwLTti4CN9+uQOG2USuQzcNf5GRfDR3YU2E2Cy6PD3
         I61AVqbzW68AJBOX4gVivw+QWEJjQbY+h/qD2AGj0o5wjlBagTfy3UyDumKEcYVdZt0f
         A/jEM5Z6Qj2+7V1MIcuJ3PiQ36FFhZBvC5jvBoBZ9GWydfv0iF6yf/DK30Qm/BGLSQ0K
         oPBqWCzo4SiJhZHK64n9G3a2/BvLV9AoHsR/M8h+xXDA93O1KqzSdc+F0//UFigolIrr
         F8ZQ==
X-Gm-Message-State: AOJu0Yzry0XLs3EyAtfwdaIzWN/H1x6tTt+xWmPjR0MJIqowvTL+n5LG
        XdlpGL0ie9G5OzckN7C/MYvQK3jOR346ZLITWHS2vwe50BX6Mbv3T9zBS+Eue+Tzo9bF0jsPT5E
        ngf91bJ8wqWVkoZTHqSkd0DLu6Oz/Y45YLPYodxOYf/9AJA==
X-Received: by 2002:a2e:300e:0:b0:2bc:de8d:4ab1 with SMTP id w14-20020a2e300e000000b002bcde8d4ab1mr2533683ljw.6.1694615456175;
        Wed, 13 Sep 2023 07:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErEehaSCj9lJQoT+HMjalVIqxubrWB6pY7sRstDZKBMzLj3mGIls8tvir2e0ztzoI4M3hyBwKMiouF83Ab2R8=
X-Received: by 2002:a2e:300e:0:b0:2bc:de8d:4ab1 with SMTP id
 w14-20020a2e300e000000b002bcde8d4ab1mr2533658ljw.6.1694615455860; Wed, 13 Sep
 2023 07:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115316.3652155-1-leitao@debian.org> <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com> <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com> <20230616153221.GI4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230616153221.GI4253@hirez.programming.kicks-ass.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 13 Sep 2023 16:30:44 +0200
Message-ID: <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Sandipan Das (AMD)" <sandipandas1990@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, ananth.narayan@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Sandipan,

Is there any update on this issue? We have hit the issue, and it makes
the server pretty unusable due to the thousands of Call Traces being
logged.

Thanks a lot!
Jirka


On Fri, Jun 16, 2023 at 5:34=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jun 16, 2023 at 08:13:22PM +0530, Sandipan Das (AMD) wrote:
> > The reserved bits should never be set. The purpose of the WARN_ON() is =
to catch such anomalies.
> > I am working out the details with Breno and will report back with a res=
olution.
>
> Thanks!
>


--=20
-Jirka

