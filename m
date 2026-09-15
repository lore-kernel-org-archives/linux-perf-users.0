Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0A440A25
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511521; cv=pass; b=saOf286GCACNmFzgewJzA1T77adgp1MYmVVMH2hsq73iaw4JKIycCnF3PasqmhuT/X7eGZyfRxwnndTz3slCOAEYPFgCb7iTio+1fcvvyaMFDexwVZAXKkuTFTe1BoB0R78B7uhIPgLa1fg4dyPk7ZGl8nZU4D/dwr1OGz+7p8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511521; c=relaxed/simple;
	bh=HwkUmEeMNJIDc9Gel3SUVMVZAqVSKw+L0prI4S18Yvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRYUOOw8r/trO2+g0gBeAyY0dEcFjkYMSmIDcrkZzejYcHmz1CC4GTzeu8QFdM4BmyjJXid2gxGlHzVWH1KlKvTFpgD3kILtetfr58YaG6oiL6cU1FyXd5gfQsrs0PCxM3g8FOe/hlTKRzg5ZYYNDXH07Foca2DPEe+xuFCE4pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmGLTiyT; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmGLTiyT"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d5fc2cd8so40681cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789511518; cv=none;
        d=google.com; s=arc-20260327;
        b=QN0AUkGN68tl2um8x4LXHAxbUB/zEDSm59F7y4PoLBf3heBfEGJIJiPanq2ntMU2xH
         KNCJLKLpWhrsnf4jcgrlHXxomPkiEbCBz6zFcEjrMvYFbHL14+E+gQUflilPfsfJJFsN
         j+VguRFZRSPYErHuj2QoFUpqBzjnSbfrbP0uI7DQh/l+zqXACOM9Ma6aWIZTzVmXDah2
         N8JLHRtghT5YjSFTdLBczHVBuYUp6hs7I1wfDOFQHjG/WO+qjXBIBsTfuCWXndr3rekz
         0mm6PQ8Z3CyxjVe7CYFmZNfODFGajz7okokWyrl/Qa2Gbxl7Jz0ja37a7QaIHLBvcvPi
         OgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rF3d1NpRpJqESqzYc95bKbTV6mFlbMcr7RivfQo41c8=;
        fh=uo1se5QM1ODP7kO/ILzsmwWHx+eJuR80l+cA29BYjY0=;
        b=rjf4XOgTWMMeSJ2D57soSFy7vR07LfGwtZkK8LQCtlO1eeJhhDhDs6DPD3dHa27d9C
         qMLKZRLf1YeFlbOcyQYZ202LyawqbwQocCLfE6aa1vB0wzz8P6Dnd/uUbBGke3BuWr4l
         WsTb0hotPgs9iPxj9lAI/KR5pT9WwLJ/TjpuCj+z9lT2fMNIDWSUJV0436Mq3ZCnCClC
         o1qen+To/MpUlkYFyqrl+XFXzwVdoTzaOqKGQoW9rJ1JEbOulGEtP+4u17Xjq8NzKNv7
         Pp72cIHHwQLT5jVOtyxxTscTG2Hk7vgzBlq6UyikDHE+yLVyGJN2ZPwgXRFR2FXpMx87
         Fk2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789511518; x=1790116318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rF3d1NpRpJqESqzYc95bKbTV6mFlbMcr7RivfQo41c8=;
        b=rmGLTiyT872aZ7Gv3kYRsdGVVc3aKjEAJwTRbugk1jh3QssVHVzdKVtNJFA3kjgZuf
         mk2gZqUQVhzl9hYPCSX0qDi3UrG4zEZiFBu/L2x3zRgOSBcYzYiQwmyFtuZyG4aa+c0W
         A79j1YeCp9cD5WIDD2D42uwnhmEOKCupj/R613kru1BsCQLyFUht2SfHdd+IPtXdeGRU
         JgQkmSclhfXvYm0G2DChEyUWty0lh+SYNwdDV6pZiHzh2pelutzIDf0b0idIrDOgN/Xu
         j2922DpwX/zgoIL3dEaQ+L5BYiSupjszabRyVJ+E59+ufLnyVEhnI7VEN10UxWIkGaIw
         Qlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511518; x=1790116318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rF3d1NpRpJqESqzYc95bKbTV6mFlbMcr7RivfQo41c8=;
        b=v/6fv7DTLxS3SGIVWjWHBvshdz7aoCkzI2zWMBJEW3dlKD+j/odVAffMqixTD0NxAH
         DwKjomaQFcnZrW94Z3fOgIUjeRd6rFWMvzh9PL9IwP6YRTcwoj+nRszg0GlegcvtgopM
         fwlEoHYiPzsZ+nKNfzWljbrkvKzF0sBl11fW2oAjPg+7qYMaGCZMpljd8IlNJmI48n54
         URS1vxzRFR0lCcMO/zqs/ZOA+ej3a3+4PateRWWpIJuP5/FEFQ1AS55YPIEfA9sP8r5M
         7Zs8jlv8hSwlRYxC7+j65EYLEjqEY7mxN252O/OWgua6g/myTby0spEjzTJs/0Fida8y
         3neg==
X-Gm-Message-State: AFuF++nBgo92HR5Atu1Rn0qGe0ov86Ogz6OUUGaflak1C1gHSvJIFeiO
	1uFekrrmFM+Q4h55EGjeiGFg77EUsdi825a0JfBUqG9g+jBHEhcAyiny9tD/f3FN0W6ktz+glJi
	icteRpvs4A6l33KUC+0qWBjbKf98r3KTGvfUJez6H
X-Gm-Gg: AYBFou357G4ksMXMxVRQ5G7jEhFS1d0DOCUyfV8CRxEbsYpV433n9Ur0M7Jh1pl9Fir
	h4NilOp2okXVN5CB4ApXGpXTFXlN9isCakv1Nha3LXMfC0eGtYqPbyTXE9DfePB8WKAWjISgoTb
	2VctJL+IngFPIWalqAe5T9Z8huovzeMLv8BtTqIJLnr/guxDU2yFArxoimiP2hVKFOvJMLMLoND
	9C+OQkqGmHLVZ/Z60+ymH2SUk+emq5zDx36Y5ns4uLc0l81EcgfMuUr0+WGCL1OqibIlJfafbry
	/uButJyM4NOdkaRMCIIRkAJHqDAH8ueoVZ5rkLwY9yDZ0EjGY0R7Wu3EiDKR7NU9HE3zReAJfn3
	FtnFzV9BorA==
X-Received: by 2002:a05:622a:260f:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-5325087c7f5mr5483341cf.12.1789511517300; Tue, 15 Sep 2026
 15:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786728929.git.sandipan.das@amd.com> <10376263-f9e7-4419-9042-074b3a36cfab@linux.intel.com>
In-Reply-To: <10376263-f9e7-4419-9042-074b3a36cfab@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:31:45 -0700
X-Gm-Features: AcwNN1UnN_Tnwq8QQ1u5fl9Yt3ytKf6W3FXRQdA0drJuJRJdASR59wa4A4UogVw
Message-ID: <CAP-5=fX5zYcb4=q_BqM+h+5g3ZnuSjEWg1=f5LrtfOfcgtHetA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf/x86: Fix perf_event_print_debug() on
 non-Intel PMUs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Petr Tesarik <ptesarik@suse.com>, Zide Chen <zide.chen@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 6:12=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
> The whole patch series looks good to me. Thanks.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Ping.

Thanks,
Ian

> On 8/15/2026 1:48 AM, Sandipan Das wrote:
> > Petr Tesarik reported that reading MSR_ARCH_PERFMON_FIXED_CTR_CTRL
> > raises a #GP on AMD processors that support PerfMonV2, and proposed
> > skipping that register when no fixed counters are implemented [1].
> >
> > However, perf_event_print_debug() also dumps the global control and
> > status registers whenever x86_pmu.version >=3D 2, and reads Intel
> > Architectural PerfMon MSRs to do so. That condition used to be
> > Intel-specific, but since commit 21d59e3e2c40 ("perf/x86/amd/core:
> > Detect PerfMonV2 support"), x86_pmu.version is also set to 2 on AMD
> > processors that support PerfMonV2, where none of those registers are
> > available.
> >
> > The same reasoning therefore applies to the other registers read here,
> > so rather than special-casing each one or reinstating a vendor check,
> > this series makes the global register dump a vendor-specific operation.
> >
> > [1] https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.=
com/
> >
> > Previous versions can be found at
> > v1: https://lore.kernel.org/all/cover.1786010408.git.sandipan.das@amd.c=
om/
> >
> > Changes in v2:
> >   * Address build issue reported by Sashiko.
> >   * Use a static_call as suggested by Dapeng.
> >   * Pick up Tested-by from Petr.
> >
> > Sandipan Das (3):
> >   perf/x86: Add x86_pmu::print_debug
> >   perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
> >   perf/x86/amd: Implement x86_pmu::print_debug
> >
> >  arch/x86/events/amd/core.c     | 20 ++++++++++++
> >  arch/x86/events/core.c         | 60 ++++++++++++++++------------------
> >  arch/x86/events/intel/core.c   | 32 ++++++++++++++++++
> >  arch/x86/events/perf_event.h   |  4 +++
> >  arch/x86/events/zhaoxin/core.c | 18 ++++++++++
> >  5 files changed, 102 insertions(+), 32 deletions(-)
> >
