Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E5346E56
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074429; cv=pass; b=kmTKoayEqk+mlkMuXNPmqSiLA8Ep6aZTYPd7QJ8OiyRqzIw54H5OjfoMjORG5QhTn488KrboMTbdquSl3D+cAtrvWPXd2Sg1ztCllLHL2xSCaTv7kNqW6vNbklsyDGlNfeLWJdTjObtuH3frmzTSKOZX+GmcIUZkiYxkrkthRXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074429; c=relaxed/simple;
	bh=Lj+R466yzYuE75ZfH8uQjT5GpOm9hIb8Ad09LLAT+6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeC2ErrcXioWJIJH9zY61Ea5NaYsVCEFEGEjPRdAsQlbHud/CZqSpKwTq2+As9Rm7zcRO3ddfeZ181cedXX4uKb1g5NhiEXywiPB8pf4qmOqz12NGlFvJwAjwnPWbUISwNkFfKiJ4mFK/xfK9C3Ac7b1nnZGvBCnEHi1ypchhKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuBX2dKw; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuBX2dKw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b0b260d309so5075ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074427; cv=none;
        d=google.com; s=arc-20240605;
        b=VQeBSuy0ND8gIHHVAWK0ZHcl8daPgnh7lE0yWm7sPMXeJDTokEKsTEbE2I8W+GsNEN
         RpXhnctACaLBYMlakV8ws96HfdkJwHwkfuBVEKBjOOIEVp9WEG7Rw6/spBfePnIh5wYH
         3yrTQxWfpcknF8cCDyOWtsLdoPIgEzkoCsvoovP8C5iYC+O0myD+CBjAb9ASRXDmMa5S
         AyVK/M7ZOl5A1Au7e8pNgQ180YuZDTMW4rQ2YfyKgswBBUu5295HAnP+11LuKvJZ9LZa
         4P8yAQYi5sNsEMeRbsEN369DkIWpw3XiJ2y5OI/g/IbqVzn5uwoIm8W9lRUXM3PoOzDo
         +DWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3oBuMrbNOeFeRMC6Ls8GgwmmvSyk++fp1ZAZivpZOtc=;
        fh=lMv8ZVI+LFet3SFxclY8BbDKvoJqRaMriSrR10VjWeQ=;
        b=S+QYQq4LrOe5psaun67ROb9LcjEtj6eCv5Qm9d6KWh+5/92RyamY8ZAQr1OE+sZRTD
         mq2iUrFcO3vdaAVy1MACFsYEMZs2aCnNbwoxQeUjKNfYQsBjcD1icm+FMZKQjYAYG6BL
         LiXBh6rpU3X7fTNZUs9ZnDzIFJ0ka2d4Vc4sxRc9XihKpyRjS5RWtBdSsKr1WwEX1Xwc
         +S1zJBAnEIQ5PXKCU5ceBejX/t8ATnefaCpriUYQaAbtfGJsvzXke4ziiQaBIQlyQ0g9
         GHMoVvuWufTKz6K5JTLrRAqyTprmTCawEKW0FSJRh3lhK65zqUDdD26E5DQeeqb1zl3H
         DMCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074427; x=1775679227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oBuMrbNOeFeRMC6Ls8GgwmmvSyk++fp1ZAZivpZOtc=;
        b=cuBX2dKwmiZyVCD6ZeNboULrDX1x/56e2Pc1eI+f1gqLYpBkqGhXpKBRcbYFw1V7Pn
         w7KQjgjrotNU4m6qj8BlqsxJf2t4y894Z8ld2uiSs9FVZFC0OJsbig7sgLBZ5PRGkNRj
         n2ux8x+o/dZkTJpG06IEgRYSsyB0Jo5ENyHkArK6QqgFwtltwe1sWrhNXsFrlVPZN/w8
         zHHRQu13ltOJdqMpMUB3MkeTeFuOJiC4Zc7UCzzrVEkLzvBtZtQ7bDhT0OWbh5sQRy7k
         ukTaKLRBSyiEPP4zCWDn2ma0DFd1WG2tpXcAjM7KIPrvec3uiocTeGQVvag6NXviMRwq
         kmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074427; x=1775679227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3oBuMrbNOeFeRMC6Ls8GgwmmvSyk++fp1ZAZivpZOtc=;
        b=DRkVIE2Y5XJIejMpTDRKHnhkMb4VAfJaElwb8qy8E0p5GZGds0BKImb6b5iz942KZX
         eDRBv35+f3IGdhiXLM6UCCEOMuew/id30FTdcTXG9jF+9vmS3D/Q8fXFFIYq+pyCiaCm
         AT8Ye0nEhFxR3inlSTntVBsQVffYTnX/AgOy2Y2sWbLEdLESqAeYsJxIvtE1CUItRzeY
         3kIElAM8Swl4ByiJwIRtaavIs03Pm4zXC00H/SNK5XCeaO6pc0pk15Yif9QUdNDQUBkw
         RXifLZfbrhbeDh2K7sLNoV1XVwbdxbb3bFP7T+lyLFj3Q6hKRxltY5pR0JWz0MDiGZot
         yRog==
X-Forwarded-Encrypted: i=1; AJvYcCVuYuEtKbwWj8Jv99YzKXNd0q+/OIN3Qu5nI0ktiSXElScbQS6jBPFitMcBvU9+bx9uPikyHm7RXzrwuXS2KyNU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2FGF49qgjs374zz2QS0wTD3y/3H5S7Dep1uogkT7eLzKWdrN
	IRShIVVqMzspH0oBMP81jRgTRff0nY5AalPwSVgrsPuev7opXGWjIJjaMG78AYtbL42k21NDSZ8
	X2yuphqlnz5EpXqqSIX/8UgRBwRcLEHAe9dmknKtL
X-Gm-Gg: ATEYQzxX34VmU5OrHo5RrLkMY02S9vNlRVVaiyB3MC4Li2J0spks6gVWyji/3cYNrp1
	8r10FzIeStwY5mVqxMpDrUIhAEzyEoELpAJrvPOTHWBhe5noKMeoVaanwKr3xC4kTTCEhK8yxLD
	kCOLGuHXwm7vUCS4Ev8VITX1ppsfa4yJL8xULuieldKQGeZ+pR1ZF+Ff3gcc4q8vhwp+BGrtL7H
	WgOJF46+Yu/YbqNpekp1uXH3HcXmpF/JFLqobcN+4LDVf9mOeoH6jyAkj2kqZmxTSatwwyLqHDD
	75hD45FkW8cwJEGYGsEy+aUKWNbqnLcQbBTh
X-Received: by 2002:a17:903:1210:b0:2b0:9a61:9d9 with SMTP id
 d9443c01a7336-2b2769ff14bmr387355ad.9.1775074427053; Wed, 01 Apr 2026
 13:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com>
 <20260325120627.1841175-2-tmricht@linux.ibm.com> <CAP-5=fXBoKMp1COEHVtSiu_kRvELqBpFDZ7_m05y=MFqDhk0yA@mail.gmail.com>
In-Reply-To: <CAP-5=fXBoKMp1COEHVtSiu_kRvELqBpFDZ7_m05y=MFqDhk0yA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:13:35 -0700
X-Gm-Features: AQROBzAK4Qk9hAJXi7SMmrQptfDmYITsHb3dwfqkPpfw3-Zl_GSuDOExIrDOb70
Message-ID: <CAP-5=fXmTa-s5fTUg+x4hJa4kiJ5bCTVHy7c4L7mBE72Xk+EWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf config: Rename symbol_conf::disable_add2line_warn
To: namhyung@kernel.org, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Mar 25, 2026 at 5:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > Rename member symbol_conf::disable_add2line_warn to
> > symbol_conf::addr2line_disable_warn to make it consistent with other
> > addr2line_xxx constants.
> > No functional change.
> >
> > Fixes: 257046a36750a ("perf srcline: Fallback between addr2line impleme=
ntations")
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Ping. Thanks,
Ian

> Thanks,
> Ian
>
> > ---
> >  tools/perf/builtin-diff.c     |  4 ++--
> >  tools/perf/util/addr2line.c   | 12 ++++++------
> >  tools/perf/util/block-info.c  |  2 +-
> >  tools/perf/util/libbfd.c      |  2 +-
> >  tools/perf/util/symbol_conf.h |  2 +-
> >  5 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index 59bf1f72d12e..8a93e56f4a7e 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -1353,7 +1353,7 @@ static int cycles_printf(struct hist_entry *he, s=
truct hist_entry *pair,
> >         /*
> >          * Avoid printing the warning "addr2line_init failed for ..."
> >          */
> > -       symbol_conf.disable_add2line_warn =3D true;
> > +       symbol_conf.addr2line_disable_warn =3D true;
> >
> >         bi =3D block_he->block_info;
> >
> > @@ -1987,7 +1987,7 @@ int cmd_diff(int argc, const char **argv)
> >
> >         if (compute =3D=3D COMPUTE_STREAM) {
> >                 symbol_conf.show_branchflag_count =3D true;
> > -               symbol_conf.disable_add2line_warn =3D true;
> > +               symbol_conf.addr2line_disable_warn =3D true;
> >                 callchain_param.mode =3D CHAIN_FLAT;
> >                 callchain_param.key =3D CCKEY_SRCLINE;
> >                 callchain_param.branch_callstack =3D 1;
> > diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> > index 31c0391fffa3..e9f084db0802 100644
> > --- a/tools/perf/util/addr2line.c
> > +++ b/tools/perf/util/addr2line.c
> > @@ -123,7 +123,7 @@ static enum cmd_a2l_style cmd_addr2line_configure(s=
truct child_process *a2l, con
> >                         lines =3D 3;
> >                         pr_debug3("Detected binutils addr2line style\n"=
);
> >                 } else {
> > -                       if (!symbol_conf.disable_add2line_warn) {
> > +                       if (!symbol_conf.addr2line_disable_warn) {
> >                                 char *output =3D NULL;
> >                                 size_t output_len;
> >
> > @@ -310,7 +310,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >         }
> >
> >         if (a2l =3D=3D NULL) {
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("%s %s: addr2line_subprocess_init fa=
iled\n", __func__, dso_name);
> >                 goto out;
> >         }
> > @@ -330,7 +330,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >         len =3D snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
> >         written =3D len > 0 ? write(a2l->in, buf, len) : -1;
> >         if (written !=3D len) {
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("%s %s: could not send request\n", _=
_func__, dso_name);
> >                 goto out;
> >         }
> > @@ -339,7 +339,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >         switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, add=
r, /*first=3D*/true,
> >                                       &record_function, &record_filenam=
e, &record_line_nr)) {
> >         case -1:
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("%s %s: could not read first record\=
n", __func__, dso_name);
> >                 goto out;
> >         case 0:
> > @@ -355,7 +355,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >                                               /*addr=3D*/1, /*first=3D*=
/true,
> >                                               NULL, NULL, NULL)) {
> >                 case -1:
> > -                       if (!symbol_conf.disable_add2line_warn)
> > +                       if (!symbol_conf.addr2line_disable_warn)
> >                                 pr_warning("%s %s: could not read senti=
nel record\n",
> >                                            __func__, dso_name);
> >                         break;
> > @@ -363,7 +363,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
> >                         /* The sentinel as expected. */
> >                         break;
> >                 default:
> > -                       if (!symbol_conf.disable_add2line_warn)
> > +                       if (!symbol_conf.addr2line_disable_warn)
> >                                 pr_warning("%s %s: unexpected record in=
stead of sentinel",
> >                                            __func__, dso_name);
> >                         break;
> > diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.=
c
> > index 649392bee7ed..8d3a9a661f26 100644
> > --- a/tools/perf/util/block-info.c
> > +++ b/tools/perf/util/block-info.c
> > @@ -303,7 +303,7 @@ static int block_range_entry(struct perf_hpp_fmt *f=
mt, struct perf_hpp *hpp,
> >         char buf[128];
> >         char *start_line, *end_line;
> >
> > -       symbol_conf.disable_add2line_warn =3D true;
> > +       symbol_conf.addr2line_disable_warn =3D true;
> >
> >         start_line =3D map__srcline(he->ms.map, bi->sym->start + bi->st=
art,
> >                                   he->ms.sym);
> > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > index 63ea3fb53e77..c1c12308cc12 100644
> > --- a/tools/perf/util/libbfd.c
> > +++ b/tools/perf/util/libbfd.c
> > @@ -233,7 +233,7 @@ int libbfd__addr2line(const char *dso_name, u64 add=
r,
> >         }
> >
> >         if (a2l =3D=3D NULL) {
> > -               if (!symbol_conf.disable_add2line_warn)
> > +               if (!symbol_conf.addr2line_disable_warn)
> >                         pr_warning("addr2line_init failed for %s\n", ds=
o_name);
> >                 return 0;
> >         }
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index 71bb17372a6c..ff229942fbb1 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -51,7 +51,7 @@ struct symbol_conf {
> >                         report_block,
> >                         report_individual_block,
> >                         inline_name,
> > -                       disable_add2line_warn,
> > +                       addr2line_disable_warn,
> >                         no_buildid_mmap2,
> >                         guest_code,
> >                         lazy_load_kernel_maps,
> > --
> > 2.53.0
> >
