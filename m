Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8E31B114
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742997; cv=pass; b=AVRVh4VMI33UCh5CGvYy8hwrxT8H9F/F/fF40Kzdyc3vfI2KRFLgcVZlxB4ASpd1iH5MvQ+Js/kO3IUg6QCAN/v6r4qQX3z+BXLR7zaatOVR3sDjE0RWdnmRjn8TGGmHDcWwO2g1nzoPRZyzuwJzQ81+B/XV23PRQuiwTPMxvmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742997; c=relaxed/simple;
	bh=xX17c7pO2QWQCIyie+PAEYFQwX4s+glBOxKiA0vXI0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5Q6mlCrxEChROlZDc5EtZUFNv1jhBUTPMjJ1ALoFz4BsjRzq2rb7KnKLd5XRIww17adsVZmmEryGqsxID9Z8WgOplBNsinbnvbxRSJyHHqxbA5E3k0Io9k3tc6XLDgz+FpVdi9ovwOEzWFs0kKR+cBGnldAl1c+31R/yFY7LJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhvkUAG6; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhvkUAG6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a885af8ee7so80465ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 09:03:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770742996; cv=none;
        d=google.com; s=arc-20240605;
        b=KfCRnpl405MPkapvTA3IQqMUyFXU+MraXls5c0BxB2Nv+/0GJ6+DDQ5wignG6Qpxt8
         MxGqxWr4+j1IhwRwSSYT2nXSsFDpvo73OjM7fsyY6uN2sm0/l3aJKEwH0zbgX/PF3Jqw
         gK6qmVVbvtXdrCDJt/EhybprD7/AnrTMDFJ98q4lgEdjNKPvEoXLz8uvaZDrK9ADe8AC
         Zf4MG+abFTEB83WRWnNnT7SatqlTJvGlgZcZ/DP5Tsty0pWDHhAJYn5H3UtBGDjuEL1Q
         gPLF6P3TnyFtUkrp9e22ijjcsB5YROzzdEFfu/X65AEhPgCO+DMqHDaJf6k7vcwbF3Nq
         dadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kPtpzIrtJsRYDGV7q+AhACafD6ZWazPAZQJP3uRSXA=;
        fh=VJEVfPPI+jiA2J3wKOgyS6Oc++ihrEPRwGmPCP9j5Og=;
        b=jyLaNm0qvCui1JZu6OoT9re5Isat1AmcBFVGq31Nvt99topRn8q4l72kRifZYASGu1
         b8VOI7s5wprJw/2NiJOiqsWqbmYKCA4KS3HEdkqwy6eFukX8RmEggQiQ5KUr/y+GkAxx
         pyxJliVbFeN/ouuIboEY2LkcUx3QoyaEM86tY7n/L2EltCaht4je3e3+29GOw2WVBzdU
         b+J5omHMNJESSwVqQh6nZCmFbce+jxgXkpv8NNGdWqRBehw73fuVIher4kjiJJrcOiCT
         ZSDhs6MxAMear8ICi6yAR+9eAjudbOuOg7TQFrRBFFGsADOn3l0QZf+4MK1BG6bt3iWh
         l5bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770742996; x=1771347796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kPtpzIrtJsRYDGV7q+AhACafD6ZWazPAZQJP3uRSXA=;
        b=NhvkUAG6KnkMmqiq+AbJz5MSBABTACY2kgqgq3JMOlUPAn1kWhR6ir0dF81ClNDRZF
         ZBVrG3CNlkj7biFfLCKifDiMpjsuVhZEk+rXGhKi26Whuxneub7BKv7eMEVkta9Eh6gx
         KmVH6TZ5yBw5tyuFo+fsltQdNo9AVAGB1L41ymKya1dyr+z0spqmPE/6hHR5HVmx6Cwe
         NfYta97dkTtLv38mnnZb/cNv5x//JayoUX5+QthJS9R4V7KFlVccMZz3OfaBQsKhXfSK
         5AnPNNsm+a++mfDmh3UdKxUNuMoQ70PdfzgWGdrAWAieWdQci3ejFNhDDVbW7pqlp5YW
         169w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770742996; x=1771347796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kPtpzIrtJsRYDGV7q+AhACafD6ZWazPAZQJP3uRSXA=;
        b=rcbZ9s82Xwj2BM3DKchDGkejf4cs+70bsJ20iVSse1GMlSANCRxXjB9GCah83gLc15
         4S9nYIM4VUrgPezwMGR8f1F/Gmbbvfq2UhBkYkk47B6dDaidoe0Pma428pYTrdHuDYgx
         bmY5zwYVlXhrWXNthjH0itP+BRxZ5RBPWZMDsxf+Ny7MKhW/UhhVGuwMr9bnlt7LjgBJ
         XcJhFR98etP/3nhGmyjdbOTKQAtxDEX9B8Oww2IqROBJyWSeYS2KS/rKM5xCH63KkXNc
         xYcUWRRd5kpyAfRsacRg7HVwkZ+Nbfbk7sKi6lyoadPBWczDPHz7xntEB6SEQAXlusSG
         f/hg==
X-Forwarded-Encrypted: i=1; AJvYcCVyJ4Dct3ota3ydm5mJwEWkqJ3TpV80RD2AJaSO8sd/4IGcG9FxoL6WHU2S1bAf744im+PsTuiXpEPp7+db0bUC@vger.kernel.org
X-Gm-Message-State: AOJu0YyGm2HTcKN/yhLY67BM/M0oaTDcW4qhCuTDo1vTX0xG/ez4XCxR
	h50fxe0Awr3JDPIpbyaqbUd50z/5kGmcvk/MJrf8T8DqKHaXGvnn3nrl7o+aakeA7AYk5BbalyW
	RlYRUtNbB5jsStQVfBI1aPnmjs4/v7uEn4SUv43dd
X-Gm-Gg: AZuq6aJK7qFRQb4VjLP0ENRgwXstluMri5jlJxyI2+wPhLEbjT6GIpmHQBf/90NMS5R
	IYb0TFbbABaZBohUTzndZfXF+2vtAG5rcSfiaE1LTXjoTU7xBMcEQTKm/sISu850Zrte7oeMAi5
	Vb3KFh3wBSbNvfnMMcNv7E24y/mWBwzhy/geybRbLLFo0+ZwWwuaZWfBaQO6kICX0C2vpsqck4j
	vkVH90MrYEZIykFmZ9MdQZHvYXtw+25b5x+W7Yls6THCpImyygg4t0f0awoDhHBm2t6khB4P4Gq
	yrbnt78HMT5K0pyqAJutQJRglA66eShSAd0v
X-Received: by 2002:a17:903:298c:b0:2a7:640c:834b with SMTP id
 d9443c01a7336-2ab0dfb9250mr3606035ad.0.1770742995401; Tue, 10 Feb 2026
 09:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203141608.14128-1-qzhao@redhat.com> <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
 <CAATMXfm88MZ3Fhc0upRQ_5D2Vy+g8CscVAwhfY7nbM9oX93Qvw@mail.gmail.com>
 <293a4d85-a320-4280-9607-5b9d08ba555b@linaro.org> <CAATMXf=HOq8XzfkqCs=GAmvbSBzSBSnvKUert+ggxSS3SOuc0g@mail.gmail.com>
In-Reply-To: <CAATMXf=HOq8XzfkqCs=GAmvbSBzSBSnvKUert+ggxSS3SOuc0g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Feb 2026 09:03:01 -0800
X-Gm-Features: AZwV_QiFG-90x0_dBhKLqwR4o13TyE6z_cT62tSbyPrvNcp_NKTntU8OX7a5Zy8
Message-ID: <CAP-5=fX_Pvy_SGYZhiKj=-bJ-tHQ8wc_U15Z8g7nhmenOvQJjw@mail.gmail.com>
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: Qiao Zhao <qzhao@redhat.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	leo.yan@linux.dev, namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org, 
	vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 1:40=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrote:
>
> On Fri, Feb 6, 2026 at 11:12=E2=80=AFPM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> >
> >
> > On 05/02/2026 2:14 am, Qiao Zhao wrote:
> > > Hi James,
> > >
> > > Thanks for the review and the question.
> > >
> > > I did try modifying the check according to your suggestion, i.e. chan=
ging
> > > the condition like:
> > > +      if (!rdpmc_supported && (pc->cap_user_rdpmc || pc->index)) {
> > > However, with this change the tests regress on ARM, the results are:
> > > --- start ---
> > > User space counter reading 1
> > > User space counter reading for PMU armv8_pmuv3_0
> > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> > > unsupported counter access 1]
> > > ---- end ----
> > > 126.4: User space counter disabling instructions                     =
: FAILED!
> > > --- start ---
> > > User space counter reading 0
> > > User space counter reading for PMU armv8_pmuv3_0
> > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> > > unsupported counter access 1]
> > > ---- end ----
> > > 126.5: User space counter disabling cycles                           =
: FAILED!
> > >
> > > On ARM, cap_user_rdpmc represents a PMU capability and may remain
> > > set even when user rdpmc access is disabled via sysfs/sysctl. In that=
 case
> > > the mmap page reports: cap_user_rdpmc =3D 1 and index =3D 0, which is=
 an
> >
> > That's a slightly annoying difference to x86 then, which makes it a bit
> > harder to test.
> >
> > > expected and valid state when rdpmc is disabled.
> > > The intention of the existing check: if (!rdpmc_supported &&
> > > pc->cap_user_rdpmc && pc->index) is only to catch the inconsistent ca=
se
> > > where rdpmc is reported as unsupported, but the mmap page still expos=
es
> > > a fully usable rdpmc state (i.e. both capability and a valid PMC inde=
x). This
> > > avoids flagging the ARM case above while still detecting real inconsi=
stencies.
> > >
> > > With the current logic, the tests now either pass or are skipped as e=
xpected
> > > on ARM, and there is no behavior change observed on x86_64.
> > >
> > > Thanks,
> > > Qiao
> > >
> >
> > But "rdpmc_supported =3D pc->cap_user_rdpmc && pc->index" here:
> >
> >    if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> >        rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
> >
> > So I'm still not sure I get checking rdpmc_supported with those exact
> > two things again.
> >
> > In fact I looked more closely and the test is already setup to write to
> > <pmu>/rdmpc to run the test twice with it both enabled and disabled in
> > set_user_read(). We only return USER_READ_UNKNOWN in that function on
> > perf_user_access platforms, but only because that function doesn't know
> > the place to enable it is /proc/sys/kernel/perf_user_access.
> >
> > So actually we should modify set_user_read() to try enabling in both
> > places, and then the test can test enabled and disabled outcomes on Arm
> > as well as x86. Now that we know there is this other file we can make
> > the original intention of the test work with it, rather that just addin=
g
> > a skip and not testing anything.
>
> Thanks for suggesting to modify set_user_read() so that it can try
> enabling rdpmc
> both locations (PMU <pmu>/rdpmc and sysfs file
> /proc/sys/kernel/perf_user_access).
>
> Before preparing the next version, I would like to confirm the
> expected direction.
>
> My current understanding is that the intended behavior of the mmap rdpmc =
test
> is to actively toggle the user-space counter access (enable/disable)
> and verify both
> outcomes, rather than skipping the test when rdpmc is unavailable.
> Based on this,
> the next step would be to update set_user_read() so that it attempts
> to control rdpmc
> through <pmu>/rdpmc first and falls back to
> /proc/sys/kernel/perf_user_access when
> the PMU interface is not present.
>
> Hi Ian,
> Could you please confirm if this is the preferred approach for the
> next revision, or if we
> should instead keep the current skip logic for platforms where neither
> interface can be
> modified?
>
> Thanks for the guidance.

Hi Qiao,

I'm not the gate keeper on how things should look but my goal in
having the test, and extending its coverage, was that the
implementation should match the description in perf_event.h:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/perf_event.h#n601
this doesn't cover the sysfs/procfs files but the man page does at
least for sysfs. None of these sources cover the affinity/rseq issues
with using rdpmc that if not handled lead to SIGILLs on x86 unless we
land this kernel patch:
https://lore.kernel.org/linux-perf-users/20250618084522.GE1613376@noisy.pro=
gramming.kicks-ass.net/
I'm not sure of the state of this on ARM where there is much greater
consistency between performance counters, we may be pessimizing ARM
code to work around this on x86.

My suggestion would be to make the test work, James happy, etc. and
then send out updates to perf_event.h commands and the man page. Most
likely the perf_event.h comments will receive good review and we can
iterate from there, for example, the /proc/sys/kernel/perf_user_access
slipped under my radar. My understanding from working in this area is
that perf_event.h is supposed to describe how users use the rdpmc API
and given the Linux syscall exception on the file, users can freely
reimplement it (as the point of having a kernel API is people use it).
The point of the test is to make sure the perf_event.h comment is
honest. The man page has more space for more detail. As the man page
doesn't cover /proc/sys/kernel/perf_user_access and perf_event.h
covers neither the sysfs or procfs files, as well as not mentioning
the SIGILL issue, I think there's quite a bit of work to do.

Thanks,
Ian


> - Qiao
>
> >
> > > On Wed, Feb 4, 2026 at 5:40=E2=80=AFPM James Clark <james.clark@linar=
o.org> wrote:
> > >>
> > >>
> > >>
> > >> On 03/02/2026 2:16 pm, Qiao Zhao wrote:
> > >>> Some architectures control user-space rdpmc access via sysfs or sys=
ctl,
> > >>> for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
> > >>> rdpmc attribute under event_source devices on x86_64.
> > >>>
> > >>> The mmap-based rdpmc tests currently assume rdpmc availability pure=
ly
> > >>> based on perf_event configuration, which leads to false failures wh=
en
> > >>> the system globally disables rdpmc access.
> > >>>
> > >>> Introduce a helper to detect rdpmc availability via sysfs and skip
> > >>> user space counter reading tests when rdpmc is disabled by the syst=
em.
> > >>>
> > >>> The check is only applied to USER_READ_ENABLED tests. User-read dis=
abled
> > >>> tests continue to run unconditionally, as they validate perf_event =
mmap
> > >>> semantics independent of rdpmc availability.
> > >>>
> > >>> Additionally, tighten the unsupported rdpmc check to require a vali=
d
> > >>> counter index, avoiding false failures when cap_user_rdpmc is set b=
ut
> > >>> no counter is assigned.
> > >>>
> > >>> v1->v2
> > >>> - Check rdpmc availability via sysfs before running USER_READ_ENABL=
ED tests
> > >>> - Handle both perf_user_access and rdpmc sysfs interfaces
> > >>> - Avoid false failures when cap_user_rdpmc is set but no counter in=
dex exists
> > >>>
> > >>> Testing:
> > >>> - arm64: rdpmc disabled by perf_user_access (tests correctly skippe=
d)
> > >>> - x86_64: no behavior change compared to v1
> > >>>
> > >>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> >
> > [...]
> >
> > >>>                if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->=
index)) {
> > >>>                        pr_err("User space counter reading for PMU %=
s [Failed unexpected supported counter access %d %d]\n",
> > >>>                                pmu->name, pc->cap_user_rdpmc, pc->i=
ndex);
> > >>> @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum =
user_read_state enabled)
> > >>>                        goto cleanup;
> > >>>                }
> > >>>
> > >>> -             if (!rdpmc_supported && pc->cap_user_rdpmc) {
> > >>> +             if (!rdpmc_supported && pc->cap_user_rdpmc && pc->ind=
ex) {
> >
> > This weakens the test on x86 though. If they behave differently you
> > might want to just skip it on platforms with
> > /proc/sys/kernel/perf_user_access and add another test for them that
> > pc->index shouldn't be set if it's not supported, but ignore cap_user_r=
dpmc.
> >
> > >>>                        pr_err("User space counter reading for PMU %=
s [Failed unexpected unsupported counter access %d]\n",
> > >>>                                pmu->name, pc->cap_user_rdpmc);
> > >>>                        ret =3D TEST_FAIL;
> > >>
> > >> Not sure I understand this test, shouldn't it be (pc->cap_user_rdpmc=
 ||
> > >> pc->index)? As in, you don't expect either of them to be set if
> > >> !rdpmc_supported. But then it's the exact opposite of the one above =
so I
> > >> don't think it does anything.
> > >>
> > >> Either way the test now passes or skips properly on Arm:
> > >>
> > >> Tested-by: James Clark <james.clark@linaro.org>
> > >>
> > >>
> > >
> >
>
