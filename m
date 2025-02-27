Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A81F585C
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633869; cv=none; b=BtWz/OjRYurwoQ4h6X1/5Rm4QpQWC2M3ri24nFb3dOnT39k/2/RyeQlMVmIKB4O/J/6GlU0apJZp2PCLpKpNCX1rCndzMFCyiQnvSxHOvog7d9DI/NbnlTu5jq+d6HyIn6+4jz4lve06QTSNOOhaiFcVWAbZvtrfGkIylDqveQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633869; c=relaxed/simple;
	bh=47ds+4hGrY28VgZ3hza+Gb+h0Ld/NmG/YiG2BZEJFxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwKPOFn6wq5Zw3HY9dKQdSgtNI6H/L4yZ0XNPr9ZZ97l08Eu/TJhdpuOx6H1xhcI6z5H1wZIPGZ8KoDCZRhPv/iLLDYlsE1MsbMBc714GcAVGe6+4tl1NlS5gab/1QkrqGy3Ww67jFI56YOcELRkyu2WPqoVL4neCoroRIODxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IItbCHa0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IItbCHa0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22342c56242so112615ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 21:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740633867; x=1741238667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnEz81f237FPFDdRQFlVRCVwc99gvba5x2QOCkc+RR0=;
        b=IItbCHa0uyx5fe4QzAMSNnHwSUfyk0nHp5n7jzYH6dClTko0A6V99uKRKYSs1dFR1t
         kEVBj9nNc8RJp4tMozfscA7F1mKNRs9acnvu1yZPR8GNwqJX0vF97m4EdjP8XFqOCljp
         HLORO3UYbBwQRpQIm57gtSISevHLrn79EF2TmhF7gmoUpwlaWpMQxT0++VzBG0qIpLoZ
         UxuFIqqM+bJe0uhAnfZCk4K6UUmDnZhD4nazM7rPKv/s14GvVblAYLnSs/9YwF47u+Qz
         D1lnsuUob66wr+BiY/ftAoDEokEE8g4W+rISMyKDL3jHdp7mlABQ+X+HIyT456XUxSOK
         WB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740633867; x=1741238667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnEz81f237FPFDdRQFlVRCVwc99gvba5x2QOCkc+RR0=;
        b=QKclLl0MSuEdJzE9oNLVso2pRiMKzi2oqDxM8JxZ+J1umq4fPZVGyK0NhMeOC8a5ew
         5/e+pEu5WLR/e+hb4ZDqHQBmDmEpc9HKFbbhUVYDDcWu1T8+vJcC2wEWNu+hnIpj/25m
         NaJS2HqU4L1pxyhQZBLn3Dj4glZToHkgVSjsq/5XdAAQTSttlhv808r+U5T/HvTlas1w
         NiwGyK/GJQXfGubM8LNhDYUgXOZ2SAoJR1zZFvM90tDG6KXDtXUQAn5TiW1KW7AEfe8o
         WLqIcgF/1j81UtSrfBpi8a4U9Ij2QgFtnqDdggsZ27tyCGUIyVm72X29Z4auFYVjxiq3
         79Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWHzeAgnlwY9ehpOBMveDrvRoNc1ZbIaTWakO53YQ5Npq0paGR8kug/lrkufrxZZ7DLvXK1qcbHkn5velZ9baL0@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGc+eWsXIafs3vpa/BU+nN8659oku6SlZkW6IKwM4wcGK6lfT
	xpOJY5HIcBO5bDspHTaF815TIT9dHzF8PzCnOdIZjICKZjtROzKCMYereFZLnVGVn7qVNqA2V7l
	Q1BN1HWrCbh9fyS1553YiZlVF+47odHUzrSl4
X-Gm-Gg: ASbGncuv9EZGj7hgIOLWyfAnhxpu+viMpU45PaMMgXpfkFqFrr+FZDK5zPROma3TlFN
	tIe5awDq4yAGzxtqorEUCkfrphxGnzA7R59I1p5KA9YseqOWmtGxwra3sywDhKONzOJPUMR66XI
	MAoxQfkiw0
X-Google-Smtp-Source: AGHT+IESGHDEUIPVrjNTh39ynN60aQSgX7N+PvnUqhcTHIKp7IZB5bqsgXo3vv32FxrjQl6qmhQtj7bSXHofxTNEMow=
X-Received: by 2002:a17:902:f7cc:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-223517240a4mr1111615ad.15.1740633866391; Wed, 26 Feb 2025
 21:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219185657.280286-1-irogers@google.com> <Z702_CQ7nMx9fZQn@google.com>
 <CAP-5=fWYiQP84BMjm69xud4vYaRrutRG-RASKbxQaGSisRm7jA@mail.gmail.com> <Z7-rN8iGUpPe6b-1@google.com>
In-Reply-To: <Z7-rN8iGUpPe6b-1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 21:24:15 -0800
X-Gm-Features: AQ5f1JpYoEre35TWzYAHXMZBSPsriPeINrD-jPxutBzlTEFdOvLRV6EZPh8_ULw
Message-ID: <CAP-5=fVAuCF4i8HQEGYx_ApcSuBg82pXCsgk98oU9-2Gm=NOcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] perf: Support multiple system call tables in the build
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 24, 2025 at 08:22:50PM -0800, Ian Rogers wrote:
> > On Mon, Feb 24, 2025 at 7:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 10:56:49AM -0800, Ian Rogers wrote:
> > > > This work builds on the clean up of system call tables and removal =
of
> > > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > >
> > > > The system call table in perf trace is used to map system call numb=
ers
> > > > to names and vice versa. Prior to these changes, a single table
> > > > matching the perf binary's build was present. The table would be
> > > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > > perf, the names and numbers wouldn't match.
> > > >
> > > > Change the build so that a single system call file is built and the
> > > > potentially multiple tables are identifiable from the ELF machine t=
ype
> > > > of the process being examined. To determine the ELF machine type, t=
he
> > > > executable's header is read from /proc/pid/exe with fallbacks to us=
ing
> > > > the perf's binary type when unknown.
> > >
> > > Hmm.. then this is limited to live mode and potentially detect wrong
> > > machine type if it reads an old data, right?
> > >
> > > Also IIUC fallback to the perf binary means it cannot use cross-machi=
ne
> > > table.  For example, it cannot process data from ARM64 on x86, no?  I=
t
> > > seems it should use perf_env.arch.
> >
> > The perf env arch is kind of horrid. On x86 it has the value x86 and
> > then there is an extra 64bit flag, who knows how x32 should be encoded
> > - but we barely support x32 as-is. I'd rather we added a new feature
> > for the e_machine/e_flags of the executable and worked with those, but
> > it is kind of weird with doing system wide mode. I didn't want to drag
> > that into this patch series anyway as there is already enough here.
>
> Right, I don't know how to handle x32 properly.  Maybe we can just
> ignore it for now.
>
> But anyway looking at /proc/PID for recorded data doesn't seem correct.
> Can you please add a flag to do that only from trace__run() and just use
> EM_HOST for trace__replay()?

So I was hoping at some later point the e_machine on the thread could
be populated from the data file - hence the accessor being on thread
and not part of the trace code. We could add a global flag to thread
to disable the reading from /proc but we do similar reading in
machine.c for /proc/version, /proc/kallsyms, /proc/modules, etc. I
think the chance a pid is recycled and the process has a different
e_machine are remote enough that it is similar in nature. Adding the
flag means we need to go and fix up all uses, we only need to set the
flag in builtin-trace.c currently, but we've been historically bad at
setting these globals and bugs creep in. I also don't think
record/replay is working well and I didn't want the syscalltbl cleanup
to turn into a perf trace record/replay fixing exercise.

Thanks,
Ian

> Later, we may need to add a misc flag or so to PERF_RECORD_FORK (and
> PERF_RECORD_COMM with MISC_COMM_EXEC) to indicate non-standard ABI for a
> new thread.  But it's not clear how to make it arch-independent.
>
> >
> > > One more concern is BPF.  The BPF should know about the ABI of the
> > > current process so that it can augment the syscall arguments correctl=
y.
> > > Currently it only checks the syscall number but it can be different o=
n
> > > 32-bit and 64-bit.
> >
> > That's right. This change is trying to clean up
> > tools/perf/util/syscalltbl.c and the perf trace usage. I didn't go as
> > far as making BPF programs pair system call number with e_machine and
> > e_flags, there is enough here and the behavior after these patches
> > matches the behavior before - that is to assume the system call ABI
> > matches that of the perf binary.
>
> Right, the next step would be adding a BPF kfunc to identify the current
> ABI.
>
> Thanks,
> Namhyung
>
