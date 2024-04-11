Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F1481AA
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878280; cv=none; b=By6hCBExi5ifQtgngIs99XtXJXGkxVEbsVW9LKwho0W+f8WEoEwca7bi41yFx4Stmi75QNHmndIsRiBKz4vwawguDDFXxRWgzIn9N0yNfAQs+RkGPRQTZA3CaR1vhexDrueDwkBSGmSJi40PQvPLgXKvrwl6/VOjaNFzAwzwa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878280; c=relaxed/simple;
	bh=4SuOykEybb7HcIIt3unOysdTVnJJ7Js5I2n5NiYPPNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uyWI3MwN633larc54tb3ImhRX0Ef/EgWTRpuh5mGpdqniONEpzGig5IuCROqOuoqKwKOy7L+N1D8bf3bz/Fmv+Uc7A1i1810B4ji0PKir8yxqJFSO48phBm7qDrTjfBezEQxTq/r2sI0jUU2Wc7F+2zW2WTBpmjOv3St+s5vkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCdv+mXo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCdv+mXo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a2bc796cf4so305577a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712878279; x=1713483079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfAluTUg9e6YSqecG2tHKocCu1vhJlnxyS6nHwDSGiw=;
        b=XCdv+mXoF+oAD/CndueJFUU/0KaBRTzosFD2IIIg+FduonvtCgZSohu3O60oglcnIG
         aU/5XOzUlPwqlxsAtGVZMNHlghA4Q0n9x+GNUxnh3WulAaeSdcdHArrCaIvffW2VyLAq
         lg75Vu2dWSstrwtVNo41lV9VnHURHI3d77Yyr4gii143HRbfr7e4J34SC11c0O8c4q9O
         3Nf4jTvzlOxEnFeHTd/k6ktnZryg/k0C3TWF/MLE3bqdtmJOH8Mn/581xYp4XSaX66bw
         5kThN0SsFy/qjGwZmOg0p2JFZQdETEA3Gduw4vy1jkriDdcAqds6xYhVhxpyDXqWD7xN
         BgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878279; x=1713483079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfAluTUg9e6YSqecG2tHKocCu1vhJlnxyS6nHwDSGiw=;
        b=mI6hZDn8dz4QzoQtH4XMBzPZBjVJkNiptfWDdaaNeCtgdK9hoiqX836B6qrdDgj+4C
         4ycmFoIm3Pkavd44OAdyE0bEsMi3Ngv7aO2Xise0jbjR48GX8l13CSqtd2FDQlJPSf11
         D3kgJ85Rs4gys0y5RgbDXgQ56+Dd/y4wabievVpj+2S7VPUDFQSo5qBUdQ/yowjiNHCh
         b6FkcO36AsS2/cKgsvgha12s9svlgf2C73p/zhI1h5BrGOdqHb8u93Nb3BHMZn4dcu7h
         L61hCUAngLq6s602VwXYR95WRnMb4YoPotwnN14kGMUMNFqun4TFXa4Rwau2htr+O5CF
         bo0w==
X-Forwarded-Encrypted: i=1; AJvYcCVgh+5MEjngp30uoQmGMaMqwt5HtUrYTWxyNx4qlAfVUbk/R8UJHLmdoDjY5at+fvPq66nezHCZeVTvLLGhhp1VrLPFgltHz4cWvGwC20XPNA==
X-Gm-Message-State: AOJu0YyOePpnLUId7wl9qmdLlDDGTztAROjvhk/zkod1KmWpmdbcspKV
	4XV61uM8ZrZqmWBXPAqYDrA/2+0fm0586PPQ5biNdg1+IiCyQyoWH4qRhI4R2Lj67nxhiRBXvMk
	vrg==
X-Google-Smtp-Source: AGHT+IGACbup5qhwqtDsAZiOCGvghLAulCS/fhvTb+pjJJrKJViinsDcOsCtXCLMfcO+uGTvn4qi6C0+hKI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9cd:b0:2a6:ce35:d357 with SMTP id
 71-20020a17090a09cd00b002a6ce35d357mr2765pjo.0.1712878278596; Thu, 11 Apr
 2024 16:31:18 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:31:17 -0700
In-Reply-To: <CALMp9eS4H-WZXRCrp+6aAgwAp+qP2BgJx5ik5kA7vdyQ9qzARg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-24-xiong.y.zhang@linux.intel.com> <ZhhZush_VOEnimuw@google.com>
 <CALMp9eS4H-WZXRCrp+6aAgwAp+qP2BgJx5ik5kA7vdyQ9qzARg@mail.gmail.com>
Message-ID: <ZhhyxT66RdpiCRA2@google.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024, Jim Mattson wrote:
> On Thu, Apr 11, 2024 at 2:44=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > +     /* Clear host global_ctrl and global_status MSR if non-zero. */
> > > +     wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> >
> > Why?  PERF_GLOBAL_CTRL will be auto-loaded at VM-Enter, why do it now?
> >
> > > +     rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
> > > +     if (global_status)
> > > +             wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status);
> >
> > This seems especially silly, isn't the full MSR being written below?  O=
r am I
> > misunderstanding how these things work?
>=20
> LOL! You expect CPU design to follow basic logic?!?
>=20
> Writing a 1 to a bit in IA32_PERF_GLOBAL_STATUS_SET sets the
> corresponding bit in IA32_PERF_GLOBAL_STATUS to 1.
>=20
> Writing a 0 to a bit in to IA32_PERF_GLOBAL_STATUS_SET is a nop.
>=20
> To clear a bit in IA32_PERF_GLOBAL_STATUS, you need to write a 1 to
> the corresponding bit in IA32_PERF_GLOBAL_STATUS_RESET (aka
> IA32_PERF_GLOBAL_OVF_CTRL).

If only C had a way to annotate what the code is doing. :-)

> > > +     wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status);

IIUC, that means this should be:

	if (pmu->global_status)
		wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status);

or even better:

	toggle =3D pmu->global_status ^ global_status;
	if (global_status & toggle)
		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
	if (pmu->global_status & toggle)
		wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
