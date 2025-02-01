Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A88A935
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738399899; cv=none; b=RS/SifrWtRHcDz1ZQFDmjUym2fR+N1ioy0aRrysEUGCvYf0d1DYNNZK+FzXaV+Q7ixkTNSV3IoibQlQHTbHIT/QbJPz3Qg4B186a+W172KKOzncjg9kGmH505H7D8rF2v7zcaiaQFCmoYrnCCibXdwHAf2Cvh2fsGh0hmFOgsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738399899; c=relaxed/simple;
	bh=wHk4hM1E2Xs597sLaiQpMT4/XnQINO/xkvfZUfLDhCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=t0kgAClfj0vZTFTb6tTUC8RiJ2f2i47fZj5STQ5WCRAlt1t9xD+p64cKtFB4pQUwcWTjnFbJWYaT8/Ulht02gJ6mmssHot9ztcnTIMbjTkoQh+qaaWT5BhnqxXnzyMBc8kpEel2JA1efXzs+9QAR+mcAIjvGZDkzAO2DmmRex/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdN/Pcu0; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdN/Pcu0"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a814c54742so93655ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Feb 2025 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738399897; x=1739004697; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIefE9I0jaBGB4Y4mTk2FVVd4hcyxumz66eayz6AufQ=;
        b=rdN/Pcu00aU9E+plgIOT/MizyBzdvwOpfv7OPwvW+dBe0Fxo8rD6HAD8IEW+HEetvH
         D7CmSwYuNbDo5jNQfyS9tDiU3GlLMvilaPIxvYp3QQlf/NuCW3qTK4RfOJFGUpY4LAB/
         3/LBBQLYLSwljUcsq3w2QCEJnNzscJ6SdSurvDQukaR3wDt7UvE0hyFMyS8unMXmvUgv
         jngrg2InlhUN7LJHSgL75cQDECkCiCaZGZwkdmJIQBeLDcTip4PCG4EQGAvWW/bcCsge
         Z3bA/3r2LiNEsBSRzSkgILAvmQvPm5jNDdWP+A2/ipmM9CZQ3JnHogqSumOG9oGhgklE
         vJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738399897; x=1739004697;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIefE9I0jaBGB4Y4mTk2FVVd4hcyxumz66eayz6AufQ=;
        b=OIkTFts3WiVTG/uIyfik/fWnp6KBlzd0nWAgUADBPXTT6ppluMPom18VkhDQEnjECf
         0kOSQqX1+tBzNVE9pIl2VEDCPPwaFnVsm+JHgKF8FmcCLyEddBt3yQemy6j9vWIWnyPQ
         v764IAxoDCcZWgjdHpt7/GRu6VCHoPB5TB2gOAGzEHC0+6BxBYr3aw7jrEaLrxQ+Ij3N
         xwy/1gMTSG/H2rbg1nb4f19r6lAsC6jxu+Lw9Av/UNfgHvAanc55f4rIr0HD2/Jf3ChA
         EAEu6yT82fwD5esiJM5xfq3vmM9Khws7D70UpQfEWJjkPVxJrq0XwrX7F29wyX1NLDWt
         Pb5w==
X-Forwarded-Encrypted: i=1; AJvYcCVVn3swebn0xsPpiTxDXXaGTi3olMarzbdrKdduOViqhf1XkHAI7U1y02hzj33pvLtrzNi4iAchQ5wpYLarUElA@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkVbhrTu/HJivWhTW1mDWsK0pySLbK/xpia6wr33dlLzY2KWt
	WNyxXI2YCPTKrHWMJReFGvxiXo/kLOJnklwc3cpisCMrOjw8dmV0ZtuN4CWXNbAFl5aN2xH7+wB
	WHdH/vzIMe6zyZYVc3HtV1J2MPj8aFQV8WXOB
X-Gm-Gg: ASbGncvUTBpaXq7y5bRMyYhZpVeWoGGhrm2oQXuCY1tB7dlyZ5MEcVuVlo65dY5tri6
	bP59BHWIues3r/vQy87FUzrsLZOD/pRb7I1/vpuX7VtCN7rLO3jjqGdKc2tGyyx9fFPmMH3s9YA
	==
X-Google-Smtp-Source: AGHT+IFhoRz5P8nIkYHneDkKTVBakh7rtHG1dVw4obSdcvgjm+5z3V7T8nuKUGr47wUBBSm2PXOEjroFbF04NpvDEJE=
X-Received: by 2002:a05:6e02:1807:b0:3cf:c8b9:8826 with SMTP id
 e9e14a558f8ab-3d020178ad0mr2457485ab.10.1738399896951; Sat, 01 Feb 2025
 00:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com>
In-Reply-To: <20250201071455.718247-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 00:51:25 -0800
X-Gm-Features: AWEUYZlh_7DpL4vGIxHF0oRogbUtw7xXXY8ZKrPktMrlaINtX7JtLXsF90u6VZI
Message-ID: <CAP-5=fVJPAEhvyV_dPHSHKJVeskCf_paFSP6V4EWmEyqACeA-w@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the build
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> This work builds on the clean up of system call tables and removal of
> libaudit by Charlie Jenkins <charlie@rivosinc.com>.
>
> The system call table in perf trace is used to map system call numbers
> to names and vice versa. Prior to these changes, a single table
> matching the perf binary's build was present. The table would be
> incorrect if tracing say a 32-bit binary from a 64-bit version of
> perf, the names and numbers wouldn't match.
>
> Change the build so that a single system call file is built and the
> potentially multiple tables are identifiable from the ELF machine type
> of the process being examined. To determine the ELF machine type, the
> executable's header is read from /proc/pid/exe with fallbacks to using
> the perf's binary type when unknown.
>
> Remove some runtime types used by the system call tables and make
> equivalents generated at build time.
>
> Ian Rogers (7):
>   perf syscalltble: Remove syscall_table.h
>   perf trace: Reorganize syscalls
>   perf syscalltbl: Remove struct syscalltbl
>   perf thread: Add support for reading the e_machine type for a thread
>   perf trace beauty: Add syscalltbl.sh generating all system call tables
>   perf syscalltbl: Use lookup table containing multiple architectures
>   perf build: Remove Makefile.syscalls

If you are looking for the improvement this series achieves, patch 6
has sample before and after output:
https://lore.kernel.org/lkml/20250201071455.718247-7-irogers@google.com/

Thanks,
Ian
