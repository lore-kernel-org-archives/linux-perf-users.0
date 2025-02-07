Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09A18DB0A
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947252; cv=none; b=FHhUYJbd4Wbodv1uf18SS/Ei6VL3YSA2g7T7qGJlV+zR2N16WMjQj+70K8KRcRTNLLZUZqJNAPa0TI6ri4eAr6YQiiAa8wN49MJYZ17l6l2Jp3iCGFvc9pXo+MJcWuIfGQbeclT2uufWuVZTOwO2FyOrzEjWvyfKWrwu8C3Bysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947252; c=relaxed/simple;
	bh=RBG51+4Lfr8vrZH4BvUqvMXfCP96AceZstCxlo2AYWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjrVw35qQ6KQtOCVJgsy5SDNm9WmOTndCUSWw3BiC+l2q/u4OD3wYYJZIf4yRiPTrFHsssPkZG8NnT+j4YuswbS2didO4vvXDShpojZ4y5UDaotJQifGyrUyBp+doWSPaS8N3rDivCmHdWYq6sgRvt2fJ3rcdW2zrYlEdOLVRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FScusrU6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FScusrU6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166651f752so52457065ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738947249; x=1739552049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UvshL8nXVJdd7vp4+YSGo25p1rD7pCcETOL1e0fbZQ=;
        b=FScusrU6GtU2JbOsxqOOu2ijBPENshOfq6kNCSn+EvDcOrm5JAecHIRHlMJ4hV+n6p
         5LlmEcqlH0XwH+uZTsHuoRvdKQWIMYB4Cyve03u0VB1FKwT7YkA67l+m97WeYKQEGLqQ
         8h4JhVBR9MMFTq9Hb8hDBBM6k4jTQG+GEDuexm7QnFxyR7M8ACM2yF3HEqJMvilcG4Wp
         hWa76er9zQadEYnS/JH8pJKJpHyqNTzDHFe43kd6q97jSTKJTGzFZ2b7zTv4q/mBnq+w
         TC/caD9UYZDoQDzry5XxrtJsguX9jQqYykIoKTpw6/7QcMdnAu1rr8aecII0iN4kSOqp
         068A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947249; x=1739552049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UvshL8nXVJdd7vp4+YSGo25p1rD7pCcETOL1e0fbZQ=;
        b=BFDqftOTh+joXTgg/l2/OLX0uIK8VZlpBxG6ZY1Nola3VuXRliekq8zc2TOuLEG0YZ
         NZK9qjztuFLIHGGD/2lBBdIbjVUdi879S6P/1ttxm/9d3XrXlvbJxI1YhkEuryc7B1JI
         NDNwkgg/x8ZVKTPgPkljKFvYPEuNOym/0gdtlxj6FEB25OpA54nJT1zRCvm6/qpLY47k
         nQnWiFEJZfGhqQxaaazk5lyaNH7YkSYjCOpVjUbXL4pesm49GqjcX128I9tA79LvvwSN
         f9kQs1WTRlLuLr2xLh4HmHN0nLLkXyWFpGz1Ft7sb6EnDR5JMbwb1SRJcSQzbpN3qhUs
         htpA==
X-Forwarded-Encrypted: i=1; AJvYcCWEN3tXnfZRTM+TQfcAcaWYs4RX9qPUpvS7tiYy6t4FLGgF3wkHvGvRvtLAGyuRTWyA/fiIP8yfCosjHnpYlhqC@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqy7S+I/dFGYs9p0t3M3ZsYZQ/7FEl8Zi0SRdskkLr2e34yMu
	KLcOT6JRfk2VIHjRyXNyIBenH+A+iWn8O87etmbKFZB6rZDKkdsHn0EvLL50/Rq5H33JTnZy04I
	Dis0ssexSg/Iw13ILGlpmeUSLdsvVOMvgn70afA==
X-Gm-Gg: ASbGncvPEOoqP92hHzWDcxD3jcXuNtvAaNH8iDk3S8ODePMIW0IBKVFjuzEIThloWtX
	udsb/NMgWsLa2K2PNnHaAztkC9xoJ76SYM8Y8AWzVyBPfPdQoCZVF+uMFNUgbH2q9qJ3AW79Gnw
	==
X-Google-Smtp-Source: AGHT+IGcOreyYzVTdgMb0QBe7xfS8Hq4n/vBf0b22MVHxkWExD11jxox3l4GddXf+HqClKoe976BaxK99Tn7Vq/+DBg=
X-Received: by 2002:a05:6a21:3399:b0:1e0:d4f4:5b39 with SMTP id
 adf61e73a8af0-1ee03a9b0afmr7073525637.24.1738947249048; Fri, 07 Feb 2025
 08:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
 <20250205-counter_delegation-v4-11-835cfa88e3b1@rivosinc.com> <20250206105100.GA2971@willie-the-truck>
In-Reply-To: <20250206105100.GA2971@willie-the-truck>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 7 Feb 2025 08:53:59 -0800
X-Gm-Features: AWEUYZl2-SoqDPQ6r-GdOfUPJBX1qdNjRlIcNpQpRwZeLOQULWh9MTRajFVfra0
Message-ID: <CAHBxVyEtxoRHLO791r6uFzHnX0vAcpeWMOcS+0tbVN+p6Oh2tQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] RISC-V: perf: Restructure the SBI PMU code
To: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:51=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Feb 05, 2025 at 11:23:16PM -0800, Atish Patra wrote:
> > With Ssccfg/Smcdeleg, we no longer need SBI PMU extension to program/
> > access hpmcounter/events. However, we do need it for firmware counters.
> > Rename the driver and its related code to represent generic name
> > that will handle both sbi and ISA mechanism for hpmcounter related
> > operations. Take this opportunity to update the Kconfig names to
> > match the new driver name closely.
> >
> > No functional change intended.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  MAINTAINERS                                       |   4 +-
> >  arch/riscv/include/asm/kvm_vcpu_pmu.h             |   4 +-
> >  arch/riscv/include/asm/kvm_vcpu_sbi.h             |   2 +-
> >  arch/riscv/kvm/Makefile                           |   4 +-
> >  arch/riscv/kvm/vcpu_sbi.c                         |   2 +-
> >  drivers/perf/Kconfig                              |  16 +-
> >  drivers/perf/Makefile                             |   4 +-
> >  drivers/perf/{riscv_pmu.c =3D> riscv_pmu_common.c}  |   0
> >  drivers/perf/{riscv_pmu_sbi.c =3D> riscv_pmu_dev.c} | 214 ++++++++++++=
+---------
>
> This seems... gratuitous? It feels like renaming the file could be a pain
> for managing backports and renaming the driver might cause some headaches
> in userspace.
>
> What do you gain from such an invasive change?
>

The current upstream driver was developed only for SBI PMU[1] due to
lack of any ISA extension support that allows PMU programming from the
kernel.
Thus, the name of the file and the functions reflect those assumptions.

IMO, it would be confusing to use a driver named sbi that also uses
the new ISA extensions that allows direct PMU programming from the
kernel.
This patch allows the internal functions and structure to clearly
identify two ways of PMU programming.
There are more PMU related ISA extensions planned in the future as
well. Thus, I felt it would be best to do these changes now rather
than later.
I understand that managing the backport would be a pain as a result
but I didn't quite understand the concern about the userspace
headances.
Can you please clarify that ?

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.=
adoc


> Will
