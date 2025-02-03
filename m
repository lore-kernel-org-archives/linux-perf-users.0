Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57C20E317
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607336; cv=none; b=rcO4a8bI7Zj/TctGLHKvcSMmN22ObGO5eqrVDKNqa5aq+M+dqmaEpPz4rCsRcPkNQB4biH5ug1OQmEX6N8i4TIMr9ebCKhHBzRYK9xbR+qih9C9FPcI/Tk4NtONLga64P0oJZ2WVTqOIzbPNDi7gPjlLKNU3QCxVgfvRPBezs/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607336; c=relaxed/simple;
	bh=PKPB5z8jjt3oXbFDRocWuOE6GY1Tqjmchh+Zand458k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e4tWp8XsyeUsHWRra2KPbWoAqqT54uULLsJEASFG63BmkXDo/YIRc+Jz+MH1VeN+0cKV4/3SLNNgyCjpRA0wF6LcbfkqR2tvceulmuhpyn9tv5J77LZgmmPWRQC4cPPgcryzK0bW6olaMw/0FO27d4MWLDngABK1J//ZhwiU770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0T+rDMc1; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0T+rDMc1"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a814c54742so2275ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 10:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738607333; x=1739212133; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwX9yigjczno1Znsa9bRz1z0dQyr4IiRfFLwwoCxyg0=;
        b=0T+rDMc1vxZ7ATjjLM+jiGaHJciTiCdMdda7V0ljlX+ghT9p8264U0jk8ySHp60y/g
         s1XTxvVehe0XnXT1KlRBfO51jad0oXM7nl5NyQn1VSeLzKDMb45rjgPyQ3F7B0b0kZqy
         xUe2Nhg9OIdh+ES6kayOCmszXjjhtDSaoPkzweZ8xjORkTErIfcG6nh28SXQuAxShRN7
         I/s14i/Fo/Kl4k/WR6E7K3/nPg/7PlcSesoenGYK1tFMXOWbxvOxwCl59xx3mmXYq9BD
         uTqsXCts4d8PU85qPSfJQDF3q0ZbqKAtVD6BydKKAIobIoR/nfUbpQVDz/8kHTtMsj34
         cZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738607333; x=1739212133;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwX9yigjczno1Znsa9bRz1z0dQyr4IiRfFLwwoCxyg0=;
        b=q/OnFuSmi5gtZ2jd7XucZGCfOCMyq23jEWLPIxsjBqzZK+d3WxDg6CpUA/vKLE67eA
         OWzHbq/QTFjul7K5OBwtyzEYS/Drx6aoIWkrGnsTWv86hCOa7eQtu+CAxjQrPwrm/u/a
         8kqqCH6+0QCdQk3t0aZdg0hbeCkSZqulsGrijsYxtU8OFB0mlGaHbKCB5mQTgFeweqRB
         BlnylT1O0QVKA2a5hzCt2Hu57H/OJ1ci9TJonQ4SDDa28TZqf4WmdxMBTNeFjsxXYcSk
         kFh6elRzUebEshguS3fv8bA0R+UCRGcUwwls32JcKOfE7A9mxBm47QwAVX0zh70zZLwC
         m8pA==
X-Forwarded-Encrypted: i=1; AJvYcCXnOpTbAo11mTyzkVLx8ZlMCQ6IB9QekpuH5NtEJIJcIVTrfhyHbxGZSgGFLZDmi35fj15mTbdMhylmvc+g38/p@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqthrljTR3P14ZzD1aEPY1VxugiO00CkQE+ceLPn+irK/GIIA
	XfF7vzdjnWTfInhc9/PXjmzW1bsPp93rl1HRAc9djBAuEwM24pXDrQU490AP+OMlg/ADCsSzSMF
	saedfCxG/ca+vRV1GK0ZS9DoXiLIivvDBHM6T
X-Gm-Gg: ASbGnct+Am9PlX9fiWLXzAlmn22IR3aqBhYNnUrNMlZpBObXEqMTdvmisNtW/clKArO
	yOA0EZ/vZnht9GJMEdlQ6R32DkYO/84Gm7zVgg26uGJkP9ZAl73pKJfFSS+LARHBFQ6VcOWPdN5
	IPVqiwfUAjseJDVHLQ92yKFxg=
X-Google-Smtp-Source: AGHT+IH+A9TihiG72yU0Vq5EiYylzTrE/IWJEUJYg00EcqiTZKQbwizmjhExw2bHiq41772gYqefQvOo1dSun9QKKsQ=
X-Received: by 2002:a05:6e02:152b:b0:3a7:e3b3:2e3 with SMTP id
 e9e14a558f8ab-3d03eef69e2mr568275ab.17.1738607331812; Mon, 03 Feb 2025
 10:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <CAP-5=fVJPAEhvyV_dPHSHKJVeskCf_paFSP6V4EWmEyqACeA-w@mail.gmail.com>
In-Reply-To: <CAP-5=fVJPAEhvyV_dPHSHKJVeskCf_paFSP6V4EWmEyqACeA-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 10:28:40 -0800
X-Gm-Features: AWEUYZk2d0_RD-bETg-4iKC_pajIBGhSvw_oeuucHt_WAGp1zkLzZrIkQ1Y7lrI
Message-ID: <CAP-5=fX2BtFzhGLCSqO1QszqfX=HT8RrTdG_5Ttp5Gw4seSstA@mail.gmail.com>
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

On Sat, Feb 1, 2025 at 12:51=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > This work builds on the clean up of system call tables and removal of
> > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> >
> > The system call table in perf trace is used to map system call numbers
> > to names and vice versa. Prior to these changes, a single table
> > matching the perf binary's build was present. The table would be
> > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > perf, the names and numbers wouldn't match.
> >
> > Change the build so that a single system call file is built and the
> > potentially multiple tables are identifiable from the ELF machine type
> > of the process being examined. To determine the ELF machine type, the
> > executable's header is read from /proc/pid/exe with fallbacks to using
> > the perf's binary type when unknown.
> >
> > Remove some runtime types used by the system call tables and make
> > equivalents generated at build time.
> >
> > Ian Rogers (7):
> >   perf syscalltble: Remove syscall_table.h
> >   perf trace: Reorganize syscalls
> >   perf syscalltbl: Remove struct syscalltbl
> >   perf thread: Add support for reading the e_machine type for a thread
> >   perf trace beauty: Add syscalltbl.sh generating all system call table=
s
> >   perf syscalltbl: Use lookup table containing multiple architectures
> >   perf build: Remove Makefile.syscalls
>
> If you are looking for the improvement this series achieves, patch 6
> has sample before and after output:
> https://lore.kernel.org/lkml/20250201071455.718247-7-irogers@google.com/

I think there is a follow up to these patches to clean up the notion
of "arch" and its "name" member:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/disasm.h?h=3Dperf-tools-next#n20
The name on x86-64 has the value "x86" and isn't known to be i386 or
x86-64, causing ambiguity to work around:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/disasm.c?h=3Dperf-tools-next#n1898
It feels likely that rather than recording (in env) a string based on
uname and bashing it around:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/env.c?h=3Dperf-tools-next#n440
It would be better to record the e_machine values for the set of
threads in the record, or just a set of potential e_machine values. We
can get rid of name in arch, use e_machine from some dso helper, and
then deal with this as appropriate without needing to carry around
is_64bit to deal with ambiguity.

A change like this would need its own feature flag, and helpers
between the old name and e_machine so all notions of the old style
name could be removed, etc. It may be convenient to duplicate arch
tables for i386/x86-64 rather than have disasm's arch deal with a set
of e_machines.

Thanks,
Ian
