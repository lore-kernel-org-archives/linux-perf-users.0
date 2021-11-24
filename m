Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03157C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 00:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhKXAGN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 19:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbhKXAGN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 19:06:13 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0354C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 16:03:04 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z26so843580iod.10
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 16:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oc4SpM7wg3bYNLnPBYyNuwZV0M6LV5LKztj1k1DfLA4=;
        b=o07trBniGLeNffSg8eCbyVO4eMWabd8ua7FT9Lx4uKiZSqzT6pxkzxBngwYto4rBEo
         P1clLQlbtUf98uFx1kfOot8kM0KcO3kGw3bNTbaaEEBr+9Yra/SW+Bw6cJkomCFU6cz+
         9m2sn/+1V2+GWP8flqrPA5rNgvtYg2y7ffTn8IgzUycqfjWHkKCLcfkWegDQdfTptTIQ
         SGHLuYDqf45w09Se+StoH6iHr+7cCK39AjAYEDafg6hDKLSkOrnHgcAhkRuMYhg4BoMG
         VGpevoujkeco03Y/2Dg0qBY/1cawZkbCcC6lk59wFg94U+gqoekxJiAR29yiiu/Y7W5J
         arMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oc4SpM7wg3bYNLnPBYyNuwZV0M6LV5LKztj1k1DfLA4=;
        b=dRUXoHdKtDKKNrqZrOryu3SeVxzuJcyXKBmHq3Ycgm4TehaAYo42B6ZAHNIGsOVeQi
         qbDAzVzpNdTYY6nYjZAGURgzLEIYrS1ilT/mwqQI8LPCQlnAl5geg2LY+RlqJR1qM44q
         ES8YWexobXbjxOsfREqWS+lBAKX2Mg0i96m+KeyfkKlipClWspAevJXz1fJ8r0GT/Ltv
         +orKlUget6OJ4G82X3polWxeGAWtZXq8qDepfdjB4SUDcTRsDUcGGvWg6R4/BW/4I+j0
         97t4I10A5ZzyHAE5cSuUDTv4TQ50hdU0yIVrBrX8wsXL4D9r5Sg2OPS74tbjCPSDKpBh
         v4vQ==
X-Gm-Message-State: AOAM533T9yveZXVUPZfa2np2WI24Rq/gSdyAOHCrcgXLHlEFspxN0gbH
        DN8cHdRt+jmDPMst2bQ1yc71n7VOW3vO5c+ZW7jdQA==
X-Google-Smtp-Source: ABdhPJxiyjw1BIh+of+YLYTPV0KhjH8cmwFy/94059bmov5sSmPkPraVeZO2Dwc/nLr4hZYCUvQYUnXtHNfhHsUJEPg=
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr10000980iow.35.1637712184217;
 Tue, 23 Nov 2021 16:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20211123224821.3258649-1-irogers@google.com> <20211123224821.3258649-2-irogers@google.com>
 <YZ16mRRu7HZzUlYe@kernel.org>
In-Reply-To: <YZ16mRRu7HZzUlYe@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 23 Nov 2021 16:02:51 -0800
Message-ID: <CAP-5=fWOqj_3vkZEC2SV6oW==M1Kx+ajnkjw5D5f4-mtzicofQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Fix SMT not detected with large core count
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 23, 2021 at 3:34 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Nov 23, 2021 at 02:48:20PM -0800, Ian Rogers escreveu:
> > sysfs__read_int returns 0 on success, and so the fast read path was
> > always failing.
>
> Please split this into two patches, the above part should be in one, and
> the strtoull in another.

Will do.

> Also can't we just do as ./tools/perf/util/cputopo.c and use instead
> core_cpus_list?

It is more complex for the list case as the list may have a range. It
shouldn't really matter with the active fix in any case. I think
ideally we'd have an abstraction like cpuset in util-linux:
https://github.com/util-linux/util-linux/blob/master/lib/cpuset.c
This is a bit beyond what I'm trying to fix here.

Thanks,
Ian

> On a 5950x:
>
> =E2=AC=A2[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu31/topology/=
core_cpus
> 80008000
> =E2=AC=A2[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu31/topology/=
core_cpus_list
> 15,31
> =E2=AC=A2[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu0/topology/c=
ore_cpus
> 00010001
> =E2=AC=A2[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu0/topology/c=
ore_cpus_list
> 0,16
> =E2=AC=A2[acme@toolbox perf]$
>
> - Arnaldo
>
> > strtoull can only read a 64-bit bitmap. On an AMD EPYC core_cpus may lo=
ok
> > like:
> > 00000000,00000000,00000000,00000001,00000000,00000000,00000000,00000001
> > and so the sibling wasn't spotted. Fix by writing a simple hweight stri=
ng
> > parser.
> >
> > Fixes: bb629484d924 (perf tools: Simplify checking if SMT is active.)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/smt.c | 68 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 58 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> > index 20bacd5972ad..2636be65305a 100644
> > --- a/tools/perf/util/smt.c
> > +++ b/tools/perf/util/smt.c
> > @@ -5,6 +5,56 @@
> >  #include "api/fs/fs.h"
> >  #include "smt.h"
> >
> > +/**
> > + * hweight_str - Returns the number of bits set in str. Stops at first=
 non-hex
> > + *          or ',' character.
> > + */
> > +static int hweight_str(char *str)
> > +{
> > +     int result =3D 0;
> > +
> > +     while (*str) {
> > +             switch (*str++) {
> > +             case '0':
> > +             case ',':
> > +                     break;
> > +             case '1':
> > +             case '2':
> > +             case '4':
> > +             case '8':
> > +                     result++;
> > +                     break;
> > +             case '3':
> > +             case '5':
> > +             case '6':
> > +             case '9':
> > +             case 'a':
> > +             case 'A':
> > +             case 'c':
> > +             case 'C':
> > +                     result +=3D 2;
> > +                     break;
> > +             case '7':
> > +             case 'b':
> > +             case 'B':
> > +             case 'd':
> > +             case 'D':
> > +             case 'e':
> > +             case 'E':
> > +                     result +=3D 3;
> > +                     break;
> > +             case 'f':
> > +             case 'F':
> > +                     result +=3D 4;
> > +                     break;
> > +             default:
> > +                     goto done;
> > +             }
> > +     }
> > +done:
> > +     return result;
> > +}
> > +
> >  int smt_on(void)
> >  {
> >       static bool cached;
> > @@ -15,9 +65,12 @@ int smt_on(void)
> >       if (cached)
> >               return cached_result;
> >
> > -     if (sysfs__read_int("devices/system/cpu/smt/active", &cached_resu=
lt) > 0)
> > -             goto done;
> > +     if (sysfs__read_int("devices/system/cpu/smt/active", &cached_resu=
lt) >=3D 0) {
> > +             cached =3D true;
> > +             return cached_result;
> > +     }
> >
> > +     cached_result =3D 0;
> >       ncpu =3D sysconf(_SC_NPROCESSORS_CONF);
> >       for (cpu =3D 0; cpu < ncpu; cpu++) {
> >               unsigned long long siblings;
> > @@ -35,18 +88,13 @@ int smt_on(void)
> >                               continue;
> >               }
> >               /* Entry is hex, but does not have 0x, so need custom par=
ser */
> > -             siblings =3D strtoull(str, NULL, 16);
> > +             siblings =3D hweight_str(str);
> >               free(str);
> > -             if (hweight64(siblings) > 1) {
> > +             if (siblings > 1) {
> >                       cached_result =3D 1;
> > -                     cached =3D true;
> >                       break;
> >               }
> >       }
> > -     if (!cached) {
> > -             cached_result =3D 0;
> > -done:
> > -             cached =3D true;
> > -     }
> > +     cached =3D true;
> >       return cached_result;
> >  }
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
>
> --
>
> - Arnaldo
