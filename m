Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF010E5
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213649; cv=none; b=NhWuz35KEI6cLGE8S87ehhJzjoxtI+PmxX6+4Es8MnwKdrpCXw0ZO/q9a7XRlp3WqDt8/xOZYCgSR8D/SzwG/XA9IQhtuZm4BEKtkA8s6aEYt9keYkWGDmr4Kk3/i/7n6LdHICaice+qzMYzD4JjsnjYu/CkJkSB0MEQKIgt44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213649; c=relaxed/simple;
	bh=/KkMnRwuz+l55lhU9dM+hdqIe9xqwcIh9uTzOkJpltY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sND11jfc3HtK6dpkQ5mOcyk8khdzucHARFUsEwsQpYMdxwjUZGjCTfqpQMgurUursBshAbjLRMSZRTpkxpDZ5qyyzpKspRH3H6bY3P/mSg+pZGpdYnnFsxtae6i10mbpTQltWRH92Y1gRG+qhsNILkstXoTiXuv2wWjNtoVb0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUzA9T5L; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUzA9T5L"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so407106e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 17:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715213645; x=1715818445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD6lUi8SG73xbLOFxo5AJaBVzp1RIH6Hedt4OaGzUw0=;
        b=aUzA9T5LA+uaSWxhsIP3gqpswL09jQw4M4fr3OprTEWtVtIXFecU4I5iTYOA6hlZfm
         UaelFKNlsw9+r2sNWy4HQdlg/bbGtx83ngdGUQhWlpqTTopPL3KGel8o7bNpv6+6og+T
         bcIovOf0CWi/PKumU7DY35je97SAmJlUX6o/ozOu8MPAUjsOe8+PQ7M/j/qybtIQ4hav
         OCoRDslOE1fQ6zWvs7NZCfCHgWrH3aoKx/6iOu37CHlyWqPe+gUrw2NgrrFM8gzeP/Aa
         t/1mKDKbH/8mOGO1AzVdz5TbxF4kq2WrdOj+BPCaBfuxHMTYBpWOqJNzdtkFsAL27G7+
         J6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715213645; x=1715818445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD6lUi8SG73xbLOFxo5AJaBVzp1RIH6Hedt4OaGzUw0=;
        b=oOuH9Lq4xtb6ZXE2Mz22Pyt3e9Z+oKM2PFaBSXipzdzCh8arNxWeXsAOQOzm9PxNLs
         H4JX/6UzyZ3JstAXjW66VP8GjdjGFxqvMLrvIHZJLxgNAFSjrvOQh5ZM9h/E6Cx8K09a
         xDGiHezYPm7NkuI3priSpmTsJqThrJ/hqFFIzWG1fUG8Yz6LlbOZWQGor5+y5wMqp0IS
         nqjPpk2smGpAhv2j1+iv+gd4gpiTfXlfJUid3bmoZSYkYm29M44A+sK45lD+Oem/Xy6B
         8RxDM70mYFwSbDxa+pIwO8h/qeijEotgVANvcKeZc2HduljF26+Fnx5qi2o74agSjbsv
         kFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzqYoY4QpLMTHNzTHbAgRv9/L0K/SsmA4j3hkpW8Z1ky0o7FuYWbmAaavMCS3i8HWvosG+oCyQ3/mvt0ogc1vIAKP758U5yG6KgfTNxgY6Q==
X-Gm-Message-State: AOJu0YzMGdUp4GU0I+cjsvS4APEq85Lyi/YGGA/tnnVmoOpLc+hWtUAX
	nTo8qlAL2WtLqdFXqjrLlazcYK4gku5QjOw3tWOF9t/2Sesw6wdC5IkInRLPTf8ZJJiusxKT58G
	vyLyWnHlqa/kxKntSWdFY1byuTukT8kWXlYd7
X-Google-Smtp-Source: AGHT+IHxLy+/Yz3kCV2cQdiakGf5bXR4LBAPmGIUJilyj3ZlVYQPDqd4Ls6z46ei2t3Mp+gZ+KSnAY7jB9iVDLNK56Q=
X-Received: by 2002:ac2:52bc:0:b0:51a:f11c:81db with SMTP id
 2adb3069b0e04-5217c76046fmr3722169e87.30.1715213645409; Wed, 08 May 2024
 17:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com> <20240506053020.3911940-18-mizhang@google.com>
 <3eb01add-3776-46a8-87f7-54144692d7d7@linux.intel.com> <CAL715WL80ZOtAo2mT95_zW9Xhv-qOqnPjLGPMp1bJKZ1dOxhTg@mail.gmail.com>
 <fbb8306c-775b-4f00-a2a6-a0b17c8f038e@linux.intel.com> <ZjuIiDwbrWL7OD86@google.com>
In-Reply-To: <ZjuIiDwbrWL7OD86@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 8 May 2024 17:13:28 -0700
Message-ID: <CAL715W+qV6D1WfTOMLv2ZgKZnJM-hDnBL-iiVr2m1_SK1rVpjA@mail.gmail.com>
Subject: Re: [PATCH v2 17/54] KVM: x86/pmu: Always set global enable bits in
 passthrough mode
To: Sean Christopherson <seanjc@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:13=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, May 08, 2024, Dapeng Mi wrote:
> >
> > On 5/8/2024 12:36 PM, Mingwei Zhang wrote:
> > > if (pmu->passthrough && pmu->nr_arch_gp_counters)
> > >
> > > Since mediated passthrough PMU requires PerfMon v4 in Intel (PerfMon
> > > v2 in AMD), once it is enabled (pmu->passthrough =3D true), then glob=
al
> > > ctrl _must_ exist phyiscally. Regardless of whether we expose it to
> > > the guest VM, at reset time, we need to ensure enabling bits for GP
> > > counters are set (behind the screen). This is critical for AMD, since
> > > most of the guests are usually in (AMD) PerfMon v1 in which global
> > > ctrl MSR is inaccessible, but does exist and is operating in HW.
> > >
> > > Yes, if we eliminate that requirement (pmu->passthrough -> Perfmon v4
> > > Intel / Perfmon v2 AMD), then this code will have to change. However,
> > Yeah, that's what I'm worrying about. We ever discussed to support medi=
ated
> > vPMU on HW below perfmon v4. When someone implements this, he may not
> > notice this place needs to be changed as well, this introduces a potent=
ial
> > bug and we should avoid this.

I think you might have worried too much about future problems, but
yes, things are under the radar. For Intel, this version constraint
might be ok as Perfmon v4 is skylake, which is already pretty early.

For AMD, things are slightly different, PerfMon v2 in AMD requires
Genoa, which is pretty new. So, this problem probably could be
something for AMD if they want to extend the new vPMU design to Milan,
but we will see how people think. So one potential (easy) extension
for AMD is host PerfMon v1 + guest PerfMon v1 support for mediated
passthrough vPMU.

>
> Just add a WARN on the PMU version.  I haven't thought much about whether=
 or not
> KVM should support mediated PMU for earlier hardware, but having a sanity=
 check
> on the assumptions of this code is reasonable even if we don't _plan_ on =
supporting
> earlier hardware.

Sure. That sounds pretty reasonable.

Thanks.
-Mingwei
