Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946B3E8C7C
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313274; cv=none; b=JvsZB2Drq/GvPG2u1ayF/yscv/t8rcQYPGvWOh7GfnaKbaXWOV//1jMzqpvUCRvLPGArx0IlXnaC0Hhl0VBWv30rjZE6/IMTWd7d8Q1I0tMD7BOCTm1BJkpR5JVNFBjSys1zLaf/hJu1FTlZWMsadLhKxtp0vdFCZy8F783APxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313274; c=relaxed/simple;
	bh=96FK0J5SFoQd0d744pNmWYGadevOaCIQAgddi9+8C7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQsENQB9sYKWUmij23ncG11pg76WdinDCcEa554/zcp0L6d6v8CpU7lTyx6J11GeRLasQhTuJnxwGAZrobBIE8eR/yfn6HDu5KE9O97lwH6p6FfYZ08fqjGnD8Mh474lZBwCSw0v2X0E0mH7M9K5wNJYftB9iLzhYcsrx0vmrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUJV8rBT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUJV8rBT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso11885763b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777313272; x=1777918072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqFKfurWLw8iXQu8R+YsfjtSOjs3MOMDwBjfPMXsdGc=;
        b=AUJV8rBTS3hUQ6SWsiHRQ58GbNrbs9zRvvkbjSFgKTMYRhFS4ZxcUJPd8DMWtQ2ufP
         sb7fIUhsGeZJ6A160GWgH3dQ4IW1BAv2t7dqNocmNavrwsPoRlhUmljs3dLMSdmIYqaw
         HrHCPux+hCDN2bSAHeHgiP74drFYTykHF1TQmcTHYlu0fzjknnq1rjd1RJFK9acmzWl5
         c0wA7KiZsnQAHyWkHEuC7yka2C23gQS1JLp3tcoOS6TPj5wG3m7+XWalvrmzGV/cxenr
         PN6D8Oep+hwk2PqodCeSG+uuVmxKrK74FN/Cy6mzjUV3Yby27D9DUMyY54Lb2mIclaC0
         fZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313272; x=1777918072;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqFKfurWLw8iXQu8R+YsfjtSOjs3MOMDwBjfPMXsdGc=;
        b=bX3Qw9OnrOt1oXntvjsXNnbEA1qwMdqRHJZ4D4h7i8DFEnLcFUcytDisWwn9zTyqgO
         xAbgRMgB73Bh8tv/km1Qgo3IEDt1xt1bbf8/Gx0aGzVG8hW4C/AiZdDtUeN3nn3Ktqxb
         D4I86fxVEjTO8KmMZNuqh7bZvO4wNo4nGBccwM9HmKq+ouphD3yQ9r7QeYku5Px8+vS+
         a0ThVzMG1GSNVaJvDGCdZRI9AFLIToOtfGWnrhFiFUBbWzcVA89EZ77z92wGWyFYGuJb
         RfNr2sRcoBd6hwf5X6aO3nKlMOxMn3RCSi2YypVr09fR8ehifF9cZZiVskFR5vwibtKA
         8sRA==
X-Forwarded-Encrypted: i=1; AFNElJ+UTjv9hgdMf5WqIdd2Ug4VT1dFL+j2hW9oO9MdXOyBao1MfoFh8ai6qwjn48fwozNJsSZ4jd5f2DZNrNuzFcD+@vger.kernel.org
X-Gm-Message-State: AOJu0YzX8n+Hb7+g4S05IOw2HGngGlq06GGHwfC/3Z4/61Opjx3Xh9F8
	TLsRW3a2U5QlVd8uHdIVjdcOimDmbDR2iQIb1g/M3gxHGTvZy4kGE4mDyr29Ub/gVEvnlshqlh6
	Djog3Xw==
X-Received: from pffx16.prod.google.com ([2002:aa7:93b0:0:b0:82f:af01:3a8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1bce:b0:82f:5f2c:dc1e
 with SMTP id d2e1a72fcca58-834dc241682mr60145b3a.30.1777313271650; Mon, 27
 Apr 2026 11:07:51 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:07:50 -0700
In-Reply-To: <435241c3-20a7-4214-9f54-5ca82678dc3d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-2-seanjc@google.com>
 <CALMp9eSivf0oDdbgfLSY0zcvtMAV__da8ENCJk=QpEkEeUC1PQ@mail.gmail.com> <435241c3-20a7-4214-9f54-5ca82678dc3d@linux.intel.com>
Message-ID: <ae-l9qDd4Qnvq752@google.com>
Subject: Re: [PATCH v2 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026, Dapeng Mi wrote:
> On 4/24/2026 1:59 AM, Jim Mattson wrote:
> >>  arch/x86/events/intel/core.c | 42 ++++++++++++++++++++---------------=
-
> >>  1 file changed, 23 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core=
.c
> >> index 793335c3ce78..002d809f82ef 100644
> >> --- a/arch/x86/events/intel/core.c
> >> +++ b/arch/x86/events/intel/core.c
> >> @@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_gue=
st_get_msrs(int *nr, void *data)
> >>         struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
> >>         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
> >>         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
> >> -       int global_ctrl, pebs_enable;
> >> +       u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_mas=
k;
> >> +       int global_ctrl;
> > Is it worth noting somewhere that pebs_ept is not supported on any
> > CPUs with PMU version < 5, where a single event can set two
> > PEBS_ENABLE bits (cf. intel_pmu_pebs_enable)?

Is that a hardware limitation, or a "perf hasn't added pebs_ept for PMU v5 =
yet"
thing?  I assume it's the latter?

> >> +       /*
> >> +        * Disable counters where the guest PMC is different than the =
host PMC
> >> +        * being used on behalf of the guest, as the PEBS record inclu=
des
> >> +        * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status=
 for the
> >> +        * wrong counter(s).  Similarly, disallow PEBS in the guest if=
 the host
> >> +        * is using PEBS, to avoid bleeding host state into PEBS recor=
ds.
> >> +        */
> >> +       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cro=
ss_mapped_mask;
> >> +       if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> >> +               guest_pebs_mask =3D 0;
> > I don't understand this clause. IIUC, it says that if we don't have
> > any exclude-host PEBS events, then clear PEBS_ENABLE for the guest.
>=20
> I suppose it says all guest PEBS events need to be disabled if there is a=
ny
> event using PEBS on host side, and it's clearing GLOBAL_CTRL instead of
> PEBS_ENABLE to disable guest PEBS events.=C2=A0

Yeah, but why disable _everything_?

> > Yes, any guest-programmed PEBS event should be exclude-host, but if
> > there is an inconsistency, shouldn't we apply a mask? What if there is
> > only one exclude-host PEBS event, but there are two bits set in
> > guest_pebs_mask?

I'm confused about this as well.  The comment above about not bleeding host=
 state
into the PEBS records is my best guess (and it's probably not a very good g=
uess)
as to why the code does what it does.  The changelog from commit 854250329c=
02
("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations") jus=
t says:
   =20
    The guest PEBS will be disabled when some users try to perf KVM and
    its user-space through the same PEBS facility=20

That doesn't entirely make sense to me though, because I would think disabl=
ing
the host counters iva GLOBAL_CTRL would suffice.  I.e. there's no need to d=
isallow
PEBS in the guest just because the host is also using PEBS.  But I can't th=
ink of
any other reason to fully disable PEBS.

FWIW, I was going off the previous code which effectively did:

	if (cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask) {
		/* Disable guest PEBS if host PEBS is enabled. */
		arr[pebs_enable].guest =3D 0;
	}

One idea would be to add a FIXME, and then address the FIXME in a follow-up=
 patch
(in the same series)?  And then see what breaks? :-)
