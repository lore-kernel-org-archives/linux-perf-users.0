Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6782144CD
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995056; cv=none; b=UiXH/TDKg8j73gB7pRqEapwOwbMmHw2SwEtBjv1z8dROHSOOk4V7NcgahZeCBVrplIQHoC+LM4VwR4Ma0g1G6zXL62vJp9yRYlMkxsFwQK0elv0ejnunGic0NsoNVSjNoIXsKYd7qaFvmJsFRzzDeSQNh1z/BOjEee8YKTdc+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995056; c=relaxed/simple;
	bh=dkho66LvqDZBbZAtS2Bh1yyXAiAU3nt7Z/Ca6INmHfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N66QOw7kRFfk7U9MZGr8vyPsbbdStZXQf71sCnk/pMvERwCKUMRK6A5Pe5gYoHUPvhHvhbIpbq+ch9Pe/EC5SbQFX9RvNstNbJ0H0hQeNGKGd6cQq9c7n3/quVHzdhpKseSuRsG+oSsG9Dm5Wwl9DsDeR0x0qgO4opc36tyW1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8zVS9q5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8zVS9q5"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b295b9eeso227811cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730995053; x=1731599853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+7ho61/oAoiWQbCyZG6AJoc8iLMZGuZ9+96uL2SaXc=;
        b=r8zVS9q5gHrNbDktJcNrGrCqjiNGPjXAVNPYPINKICUp9P0hewoH2L4ICLjHkdM69r
         TAA/tDCvrWodu6H9Bri0vqa9b7zQEQEOMr+TGn+P65LwxYamkTnv+xvFuEyqTNqyuvVV
         TXz2cPwxd4m0LsrxSfs5nievL+1DTFsDrukhug+cmdN3cv7Cs0A+3MU9/VhS1KkFQ/8p
         Of7b8rzY/ip6OL/ekMzstz3QDrzlUAcrsRXnkaxYVu/GRcoyydHtxAUYYLtEW3VBo3at
         GQFvm1NXSeHYk5LXg4wfvnBvUrJisJH2w9AdY44muNrzG5o7bNrHq4d8+ZIShIUjqnXN
         pCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995053; x=1731599853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+7ho61/oAoiWQbCyZG6AJoc8iLMZGuZ9+96uL2SaXc=;
        b=IAEk2+EsE9VPlY1ZAIBtrKcvVPVhTXKId3VpLNBjE+43aZ7nLBb5Xz7m4jcBCnvfOw
         x3R3llajkCTXWjouUCdg9VWvzrFMQNJdEN6iHgaDAgEVIoWQyG+MxhgrSe8ZexIcgcEQ
         kq6OuzYQhNGd/QADQZda5HFL3sTeQFlBQbhEo16MR+rp5CN8i26JZHDINnmVP+pTGFVH
         CMHiMdW6P7Hk6DgG6Y/I0wad+r/y5CIjJIGX8hSyRTPL+KU1qJynts7reSrQeTQGZzg8
         HkLZrqf1UK0FWRve9uWJnLUql3skk+tX/WKxtK1g++MUD3nmq0ggtjJLOvCeT/UjNlGk
         QgIw==
X-Forwarded-Encrypted: i=1; AJvYcCX4E31P6hOCEohIM1Oo953fvEk8zDU/vX0Jke8lEnyi8NaevHmlZbe8Z4mym4WEqbz7Uup75d9R0zAw6/BGJPdQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzre8Dhl+dgrzzTJTwNFY7alkmX8sNIhu71PvAbJoaFTkKdDsNQ
	60uQ8zQcdlDuu3RwF4VYPcHgXA+/+gre/MCBvQjE1hCxovyEFVBbhIn7BMBtPr/i/mZ0SecfJia
	nBK4q1DgWUvcxohidnJ7pFbyqk51r0bV/gQqx
X-Gm-Gg: ASbGncv4Wqiz5P8qi3F1dh6UFoMg5WVmapNfpjzwHjt1EgKB2CN1Whc6ZuTUdYzeTEF
	aAW3Hc4jCSODyhSB6RznGBz3at9CJ6fLZS96NzRATGDcUJTx8aX/JUJ1c7CpkmdY=
X-Google-Smtp-Source: AGHT+IHVKHBvB2cCzxWI5DhXsQxE1wxEcC6cL+BUBfk+cOX40yCQNgt2BOrt/ugueoPHNZE5j5DaoRIma6XSWf55aH0=
X-Received: by 2002:a05:622a:4e8f:b0:460:3f4a:40a1 with SMTP id
 d75a77b69052e-462fa5a3211mr4869671cf.13.1730995053179; Thu, 07 Nov 2024
 07:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com> <20241107082807.ipb7xzqvs24tto2e@hippo>
In-Reply-To: <20241107082807.ipb7xzqvs24tto2e@hippo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 07:57:21 -0800
Message-ID: <CAP-5=fXn3GSR88=UVqZ6zxsuv6s+ZBMGY1A0U8D-_oU4sm10kQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Refactor cpuid and metric table lookup code
To: Xu Yang <xu.yang_2@nxp.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ben Zong-You Xie <ben717@andestech.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:05=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Ian Rogers,
>
> On Wed, Nov 06, 2024 at 11:15:53PM -0800, Ian Rogers wrote:
> > Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> > lookup:
> > https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.ya=
ng_2@nxp.com/
> > These patches remove a lot of the logic relating CPUIDs to PMUs so
> > that the PMU isn't part of the question when finding a metric table.
> > For time reasons, it doesn't go as far as allowing system metrics
> > without a metric table as a metric table is needed for metrics to
> > refer to other metrics, and the refactoring of that resolution is a
> > hassle.
> >
> > Ian Rogers (7):
> >   perf header: Move is_cpu_online to numa bench
> >   perf header: Refactor get_cpuid to take a CPU for ARM
> >   perf arm64 header: Use cpu argument in get_cpuid
> >   perf header: Avoid transitive PMU includes
> >   perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
> >   perf jevents: Add map_for_cpu
> >   perf pmu: Move pmu_metrics_table__find and remove ARM override
> >
> >  tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
> >  tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
> >  tools/perf/arch/arm64/util/pmu.c         | 20 ------
> >  tools/perf/arch/loongarch/util/header.c  |  4 +-
> >  tools/perf/arch/powerpc/util/header.c    |  4 +-
> >  tools/perf/arch/riscv/util/header.c      |  4 +-
> >  tools/perf/arch/s390/util/header.c       |  6 +-
> >  tools/perf/arch/x86/util/auxtrace.c      |  3 +-
> >  tools/perf/arch/x86/util/header.c        |  5 +-
> >  tools/perf/bench/numa.c                  | 51 +++++++++++++++
>
> Meet error when build perf tool:
>
>   CC      util/levenshtein.o
>   CC      tests/mem.o
>   CC      util/mmap.o
> bench/numa.c: In function =E2=80=98is_cpu_online=E2=80=99:
> bench/numa.c:550:21: error: storage size of =E2=80=98statbuf=E2=80=99 isn=
=E2=80=99t known
>   550 |         struct stat statbuf;
>       |                     ^~~~~~~
> bench/numa.c:554:13: error: implicit declaration of function =E2=80=98sta=
t=E2=80=99; did you mean =E2=80=98strcat=E2=80=99? [-Werror=3Dimplicit-func=
tion-declaration]
>   554 |         if (stat(buf, &statbuf) !=3D 0)
>       |             ^~~~
>       |             strcat
> bench/numa.c:578:13: error: implicit declaration of function =E2=80=98sys=
fs__read_str=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   578 |         if (sysfs__read_str(buf, &str, &strlen) < 0)
>       |             ^~~~~~~~~~~~~~~
> bench/numa.c:550:21: error: unused variable =E2=80=98statbuf=E2=80=99 [-W=
error=3Dunused-variable]
>   550 |         struct stat statbuf;
>       |                     ^~~~~~~
>   CC      tests/cpumap.o
>   CC      tests/stat.o
>
> After remove these errors, my issue is disappeared.

Thanks, I'll fix this in v2. I'll also add your patch to the front for
the sake of backport fixing. If you could provide tags for my changes
it would be appreciated.

Thanks,
Ian
