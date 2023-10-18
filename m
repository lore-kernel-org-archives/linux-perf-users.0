Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB6800
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="majv7qat"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3486BA
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 17:02:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-777745f1541so95079985a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697587321; x=1698192121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/603XVHKaUaM8lugP87JFe8YYdPyptNnYZAmeymCgY=;
        b=majv7qatmKp5hGEMBDnrcA/xbS7deDukIQnOFM9dOmjfsR5yTtI/fh9vZqOeE6a3+I
         zHB0ptmqwmSjHEjaNF1bHyj76vG+mHkTb8CzzmS0CLSl8vW/xrdR+oeYtV3NDPbkhJuk
         eY9HfyzB3w8lKw22JBZALwsrMiVe0RQZ25wlVz4MruYuL0n9R6oiiqsUYSUo5sKCw35h
         hkSl5piDBIhaw1Ol1kWt61AdwUpalXYQUf66tmKAKa3PGAYdYe7bffojY0/2XCFfYaaJ
         Ek0QEgKSijvvlu0E+gHtOBCONzYD26k37W0AaIfIwtP6iBUMeUJ5wd2jCo/8vqNTA2LB
         Tx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697587321; x=1698192121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/603XVHKaUaM8lugP87JFe8YYdPyptNnYZAmeymCgY=;
        b=M0a+lf5P/JKUzitu4vsKgPob/3eTdS2YwmqK/k1Y8S2dXwAD8uNEkVFNllPxGf3dwx
         XmsZJmy1+B/vb8aYD75TmKy9TsXFA88NtCZDVMgO165wWZ/uO/FHY/hLC1LFyDS3qIW5
         33sXPCKUL7l6VoJkpdrizVIYOwrh9v3dkEDZHynfuGA/fZji4p0ZCOZjMVGaROoQLtsw
         EsskjhJrUCy9e5/5++TOrrAJkOISpdvR9wlzXTmpWKpnzX63Ix2tGQ63YY1K+0lmqlKK
         Al1rC3UzE77K67jyIAFf1IAg3ay9dK5T8cb2LmJp9E7M8B5I368zoUOT6Hhla0vX/pBa
         PKvg==
X-Gm-Message-State: AOJu0YxeFYlJlq1uMD+bWLReJs0C0Qpcw8DRNNd9WIYzTxXdCNl1GoHW
	liADs0fcbQPxGi13c0NcAC62pxWJmCqo98AYe1DQqg==
X-Google-Smtp-Source: AGHT+IESc2jTZ14IErCtSD+XcH0XpFOrhUBDLZawZQWz8lF0Jn33Z5ZeUHxOsx7dhaVo+vey71zFifxSwADdtIjWyu0=
X-Received: by 2002:a05:6214:2aa1:b0:66d:3c8b:5f44 with SMTP id
 js1-20020a0562142aa100b0066d3c8b5f44mr4336406qvb.27.1697587320791; Tue, 17
 Oct 2023 17:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002204017.GB27267@noisy.programming.kicks-ass.net>
 <ZRtmvLJFGfjcusQW@google.com> <20231003081616.GE27267@noisy.programming.kicks-ass.net>
 <ZRwx7gcY7x1x3a5y@google.com> <20231004112152.GA5947@noisy.programming.kicks-ass.net>
 <CAL715W+RgX2JfeRsenNoU4TuTWwLS5H=P+vrZK_GQVQmMkyraw@mail.gmail.com>
 <ZR3eNtP5IVAHeFNC@google.com> <ZR3hx9s1yJBR0WRJ@google.com>
 <c69a1eb1-e07a-8270-ca63-54949ded433d@gmail.com> <03b7da03-78a1-95b1-3969-634b5c9a5a56@amd.com>
 <20231011141535.GF6307@noisy.programming.kicks-ass.net> <b2bfead3-0f48-d832-daee-e7c2069dae5d@amd.com>
 <CAL715WLhJ_xSL-cR+ppoJA+dwWK2gwCPb2ZqfToRYm-ShqkmEw@mail.gmail.com>
In-Reply-To: <CAL715WLhJ_xSL-cR+ppoJA+dwWK2gwCPb2ZqfToRYm-ShqkmEw@mail.gmail.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Tue, 17 Oct 2023 17:01:23 -0700
Message-ID: <CAL715WLuO0WFumyTuahXoxxirFRknN4+nU_zNxbumuQjEVxfow@mail.gmail.com>
Subject: Re: [Patch v4 07/13] perf/x86: Add constraint for guest perf metrics event
To: Manali Shukla <manali.shukla@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Like Xu <likexu@tencent.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, David Dunn <daviddunn@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 9:58=E2=80=AFAM Mingwei Zhang <mizhang@google.com> =
wrote:
>
> On Tue, Oct 17, 2023 at 3:24=E2=80=AFAM Manali Shukla <manali.shukla@amd.=
com> wrote:
> >
> > On 10/11/2023 7:45 PM, Peter Zijlstra wrote:
> > > On Mon, Oct 09, 2023 at 10:33:41PM +0530, Manali Shukla wrote:
> > >> Hi all,
> > >>
> > >> I would like to add following things to the discussion just for the =
awareness of
> > >> everyone.
> > >>
> > >> Fully virtualized PMC support is coming to an upcoming AMD SoC and w=
e are
> > >> working on prototyping it.
> > >>
> > >> As part of virtualized PMC design, the PERF_CTL registers are define=
d as Swap
> > >> type C: guest PMC states are loaded at VMRUN automatically but host =
PMC states
> > >> are not saved by hardware.
> > >
> > > Per the previous discussion, doing this while host has active counter=
s
> > > that do not have ::exclude_guest=3D1 is invalid and must result in an
> > > error.
> > >
> >
> > Yeah, exclude_guest should be enforced on host, while host has active P=
MC
> > counters and VPMC is enabled.
> >
> > > Also, I'm assuming it is all optional, a host can still profile a gue=
st
> > > if all is configured just so?
> > >
> >
> > Correct, host should be able to profile guest, if VPMC is not enabled.
> >
> > >> If hypervisor is using the performance counters, it
> > >> is hypervisor's responsibility to save PERF_CTL registers to host sa=
ve area
> > >> prior to VMRUN and restore them after VMEXIT.
> > >
> > > Does VMEXIT clear global_ctrl at least?
> > >
> >
> > global_ctrl will be initialized to reset value(0x3F) during VMEXIT. Sim=
ilarly,
> > all the perf_ctl and perf_ctr are initialized to reset values(0) at VME=
XIT.
>
> Are these guest values (automatically) saved in the guest area of VMCB
> on VMEXIT?
>

Never mind on this one. So, if both values are in Type C, then they
should be saved to the guest area of VMCB on VMEXIT (according to APM
vol 2 Table B-3). So, this means KVM does not need to intercept these
MSRs on pass-through implementation.

Thanks.
-Mingwei

-Mingwei
