Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386315EFC2
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971950; cv=none; b=f/c7USY1/g1PG9rBPoVkeKWwd22ezBTov2X6OJwnzsw5gN+e7LsOz/Yq1i+f3U45GHhsD0Nhm2sw+Rrw0HeH13dwPjuMQv10IH3bYD//PTg8HWKh698uYm+d1QppLuY0OFJltBREAOt9FHhkBE69ibiOXMRSQLE11W5wsDE5+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971950; c=relaxed/simple;
	bh=zo6CfEdwy0Z1jFqYaKi4gjp+7PfLdUHzWaLTgeGkHGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsUu+KBvIvxahJmYFF8NALaHNqUuM0JtbWI2astB4ZCH9BRV/pBXdWZDvO22AhLk6sAuLPPk0spybCiyetQc4lgBAOXzzQ0cHA2JYZFFPecCHmcu6kC/MUmve2oW3k5fpX5U0YEdR0zTxu/oD0ahBPk29Ticrk5tbcLLVPdz6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feRz2wqM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feRz2wqM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43989e6ca42so446471cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2024 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713971947; x=1714576747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16IfUr/aDIVyiGDdNYlmv/QESeSDyKp3ic+JdrAeLjo=;
        b=feRz2wqMghEcvfLAvXv1fx904ZD5M7NaI7j0/XiUAQ50ahuo7PkAqIGbzW05QTXNrL
         yeqUwFrPRT6WdDBIdokZfPwYVEUpMAZ3nQtuFxDoPhdk8HmMCAiDspUlPiXSvr1LDTu1
         eUoOhVVvjD533VovQkhcgnQ7O1HeduVuTlnpqoZ/zpsoF9bWpU3b7bEkE3IdOlIAERFe
         YRY0fPpfr2cpYMf+gN5IxTRnC++4FozqgFktvl62Ar7qqdkC9NExjxUo5MCLgP7hV9yk
         5YJfdCdKxIOkGJAKYXy1ohCfy6LfSDH7fod8XYDPyrlJooq+0aN/pgliaD0pKYJdRhrO
         vEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971947; x=1714576747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16IfUr/aDIVyiGDdNYlmv/QESeSDyKp3ic+JdrAeLjo=;
        b=f6cVS5W0Ca2IY/SoYTH1EliWos0cEG8ikIYLVIpIOzqubifBXeKiV4i/NGqYZnnR+V
         F+7gvLTal4VcWV6C85cfJNYtVWSBvhR3NmcZHrYC3uAcca0bbRedT7H7xf/Ti3EJtmc+
         ZrMIdteFC8l+uJiJXwcvkFXqeHLVLHgmq8kCQ2FUYM21K3T9/mMTCZuxOkVQ2zWOlDqj
         9mtG32yMIb/lail5VFSFlQyu6adl1XnVqZGP2I/86rZIoR0fafE4tywkR2PU2b0FbDwd
         758uZN3rugnUGFPtJJk9TxCTl6uVm6Wx6rPPR8ZmUExzpsxvy5MayprrSwbXp1ifx3BK
         qPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu7eaW7aitQ+IU3RbLSCeazQivKbErGShBP/RQaCGiTgbli1tOzsdTWgsN7UEzvyILtoQauXeaa8a+/eDuw4q/6NcMpvvNHk632P8BWoZJ5Q==
X-Gm-Message-State: AOJu0YxACFMjs2MoWXg64OGb8ZFBDAmbDLtRdj0rqtShv3MSEuXm2P2n
	5wPV2vAOCpwDvEccNH9TkmAjW0FGGX2/W6t5dCSsJsuwwETSNksNNhy8RXOK6oNcWt+8uNiOiyp
	umygvjuOkjSMUWhuvcsEZqImF/N6IaA7h3T2K
X-Google-Smtp-Source: AGHT+IEFfX0IrtvdULyN66f10heNy91Xt+GeYOFUXi4nvaPeuN2PAOzDNm7Vw0JcnmVVNOeGCTZgBZtFwdAB2xtB2ts=
X-Received: by 2002:ac8:1286:0:b0:43a:2e2b:eec with SMTP id
 y6-20020ac81286000000b0043a2e2b0eecmr169202qti.2.1713971946704; Wed, 24 Apr
 2024 08:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com> <20240416061533.921723-14-irogers@google.com>
 <e8147f53-1930-44d8-abb8-fee460ec355f@linux.intel.com> <CAP-5=fVXv_gsoq5L08gaEJvU1E8xoihc3-L4taA+bPHyOJfgqw@mail.gmail.com>
 <7df3ff63-a421-42cc-bcaa-b0254ff6a0e8@linux.intel.com>
In-Reply-To: <7df3ff63-a421-42cc-bcaa-b0254ff6a0e8@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 08:18:52 -0700
Message-ID: <CAP-5=fUi8DPNrbp=978K92Mopa71ag1sukttX3KcztD2ac0ADg@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] perf parse-events: Improvements to modifier parsing
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:20=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-19 2:22 a.m., Ian Rogers wrote:
> >>> +             /* Simple modifiers copied to the evsel. */
> >>> +             if (mod.precise) {
> >>> +                     u8 precise =3D evsel->core.attr.precise_ip + mo=
d.precise;
> >>> +                     /*
> >>> +                      * precise ip:
> >>> +                      *
> >>> +                      *  0 - SAMPLE_IP can have arbitrary skid
> >>> +                      *  1 - SAMPLE_IP must have constant skid
> >>> +                      *  2 - SAMPLE_IP requested to have 0 skid
> >>> +                      *  3 - SAMPLE_IP must have 0 skid
> >>> +                      *
> >>> +                      *  See also PERF_RECORD_MISC_EXACT_IP
> >>> +                      */
> >>> +                     if (precise > 3) {
> >> The pmu_max_precise() should return the max precise the current kernel
> >> supports. It checks the /sys/devices/cpu/caps/max_precise.
> >>
> >> I think we should use that value rather than hard code it to 3.
> > I'll add an extra patch to do that. I'm a bit concerned it may break
> > event parsing on platforms not supporting max_precise of 3.
>
> The kernel already rejects the precise_ip > max_precise (using the same
> x86_pmu_max_precise()). It should be fine to apply the same logic in the
> tool.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/core.c#n566
>
> Will the extra patch be sent separately?

Let's do it separately. I'm concerned about the behavior on AMD (and
possibly similar architectures) where certain events support precision
like cycles, as they detour to the IBS PMU, but not all events support
it. The max_precise should reflect that AMD's Zen core PMU does
support precision as a consequence of detouring to IBS, but maybe
things in sysfs aren't set up correctly.

Thanks,
Ian

> Thanks,
> Kan
