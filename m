Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A6299927
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877792; cv=pass; b=omIWz0QjcgeirJJkJr6LCzAvt63eLXKW2qCxSwyV3I8NF3pEI+CGIfVnPL+xfaPAHV0GHykIRfBbWfsYpnmtZVWegn7GuUAcSNClFs1ePscrRiXhf6gVX6LvEsHHxzutd9z4Zh/vAJViNY2+8h57n0nfFWYT8g0eu7Y/qNgfEAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877792; c=relaxed/simple;
	bh=dMrhUNqvf7Bvpz+GdWMd+I1QywPgBCVobhnME0XEom0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvOQDzztl698PjPEYE7PQHfi1Q6t7HDQ8y8bA3K/uuF0an275QRYR6NDmNKAU9+yxMQW1i6Ps/mSuKiqtUcpbVGdYM3NC3hbcv3VS5KPE4WXl8sFPi0QTq6RQ6r+zGybKQ6rT86o14Xv1BARiAUuIoNYdVX7Y4XilKlJB1LMITI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SA4yphns; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQckfVKR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA4yphns";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQckfVKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770877789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SETp/iYM//yHC8nEihUP0N5Ixgpdyu1M1FHJUuCGxsA=;
	b=SA4yphnsv6PCrzgjRdP/AM3C5fBvkxGoBLlfA3bQ2lw0UIKaRxSUiecvGEHfOzMKdiBtUH
	xsbo65Iaxy0wjHC0OmYhS26QOfNyz7AVpH42iOnfOYCn8ACNrGtSO6ibNZG2k9SvVqCEUq
	ncRGHRY0qegPrurL/aGAkTLXBk5WhKQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-DFU1fauYMnibN4K9CdoMrA-1; Thu, 12 Feb 2026 01:29:48 -0500
X-MC-Unique: DFU1fauYMnibN4K9CdoMrA-1
X-Mimecast-MFC-AGG-ID: DFU1fauYMnibN4K9CdoMrA_1770877788
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7cfd12d8245so17308156a34.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 22:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770877788; cv=none;
        d=google.com; s=arc-20240605;
        b=NsyE1WOnGJqzFsRiDfCcoxjz97gNUSI8FBJa5iprzRfGqdq4q2e4AFQz49bzDGz0KY
         XQ3yTo7TIyrNbuXc+2S/sWwBwA0mnHUzDQhb3HYXeqBwg2eZGKW83tCBKQwv1ZyB/vQ2
         xaGlWcJ9hhYXCE0xUVveR4picC0wJYIwppuW2LE3FdMSlQWmtCnVf5cb+K+6ANiAfU13
         XDmFK3HQIWUxJbRz/HTmXh+5xWBWTwL6BTO5OQx5SBa2obTWcToVspXT/G93MYJnLGpe
         fnREzcWOSaeZOzry4BplRSYF5QquqdFAqixvZ8dhs65ADppmjnZjRGdvoLMt4XsmDDO6
         RCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SETp/iYM//yHC8nEihUP0N5Ixgpdyu1M1FHJUuCGxsA=;
        fh=a82Sq0bVxgidvrX7WozDJI6QRVMRx5q4mu87qNAmtWM=;
        b=OtqZFC2lQ7FPd3WNtRPQZLTZhyvFQdKY+iXdwc33BFlThMHrs2WhiHCxKz36yyGOw1
         nH9pFI55RFUPcppzf2DA2LExe7e7gjPMu1eoryHDJtoN8sdZSHFv7VHwVv5QwS7slhJ7
         r58VacHU7hVWL4hWN0HAWW8FYrlZrUSGWxpaoJliqBJ14enFbvBmha7y8KLCK6qVoQ4x
         8BB7+ToUbHAiby2o9NxjqR+kL/AwzvwGjmj3VMu7wTo7jELkbIrBCzJ+UmOoBGujnq9F
         HDLigi7m+x+R9tAGue47WOSHyVlxYuvrNFTFRGQWKY4wTdyT71BmyGKx+FwsR/BASN9S
         s7iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770877788; x=1771482588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SETp/iYM//yHC8nEihUP0N5Ixgpdyu1M1FHJUuCGxsA=;
        b=LQckfVKRXWqLJQCIBoUyqswJYLG3vpgDvipZ6fAtq2FMlY3Ew1uyEKCGhDKazTRAGL
         VkIAQeBlpLC3o+2t9jw+ibPzRJGhLAmRqiv0uq9zufpJQRGf/2wzfcODu0y8DUVIW9Kc
         PeEAA1SR5weQ0d9sygLzRPD7B+HMsnYj7QbqCPdl1VgcNQII7tGSg6Di+HocE621nfWT
         iJ7I9UEj71b6IlR/rMYabbIUkLl2gGWPtFQNbC3RjbNO1gHxNl7+7Vr+w2/ShxOnOjtT
         Q1eTVGmVQpph2wHB0ZhRrl67Y8Jdag1xn13TYp833HlVI1DGfS8KPFkGsS52Ooit6Fz0
         O63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877788; x=1771482588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SETp/iYM//yHC8nEihUP0N5Ixgpdyu1M1FHJUuCGxsA=;
        b=WywtdiTY6BSz/9ufoFkSCTGkLCKF2Vb/m2u8b+hjcpkPrLbTatAtPtA00jPx7DF2Jx
         qZKtxQ2AxjQ6ywiYpNAIwJ9gHhDnqnYKzrkZg3d4FdLw7A/dFtoQ/6XCKv1puX6/aFbq
         Xm9iIakxwg88qyeSUuK826jwrzaaAqizjI9TBSqRqh9yvYtqBRh0o6pE9jsiBFGiXVkE
         mxNIbFX8YLzqXg2wj76q7+BoE4+0dwgh0I3XOFWP1VcPclXZhBe0iQYum6pQBsKq4a57
         6CWXQS7CIwmfL1zwMjayKihhzToItHQ2PQBtHu89h5dOi9B7k8CP6WmhO2OnSAy6kVVN
         wJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBTuEZVH5uWjUCruyrmh2mbJXY/nE6M7bCUqgQI5bgYnDVrdMqToVXhcslfq3ZxCsQMI92CheV0dWGy9UFbJU0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2o3k5N0AdCmEba77VZlFKg/wwOs0g9s6uiq4Ia+pkg8f22Wz5
	9yuh21vYWVB2HAvXTkef7upnJtp3QG+I837fvdhnZPdoK08uxYXnJAohA3VmtLcB9vSKKpGviW8
	X+G2H0D8uf/yOk3tT+YRIfKD6qfacRMjWoGhWiWpWNyUedL3bgZO2tn1rCQyX0b/8HJZD6SNSAx
	U8DNHSoo9hq1QmdL7G2t+ds/HUy+S5BBg0Chq38LWiOy6wPg==
X-Gm-Gg: AZuq6aKFpgIYGZ8huZejXik+qHHzDD4NZhaMw6xscdtrE83KkgvUW4998rHs7vXEBj/
	67bpZEHTXLizaTfr8niDD1tz0P6l5iv3ru9njUnGnTczyEjfwNJtHYUX47E0I3jcL9W+2wH3g38
	6cEb+bNsxFLH6QWiLTtwSGN7jh30+9JEX8o2t7jVhK4/9YEPPt3l7EFbntW92pLA+CuxlFM6Cc9
	Zdl7/U=
X-Received: by 2002:a05:6820:498a:b0:66b:6862:18e1 with SMTP id 006d021491bc7-67599009803mr713422eaf.36.1770877787767;
        Wed, 11 Feb 2026 22:29:47 -0800 (PST)
X-Received: by 2002:a05:6820:498a:b0:66b:6862:18e1 with SMTP id
 006d021491bc7-67599009803mr713410eaf.36.1770877787285; Wed, 11 Feb 2026
 22:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203141608.14128-1-qzhao@redhat.com> <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
 <CAATMXfm88MZ3Fhc0upRQ_5D2Vy+g8CscVAwhfY7nbM9oX93Qvw@mail.gmail.com>
 <293a4d85-a320-4280-9607-5b9d08ba555b@linaro.org> <CAATMXf=HOq8XzfkqCs=GAmvbSBzSBSnvKUert+ggxSS3SOuc0g@mail.gmail.com>
 <CAP-5=fX_Pvy_SGYZhiKj=-bJ-tHQ8wc_U15Z8g7nhmenOvQJjw@mail.gmail.com>
In-Reply-To: <CAP-5=fX_Pvy_SGYZhiKj=-bJ-tHQ8wc_U15Z8g7nhmenOvQJjw@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Thu, 12 Feb 2026 14:29:36 +0800
X-Gm-Features: AZwV_QjYbkRpweFLKCAvVqlsieSLPAR6e6SH30pU7X3fXEzcA4NVMSOg9z3S7A8
Message-ID: <CAATMXfnwqH0zhcSi1h_djVP-0bSKdRC=y0ar8_8r9vDW05+cUA@mail.gmail.com>
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	leo.yan@linux.dev, namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org, 
	vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

Thanks for the detailed explanation.

Based on your and James' suggestions, I will focus first on making the mmap
rdpmc test behave consistently across platforms by ensuring the set_user_re=
ad()
can actively control the user-space counter access through both <pmu>/rdpmc
and /proc/sys/kernel/perf_user_access, so the test can exercise both enable=
d and
disabled paths rather than relying on skip logic.

Once the functional behavior is aligned and the test reflects the intended =
rdpmc
API semantics, I agree that the next useful step would be to review and pro=
pose
updates to the perf_event.h comments and the man page so that the documente=
d
behavior better matches current kernel behavior.

I will prepare the next revision along these lines and send it for review.

- Qiao

On Wed, Feb 11, 2026 at 1:03=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Feb 10, 2026 at 1:40=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrot=
e:
> >
> > On Fri, Feb 6, 2026 at 11:12=E2=80=AFPM James Clark <james.clark@linaro=
.org> wrote:
> > >
> > >
> > >
> > > On 05/02/2026 2:14 am, Qiao Zhao wrote:
> > > > Hi James,
> > > >
> > > > Thanks for the review and the question.
> > > >
> > > > I did try modifying the check according to your suggestion, i.e. ch=
anging
> > > > the condition like:
> > > > +      if (!rdpmc_supported && (pc->cap_user_rdpmc || pc->index)) {
> > > > However, with this change the tests regress on ARM, the results are=
:
> > > > --- start ---
> > > > User space counter reading 1
> > > > User space counter reading for PMU armv8_pmuv3_0
> > > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> > > > unsupported counter access 1]
> > > > ---- end ----
> > > > 126.4: User space counter disabling instructions                   =
  : FAILED!
> > > > --- start ---
> > > > User space counter reading 0
> > > > User space counter reading for PMU armv8_pmuv3_0
> > > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> > > > unsupported counter access 1]
> > > > ---- end ----
> > > > 126.5: User space counter disabling cycles                         =
  : FAILED!
> > > >
> > > > On ARM, cap_user_rdpmc represents a PMU capability and may remain
> > > > set even when user rdpmc access is disabled via sysfs/sysctl. In th=
at case
> > > > the mmap page reports: cap_user_rdpmc =3D 1 and index =3D 0, which =
is an
> > >
> > > That's a slightly annoying difference to x86 then, which makes it a b=
it
> > > harder to test.
> > >
> > > > expected and valid state when rdpmc is disabled.
> > > > The intention of the existing check: if (!rdpmc_supported &&
> > > > pc->cap_user_rdpmc && pc->index) is only to catch the inconsistent =
case
> > > > where rdpmc is reported as unsupported, but the mmap page still exp=
oses
> > > > a fully usable rdpmc state (i.e. both capability and a valid PMC in=
dex). This
> > > > avoids flagging the ARM case above while still detecting real incon=
sistencies.
> > > >
> > > > With the current logic, the tests now either pass or are skipped as=
 expected
> > > > on ARM, and there is no behavior change observed on x86_64.
> > > >
> > > > Thanks,
> > > > Qiao
> > > >
> > >
> > > But "rdpmc_supported =3D pc->cap_user_rdpmc && pc->index" here:
> > >
> > >    if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> > >        rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
> > >
> > > So I'm still not sure I get checking rdpmc_supported with those exact
> > > two things again.
> > >
> > > In fact I looked more closely and the test is already setup to write =
to
> > > <pmu>/rdmpc to run the test twice with it both enabled and disabled i=
n
> > > set_user_read(). We only return USER_READ_UNKNOWN in that function on
> > > perf_user_access platforms, but only because that function doesn't kn=
ow
> > > the place to enable it is /proc/sys/kernel/perf_user_access.
> > >
> > > So actually we should modify set_user_read() to try enabling in both
> > > places, and then the test can test enabled and disabled outcomes on A=
rm
> > > as well as x86. Now that we know there is this other file we can make
> > > the original intention of the test work with it, rather that just add=
ing
> > > a skip and not testing anything.
> >
> > Thanks for suggesting to modify set_user_read() so that it can try
> > enabling rdpmc
> > both locations (PMU <pmu>/rdpmc and sysfs file
> > /proc/sys/kernel/perf_user_access).
> >
> > Before preparing the next version, I would like to confirm the
> > expected direction.
> >
> > My current understanding is that the intended behavior of the mmap rdpm=
c test
> > is to actively toggle the user-space counter access (enable/disable)
> > and verify both
> > outcomes, rather than skipping the test when rdpmc is unavailable.
> > Based on this,
> > the next step would be to update set_user_read() so that it attempts
> > to control rdpmc
> > through <pmu>/rdpmc first and falls back to
> > /proc/sys/kernel/perf_user_access when
> > the PMU interface is not present.
> >
> > Hi Ian,
> > Could you please confirm if this is the preferred approach for the
> > next revision, or if we
> > should instead keep the current skip logic for platforms where neither
> > interface can be
> > modified?
> >
> > Thanks for the guidance.
>
> Hi Qiao,
>
> I'm not the gate keeper on how things should look but my goal in
> having the test, and extending its coverage, was that the
> implementation should match the description in perf_event.h:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/include/uapi/linux/perf_event.h#n601
> this doesn't cover the sysfs/procfs files but the man page does at
> least for sysfs. None of these sources cover the affinity/rseq issues
> with using rdpmc that if not handled lead to SIGILLs on x86 unless we
> land this kernel patch:
> https://lore.kernel.org/linux-perf-users/20250618084522.GE1613376@noisy.p=
rogramming.kicks-ass.net/
> I'm not sure of the state of this on ARM where there is much greater
> consistency between performance counters, we may be pessimizing ARM
> code to work around this on x86.
>
> My suggestion would be to make the test work, James happy, etc. and
> then send out updates to perf_event.h commands and the man page. Most
> likely the perf_event.h comments will receive good review and we can
> iterate from there, for example, the /proc/sys/kernel/perf_user_access
> slipped under my radar. My understanding from working in this area is
> that perf_event.h is supposed to describe how users use the rdpmc API
> and given the Linux syscall exception on the file, users can freely
> reimplement it (as the point of having a kernel API is people use it).
> The point of the test is to make sure the perf_event.h comment is
> honest. The man page has more space for more detail. As the man page
> doesn't cover /proc/sys/kernel/perf_user_access and perf_event.h
> covers neither the sysfs or procfs files, as well as not mentioning
> the SIGILL issue, I think there's quite a bit of work to do.
>
> Thanks,
> Ian
>
>
> > - Qiao
> >
> > >
> > > > On Wed, Feb 4, 2026 at 5:40=E2=80=AFPM James Clark <james.clark@lin=
aro.org> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 03/02/2026 2:16 pm, Qiao Zhao wrote:
> > > >>> Some architectures control user-space rdpmc access via sysfs or s=
ysctl,
> > > >>> for example /proc/sys/kernel/perf_user_access on arm64/riscv or t=
he
> > > >>> rdpmc attribute under event_source devices on x86_64.
> > > >>>
> > > >>> The mmap-based rdpmc tests currently assume rdpmc availability pu=
rely
> > > >>> based on perf_event configuration, which leads to false failures =
when
> > > >>> the system globally disables rdpmc access.
> > > >>>
> > > >>> Introduce a helper to detect rdpmc availability via sysfs and ski=
p
> > > >>> user space counter reading tests when rdpmc is disabled by the sy=
stem.
> > > >>>
> > > >>> The check is only applied to USER_READ_ENABLED tests. User-read d=
isabled
> > > >>> tests continue to run unconditionally, as they validate perf_even=
t mmap
> > > >>> semantics independent of rdpmc availability.
> > > >>>
> > > >>> Additionally, tighten the unsupported rdpmc check to require a va=
lid
> > > >>> counter index, avoiding false failures when cap_user_rdpmc is set=
 but
> > > >>> no counter is assigned.
> > > >>>
> > > >>> v1->v2
> > > >>> - Check rdpmc availability via sysfs before running USER_READ_ENA=
BLED tests
> > > >>> - Handle both perf_user_access and rdpmc sysfs interfaces
> > > >>> - Avoid false failures when cap_user_rdpmc is set but no counter =
index exists
> > > >>>
> > > >>> Testing:
> > > >>> - arm64: rdpmc disabled by perf_user_access (tests correctly skip=
ped)
> > > >>> - x86_64: no behavior change compared to v1
> > > >>>
> > > >>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > >
> > > [...]
> > >
> > > >>>                if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc=
->index)) {
> > > >>>                        pr_err("User space counter reading for PMU=
 %s [Failed unexpected supported counter access %d %d]\n",
> > > >>>                                pmu->name, pc->cap_user_rdpmc, pc-=
>index);
> > > >>> @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enu=
m user_read_state enabled)
> > > >>>                        goto cleanup;
> > > >>>                }
> > > >>>
> > > >>> -             if (!rdpmc_supported && pc->cap_user_rdpmc) {
> > > >>> +             if (!rdpmc_supported && pc->cap_user_rdpmc && pc->i=
ndex) {
> > >
> > > This weakens the test on x86 though. If they behave differently you
> > > might want to just skip it on platforms with
> > > /proc/sys/kernel/perf_user_access and add another test for them that
> > > pc->index shouldn't be set if it's not supported, but ignore cap_user=
_rdpmc.
> > >
> > > >>>                        pr_err("User space counter reading for PMU=
 %s [Failed unexpected unsupported counter access %d]\n",
> > > >>>                                pmu->name, pc->cap_user_rdpmc);
> > > >>>                        ret =3D TEST_FAIL;
> > > >>
> > > >> Not sure I understand this test, shouldn't it be (pc->cap_user_rdp=
mc ||
> > > >> pc->index)? As in, you don't expect either of them to be set if
> > > >> !rdpmc_supported. But then it's the exact opposite of the one abov=
e so I
> > > >> don't think it does anything.
> > > >>
> > > >> Either way the test now passes or skips properly on Arm:
> > > >>
> > > >> Tested-by: James Clark <james.clark@linaro.org>
> > > >>
> > > >>
> > > >
> > >
> >
>

