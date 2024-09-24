Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030E1B85CC;
	Tue, 24 Sep 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200386; cv=none; b=EqlwV4NLjBpWRkUuEw1BJ6ffUvABSESH5YSUnkgITnf5/vVAet823OFdFB1IhVOzq8N8vCPKlUtkAk/dJD4hRekODink9Wk8V/V4jddVLa6DUAq7AeaNn2QsPMa1FVj+Xil9mXsEDbfXQ1pbnCKfW+HXgHDt/qs/qIP7lw9P6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200386; c=relaxed/simple;
	bh=POs2HK6kTTolY7xaUcSVPRXzi118N9fp0b/+xerp1wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7G3p0UC6bLNP6pRJgHVuEp52j/2y6Tb4/TXbBxZLIqDFHZ2VITMii6oh6iY9xb9YCzO35U/Bo/Hcc9MpGIAx30oKZ3JXHQs37coek9ADIYDAUt7QhKdKn83oyYq4UBEujxPO0FSCPq42+LKl8MKrlMOvoNlPt7qh3NvGzmRr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THPZiS+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THPZiS+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5936C4CEC4;
	Tue, 24 Sep 2024 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727200386;
	bh=POs2HK6kTTolY7xaUcSVPRXzi118N9fp0b/+xerp1wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THPZiS+vIs0qgmO/2MeLNZ/ZqOJxR3RO1/zx4o5GN+BiGNCfStw4/D3dzzFad0qsl
	 up3h2IeWem1sr1TXYZYjtr6TSqUJ7HGqwL0kwMhyMAP8mIzU0i1AUDk4GU/tv81912
	 Wwc5lDCVt0IvXJlYu5chCkXz0/8QRbkfgBVaJAnGhEzOsplbUk/T/8ivAiWX4RVrz1
	 HXWFrVdjsx3Vmyf62S+zhUcESsSDwqUx0zuSaktmISjkCa4xae/aCJAluUfW06ExOk
	 9U7nOj/ufDq1Xy0wqNPqcSKz0iIH6P/MJsDUGMXR4Kohl4JWs0qgnpgoHvm54QKj/o
	 gCLINtAhYGr1w==
Date: Tue, 24 Sep 2024 10:53:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Charlie Jenkins <charlie@rivosinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Howard Chu <howardchu95@gmail.com>,
	David Abdurachmanov <davidlt@rivosinc.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] perf syscalltbl: Add syscalltbl__id_at_idx() with no
 syscall table support
Message-ID: <ZvL8gAy07ekBJZ_H@google.com>
References: <20240830-perf_syscalltbl_fix-v1-1-e2ff61ee5e8e@rivosinc.com>
 <ZvLaGy7jRa9Q/5fQ@ghost>
 <CAP-5=fVWFUA4LpchM1MZdMhDvSFhTUtqdVR-s59WtAcpj1fO=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVWFUA4LpchM1MZdMhDvSFhTUtqdVR-s59WtAcpj1fO=g@mail.gmail.com>

On Tue, Sep 24, 2024 at 09:11:41AM -0700, Ian Rogers wrote:
> On Tue, Sep 24, 2024 at 8:26 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 09:30:50PM -0700, Charlie Jenkins wrote:
> > > When HAVE_SYSCALL_TABLE_SUPPORT is not defined, neither is
> > > syscalltbl__id_at_idx(). However, this function is expected to be
> > > defined when HAVE_BPF_SKEL is defined.
> > >
> > > Return -1 from syscalltbl__id_at_idx() to match the other functions when
> > > HAVE_SYSCALL_TABLE_SUPPORT is not defined.
> > >
> > > Without this, compiling perf on riscv when libtraceevents, libelf, and
> > > clang are available will cause the functions trying to call
> > > syscalltbl__id_at_idx() to be compiled. This results in the following
> > > error:
> > >
> > > /usr/bin/ld: perf-in.o: in function `.L0 ':
> > > builtin-trace.c:(.text+0x60b14): undefined reference to `syscalltbl__id_at_idx'
> > > /usr/bin/ld: builtin-trace.c:(.text+0x60c6c): undefined reference to `syscalltbl__id_at_idx'
> > > /usr/bin/ld: perf-in.o: in function `.L2564':
> > > builtin-trace.c:(.text+0x60cb6): undefined reference to `syscalltbl__id_at_idx'
> > > collect2: error: ld returned 1 exit status
> > > make[2]: *** [Makefile.perf:793: perf] Error 1
> > > make[1]: *** [Makefile.perf:290: sub-make] Error 2
> > > make: *** [Makefile:70: all] Error 2
> > > make: Leaving directory '/src/linux-6.11-rc5/tools/perf'
> > >
> > > This patch resolves this issue for all architectures which do not define
> > > HAVE_SYSCALL_TABLE_SUPPORT.
> > >
> > > $ ./perf trace -e syscalls:sys_enter_mmap --max-events=1 ls
> > > 0.000 ls/287 syscalls:sys_enter_mmap(__syscall_nr: 222, len: 9939, prot: READ, flags: PRIVATE, fd: 3)
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > Reported-by: David Abdurachmanov <davidlt@rivosinc.com>
> > > Suggested-by: David Abdurachmanov <davidlt@rivosinc.com>
> > > Fixes: 7a2fb5619cc1 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
> > > ---
> > >  tools/perf/util/syscalltbl.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> > > index 0dd26b991b3f..12654460428f 100644
> > > --- a/tools/perf/util/syscalltbl.c
> > > +++ b/tools/perf/util/syscalltbl.c
> > > @@ -188,4 +188,9 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
> > >  {
> > >       return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> > >  }
> > > +
> > > +int syscalltbl__id_at_idx(struct syscalltbl *tbl __always_unused, int idx __always_unused)
> > > +{
> > > +     return -1;
> > > +}
> > >  #endif /* HAVE_SYSCALL_TABLE_SUPPORT */
> > >
> > > ---
> > > base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
> > > change-id: 20240830-perf_syscalltbl_fix-4f586221795e
> > > --
> > > - Charlie
> > >
> >
> > Can this please be picked up? Compilation on riscv (along with any of
> > the other architectures that don't have syscall table support) is
> > broken. The long term solution is to add support for the syscall table
> > on riscv. I will send out a patch for that, but in the meantime it would
> > be great to have this in the tree.
> 
> I thought something had been done:
> https://lore.kernel.org/lkml/739001a4-4df1-4dec-a141-926c78c5c07e@kernel.org/
> Not sure what's happened.

Hi Arnaldo, can you clarify what's going on here?

Thanks,
Namhyung

