Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743503ACF0B
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206990; cv=none; b=YjiX39ANaMszU1rhGu3e1feCGQDd+fNkaKkYfSkaH1zHIk/xRmPj3kRB/cY7DP+5K1b+LcV4lE/rb6tIaIorAsvLAlTVJ7s5jLAI6PdHDBoBdxtep2TG01852z2A/jNVlk9OuceE6fj1Tc6nwSXNf29hcMU4bwAGbVtY8Tsn1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206990; c=relaxed/simple;
	bh=2w8FCsUeUvgD6onjKxIhyqqgoHp1gSabAVxysWnlmzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcg2GJxy4PXiTGP6k5vwk8fZLqoCMD4692QOhBtCerUHU5/DVqnt99KXL9P6GYPYiivWgYxtkyqPqwkS7gjhtaZXJnWGYHu9vAbclyOnAaAs1Zu+MJUbDP9Q/OfzEGxnelwmma3XouSWWqUTwK76VPcI4xIHm8n3YG0pXzyYKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTjeqcz5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTjeqcz5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f65a151deso247074b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776206989; x=1776811789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRasnSp3LeKygs+54FOeXokg/h9FwjkuSVLECbKoWoE=;
        b=rTjeqcz5+N7mwf7X1G8vnZe0S5fWNDYdSJcw2MjKf0Q9bm0UdBP6Dn4AiiixtR6FFl
         yyeF0JmKTKHUHEAv2tyVrHwxm9C/5c4SDbtP7Tw1TXAy/AEaBXh2768Rh5AwYKeXatyO
         CSQBeeOoKv1bWQYl/j1oPkxQxWUh/kg9g9LTeUGym+hL7+nkG6plQ8WJp0XJnRU7ABHK
         UeOtb7VSCHtfqt2C98ofAM34O3rjsQiHpSgiWnM/+JJUOusMsHJPoI6l61BOcuYWDLej
         uj/QqCd0L3KiiyIHIRlNEfEwXAGvUUYDi0QnBM0/gzUbZhV5tIthyK4VerSWlhD5tdjm
         SE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206989; x=1776811789;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XRasnSp3LeKygs+54FOeXokg/h9FwjkuSVLECbKoWoE=;
        b=NAfd/yFMW9eMsJzp+v8vUsLnP3e3lzVEegBqovK9eNwxtjRTuQbTpa8Xomxefl4NDP
         PDtLMOisM7Pd/U4VFMBplHTDZJB488I7LCvEAMZi68EdRBw7GoOyg0m7TjFfP9bU4s/h
         VrS31d6mMxO+5Z1E4YmqVelBHxqR571TwWwXXkMjvMZegFM0DeyDodb3LHtFwaA7XCdg
         Ja1VGT2OYD2cLLLFRiQpMUDwLvLvC5NsnEREFZG6ltXVOq3xYOPLWQexmNDVX2eWwHB7
         St/ISdJUC/gFJIScu0Xi/dBa+DnhfZ6KGInHwIhENQM9VJymvLdZMQgOKPj2UTds+7/z
         ojzA==
X-Forwarded-Encrypted: i=1; AFNElJ879nG4fvjgCGaEFAk0l8DAiV0KDfGeJlW8v+sPYJL2ODRJzHrrRnunS6Kyyf6Foc4QsIN45e2KHlIwMEXsZx8q@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpJONz5VWzAWAmAcX/LgKx4ezp8vXM3WwubWAv7lsYLuoOEnN
	lV48mB38IXHKCS2GVuSictQIMMrA3tyly6cvHm56u8GXnYe14AWTUcR53FGAcSGaayu1FFIxTdJ
	lw+dF9g==
X-Received: from pfbde16.prod.google.com ([2002:a05:6a00:4690:b0:82f:5aef:db75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9083:b0:82c:b808:4c59
 with SMTP id d2e1a72fcca58-82f0c2e6c46mr19583002b3a.46.1776206988555; Tue, 14
 Apr 2026 15:49:48 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:49:47 -0700
In-Reply-To: <CALMp9eRxd=-xotnr9rLYhHtVK6G5oGAbXByXgpt078G8mWQEqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-3-seanjc@google.com>
 <CALMp9eRxd=-xotnr9rLYhHtVK6G5oGAbXByXgpt078G8mWQEqg@mail.gmail.com>
Message-ID: <ad7Ei3FsFSm8C8he@google.com>
Subject: Re: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
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

On Tue, Apr 14, 2026, Jim Mattson wrote:
> On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > @@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_guest=
_get_msrs(int *nr, void *data)
> >         if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> >                 guest_pebs_mask =3D 0;
> >
> > +       /*
> > +        * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS=
 will be
> > +        * active in the guest; if no records will be generated while t=
he guest
> > +        * is running, then running with host values is safe (see above=
).
> > +        */
> > +       if (!guest_pebs_mask)
> > +               return arr;
>=20
> I think this has an unintended side effect. If DS_AREA and
> PEBS_DATA_CFG were previously listed (because pebs_guest_mask was
> previously non-zero), KVM will leave the stale entries in the MSR-load
> lists.
>=20
> KVM only clears MSR-load list entries for enumerated MSRs with
> matching guest and host values.

Argh, right.  This as a delta change I guess?  I'd love to overhaul the int=
erface,
but reworking KVM to play nice with core_guest_get_msrs() would be much mor=
e
difficult.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 20a153aa33cb..3244d5589981 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5059,22 +5059,20 @@ static struct perf_guest_switch_msr *intel_guest_ge=
t_msrs(int *nr, void *data)
        /*
         * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS wil=
l be
         * active in the guest; if no records will be generated while the g=
uest
-        * is running, then running with host values is safe (see above).
+        * is running, then simply keep the host values resident in hardwar=
e.
         */
-       if (!guest_pebs_mask)
-               return arr;
-
        arr[(*nr)++] =3D (struct perf_guest_switch_msr){
                .msr =3D MSR_IA32_DS_AREA,
                .host =3D (unsigned long)cpuc->ds,
-               .guest =3D kvm_pmu->ds_area,
+               .guest =3D guest_pebs_mask ? kvm_pmu->ds_area : (unsigned l=
ong)cpuc->ds,
        };
=20
        if (x86_pmu.intel_cap.pebs_baseline) {
                arr[(*nr)++] =3D (struct perf_guest_switch_msr){
                        .msr =3D MSR_PEBS_DATA_CFG,
                        .host =3D cpuc->active_pebs_data_cfg,
-                       .guest =3D kvm_pmu->pebs_data_cfg,
+                       .guest =3D guest_pebs_mask ? kvm_pmu->data_cfg :
+                                                  cpuc->active_pebs_data_c=
fg,
                };
        }
=20

