Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792433463;
	b=e0zaWbxM9skF0jWdzGemNBMzjV3f+wjsX1ECggyt8gp+aYz+oWA7CPEgDSt5fISaUJtg
	 MPm7Wqf5hudkj1E52oT7dMuJBZ6MyK/sftJyhY8hwB0OSquA/LeUjy8laCIpV/mGVGCwU
	 rtIu4dYlxsqcF5jY+VjwbCkKAwDv9UE1EhoB79ZrP4eqn/t+edOGWFNsSIorFeFUyOVQr
	 oEX3y6Aecl8sR1NPDJDR5erVfLODWbYNuwUsBki4bnbyN7pM+w6gQ1f0miYuB7mUjcA6s
	 B1uQ+UWKSFqlx8IyCGCVuHa6FyyZDCWJw9cmhncOaMwf8NTbKqU4GmU0XstZfS0QWnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sw/oJwCnvvZ5IV8SeRYvDYH7RjC/pEaouYLNvORoNPY=;
	b=YW0kOE6e1UUnYLJ3ulB8ZXim2spccncG4II/CkkWczmH2OBqor0tj01qLw/nKE0n4CZW
	 VzcnmboYzfxXsZ3rx6earOqj/rYuQC22sAAh2y84jyDKqnhcmZjVUPgmzuYzQLkKkuJoV
	 kC/J0HsqZ3Ky+tD/U0PyU78Qye35svt+ce5K0IUDKAgYuugvozaeVt97Z+IVRjNADk0F1
	 Q9e5Tso3yJnvjjAwMJEY1hQNlDuw+HurwtjgF+IUrpwCq1n3YhWzT/bkoryMMMyRyDQ9F
	 628ZqwBUcadRphBCM8j1Eiz9vL6g/+cMLJ3N0yRn7I+zgQYfqXDO+8tBPj+Z6aLMqgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XawbiBWp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12D606A319
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 18:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC12D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XawbiBWp
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1176a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 11:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792433461; cv=none;
        d=google.com; s=arc-20260327;
        b=Zgt7ba78pbI9qsMvkjyfCWDtuai5mQF79QMbQtzPKGi8VwwbYYqbO+9O0K5PceeR2Y
         PNkd9GUsGjzkxX0UsFZbHCnEftCY9+f1LznkC7PF8OCbw1rV0KIrdtCsnhZWNsPPYXSo
         syR/wVCOtjocJIvs8AdJDGP0kQ8o2ZT6mggJaPPTNxpUYqekt16Nn+cEy30/QzKqVBwo
         Hsr48dXfciqAuibMQRr3Eh13yB9wm39qNAtsFHYUcfP9LYkr1hVfmOKtPy3+Kfyjt0vF
         wEkBgfOq5tolnWfX3D1TY49+yWp3j06kuQvdIpAtGtoWSylHwqLeyB7ZttKqnrak2kWs
         jA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sw/oJwCnvvZ5IV8SeRYvDYH7RjC/pEaouYLNvORoNPY=;
        fh=rPURb7h61Ziy0ETdD1STX3/aYCxiC6zs3KB9d3FintE=;
        b=r+RC/VXZRW+3aR6F6XI1Xd+Ouzfg5I77rP6vFMJAiGgSs9K0xttgUCk1cxNP70KJiW
         FRJKCOuX1GH0N9EOb/QeoTeNl6ZfCj/0Kf+693ifY/fioxGrEnnTTn2IcWc/8DWWYW6c
         lH7BSC5bd3cA9fd4kVbbbD1gTQ/YNQ2MnEIF8gBsj7DIIc4eNy+wdNAfGlPWrqEOZE+l
         b0qPT3sNV7NjQwbQg/jRE3jCdue1kSZYCvmg7gCv5Rh558JJv9nSfQAN6+yjB6VK7cz0
         hOVHGM+yZe9Oj0+804pZPj0REkYVwr2gdaaLRgjnY3ug5sGtV2ddO5g73jZDUkfttDRS
         zKvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792433461; x=1793038261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sw/oJwCnvvZ5IV8SeRYvDYH7RjC/pEaouYLNvORoNPY=;
        b=XawbiBWpxBaAbJCrp6sgW2SrdZ1nnwwZpb55aOpDcvSk2bKzJwU1rtiwSM3BYw+QSy
         LJhAib2gkkrM6hvyqj6cFrseRPshfhQRFHI+wcKvTO6v2OG5pJsNNCRuBeaxF6u0m7HX
         JXPn9HOOgvBL3V5ucDb9YnCe9xLndgmSa028loyJqNJZyPnk2lB5Rf7dJDSgKYRD8CPi
         7AkWiYGkZBb8LEB7OtBJ5gyeXCFsDV/+GHZEte8rjxoONXoBGaKzXWPF0WAjPvht8BZf
         eYNk1rocisjaLhsnKFdGUhnEMtqGwefaZ1ZVYRBDLYzW9SgpYKVAvdgoohRuM90dhpeG
         YIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433461; x=1793038261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw/oJwCnvvZ5IV8SeRYvDYH7RjC/pEaouYLNvORoNPY=;
        b=gNVrwDlc1++hRVYrdzfr/sy+Sl6Py+7DrULI3KIu0e70qYM6V3Np7YPX2UlP9VB007
         ltZfxBPtI9b7a/Icn4H4xo1v1fCCHE3mXGVxVP0WRwnn0x+O5E+Pfe0WzmjrvqJLS39r
         WNzMqKxEdGOy0HBL2R1hsZ2yrHmzb3wWSJLNGqKkHvUhQIVfgcT5lnVM9oOwLY5GWbF5
         UIc5EIH9cZcK/X8l9e3JvncI44joBRe1x99XPN2nmhVSJ2+RD38Z0Q0l3edX2qie41Bv
         hL2eXUp28eBBgGvZ8bTP/YJQ/Qc6PFrDXNiwqnRiEnxRdauPcMgoxILZNvXKtsY3j/S2
         l6Ig==
X-Forwarded-Encrypted: i=1; AKwUvBzIW6X9j/4M4hEyNWtMo+eQ5aJ6llJdCSkGXGGzZL2NYxvAT10hoDt8rXo7NDJuO4pxGQuTea8gxveJfsciXERo@vger.kernel.org
X-Gm-Message-State: AFq9FYLiolmifZmK3BqyRyTJ3q6yKY7RIjhbydNMUN0KhSAbEwoMGPZo
	oJJMQGtYHGSSX/qPhr3TBdOpaYA9tU15/OIAUQ6UsElovx0JBOkoNUAMT4G3R77vpKpUGCsnfc8
	OfCDLF+wl92r8OAm5oINTNeFm6qM/djqH3/k+O18M
X-Gm-Gg: AYBFou1lP9TTHsAwXp/h+YYb9BhuLyUgAm72mYtrOxu64dV1wcC/OG6HLtzI8I4Cb59
	opFbLRBSzYPhITV6vEF2BEdsjdr64oSfMI2UPBeXKNbE/z9ish3tqtKYwR/r7L2LmeSVA++YAHg
	ZUnFC+1mKhdVG+trg9G9VNHhjtH2lPTzk9gFfsaqbKN/3dQ84cqLe3BL5OqV7pi0Ht6aKwGJ55j
	Zwb5nyQ/nrXjn2BhavmaoPtt4MujPW+zQjn8Ru6T8MtlwDU/tJ3pySSn1bK6IMYLJ37/8s+bv4o
	dQyzyEmp6U9Dk0fkXJQ+JG1kxPa9Bnm7gnofMpyCyv9qJvGAFYh07ig=
X-Received: by 2002:a05:6402:a542:10b0:6b1:bc48:2238 with SMTP id
 4fb4d7f45d1cf-6b3e5a09b7cmr341a12.11.1792433460748; Mon, 19 Oct 2026 11:11:00
 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015060430.5877-1-ravi.bangoria@amd.com> <20261015060430.5877-4-ravi.bangoria@amd.com>
 <CALMp9eRTG=uLkAWohYW0HOoS1xvNc_0brovYsfbCUS_mf4H3Kw@mail.gmail.com> <09e61c95-97bd-46c7-9d96-c3926e324c26@amd.com>
In-Reply-To: <09e61c95-97bd-46c7-9d96-c3926e324c26@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 19 Oct 2026 11:10:48 -0700
X-Gm-Features: AclHuK96mVnG1xIwf-S_D2KmcmixkT9fy4R8_miYUa2Z7RmYqEds8TdrEX_ogIw
Message-ID: <CALMp9eS_jTjJCY_NUbg3r-QPdFT70pyB_=ZgYi2qAe8pyGzmuw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/amd/ibs: Simplify event state handling with IBS_CAPS_DIS
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jayapal Ashwin Nair <janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Santosh Shukla <santosh.shukla@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 4:32=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Jim,
>
> Thanks for the detailed review.
>
> >> The IBS_{FETCH|OP}_CTL2[Dis] bit allows IBS sampling to be stopped wit=
hout
> >> a RMW of IBS_{FETCH,OP}_CTL. Systems providing this bit therefore do n=
ot
> >> require the IBS_STARTED and IBS_STOPPED states used to coordinate cont=
rol
> >> MSR updates with late NMIs.
> >
> > CTL2[Dis] doesn't make late NMIs go away. Hence, this patch needs a
> > 50us poll. With the two-line fix in my original patch, the existing
> > scheme handles late NMIs indefinitely: IBS_STOPPED remains set until a
> > late NMI consumes it, even if the event has been restarted in the
> > meantime. This patch trades that for a 50us window, after which a late
> > NMI is unknown (which *is* fatal with unknown_nmi_panic). Moreover,
> > since we still have to handle hardware without IBS_CAPS_DIS, we now
> > have two state machines instead of one.
>
> IBS_STOPPED only records that "a late NMI might exist". It can't tell
> whether the disable actually completed or whether that late NMI has
> already arrived. Trying to infer from software state is fundamentally
> broken, since the WRMSR and a software state transition can't be made
> atomic.
>
> Given that Zen6 provides a clear hardware state machine, I believe using
> it, rather than a software state machine, is the right approach.
>
> I ran a fuzzer for several hours with my patch (+Manali's patch [1]) and
> saw no Unknown NMIs on Zen6.
>
> However, With your patch[2] (+Manali's patch), the same fuzzer continued
> to produce quite a few Unknown NMIs on Zen6. One race I was able to
> identify (with your patch applied) is described below.
>
> ---
>   o FETCH and OP both are enabled.
>
>   perf_ibs_stop() /* For OP */
>   {
>        set IBS_STOPPED
>        op state: ENABLED | STARTED |
>                  STOPPING | STOPPED
>
>        OpVal is 0 in hardware
>
>                                                NMI due to FETCH
>                                                {
>                                                     FETCH: Val=3D1, sampl=
e handled,
>                                                     fetch re-armed
>
>                                                     OP: STARTED is set, O=
pVal is 0 so
>                                                     test_and_clear(IBS_ST=
OPPED)
>                                                     clears the STOPPED st=
ate
>
>                                                     OP continues to run, =
it overflows,
>                                                     sets OpVal=3D1 and a =
new NMI is
>                                                     latched by the OP har=
dware
>
>                                                     return handled=3D2
>                                                }
>
>        op state: ENABLED | STARTED |
>                  STOPPING
>
>        WRMSR OpCtl2.Dis=3D1
>        leaves the valid sample in OpCtl
>
>        clear IBS_STARTED
>
>        op state: ENABLED | STOPPING
>
>                                                NMI (late) due to OP
>                                                {
>                                                     FETCH: Val=3D0 -> ret=
urn 0
>
>                                                     OP: STARTED is clear =
and
>                                                     STOPPED is already cl=
ear.
>
>                                                     return 0 without read=
ing
>                                                     IbsOpCtl
>
>                                                     return handled=3D0
>
>                                                     Unknown NMI
>                                                }
> ---
>
> [1]: https://lore.kernel.org/r/20260310060022.15120-2-manali.shukla@amd.c=
om
> [2]: https://lore.kernel.org/r/20261007234815.4026028-1-jmattson@google.c=
om
>
> [...]
>
> >> +/* ->stop() for platforms with additional CTL2[Dis] bit. */
> >> +static void perf_ibs_stop_dis(struct perf_event *event, int flags)
> >> +{
> >> +       struct hw_perf_event *hwc =3D &event->hw;
> >> +       struct perf_ibs *perf_ibs =3D container_of(event->pmu, struct =
perf_ibs, pmu);
> >> +       struct cpu_perf_ibs *pcpu =3D this_cpu_ptr(perf_ibs->pcpu);
> >> +       u64 config;
> >> +       u64 ctl2;
> >> +
> >> +       WARN_ON_ONCE(test_bit(IBS_STOPPING, pcpu->state));
> >> +
> >> +       set_bit(IBS_STOPPING, pcpu->state);
> >
> > This function needs to be reentrant. If an IBS event is a sibling in a
> > group led by a core PMU event, and the leader is throttled,
> > perf_event_throttle_group() will stop the IBS sibling from the core
> > PMU's NMI handler:
> >
> >     amd_pmu_v2_handle_irq() ->
> >       perf_event_overflow() ->
> >         __perf_event_overflow() ->
> >           __perf_event_account_interrupt() ->
> >             perf_event_throttle_group() ->
> >               perf_event_throttle() ->
> >                 perf_ibs_stop() ->
> >                   perf_ibs_stop_dis()
>
> Core and IBS, both are of hardware PMU type and thus can not be
> grouped together.

Ah. In that case, perf_ibs_stop() can only be reached in NMI context
from perf_ibs_handle_irq(), so I retract my objection.

> [...]
>
> >> +       if (in_nmi())
> >> +               wrmsrq(hwc->config_base, config);
> >
> > As we saw above, in_nmi() doesn't mean that we're in
> > perf_ibs_handle_irq() for this sample. If IBS Val=3D1 and the IBS NMI i=
s
> > still pending, this clears Val. When the IBS NMI arrives,
> > perf_ibs_handle_irq() finds CTL2[Dis]=3D1 and Val=3D0, and therefore
> > returns 0, leading to an unknown NMI.
>
> The back-to-back NMI handling logic in the x86 generic NMI code should
> already handle this. No?

Given the skid that the 50us poll is designed to accommodate, I'm not
sure that the back-to-back code always handles it, but since
perf_ibs_stop() can only be reached in NMI context from
perf_ibs_handle_irq(), I retract this objection, too.

There are still problems for older hardware (e.g. the race you
identified above predates my change), but that's a different
discussion.

Reviewed-by: Jim Mattson <jmattson@google.com>
