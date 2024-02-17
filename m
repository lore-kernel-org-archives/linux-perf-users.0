Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC64C8F
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Feb 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131167; cv=none; b=AjOXgP0vswqrFSBLoOS6W6ZiI64ErmY9B+vZWdIj2j0QpNLsoQsJdY1cv9OLjw6eHCY8Yoc4om4lezTLJcjospiOeCb+CMUOJPO1FvObphLqhfbaSayVJgt36KAzUWK1yByFWkUW0JwCAX2496x8JiMZLCYTTylQidu79GnqN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131167; c=relaxed/simple;
	bh=xMjUVfiyxmaguXvZrW6crG3aoQIwn8QnYYLwV+KSSWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjGmt6tnmNmPIty9/m3B8ZoHPOF7x3NWlqYTS5qgT3hbzAKGKRyQte7NMhyoInW1j0+YJew0lFANwVnbMs973BhqU2HMMqArzqmTRUlXUBootETy6t8SMeLK4BiLIn+C4nj9y8mrjI7FyQqG+b2xHrd+64ufbAQ3fBmL3JQ/8Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVfEHcpu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVfEHcpu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1db61f7ebcbso39535ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 16:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708131165; x=1708735965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvr57WXSGKgreDl2S3+cS6Q3DlJ9MFO+tZDONyxR8WE=;
        b=pVfEHcpu9cuLDlTbA+B73bEzwdSAI33O59xw1XUAjm+2D2RkU9FhRwtiOCZjT6ONmO
         ITGz9nCbcps+KSWsv8DUSqlo1PfN4HqtS9FswiKLIw4aPZELISMRKWHQvz2tC8mpvvsw
         0giSomXQOEjZQYjpkEE8wOT2VVrl0dGT5MZn4XxAolJpH1PdZRvtj2A40rMh7B4889RC
         UuiaKXm0GX2v+KNcFb/ERPMvQCxHJTH5+l8t+Oz1pq5j5Acsl6aMzFwnRE7gvyYORY9Z
         8qp1BeVLyJh427UCoeqPgWrZk0MzF6GaTaqJJvxmhyLRi2rk8HPXtN+7iZkjiXxYxSjC
         TBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131165; x=1708735965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvr57WXSGKgreDl2S3+cS6Q3DlJ9MFO+tZDONyxR8WE=;
        b=r72Zyc1u+lMO+JkltfNJBiYq6I1wea+Eh7DjKuZ9yl9KNvBQ6h3BbmC2Fw6Vcyx3sn
         rrbw5IrVkHTLYDCHZQX1WPQk0EME0gmdfed/qvudMHLum9XMrha2Ak62dAiAmCNUZyV5
         Iwsu/zh+9xQyLxh8MbszxTFlz6Hq+X00ezS4e7o1h0IyhCxnN7mJOfLiFvFK/1RFfgj7
         Aw/G+Bje1qPYxjgjvSAjO8wFVmSfXJXJqXwpmIzR0SvvbYwdpE37g0DB0oMP+9K3MEow
         HFUbcEh61QwvkE2eHP18oCGFoDN5Il2rliyuPfHjlhlwIJkxYpPC/MlLgnXCvSF1nIDM
         dMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAjs57kRMAWjsXJpJV2cBlaIBTcXnhKogC9VO91adpxszSYEBo7BdQ+fO54yH+gX5G9KwsfNCtelP5W2UMzzb4bdbKPY68O+3LKzqSF8r0fg==
X-Gm-Message-State: AOJu0YxdUEsw2NWXvACSfeM4p29RL13xl5Vmh64Ak1JqQKpEEUJAWgXU
	cooSYjes087U3Nv4G9ylcSRdYqC4xWaEKPzFnQ9TdyugElE+X8Wi6QWlfoq4wjlY8UOFPOoZ4xm
	wlT0voayj8OeTQQ5te6CldMMhmNcuzg6TwIez
X-Google-Smtp-Source: AGHT+IE3HGUrOS/cMjy3dK83NQcHQ7z42RJxNSfu2ZjNKxNaIs4MfqHN+ZrLaeTNVN7unFneCe3UnNRtF7B+qxo7VzY=
X-Received: by 2002:a17:902:c70c:b0:1d8:eac9:bbfc with SMTP id
 p12-20020a170902c70c00b001d8eac9bbfcmr98349plp.15.1708131164390; Fri, 16 Feb
 2024 16:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <20240202234057.2085863-3-irogers@google.com>
 <CAM9d7ci3VO7reyxPc8WOczdoyYYCUshxCJDMZ7wPpHknCubNXQ@mail.gmail.com>
In-Reply-To: <CAM9d7ci3VO7reyxPc8WOczdoyYYCUshxCJDMZ7wPpHknCubNXQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Feb 2024 16:52:31 -0800
Message-ID: <CAP-5=fVNLoes2VaCcqrueiDLBZAZNthSJVD17z77cnyE7wF7ag@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Potential corner cases could cause a cpumap to be allocated with size
> > 0, but an empty cpumap should be represented as NULL. Add a path in
> > perf_cpu_map__alloc to ensure this.
> >
> > Suggested-by: James Clark <james.clark@arm.com>
> > Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a81=
01@arm.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index ba49552952c5..cae799ad44e1 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, =
int nr_cpus)
> >
> >  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
> >  {
> > -       RC_STRUCT(perf_cpu_map) *cpus =3D malloc(sizeof(*cpus) + sizeof=
(struct perf_cpu) * nr_cpus);
> > +       RC_STRUCT(perf_cpu_map) *cpus;
> >         struct perf_cpu_map *result;
> >
> > +       if (nr_cpus =3D=3D 0)
> > +               return NULL;
>
> But allocation failure also returns NULL.  Then callers should check
> what's the expected result.

Right, we don't have a habit of just aborting on memory allocation
errors. In the case that NULL is returned it is assumed that an empty
CPU map is appropriate. Adding checks throughout the code base that an
empty CPU map is only returned when 0 is given is beyond the scope of
this patch set.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +       cpus =3D malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cp=
us);
> >         if (ADD_RC_CHK(result, cpus)) {
> >                 cpus->nr =3D nr_cpus;
> >                 refcount_set(&cpus->refcnt, 1);
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >
