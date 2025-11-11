Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21B272801
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884114; cv=none; b=D4lGmkKUPUWb5eNV2t8iqeDYLJoisgEqIU47GPfEwyuWxDa8q7s0L5ysUztSy0Odj0LWwWIr591wpk+Z2iuexErS0bgx4ta3v3jbwzw058UzUM6m7bB9GbhLxcyWMYsDnqabxbaGhUFrqQhnTG23RZ1dqo0d25qGw/P/8KttBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884114; c=relaxed/simple;
	bh=POx07xgO19fjd2of5y/PICQ1dU681FfqtcMrZwKBY5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orrZ37QuPYvj79xVmOiLzJPnNfhND5L+PohSdLgLS8gSu4g12gpm+CWZnxC8/Oc85+G2M6/fGWtJCtzwCmxE0+l/JLKDGp93698OJYoMv4RwPirItSKLUMaK/+o+snsnq47H5C+a3K5b5gArYNX0gdYvOtJs9b8aWDAsegxaoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSggIIrt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSggIIrt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2959197b68eso3565ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 10:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762884112; x=1763488912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj3oD85/fF4h5DTo6ut15zDZ0vkRj7B3cZojmVYXkZo=;
        b=zSggIIrtaiRWKpB4J+DY3xSg6E+RQFzHDXA7P76UjaNnEpC1fO+3xayXZzq4Dv3Tbc
         Y9GfIehx/N3ZIbDsIvlIfLG7b+fp6tIkoFaYoqXhtz2+R3yFg+yB+JYlzcKZI4Yw/TKZ
         ko41ichxXncrAJUfpOAtega99Yy6pah384EUQe3+EpxO79MR+zPzzHodqw3utMgCerSe
         PuOmusgThYWXs7Xlsh1m7kiALNBqLem4Zsh4b93VF9emeUObAob3T57WLIQ65d1dZaFb
         wr84pB6TWPzXv1wfZf5r4Z+aAEGIBazmHYZVfkkNGC2l1laCjkZxBayawHqSh0ZQUMi+
         1AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884112; x=1763488912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rj3oD85/fF4h5DTo6ut15zDZ0vkRj7B3cZojmVYXkZo=;
        b=J/8PZEAGsfOpXN8xDgrkaIWtcQCRW2gyOPYRUrTHL/xNh9ANeh6gJyk2oCVMOiDWY6
         gEVPGqZCqYFjoBJ7eoLTvlIRqlWl0UeCm6Y25ygeQlZ8AsZrgr/ovODKSiZlpLFbj5Cg
         6eM51kMYDYELVKEMD3pxPJPS7x+WNrLxbwHwkZLCqmtOKUSTTGysIdHJGVtFtGdyNx5c
         O6ZywTRyHbvXUHRJgC+uDlEEAgFmTIAEDKD+u0NgoaPqR+yZniuJRR86m4qmbPX/fgUD
         BSNA8yfJHx9++9X+opx0eCihRN2qMmmSw78S8uKQc0yXQYwJCeH7oFNSJPwdUMzEVQ5O
         W9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPb42yjZEVgJL601ieI9t+Kua03kQZIukab5VJGC7xZPJhmqU8mXo39aGhcxW8SG9LtcrFsvn6QQvScdWot2H@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5VjFhLaAzsUcK+E8WnPnydH2ZNZZj+W93rIvV1fuLazO4m/M
	vku6DlJWrlvUCx2IQuLFH8lGrkKQcqk+vE3CfZLG6/lHLFO7cqUcAyx89XUBmm7XMCcoy/8CsId
	gPlg6M9K+yrQGo0PQrc5UJav3mfPs2bYbNgl0YeOt
X-Gm-Gg: ASbGncvEN29eIfFTUX1MQ8fiDdBcvLlNsYZ+gST37X0vpnAXpuCmEJkJVK4i9LyYoQy
	+SHVXrphVtjjMSlgxIQnuXt791ws/JA6fkbuyw5fgVBwiMueG8qYb+xqicz1A8dsIbAyTm1cXu1
	8tXgTE10oQxYDGlDfq9XUTD0hojhBSmtlmKgpG4f5INaOJNMWacFH4gVAOae5nGeh7mcfiMc1Vp
	i775G6zrtgyQ2KFuCqhlA8C+94bvZpKxeGJlcUkrSOMOu0A9wdgmXJegfhJPnfhZBT4lUNrJ/ap
	+NDNKEtVB3j2HI79fPEt8Q0QvRkV05ivLX1n
X-Google-Smtp-Source: AGHT+IEaYfD4+h5i0LnDfGy3StP6alCdbAGrRzBT449Gnul1EibX1V26xrhMdWylATmgLhu5TZsvpqxt9mZxeWG4ecw=
X-Received: by 2002:a17:903:1a6f:b0:298:4819:f4d9 with SMTP id
 d9443c01a7336-2984819f64amr1468145ad.8.1762884111278; Tue, 11 Nov 2025
 10:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com> <aRLV50z1L9A3YRFF@google.com>
In-Reply-To: <aRLV50z1L9A3YRFF@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 10:01:40 -0800
X-Gm-Features: AWmQ_bksGFltkNtn8RNtUeEYKdYbTBJDmTCEeYnwmeaDQvhSPtYZgO3gbyAEAPI
Message-ID: <CAP-5=fW4XSL_tAD9-BzG9ceUJSr005bWi3Q1-kiJ_xyiHJZggg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Remove NO_AUXTRACE build option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Tomas Glozar <tglozar@redhat.com>, Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Sun, Nov 09, 2025 at 05:31:47PM -0800, Ian Rogers wrote:
> > Switch the __get_cpuid feature for intel-pt to use the provided cpuid
> > function in perf, this removes the need for NO_AUXTRACE when the
> > feature detection fails. Remove the now unnecessary feature
> > detection. Remove NO_AUXTRACE as it just builds a more broken version
>
> Can you please elaborate what the broken part is?

Sure. I'll summarize what alters in patch 4. NO_AUXTRACE is
controlling 3 main things:
 * set up of aux options for PMUs (code in the arch directory)
   * ARM: coresight and SPE
   * Intel: BTS and PT
   * PowerPC: VPA DTL
   * S390: cpumsf
 * support for decoding aux events (common code that can be
cross-compiled assuming other library dependencies are available)
   * ARM: coresight
   * HiSi: PTT decoder
   * Intel: BTS and PT
   * PowerPC: VPA DTL
   * S390: cpumsf
 * Tool support for aux buffers (common shared builtin code):
  * perf record: aux options for events, snapshot, aux-sample
  * perf inject: aux events will fail the entire perf inject command

So somebody with a NO_AUXTRACE build would generally experience a very
sad perf command. Having the option made sense when there were feature
tests that could fail, but possibly that should have just controlled
not compiling intel-pt. Having the option is extra burden on
developers/maintainers, as shown in my comment:

> This was prompted by needing to make a v2 patch set of:
> https://lore.kernel.org/lkml/20251107170712.2302714-1-irogers@google.com/
> due to a broken NO_AUXTRACE configuration.

Somebody may have been using NO_AUXTRACE as a proxy for not having
some library, but I don't see that in the code. If this is the case we
should add the appropriate feature test, ..
Not having NO_AUXTRACE may have been a bug work around for someone, in
which case we should work to fix the bug. Again, I don't know of this
case and don't see it in the code.

Thanks,
Ian

> Thanks,
> Namhyung
