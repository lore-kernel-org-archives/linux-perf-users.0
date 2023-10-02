Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E119BBE
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 15:23:33 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF260B8
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 08:23:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41958410e5cso496961cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Oct 2023 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696260210; x=1696865010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcmjJranJU9dHmKZgwi11TJfqlRgTzZNCx/vVbaZ/W0=;
        b=WRCQdQGHTZRwMsM/W5bx9E3lku+poVB/wDA58277PG8jQwqVtE0Cbu/XEumKa0Lps6
         0J5eKYADoXN+vUWAvYxnXH9dSe4nG6LkHrwJvH4g3dvbUs3ntyk3j+7bD4m1363WSjQw
         tzMSSbs1cPT9kNtswcAg70HcFBcDugUv3awR6lRzA1Zhb372xG22TwZLTPG5LvpbV0re
         DAJjmCby8mqQN5R4wfdRZOZYSA+zRRKPX5sAawG09qginICkco9KeCzdWAlF7AF55pHp
         QFxwtSRlUXbXAEweNyj5a1aqSq8g307bIk0fcPIk9FLhafs5QkCgVVDF2jPq3ny0zh5f
         DkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260210; x=1696865010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcmjJranJU9dHmKZgwi11TJfqlRgTzZNCx/vVbaZ/W0=;
        b=aMR5vpaqj7qTtjRNnwPMxpCeK1k1ctHouUjBMMK3s+QyhIocrpsn/Vdly8JMR9okcF
         osiJELGn/9dH5/sUUKYgzH2TGjlGA/40pBJ18sX/xkaV5q/LWFRtSxQh+kMapEF1lqYh
         jVBUD0Xzy8AM//hJOB04kFDzDlg1U+AXa0I7PCtTnKvwh1MCABr/H1JJ0B1qMe76XWX6
         d36dAd1oTfnQnvM32lARYiKX+ue5dG8tQwKMdM7YK5lsEPiSi7N1Q61hHcd0HpYE7DXT
         VtZXUeOWBEIseybl1CNj4c4c0fVzklHsXDKG1ziq57yf4iU+/4hrB6IKBGNAEWToMLVb
         4gOA==
X-Gm-Message-State: AOJu0YzZ/WQr7ZLDwBffLBiWwCr18Xw2MMHHk5X7O9MNJr5Ss6iFaYQp
	Kqgq06Aax1BIPnmlofQYtCuBRwiyTOvOtCgy6FJHGw==
X-Google-Smtp-Source: AGHT+IFlu305KhvyXysTo++Jl9EAskcrzabqiwpzs9CTrnnArCGgWBa6iqE4HiqMPpkfLFQwSSpfqxOPoWFQEhD18O0=
X-Received: by 2002:a05:622a:94:b0:417:9238:5a30 with SMTP id
 o20-20020a05622a009400b0041792385a30mr354168qtw.29.1696260209711; Mon, 02 Oct
 2023 08:23:29 -0700 (PDT)
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
 <ZRrF38RGllA04R8o@gmail.com>
In-Reply-To: <ZRrF38RGllA04R8o@gmail.com>
From: David Dunn <daviddunn@google.com>
Date: Mon, 2 Oct 2023 08:23:17 -0700
Message-ID: <CABOYuvYNZd63mNjAsZUckguYbcq4KDvy1Q9Zwzh1DgFfiFb=HQ@mail.gmail.com>
Subject: Re: [Patch v4 07/13] perf/x86: Add constraint for guest perf metrics event
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Like Xu <likexu@tencent.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 6:30=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> The host OS shouldn't offer facilities that severely limit its own capabi=
lities,
> when there's a better solution. We don't give the FPU to apps exclusively=
 either,
> it would be insanely stupid for a platform to do that.
>

If you think of the guest VM as a usermode application (which it
effectively is), the analogous situation is that there is no way to
tell the usermode application which portions of the FPU state might be
used by the kernel without context switching.  Although the kernel can
and does use FPU state, it doesn't zero out a portion of that state
whenever the kernel needs to use the FPU.

Today there is no way for a guest to dynamically adjust which PMU
state is valid or invalid.  And this changes based on usage by other
commands run on the host.  As observed by perf subsystem running in
the guest kernel, this looks like counters that simply zero out and
stop counting at random.

I think the request here is that there be a way for KVM to be able to
tell the guest kernel (running the perf subsystem) that it has a
functional HW PMU.  And for that to be true.  This doesn't mean taking
away the use of the PMU any more than exposing the FPU to usermode
applications means taking away the FPU from the kernel.  But it does
mean that when entering the KVM run loop, the host perf system needs
to context switch away the host PMU state and allow KVM to load the
guest PMU state.  And much like the FPU situation, the portion of the
host kernel that runs between the context switch to the KVM thread and
VMENTER to the guest cannot use the PMU.

This obviously should be a policy set by the host owner.  They are
deliberately giving up the ability to profile that small portion of
the host (KVM VCPU thread cannot be profiled) in return to providing a
full set of perf functionality to the guest kernel.

Dave Dunn
