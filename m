Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AD212554
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257673; cv=pass; b=WGPs4OkCbwpWOvgUFWSKa7Pnut6Hq15EXQLhNdm8AFHaP4ndlLpBmSICvJjvs62JwDP9XjrLxX3wM8+rl5t1sulQGgTbtnMsyc1u7WO6rEaaVJwKbLz0R896vU/ltlKQR+HHikIUNccrZCrg6UqCUhNsfMN7MpGr1mII0ZicHkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257673; c=relaxed/simple;
	bh=eaakX1+8OcipDdQQXrHzBK7Gy+7JgN/zV2K84QtPL64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZzjZfwhjKfzNsd28/XeKDB3tP0a7fgOT8SSr1SOwCCaAO2p0T3F7u9TO68ew81Rk5WaFeg3UpgIFPWI/kxQSRxjsWRWd4URz5VkeXOTW/FEIGV9p+gINSC51sWJ4Us4TggPsoqSjkYsAe3ptmirlOwfVmJWhyao2zzeLwRVMrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLkFF1tN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScJc9dfl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLkFF1tN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScJc9dfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770257671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhr8vWIGYF1FOYr/E/NNfQt7aE42qa44oS7zq9va7TE=;
	b=fLkFF1tNke+gz2YL1hfuD94kWsjnc9EgD/11Xd/k96QUiWqyXVqwbf4E8MI2W76eXr7ZGG
	LGjmPx9RF9B/u/+qjzV6MLfR1CLlFDAnlwjA/E+9Jz+aOEDt2D9NSIVfw9btwpXFaX0DtE
	jtFO6hpVcqboVkI9+fsvt4c0y9qF9uk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-lGY0F6x_PxWodKyA9IeG0g-1; Wed, 04 Feb 2026 21:14:30 -0500
X-MC-Unique: lGY0F6x_PxWodKyA9IeG0g-1
X-Mimecast-MFC-AGG-ID: lGY0F6x_PxWodKyA9IeG0g_1770257670
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-66308f16ea1so1545643eaf.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 18:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770257669; cv=none;
        d=google.com; s=arc-20240605;
        b=S1uASVzgSt9yXF/8yrNhBv/jnELFJa6k2dKIx2ipHaZgkacCYFmyTjaYNV2ZdLBGxm
         9i9wlE6JrP1l4c9YGU4QcCRmIKfdCXYo2sbcpMjcoqCJ8eohXk1gv1xWexT03H3wAR3u
         uFYD8kdnx3RSYUZPQImn4OuqKMgV5zk3PG+VYKxNFKyEpjtVb6S4ITghgCFfBBotoMer
         Vb5+fYaQZfzYJmFXLumgRG7Bu4q4bK0o7+VPBCp1eUxmdnjZDipWeDfcTp7v9WptNXQ1
         zvvjWeBR4iUkFbTp4qngUSmF0exe6z+FG6lxg5ERVBTumCMNLBJhf/3r8QqFgzqnNOyH
         +COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhr8vWIGYF1FOYr/E/NNfQt7aE42qa44oS7zq9va7TE=;
        fh=LPRGDr5GRFmxCsOcp9l8FtH+PT8DqEpcIV/eHQGMKYQ=;
        b=R9HlDPM7ErWBpeu0VG8UGMTDaBupEpFg2x4FmgyK1WTxtNqL8ZHHZvxC35QEKmYySN
         FYlkXtJROPBK+L3IJXyG1XjyHb8e4EISLLx5rYzcNDPp1d4CxnUMW7qaYeH1tDNCdJVn
         lOMIoisSOso4b2HK719dV2LH8+yXOLkDjdlb/exZCu1WmGfDj43IRxYkkPGvaxNgaTRh
         MnKw36u3TR7ccHQFZAFM9Q7o0e7yEEmIQxVSrAbRcu+jCGs1ksiJlO5nW5uBtRoyYBK9
         d3cemI65kIUvHw7txnq+Dm8HS5ZqSK32OI2vuOz8J9qLQVMvXwzhV0FsaQVXuQcvi0KV
         asVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770257669; x=1770862469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhr8vWIGYF1FOYr/E/NNfQt7aE42qa44oS7zq9va7TE=;
        b=ScJc9dflOuXKPpcYveiAZrXfDZPopUsyUDF2pVeJUq7zk4Q+fDMbnv97752oD/Mr+k
         kq8N7yyNnXmUXJTgHW2xyltqb22k7Koy+wjcnetfbcoWfgmk8YrgDzCR5dTDU8MPaSuQ
         WiYSadrm9mOSMUHuI5juSnWiq4uaYSgIOoZYFHoY/JSWeYfiJ1vihZbeZYDFMlNBChw7
         H+oIOKmzQwadVSkz+cCo8J2yzKR238cvovCg0EUr4O4KPyP5VZTMxfiE31bjvzGsbwDV
         tOlTYWDIrUU8v91mFUZva+yiFls64DABlDS5D9cOdWltHwGCj/yTmUZJ8E+85JFdEeqN
         Axrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770257669; x=1770862469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhr8vWIGYF1FOYr/E/NNfQt7aE42qa44oS7zq9va7TE=;
        b=fKABclVSGBgJnAHYkgvZtHpwc+dZif/HCMptfpCbStaoEQ2snPmQXkCVkau6XZNZ3d
         bbLDDJrg1VygKG7b7xBu8H1XFFEA/dDRnY6F8szJqgh2Vakh8/8yCpg5uoB9xVVm3Rn9
         q08Ytmqq67eRRrbElMjOSEbR86h1HVIOUlkvv086A6Uqrj5fe8/IfS/Aic/JzVyudUFF
         06wSwNcYtMoe7g0APBwalDTfcIuE50JgKFzsW3Hx/beVD3xWgoBM+ecwu+Pp/BJkGfo9
         b2l7kf/56C44fYCq4cOQXtnA0g41fMlmdjGzg3NQO+KwkQZcqa4DtUwutaSMiuaDwMNh
         Hp+w==
X-Forwarded-Encrypted: i=1; AJvYcCXIJCg23NlLeBgniYk+ctY+OAwM+/73J7jiPizTmlWqFg3waPYGwZk36/nt8Zm0LwARWZX/qdTLOTJFK+aViAH6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0uMXsudjOyTPbEdX+jE86CeuUFnb9vEdIMS4jdcTytTdb3vJ
	K2qlTensBz5exMcx/9U+aUY7Zy3qiGdvXWz3j4I0eSonGYQOGWEZrzyOJ9aissfV//2eefPRJ1W
	L/Uxn8zN/W/O2Rdk76XVe+661WXGRLMPCDrNsTTI4DO6brwDAdTJaMRbTBpbpApo/Ga6CNWzRiW
	O87YBAdzmkdb7LUwNWezkaUhnxcC/ph10me7D5nYVDDpjKLQ==
X-Gm-Gg: AZuq6aLBZS1sArVM3zl321EW5DbNffineYH+WTCHBHpIOkXI6bvR2t21GtZqi7qpUiB
	U6zihKgqfOg5ME4WBDUETaXSzeZdcn/QPSWFgpBsqCkSaDTqhteahECsm8d9WSBiV2iZYLhmJGi
	A5YE2JAxR8ugy/s9WX7e/HgcywQBCGPu8W6kzXMr/iXEJZg9Rnr+2bFwyQve1lWQp1kg8=
X-Received: by 2002:a05:6820:f012:b0:65f:335d:e2ed with SMTP id 006d021491bc7-66a23a0ac81mr2399232eaf.74.1770257669556;
        Wed, 04 Feb 2026 18:14:29 -0800 (PST)
X-Received: by 2002:a05:6820:f012:b0:65f:335d:e2ed with SMTP id
 006d021491bc7-66a23a0ac81mr2399222eaf.74.1770257669159; Wed, 04 Feb 2026
 18:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203141608.14128-1-qzhao@redhat.com> <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
In-Reply-To: <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
From: Qiao Zhao <qzhao@redhat.com>
Date: Thu, 5 Feb 2026 10:14:18 +0800
X-Gm-Features: AZwV_QiL-D4Skszb4fy8oKYjHx3iM1u38Bn0nltd8KoVcdZ1UGdLSP3e5GeNF0o
Message-ID: <CAATMXfm88MZ3Fhc0upRQ_5D2Vy+g8CscVAwhfY7nbM9oX93Qvw@mail.gmail.com>
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, leo.yan@linux.dev, 
	namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org, 
	vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

Thanks for the review and the question.

I did try modifying the check according to your suggestion, i.e. changing
the condition like:
+      if (!rdpmc_supported && (pc->cap_user_rdpmc || pc->index)) {
However, with this change the tests regress on ARM, the results are:
--- start ---
User space counter reading 1
User space counter reading for PMU armv8_pmuv3_0
User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
unsupported counter access 1]
---- end ----
126.4: User space counter disabling instructions                     : FAIL=
ED!
--- start ---
User space counter reading 0
User space counter reading for PMU armv8_pmuv3_0
User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
unsupported counter access 1]
---- end ----
126.5: User space counter disabling cycles                           : FAIL=
ED!

On ARM, cap_user_rdpmc represents a PMU capability and may remain
set even when user rdpmc access is disabled via sysfs/sysctl. In that case
the mmap page reports: cap_user_rdpmc =3D 1 and index =3D 0, which is an
expected and valid state when rdpmc is disabled.
The intention of the existing check: if (!rdpmc_supported &&
pc->cap_user_rdpmc && pc->index) is only to catch the inconsistent case
where rdpmc is reported as unsupported, but the mmap page still exposes
a fully usable rdpmc state (i.e. both capability and a valid PMC index). Th=
is
avoids flagging the ARM case above while still detecting real inconsistenci=
es.

With the current logic, the tests now either pass or are skipped as expecte=
d
on ARM, and there is no behavior change observed on x86_64.

Thanks,
Qiao

On Wed, Feb 4, 2026 at 5:40=E2=80=AFPM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 03/02/2026 2:16 pm, Qiao Zhao wrote:
> > Some architectures control user-space rdpmc access via sysfs or sysctl,
> > for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
> > rdpmc attribute under event_source devices on x86_64.
> >
> > The mmap-based rdpmc tests currently assume rdpmc availability purely
> > based on perf_event configuration, which leads to false failures when
> > the system globally disables rdpmc access.
> >
> > Introduce a helper to detect rdpmc availability via sysfs and skip
> > user space counter reading tests when rdpmc is disabled by the system.
> >
> > The check is only applied to USER_READ_ENABLED tests. User-read disable=
d
> > tests continue to run unconditionally, as they validate perf_event mmap
> > semantics independent of rdpmc availability.
> >
> > Additionally, tighten the unsupported rdpmc check to require a valid
> > counter index, avoiding false failures when cap_user_rdpmc is set but
> > no counter is assigned.
> >
> > v1->v2
> > - Check rdpmc availability via sysfs before running USER_READ_ENABLED t=
ests
> > - Handle both perf_user_access and rdpmc sysfs interfaces
> > - Avoid false failures when cap_user_rdpmc is set but no counter index =
exists
> >
> > Testing:
> > - arm64: rdpmc disabled by perf_user_access (tests correctly skipped)
> > - x86_64: no behavior change compared to v1
> >
> > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > ---
> >   tools/perf/tests/mmap-basic.c | 45 +++++++++++++++++++++++++++++++++-=
-
> >   1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basi=
c.c
> > index 3313c236104e..67d6d83dbedb 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -220,6 +220,37 @@ static enum user_read_state set_user_read(struct p=
erf_pmu *pmu, enum user_read_s
> >       return old_user_read;
> >   }
> >
> > +static bool rdpmc_sysfs_enabled(struct perf_pmu *pmu)
> > +{
> > +     char buf[8];
> > +     int events_fd, fd;
> > +     ssize_t len;
> > +
> > +     /* ARM/RISC-V style or similar */
> > +     fd =3D open("/proc/sys/kernel/perf_user_access", O_RDONLY);
> > +     if (fd > 0) {
> > +             len =3D read(fd, buf, sizeof(buf));
> > +             close(fd);
> > +             if (len > 0)
> > +                     return buf[0] =3D=3D '1';
> > +     }
> > +
> > +     /* x86_64 style rdpmc file or similar */
> > +     events_fd =3D perf_pmu__event_source_devices_fd();
> > +     if (events_fd >=3D 0) {
> > +             fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc=
", O_RDONLY);
> > +             close(events_fd);
> > +             if (fd >=3D 0) {
> > +                     len =3D read(fd, buf, sizeof(buf));
> > +                     close(fd);
> > +                     if (len > 0)
> > +                             return buf[0] =3D=3D '1';
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >   static int test_stat_user_read(u64 event, enum user_read_state enable=
d)
> >   {
> >       struct perf_pmu *pmu =3D NULL;
> > @@ -247,7 +278,7 @@ static int test_stat_user_read(u64 event, enum user=
_read_state enabled)
> >               struct perf_evsel *evsel =3D NULL;
> >               int err;
> >               struct perf_event_mmap_page *pc;
> > -             bool mapped =3D false, opened =3D false, rdpmc_supported;
> > +             bool mapped =3D false, opened =3D false, rdpmc_supported,=
 sysfs_enabled;
> >               struct perf_counts_values counts =3D { .val =3D 0 };
> >
> >
> > @@ -300,6 +331,16 @@ static int test_stat_user_read(u64 event, enum use=
r_read_state enabled)
> >               else
> >                       rdpmc_supported =3D (enabled =3D=3D USER_READ_ENA=
BLED);
> >
> > +             if (enabled =3D=3D USER_READ_ENABLED) {
> > +                     sysfs_enabled =3D rdpmc_sysfs_enabled(pmu);
> > +                     if (!sysfs_enabled) {
> > +                             pr_debug("User space counter reading for =
PMU %s [Skip rdpmc disabled by sysfs]\n",
> > +                                     pmu->name);
> > +                             ret =3D TEST_SKIP;
> > +                             goto cleanup;
> > +                     }
> > +             }
> > +
> >               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index=
)) {
> >                       pr_err("User space counter reading for PMU %s [Fa=
iled unexpected supported counter access %d %d]\n",
> >                               pmu->name, pc->cap_user_rdpmc, pc->index)=
;
> > @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum user=
_read_state enabled)
> >                       goto cleanup;
> >               }
> >
> > -             if (!rdpmc_supported && pc->cap_user_rdpmc) {
> > +             if (!rdpmc_supported && pc->cap_user_rdpmc && pc->index) =
{
> >                       pr_err("User space counter reading for PMU %s [Fa=
iled unexpected unsupported counter access %d]\n",
> >                               pmu->name, pc->cap_user_rdpmc);
> >                       ret =3D TEST_FAIL;
>
> Not sure I understand this test, shouldn't it be (pc->cap_user_rdpmc ||
> pc->index)? As in, you don't expect either of them to be set if
> !rdpmc_supported. But then it's the exact opposite of the one above so I
> don't think it does anything.
>
> Either way the test now passes or skips properly on Arm:
>
> Tested-by: James Clark <james.clark@linaro.org>
>
>

