Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F814884C
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931711; cv=none; b=UziHoQO9cX0kA9ti0ZmmPXtrUYHJX55swz6pOEnJr1R6KCMfr0EAGwSDF4SOOWQnNmgISSg63gQ6kqHyfqBB3fdAfU3rBX635DfTuIKAxeOsDSlGEx11RUGxTC4uhjMb6C6339tOJS5IwKPfXR0GYctnjFGX1k/UwQreHd2B5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931711; c=relaxed/simple;
	bh=urZDD7SqMI1dPeUfSX17Ch/qC8OVmVTVKPjzd7UPYPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOp9CN24/LN9juv675RX9mjy2Uk8RMhS3gjhhjaJeKjh58YFFAsFfvBnA2AvdXK2FAjBYt1tqxE93Q5VVbel2wBTgTaUrESrInFSb1NF7tMFgxetJDs6t6PlJVOQ/DFzgKoyd6Ol5V+Fm5Y597F55oOAk+O9U7SmaEkIBCErYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T43dQIdq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T43dQIdq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242aca53efso63375ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 22:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741931708; x=1742536508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyhsHWhKQvd+JYS7FBXku46dzZupP9OzOBkxq4HnRPc=;
        b=T43dQIdqyp3ytr1kRatF9RVwnfYguJH8eH6Z8hG5m9i5cOottoKMBaATR0yWKSq+34
         qNVZJ6MuekSYZNME0YEHBB5R5OH5oSl3ZzjKTnt8m/moqURrMyYf/ng61i6O89aAnCgT
         A41VwfCIKOhW8FelbyC/Htx8DCErw4vjNyv3WOTK6vVetBkdENBDqwAep00dUdVIXF2T
         q6yU7jJlwhbJobh7poKv6wGkkIXuuzSvWGBPJhDggqvgz06dzNd0O/0OD4BFya7v2/CD
         0YZQWdDGnPUiUqCRGBnU21y54iYhIrN4CxLfTlPn0HBZqtBKUKtGwZkCqk/v+PPRWL9m
         O+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741931708; x=1742536508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyhsHWhKQvd+JYS7FBXku46dzZupP9OzOBkxq4HnRPc=;
        b=mBoZKW7Qw9/8vYGbtqwLdPHEFjexTopTO/wHUzT5AsQ1O2k7BFjVdCddCzwmgLUtOZ
         MWtQ/qxzUGpkZSTsdcYPMRYf6wCw210CBFRfJgjz18dUmkHElSQHq54m90f5GrcpkbAt
         My3NXL94Bb3lhYx6jJ2bysbeDpLBwFODygASBwizU8w+7H6yiBTrDZCixI6i80zt2L74
         5/TZ2b7LGBqdW/EPAmx+S2zskUXf0qbokCf1FNaSe/VNyaycxXpdw0seJxyny7/EXYsb
         XXKOEogj/lyS9CPWsdL+Y3kR0mUapogMhE5d9ITf01tx6WGlIbGPNNZhd/fc6l1+uyXP
         NrfA==
X-Forwarded-Encrypted: i=1; AJvYcCWtNecL8K4Oyy5W93hacBblEQMXszef1NKbHro8YtcB29pmdyvUsGS/MPmddZXj0ZdVqyTXPD/oxH4NWVtb33Jf@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyN5vuodC/TNWmr0RQHFvAfuvdiej30V3oZ/gVw26AlfY+aNU
	qeVvF83+kerfRtSbAjv3d/Yk617lVl8GehVLxcjDiy/r4cfVr/oNXSwCzvOnhI5uPU1n3D0INBF
	8To8QssqKBxWO6Ew9fHNebhnFIR/Sidlf9El3
X-Gm-Gg: ASbGncvmN6Q9Xats/XgtEHXCBZwxKYkOU73evyH9Ykg7RRouZ7ceYH+Hp9DSbddYUAG
	u+OK2+56qAREab86Di9Pa4YzX/laVp1fE+ns5ZIFGArMb7zSUZlezfVJf9+DhVD43dWOnHXBYSH
	aDjFz82S6JsVVAreAXfSLGsbmNQ7s=
X-Google-Smtp-Source: AGHT+IEgLWIAjxCjYNH0X+NtNqkuwI/bPH4Uumyk01Hxp41RAM67Lx0FYNOYHRHcAIdc8VeJeEOB7hLlngI/eMqwcbI=
X-Received: by 2002:a17:902:d509:b0:21f:4986:c7d5 with SMTP id
 d9443c01a7336-225de74a016mr2010415ad.8.1741931708229; Thu, 13 Mar 2025
 22:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
 <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
 <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com> <Z9NbFqaDQMjvYxcc@google.com>
In-Reply-To: <Z9NbFqaDQMjvYxcc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Mar 2025 22:54:57 -0700
X-Gm-Features: AQ5f1JpmtjskMcZorXzTagF_PQQ_b8arX_0AF-lPzn55eWXEmzSyGiUvOZGlAFk
Message-ID: <CAP-5=fUdXRv512ZFiQKtxouNzN+HgommWGF3Pje1Tcuxg=J78Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Mar 12, 2025 at 02:04:30PM -0700, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 10:06=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Thu, Jan 23, 2025 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > > On Thu, Jan 23, 2025 at 1:59=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > > I like changes up to this in general.  Let me take a look at the
> > > > > patches.
> > >
> > > So it would be nice to make progress with this series given some leve=
l
> > > of happiness, I don't see any actions currently on the patch series a=
s
> > > is. If I may be so bold as to recap the issues that have come up:
> > >
> > > 1) Andi Kleen mentions that dlopen is inferior to linking against
> > > libraries and those libraries aren't a memory overhead if unused.
> > >
> > > I agree but pointed-out the data center use case means that saving
> > > size on binaries can be important to some (me). We've also been tryin=
g
> > > to reduce perf's dependencies for distributions as perf dragging in
> > > say the whole of libLLVM can be annoying for making minimal
> > > distributions that contain perf. Perhaps somebody (Arnaldo?) more
> > > involved with distributions can confirm or deny the distribution
> > > problem, I'm hoping it is self-evident.
> > >
> > > 2) Namhyung Kim was uncomfortable with the code defining
> > > types/constants that were in header files as the two may drift over
> > > time
> > >
> > > I agree but in the same way as a function name is an ABI for dlysym,
> > > the types/constants are too. Yes a header file may change, but in
> > > doing so the ABI has changed and so it would be an incompatible chang=
e
> > > and everything would be broken. We'd need to fix the code for this,
> > > say as we did when libbpf moved to version 1.0, but using a header
> > > file would only weakly guard against this problem. The problem with
> > > including the header files is that then the build either breaks
> > > without the header or we need to support a no linking against a
> > > library and not using dlopen case. I suspect a lot of distributions
> > > wouldn't understand the build subtlety in this, the necessary build
> > > options and things installed, and we'd end up not using things like
> > > libLLVM even when it is known to be a large performance win. I also
> > > hope one day we can move from parsing text out of forked commands, as
> > > it is slower and more brittle, to just directly using libraries.
> > > Making dlopen the fallback (probably with a warning on failure) seems
> > > like the right direction for this except we won't get it if we need t=
o
> > > drag in extra dependency header files for the build to succeed (well
> > > we could have a no library or dlopen option, but then we'd probably
> > > find distributions packaging this and things like perf annotate
> > > getting broken as they don't even know how to dlopen a library).
> > >
> > > 3) Namhyung Kim (and I) also raises that the libcapstone patch can be
> > > smaller by dropping the print_capstone_detail support on x86
> > >
> > > Note, given the similarity between capstone and libLLVM for
> > > disassembly, it is curious that only capstone gives the extra detail.
> > >
> > > I agree. Given the capstone disassembly output will be compromised we
> > > should warn for this, probably in Makefile.config to avoid running
> > > afoul of -Werror. It isn't clear that having a warning is a good move
> > > given the handful of structs needed to support print_capstone_detail.
> > > I'd prefer to keep the structs so that we haven't got a warning that
> > > looks like it needs cleaning up.
> > >
> > > 4) Namhyung Kim raised concerns over #if placement
> > >
> > > Namhyung raised that he'd prefer:
> > > ```
> > > #if HAVE_LIBCAPSTONE_SUPPORT
> > > // lots of code
> > > #else
> > > // lots of code
> > > #endif
> > > ```
> > > rather than the #ifs being inside or around individual functions. I
> > > raised that the large #ifs is a problem in the current code as you
> > > lose context when trying to understand a function. You may look at a
> > > function but not realize it isn't being used because of a #if 10s or
> > > 100s of lines above. Namhyung raised that the large #ifs is closer to
> > > kernel style, I disagreed as I think kernel style is only doing this
> > > when it stubs out a bunch of API functions, not when more context
> > > would be useful. Hopefully as the person writing the patches the styl=
e
> > > choice I've made can be respected.
> > >
> > > 5) Daniel Xu raised issues with the removal of libbfd for Rust
> > > support, as the code implies libbfd C++ demangling is a pre-requisite
> > > of legacy rust symbol demangling
> > >
> > > A separate patch was posted adding Rust v0 symbol demangling with no
> > > libbfd dependency:
> > > https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.c=
om/
> > > The legacy support should work with the non-libbfd demanglers as
> > > that's what we have today. We should really clean up Rust demangling
> > > and have tests. This is blocked on the Rust community responding to:
> > > https://github.com/rust-lang/rust/issues/60705
>
> I think #ifdef placements is not a big deal, but I still don't want to
> pull libcapstone details into the perf tree.
>
> For LLVM, I think you should to build llvm-c-helpers anyway which means
> you still need LLVM headers and don't need to redefine the structures.
>
> Can we do the same for capstone?  I think it's best to use capstone
> headers directly and add a build option to use dlopen().

So I don't disagree. If we have headers but someone wants dlopen,
let's use the headers and let them use dlopen. Unfortunately the way
the build is set up isn't for that. The build assumes either:
1) you have libcapstone and its headers and want to link against it,
2) you don't have libcapstone and support is just removed.

In the changes the options become:
1) unchanged, if you have libcapstone then use the headers and link
against - this is Andi's preferred approach,
2) if you don't have libcapstone dlopen is used with constants derived
from pahole and baked into the sources - much as we do for vmlinux.h
in BPF programs.

One way to achieve what you are asking for is to make the build do:
1) the link against libcapstone approach that needs the headers,
2) the dlopen with capstone.h headers,
but we need a way to build without libcapstone, so we get:
3) possibly dlopen with pahole derived constants - but if we have that
then why do 2?
4) a no support option.

The problem is that if we don't do (3) then (4) will become the no
libcapstone option and frankly people who care will do (1) and so (2)
becomes redundant.
It was intentional doing the changes the way I have so that when you
don't build with libcapstone, were you later to add the library you
would gain support for it. This is with the down side of a small
number of constants being in the code. Potentially these could change
in the header files, but any such change is an ABI breakage and so
unlikely to happen. So I think the way the patches have things set up
is best.

Thanks,
Ian
