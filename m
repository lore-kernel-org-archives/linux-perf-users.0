Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08D204F85
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696674; cv=none; b=RSTr96UBTU+6W8730q3CQa3zwrfZXbhvTDvf1PNWAzBzH5cBT6x8ABhHXV1PvOdKV5ImZYvyv0zA8kBKMXArriVrz8PuRoDqDDtVmGjitLXyzJFmt+q6w06Z9KURBJshnoZKuaQ06wrAAI5pBiBybwSyFedH0sN4IsOW6kVGLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696674; c=relaxed/simple;
	bh=i18llDbp3q6y0/w+gTxZyxhvyOXPpj+iA3QfM/7JUT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyAixJXe9bezCC5enhJVJ7FmRZxv+QFuLkIdrGO7apmVXf16pPrgcqZlz7PoOMxmjtao9RhdFOjuJtfxceFetg7SQBbf3/AJT4tq+zbXI4CrtJ47OzFO0nozhvdod6Vx+vC8pKTTNhOMch6NAo1m9umAu/sxw6GaeIpk7MBGO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhvGioqw; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhvGioqw"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d04e5bd797so25755ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738696671; x=1739301471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i18llDbp3q6y0/w+gTxZyxhvyOXPpj+iA3QfM/7JUT4=;
        b=XhvGioqw8wbDDdZiYjaZFR3Tc7r7sRfCJ7EEoWcmnSeLPrnjl2je5GBz9I90Kv+VMP
         ur5gvU7Wyy6JvmZCY1gPYFaR8KyEaxcdbQy+hxYyxs1UcpXMQNfPMMCrBlho+rJ7WaIN
         xn+PLhsNNKNbmv1sR7kgl/5iieqAvE4cRJNbGx+aQs9mhy4x5Lf573L9P2+Xf5Gzf4ko
         agQnrcUEwOTxdEBIpS25Ke9fMp5byC7vqRNQGCtnMM8DBrRaEKlEIO9K7ChJ5ZquFr6l
         BKQWYimGqX4d2elyP4qo0D091ESyd3Z45OMyW9FnCK2ciQo9y4e6wd4ruTI0k+it8FXK
         19oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696671; x=1739301471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i18llDbp3q6y0/w+gTxZyxhvyOXPpj+iA3QfM/7JUT4=;
        b=G5GGpsmP+oikQQWl3fkL9r6CYSx/J9HP/bNIwehXE8eiqjcThbRIwTiT8P7hpc2ZYV
         ix05Y0saMf5wbGLUCp7BiSYw+tXF6n26saHpSYL57xjVQt4GXIK0bRtkrIiPj3P/H8JO
         7E2a9P1nl6EN94/NcuRorxHYDzPg58LJ7/Al4pNhV2zjLdg+aZlnDqhv9LpLy65xbJba
         AjIObH+02y5eaTeMOgwC/kETrRsEjqOrn5zGUY8jmCvLs6PrbsjlEIRUgfxOrBIyvYaa
         UWq+z6i90co24McJxDbyd+9UbpObBNU9YaewSKPRnlaXPEvxN8mHLAt/0z9W4609CvGW
         I0WA==
X-Forwarded-Encrypted: i=1; AJvYcCUxpN5S21ucD+gQhu7Lxp2nJUZByiY2N50bzBBvMdwPfcJt2YsCEN0J/ZoNtP31m2O4QrOneeXdyHCkosMV3jUu@vger.kernel.org
X-Gm-Message-State: AOJu0Yylwy9QqI3qyDbJIwmX4kb0D+L2/gxop8h4fctmKgDUV4NGLrZk
	XdHCb0MN/RlPRXbQc6DSs61NJRTNwG9oOioJDd1cpQ8cygMAJudOlb/3x4tWPqMiRV3XjCj9dAs
	YjbL4vOruACVHFNZu0gBVUWdmBbLETyarMFDJ
X-Gm-Gg: ASbGncvsJTHNSWmIUUYkZFwDm2Fkz0s6kOFoM1p0jFzpRwO+juJXeQNAE4u63BAEnC4
	p7DU99yl3duT6QE58go6tjI5LXEgtbeyj5JzWKraZI/OKibfs87wwzX7az8gl9HVHpHozRqfNsc
	jhsQQnbCM4yID/nP8+Ei1RKOs=
X-Google-Smtp-Source: AGHT+IFolYWpFTnQsRdsrwOlOifUaBgvwudGG5wYq6BOxOFUog2J180QiONTDBpKLqE0BXd+LTekoBGthx3cwhLK2l0=
X-Received: by 2002:a05:6e02:1b03:b0:3d0:a9b:bf4b with SMTP id
 e9e14a558f8ab-3d03fbc124emr4771915ab.12.1738696671064; Tue, 04 Feb 2025
 11:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
 <Z6EVwaOVYaKtaK1j@ghost> <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
 <Z6Eh1QLuqTbUKLCc@ghost> <CAP-5=fXZr8L4Z=Lb28QDZF8cbv2eJJEHSb0H9zcqSOB9cn5-9g@mail.gmail.com>
 <Z6FLDHz6V5L-HGR7@ghost> <CAP-5=fVk6N=FVXsJ9xRJZhYSh2sbmUkEPr5HqRd-pR7mbGts+w@mail.gmail.com>
 <Z6Jk_UN9i69QGqUj@ghost>
In-Reply-To: <Z6Jk_UN9i69QGqUj@ghost>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 11:17:39 -0800
X-Gm-Features: AWEUYZlVFnxotEtPCBotMGFHsGHFGTZrWjMIjpLeZvUSs1sflhNc56tRZVilEN8
Message-ID: <CAP-5=fVXAt3jbiTTBNwNVqWMmAc=9U_XatgC_o854kyUGjkg0Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the build
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:05=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Mon, Feb 03, 2025 at 05:58:29PM -0800, Ian Rogers wrote:
> > On Mon, Feb 3, 2025 at 3:02=E2=80=AFPM Charlie Jenkins <charlie@rivosin=
c.com> wrote:
> > > On Mon, Feb 03, 2025 at 12:54:59PM -0800, Ian Rogers wrote:
> > [snip]
> > > > I think it makes sense in the kernel, as the built binary doesn't h=
ave
> > > > cross-platform concerns. This is probably also the reason why the p=
erf
> > > > tool has an arch directory. Let me know what you think is the right
> > > > direction for the perf tool syscall table code.
> > >
> > > I am hesitant about moving all of the arch-specific syscall generatio=
n
> > > flags into a single file.
> >
> > In these changes I had a single file to build up a mapping from ELF
> > machine to syscall table in an array and I wanted to keep the logic to
> > build the array alongside the logic to build up the components of the
> > array - so the ifdefs were visually the same. As the scope is a single
> > file and the variables are static, this can give useful C compiler
> > "unused definition" warnings. You can trick the linker to give similar
> > warnings at the scope of a file, so this isn't a deal breaker.
> >
> > > There is currently a really clean separation
> > > between the architectures and it's possible to generate all of the
> > > syscall tables for all of the architecutures based on the paths to th=
e
> > > syscall table.
> >
> > This doesn't happen currently as the build of the arch directory is to
> > add in $(SRCARCH) only. So
> > tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls will only be
> > included into the build if SRCARCH=3D=3Darm64. As I've said I'm against
> > the idea of the arch directory as it nearly always causes cross
> > platform problems - not an issue in a Linux kernel build. We recently
> > eliminated dwarf-regs for this reason (and hopefully fixing up cross
> > platform disassembly issues as a consequence):
> > https://lore.kernel.org/all/20241108234606.429459-1-irogers@google.com/
> > We could have the syscall table logic not under arch and generate
> > multiple files, but we'd be adding extra logic to pull things apart to
> > then pull things back together again, which feels like unnecessary
> > complexity.
> >
> > It seems in your changes the Kbuild and Makefile.syscalls are running
> > in the arch directory - this feels like a lot of peculiar and
> > separated build logic for just iterating over a bunch of arch
> > directory names and calling a shell function on them - albeit with
> > some arch specific parameters. There's also an extra C helper
> > executable in your code.
>
> Yes, I can understand why you be opposed to that and I don't have a good
> counterargument.
>
> > I kind of like that I get a single header
> > that is the same across all architectures and with no more build
> > system requirements than to support ifdefs - in fact the ifdefs are
> > just there to keep the code size down there is a #define to make them
> > all have no effect. I hear your "clean separation" but I also think
> > separation across files can make things harder to read, state is in >1
> > place. I've tried to cleanly separate within the script.
> >
> > I do think there is some tech debt in both changes. My:
> > ```
> > #if defined(ALL_SYSCALLTBL) || defined(__riscv)
> > #if __BITS_PER_LONG !=3D 64
> > EOF
> > build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"
> > common,32,riscv,memfd_secret EM_RISCV
> > echo "#else" >> "$outfile"
> > build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"
> > common,64,riscv,rlimit,memfd_secret EM_RISC
> > V
> > cat >> "$outfile" <<EOF
> > #endif //__BITS_PER_LONG !=3D 64
> > ```
> > means the perf binary word size determines the syscall table support.
> > This is because the e_machine in the ELF header isn't unique in these
> > two cases and having both tables would have no effect. You've moved
> > this into the env arch name handling, but I think having >1 way to
> > encode a binary type is suboptimal. There are some ELF flag ABI bits
> > that resolve disassembler things on csky, so perhaps a resolution is
> > to pass ELF flags along with the machine type. I'm not clear in your
> > change how "32_riscv" is generated to solve the same problem. Imo,
> > it'd kind of be nice not to introduce notions like "64_arm64" as we
> > seem to be always mapping/normalizing/... these different notions and
> > they feel inherently brittle.
>
> Maybe it is brittle? It could be mapped to e_machine, but that just
> might not be reasonable to work into the method from my patch.
>
> >
> > > What causes the arch directory to be a pain for Bazel? I
> > > guess I am mostly confused why it makes sense to change the kernel
> > > Makefiles in order to accomidate a rewrite of the build system in Baz=
el
> > > that isn't planned to be used upstream.
> >
> > It's just software and so the issues are resolvable, ie I don't think
> > bazel should be determining what happens upstream - it motivates me to
> > some extent. For the bazel build I need to match the Makefile behavior
> > with bits of script called genrule, the scope and quantity of these
> > increase with the arch directory model, extra executables to have in
> > the build etc. I also imagine cross platform stuff will add
> > complexity, like mapping blaze's notions of machine type to those
> > introduced in your change. It is all a lot of stuff and I think what's
> > in these changes keeps things about as simple as they can be. It'd be
> > nice to integrate the best features of both changes and I think some
> > of the e_machine stuff here can be added onto your change to get the
> > i386/x86-64 case to work. I'm not sold on the complexity of the build
> > in your changes though, multiple files, Kbuild and Makefile.syscalls,
> > the arch directory not optionally being built, helper executables.
> > Ultimately it is the same shell logic in both changes, and your
> > previous work laid out all the ground work for this (I'm very grateful
> > for it :-) ).
>
> Thanks for elaborating on this! I do wish we had more of this
> conversation on the original patch so we could have molded the original
> patch closer to what this one is doing. I know you did mention you would
> like to get rid of the arch directory as feedback on that patch but I
> hadn't realized that this was the direction you were hoping to take
> this. It does seem like the changes you have made in this patch will
> lead to a something that is more robust and simpler to maintain, so we
> can move forward with reviewing this patch and stop reviewing the one I
> wrote.

Thanks and sorry for work done that may not land - the maintainers may
prefer the approach in your patch and my opinions matter little to
them. If it is any consolation I wrote an entire Rust symbol demangler
[1] that I don't expect to land :-) I also appreciate that you've been
cleaning up the tools build infrastructure along with your changes,
something there isn't enough of.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com=
/
