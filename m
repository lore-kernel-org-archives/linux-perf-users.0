Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123B311C11
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716437; cv=pass; b=omo+Lb2Gn2//ktzFECZlx4xdbeYmE3IbCQugHv3QS0bN9bjk+fvQU7avLWtPX2vI7+unfN1jiiFaSaog6z4GmGRNYtZ3hMLB0AOcWyfBd+LXhoZbazwF4ABotUm2jlhFWuu11UtKBim3FXls8enyKTcjPI18UL349nhzfNxvMwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716437; c=relaxed/simple;
	bh=zSTxl3WzMiiDGTZPynEAZyx8AhLzp6kDThP8Yg8eBko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ippDo9RM5+6eEG9Czf7USlCdgnGwrx2TSsgCUI7hSSk77IMWKEhQwVcLCRlq0mwOdYWP0c5cIUtgSEyEMXY05M7I6BRSXEwd6bGYyqmZsft1zBjz2w5ahTetZiqmII2NdmZ/Kf2Sj5LlkVNQsLTQLes2GGOYZQbYtAOT0pSs5vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpNRBTsC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QACD+6Nl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpNRBTsC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QACD+6Nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770716434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SO+AiM4mV8eIbKRvbLLRz4Cb9QyYNG8NO2SUFMyl06g=;
	b=cpNRBTsCcdyS8HkbFFTj2yu1cZ3nXFkgCJZqmb5kCxN8SJGhGdwT+OihS2N2Ujg3X0FxGn
	jWqtm7C3pPt+FelUIH7xdFq+TJtz9xWcfVZ9ZxMnpxEAzEN+qeZvKzOGS4wEavwf+SUnGD
	4SAwcCzWHOKZJFeR8eZ9mpPaIiiBU2Q=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-i-zQQU1WM-GptkJVfKn5QQ-1; Tue, 10 Feb 2026 04:40:33 -0500
X-MC-Unique: i-zQQU1WM-GptkJVfKn5QQ-1
X-Mimecast-MFC-AGG-ID: i-zQQU1WM-GptkJVfKn5QQ_1770716433
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-662f738c3bfso2312447eaf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 01:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770716433; cv=none;
        d=google.com; s=arc-20240605;
        b=VD4zA0yt54Mpa23YQrznOvzsV5n+4tNayqJGSTVEJraT7CZKZjJrpNZMHUj+q8TZy9
         Q4yso0Gol0HeOzawUjbCmz94zW5Ieb6A8CKo2lpeErILo7TQ0sCkeqHpxXI2epXMMyph
         bG+GrE7UV6QwaaZzfa0rxBIBxerN7wmoapsHb9Qp/VHzH+1ba6xA1YHOCiBYrLzqXray
         sjjdCSZByZGwqhl9nr1j3T5vI5W1H5DOVD9pV9fWsJyyTuJpDlidxK+5Qxxb4mSPqP+1
         lyL3q/KO8ikEauJ1sIyusn/70O8TM7oO77ipDFRALIrf2vTif/2EHX9tlfAWNURsRlGw
         ilUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SO+AiM4mV8eIbKRvbLLRz4Cb9QyYNG8NO2SUFMyl06g=;
        fh=Ck/Zensbx/6eUITetI8VRPuteFDT2aDnzQnIKG8dYhQ=;
        b=EFgGg8m67Ac5ZrYL0of7vitKZR0g+GxEGZeyrbSK6JBeekvU+oq8e1OR0Fvv7I9XFX
         Dt0N04/c8gVPLVNRY3RbKpGya+nNkd125u7kDG2ZOXY5wDeBrG+wXAT/GfOxY8yzUj5h
         pEDqU4Tqyu6ita/3T7BuWZ7u0mnQ490AdrW5wS/yjORmkX4baN+8MBYO8wIIbvOP59Nd
         00vY2TNin5rZL/VRkH5j4X/ZLAef0/NO095A0Obmh/lMF2UO6B4+4ZcLBniCBbREI/wl
         4pw7rEojqLCFNqYIYY8LvJKzwhRp02Opph5uCwq0qqzA1UWm15i0fEeDwwJ5VwnrPXeg
         VT1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770716433; x=1771321233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO+AiM4mV8eIbKRvbLLRz4Cb9QyYNG8NO2SUFMyl06g=;
        b=QACD+6Nlx06R1z1ienzVhP4i1tTpxgfQjB/dVkIuBz9eaG4x7FkpBcuiXRys5Gba+K
         kLUxdIpBtHAN686qvFD6tSnpBo9LXRr0yI/cDNMXcJyg5ETGksbUAcocUkwfO0SSkVhd
         wOSohfgXe17adrSmSEYpiYuALgvA745YO7/x8llsHZR8Ij1TaKkiJn3leSkCeUz1xLfi
         TL4zfuCXpqX2faGnz/tGQfJiuv1OmGOxJ8DXWw/083XFt7AB35eJYLuhhk4IaiNtCqkP
         0eXZ6mX0M18Tj2dYWgJmKZkmQQQntHypaGKRX7X3cjucW1K8hekF4yi4AZKr+hj63WYA
         x1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716433; x=1771321233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SO+AiM4mV8eIbKRvbLLRz4Cb9QyYNG8NO2SUFMyl06g=;
        b=pokhEuBpFASJYX9bW8LBeJmnNRJil4f+aUhAN9VeujrwANYucPWJT8WxUcB91n71wn
         IjeoT+WTWQQBtajUU2TjWXNPlsiS8QI5gHkzDSTkt/5eokEf5vNB0zkJqK+orDLClYq9
         aJcfh+NPsUaj1ndhBvbeUKsixd5GNwYUEymWl0pXNVm92jYpiixmhZahLszZ6BLG2qfr
         DQLjrwsDRpEZljEP9r3QFL3W2ShWf6ek65A2EwXtSEy86iknJrG8+vUGbG120SR0nGUj
         XuDiTJTyxidBzEoccqtpU1anwwNYY9c3i/H7g8jWgjU77ZOwDgAu/9lW2psApxdhDtYp
         w15w==
X-Gm-Message-State: AOJu0YzAOC9Gb8+mTY3NYrH4cSxndXT7lBQS9iVnNkvad/7OLWv1GrGa
	loxXXS1HL8lpSBJ6BQpqEkc10bRcS50e2jJnW8+nuVBVr8dIAZZGS/c5B9FSQ1qAilB0MFFnrKs
	WLAhsUEHkGt8icTT4M+ycR00YH6T3sdqITugkyJglUS9vsQQuGjYhmU55JwxgUThG3DqYBLIgD+
	P67D+truyyXn96m18ouWkfCJ/JyAlj+vUiiOxfu5ol/w3V1g==
X-Gm-Gg: AZuq6aKVIXuifvd8I242yzDppCgVB6T5cRx1FxlFkNSh5mrMr3ffiHhKCy2e66wa0k8
	Hz2hv9sbroHPkp4OuEJ95YSOemMM7N7V9AUappzYYP0eC71U9rX12S6qzXMRsmmKPdvGvdG++NC
	SU79n4JkdlTeLcu19bQZ+ZYGW7QBV67Suu/YmbOJvxCDSfG6x/14Xzt4qDGNA8ektOWGtkx9f5M
	5q/mIg=
X-Received: by 2002:a05:6820:1c8a:b0:66f:223f:81a7 with SMTP id 006d021491bc7-66f223f83a4mr4567273eaf.31.1770716432833;
        Tue, 10 Feb 2026 01:40:32 -0800 (PST)
X-Received: by 2002:a05:6820:1c8a:b0:66f:223f:81a7 with SMTP id
 006d021491bc7-66f223f83a4mr4567266eaf.31.1770716432425; Tue, 10 Feb 2026
 01:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203141608.14128-1-qzhao@redhat.com> <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
 <CAATMXfm88MZ3Fhc0upRQ_5D2Vy+g8CscVAwhfY7nbM9oX93Qvw@mail.gmail.com> <293a4d85-a320-4280-9607-5b9d08ba555b@linaro.org>
In-Reply-To: <293a4d85-a320-4280-9607-5b9d08ba555b@linaro.org>
From: Qiao Zhao <qzhao@redhat.com>
Date: Tue, 10 Feb 2026 17:40:21 +0800
X-Gm-Features: AZwV_QhbfVa4Xm4I3m_sw5iVU-8HrLjY-woCqmC4zI1cyd9YJWfDltyLjcVM3rI
Message-ID: <CAATMXf=HOq8XzfkqCs=GAmvbSBzSBSnvKUert+ggxSS3SOuc0g@mail.gmail.com>
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: James Clark <james.clark@linaro.org>, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, namhyung@kernel.org, 
	mpetlan@redhat.com, acme@kernel.org, vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 11:12=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 05/02/2026 2:14 am, Qiao Zhao wrote:
> > Hi James,
> >
> > Thanks for the review and the question.
> >
> > I did try modifying the check according to your suggestion, i.e. changi=
ng
> > the condition like:
> > +      if (!rdpmc_supported && (pc->cap_user_rdpmc || pc->index)) {
> > However, with this change the tests regress on ARM, the results are:
> > --- start ---
> > User space counter reading 1
> > User space counter reading for PMU armv8_pmuv3_0
> > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> > unsupported counter access 1]
> > ---- end ----
> > 126.4: User space counter disabling instructions                     : =
FAILED!
> > --- start ---
> > User space counter reading 0
> > User space counter reading for PMU armv8_pmuv3_0
> > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> > unsupported counter access 1]
> > ---- end ----
> > 126.5: User space counter disabling cycles                           : =
FAILED!
> >
> > On ARM, cap_user_rdpmc represents a PMU capability and may remain
> > set even when user rdpmc access is disabled via sysfs/sysctl. In that c=
ase
> > the mmap page reports: cap_user_rdpmc =3D 1 and index =3D 0, which is a=
n
>
> That's a slightly annoying difference to x86 then, which makes it a bit
> harder to test.
>
> > expected and valid state when rdpmc is disabled.
> > The intention of the existing check: if (!rdpmc_supported &&
> > pc->cap_user_rdpmc && pc->index) is only to catch the inconsistent case
> > where rdpmc is reported as unsupported, but the mmap page still exposes
> > a fully usable rdpmc state (i.e. both capability and a valid PMC index)=
. This
> > avoids flagging the ARM case above while still detecting real inconsist=
encies.
> >
> > With the current logic, the tests now either pass or are skipped as exp=
ected
> > on ARM, and there is no behavior change observed on x86_64.
> >
> > Thanks,
> > Qiao
> >
>
> But "rdpmc_supported =3D pc->cap_user_rdpmc && pc->index" here:
>
>    if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
>        rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
>
> So I'm still not sure I get checking rdpmc_supported with those exact
> two things again.
>
> In fact I looked more closely and the test is already setup to write to
> <pmu>/rdmpc to run the test twice with it both enabled and disabled in
> set_user_read(). We only return USER_READ_UNKNOWN in that function on
> perf_user_access platforms, but only because that function doesn't know
> the place to enable it is /proc/sys/kernel/perf_user_access.
>
> So actually we should modify set_user_read() to try enabling in both
> places, and then the test can test enabled and disabled outcomes on Arm
> as well as x86. Now that we know there is this other file we can make
> the original intention of the test work with it, rather that just adding
> a skip and not testing anything.

Thanks for suggesting to modify set_user_read() so that it can try
enabling rdpmc
both locations (PMU <pmu>/rdpmc and sysfs file
/proc/sys/kernel/perf_user_access).

Before preparing the next version, I would like to confirm the
expected direction.

My current understanding is that the intended behavior of the mmap rdpmc te=
st
is to actively toggle the user-space counter access (enable/disable)
and verify both
outcomes, rather than skipping the test when rdpmc is unavailable.
Based on this,
the next step would be to update set_user_read() so that it attempts
to control rdpmc
through <pmu>/rdpmc first and falls back to
/proc/sys/kernel/perf_user_access when
the PMU interface is not present.

Hi Ian,
Could you please confirm if this is the preferred approach for the
next revision, or if we
should instead keep the current skip logic for platforms where neither
interface can be
modified?

Thanks for the guidance.

- Qiao

>
> > On Wed, Feb 4, 2026 at 5:40=E2=80=AFPM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >>
> >>
> >> On 03/02/2026 2:16 pm, Qiao Zhao wrote:
> >>> Some architectures control user-space rdpmc access via sysfs or sysct=
l,
> >>> for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
> >>> rdpmc attribute under event_source devices on x86_64.
> >>>
> >>> The mmap-based rdpmc tests currently assume rdpmc availability purely
> >>> based on perf_event configuration, which leads to false failures when
> >>> the system globally disables rdpmc access.
> >>>
> >>> Introduce a helper to detect rdpmc availability via sysfs and skip
> >>> user space counter reading tests when rdpmc is disabled by the system=
.
> >>>
> >>> The check is only applied to USER_READ_ENABLED tests. User-read disab=
led
> >>> tests continue to run unconditionally, as they validate perf_event mm=
ap
> >>> semantics independent of rdpmc availability.
> >>>
> >>> Additionally, tighten the unsupported rdpmc check to require a valid
> >>> counter index, avoiding false failures when cap_user_rdpmc is set but
> >>> no counter is assigned.
> >>>
> >>> v1->v2
> >>> - Check rdpmc availability via sysfs before running USER_READ_ENABLED=
 tests
> >>> - Handle both perf_user_access and rdpmc sysfs interfaces
> >>> - Avoid false failures when cap_user_rdpmc is set but no counter inde=
x exists
> >>>
> >>> Testing:
> >>> - arm64: rdpmc disabled by perf_user_access (tests correctly skipped)
> >>> - x86_64: no behavior change compared to v1
> >>>
> >>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
>
> [...]
>
> >>>                if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->in=
dex)) {
> >>>                        pr_err("User space counter reading for PMU %s =
[Failed unexpected supported counter access %d %d]\n",
> >>>                                pmu->name, pc->cap_user_rdpmc, pc->ind=
ex);
> >>> @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum us=
er_read_state enabled)
> >>>                        goto cleanup;
> >>>                }
> >>>
> >>> -             if (!rdpmc_supported && pc->cap_user_rdpmc) {
> >>> +             if (!rdpmc_supported && pc->cap_user_rdpmc && pc->index=
) {
>
> This weakens the test on x86 though. If they behave differently you
> might want to just skip it on platforms with
> /proc/sys/kernel/perf_user_access and add another test for them that
> pc->index shouldn't be set if it's not supported, but ignore cap_user_rdp=
mc.
>
> >>>                        pr_err("User space counter reading for PMU %s =
[Failed unexpected unsupported counter access %d]\n",
> >>>                                pmu->name, pc->cap_user_rdpmc);
> >>>                        ret =3D TEST_FAIL;
> >>
> >> Not sure I understand this test, shouldn't it be (pc->cap_user_rdpmc |=
|
> >> pc->index)? As in, you don't expect either of them to be set if
> >> !rdpmc_supported. But then it's the exact opposite of the one above so=
 I
> >> don't think it does anything.
> >>
> >> Either way the test now passes or skips properly on Arm:
> >>
> >> Tested-by: James Clark <james.clark@linaro.org>
> >>
> >>
> >
>

