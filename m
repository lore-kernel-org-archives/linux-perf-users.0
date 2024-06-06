Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD613E3FF
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665663; cv=none; b=kMj4cjEud+4/T59LJUiReYl03ZAHw/BPlDisfmUKnwAbm2H25BC6Q4y17tne/Sixt2X/Lzj/TsZcMtSdPm61Cv8zMoKA6Xp8q+H5xBKxLY7D/KKWufrNId1lQAvvojYMCdbF616cKZVeeukkZ6I/mMClY5XF/79eDGcf8Er8P58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665663; c=relaxed/simple;
	bh=WSjcwc3qIu3YfJ++yrfMiL6FsdH4/JsJR+KDt7ie71Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSZU6kBvdOkLYzArVEKhn3w1WdSzT+yISC68bJ8DIKUj06vXzzKLq0NFLrNcCdsyhUeB0pQkt0PO78iuwOY4gocLoKyHCCxas/OiZd7DXf3yTKOnHD529wbuJHiDhHbe25rmYb5Qxpd8G72l1NQQFc0F1YnxlX+45IcnTcGn4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ALwb9oLw; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ALwb9oLw"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37491216a2bso3335915ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2024 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1717665661; x=1718270461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdJFT3+u1sx6Ka9DdK4imlo+hWjtAf82CvjoDoTozfE=;
        b=ALwb9oLwUayhyeuHaZ1QdR+xZQcNVjK91coIMe7HNz/8PtxlOdwyTBPQwbkkz61QkX
         SmqVP6YBk5weIFX2GPdrQrLzJLivG1WhQHJvINC+I01u3eWjCDDnoZENx4xdA6R9HOFy
         g1PIy/vQ5a4+NVfvM8QNeLvzrLDojnLOz8UhF8EY0jLT1/obU9EkmmJoK9QSfCS5rEzQ
         77kXUOAzEqoMG3AHNdjuA/YFAi1ZdkHhGp54bh4d2gpSSPy9s0yPrq7OBswCXWzNY7Wu
         iiIgCZvn1/5W734LYT8CEuvDKhnn1/xNn9P+lfu5LSh5G40gwQlr9AOgKh8Iv21/iU2Q
         EzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665661; x=1718270461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdJFT3+u1sx6Ka9DdK4imlo+hWjtAf82CvjoDoTozfE=;
        b=bZwTSWDxp4ps8/oeptousG248Po0RTesuyPT1nn0z8QAYZGgzMQbG2XdGfYMSBV0PK
         GfkEULAGjjA2Y2UUIMirQPmh6XuVWmMiulMqcaVwpypis3lqhm+N2KZiR03fOJVWVZfw
         26Ju4kLoV8C13rHzdmrvUi+p4hlvptXo5DnERfwDRUmRPIaDiKDvrmOih3RYfUtfX1Dm
         rp+13kRExOfb3yPvGcTSVZuUYCIb1Dmoy96nYC/hpPqbiER7mIfFUnh3QySew/QJVoU9
         +ZdUw1wmqxJYaziMl51YpR9mLNc1NitJcWo9WNKp6BnbToCtdQZx+o+znmq/GfVhY5oq
         LfFw==
X-Forwarded-Encrypted: i=1; AJvYcCURV72Abskbu+qPLkFeF/+1ma0Ft5gdvNZck5RMfvgR3m8NmbgWeF1E9GdQcLI4J1uvcKPAlliH+QfbGJ708uGhLCwb5ZSxLFyjWpfRLW2d9Q==
X-Gm-Message-State: AOJu0Yyj+W9rrB+Y7Ozi7E0RV6iBLCaTYwH+QqAcXnJf+mJodR8ajHAD
	em841A5lvP85JiKJPOdWASAv56ugkucvDWIcP44xss/KmnnmaMHedB5yHWBtBT+02ozSgsDmW9j
	XbkU6J9eUSlVOzRpP0brRTETTpnlzoU3nwB/LMg==
X-Google-Smtp-Source: AGHT+IE8YaOoLCQa7Dozfw5ABFzfn4U30/iv1AHjlqK24vEsauUk0R4EPjGHHwgvhsSuZpl+WSU9M4bDGfvRA8iArzk=
X-Received: by 2002:a05:6e02:1fe6:b0:374:9cdc:7a3a with SMTP id
 e9e14a558f8ab-374b1ef4a7dmr55256965ab.11.1717665660959; Thu, 06 Jun 2024
 02:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
In-Reply-To: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 6 Jun 2024 14:50:49 +0530
Message-ID: <CAAhSdy0+174Mgiw=bD8SENFz8+izE9wy=ABM_MiuvH7Wjhqf+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf kvm: Add kvm stat support on riscv
To: Shenlin Liang <liangshenlin@eswincomputing.com>
Cc: atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:42=E2=80=AFPM Shenlin Liang
<liangshenlin@eswincomputing.com> wrote:
>
> 'perf kvm stat report/record' generates a statistical analysis of KVM
> events and can be used to analyze guest exit reasons. This patch tries
> to add stat support on riscv.
>
> Map the return value of trace_kvm_exit() to the specific cause of the
> exception, and export it to userspace.
>
> It records on two available KVM tracepoints for riscv: "kvm:kvm_entry"
> and "kvm:kvm_exit", and reports statistical data which includes events
> handles time, samples, and so on.
>
> Cross compiling perf in X86 environment may encounter issues with missing
> libraries and tools. Suggest compiling nativly in RISC-V environment
>
> Simple tests go below:
>
> # ./perf kvm record -e "kvm:kvm_entry" -e "kvm:kvm_exit"
> Lowering default frequency rate from 4000 to 2500.
> Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
> [ perf record: Woken up 18 times to write data ]
> [ perf record: Captured and wrote 5.433 MB perf.data.guest (62519 samples=
)
>
> # ./perf kvm report
> 31K kvm:kvm_entry
> 31K kvm:kvm_exit
>
> # ./perf kvm stat record -a
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 8.502 MB perf.data.guest (99338 samples=
) ]
>
> # ./perf kvm stat report --event=3Dvmexit
> Event name                Samples   Sample%    Time (ns)     Time%   Max =
Time (ns)   Min Time (ns)  Mean Time (ns)
> STORE_GUEST_PAGE_FAULT     26968     54.00%    2003031800    40.00%     3=
361400         27600          74274
> LOAD_GUEST_PAGE_FAULT      17645     35.00%    1153338100    23.00%     2=
513400         30800          65363
> VIRTUAL_INST_FAULT         1247      2.00%     340820800     6.00%      1=
190800         43300          273312
> INST_GUEST_PAGE_FAULT      1128      2.00%     340645800     6.00%      2=
123200         30200          301990
> SUPERVISOR_SYSCALL         1019      2.00%     245989900     4.00%      1=
851500         29300          241403
> LOAD_ACCESS                986       1.00%     671556200     13.00%     4=
180200         100700         681091
> INST_ACCESS                655       1.00%     170054800     3.00%      1=
808300         54600          259625
> HYPERVISOR_SYSCALL         21        0.00%     4276400       0.00%      7=
16500          116000         203638
>
> Changes from v1->v2:
> - Rebased on Linux 6.9-rc3.
>
> Changes from v2->v3:
> - Add the missing assignment for 'vcpu_id_str' in patch 2.
> - Remove parentheses that cause compilation errors
>
> Shenlin Liang (2):
>   RISCV: KVM: add tracepoints for entry and exit events
>   perf kvm/riscv: Port perf kvm stat to RISC-V
>
>  arch/riscv/kvm/trace.h                        | 67 ++++++++++++++++
>  arch/riscv/kvm/vcpu.c                         |  7 ++
>  tools/perf/arch/riscv/Makefile                |  1 +
>  tools/perf/arch/riscv/util/Build              |  1 +
>  tools/perf/arch/riscv/util/kvm-stat.c         | 79 +++++++++++++++++++
>  .../arch/riscv/util/riscv_exception_types.h   | 35 ++++++++
>  6 files changed, 190 insertions(+)
>  create mode 100644 arch/riscv/kvm/trace.h
>  create mode 100644 tools/perf/arch/riscv/util/kvm-stat.c
>  create mode 100644 tools/perf/arch/riscv/util/riscv_exception_types.h

Queued this series for Linux-6.11

Thanks,
Anup
