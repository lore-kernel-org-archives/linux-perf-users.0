Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5578F2E
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803281; cv=none; b=M/W7iQRCPiALhQIyZM+RxR7e9QIbZMpNcHnBCDbxVpjNRmjqmVqGLbpul73gA6P4WMGJCdCVP7EUJXepbTEXA8y0w6D2uyMvrN4dnQaLNQv+udyVNjQpfEe5ivf9NAYqQfqciTNPBD1liuWF3ezLfCCocZQrS8HEiukCdA5eqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803281; c=relaxed/simple;
	bh=fg3sGqTViN88dM5k4ylApUrKt/tIekFtKGDLtWGuHNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYTGLFGnlJQHK43deWMNZUBkJw6dQyEY0WmnPy/ORIkVRHs3VBBWJEnlqiOD9bjYT77ym+ZOMLnGwtzZ+hIUQ4I4mKB0k/e5g7fWm8UhQxZYLZptofUXVYvsIh70/YF2G/HOufHyJ7Y7o20Mi8Nb3+hclq6s/UiwQKnjMFrTu30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeDKefIw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeDKefIw"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so7201311a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778803279; x=1779408079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekwzuKByn89i3DA5c0najFAwiJQphytX5oT+VOszmD4=;
        b=SeDKefIwVwv3U/FezxZZxhhwzFx3X12RUOthZL3b+iqb78pEPXWZqaFz7WeBJN7jBi
         N3RcoJUBgtCUCByINWLLQ8TlwUZ5HJXS1XMFV6KGSSp/diOCI5BATfODi32LnGj8d3kj
         giX/Jk5v4dqwjUJEmLGR/Hf8Dflwwh9UnZccLM8lICpVhC55hDzc4JMi1HvkeKWUTGc7
         3LOGDHejho12Wc2mVLWTLZcDYbgfKz7CliIfEWAobPW0zeydsGiJoCy8Zz3hwBzpj7uI
         cue2qwQ28lHIcPA1Z/CfPdvhsFZAiX6utfqndhpuQrvB6jsQd4FiJyrKDq+b9Z/JFV7a
         Ys1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778803279; x=1779408079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ekwzuKByn89i3DA5c0najFAwiJQphytX5oT+VOszmD4=;
        b=gXhtbBnhOHjPWKsFo0zveojDFFVkZ+fmj8NcUgQ56xohTG2SENP3ZI/UyPeSrbYERU
         AcbwTmrdsOeVEIeHsCwRq7+QCaEa2Z55zxVEZ1s+oPrswwGp7BGKBofYkeh8X4D2HpzF
         6bN/sv1WYAkhoBWXTT8kWzbVQtulEnl3WS0RR8/QdD9wcpnUciHBy6+AuQ/coHs1Q097
         fGMqo1/ItAboWzLoDPbsa/l2Cf+oQLTtmv+V5z+klDNno9yQQ4RoAUfKVBBbUZep2QQy
         10gz4ENevMdXrm8mUHh+cYsV8VzJz+AwtQhLLR/94rbM+bQGUaxFLAtnuaApBaIXnM1f
         4eQg==
X-Forwarded-Encrypted: i=1; AFNElJ88mjMtJ7mGh+KhWQh2DjVVruTmXRUqJn8AeF6iMMRhAavaopOrKdqotMffu49Y2UjazmBC4NcW4XhpuLm4zDOE@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsoEFCtBMs/beXPFrPEZg3VRRLc2vBs2bn7p1AxbikJw9RDd9
	v2zEaiX6X58NxKCPcGMhv4CEbdQvDoeKmhhsExDWGJ/0QpGs+MpGCHlQqy7gXIU0sbg06htktSG
	oe8VrXg==
X-Received: from pjzh17.prod.google.com ([2002:a17:90a:ea91:b0:366:466d:7b2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2703:b0:368:7327:6326
 with SMTP id 98e67ed59e1d1-369519e207cmr1474299a91.1.1778803278494; Thu, 14
 May 2026 17:01:18 -0700 (PDT)
Date: Thu, 14 May 2026 17:01:17 -0700
In-Reply-To: <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-2-seanjc@google.com> <20260508234018.F06AEC2BCB0@smtp.kernel.org>
 <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com>
Message-ID: <agZiTeGgRO4PJ9mI@google.com>
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: sashiko@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026, Dapeng Mi wrote:
>=20
> On 5/9/2026 7:40 AM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] The host PEBS collision check fails to mask non-counter bits, =
incorrectly disabling guest PEBS for events like Store Latency.
> > --
> >
> > Note: The format of this report has been altered due to recitation
> > restrictions. The original patch code is not quoted directly, and findi=
ngs are
> > provided as a free-form summary.
> >
> > commit 39adc53b360e88595a3be6fc59b18b048d9e9921
> > Author: Sean Christopherson <seanjc@google.com>
> >
> > perf/x86/intel: Ensure guest PEBS path doesn't set unwanted PERF_GLOBAL=
_CTRL bits
> >
> > This commit masks the pebs counter values being reinstated into the glo=
bal
> > control msr for a guest with perf's desired value. This is done to ensu=
re the
> > hypervisor doesn't unintentionally enable counters.
> >
> > In intel_guest_get_msrs(), the host pebs collision check evaluates the =
host
> > field of the pebs_enable array entry to determine if the host is active=
ly
> > using pebs. If it is, guest pebs is disabled.
> >
> > Is it possible for this check to falsely detect a host collision due to
> > non-counter bits being set?
> >
> > When a guest configures a store latency pebs event, a backing perf even=
t is
> > created. In intel_pmu_pebs_enable(), this sets both the counter index b=
it
> > and bit 63 in cpuc->pebs_enabled.
> >
> > Because the host field is calculated as cpuc->pebs_enabled masked again=
st
> > the inverse of cpuc->intel_ctrl_guest_mask, and the guest mask exclusiv=
ely
> > tracks valid counter indices (never including bit 63), bit 63 remains s=
et in
> > the host field.
> >
> > Consequently, the check for whether the host is actively using pebs wil=
l
> > evaluate to true even when only the guest is using pebs. This introduce=
s a
> > regression where guest pebs is completely disabled, silently breaking g=
uest
> > store latency events.
> >
> > Should the host pebs usage evaluation also be masked by intel_ctrl to p=
revent
> > non-counter bits from triggering a false collision?
>=20
> Hmm, I suspect if the issue could happen on real hardwares.=C2=A0=C2=A0

OMG, it took me _so_ long to understand what Sashiko was complaining about.=
  I'm
pretty sure I read Sashiko's response like four times, and it didn't click =
until
I read your response.

In case anyone is feeling as dense as me, Sashiko is saying this:

	/*
	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
	 *        of disabling guest PEBS entirely if the host is using PEBS.
	 *        What exactly goes wrong if guest and host are using PEBS is
	 *        unknown.
	 */
	if (pebs_mask & ~cpuc->intel_ctrl_exclude_host_mask)
		guest_pebs_mask =3D 0;

should probably be masked by intel_ctrl as well.

> The function intel_pmu_pebs_enable() indeed sets extra bits=C2=A0into
> cpuc->pebs_enabled=C2=A0for load latency and specific store events, like =
below
> code shows.
>=20
> ```
>=20
> ......
>=20
> =C2=A0 =C2=A0 if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_p=
mu.version < 5))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpuc->pebs_enabled |=3D 1ULL << (hwc->idx + 3=
2);
> =C2=A0 =C2=A0 else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpuc->pebs_enabled |=3D 1ULL << 63;
>=20
> ......
>=20
> ```
>=20
> But these 2 cases should only be hit on quite old platforms (prior to
> Icelake). On these platforms, only GP counters support PEBS sampling and
> pebs_capable would be set PEBS_COUNTER_MASK, and so these extra bits woul=
d
> be filtered out by the pebs_capable and pebs_mask won't really contain
> these extra bits.=C2=A0

Thanks for digging into this!  I was staring and just going "huh!?" over an=
d over
in my head :-)

> Anyway, we could optimize the code further like below and thoroughly filt=
er
> away these extra bits. (only building, not test on real HW)

Hmm, I think I'd rather figure out what it would take to drop the FIXME ent=
irely.
And if we need to keep the check, I'm a-ok risking false positives until we=
 have
a better understanding of why the check exists.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 854881b5e696..6eee7636a822 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4997,7 +4997,7 @@ static struct perf_guest_switch_msr
> *intel_guest_get_msrs(int *nr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cpu_hw_events *cpuc =3D this_cpu_ptr(&=
cpu_hw_events);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct perf_guest_switch_msr *arr =3D cpuc->g=
uest_switch_msrs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ct=
rl);
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 pebs_mask =3D cpuc->pebs_enabled & x86_pm=
u.pebs_capable;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 pebs_mask =3D cpuc->pebs_enabled & x86_pm=
u.pebs_capable & intel_ctrl;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 guest_pebs_mask;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int global_ctrl;
>=20
> @@ -5049,7 +5049,7 @@ static struct perf_guest_switch_msr
> *intel_guest_get_msrs(int *nr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the guest wants to use for PEBS, (c) =
are not excluded from counting
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in the guest, and (d) _are_ excluded =
from counting in the host.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0guest_pebs_mask =3D pebs_mask & intel_ctrl & =
guest_pebs->enable &
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0guest_pebs_mask =3D pebs_mask & guest_pebs->e=
nable &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ~cpuc->intel_ctrl_exclude_guest_mask &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cpuc->intel_ctrl_exclude_host_mask;
>=20
> >
