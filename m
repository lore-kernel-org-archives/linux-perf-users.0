Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B1C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjEYXdq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 19:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjEYXdp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 19:33:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF4E12F
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 16:33:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75b0b5c9eb8so22577085a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685057621; x=1687649621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YzCxsRkWRgjvxa97wKSZh7dXjwpqx38ke3QcUo28Gw=;
        b=ONoFX+F4F2X86rv7VvsZSPoH94Bp5Dzmro4D2nJ5E9c9gbmHzGNlof9m0UU8/dRqOa
         jQBldMzlQOMjX4Gxl2prbhy/GHdyMkidFk2rmIdL8wbntZg/MZRW/lgJFx6jw+PCwC5p
         qN+oOZCLFqRhDHvnI2AIAY4lfka92actK8tzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057621; x=1687649621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzCxsRkWRgjvxa97wKSZh7dXjwpqx38ke3QcUo28Gw=;
        b=YFYizkvBSJEBdTuDCZTbu+cvJmc2+wf4kvUzOpkjVXHjNMYOg3w8OlgjPHOQO6IHiP
         75yJA9uEuA6Gjc/uDUAxtanY9AQGuAsdDhUjuTw/pusto9ujqIbVQI2dvu5TYrELp+cr
         y0kEclkCQ3TUXg5JgI5ALZb2jxOZZbLGewxvqZM2CTqhuH+C/0wR4CjjaG+wMDXDib2Q
         06JrVUCuBfELJXsFiQ5fyNZ4Ggxy0DRUxi7R40RpVDgEowmwKaonRR7dB9YmUepa7PNf
         b8YFKnQb/X/TsbH2tmL/yMJVlTKSQNhRdWRLJnlUbfU98XP/T6gVxK+0VZ/gv7YS44bS
         kPng==
X-Gm-Message-State: AC+VfDwpmu5T8Qwru+yWWRktEtf0xDA9F8PELX1AjmtW5DK1ancNGHk4
        fQKjIYex8HVV0HUN9TzcxHGC66QqzTSNtNdlQDc=
X-Google-Smtp-Source: ACHHUZ7bZ2g0s/xArRTtqNwbPo0Sz+UCyLDELn7xQkobewXY7r3hylRq5+TFC1GpjkHAYQFFmtQW7A==
X-Received: by 2002:a05:620a:8709:b0:75b:23a0:e7c9 with SMTP id px9-20020a05620a870900b0075b23a0e7c9mr356538qkn.42.1685057621355;
        Thu, 25 May 2023 16:33:41 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id e25-20020a05620a12d900b0075b13a89c30sm757994qkl.3.2023.05.25.16.33.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:33:41 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f804665702so83131cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 16:33:40 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c84:b0:331:a582:1c63 with SMTP id
 w4-20020a056e021c8400b00331a5821c63mr3274ill.3.1685057600304; Thu, 25 May
 2023 16:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.12.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid> <ZG4TW--j-DdSsUO6@alley>
In-Reply-To: <ZG4TW--j-DdSsUO6@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 16:33:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vu4BSec-kDxf8oS+DDcb+3W6RS-Z-Ouu-+sRnk2zhSrQ@mail.gmail.com>
Message-ID: <CAD=FV=Vu4BSec-kDxf8oS+DDcb+3W6RS-Z-Ouu-+sRnk2zhSrQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/18] watchdog/hardlockup: Rename some "NMI watchdog" constants/function
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, May 24, 2023 at 6:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-05-19 10:18:36, Douglas Anderson wrote:
> > Do a search and replace of:
> > - NMI_WATCHDOG_ENABLED =3D> WATCHDOG_HARDLOCKUP_ENABLED
> > - SOFT_WATCHDOG_ENABLED =3D> WATCHDOG_SOFTOCKUP_ENABLED
> > - watchdog_nmi_ =3D> watchdog_hardlockup_
> > - nmi_watchdog_available =3D> watchdog_hardlockup_available
> > - nmi_watchdog_user_enabled =3D> watchdog_hardlockup_user_enabled
> > - soft_watchdog_user_enabled =3D> watchdog_softlockup_user_enabled
> > - NMI_WATCHDOG_DEFAULT =3D> WATCHDOG_HARDLOCKUP_DEFAULT
> >
> > Then update a few comments near where names were changed.
> >
> > This is specifically to make it less confusing when we want to
> > introduce the buddy hardlockup detector, which isn't using NMIs. As
> > part of this, we sanitized a few names for consistency.
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -30,17 +30,17 @@
> >  static DEFINE_MUTEX(watchdog_mutex);
> >
> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WAT=
CHDOG)
> > -# define NMI_WATCHDOG_DEFAULT        1
> > +# define WATCHDOG_HARDLOCKUP_DEFAULT 1
> >  #else
> > -# define NMI_WATCHDOG_DEFAULT        0
> > +# define WATCHDOG_HARDLOCKUP_DEFAULT 0
> >  #endif
> >
> >  unsigned long __read_mostly watchdog_enabled;
> >  int __read_mostly watchdog_user_enabled =3D 1;
> > -int __read_mostly nmi_watchdog_user_enabled =3D NMI_WATCHDOG_DEFAULT;
> > -int __read_mostly soft_watchdog_user_enabled =3D 1;
> > +int __read_mostly watchdog_hardlockup_user_enabled =3D WATCHDOG_HARDLO=
CKUP_DEFAULT;
> > +int __read_mostly watchdog_softlockup_user_enabled =3D 1;
>
> I still see nmi_watchdog_user_enabled and soft_watchdog_user_enabled
> in include/linux/nmi.h. They are declared there and also mentioned
> in a comment.
>
> It seems that they do not actually need to be declared there.
> I guess that it was need for the /proc stuff. But it was
> moved into kernel/watchdog.c by the commit commit dd0693fdf054f2ed37
> ("watchdog: move watchdog sysctl interface to watchdog.c").
>
> >  int __read_mostly watchdog_thresh =3D 10;
> > -static int __read_mostly nmi_watchdog_available;
> > +static int __read_mostly watchdog_hardlockup_available;
> >
> >  struct cpumask watchdog_cpumask __read_mostly;
> >  unsigned long *watchdog_cpumask_bits =3D cpumask_bits(&watchdog_cpumas=
k);
>
> Otherwise, I like the changes.
>
> With the following:
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 83076bf70ce8..d14fe345eae9 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -17,8 +17,6 @@ void lockup_detector_soft_poweroff(void);
>  void lockup_detector_cleanup(void);
>
>  extern int watchdog_user_enabled;
> -extern int nmi_watchdog_user_enabled;
> -extern int soft_watchdog_user_enabled;
>  extern int watchdog_thresh;
>  extern unsigned long watchdog_enabled;
>
> @@ -68,8 +66,8 @@ static inline void reset_hung_task_detector(void) { }
>   * 'watchdog_enabled' variable. Each lockup detector has its dedicated b=
it -
>   * bit 0 for the hard lockup detector and bit 1 for the soft lockup dete=
ctor.
>   *
> - * 'watchdog_user_enabled', 'nmi_watchdog_user_enabled' and
> - * 'soft_watchdog_user_enabled' are variables that are only used as an
> + * 'watchdog_user_enabled', 'watchdog_hardlockup_user_enabled' and
> + * 'watchdog_softlockup_user_enabled' are variables that are only used a=
s an
>   * 'interface' between the parameters in /proc/sys/kernel and the intern=
al
>   * state bits in 'watchdog_enabled'. The 'watchdog_thresh' variable is
>   * handled differently because its value is not boolean, and the lockup
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Even better might be to remove the unused declaration in a separate
> patch. I think that more declarations are not needed after moving
> the /proc stuff into kernel/watchdog.c.
>
> But it might also be fixed later.

Breadcrumbs: I squashed your suggestion together with Tom's patch and
posted the result:

https://lore.kernel.org/r/20230525162822.1.I0fb41d138d158c9230573eaa37dc56a=
fa2fb14ee@changeid

-Doug
