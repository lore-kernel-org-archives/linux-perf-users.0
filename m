Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F81DA29
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 19:03:27 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6BC6
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 12:03:25 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a1ec43870cso1628757b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Oct 2023 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696273404; x=1696878204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3He/PUj1SuAa2JXabRDuVg056s7G52ETnxzH3dmdWOg=;
        b=OPt6mP8S+PTAA1io3oSX62PkRFFRMQai47lm+csYxbnU/hk3TOjsl8UkXN5mYvfxCb
         00hmO/F/w1BhhNahHTaONXilcHlVACvejg34jHMR9BV50BZKxr7hqbdHaB/UzbqMH8I+
         hxdGNQCtra/OsmPTGZ4Al5EzQLPrtYYei6jzdocuVLQ+JrL/D0oEORbTKoeUI5XeMIim
         0C1dMnN2Abc0OSDQpM7wCxMi4tVgjaAnAZWOQmwn6AFDAcNbHqGP3QqdCvu3qMm1A3c2
         g06qAxrA8nZ6BslyWONYQyWGHmzLhkQIZkBD0oj9QHDxAFvbodZEwak7aTX9VD8dVfTt
         WN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273404; x=1696878204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3He/PUj1SuAa2JXabRDuVg056s7G52ETnxzH3dmdWOg=;
        b=AEPu2M+mi6jR67bqqtMxQw6IETWtkLlsm+c2Bat1+s8I63NKPfeKScQdTz6EvxMVk+
         dthNGzeBEbZgpyxk6+G8qUYjsxPYUs9lYGjoQwlnoHEgPUmlMIpRCcytaAn4oGC1ow3k
         cfyBp+ZjCsWKve7VM5ANJTGHXExOFil4uhCsl+WC1wmPOt9RuxKlvb9atzoD/ohWqbvu
         tjFdXFf7Y2nWAeldpYqX1Gyc/gG0XSxAHhR0wZe3wihGrHL6JnqcBZQhef8dJZB/MyuQ
         eSmgqQY1Ln7ZYsW19VSIY2hAxXk/GOvNitszvISr2H6zIkVDAWxAsSuszXxtJn89/eQ0
         F+4g==
X-Gm-Message-State: AOJu0YxYp6R12QZbmZjtMrWOGMAqE8unLISxeu0/gCx3sVkURxXdv8xc
	Y4vZLwLK8TejwhurRUQn8hK7VvT5TFd4z/5n8sIPAg==
X-Google-Smtp-Source: AGHT+IEA4dDmQIWRpX6+dlkx4q9Ijn6B2IOnk5daMYuSLEH8f9r1rw9SVKRq62PuHfbXPuIVJgNXE2DhJjYf4yhOlSQ=
X-Received: by 2002:a25:874e:0:b0:d81:83f6:99cb with SMTP id
 e14-20020a25874e000000b00d8183f699cbmr11987198ybn.42.1696273404469; Mon, 02
 Oct 2023 12:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
 <20230927033124.1226509-8-dapeng1.mi@linux.intel.com> <20230927113312.GD21810@noisy.programming.kicks-ass.net>
 <ZRRl6y1GL-7RM63x@google.com> <20230929115344.GE6282@noisy.programming.kicks-ass.net>
 <ZRbxb15Opa2_AusF@google.com> <20231002115718.GB13957@noisy.programming.kicks-ass.net>
 <ZRrF38RGllA04R8o@gmail.com> <CABOYuvYNZd63mNjAsZUckguYbcq4KDvy1Q9Zwzh1DgFfiFb=HQ@mail.gmail.com>
In-Reply-To: <CABOYuvYNZd63mNjAsZUckguYbcq4KDvy1Q9Zwzh1DgFfiFb=HQ@mail.gmail.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Mon, 2 Oct 2023 12:02:47 -0700
Message-ID: <CAL715WJyrb7-cj=p78WwDWvv_gwBjAFSOch0M8C02iNfSVuOaw@mail.gmail.com>
Subject: Re: [Patch v4 07/13] perf/x86: Add constraint for guest perf metrics event
To: David Dunn <daviddunn@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Like Xu <likexu@tencent.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Jim Mattson <jmattson@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 8:23=E2=80=AFAM David Dunn <daviddunn@google.com> wr=
ote:
>
> On Mon, Oct 2, 2023 at 6:30=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
> >
> >
> > The host OS shouldn't offer facilities that severely limit its own capa=
bilities,
> > when there's a better solution. We don't give the FPU to apps exclusive=
ly either,
> > it would be insanely stupid for a platform to do that.
> >
>
> If you think of the guest VM as a usermode application (which it
> effectively is), the analogous situation is that there is no way to
> tell the usermode application which portions of the FPU state might be
> used by the kernel without context switching.  Although the kernel can
> and does use FPU state, it doesn't zero out a portion of that state
> whenever the kernel needs to use the FPU.
>
> Today there is no way for a guest to dynamically adjust which PMU
> state is valid or invalid.  And this changes based on usage by other
> commands run on the host.  As observed by perf subsystem running in
> the guest kernel, this looks like counters that simply zero out and
> stop counting at random.
>
> I think the request here is that there be a way for KVM to be able to
> tell the guest kernel (running the perf subsystem) that it has a
> functional HW PMU.  And for that to be true.  This doesn't mean taking
> away the use of the PMU any more than exposing the FPU to usermode
> applications means taking away the FPU from the kernel.  But it does
> mean that when entering the KVM run loop, the host perf system needs
> to context switch away the host PMU state and allow KVM to load the
> guest PMU state.  And much like the FPU situation, the portion of the
> host kernel that runs between the context switch to the KVM thread and
> VMENTER to the guest cannot use the PMU.
>
> This obviously should be a policy set by the host owner.  They are
> deliberately giving up the ability to profile that small portion of
> the host (KVM VCPU thread cannot be profiled) in return to providing a
> full set of perf functionality to the guest kernel.
>

+1

I was pretty confused until I read this one. Pass-through vPMU for the
guest VM does not conflict with the host PMU software. All we need is
to accept the feasibility that host PMU software (perf subsystem in
Linux) can co-exist with pass-through vPMU in KVM. They could both
work directly on the hardware PMU, operating the registers etc...

To achieve this, I think what we really ask for the perf subsystem in
Linux are two things:
 - full context switch for hardware PMU. Currently, perf subsystem is
the exclusive owner of this piece of hardware. So this code is missing
 - NMI sharing or NMI control transfer. Either KVM could raise its own
NMI handler and get control transferred or Linux promotes the existing
NMI handler to serve two entities in the kernel.

Once the above is achieved, KVM and perf subsystem in Linux could
harmoniously share the hardware PMU as I believe, instead of forcing
the former as a client of the latter.

To step back a little bit, we are not asking about the feasibility,
since KVM and perf subsystem sharing hardware PMU is a reality because
of TDX/SEV-SNP. So, I think all that is just a draft proposal to make
the sharing clean and efficient.

Thanks.
-Mingwei

> Dave Dunn
