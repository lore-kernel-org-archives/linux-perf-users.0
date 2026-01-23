Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE93101A7
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156954; cv=pass; b=cdil923+OTcMtjaEx8Jn3f7n2vlRJM3RXQx2td/dtiKiKYqXiqpOZQkDUxwQKMKxA2A8uY7NchSu1kipsfvG9LcrQ3zin17/i33wOmy7GWC7aNIurD0ONgZg04ICMefNXTBTwP8sTAcUccNL19My8RocN7xYXD40OYy9Qlkp0pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156954; c=relaxed/simple;
	bh=6JnY9YYtFzwEIKWsbVJO+xKlsDs+Dm1P2CL/6G22SyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUHJjxvQ0wgigRjHBzltzSk34c0c34t999kVcDNNI4lMFeIYlOkPn72tax1WZniAAuzliWigYpX/XdhavnSmJdMAv5jf4pFY/8N3aKf51LvvaYlezWm6Riza6aHdt5l0soo2gn/Cgb9qrCzw4YOThc5gW7gJNTqQtOC4XNfJZYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGviMId7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGIX/1RX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGviMId7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGIX/1RX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769156951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FQkxRMlFhnQvpg16RYjPS0s/a9dK9DyLMuEe8KZOG4=;
	b=hGviMId7lq4yxcJCqfoaCmLAXNAsODrOCs2SH6AEN5oP5nvPXtqTlJN75RHI9eGxdO3DEU
	A0PlLtZ0A+Ida+IkX5WxPVGcJEkFfgwlWQVsoyB9HfnFoZsoloD1Ht6EFhkszoDUGI3EmE
	XA1+xBMOBNwVmzL4fpJyInWAjoHU8xs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-WbnYIWdpOd6HqhfH_L6Ohw-1; Fri, 23 Jan 2026 03:29:10 -0500
X-MC-Unique: WbnYIWdpOd6HqhfH_L6Ohw-1
X-Mimecast-MFC-AGG-ID: WbnYIWdpOd6HqhfH_L6Ohw_1769156949
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-662b9af3988so4000103eaf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 00:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769156949; cv=none;
        d=google.com; s=arc-20240605;
        b=LTTKOACxzQdC8UZBD0AiSIbVXMNIn7plIcf2OkhMDei8Cv6cPyQd5+TFFIsp95tqlq
         Y/+yHDHD3rU/El4Sm/r0z3J9W4zQhmyFTUXMYsPLUEZOptUPynmHZHYAEGiEwwIV9inU
         CZ8JRZnuR7zNWOi4RuHPe/1Fw8qbIqDWO/PVEk6UV4W+TRnaKxxwuBX/HeZi5LiR3bBd
         S7NaFR4N2kvBjzaLWsBLy795OAbZkLuu4iJHkvXCSdsQ8xiRiHNaR8ybJLMTQ46Q9qe8
         8K1D5vun5iD07jwi0oRm5Hnhn8Cr5s0GdRyx0rTgo2JR0JJPma9mBzb6kw3LDgIm7faa
         YyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4FQkxRMlFhnQvpg16RYjPS0s/a9dK9DyLMuEe8KZOG4=;
        fh=PcE+oFqctJCZWp9mvn2Fs55zPJhNmZYhs2BtLqzVGTI=;
        b=OVrTADTAxUheQhlyqoCZfTEKZ5iW/N65fhPZtxVMePIuDDpm4z5uJIqeR4wqiWCOCs
         zvnbWBCIcnQvb03b9UW1hd7ywMjc4vIpnfBlP1PxfS+Qfst8/vB6kg+OfsX8nY0y4+AL
         UTfR4obcOwlHiWUUdzBTmutPy9YjWMXlB6VXTIYC8UngxzxXUPVSFkkreQ9WdR9625Dt
         Rk0CehEZyoljA0RI3WZ7hi+hU3LpPV43/Ue4VSepkdC+aksJ7/Oylg/u30HwacJeizxU
         r0K/vPXe+IGmwWnSu1gh4YjGY/vnwfHIaFc3ezEr+2KpBzSVPlxnZMXA1+bqIjf4wSPA
         REMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769156949; x=1769761749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FQkxRMlFhnQvpg16RYjPS0s/a9dK9DyLMuEe8KZOG4=;
        b=IGIX/1RXHcYoSIpt4uAhdp+NRZDg9Muujt5XSjfUl0770gtCrjwe+Yna8Pdyo+GnN2
         yv6qGDmVwb7Q6hloTlTPMEVUuqixTdaA8D9XXM0EGBm1IMRr0GjoZ5iI6NNGfJoQzoSu
         EpXA0fQBLJVVU2uk3g4IMfjHmstUZhCWaEy7P/48pgxOoO3HZFfjGq13e7Z7NSa0s7Na
         g1gTLWF/08H9xxLXtF5WdVQncTWP6+rjRWyLNR+aCW9U5T3WHFqqQRYsKk0kcmbyUySK
         rG1NoB20qz2o45F+uMRstksC5+Hh4S4Be5QZ/JhD5FcKah5Sv5N/3VpLGWmpwhjGd4b8
         b27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769156949; x=1769761749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FQkxRMlFhnQvpg16RYjPS0s/a9dK9DyLMuEe8KZOG4=;
        b=lna6oYbErf8wazgA8dbZdr/Z7ea737YN9eyQYqmrg8sDnQVh32ihrmo9Zj3OWOOa9a
         /C5n4p6mI4SEOcCLHzv1X+ZIZk/RSHi9xy73+iOqM/SyXK2n8JLi5XON9/WSRCW5kC1N
         fj3HcbrbOc+c7mLhr5ZWKj8NVkAtLopxhVmtJPbVLlRsL6KwZONEVQnC1S3Gk1RUa7Mc
         T+TmfATlxO2Pg6X7A+hiOa6r5Np5OQQg1ORo80Rk5UESeqeGFR/EYA1d6/WjP1qF7X8e
         khS7nDH6AvmkSQRNeF5lkYYdUVI2CdyynMbnmYU5roqH68fSrEgR9LXKCIYLJGlLl2EF
         7aUg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Jg4op+pB2UTx+5HHXTsmX+ghNqWTK7v/adc9bs7c3Giglw0PwfYiKBvsOotHD2XjcnHxdhO6rxSkTYy7pZhm@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpiGP9AE8Wlyw4HWD/S4vacRkn9S2pjNfZ/dI4x2+zsHz65pP
	iYZBYDa6GulLc88AfuBjvK6Fw3b/TBzQ4ukCmmvvPJ6T1Z9+6fmCANb3KrF5KddpyTKrm9yoo6c
	8lrFF1csQhG8StU/0jAoDpO7Go07R4iDjeMRDU+geFhYaMtmQozn18k0s2qpD/bkbCsSqtlyQCs
	XYxhMVwgeo5KnSXX8LTgb3KIGMceV03DgQx+QCWviSbRn4MSmNykQzo6gVtTU=
X-Gm-Gg: AZuq6aJgY05MXgrKsx5thwNYOsnXnwRCZ54dJBSpG752JtSNTeeYij59LXDv3+3o3uz
	9tQ607gippk8jyWptp76qa01Enh3pt8MhEQUm/qcirMYfHLM7kw5yvK0op0MBaJFODjbj2gqhDo
	VhZyrRu0z1FNaeMZULcDvgCo31u0StZL54lUryeRONEB1bhqLTdyfy4X8nfd3Grf9c2dE=
X-Received: by 2002:a05:6820:987:b0:662:c22f:b969 with SMTP id 006d021491bc7-662d060cc5cmr155556eaf.6.1769156949051;
        Fri, 23 Jan 2026 00:29:09 -0800 (PST)
X-Received: by 2002:a05:6820:987:b0:662:c22f:b969 with SMTP id
 006d021491bc7-662d060cc5cmr155548eaf.6.1769156948667; Fri, 23 Jan 2026
 00:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com> <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
In-Reply-To: <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Fri, 23 Jan 2026 16:28:57 +0800
X-Gm-Features: AZwV_QhFVperM1bDsa3BK-vKrAXSug48_Bxp3JYrCz1OVhJT83BGEBqPPgNDStE
Message-ID: <CAATMXfmz2BCAoRXFOgSMyLK+FEF=ac5g_ZabY2a8ie+ZYfHtrA@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, namhyung@kernel.org, 
	mpetlan@redhat.com, acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

Thanks for the follow-up questions. I've gathered some additional data
from the affected ARM systems.
Environment:
- Architecture: ARM (aarch64)
- CPU: Ampere(R) Altra(R) Processor Q80-30
- Tested on both bare-metal and ARM KVM guests
- Observed behavior is identical on bare-metal and KVM
- This is not a heterogeneous / big.LITTLE system
- perf version: 6.19.rc6.g053966c344db

rdpmc sysfs:
On these systems, there is no rdpmc attribute exposed under the PMU devices=
:
# grep . /sys/bus/event_source/devices/*/rdpmc
grep: /sys/bus/event_source/devices/*/rdpmc: No such file or directory

So the =E2=80=9Crestricted PMU access=E2=80=9D I referred to is not due to =
toggling a
visible rdpmc sysfs knob.
From a user-space perspective, there is simply no rdpmc control file availa=
ble.

PMU devices:
The core PMU present is:
# grep . /sys/bus/event_source/devices/*/type | grep armv8
/sys/bus/event_source/devices/armv8_pmuv3_0/type:10
(Other devices are DSU/CMN/DMC PMUs.)

Virtualization:
The same rdpmc behavior is observed when running under ARM KVM,
so this does not appear to be virtualization-specific.

Observed inconsistency:
Even though perf_event_open() succeeds with .config1=3D0x2 on aarch64,
and the mmap page report
cap_user_rdpmc=3D1, user-space rdpmc access fails at runtime, which is
what causes the test to treat
rdpmc as unsupported.

At this point, I agree the key issue seems to be the mismatch between
the reported capability (cap_user_rdpmc)
and the actual runtime behavior, rather than perf_event_open()
failing. I don't yet have enough insight to say
whether this is an ARM PMU driver capability-reporting issue or an
incorrect test assumption, but hopefully the
above data helps narrow it down.

Please let me know if more details would be useful.

Thanks,
Qiao

On Fri, Jan 23, 2026 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jan 22, 2026 at 7:11=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrot=
e:
> >
> > Hi Kim, Ian,
> >
> > Do you mind reviewing this change?
> >
> > On Tue, Jan 20, 2026 at 5:05=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wr=
ote:
> > >
> > > On some platforms (e.g. ARM systems with restricted PMU access), user=
 space
> > > PMU counters may be reported as supported but blocked at runtime. Fai=
ling
> > > the mmap interface tests in this case is incorrect.
> > >
> > > [Test Log]
> > > 124.2: User space counter reading of instructions                    =
: FAILED!
> > > --- start ---
> > > User space counter reading 0
> > > User space counter reading for PMU armv8_pmuv3_0
> > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected u=
nsupported counter access 1]
> > > ---- end ----
> > > 124.3: User space counter reading of cycles                          =
: FAILED!
> > > --- start ---
> > > User space counter reading 1
> > > User space counter reading for PMU armv8_pmuv3_0
> > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected u=
nsupported counter access 1]
> > > ---- end ----
> > > [/Test Log]
> > >
> > > Skip the user counter mmap tests when runtime PMU access is not avail=
able,
> > > while preserving failure for genuinely inconsistent states.
> > >
> > > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > > ---
> > >  tools/perf/tests/mmap-basic.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-ba=
sic.c
> > > index 3313c236104e..4881a641749b 100644
> > > --- a/tools/perf/tests/mmap-basic.c
> > > +++ b/tools/perf/tests/mmap-basic.c
> > > @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum us=
er_read_state enabled)
> > >                 }
> > >
> > >                 if (!rdpmc_supported && pc->cap_user_rdpmc) {
> > > -                       pr_err("User space counter reading for PMU %s=
 [Failed unexpected unsupported counter access %d]\n",
> > > +                       pr_debug("User space counter reading for PMU =
%s is not supported (cap_user_rdpmc=3D%d), skipping!\n",
> > >                                 pmu->name, pc->cap_user_rdpmc);
> > > -                       ret =3D TEST_FAIL;
> > > +                       ret =3D TEST_SKIP;
>
> Hi Qiao,
>
> It sounds like the ARM behavior is divergent from the Intel behavior,
> but that said Intel hybrid rdpmc is known to be problematic. There's a
> fix for part of that which will hopefully land [1]. One weird thing on
> Intel hybrid is that the rdpmc permission file within the PMU is kind
> of "shared" between all core PMUs, so disabling rdpmc on the e-core
> PMU disables it on the p-core. In one iteration of this test tried to
> incorporate support for this. Anyway, ARM...
>
> So in the test we're doing:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n243
> ```
> #ifdef __aarch64__
> .config1 =3D 0x2, /* Request user access */
> #endif
> ```
> So 1 question is why the perf_event_open is succeeding with a request
> user access bit set in the config in a system where this is blocked?
>
> I'm not sure on the support for the rdpmc file on ARM but it looks to
> be wired up:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n324
>
> So in the test where you've changed it we've determined that rdpmc
> shouldn't be supported but the shared page is saying the
> cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
> I wonder if the setting of cap_user_read:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n1615
> should also be testing whether support has been disabled through the
> rdpmc attribute? Hmm.. but x86 doesn't do that:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/arch/x86/events/core.c?h=3Dperf-tools-next#n2753
>
> So given that ARM and x86 look in sync, x86 doesn't have issues I'm
> aware of, and it certainly looks like a failure inconsistency that the
> test thinks that user rdpmc support is disabled but the page says
> otherwise. I could use more details to understand this, like what's
> the contents of the rdpmc file? In your commit message, is the
> restricted PMU access the rdpmc file or a different capability? Could
> this be a weird hybrid/BIG.little issue like on x86?
>
> Thanks,
> Ian
>
> [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-a8f1-20a34e2f9af2@lin=
ux.intel.com/
>
> > >                         goto cleanup;
> > >                 }
> > >
> > > --
> > > 2.49.0
> > >
> >
>

