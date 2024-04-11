Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F83205E2F
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863930; cv=none; b=l3gVVmqAnIEoSzyOqobu7XPfHnHiDrMf2mJk9wYN7P9w1PYll+RGt39qXIMVOcF6YfJRNiWOCNQrWqTruBVq5ByurPWPBJu6ZN9uC3PJhg1lNYfUGUwKCEjC03HTI9bKxAsoE5LWlyPyDjg0RfVmwW2qgn4aMWGwyHu/hDossw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863930; c=relaxed/simple;
	bh=1yU/kPa98UhjQAO/mISuRqsc8cngmTEg4cn2oa0bI98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrNJu3mVbWICJGGPPrqw3TiFKb/JSpGRhEsFw4VaBX/xcj6o9W0HeV2qcc4Whjgtpw+ATuK10QE9APUXhHva1hafCSJKECXhuovGFV2FExOIlKo+gYLaH0AXeTChr7UWnCxOZ9jbflvuYm9dCMQK51Dt18je0KzALyt71/V1vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+2tMixD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+2tMixD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso128836a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863928; x=1713468728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxiGI4jPhKPJt33E2rX2XkxPrGB9QhLEWHybdPq8HoY=;
        b=r+2tMixD3+3dsl4h3/gV3do6LlJqSfuLtNqIndf3hh6YxgLOXLgfm+urpVbm45TArc
         ATmJVuRNWXi9rdIF42ESF7IfjYXX0JhOQsw1LEj6h/NwRuRs6SPPKjHVixNCIl4rBNSy
         V/Mb1KXHF5Fn98Thit1ykSqY4/M/qNUu4IVL3P2YNbjKMkstCZPp5t2EpQDn89s109PC
         bkmHAbxFzmICTXVjFDlV37AsU9a9OwXzSC8LsJGz8uZ747Xg6Zlw7wLupPmgz6tpK0gM
         deTgLlg6dKuh+MWOk8BilrwOvRKcXlD0Nu1UGTbbIegFYvsHmX1o2PSz33SyvyjT8e5V
         KSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863928; x=1713468728;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxiGI4jPhKPJt33E2rX2XkxPrGB9QhLEWHybdPq8HoY=;
        b=Y/2wABa+LL6MJLUOgqqShB5txeeXL29hru5Q1NWXLbSmDnH5KiOURTtUOGSew4YioV
         jUXVBOzR3nfADtKC2E46NH1eId/TZLJ2jXDSGh+kGQwWoEGtU+XeQ4nUhAShQfJn18g6
         94bM0d2jcqrhiTBShINZjNp28TjDNtKflDSctJM/brDKCgCub2xZeZ7bA3P2kvYSLrQf
         P+oeG2T5bTD2VB8jR5pzN1niZDtzypOA1EzW0dH/PU4wvF/03puGh8VvPLPqCRLK4az5
         rOYaMcTCrpABVY2pctodZXHNCGvzqxYthzkUspP/qq3tmb+w3Wzp0QS3kZF8PZzHkpBN
         TH+g==
X-Forwarded-Encrypted: i=1; AJvYcCWu4KEskkr0bZONNEjs5pQQPbZsP1EIb35xxfqR5rqtUEGLnmW6SD4XJ8vIo3WLfW0e6WrRV04cDN5+J1Zg9TuCZy9Nx5QRu6VIyCqesOhM8w==
X-Gm-Message-State: AOJu0YxYI/jYQAtUl34ba/yrATqG8L1pwwzwRPvhQrgfOBNN50LI6qjK
	v3wt0tsxzB3d07E5W4T1SsCWrt18F+fC5oR7WxdksPYxjyRL/t6m7ipoqEyh8QvAiFxlIC/if99
	5tw==
X-Google-Smtp-Source: AGHT+IGTwogz395YcDpJ8vsW5oF/ZJs17z0JztTRaWHGTPCZjGfXEKc3xTuRKSaj6FoxAkqRPGfrkPX7DW4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:fc07:0:b0:5dc:4a5f:a5ee with SMTP id
 j7-20020a63fc07000000b005dc4a5fa5eemr19333pgi.1.1712863928433; Thu, 11 Apr
 2024 12:32:08 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:32:06 -0700
In-Reply-To: <Zhgh_vQYx2MCzma6@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-2-xiong.y.zhang@linux.intel.com> <ZhgYD4B1szpbvlHq@google.com>
 <56a98cae-36c5-40f8-8554-77f9d9c9a1b0@linux.intel.com> <CALMp9eRwsyBUHRtjKZDyU6i13hr5tif3ty7tpNjfs=Zq3RA8RA@mail.gmail.com>
 <Zhgh_vQYx2MCzma6@google.com>
Message-ID: <Zhg6th5ye-LPynY3@google.com>
Subject: Re: [RFC PATCH 01/41] perf: x86/intel: Support PERF_PMU_CAP_VPMU_PASSTHROUGH
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024, Sean Christopherson wrote:
> On Thu, Apr 11, 2024, Jim Mattson wrote:
> > On Thu, Apr 11, 2024 at 10:21=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> > > On 2024-04-11 1:04 p.m., Sean Christopherson wrote:
> > > > On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > > >> From: Kan Liang <kan.liang@linux.intel.com>
> > > >>
> > > >> Define and apply the PERF_PMU_CAP_VPMU_PASSTHROUGH flag for the ve=
rsion 4
> > > >> and later PMUs
> > > >
> > > > Why?  I get that is an RFC, but it's not at all obvious to me why t=
his needs to
> > > > take a dependency on v4+.
> > >
> > > The IA32_PERF_GLOBAL_STATUS_RESET/SET MSRs are introduced in v4. They
> > > are used in the save/restore of PMU state. Please see PATCH 23/41.
> > > So it's limited to v4+ for now.
> >=20
> > Prior to version 4, semi-passthrough is possible, but IA32_PERF_GLOBAL_=
STATUS
> > has to be intercepted and emulated, since it is non-trivial to set bits=
 in
> > this MSR.
>=20
> Ah, then this _perf_ capability should be PERF_PMU_CAP_WRITABLE_GLOBAL_ST=
ATUS or

And now I see that the capabilities are arch agnostic, whereas GLOBAL_STATU=
S
obviously is not.  Unless a writable GLOBAL_STATUS is a hard requirement fo=
r perf
to be able to support a mediated PMU, this capability probably doesn't need=
 to
exist, e.g. KVM can check for a writable GLOBAL_STATUS just as easily as pe=
rf
(or perf can stuff x86_pmu_capability.writable_global_status directly).
