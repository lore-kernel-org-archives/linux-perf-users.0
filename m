Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4B2466B4C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053521; cv=pass; b=oWw1fvwMR64Hzch9jN4EUxyTZklp77+NWRH3NcGQRSpvSL5UBem8fvbwiF25pe1w79SYz8FIBAocnjvUfdjJ6WZG63QEPdJ/S/DaxkL+wWlMWW+3rRpu7jRY7MbctTK44h3UDd321M8SqTHRd1ZoWJrizWJFHnp2jKvHafh8GtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053521; c=relaxed/simple;
	bh=ZBoiAthaMa3BrjzxtWZ9ZmETPkPuMyUotPSj7sliQLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mB6MKF5LOi1JN8SU9iSqwTpMYOOuF0h2Anr0qFuNXYBy8tEl+wJoYCqHiUIPzfH1Cn716cZ743PfvhieUwmmXfW0XQpQp23Ihif9J5lK2tP1yZbSONkjH3i3qct/j7owtlB30WSkikawBUK1kzFf322QeDGjhAMkxWirdLphKOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAu2alfy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jlGmcqNZ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAu2alfy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jlGmcqNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775053518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ohvj8bGvJ43tLgqw+Uq6GQCZR6jCHwB9flzfTjrXcg=;
	b=NAu2alfyAiFdK3qENbfXdpM/Q0YWm5WyYM0abQURvsZzGbex1lIKUMr65Su/x2PUJxzAqo
	bYlMIj9afhBPwvhoKPpw46qqC/RcNG/KmKIAdurbSKLeixIwz81oo95fRnpdqzEe16LOfG
	DT34WYpHz9ZzHTdDc3olgxNh3I8caB0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Q20_vDaIMcm0gw5iW2Y81A-1; Wed, 01 Apr 2026 10:25:17 -0400
X-MC-Unique: Q20_vDaIMcm0gw5iW2Y81A-1
X-Mimecast-MFC-AGG-ID: Q20_vDaIMcm0gw5iW2Y81A_1775053516
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67c7f139d4aso26418116eaf.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 07:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053516; cv=none;
        d=google.com; s=arc-20240605;
        b=PjFC5c3uvl1bhpgKTrEjNEOxOKh/HzUx6YAzDkB8LceDPhGbuBmXFr6OvNrtjYUdOk
         Eb05o+Qav3lMB5smdbJ2A5PRGADrOrFnZHZDQlibpaoBPHtqXDTRZiWYlU4V/Mg0D9nk
         COL+Drd4NpYNYt18wPAm25SfZxn1vCI21CTSRhTMw/Y2KZLeu2yHkoqd5lu9NufzYfim
         z+t0VuHm5Qf85U7oE12Dt86L2cpffnd5BFPWhN4NdxwHe05CvZ7E3NJdptbVWfJo6rsE
         LIPfuOxqbxyNJ5lQ4hQszQH7dvOfuR9VzEedVUSikf/3OpOpZ/ZuKK2MQf50suh1SRQS
         qtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ohvj8bGvJ43tLgqw+Uq6GQCZR6jCHwB9flzfTjrXcg=;
        fh=LQhfUsdNz6kQbneMcYNLKpFdp6rWyCQE8kCF1okHJ10=;
        b=PuEVHJ6dJUetYOjmRXC/6YfZ0cnaqLR13Qk2fAFY3rBz588vaQKy2s2Cch8sYNREnk
         PEZyAxltN20y7QfUdeu6cGUETyOBM+NG6Jumws5Ky4lnh2oTztb9wW/COXgVuhCpL3pd
         dAYAHWPqQf+1StO6zHWySWNurtMartxS2QMppiV8PdSUQZ6XhHrGbLUeL9lPR09YiLAE
         F12HqSp4eV9dNgyGVZ8cgHuJw+NG35dxnEBL8wc63GvPmI5npWy50EbCBaL2R0NOTIxe
         jBujp/j5qsYJ3RkHkp1548kwHDlRLmTGgYAuB5++Ktf3fZylrODo9AmEGbBAxu1veAJj
         clkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775053516; x=1775658316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ohvj8bGvJ43tLgqw+Uq6GQCZR6jCHwB9flzfTjrXcg=;
        b=jlGmcqNZb1Gjss7ec2Pu0fm85gRFvM6Mg7bDDErGvjFVmIXtz9L5/kHts/bQ0ngT99
         fxC3yGX/bz8iq3hrbo/yihzJYd9lpEqnKpk0eDFn65oUqoteLVucFw2j8MxwtFAEzLCL
         93rGgiJ89UB6JxkRwGlySCyhSUpTWiGkKrXJDY6vb4zuG+x5SXXIChcWQXhzR5LJ8W1a
         laOLq+eKkLL4WQfJ3c4uxsrbVnI8/h/O1/CD63l25nNQw8yPhrXNGyd1vTufSNnZxp/b
         BZQH9s5Yx/w3hY0+eohD5McHi5g63t+tz/6rtMn7rPREueTGMGaVNaj4WN5xgZMGEWmT
         cJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053516; x=1775658316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ohvj8bGvJ43tLgqw+Uq6GQCZR6jCHwB9flzfTjrXcg=;
        b=oYSLOnRjiowcqeW2RREspN5/iRd6FCiGI2JEIt7m4Y4oL6CZT38it3z1hjWXKzT+ED
         Bo4Yo8BJFcKQVqwUSIiousUgO1JRTKNGxMocY6bFUVzoL3sJEMMhZs9dzuZW9W/mrXTm
         HpQP5dJj6mczqliJhdYS5RzTN3icoAX56TCaHfNwZTsvj0EjpwKGtjfFBc4wHMxBaGyf
         Qum1U18w7O7uWDhv5YmFOz32c1/FNJU700/ERlxepiKryVpowEuulVqKQNpqIBgCNUwI
         Dm0faqdWBcJbSmubzHq84E5iVWB1DbVtOgsaaB+pdssyk4zdEtH/pTouXbwCYufZEszy
         ZZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ugMXw0rULJ2kKSrUG3Z3N9Arc5NW73kNJyAwDXxa7RQ3/D0ZEGFvRBAgF4z68CBdXMnqHyGBd3oWawnxMVS3@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCtEAH7VQpx6SuiWElNfm0biIuzYpvJ7qpNGcd0PCdDnuRwFh
	Pkw21zs2mdBhCV1scLqdbh0azno/8lykxw4Gqi/Y+J/mfNhF72txR1KV/3ChHawaiIoQUlQGZ13
	DQAU35vcTlFN4uXpuwRt9Od8JsDGLMMWP7733sg5K0qk5ec0yPaHe6SA4q5tFYiRBy4V/aadA2D
	ODL1TuPPwUeYXESi9m7BSn4A8AMzvVZokBpmx768neLs66gw==
X-Gm-Gg: ATEYQzzXY+qySjlAeocK7aXL93gfGDriICN/LjscHrwAd+0v0J8nmZ3jVfWYptd/x96
	X7gBkeRiwieMsLK0xENhPb2kNSDiaudg+QK2lSCNyqcGVn8JRIsHKDUv/VZyA7B+XtSmucDeZRS
	a19fzbnk4zElxFtMO4dogq/Ztxx2OPtK8JPH2CeL3V+ORrTS1WaKMxxcIItYlEV0BHYTvz/2LgS
	TYnBA4=
X-Received: by 2002:a05:6820:2211:b0:67d:e505:cf49 with SMTP id 006d021491bc7-67fabbf0f99mr1896231eaf.2.1775053515637;
        Wed, 01 Apr 2026 07:25:15 -0700 (PDT)
X-Received: by 2002:a05:6820:2211:b0:67d:e505:cf49 with SMTP id
 006d021491bc7-67fabbf0f99mr1896212eaf.2.1775053515070; Wed, 01 Apr 2026
 07:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330090003.656540-1-qzhao@redhat.com> <1f378f98-c5a2-48f8-9e63-0ee1d50b4d4f@linaro.org>
In-Reply-To: <1f378f98-c5a2-48f8-9e63-0ee1d50b4d4f@linaro.org>
From: Qiao Zhao <qzhao@redhat.com>
Date: Wed, 1 Apr 2026 22:25:03 +0800
X-Gm-Features: AQROBzBPziyI2D3sWk_MM2qOWqsemzR6mtTBkAV6AfYH7A8uEu6omXIElxyzu68
Message-ID: <CAATMXfmxLVn528BXZnczsr7riXJSG6XKJiqGkqoNweYpVUtb8w@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] perf tests: mmap-basic: fix user rdpmc
 detection logic
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, leo.yan@linux.dev, 
	namhyung@kernel.org, acme@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

Thanks for the review.

You're right that removing the pc->index check makes the test lose its
original meaning, and the current arm/risc-v logic becomes inconsistent.

My initial intention was to handle cases where pc->index is not set on
arm, but I agree that this should not come at the cost of breaking the
test semantics.

From my understanding, this test is meant to validate the correctness of
user space counter reading via the mmap interface, not just the capability
flag itself.
Specifically, this test covers multiple scenarios:
1. When user space reading is enabled:
    - The counter should be readable from user space.
    - This requires both the capability (cap_user_rdpmc) and a valid
       event (pc->index).
2. When user space reading is disabled:
    - User space reading should not work.
    - Either cap_user_rdpmc is cleared or the event is not accessible.
3. The instruction/cycle tests (enabled/disabled) verify that toggling user
     access actually changes the observalbe behavior from user space.
So the key point is that the test is not just checking cap_user_rdpmc, but
whether user space reading is functionally working as expected.

I'll rework the patch to restore the pc->index check and keep the test logi=
c
consistent across architectures. If needed, I'll handle any arm-specific
issues separately.
Also, I'll refactor the duplicated perf_user_access write logic into a help=
er
function and fix the misplaced Intel comment.

Thanks again for pointing this out.

Thanks,
Qiao


On Mon, Mar 30, 2026 at 6:14=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 30/03/2026 10:00 am, Qiao Zhao wrote:
> > The mmap-basic test incorrectly determined rdpmc availability in
> > several environments, leading to unexpected failures on arm64 and
> > other architectures.
> >
> > Previously the rdpmc capability decision lived in test_stat_user_read()=
,
> > which caused inconsistent behaviour when:
> >   - perf_user_access sysctl state is unknown
> >   - architectures expose cap_user_rdpmc differently
> >   - arm64 platforms where rdpmc semantics differ from x86
> >
> > As suggested during review, move the rdpmc capability decision into
> > set_user_read() so that the user_read state and expected behavior
> > are decided in a single place.
> >
> > Changes in v3:
> >   - Moves perf_user_access handling into set_user_read()
> >   - Simplify test_stat_user_read() expectation logic
> >   - Use unified rdpmc_supported calculation
> >   - Handle USER_READ_UNKNOWN consistently
> >
> > v2:
> > https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@r=
edhat.com/
> >
> > v1:
> > https://lore.kernel.org/linux-perf-users/20260120090522.1193981-1-qzhao=
@redhat.com/
> >
> > Note:
> > A potential cleanup around perf_event.h mentioned during review is
> > intentionally deferred and will be handled in a follow-up change
> > to keep this fix minimal and focused.
> >
> > Tested on:
> >   - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
> >   - X86(include hybrid): all mmap-basic tests pass
> >   - IBM Power9: all mmap-basic tests pass
> >
> > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > ---
> >   tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++---------=
-
> >   1 file changed, 39 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basi=
c.c
> > index 3313c236104e..3633e7c87dc1 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct =
perf_pmu *pmu, enum user_read_s
> >   {
> >       char buf[2] =3D {0, '\n'};
> >       ssize_t len;
> > -     int events_fd, rdpmc_fd;
> > +     int events_fd, fd;
> >       enum user_read_state old_user_read =3D USER_READ_UNKNOWN;
> >
> >       if (enabled =3D=3D USER_READ_UNKNOWN)
> >               return USER_READ_UNKNOWN;
> >
> > +     // Try the PMU rdpmc sysfs interface or similar
> >       events_fd =3D perf_pmu__event_source_devices_fd();
> > -     if (events_fd < 0)
> > -             return USER_READ_UNKNOWN;
> > -
> > -     rdpmc_fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc",=
 O_RDWR);
> > -     if (rdpmc_fd < 0) {
> > +     if (events_fd >=3D 0) {
> > +             fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc=
", O_RDWR);
> > +             if (fd >=3D 0) {
> > +                     len =3D read(fd, buf, sizeof(buf));
> > +                     if (len =3D=3D sizeof(buf))
> > +                             old_user_read =3D (buf[0] =3D=3D '1') ?
> > +                                     USER_READ_ENABLED :
> > +                                     USER_READ_DISABLED;
> > +
> > +                     if (enabled !=3D old_user_read) {
> > +                             buf[0] =3D (enabled =3D=3D USER_READ_ENAB=
LED) ? '1' : '0';
> > +                             len =3D write(fd, buf, sizeof(buf));
> > +                             if (len !=3D sizeof(buf))
> > +                                     pr_debug("%s write failed\n", __f=
unc__);
> > +                     }
> > +                     close(fd);
> > +                     close(events_fd);
>
> Hi Qiao,
>
> This block that writes to the file is duplicated with the fallback
> below. I think a function for this would be better.
>
> > +                     return old_user_read;
> > +             }
> >               close(events_fd);
> > -             return USER_READ_UNKNOWN;
> >       }
> >
> > -     len =3D read(rdpmc_fd, buf, sizeof(buf));
> > -     if (len !=3D sizeof(buf))
> > -             pr_debug("%s read failed\n", __func__);
> > +     // Fallback: perf_user_access interface (arm64, riscv, or similar=
)
> > +     fd =3D open("/proc/sys/kernel/perf_user_access", O_RDWR);
> > +     if (fd < 0)
> > +             return USER_READ_UNKNOWN;
> >
> >       // Note, on Intel hybrid disabling on 1 PMU will implicitly disab=
le on
> >       // all the core PMUs.
>
> This comment isn't in the right place anymore because the fallback never
> works for Intel.
>
> > -     old_user_read =3D (buf[0] =3D=3D '1') ? USER_READ_ENABLED : USER_=
READ_DISABLED;
> > +     len =3D read(fd, buf, sizeof(buf));
> > +     if (len =3D=3D sizeof(buf))
> > +             old_user_read =3D (buf[0] =3D=3D '1') ?
> > +                     USER_READ_ENABLED :
> > +                     USER_READ_DISABLED;
> >
> >       if (enabled !=3D old_user_read) {
> >               buf[0] =3D (enabled =3D=3D USER_READ_ENABLED) ? '1' : '0'=
;
> > -             len =3D write(rdpmc_fd, buf, sizeof(buf));
> > +             len =3D write(fd, buf, sizeof(buf));
> >               if (len !=3D sizeof(buf))
> >                       pr_debug("%s write failed\n", __func__);
> >       }
> > -     close(rdpmc_fd);
> > -     close(events_fd);
> > +
> > +     close(fd);
> >       return old_user_read;
> >   }
> >
> > @@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum us=
er_read_state enabled)
> >                       goto cleanup;
> >               }
> >
> > +#if defined(__aarch64__) || defined(__riscv)
> > +             rdpmc_supported =3D pc->cap_user_rdpmc;
> > +#else
> >               if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> > -                     rdpmc_supported =3D pc->cap_user_rdpmc && pc->ind=
ex;
> > +                     rdpmc_supported =3D pc->cap_user_rdpmc;
> >               else
> >                       rdpmc_supported =3D (enabled =3D=3D USER_READ_ENA=
BLED);
> > +#endif
> >
> > -             if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index=
)) {
> > +             if (rdpmc_supported && !pc->cap_user_rdpmc) {
>
> I still don't really get what this is testing. On Arm we do
> "rdpmc_supported =3D pc->cap_user_rdpmc" and then test that those
> variables are the same value? And removing the pc->index check has
> affected x86 but this fix is only for Arm and RISC-V.
>
> pc->index needs to be checked on Arm as well for the test to make sense.
> When user reading is enabled "cap_user_rdpmc && pc->index" is true. So
> when we've enabled user reading that should always be true and it should
> always be false in the disabled test. That doesn't seem that different
> to x86.
>
> >                       pr_err("User space counter reading for PMU %s [Fa=
iled unexpected supported counter access %d %d]\n",
> >                               pmu->name, pc->cap_user_rdpmc, pc->index)=
;
> >                       ret =3D TEST_FAIL;
>

