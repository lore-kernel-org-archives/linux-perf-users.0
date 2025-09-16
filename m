Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE62FFF95
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042028; cv=none; b=Z84oF0HDsOqfGLB89Bg00IJcrNiPhlWKN+FQZ3zsp/fO3W23aHvbefXc6FP/HYaKKI1xvasN/DsOnuTxb2RWL+qRUeW/9/Dj3XzI8dgSk18C2CXmPVA7NdGQ941iUu8ylh37gBvgp25IcRgbjPpO9KslCY8lMFVbtH2lb0uFzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042028; c=relaxed/simple;
	bh=OcDCBdLByHtvifRhn7gwUlfzCwDJ8tyJdF9atk9M5ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SINwGZK4Co+BkQcOax6P/WxUwOlKlDOcU5mr6O1ZiSb5CvXwCnHSC6ojn60ZdsAlmF56i5lxfEpZPhp3Fhzu3bHJjy83J3qDdnhzqpk4a4u5pWyzZkIe+ea/gE5exQ6Um5TFceOztF9kC+1QsYgbTmJcTC7hTirkygSWXCZIQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1iNXeQ5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1iNXeQ5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-265f460ae7bso8555ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758042026; x=1758646826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcDCBdLByHtvifRhn7gwUlfzCwDJ8tyJdF9atk9M5ns=;
        b=l1iNXeQ5Cv/Fy1HClJhIAzyElVMPQe947Y1nKk0+FmhEUowsYyYAhrtWM3W2PToF5a
         4OYIJmMFMLwNiZH4ESbFVmmGzAzc1eA9DD5GIFrBPiAIV6ymxmQg/gbjar2rq+yWqf/U
         3aupjmSG6jwqpRBf/jxXa+LXjOrOzVJf/grZPFarqK5djwfQZLD0tJlWd0VeiJDnDCm5
         xLCuDwXAngaIrRltc6uo2eb0mBEAT7IPm27BfI67dKnOHOrEdKYJylJc5qEFgUUbadbj
         enKdQNjWSyFg+J5ays/tv7BSiszHSSFAohhOLUF99+Er+kCoZsRQWcZpncpti4+o4hFM
         yX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042026; x=1758646826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcDCBdLByHtvifRhn7gwUlfzCwDJ8tyJdF9atk9M5ns=;
        b=CCiYeLSpQCWmeuE9mZB9OWkGI2/0evINSqSpgKSDAP2Z6FOfir3NfPa/Ncc8Ebapvz
         6Y4KXSwEi5rsiuxjbiw0PTRtqq7VODTSukPtCTjvDrT7vmdSmLgRNnNbrKPKGptyWZ61
         wpU5gdfHGwpUcWldVP0EKmZ/jN8xtec34qFhwo42YFqi9qHqn8Xxm36i728P0OJ0tXTr
         E1GgW2k0+Dm5ussigRNj3p59lz2g5p+XHbjEOzIzVFV5UF9qcb4+02slrwRYjgqmu1Af
         rsuehVBEWdOTmdk9bcsFdcjL31HAtjp5f9d2NCAtk7Q+pfHavft4om8ij/pFKNFpPuZc
         9okg==
X-Forwarded-Encrypted: i=1; AJvYcCXenVWt0LXLjune0P4e2KMnwVz2g0Qk3s9hwkGyH8IUEAl0LIgxH2cs9UA3yOGZj/unU8UAp/rkggChQ/P5WoXo@vger.kernel.org
X-Gm-Message-State: AOJu0YxovNa2AAGPk0hDkc00PdzKrUaPJXNwYmCT6El3PdBBQ3CA4+6c
	ghM9rqoUMfIfndJZVyuPBXyqkVeBhEEGhuoFaNOw4P9yGOITDGSItyoGlWBmAQsK0yVH/mYGFbY
	wonwJyKwPsrsLZGxU7Enpu+OzlPF5zIE1YN+C0QaIEdwx7UjI82mbDmcEc98=
X-Gm-Gg: ASbGncv7gfr2frTLa41Qtcc7KDCqlOgqODcb5HKFcqF40v2snzC7yEyg36q9yhABSXm
	uWaNoiDujfu3W01+9+SdygFJBlaEAoGOswzpWeS0hlgne3nL2asNeS8K4Cu7DwwH+Dk6ycFsX7k
	3x4N6amD8xdktrja/GDHa/ZiAgbJmxP7GldotD73n2y7sg0GUIwXLKsKXWz5wP8YukSot57Z1iF
	pOjJaDSkVjpGnvO8gwHCK18GNivs20snJBrEnGuKCg3O5MaNWQZu2Y=
X-Google-Smtp-Source: AGHT+IHUsNcKOTamp95NIzkPK9s84PFTzHF4QU/SeT7kF8GYkkd2d/3wEcgBA5atOSoMKUJt92zudhDOxXiU3gxiu5g=
X-Received: by 2002:a17:902:ea0f:b0:24b:131c:48b4 with SMTP id
 d9443c01a7336-267ca0ea180mr4472595ad.5.1758042025737; Tue, 16 Sep 2025
 10:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com> <aJDDfCKFXFQOJ134@J2N7QTR9R3>
 <20250916141811.GK3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250916141811.GK3245006@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 10:00:13 -0700
X-Gm-Features: AS18NWBS359cdZhMnRKWnz-vGZRlDX8LuYkVYTjQunTHAtMOz3vtvbWP6vzFn3o
Message-ID: <CAP-5=fVec0Wp-d489aWE6Tk=W4dz-r6O+JUiqSPLcEZ7TK6FJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf bench: Add qspinlock benchmark
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yuzhuo Jing <yzj@umich.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:18=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Aug 04, 2025 at 03:28:12PM +0100, Mark Rutland wrote:
> > On Mon, Jul 28, 2025 at 07:26:33PM -0700, Yuzhuo Jing wrote:
> > > As an effort to improve the perf bench subcommand, this patch series
> > > adds benchmark for the kernel's queued spinlock implementation.
> > >
> > > This series imports necessary kernel definitions such as atomics,
> > > introduces userspace per-cpu adapter, and imports the qspinlock
> > > implementation from the kernel tree to tools tree, with minimum
> > > adaptions.
> >
> > Who is this intended to be useful for, and when would they use this?
> >
> > This doesn't serve as a benchmark of the host kernel, since it tests
> > whatever stale copy of the qspinlock code was built into the perf
> > binary.
> >
> > I can understand that being able to test the code in userspace may be
> > helpful when making some changes, but why does this need to be built
> > into the perf tool?
>
> Right, I think most of us already have a userspace version of it. I have
> a thingy that has TAS, TICKET and QSPINLOCK wrapped in a perf self
> monitor that I can run on various x86_64 to see how it behaves.
>
> IIRC it also has a pile of 'raw' atomic ops to see the contention
> behaviour. This shows that eg. XADD is *waay* nicer than a CMPXCHG loop
> when heavily contended.
>
> Anyway, that lives as a random tar file on a random machine in my house,
> I'm not sure it makes much sense to stick that in perf as such. Rather
> specific.

The intent was that the benchmark wouldn't have stale copies of files
in the same way we keep other files in perf in sync with those in the
kernel.

The inspiration for adding a benchmark this way comes from the
existing perf bench memcpy benchmark. The reason to care is that, as
with memcpy, there are subtle effects from things like RISC-V's
non-temporal atomics (ARM near-far atomics) and the size of CPU cores.
In general queued spinlock is preferred in the kernel, a benchmark of
queued spinlock and ticket spinlock may reveal that ticket spinlock
would be a better default for certain configurations.

Does it make sense to have this in perf? It makes it easier to tune
the implementations, keep code in sync with the kernel, etc. Does it
make sense for perf to have a memcpy benchmark? Maybe not these days
of having a more reliable rep movsb. Anyway, in general the bar to
getting things into perf bench hasn't been hugely high and I don't see
disagreement that on some occasions a benchmark like this is useful.
As someone who cares about this kind of performance tuning, I care
about having the benchmark.

Thanks,
Ian
