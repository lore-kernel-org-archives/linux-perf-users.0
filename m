Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7E13AD20
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122392; cv=none; b=ZvwUjlVDtcZlfOvFrFkgAV/0BEsOfUO+T7A8mciufQ5u1WQMMdl7PhjtP32G4hnhwWmIqtG4i0OQf+Yn6aasYYIoRY1pIKNTOepcksf7brzdYEej/6Bs2/C9vKdpMfDJS1boXCd6n3NSFNXSIXwInmEOhOv5iFuOP6hmwH01Q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122392; c=relaxed/simple;
	bh=MN358yeAgMetR0+Jtkzwlffo/NhqEIxEzYW1pEwgFXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SN7Kkhwgwv9lzh9FyrFgMcbAKm7dVexBgGet0pdeD3+lPmWgLMHscZmRT3G1WrmCfZsB2TpFoR3/+k8AZ1e6Hgi8f5bUNza3zDdJwfhmcAsp0Q4Dd6xH1zE9isULXs1eFcAUeghP22+2ZoUOcdDJKZ97OQoP4IxCQXe99c6Seq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHkhp6ki; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHkhp6ki"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee7856bcf2so75145237b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732122390; x=1732727190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72KAuCGZk9dkQwE4EPXEULor/zpraUF3cNKJPF7sOZE=;
        b=XHkhp6kiTM155V/eJavlTDnHL7LzZHJQ4HcuKqgz4HLmtTaqsLb1cfUvpNpJOctLbv
         2GZYP/FxGuDB8aTu8yLnJTGA6MieJtlEmw/uCQLXUPhR2m/VhqmTZQI4SqUqyp9JzLGo
         FkCbMGIa84QPFAU/Kg/F3s8kOGi4/wZ6QjXR0u8LdrfZ5pz2b/n+rrK6+EQM80AS6Hw3
         sdmU02XQH8BomH+yxW8NzuZsNWUF+B8hMZyOe10EsbetXnRej2RTz4lJkZJi3aYWs5a3
         ncHPNTdGr8Ab2sOHXwA9J8YaoQZhCJ8ap8YC3LlRICPaM4fB4TaQPH2D4geOHCp6Fkcr
         8Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122390; x=1732727190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=72KAuCGZk9dkQwE4EPXEULor/zpraUF3cNKJPF7sOZE=;
        b=c2bS8WkPltZ95feFl74kEWpvp3yTnx8SCqBTSsCi+ntb8yaOd3ZKKFzsQBoLSC+ZvR
         VIBBLQLREFkl3F5XMUD/VzZbhp+ur8qv/UiCoNT0A/4K32UVW1vmFS0Qv3SyXpWZRCkI
         6Iysbmnh/YZ8+hKjIwVZGmTNGf5rsMZU+HUGNfRqk+0Uv/shq0cjKPcOo2Knws9gYRiW
         5+eoZiJjW4KOizxFVkZJUm7xnVm8kEOZPQWWVcPHY6pWzcf8XfLmwm26PASoejzd+fh5
         A6qNQIYwWR1NnVen3PDFFTBljcR/ZlGrkaTZrL6OE59eOgV7eyiRUm04kZB2PQa59QL/
         QNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEXOV4CWQSmkaywTsbkYbXgMn7jIMJJviXWx8WFaF62evEILuuoI3TwarrlQNhIbuN3rLaOq6m7RQ58M3e/uaa@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLk36PxRbSrTMDbjq4chsIwjM8IzmKzBcbVqwU5qBUNUwMwMW
	GfW/G6CAIjHaX/lD/s3uHSDTofhKm7Cs7awo461kCZBPTLlhKW7XyTBmvy3/wTnNbk1HZjHgFrJ
	/SA==
X-Google-Smtp-Source: AGHT+IG1NjrX/WWRkhsrbPKCnh25jzfDgr3jbC8xsaKOsQLUAnNOynoCLYFmHliQyM7+eVt6cZuuVgrsatA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:ec9:b0:6a9:3d52:79e9 with SMTP id
 00721157ae682-6eebd298ff5mr785067b3.4.1732122389949; Wed, 20 Nov 2024
 09:06:29 -0800 (PST)
Date: Wed, 20 Nov 2024 09:06:28 -0800
In-Reply-To: <50ba7bd1-6acf-4b50-9eb1-8beb2beee9ec@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-19-mizhang@google.com>
 <Zzyg_0ACKwHGLC7w@google.com> <50ba7bd1-6acf-4b50-9eb1-8beb2beee9ec@linux.intel.com>
Message-ID: <Zz4XFMYMbMvFh54a@google.com>
Subject: Re: [RFC PATCH v3 18/58] KVM: x86/pmu: Introduce enable_passthrough_pmu
 module parameter
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024, Dapeng Mi wrote:
> On 11/19/2024 10:30 PM, Sean Christopherson wrote:
> >> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >> index ad465881b043..2ad122995f11 100644
> >> --- a/arch/x86/kvm/vmx/vmx.c
> >> +++ b/arch/x86/kvm/vmx/vmx.c
> >> @@ -146,6 +146,8 @@ module_param_named(preemption_timer, enable_preemp=
tion_timer, bool, S_IRUGO);
> >>  extern bool __read_mostly allow_smaller_maxphyaddr;
> >>  module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
> >> =20
> >> +module_param(enable_passthrough_pmu, bool, 0444);
> > Hmm, we either need to put this param in kvm.ko, or move enable_pmu to =
vendor
> > modules (or duplicate it there if we need to for backwards compatibilit=
y?).
> >
> > There are advantages to putting params in vendor modules, when it's saf=
e to do so,
> > e.g. it allows toggling the param when (re)loading a vendor module, so =
I think I'm
> > supportive of having the param live in vendor code.  I just don't want =
to split
> > the two PMU knobs.
>=20
> Since enable_passthrough_pmu has already been in vendor modules,=C2=A0 we=
'd better
> duplicate enable_pmu module parameter in vendor modules as the 1st step.

Paolo,

Any thoughts on having enable_pmu in vendor modules, vs. putting enable_med=
iated_pmu
in kvm.ko?  I don't have a strong opinion, there are pros and cons to both.
