Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FB3B47CC;
	Tue,  8 Sep 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900664; cv=none; b=XYdn2vb/tx1vF0ZXnvn3lNr0Q10BMw6g1no6hX7T/2iabD6BbJbnjkssQp9ZPsKQRGi6SDwn6KqZ9oY1PFITzroVlmIabgmzJZgjXmRTCif0zkJHLkgOx37BpT1O2ZU1aPYDw25YzWAAfJVAff+gJ03zfSp4OHftvnvtQpPCP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900664; c=relaxed/simple;
	bh=zNgtyufiNevp2w3vVZ/PL15RCzamMft01UG496GLkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgOm6s12W5R1NuSToPozRPZ7t49PIdKXySd6VOUdmuLbLqqRnTnnuTqsIHJOCGqA0JAFGI2tvIEG8xW5t/FwxIi8TCWyPIxPVSZf8Pj+OIkIbH6b6O2mO/YOyOGgyukRQXgy6yFLzfHYZo8EVysv1BioNnUUCB/nnXD8NXXL6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKdbHp6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKdbHp6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6BB1F00A3A;
	Tue,  8 Sep 2026 20:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900663;
	bh=pqVJjziaaRCdCUM3lbSKWGOymFy2UYOe/cTKOLbEHgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKdbHp6VWtaa7SNBVtdcqbPfB0XtNA2LU0YQits6YwMZPKEUzYXzz9OPdcH7v3DWn
	 EW53PAVxsQR15v19Bs73+3qK6Nzo8eySofYrTZb8DSeCW+QYQjMVF/NcO1FQC2iSSe
	 8cMdStGec76Ah3mULD9AAbkbNhtEYwQ/ZyNatcGWM2U09DrUyi6xjsJb0r//1Uun0y
	 +PSVY8rWXCeS3dt+mnao1vN6x3avIGHv9CcNOR76+mvLHJ151jI5s2a5vIUhZfxWxO
	 44j/PVskJuAElKp1Nz5Kt/4TwHCr43hfO+uUSMPqAZWrTQKPqo2xLPh+JKJcoxbMuq
	 uxhTdFHYKLBag==
Date: Tue, 8 Sep 2026 17:51:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Nylon Chen <nylon.chen@sifive.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench futex: Define SYS_futex on 32-bit arches with
 64-bit time_t
Message-ID: <aqB1NGbcNdAGJnST@x2>
References: <20260902093210.3571958-1-nylon.chen@sifive.com>
 <CAP-5=fUzqFPfN+xH8uqERugK9xsauUoxZTVr+YLGGXVRi6UC9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUzqFPfN+xH8uqERugK9xsauUoxZTVr+YLGGXVRi6UC9w@mail.gmail.com>

On Wed, Sep 02, 2026 at 10:04:14PM -0700, Ian Rogers wrote:
> On Wed, Sep 2, 2026 at 2:32 AM Nylon Chen <nylon.chen@sifive.com> wrote:
> >
> > The kernel does not provide sys_futex() on 32-bit architectures that lack
> > a 32-bit time representation, such as riscv32. Consequently glibc does not
> > define SYS_futex there, only SYS_futex_time64, and perf bench's futex
> > benchmarks fail to build:
> >
> >   bench/futex.h: In function 'futex_syscall':
> >   bench/futex.h:77:18: error: 'SYS_futex' undeclared (first use in this function)
> >
> > Define SYS_futex as SYS_futex_time64 when only the latter is available.
> > The guard and its comment are taken verbatim from
> > tools/testing/selftests/futex/include/futextest.h, where they were added by
> > commit 04850819c65c ("selftests/futex: Define SYS_futex on 32-bit
> > architectures with 64-bit time_t"), keeping the two futex userspace headers
> > in sync.
> >
> > No timespec conversion helper is needed on top of this. glibc lays out
> > struct timespec on 32-bit architectures with 64-bit time_t as
> > { int64 tv_sec; int32 tv_nsec; 32-bit pad }, which is compatible with
> > struct __kernel_timespec, and every futex_wait()/futex_lock_pi()/
> > futex_wait_requeue_pi() call site in perf bench passes a NULL timeout
> > anyway, so no timespec ever crosses the syscall boundary here.
> >
> > Note that an earlier and more ambitious attempt at this was
> > commit c1ff12dac465 ("perf bench futex: Add support for 32-bit systems
> > with 64-bit time_t"), reverted by
> > commit ba4026b09d83 ("Revert "perf bench futex: Add support for 32-bit
> > systems with 64-bit time_t"") because it included linux/time_types.h,
> > which is unavailable on older distributions. This change deliberately
> > avoids that dependency and adds only the one guard needed to fix
> > compilation.
> >
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
