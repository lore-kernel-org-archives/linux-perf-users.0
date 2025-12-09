Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4C3128D4
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315396; cv=none; b=iBaX74V5lIs5ABQQENzo7vJnryiyHl82CgNH9KzXRBMUwd9Psmg47eQSol+aEfafkhWgggcLlEQxeQBzDFSOFuCLOFYmqd2FxEnzn+ZS+A2qvbqF7ZkWyyQL0g/8UDj3LMvVIXS28F43h3uPZcwT55LaF1ggFI3ZRfagGxwf1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315396; c=relaxed/simple;
	bh=mucoVUKCCdtJUJT/o+CYOlsOQF30kF0JmL2986cC8tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJRlUehm+til8DmilMGIPWzWl1kITPNX5WajfitLSkU/EWQA93I9u5YvmdBWpGXJka/Vu4R/pVUB9XYVtLOHcdo6KUPYPHUKZYbUlTO1eatH8FxN280T6TzVgJ4YQEZuSDNLqld/vDCFIAeiNb2n0f/z7EMdzfYdWhdxq9Z7Js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eP6PoWcr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eP6PoWcr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2980343d9d1so16165ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765315394; x=1765920194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltuJd4IR9Xwi4Dk5SETiFD2U8WT1rOExrKxCulSXNhY=;
        b=eP6PoWcrrA8g3mNZ68dPd1YmZsri4pzMwSXq6fi+CLlkepurikrASMrXX5rWpT9/CP
         PVFN31CTPP5vZ7EwvFg8PHAFUkBubp5v9jivbfGNmPay34eREMVDPXwmhzn8Pz1pm3eK
         mA/y+5cgMsqu3QOjPL5wA6twYoWnqF087wtt1fiCAFbr65OdJUBw9+BtbLyfkjcv5S4t
         wWpKfwQ6M9jD5Wpj3GnB+T2C60UbiEi78TomP8uhgZcrDis22LIxwYff32wq3d442/Pa
         +G+y0AIvnY0lbZLRKssSTuL5AkR1PxsMDWq2Fy3C7/dfnLP3KqQZnlRKokqQmM4caoGP
         JxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765315394; x=1765920194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltuJd4IR9Xwi4Dk5SETiFD2U8WT1rOExrKxCulSXNhY=;
        b=O16/qVdafNDpl+ia85IAeWi8SkUEYEFbgA1/3tbQOvjbUzxpIEKsQzgkT7i2KZC/sG
         IZRVwf25BO8NrGFTOrHXc2aUIVZPQGXR6yLHhqYbmTeSU5HsQMIWlhS11T9sLH9cN/Pr
         BarBhPYchlRD7YM6leWjLUBnNmhGEjx5Jd+VVIvHQmGaXmpJSBKKYguXy9z4Yef1K0Jt
         +CCSW0jCTDXv6MC29RLYFHhlw73YjydCzCEpQ3ZbsXnOv7XbCFjdYl03Jp9V65UhFBZI
         iWX5yIud9yD1cXR2JBnwbyXpptqQcdi00Ru6gpDOW/0N6A4wQ+EwhW/q0LDUtrya6M2X
         2Gpg==
X-Forwarded-Encrypted: i=1; AJvYcCW08+/+9sDHG5l5ExXT4ogGvuau1HgmYHCfnfw4AHz62PIbY3Z7tZmtQMZwIMy1FdMBOQoZz399AxZSJ6gINjxQ@vger.kernel.org
X-Gm-Message-State: AOJu0YweH1nbRGdIDyFRxTH0ZnE5ojEJ3gMallx62eS1usxHpNOjcyUc
	k5x39naTwoYwpxBBTL3+F/73KQ0GV6lKSGdRCJlz4XG9IMKhY+y02gQZ0YxFoRMLguu9ziiL8O1
	G7KID6y59bN2TfhaJhVQgr0XbkVt8TV1mUeBLQneM
X-Gm-Gg: AY/fxX7N8v+rPXh2z+gdoKcUPD+dOSNfjSi5r5vR7lDyVqr4P+SiiX1etPDYHTz958f
	RYeQdib+AycbDF0tzsqO90tlDdI2mxRaaBb+lwLHDOpmTHJvetcFWnG+4y3+Fv0iIx6dvN944YL
	yeri6M/k9iQk/L6JqGbjYrfS/6j2fYEbYgntKUAO2mneuFb2UNVKWQ+nlu9w5LTgE5fGvQBiabY
	rqG9pOXd2jxWqO5p+3SbZvUTdhC67B/45Xoha8UWajv1F9jcLXeE/6gduG/2UVVMU88Kjm5ew8i
	KON2vdg2rIKPRC4zn8R93gVFdNioBhWrvIc=
X-Google-Smtp-Source: AGHT+IFGHwZ+WBNiKD2Ukpzh2TOeqWtsxGlVxTjDM5O/tC8ZXFrnq4R7/PaIq9lt7alEHdQa5kYSIabuyA9oFbZAGQQ=
X-Received: by 2002:a17:902:ea01:b0:29d:7b9e:6df8 with SMTP id
 d9443c01a7336-29ebf820e77mr995395ad.2.1765315393416; Tue, 09 Dec 2025
 13:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com> <20251202175043.623597-47-irogers@google.com>
 <c71aeb58-a87c-455b-9d5d-7bb28e34d317@linaro.org>
In-Reply-To: <c71aeb58-a87c-455b-9d5d-7bb28e34d317@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 13:23:01 -0800
X-Gm-Features: AQt7F2oLlWJz_awivUXubk4AEHPdgilMtPxFS1PxSYy_IcqraGn2Q_y88AGZulQ
Message-ID: <CAP-5=fXwCoOQS=E_o34oQivXMC8RAOo8we4xk9CuL_Pa=pKOVA@mail.gmail.com>
Subject: Re: [PATCH v9 46/48] perf jevents: Add collection of topdown like
 metrics for arm64
To: James Clark <james.clark@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 3:31=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> On 02/12/2025 5:50 pm, Ian Rogers wrote:
> > Metrics are created using legacy, common and recommended events. As
> > events may be missing a TryEvent function will give None if an event
> > is missing. To workaround missing JSON events for cortex-a53, sysfs
> > encodings are used.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > An earlier review of this patch by Leo Yan is here:
> > https://lore.kernel.org/lkml/8168c713-005c-4fd9-a928-66763dab746a@arm.c=
om/
> > Hopefully all corrections were made.
> > ---
> >   tools/perf/pmu-events/arm64_metrics.py | 145 ++++++++++++++++++++++++=
-
> >   1 file changed, 142 insertions(+), 3 deletions(-)
> >
> [...]
> > +        MetricGroup("lpm_topdown_be_bound", [
> > +            MetricGroup("lpm_topdown_be_dtlb", [
> > +                Metric("lpm_topdown_be_dtlb_walks", "Dtlb walks per in=
struction",
> > +                       d_ratio(dtlb_walk, ins_ret), "walk/insn"),
> > +                Metric("lpm_topdown_be_dtlb_walk_rate", "Dtlb walks pe=
r L1D TLB access",
> > +                       d_ratio(dtlb_walk, l1d_tlb) if l1d_tlb else Non=
e, "100%"),
> > +            ]) if dtlb_walk else None,
> > +            MetricGroup("lpm_topdown_be_mix", [
> > +                Metric("lpm_topdown_be_mix_ld", "Percentage of load in=
structions",
> > +                       d_ratio(ld_spec, inst_spec), "100%") if ld_spec=
 else None,
> > +                Metric("lpm_topdown_be_mix_st", "Percentage of store i=
nstructions",
> > +                       d_ratio(st_spec, inst_spec), "100%") if st_spec=
 else None,
> > +                Metric("lpm_topdown_be_mix_simd", "Percentage of SIMD =
instructions",
> > +                       d_ratio(ase_spec, inst_spec), "100%") if ase_sp=
ec else None,
> > +                Metric("lpm_topdown_be_mix_fp",
> > +                       "Percentage of floating point instructions",
> > +                       d_ratio(vfp_spec, inst_spec), "100%") if vfp_sp=
ec else None,
> > +                Metric("lpm_topdown_be_mix_dp",
> > +                       "Percentage of data processing instructions",
> > +                       d_ratio(dp_spec, inst_spec), "100%") if dp_spec=
 else None,
> > +                Metric("lpm_topdown_be_mix_crypto",
> > +                       "Percentage of data processing instructions",
> > +                       d_ratio(crypto_spec, inst_spec), "100%") if cry=
pto_spec else None,
> > +                Metric(
> > +                    "lpm_topdown_be_mix_br", "Percentage of branch ins=
tructions",
> > +                    d_ratio(br_immed_spec + br_indirect_spec + br_ret_=
spec,
> > +                            inst_spec), "100%") if br_immed_spec and b=
r_indirect_spec and br_ret_spec else None,
>
> Hi Ian,
>
> I've been trying to engage with the team that's publishing the metrics
> in Arm [1] to see if there was any chance in getting some unity between
> these new metrics and their existing json ones. The feedback from them
> was that the decision to only publish metrics for certain cores is
> deliberate and there is no plan to change anything. The metrics there
> are well tested, known to be working, and usually contain workarounds
> for specific issues. They don't want to do "Arm wide" common metrics for
> existing cores as they believe it has more potential to mislead people
> than help.

So this is sad, but I'll drop the patch from the series so as not to
delay things and keep carrying it in Google's tree. Just looking in
tools/perf/pmu-events/arch/arm64/arm there are 20 ARM models of which
only neoverse models (5 of the 20) have metrics. Could ARM's metric
people step up to fill the void? Models like cortex-a76 are actively
sold in the Raspberry Pi 5 and yet lack metrics.

I think there has to be a rule at some point of, "don't let perfect be
the enemy of good." There's no implication that ARM should maintain
these metrics and they be perfect just as there isn't an implication
that ARM should maintain the legacy metrics like
"stalled_cycles_per_instruction":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf-tools=
-next#n49

I'm guessing the cycles breakdown:
https://lore.kernel.org/lkml/20251202175043.623597-48-irogers@google.com/
is okay and will keep that for ARM.

> I'm commenting on this "lpm_topdown_be_mix_br" as one example, that the
> equivalent Arm metric "branch_percentage" excludes br_ret_spec because
> br_indirect_spec also counts returns. Or on neoverse-n3 it's
> "PC_WRITE_SPEC / INST_SPEC".

This is the value in upstreaming metrics like this, to bug fix. This
is what has happened with the AMD and Intel metrics. I'm happy we can
deliver more metrics to users on those CPUs.

> I see that you've prefixed all the metrics so the names won't clash from
> Kan's feedback [2]. But it makes me wonder if at some point some kind of
> alias list could be implemented to override the generated metrics with
> hand written json ones. But by that point why not just use the same
> names? The Arm metric team's feedback was that there isn't really an
> industry standard for naming, and that differences between architectures
> would make it almost impossible to standardise anyway in their opinion.

So naming is always a challenge. One solution here is the ilist
application. When doing the legacy event reorganization I remember you
arguing that legacy events should be the norm and not the exception,
but it is because of all the model quirks precisely why that doesn't
work. By working through the quirks with cross platform metrics,
that's value to users and not misleading. If it does mislead then
that's a bug, let's fix it. Presenting users with no data isn't a fix
nor being particularly helpful.

> But here we're adding duplicate metrics with different names, where the
> new ones are known to have issues. It's not a great user experience IMO,
> but at the same time missing old cores from the Arm metrics isn't a
> great user experience either. I actually don't have a solution, other
> than to say I tried to get them to consider more unified naming.

So the lpm_ metrics are on top of whatever a vendor wants to add.
There are often more than one way to compute a metric, such as memory
controller counters vs l3 cache, on Intel an lpm_ metric may use
uncore counters while a tma_ metric uses the cache. I don't know if
sticking "ARM doesn't support this" in all the ARM lpm_ metric
descriptions would mitigate your metric creators' concerns, it is
something implied by Linux's licensing. We do highlight metrics that
contain experimental events, such as on Intel, should be considered
similarly experimental.

> I also have to say that I do still agree with Andi's old feedback [3]
> that the existing json was good enough, and maybe this isn't the right
> direction, although it's not very useful feedback at this point. I
> thought I had replied to that thread long ago, but must not have pressed
> send, sorry about that.

So having handwritten long metrics in json it's horrid, Having been
there I wouldn't want to be doing more of it. No comments, no line
breaks, huge potential for typos, peculiar rules on when commas are
allowed (so removing a line breaks parsing), .. This is why we have
make_legacy_cache.py
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/make_legacy_cache.py?h=3Dperf-tools-next
writing 1216 legacy cache event descriptions (7266 lines of json) vs
129 lines of python. I'm going to be on team python all day long. In
terms of the Linux build, I don't think there's a reasonable
alternative language.

Thanks,
Ian


> [1]:
> https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/=
data
> [2]:
> https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.i=
ntel.com
> [3]: https://lore.kernel.org/lkml/ZeJJyCmXO9GxpDiF@tassilo/
>
