Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691493290B0
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998161; cv=pass; b=gM5kIU8Jbp4YU+GOoaZlrDhbOezzVxXNeVbxwS4XlQxxa7cksCtBO1AzX62TIy1q31Rmb65NLu9sOT1AVKFfmDNAoYYbxdZQB0Tap5HiE9VaSsfhHLGNzj+b/RAeMxJYPncNBspP6Z4uIIDCAwR+daKpfrRhgMiS+6raGPkEIo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998161; c=relaxed/simple;
	bh=VVGQIOrbsvkmTNnzyPKWy5CnfBNQ761EWnOpmNHfENo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYBSb6VaRKrajgWU9fkWqzHvxIXdPLlDIsLKDlG4DwFmgOwk6DQOiv5XalaeXShJwzpxz/Q2ZPyZ3Z2JbldxltdoEf4FbJpVViX464UrVe/oTjFmvAQ2tuYeja3HMVsU/sZ3z4i0tUxnYHKWV4RIGzWa1FIsSq9i4L86T+ELFN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaXIQouY; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaXIQouY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso3615ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 12:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779998160; cv=none;
        d=google.com; s=arc-20240605;
        b=P5t6gOl+ioOwFN/z1YWlGDTnHN5dXb/0+lPmqtdYa4Kzr9TKWifr9KtGc5uXZFhOCm
         g7ajHBM38X+HbsSph4btZD7mKDnXMafV/nkZ9LtHdqLh7N7C16FdwLujFgmk016J94tF
         FKJAt5wqdJR4MFGfKEmlueVtjVZEsXIs5JhMj4t9GQdGJu7i66aCv40UsAHS9OM24q+S
         DnTx0xj5MUbuPcyGZzW5LDmvYRbA0MobM/5vr1s7AzExIaAa1Hh5mXTqol8uyVW3dzWP
         2DZ8hZCFC9csuZsEtUFdkIx3ryWVH2r6ASWiDefv6mmpx9WjB5LMA6qy+NvH5lpOq7Le
         SwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMY0nCuSq3Hi+T9n7w8VBBLt1r9hIh2INFD8HXrdbFo=;
        fh=IS40sBpt+oKN1J6h9AB7Ssd6aPp8JATYFgaM3D47Xaw=;
        b=II0wrbr6NbhA4/JyvElheOebKYc2G/1txxnGaz0pEmF74Hix6DfLD+vt2BwgFFuq2H
         +AZDbUVocydHakbFqPVbzCV5/1cWLU/66zYrFvOSf+ar2+vqub6YkQXvslC/xDlJ8iuI
         uhkLHuQW7IlvJ+Mox93UpNtzHe7c3KtRIS6970SF50fssqYC8ycTAvK0J69rrhyw6AAL
         a+NuHf5CQZSkAQ71rhv4ZjZBf6jVsCEWQH5sKQ44tPpAQGC+Fl7d0Nu8Few++FUwn3Cj
         28dl8fn0zUyMbMuhPBTfSitaK+t6c+K8QyDUXalIw4eEB6Vvq3vOzaBPPGlhMw4ppuOk
         j8jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779998160; x=1780602960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMY0nCuSq3Hi+T9n7w8VBBLt1r9hIh2INFD8HXrdbFo=;
        b=qaXIQouYfrR+wyt2xV64FLHbpP5RX18JGt1cUjtaHnbMIX9E1Av+tiFBPpp5rh8t7s
         /U5Kk2+0H5uyFRYlQ7GAR8VjMEJit04R0PFDQa9fLO4b2wS09uXaOIznoDpcVUvcblWH
         Qzeg7HrbC5O1YfHEHxpCNXYOU40LWIdt7ERtuwuLvBoB49mp9hae1NzO2+m7kKDjNycw
         Q9W3j/NuMNlvEXHznAA2OF8Zi9pxZPiI3ZLCmzK3HN+4leEdBUNYIBEjyJ1CsZ+3Sce5
         cYCW4Cv9RqsBF/Ui2AT/9cgy6+mgyOb7phbQ0kwwL/b0ahjBMammwNI4pQBIKRoneo/i
         t9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779998160; x=1780602960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMY0nCuSq3Hi+T9n7w8VBBLt1r9hIh2INFD8HXrdbFo=;
        b=FlIw4X0YEG3SnTqd6oOAmms2cnOhg+/J5+r1Sfnkd5Zs2+L/EB/gEfJ7Kk2XXnzZRf
         QdUbKsclk+0OFijbDjD+XcE6fhRdp0ZJSH9Jn8wiku5hZ0N7mkN+DowB+7wFS+PsrM26
         XGeY6A+bgLM3H0bVrQf2443HdBARs21+oRuQL0tHvhyCJZglIz+ih3rypyNTthm1J33U
         fr10gWnk+9o2xfSEwydTHaABt08sCMzuxrXPPAjjTyYX5P7q4qmM/JJoY8jIe8SVhC34
         m+nrEjC5ZaQACjdrY0pvlCCWaD59SugULZ85PbsxFrHz+yypFq3QRsCA5oL1FHJCYshk
         NpyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9y6CMTtMBRyr+iSOrgFPozNXNkFmy5guDO7OAujmD0R8AliazPrE9W6MIb8KTqfJ6UzYhaWqbqaPjLVKhM4Dtv@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSPIVsN30XOYSsD2FJYubqyyWPfkSFaiIGEJngI9zz5fpK3E2
	UgE66nDshKp2vCPeuOReELoC47nB82jagLY3RGJ1SGsZvDfmVrEP9mHCRrBtdQ9IaMxqpbi4Jgx
	w3mf5/mGdzuLgdoke6U3OUNcAuiuOnJkq1X1EYrMu
X-Gm-Gg: Acq92OGgKnu0rDxJktBowTuBQWljUgzgUZs8WVVLsDDimY85Pzh2ewT5iAEq9/nkknG
	7Ija6GVQOYtbeyjI0fwDZm3Wu7pod6dHUE4cmYukTPpCwMLA6cnbYtURKz7CELELY5hzYc0earA
	p/2z7lkmg+cpuVO3xdLEbbxJTweOOEV0B6wbiZC6EDkQvMo+z1IYmwnYeuBx6UQtA3hhU9MlXH+
	3VX4G4U+dxl4cNY2C0249N6Dapf5hjWROuj+tirjf1eFewIRH9krPKFpgAmycz0p4e7PF2tVTUN
	cy37o+3sKrwNj3KEiAk=
X-Received: by 2002:a17:903:1a0b:b0:2ba:73c3:49b0 with SMTP id
 d9443c01a7336-2bf20121492mr46885ad.14.1779998158846; Thu, 28 May 2026
 12:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahidF9--hJ7YXPiO@x1>
In-Reply-To: <ahidF9--hJ7YXPiO@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 May 2026 12:55:45 -0700
X-Gm-Features: AVHnY4JOW3y3Y6p6gDLx8iEVaaNhHkB0_2SsBEdlz-BBefeV2RuC83dPCyweR-I
Message-ID: <CAP-5=fUGaDGhvBU6z9hAuqFr5hpO9S-TKcW6bhwvjoA4j+xBRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests hwmon_pmu: Use PRIu64 + (u64) cast for a
 __u64 field to work more widely
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:53=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> While testing perf with an updated Debian experimental cross compiler
> (gcc version 14.2.0 (Debian 14.2.0-13)) this started failing:
>
>   In file included from tests/hwmon_pmu.c:12:
>   tests/hwmon_pmu.c: In function 'do_test':
>   tests/hwmon_pmu.c:199:34: error: format '%lld' expects argument of type=
 'long long int', but argument 7 has type '__u64' {aka 'long unsigned int'}=
 [-Werror=3Dformat=3D]
>     199 |                         pr_debug("FAILED %s:%d Unexpected confi=
g for '%s', %lld !=3D %ld\n",
>         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /git/perf-7.1.0-rc5/tools/perf/util/debug.h:20:21: note: in definition =
of macro 'pr_fmt'
>      20 | #define pr_fmt(fmt) fmt
>         |                     ^~~
>   tests/hwmon_pmu.c:199:25: note: in expansion of macro 'pr_debug'
>     199 |                         pr_debug("FAILED %s:%d Unexpected confi=
g for '%s', %lld !=3D %ld\n",
>         |                         ^~~~~~~~
>   tests/hwmon_pmu.c:199:79: note: format string is defined here
>     199 |                         pr_debug("FAILED %s:%d Unexpected confi=
g for '%s', %lld !=3D %ld\n",
>         |                                                                =
            ~~~^
>         |                                                                =
               |
>         |                                                                =
               long long int
>         |                                                                =
            %ld
>     LD      /tmp/build/perf/util/intel-pt-decoder/perf-util-in.o
>
> The usual make that %lld a PRIu64 (since arg7 is
> evsel->core.attr.config, which is a __u64) but then on Fedora 44 (gcc
> version 16.1.1 20260515 (Red Hat 16.1.1-2)) it ends up with:
>
>   In file included from tests/hwmon_pmu.c:13:
>   tests/hwmon_pmu.c: In function =E2=80=98do_test=E2=80=99:
>   tests/hwmon_pmu.c:200:34: error: format =E2=80=98%lu=E2=80=99 expects a=
rgument of type =E2=80=98long unsigned int=E2=80=99, but argument 7 has typ=
e =E2=80=98__u64=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} [-=
Werror=3Dformat=3D]
>     200 |                         pr_debug("FAILED %s:%d Unexpected confi=
g for '%s', %" PRIu64 " !=3D %ld\n",
>         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
>   /home/acme/git/perf-tools-next2/tools/perf/util/debug.h:20:21: note: in=
 definition of macro =E2=80=98pr_fmt=E2=80=99
>      20 | #define pr_fmt(fmt) fmt
>         |                     ^~~
>   tests/hwmon_pmu.c:200:25: note: in expansion of macro =E2=80=98pr_debug=
=E2=80=99
>     200 |                         pr_debug("FAILED %s:%d Unexpected confi=
g for '%s', %" PRIu64 " !=3D %ld\n",
>         |                         ^~~~~~~~
>   cc1: all warnings being treated as errors
>
> So the way to satisfy both compilers is to also add a (u64) cast to
> arg7.

As the inttypes.h definitions match stdint.h would it make more sense
to use uint64_t for the cast?

Thanks,
Ian

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/hwmon_pmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
> index ada6e445c4c41e1b..870d59c0f7cba2e7 100644
> --- a/tools/perf/tests/hwmon_pmu.c
> +++ b/tools/perf/tests/hwmon_pmu.c
> @@ -2,6 +2,7 @@
>  #include "hwmon_pmu.h"
>
>  #include <errno.h>
> +#include <inttypes.h>
>
>  #include <fcntl.h>
>  #include <linux/compiler.h>
> @@ -196,9 +197,9 @@ static int do_test(size_t i, bool with_pmu, bool with=
_alias)
>                         continue;
>
>                 if (evsel->core.attr.config !=3D (u64)test_events[i].key.=
type_and_num) {
> -                       pr_debug("FAILED %s:%d Unexpected config for '%s'=
, %lld !=3D %ld\n",
> +                       pr_debug("FAILED %s:%d Unexpected config for '%s'=
, %" PRIu64 " !=3D %ld\n",
>                                 __FILE__, __LINE__, str,
> -                               evsel->core.attr.config,
> +                               (u64)evsel->core.attr.config,
>                                 test_events[i].key.type_and_num);
>                         ret =3D TEST_FAIL;
>                         goto out;
> --
> 2.54.0
>
