Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75323587D3
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015555; cv=pass; b=ug41fyyjI4O0uVT3Lup1OOJACTDSkEgQVMlSxdsbfyjqRLcqfpykcn/YLdfunGhX3FBUGwUDcBTSlhiFTS4UIkjklfVDdBgkkjUEI1MORCrRsAJHEOXHRKIT1qkmvbWU5+SREhkmMdB7AM30UVSAhu0EEEUyiBNfZZtkXhecEqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015555; c=relaxed/simple;
	bh=3xH7cJoayCQBMHX/pjqxO9L52SPb8ZPPAk3JLOEwKBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUOlVDiM/a5DuVSbP0vh3SIjPVxRZntL9R5oirgVLwujN9Dm6AdV3i4jS0WnH0e9DEIAGu/k2UObWM0Z/+5FfuOpKOKpb21KeOSuSsRj0bOEulNGjZBv5CruNQTKwuqOo5ZunLkaDYuf2mLziy5r+VQUENUKytf6NbgdTYGB7rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EktJ2FMX; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EktJ2FMX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d06cfa93so95825ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 09:12:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769015553; cv=none;
        d=google.com; s=arc-20240605;
        b=QmXVMf04JoHjcC/b236LqxPQn9dyL0Thxa33RjSYefWYJ06Io92EgH/RUSx2BBwYO/
         13Uc0fQFYx/5yczyzkgIl1dIXDvgcOKu8pqxHeLoq3dXTsFvMe9uYxyDiRDyONYb3OXJ
         64hptxFu/12L2uV7ziQd9CI+dzwd2o+ACwOYJhhy+NnG906M79WJjNLb5iCbcEFrHtm8
         djVMjDS5WtLyPiEVuyiYu3bHlkQpwArl6Ye+CeWf7UCUN+gpEzeei0UmxlYARYtisOGy
         +pgzdSOB0I0TMuECN1aNWqWjehqeV5rVz+Ea5aZn+MIRXUic0FDPq1CXIge6JkiWtUZr
         FYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tc1dGwXswzYbHQkiJRUdg9o0VbjAjwdMnllnF6MpuWU=;
        fh=OCtKj1RDMRpRZHnfsntUz1D1DN1tzPw3gbvNF3pIP5o=;
        b=Mfv/7XSBSTO3lhe0otdUZTYeBsEtKxIyOrVY+RC1VWvAhvhnHin5czko4dPOL/lZKZ
         s16Us0SaZq+o6O9Razvg7gM61V/JjmK8WOMGLNPzaYnzy7HH2hjEKxEX1zie55yelUur
         nSYfgi87a1Wa+PxMRYJAcreinlm3+ekqHAALyR/OfVEwu1z0D/qqQQSnMyMZPKLgCCLE
         qLMetH/W/A44TGCgkKzRJx6Qb1KSKY9slJSRLn3OvYNENr9TsbtVjehIkVvOC/HAJpNQ
         zZNEmwmoYg+ajIOrADA1hxe25HOgJ39/2SdHXdNNvVz9kqOL3HfnjtiMow2SLBOlMoMf
         KVFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769015553; x=1769620353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc1dGwXswzYbHQkiJRUdg9o0VbjAjwdMnllnF6MpuWU=;
        b=EktJ2FMXwDbIa064j5Vgjyy+DNqfKgAPJCc03xTQ2Zk4g5t2piQ2cfScXQZWuqEJ9F
         fL7m2vZElK+Nc8TxFxeba9BmXq+DIzcygciw30kYfK/4kUEi7gSENeF8MSXUKMfBv650
         4Byq+IxnsiRRSyBtYBiK1cQMAB4MlLi2KtVBti4uXRfOYw9oQkk9LBNy6rE1UhznIdmj
         ikkdkpKNVm2ChbAbLW8WY5vfMQ39jAF1HCTubJghyBLRWvxJp0abIkXCUw8yFDFkxFfA
         A/b8X03j2MbaxDcTYFIjSlRBt4lp/9NMlKhqjtSrL9AoNbp2Rn2p1Rtlm82KNhozpSHI
         Qoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769015553; x=1769620353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tc1dGwXswzYbHQkiJRUdg9o0VbjAjwdMnllnF6MpuWU=;
        b=lB8nwe4UC/NmPmY5MVKgvWJW148uX6LOVhQ18m1eXFNw0Br8mC1O1HSySJPFYvQHEE
         fwqbXgL5vztwJvt93Uwx1JkoT3rUMuct3RSCMf++gveBQH/xRk4uDHY/crew60l9amC/
         Ofpv3teSaAIwmb23dXWfIsVC6JqUkv84QcbHZd/t8jO8O+wX6KFqI51CjAjdVpn7Yn4Q
         x1xwLFmhyVuGuwimMS78sjDQR52d5syge/EBTDcjD1V8FcF9F/frGMZuvq/iQ7/p+7Q8
         vQoJ35cQNZ6Oz8vvy1c4XaSTZeCaDFaV6GmbPEOvEB7wWCC33UAp3g3Hfrw/ClV8zSGy
         bLqg==
X-Forwarded-Encrypted: i=1; AJvYcCVZI28wAxRuslcP5nmGlXzHPnY+uXRspSVPeRhiz4fWkdEC3xUYmuy0Q2XCbiljTAuPej9Z4Mwq/F7v9zPv6/JD@vger.kernel.org
X-Gm-Message-State: AOJu0YzKU4DDCz0e0zM2FWbilMYarfaEPNQN5oPiRTK555NRSnDCH+ue
	+bOdnv9mQmV8VHgygyPWr5oVh4u1SWWWvU7svXYxCAi7uQ19/o/E7XGnpkMLziXadad+jTnjKrI
	CPZYuElhh+lpjHeUawuvSTnEQGi2V7bxGDz7oWmoL
X-Gm-Gg: AZuq6aK0o5BwlSt60ZN2Rc5dRUaTjCoIAogebDYWPG6mfYa7fq0aQdYANjmjb/YQyEJ
	fHmWQlD+1P/kaMKNRYLtDSAFsI9jvr2mhAgt/pq1FZhOARoQmX0QFYgTgWdxPcDq9j+KfV/8+ql
	O517fWyjiTdBoUEpEZnyz//fdf/GwZsiYYlOd7tJBN13bNA1LEnCMTwfzKr0HKc5NXzqEeDLvs7
	5mFwGqG/vaUIsZqgNqYsjhulQh/VLnvOzM4UZ6MTKKfruCZZURuUx05MYsVDJBlhjVAF3AApacM
	CtY7Iy6NJzOWQ7MfhVds1avpAQ==
X-Received: by 2002:a17:903:b10:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-2a7a244f3e9mr2184095ad.13.1769015552484; Wed, 21 Jan 2026
 09:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com> <20260121163342.GI166857@noisy.programming.kicks-ass.net>
In-Reply-To: <20260121163342.GI166857@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 09:12:20 -0800
X-Gm-Features: AZwV_QhUtCwKNF1zHLiKQ4FsJ_8SCT1LECjHQKMC093vmcxvYChH-TEAHitYvyA
Message-ID: <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, ravi.bangoria@amd.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	rostedt@goodmis.org, vincent.guittot@linaro.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com, 
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com, 
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com, blakejones@google.com, 
	ashelat@redhat.com, leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com, 
	yujie.liu@intel.com, graham.woodward@arm.com, ben.gainey@arm.com, 
	vineethr@linux.ibm.com, tim.c.chen@linux.intel.com, linux@treblig.org, 
	santosh.shukla@amd.com, sandipan.das@amd.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	james.clark@arm.com, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 8:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jan 22, 2026 at 12:09:25AM +0800, Chen, Yu C wrote:
> > On 1/20/2026 1:58 AM, Swapnil Sapkal wrote:
> > > MOTIVATION
> > > ----------
> > >
> > > Existing `perf sched` is quite exhaustive and provides lot of insight=
s
> > > into scheduler behavior but it quickly becomes impractical to use for
> > > long running or scheduler intensive workload. For ex, `perf sched rec=
ord`
> > > has ~7.77% overhead on hackbench (with 25 groups each running 700K lo=
ops
> > > on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and =
it
> > > generates huge 56G perf.data for which perf takes ~137 mins to prepar=
e
> > > and write it to disk [1].
> > >
> > > Unlike `perf sched record`, which hooks onto set of scheduler tracepo=
ints
> > > and generates samples on a tracepoint hit, `perf sched stats record` =
takes
> > > snapshot of the /proc/schedstat file before and after the workload, i=
.e.
> > > there is almost zero interference on workload run. Also, it takes ver=
y
> > > minimal time to parse /proc/schedstat, convert it into perf samples a=
nd
> > > save those samples into perf.data file. Result perf.data file is much
> > > smaller. So, overall `perf sched stats record` is much more light wei=
ght
> > > compare to `perf sched record`.
> > >
> > > We, internally at AMD, have been using this (a variant of this, known=
 as
> > > "sched-scoreboard"[2]) and found it to be very useful to analyse impa=
ct
> > > of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
> > > series to report the analysis[6][7].
> > >
> > > Please note that, this is not a replacement of perf sched record/repo=
rt.
> > > The intended users of the new tool are scheduler developers, not regu=
lar
> > > users.
> > >
> > > USAGE
> > > -----
> > >
> > >    # perf sched stats record
> > >    # perf sched stats report
> > >    # perf sched stats diff
> > >
> > > Note: Although `perf sched stats` tool supports workload profiling sy=
ntax
> > > (i.e. -- <workload> ), the recorded profile is still systemwide since=
 the
> > > /proc/schedstat is a systemwide file.
> > >
> >
> > I found this is useful for load balance analysis on my
> > 384 CPUs system with 6.19.0-rc1, please feel free to add
> >
> > Tested-by: Chen Yu <yu.c.chen@intel.com>
>
> Yeah, I've used a previous version for a while, was very nice.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Ian Rogers <irogers@google.com>

I'm still wondering if we can make some of the /proc/schedstat data
appear as tool events similar to proposals for networking and memory
tool events in:
https://lore.kernel.org/lkml/20260104011738.475680-1-irogers@google.com/

Thanks,
Ian
