Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711A30C637
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099966; cv=pass; b=J10L3Cbqvef2Vf6AMBvusE97D/YIt10vNLLy7YS0iZuRs2eIe1GvNbhhmDi4SoRf4LlnSZH1sybqiAXS7SB75+ojLJLlc7opxCV2ZN1bywgGkdZ0fKpOWF8glYQ+k/JIhI0n+CKrMc5pMQZ2fkdzFOuFaJMrivyRdRo8R0Uowj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099966; c=relaxed/simple;
	bh=YjXK6BgOQPsgC6R00beChvNdVm49sWujUHpCNdRld+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2+YdBNgWehTQKA4IrejfB14z+XjMPx4egawdxNw/6yLOvAoaV/q2o07qeCTEqV6u5ke85sLfho9aGmuNx3TlfDMzJ1JPiPGo55ssE5UK/PiegPfYp8n/PPvO0ZzQ/ZreRVufo7ai/CkWBtHZihAbrwpzzZ0oBPcPt/nfkMSntA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwfwhj4V; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwfwhj4V"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1448a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 14:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792099962; cv=none;
        d=google.com; s=arc-20260327;
        b=pvARTkyM8MpbQPKNbLiX5M6T5TmgGkTWbWhdzYehxU6vU688fRcXvkoXzsaegtyyq0
         f31tAAMM/cPevIbyBAZ/E0PIqsy0f+UaiIzpZn43ISdH3LelFNPAzQJ6qPC+A+Z3Ms2Q
         eR90mW5Mq3fOezMYqGExWDGexIhKv235eTQLlHWLgq1G4IUX2It5oBkAcCwvepCzUSCB
         sBECufSLQG65N/DQqtbITLuY+rmV0rp7oDckFLzbRGR3IH4b/6w/zOhWkSK19wjq9UMv
         TfINaCdPh6ckfa22DiwlLO/Wnvhq5hXQBXNuz05gDA2KHl5W4d/vU/90aQBkOkLovNh9
         N6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F9EW3y40s5N/1pz2rYlIzPCqkKsyouo5NVLiPakQV0A=;
        fh=Jm8Ne0WrGT6SYbxil3csRRMDybVGMpJPPnuT82v0oQY=;
        b=OcCFRlrn+YPzEpffVsJaYCszvvYcI5M7w9rsEOhBT6mASqw7gItkErigebsktmo+xw
         jnJyb/tPhFSkU8hvXxiQZ08SVlxYMwGL9N/7iCP8qqF+NvtleRZZF9Q+9+5nrmJoaYfs
         wPPZU/c36QQVBB5qoDqg7o8Bf3og2sngDbhIPewlXIk0F9h8dY8d/EeR7qSWL04KhAYM
         KKQn1pbwf2bcLHeWWImGXuziEeYR7/5Nb2BEM03tK0ufuLak9Z/Rr2iqwtEEJF3kawRl
         aw2ZP43tVHFudioD/XJv2xG/+sa5NU0wXBC91wzd3x0BrP4GQRbvsWQBjOQ0OJ2iDJtu
         jC1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792099962; x=1792704762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F9EW3y40s5N/1pz2rYlIzPCqkKsyouo5NVLiPakQV0A=;
        b=rwfwhj4VJCsrL5qvq66Wlr2SQg8D1u671ODcpczPQNa5EXT9QwgjLTc8MGEJboftze
         CzH7YgLJDpsRdiwOVO0fw1qmvY2DjZGSCAiI/ZRFAdry4YmInfjvzntmhh5QMt4F3l4G
         UtXVtMLVZVX6p833RG/WbYbKiYqABPCKH84Qnt/Zg/dnqTM1W8ErxPQF76DflDzREFi6
         fDZhAJsJIHYz1P+3+OiEh1sct0zKVYkzv90QrAzPhQt7t1VWomAHnUwNTRIqpIO8boGl
         mccZKco4YV92piRvaToAWeNHjn2IGQzcYwPlhVKxKuyyjg20Kt4cvliKaH/rsMLzQvFE
         Dq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099962; x=1792704762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F9EW3y40s5N/1pz2rYlIzPCqkKsyouo5NVLiPakQV0A=;
        b=bfpR9axb4wyJqW7X/MF6GGomR66pUdN8FGouIgCn71oci/tB6YutdAKlXpQvWZSVpl
         Q9UlBaBwRsEK5jV6XGtO5DpNcMX07P/EC+Ew+KXR5orlQBJWL5iTjmJkANkTCkzFzAXc
         fvB5cwc7e36E5fhdP72UCvxpu2yULnT67Nfycc2yUFadDP2uxYIXEoeLPgDR75JlXKga
         Asw0UXEBznsV0onms2IRV3Szx44mqBKLH1RD8GT2TwljPPu2A7bw8PFqr6pWRqoZXMPz
         ssXzE4Lme4djtv6iWYGXR1sZZbaMR3mJQt1bl0ctnY0rPW3veBCCLd2cQw00VJtFeWSj
         djyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlSvg8ZVRaadyTQZjf7nc9XsWzDaPVto3UUkwRGNtFc+km3x1SUnxdd4uUWO71IEG/1SgMioZzlVQRG+m67p4h@vger.kernel.org
X-Gm-Message-State: AFq9FYIY7dBNr7iLfvfnnZSGvSR3g7aCPDEzkmHBmnL6HFd/A06gRv7j
	Rf6G8xvqhKiG5QuWBby/aQo+uw24CAVDfzyvEBD/KevIoJv8l1dLmhiVgX8AxlB/0R/QStdDKEy
	1YDiq2MOA06GY0P4keSoX+FYu3vPcZYxHPaGK6xFC
X-Gm-Gg: AYBFou32C6OAQPymvT9Cgl++Nj8TpLpgnv2Ak5GlWe4VJkJKcIOBzksh35hHJ4Per2M
	l5zxNtZE6L9Q9Q8xtmg9IU7xCwSnn7duYSpyk7EhR5fhdRUeXfIT5bTVYEKUkdfGLG882xIQde3
	xXzodTQi5U38GH5OGx8pfYau0reI4P1XoIdDYVP4X+siDhyp6PN4dKyGH1K6EKN6xJ2o/XxPC4j
	bUPC92yqCQFtIsqQZMaMqoMv8EgF9qAZ78L+5wZ/htePQmv/5e9JHd2J2DKUGr53cvGo8/2HQfU
	Tx8k+WReL9FXYoDibWnOVIRF/erazjjuJgsMoxB0F0vhWFMbZgiF1zw=
X-Received: by 2002:aa7:cccd:0:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6b389316e80mr23741a12.9.1792099961542; Thu, 15 Oct 2026
 14:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015060430.5877-1-ravi.bangoria@amd.com> <20261015060430.5877-4-ravi.bangoria@amd.com>
In-Reply-To: <20261015060430.5877-4-ravi.bangoria@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 14:32:27 -0700
X-Gm-Features: AclHuK_p27UYc0NrEirae72lDoPwVkg8nyO4-1bdkKyLQyhcreyw4plaer2PY6E
Message-ID: <CALMp9eRTG=uLkAWohYW0HOoS1xvNc_0brovYsfbCUS_mf4H3Kw@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 11:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> The IBS_{FETCH|OP}_CTL2[Dis] bit allows IBS sampling to be stopped withou=
t
> a RMW of IBS_{FETCH,OP}_CTL. Systems providing this bit therefore do not
> require the IBS_STARTED and IBS_STOPPED states used to coordinate control
> MSR updates with late NMIs.

CTL2[Dis] doesn't make late NMIs go away. Hence, this patch needs a
50us poll. With the two-line fix in my original patch, the existing
scheme handles late NMIs indefinitely: IBS_STOPPED remains set until a
late NMI consumes it, even if the event has been restarted in the
meantime. This patch trades that for a 50us window, after which a late
NMI is unknown (which *is* fatal with unknown_nmi_panic). Moreover,
since we still have to handle hardware without IBS_CAPS_DIS, we now
have two state machines instead of one.

> Add a separate stop path for these systems. Preserve Val while disabling
> the event so that a delayed NMI can be identified and consumed, and wait
> briefly for such an NMI before restarting the event.
>
> Leave the existing handling unchanged on systems without IBS_CAPS_DIS.
>
> Reported-by: Jim Mattson <jmattson@google.com>
> Closes: https://lore.kernel.org/r/20261007234815.4026028-1-jmattson@googl=
e.com
> Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to e=
liminate RMW race")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 145 ++++++++++++++++++++++++++++++++------
>  1 file changed, 122 insertions(+), 23 deletions(-)

 [ ... ]

> +/* ->stop() for platforms with additional CTL2[Dis] bit. */
> +static void perf_ibs_stop_dis(struct perf_event *event, int flags)
> +{
> +       struct hw_perf_event *hwc =3D &event->hw;
> +       struct perf_ibs *perf_ibs =3D container_of(event->pmu, struct per=
f_ibs, pmu);
> +       struct cpu_perf_ibs *pcpu =3D this_cpu_ptr(perf_ibs->pcpu);
> +       u64 config;
> +       u64 ctl2;
> +
> +       WARN_ON_ONCE(test_bit(IBS_STOPPING, pcpu->state));
> +
> +       set_bit(IBS_STOPPING, pcpu->state);

This function needs to be reentrant. If an IBS event is a sibling in a
group led by a core PMU event, and the leader is throttled,
perf_event_throttle_group() will stop the IBS sibling from the core
PMU's NMI handler:

    amd_pmu_v2_handle_irq() ->
      perf_event_overflow() ->
        __perf_event_overflow() ->
          __perf_event_account_interrupt() ->
            perf_event_throttle_group() ->
              perf_event_throttle() ->
                perf_ibs_stop() ->
                  perf_ibs_stop_dis()

[ .. ]

> +       if (in_nmi())
> +               wrmsrq(hwc->config_base, config);

As we saw above, in_nmi() doesn't mean that we're in
perf_ibs_handle_irq() for this sample. If IBS Val=3D1 and the IBS NMI is
still pending, this clears Val. When the IBS NMI arrives,
perf_ibs_handle_irq() finds CTL2[Dis]=3D1 and Val=3D0, and therefore
returns 0, leading to an unknown NMI.
