Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E23822A7
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258017; cv=pass; b=QCbi+o6d574oqu89+n+gcMY+tWs/p5XYRCVfKGrN3XDLrKBKpo3Xv6MZWQK+pIO17zFs13y5lDjUJz6603O7eMqUEyigZ1dNrfXM5RiXhUv6nssb8PgKpzEz6RwEI4QMpc87qwpvgr7DaCwe7/+vM7dwlgXVTu7EcMMJWgUI7Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258017; c=relaxed/simple;
	bh=LW+9VRqZobJwP0PeOeVYPcYO6+HdVBVvV4EobpgdWFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR6q2vGZrb6U3ep78Js1BuufRApFcssA6PGUh7w+KqbiaklEPagOAkwWSzQqKWwDsbwotFjkQWRP9c/lyGysMS/J6aM8uUHfB8G9Uq0uSCT3zP7GB9Vnny0h2V11Y8Y0WGBciGzAe2+uUGpwIghDuOnc2qZ3J3anNP8mFi2Qj9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnU3xGDB; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnU3xGDB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so18031a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 06:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776258014; cv=none;
        d=google.com; s=arc-20240605;
        b=j6ARfJf0aJdFTuAFhgEuQihcQTeuhJlMD142DaOjb3CoV287xL8kJLBozS2kyFEUfx
         AJWMkaxCuyQYR3LDVInvt1vbG9gK4wk7tKJ/mQKWuujw6g5sxfJCOLPJg/YpdWulL7xX
         9BDbsjcGWOGqcg51wX2V8KCZ5c/7M/+t2x6ohPZ+vlJQ1g7a/DFJTLYV7ai8XdFXKTlz
         qAaDnBhEQ6qghIG6ajCsdqq83V2YrJ66UOb07ZD0sJeSkGqqUUAHibk0fjbvL+WMtf8Y
         /8FFp8THfwAm2hcPHSFMn0dClWjUCoqIdUS7FLAaw2Q3NZ5Dd4OrUwCgirNE457NUudv
         G4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JCNaaeYnrpr4S5ml/FPDiY0iZEzrTwHWX5KjR7Kb5uo=;
        fh=mPFASBSGOrZvBNsRu873yI2XZgBRzlh6Gbfkegf/9p4=;
        b=hL0KsjZMzrbJO90VjO394Lc+LuUY5mULoHPxs3ZrxBp2R5KzkbpufW1EyjvWE60+Di
         K+M6W6sAZ2yqvinzpexK4GSsnVav0NKkVuj2PeCIBuwu4zu8BQxAGa6ELrW0wwkRz5pV
         1o95rN1Ns6nKbg7tB3d9o7YZ1OmtPhaf+97cA2B6aaXevBg2al9MNl9bknKWikZd7PF5
         UMYTUD0G+aHbVDlxap3u+aEDpqIGmLksljE3w1IBtMTVzPGcD2jr2jclMgKAenZsZGIv
         uEOOm1Aw/Rx1VE7IKuvzcR4VlEurSbPJ+ZrrTyIjytKzqIjK8ra17QKNt7dFS8qv7Aza
         Og0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776258014; x=1776862814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCNaaeYnrpr4S5ml/FPDiY0iZEzrTwHWX5KjR7Kb5uo=;
        b=ZnU3xGDBb4awF4H9RFL/K8PP8PNvFNsS4KYC2UYZHqTHELlbmnmVauNcX4Q1v03POL
         OIMVDuRmH2lWV6cTyp+pjgHMtJnUPDmcX2SLSAayGdwJGoI2bgfJR8l2wRrKpn7HzTgp
         isduyzsywd7xfuYjfdMA8XVenO5BkrmLDnrl6w4i+vhd5Z9cRLuqcKwIFsbPDXzU6QkX
         kVg2dRI9nKy+9l63DZksDZfKOrilJEkTJHD/iaV+c6jmK/FrUtaP4a7H+vFTgo6kh3wQ
         wdp3qHLRehzjZ8D4C2iLAL1f5OOYkUAon+DAyyOBBrHCpSQNHbgMWM/kD+bwMrAiKbUe
         aQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258014; x=1776862814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JCNaaeYnrpr4S5ml/FPDiY0iZEzrTwHWX5KjR7Kb5uo=;
        b=WqJwuxFuIfTRsenXVl++cSms5QOmzprvZgkQBEbiTj4eHCVeWZSfq/lEIu7MwE7lp2
         9wDj61QeL7SVIV1h1ZHICum4qcKPlId2xN2qH5+NbH+pjG5oeBAVcPAIG5RclcM2ojvL
         O+XVbS/urtXfIWvgdnERMYuuySBiumb7g/bpQe5t8mNW/UAjxuNOLPRDArr5hj5/Pai6
         SJFDOvOTvaR07yfpBQj633sH35JUEa3HhgeRYiv4Pof9AJ+pXHhaT7nC9merSCm2VS++
         /x/PhsBS7NxTHq+1jVMHVBCgREtp2PCS+5vkFTMrBCc6NNYVEFW9wn7F245MTq+Hhgyh
         W9DA==
X-Forwarded-Encrypted: i=1; AFNElJ9oow/NuqILQIDDoxhfjqW+gD9MuomT4MeNEl6JLz9nMQTcEFBHRdJ/swQoJ4Idn0dxmMNasKyHJ8bxeVOKKqYW@vger.kernel.org
X-Gm-Message-State: AOJu0YzERSTHlT7uJgIg60XcyRJfDD2L+4oYn92BCAGAxNygpyaoiILv
	iDtfFu7w9XeLtlfIkssybPLayMBjrNknittaXGhfNU36W9Nf3VzWJyIK+C3Oxd2HrTlxUKwoZ23
	eTFSxLPbE3IUWgsAT8170F/MeUpLCgxOZTENZiQ/2
X-Gm-Gg: AeBDievVw2Dz9oQ3eeVWzXAW3g4KAbIsoL+teZWv4lIFkLcBjdXbT7GHEj7QGBT5053
	TCxlonMk5+w35W4eS74eVtcAM81IKtGcP/uWwr79fVcmaCkZ80ENUAmPejsNrx0mos00RNp3gss
	eSf61g7A4qf2p5zxXrwkXXmRT1oQAdYyLtDzw91aRjGW592nSQqq7q1YKqhbumdGm16wSeacZu9
	4RR0tOP5ug4UgF9QaMsyGT5RBVmXGjXDq/rZBkEEWF0MonM4kt6D+TLeeaaDD+Q+/O+4NxQXJM+
	C3o302BLaDlGM2PuUPNw+dMBfRpaolu8A/TCy60=
X-Received: by 2002:aa7:d79a:0:b0:66f:d653:92c0 with SMTP id
 4fb4d7f45d1cf-67230d8b373mr28560a12.1.1776258013088; Wed, 15 Apr 2026
 06:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-3-seanjc@google.com>
 <CALMp9eRxd=-xotnr9rLYhHtVK6G5oGAbXByXgpt078G8mWQEqg@mail.gmail.com> <ad7Ei3FsFSm8C8he@google.com>
In-Reply-To: <ad7Ei3FsFSm8C8he@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 15 Apr 2026 06:00:00 -0700
X-Gm-Features: AQROBzA_EzQ3euCNq8tdeVNjJ7rCBtxF_H_9qgmPaOzI01_Fog9ihiTjReTuZnc
Message-ID: <CALMp9eQW-3cd29yduDmFzo+HyKZB951jSxf0bV85zLT+x9iF+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 3:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 14, 2026, Jim Mattson wrote:
> > On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > @@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_gue=
st_get_msrs(int *nr, void *data)
> > >         if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> > >                 guest_pebs_mask =3D 0;
> > >
> > > +       /*
> > > +        * Context switch DS_AREA and PEBS_DATA_CFG if and only if PE=
BS will be
> > > +        * active in the guest; if no records will be generated while=
 the guest
> > > +        * is running, then running with host values is safe (see abo=
ve).
> > > +        */
> > > +       if (!guest_pebs_mask)
> > > +               return arr;
> >
> > I think this has an unintended side effect. If DS_AREA and
> > PEBS_DATA_CFG were previously listed (because pebs_guest_mask was
> > previously non-zero), KVM will leave the stale entries in the MSR-load
> > lists.
> >
> > KVM only clears MSR-load list entries for enumerated MSRs with
> > matching guest and host values.
>
> Argh, right.  This as a delta change I guess?  I'd love to overhaul the i=
nterface,
> but reworking KVM to play nice with core_guest_get_msrs() would be much m=
ore
> difficult.
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 20a153aa33cb..3244d5589981 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5059,22 +5059,20 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
>         /*
>          * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS w=
ill be
>          * active in the guest; if no records will be generated while the=
 guest
> -        * is running, then running with host values is safe (see above).
> +        * is running, then simply keep the host values resident in hardw=
are.
>          */
> -       if (!guest_pebs_mask)
> -               return arr;
> -
>         arr[(*nr)++] =3D (struct perf_guest_switch_msr){
>                 .msr =3D MSR_IA32_DS_AREA,
>                 .host =3D (unsigned long)cpuc->ds,
> -               .guest =3D kvm_pmu->ds_area,
> +               .guest =3D guest_pebs_mask ? kvm_pmu->ds_area : (unsigned=
 long)cpuc->ds,
>         };
>
>         if (x86_pmu.intel_cap.pebs_baseline) {
>                 arr[(*nr)++] =3D (struct perf_guest_switch_msr){
>                         .msr =3D MSR_PEBS_DATA_CFG,
>                         .host =3D cpuc->active_pebs_data_cfg,
> -                       .guest =3D kvm_pmu->pebs_data_cfg,
> +                       .guest =3D guest_pebs_mask ? kvm_pmu->data_cfg :
> +                                                  cpuc->active_pebs_data=
_cfg,
>                 };
>         }
>
That looks reasonable, if a bit obtuse.

Reviewed-by: Jim Mattson <jmattson@google.com>
