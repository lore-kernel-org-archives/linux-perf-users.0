Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1561F0E55
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478359; cv=none; b=C4nBlRyx1PbI+jS5G28hmMcUIW/RpHe8mQ/eT8GsIlDNGApF8TC/Jt+6Hm+t2IqWpZlOmkbs/3AyRdFn5TRzMESbFZTsFIc6UGDyRLbG6WbUcLMQr7jRXRRubQW1nbNYtFtx7G31/07sr1tLYhuwwjN5+PL/LUAOmO4HLZJykSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478359; c=relaxed/simple;
	bh=7mxyyL7MVyzak+1aNwGycWcSVQ4tiMe1zte1DrwA6ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNLocBcMk+4/rleqW4UFkw3Ao3kbz7XwYKtCWSILCbuYQYBwIrgqIOFSFZ/KNZLDHkWCe1R2OGG+Vrxm/zMYTCRSvwGcGD+YnC3CyrtZLJQ0r3cOnu3ErCvp73TT8/Ss24zObZmrF3XZni7XXwAUUJClo81ueQCuPbhCL3OyRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2NdPSkA; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2NdPSkA"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so618925ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737478356; x=1738083156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdMHqHkwdEdrk35RgW3takUNGRDO6kyBZ5ZWP7L4ArY=;
        b=g2NdPSkAF3pG/pBRL+DMOEQKo7625erywbiWqscDwmugMQefpJglX4r1PIXZOeOU2F
         Ni9TSzIAiyu6Sn1OHuRMKYCgJhwNfy+k4D26uE6j4KTMhtvEOMjiS5iRX3f8B7DoxDmt
         DEkNHZLPTToMHrPflKEXuTCToY2V9tnf1lV/5Edvb8Uw35DyLrBS/Pr7hTlp1dmkkeVi
         VHkSQXzv2Qw4qXn2fmJEmwuEc6048u8hQbvEAx/j9eQrhk9be1h762EcMH4/NaRRn2e9
         BoGv9nFwyvQ26lc3F54z2k8CjQI+q4Pc7cnS2t4zzHPF0LVXmUOIWQvbp5SRmLUhT+nQ
         gq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737478356; x=1738083156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdMHqHkwdEdrk35RgW3takUNGRDO6kyBZ5ZWP7L4ArY=;
        b=lm86MzIKF/FnJjjbL5NNX0+axyF/oOXFJZIb3EONBsnQ5t1TUEY9cYkM37c5GhqdnT
         VYwtBNztjrwGTYjQHAN+ZCzyQuAURjGeSAi43IpJAH0nlhcF9x8W9EVp+OTwCoZfhhWg
         e+N2o4uJTdxFmy8Z9rPE5z//449mGtHLtmw7ktX/m5X9+CD5Edanpgy9nhlFZRRcIzq3
         OASC36jJW7Iy9J8Egsw6+cBQpJS6jjOrDjQJabxzLfrOaBZxNIn1vLbYhtmm+KclwxUq
         EGzYP2/p07OnT3McicgK0tYWFC8R5TZN478g1esKB/M+yZG3l83we3dPl72eIMlkkWVN
         x3DA==
X-Forwarded-Encrypted: i=1; AJvYcCWljHeHteeBNWbAOmEblv26xnNZz4sUn1niLTJbTW4HczRZu87ao05uAQsDjViG8gA4cFMIS2olWFxyLpr4wPu4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+hmnkqxhb3Mv3QN0iXxgAyEHoYyQCPGPtkcohu+CgMW0JDN3
	s85ikdn1ivSFIxDbYuy6Jx1DZFoVInYG85oK6WOLadLUx++34wITrlDGQvXBqFL1cILAR0CUvnd
	8LHc1Cf92q8M6QljVJf1dC3zXfL6oD2hP4K4c
X-Gm-Gg: ASbGncvUzX1yvoFfrxijCrymx565KamXAV+pgIFQItqVhAL5kPS4PKnV1z0DIbzhwoz
	hIzengGOjV9bjudgifQaYIujsuWore5Ms8x8NaHL8eWBZArU9gdAkRCagzXkF0XOdbj5gSdRlcY
	nCb8k=
X-Google-Smtp-Source: AGHT+IHmxO9ekfZnbmE6Bs7fLm+kad4fug+Sd8hSJAjtC5MGX0sYHnFZGrHDPVQHmeTywqKuDMZuAgszz5pMm3hnqhM=
X-Received: by 2002:a05:6e02:1f12:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3cf827d810bmr9215785ab.23.1737478356505; Tue, 21 Jan 2025
 08:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111202851.1075338-1-irogers@google.com> <20250111202851.1075338-2-irogers@google.com>
 <Z4Us_aB9PNk63MbG@x1>
In-Reply-To: <Z4Us_aB9PNk63MbG@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 Jan 2025 08:52:25 -0800
X-Gm-Features: AbW1kvYxvgjy13SLjdZKQOnoERiY0yxlZ0w_vIpu7Xubnp27cGk8gKqw1dEhWb8
Message-ID: <CAP-5=fWrFGM=TbQ5zBjdBAyDLJhJ48K_6TLHt22jLhnV11OG_g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf build: Remove libbfd support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Song Liu <song@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Clark <james.clark@linaro.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:10=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sat, Jan 11, 2025 at 12:28:49PM -0800, Ian Rogers wrote:
> > libbfd is license incompatible with perf and building requires the
> > BUILD_NONDISTRO=3D1 build flag. Remove the code to simplify the code
> > base.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.=
c
> > index 1fee71c79b62..a891a0b909a7 100644
> > --- a/tools/perf/util/disasm_bpf.c
> > -
> > -int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *=
args)
> > -{
> > -     struct annotation *notes =3D symbol__annotation(sym);
>
> Song,
>
>         Have you ever investigated how to reimplement BPF disassemble
> using some other library than this one?

I think doing it using libLLVM should be straightforward. I sent out
this series to make libcapstone and libLLVM loadable using
dlopen/dlsym:
https://lore.kernel.org/lkml/20250120173208.344231-1-irogers@google.com/
See symbol__disassemble_llvm in patch 5:
https://lore.kernel.org/lkml/20250120173208.344231-6-irogers@google.com/
the difference is selecting just the BPF disassembler, so don't pass a
triplet, force it to BPF.

Anyway, one option following that series is to factor libbfd
dependencies into a bfd.c in tools/perf/util. That way we can try to
have a common interface for capstone, LLVM, etc. The other is to
delete it, which is my preference. I can add the BPF disassembler
support to llvm.c in that series and rebase this series onto it.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
