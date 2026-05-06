Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD34657E7
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076180; cv=none; b=ncY7T/jdQyeyunZUPKnncOfV7Kn/23sU0qnquZcmkEqMrY6WBNtI9uyLm+SpvPxkGesLEc7PUyk4J2j7ZCAXzp6T/Sw0w2vi8D83TvdV2YQ4RvslXo6+6BwLOsop5Nsv6j6Div5tYsvs8tUo1Af7upD7o8N8gywVUGWTOaR3s9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076180; c=relaxed/simple;
	bh=hcD0toSVOOteQihfnyNTjZWFv8+nFbgAq2DRSdobVB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nZzYtXK6zWoTxJxm9dabwROjaR+D9osNwleKenPTISCTA7ZC4SwCUJvoLE23eW8qakDbCmNNV0hX63VRxwjZxb/wJHuLtT2OxZYHMv8ypH8rrCDvj6sd5hpDIQgMRCgbl7N/7E2bCyA8mgANzNAM+is1TNkOoX+/DT/QH2lAbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ew2VpmFP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ew2VpmFP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso62157405ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778076179; x=1778680979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4inufemHLYVw7e0Jw1npJcdd1uysY1TXg59beodcgGQ=;
        b=ew2VpmFPwYUxcWwdPoARfvhlzAn5cIe5vtO9/39ay38WU3hL5wNvrCMR6U2gvT12DI
         8PgowFtXER1fpqjDKdM2CMiHAIRZCRT9dUeftX+epmwPMcNdN5KdnVIThgEdQF2NUx1H
         5wsOIcCBzOdD38qIvSNGCErduUFZsz72A5VtuXK+gMhN6s6JnwLyO8eJaHTkG6lMTvCc
         /mKC2XdY0qnSrlxHOGvhqqV75EjgMs5abHsv8LUqBGTnzffrdklBRr1aMB34sfEPazMx
         PfYOdzSzT2wOCy4zHTozB0dP7ALdK1iq26ACkBLSox3kl7r2tHQ8XpACgzr0x/UES7V/
         JMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076179; x=1778680979;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4inufemHLYVw7e0Jw1npJcdd1uysY1TXg59beodcgGQ=;
        b=hE6cc/qxzc02Ri7YHrkW0YviPlFSowqMd28KMjA+JLtORDmwQmziF32eaB+jBfhf7O
         dxPV+rUFuZ4U0Pnj3+Wv1/6mnq3Hf+JP0eCrbR4/FIxy2MLEkKT4TvfQPdvNPbf13smt
         jYK3JjE8a7kWg4aCjYEp8BYB2R0Om1PwQG9/JeXOFolsFrwxgMj1r5QzCTJRSYlnPHKs
         zw81vWBa0fGB3MBAgiuRKR5zLi4W2L4aaUFLRpGGkcgpb1DT/woDpQ8zvrZ2uede4gMQ
         0p/Q3xNk0byofFZe+KyAwI+Re91v/wicJnEFGXIgKd+vKqWU/RamWbYgBp7fqcrTnE8x
         l+4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8YW6ImRUkr30jrky6yud9HwkyHx1IziKoeOEwzWnVuH68gUROZDYASCfcchgup3mz1sebQFmZYa79KRffWbWMQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyskFGVfNI3wzPTmhacJuVnzjuR66tfmarCoCrBmxoweyrMntzC
	d6D4EyxtyE/pXjFs/12HmvoLupwAsoP4dmXdLOvt9ERYVbj4Zdxs+84l8RQFRuk5D040tSusXSL
	oxxhmsQ==
X-Received: from plqt9.prod.google.com ([2002:a17:902:a5c9:b0:2b9:a1d0:9f13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ad0:b0:2b2:5597:bad4
 with SMTP id d9443c01a7336-2ba7a20545bmr34631745ad.30.1778076178340; Wed, 06
 May 2026 07:02:58 -0700 (PDT)
Date: Wed, 6 May 2026 07:02:57 -0700
In-Reply-To: <CALMp9eRBcyLZJrcK+RqpSn3efPP62kuD00pDzQv7kRDBjkbqJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
 <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com>
 <afjU2ZbwRq7Jig0w@google.com> <CALMp9eRBcyLZJrcK+RqpSn3efPP62kuD00pDzQv7kRDBjkbqJQ@mail.gmail.com>
Message-ID: <aftKEcYiZlbnnLg0@google.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026, Jim Mattson wrote:
> On Mon, May 4, 2026 at 10:19=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, May 01, 2026, Jim Mattson wrote:
> > > > @@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_gu=
est_get_msrs(int *nr, void *data)
> > > >          * wrong counter(s).  Similarly, disallow PEBS in the guest=
 if the host
> > > >          * is using PEBS, to avoid bleeding host state into PEBS re=
cords.
> > > >          */
> > > > -       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_=
cross_mapped_mask;
> > > > +       guest_pebs_mask &=3D guest_pebs->enable & ~guest_pebs->cros=
s_mapped_mask;
> > >
> > > It would be helpful to save this mask somewhere, so that it can be
> > > used when calculating guest_pebs_idxs in x86_pmu_handle_guest_pebs().
> > > I think that code needs a fix similar to the one in commit
> > > 58f6217e5d01 ("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
> > > with vCPU's value.").
> >
> > Blech.  This all feels like a losing game of whack-a-mole.  Proxying th=
e PMU
> > through perf is a mediocre approximation for non-PEBS events, and it se=
ems like
> > it's downright awful for PEBS.  Ideally, we'd just rip out all of the p=
erf-based
> > PEBS virtualization support, and only support PEBS through the mediated=
 PMU.  :-/
> >
> > Absent drastic measures though, saving the effective guest_pebs_enable =
in the
> > per-CPU tracking does seem like the least awful approach.  Though I don=
't quite
> > understand why we can't use GLOBAL_STATUS for x86_pmu_handle_guest_pebs=
().  I.e.
> > what happens if x86_pmu_handle_guest_pebs() only processes counters tha=
t actually
> > got marked as overflowing?
>=20
> x86_pmu_handle_guest_pebs() is called in the path where we are
> handling GLOBAL_STATUS bit 62 (GLOBAL_STATUS_BUFFER_OVF_BIT).
> Individual PEBS PMCs are not configured to raise PMI on overflow.

Right, but aren't the per-counter OVF bits still set in GLOBAL_STATUS?  Ah,=
 no,
at least that's not supposed to happen, per commit 8077eca079a2 ("perf/x86/=
pebs:
Add workaround for broken OVFL status on HSW+").  Well that's lame.
