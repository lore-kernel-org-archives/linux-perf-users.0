Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD063A1D3
	for <linux-perf-users@vger.kernel.org>; Sat, 27 Apr 2024 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714187123; cv=none; b=m7hCODMW6TWisP22u4Q7AShwVdE3lLIAp46e8UFCtyWP3LzD2Ge4wQmpueyGtPAxqusj/WV7HUfRa5maVfK+EeNMON3uTQBfopHhXk3mKj6nlWZX/vPoUoiFtXtudLeUNdhv6q/eUCQXbjjrIdjKEB5OBUHnsh0OZxqJwB0bHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714187123; c=relaxed/simple;
	bh=cha9/ffLclacPVD18t3NcfWoJYtnsmNrKw5+kqwJzek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBn1SaRWjMI7y6Mtkk7LHA7RNyJ1f9gbASzfZLa+SKajVhHGWR89GOyhA2OnW5xWHRWQwlBw3+5KNvcN2+iyey8mGcd4woZUt3w17irrg5XI+LNbODyyWUTSNoON5Rp4D5dr5VKRQVCV4mTTHD/8hnCYslP55McPLndl4OH3HkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voTlGHY6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voTlGHY6"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51c077cfc09so3273117e87.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714187120; x=1714791920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KxZsU8CfmoqVg9nhLSmO6KA2q/B4uRALVgx58uGwIw=;
        b=voTlGHY6WNTRPZ9TfTButMeOuMUwcNq5SxdPYKrglGQUsUvzcGUUbGHg5tNjo5Oldm
         z3Do2cIXWc0N4G0ogEAh2PqNlhVBOpQuXvesYHWlBkUDW28XNwYh7jumUCeR+5YyWDBn
         FzDB1AbuEXZdS3mwxpQwRVUBZX5yCkN9o7eJDsEE/hSRAI5/N32SLzRKVqgH2yQAsoUS
         ofG8gkthNoRAgcP5PQjmKOgHxciOsT0OT5Mxxv8E54CJiBZ0cKczfh8CUrYWjovIqi85
         KR90oxrD+0rvylNqHD4ZHTNeGJrni037tpSceMkDcjEA2HRKAFG5ke8oTNQPDSy2fMzm
         l0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714187120; x=1714791920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KxZsU8CfmoqVg9nhLSmO6KA2q/B4uRALVgx58uGwIw=;
        b=Bndf0DxYjF7gulCe03w15bMzX2uCfgZE8Ah6QwV+n6MDZgMptRbQkjG+w4M1iDoYl3
         cY4f1YouOVjxx1LhA1hjJAgCjrT4vOGBmRNmwoPFYJB5RPx8LoX6XWLIadIrKKpWec0H
         SminZznVtzYeUiFWBsuVN+6IGemgz/UxQSA0seZQ7B3qB/kUmMA1TuoqUcpw/CSQRrd+
         ypqAtCupYHrRnq2ZTqBoNB+obzFoYs0lleT2JC5c8uxzACamO6PkWMh/JOeLwnFFcJtN
         HTEzQ4fLQcJvW14yPB+kfhrGVSMZnvSyYO9h7yw620Q4o+8Ur4HgY5V9wylqlTkd9vo9
         2Wbw==
X-Forwarded-Encrypted: i=1; AJvYcCUGNTrllzx1UzfhwT2+Ha3S/cEcnO1BwOilQ3IC+EYzh7rh51cEAhikpzZ7o+GUMuVdoBQC2RgcWvMca6HEH9ePwOzVmfF6Wkz+NctpaE940g==
X-Gm-Message-State: AOJu0YyFPe3CSFFSEXBIRU4/JJFq0qP9Cf/OHVTL5arNDKs0xYwiGmSw
	6otXoA5uyc41XRlRRz1ZM7PQzpk9WHB+PLHumITpDyibV8/peRdqmReOvKnfbr6rr3vWXC2+mXi
	iGTqqLDNkfaL14H6Zh15mnq+TT6N92OxY0dIS
X-Google-Smtp-Source: AGHT+IH7ZrbbxcIWFPMbr/gIXjFP4VCMqRaA2i6I0HFIVTbw9MBdGrgRXfr/4EcW+YlMTOtyvboEK6FX9s4UKILqlag=
X-Received: by 2002:a05:6512:684:b0:518:17ad:a6e0 with SMTP id
 t4-20020a056512068400b0051817ada6e0mr2933668lfe.51.1714187119584; Fri, 26 Apr
 2024 20:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
 <6af2da05-cb47-46f7-b129-08463bc9469b@linux.intel.com> <CAL715W+zeqKenPLP2Fm9u_BkGRKAk-mncsOxrg=EKs74qK5f1Q@mail.gmail.com>
 <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com> <ZirPGnSDUzD-iWwc@google.com>
 <77913327-2115-42b5-850a-04ef0581faa7@linux.intel.com> <CAL715WJCHJD_wcJ+r4TyWfvmk9uNT_kPy7Pt=CHkB-Sf0D4Rqw@mail.gmail.com>
 <ff4a4229-04ac-4cbf-8aea-c84ccfa96e0b@linux.intel.com> <CAL715WJKL5__8RU0xxUf0HifNVQBDRODE54O2bwOx45w67TQTQ@mail.gmail.com>
 <5f5bcbc0-e2ef-4232-a56a-fda93c6a569e@linux.intel.com> <ZiwEoZDIg8l7-uid@google.com>
In-Reply-To: <ZiwEoZDIg8l7-uid@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Fri, 26 Apr 2024 20:04:42 -0700
Message-ID: <CAL715WJ4jHmto3ci=Fz5Bwx2Y=Hiy1MoFCpcUhz-C8aPMqYskw@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: Sean Christopherson <seanjc@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	maobibo <maobibo@loongson.cn>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:46=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Apr 26, 2024, Kan Liang wrote:
> > > Optimization 4
> > > allows the host side to immediately profiling this part instead of
> > > waiting for vcpu to reach to PMU context switch locations. Doing so
> > > will generate more accurate results.
> >
> > If so, I think the 4 is a must to have. Otherwise, it wouldn't honer th=
e
> > definition of the exclude_guest. Without 4, it brings some random blind
> > spots, right?
>
> +1, I view it as a hard requirement.  It's not an optimization, it's abou=
t
> accuracy and functional correctness.

Well. Does it have to be a _hard_ requirement? no? The irq handler
triggered by "perf record -a" could just inject a "state". Instead of
immediately preempting the guest PMU context, perf subsystem could
allow KVM defer the context switch when it reaches the next PMU
context switch location.

This is the same as the preemption kernel logic. Do you want me to
stop the work immediately? Yes (if you enable preemption), or No, let
me finish my job and get to the scheduling point.

Implementing this might be more difficult to debug. That's my real
concern. If we do not enable preemption, the PMU context switch will
only happen at the 2 pairs of locations. If we enable preemption, it
could happen at any time.

>
> What _is_ an optimization is keeping guest state loaded while KVM is in i=
ts
> run loop, i.e. initial mediated/passthrough PMU support could land upstre=
am with
> unconditional switches at entry/exit.  The performance of KVM would likel=
y be
> unacceptable for any production use cases, but that would give us motivat=
ion to
> finish the job, and it doesn't result in random, hard to diagnose issues =
for
> userspace.

That's true. I agree with that.

>
> > > Do we want to preempt that? I think it depends. For regular cloud
> > > usage, we don't. But for any other usages where we want to prioritize
> > > KVM/VMM profiling over guest vPMU, it is useful.
> > >
> > > My current opinion is that optimization 4 is something nice to have.
> > > But we should allow people to turn it off just like we could choose t=
o
> > > disable preempt kernel.
> >
> > The exclude_guest means everything but the guest. I don't see a reason
> > why people want to turn it off and get some random blind spots.
