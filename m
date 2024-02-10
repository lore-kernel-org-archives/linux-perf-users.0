Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6AE5D483
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Feb 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707588531; cv=none; b=Lfi4ag45AsySgvV58CLoIRUI3xB+pbRdKGZsnSDoAtAK7CUbZ7BZ3MTcyc2RzJdTw9JvTsvppgwdN+5fr2CDQDhqCQmDGTT8DzhshBM9O2KOskd1TcU2r7KeAHssgIOYvk5we1u23FpgUpKNwyYGMPCf4RdAb0vAzatr4XSYkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707588531; c=relaxed/simple;
	bh=lcKrX2aRjFNkP4jX/gX7lMq1/swjJPiwcvS8JJ2UKac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/XBOE8aYikBA5kUx8l8ft5OJdmhlTDyJHgu3hxpYcZaqHe1rsX0W0OKtWu2JzkVkHonPRltp/6p1OuLfL0nxymkoUJnKdcIMPLhxXppCalx7nGFaLAOnxnGFYG1f6Mdl9Twr2Tk9LvP5HIpTfxFmGptciulbsJuHo4RWec+xVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ep2BltL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ep2BltL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1da120617c7so74575ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Feb 2024 10:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707588529; x=1708193329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDX7C5VgeWEhXGxm3lJpibeXlVT0VMTj0KZSmCI04qk=;
        b=3ep2BltLEN5gir0RHo2QpZrZuyUylLdYUQ5P8DRgG3Jhg1CzABm9+zSXoMfprD440G
         ktZPSs9/BhYcSPPgXftY36CPBb3PhidItAZO1FXoO6Yvybx0iOpcxgUVK7xIaKSUmrac
         3J7t8/yClwC+pS5WwYjmCz00c/EiKfRQeXmH/zwGphwzc/gbtnyFgLL8qedleupuYJFX
         VXO2AxLHm4ROXfEo3iw2BxjQjekyfkZjNPej3mfg7sNgcSqkGw8n4mn572jVCov2kjUY
         jymESrrTFH/W+F5H/V/EnshydNjkr3d74DGFgob43OXsMBRCyFFp49J/HmUZjCkYEoK0
         YIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707588529; x=1708193329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDX7C5VgeWEhXGxm3lJpibeXlVT0VMTj0KZSmCI04qk=;
        b=bXQpZ6MfkBoeSPI+INuTyXo0y9XdLp7IxSVyKqcJ0m6MEzsEWS72J5s6Xg66BcMtbU
         GI4GaFaaQA1hknvrasgw9E8pgiiroYLFYH5ihuiqtx7XId2ObGYmphz4zO+jKgfi3ZFK
         o+yVN08+XdzHnCWvfDRpixTO7l+fMqrlxsVvA0opLMYreNcY5unmgNmPflYvzpVDM6oE
         YBKWdllI1thEGPWyfnFVilIBkCjL458TnHv/t7ALif4M92BLL5eDoOSizTGuL8bWuMmN
         RhPvo96PaPkIfQ4ehGmZEFZjfjSZF3eWiv3WOm2eS1p490mutrq4J/HSvLTYJbMB1kqB
         tsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9WSkNkTzT3Ea9uox7unWoGyauu56UhnytiJ0GNdQuN7Bl6XWN4ZNZKfto3/k4M09D0AStTU0L9ajUW4ryTM2rPJUpdSwIret+2nJKQK2jcg==
X-Gm-Message-State: AOJu0YxW8rNwy+t0W0up18R94yxQtgSTYj6hkPWOEjDzNSF5vrPjsD1c
	NM2RuXyFdKn0tvJXHeMsbnSVuALNn3Drj5UREiXr35GIREGr8RO7HfW+00hcx2g68jouBv+bFTj
	43FD2N4S6JdB/OkzHJBJdsbGYHdnwnw2uc1Ke
X-Google-Smtp-Source: AGHT+IFy3H9+Iwf1AWzIzjSIJM9jx52R90mLMMKQKjC/oVRCYUD5d4W+fplaW0pXNusL1NHPcf+mHRVioCIfzLDLn9Q=
X-Received: by 2002:a17:902:c24d:b0:1d9:6c20:b900 with SMTP id
 13-20020a170902c24d00b001d96c20b900mr64520plg.7.1707588529249; Sat, 10 Feb
 2024 10:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com> <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
 <CAP-5=fUVkaq3dDoeMYYEN1N-ghnL-GiP8PV3N3pWpjQKpDTCHw@mail.gmail.com>
In-Reply-To: <CAP-5=fUVkaq3dDoeMYYEN1N-ghnL-GiP8PV3N3pWpjQKpDTCHw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 10 Feb 2024 10:08:35 -0800
Message-ID: <CAP-5=fXs8=HvjGpkLwuZBi0Hh8jtmz7=0Tp7HRgU8FOFN0GZvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] maps memory improvements and fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:46=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Feb 8, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hi Ian,
> >
> > On Wed, Feb 7, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > First 6 patches from:
> > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.=
com/
> > >
> > > v2. Fix NO_LIBUNWIND=3D1 build issue.
> > >
> > > Ian Rogers (6):
> > >   perf maps: Switch from rbtree to lazily sorted array for addresses
> > >   perf maps: Get map before returning in maps__find
> > >   perf maps: Get map before returning in maps__find_by_name
> > >   perf maps: Get map before returning in maps__find_next_entry
> > >   perf maps: Hide maps internals
> > >   perf maps: Locking tidy up of nr_maps
> >
> > Now I see a perf test failure on the vmlinux test:
> >
> > $ sudo ./perf test -v vmlinux
> >   1: vmlinux symtab matches kallsyms                                 :
> > --- start ---
> > test child forked, pid 4164115
> > /proc/{kallsyms,modules} inconsistency while looking for
> > "[__builtin__kprobes]" module!
> > /proc/{kallsyms,modules} inconsistency while looking for
> > "[__builtin__kprobes]" module!
> > /proc/{kallsyms,modules} inconsistency while looking for
> > "[__builtin__ftrace]" module!
> > Looking at the vmlinux_path (8 entries long)
> > Using /usr/lib/debug/boot/vmlinux-6.5.13-1rodete2-amd64 for symbols
> > perf: Segmentation fault
> > Obtained 16 stack frames.
> > ./perf(+0x1b7dcd) [0x55c40be97dcd]
> > ./perf(+0x1b7eb7) [0x55c40be97eb7]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x3c510) [0x7f33d7a5a510]
> > ./perf(+0x1c2e9c) [0x55c40bea2e9c]
> > ./perf(+0x1c43f6) [0x55c40bea43f6]
> > ./perf(+0x1c4649) [0x55c40bea4649]
> > ./perf(+0x1c46d3) [0x55c40bea46d3]
> > ./perf(+0x1c7303) [0x55c40bea7303]
> > ./perf(+0x1c70b5) [0x55c40bea70b5]
> > ./perf(+0x1c73e6) [0x55c40bea73e6]
> > ./perf(+0x11833e) [0x55c40bdf833e]
> > ./perf(+0x118f78) [0x55c40bdf8f78]
> > ./perf(+0x103d49) [0x55c40bde3d49]
> > ./perf(+0x103e75) [0x55c40bde3e75]
> > ./perf(+0x1044c0) [0x55c40bde44c0]
> > ./perf(+0x104de0) [0x55c40bde4de0]
> > test child interrupted
> > ---- end ----
> > vmlinux symtab matches kallsyms: FAILED!
>
> Ah, tripped over a latent bug summarized in this part of an asan stack tr=
ace:
> ```
> freed by thread T0 here:
>    #0 0x7fa13bcd74b5 in __interceptor_realloc
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
>    #1 0x561d66377713 in __maps__insert util/maps.c:353
>    #2 0x561d66377b89 in maps__insert util/maps.c:413
>    #3 0x561d6652911d in dso__process_kernel_symbol util/symbol-elf.c:1460
>    #4 0x561d6652aaae in dso__load_sym_internal util/symbol-elf.c:1675
>    #5 0x561d6652b6dc in dso__load_sym util/symbol-elf.c:1771
>    #6 0x561d66321a4e in dso__load util/symbol.c:1914
>    #7 0x561d66372cd9 in map__load util/map.c:353
>    #8 0x561d663730e7 in map__find_symbol_by_name_idx util/map.c:397
>    #9 0x561d663731e7 in map__find_symbol_by_name util/map.c:410
>    #10 0x561d66378208 in maps__find_symbol_by_name_cb util/maps.c:524
>    #11 0x561d66377f49 in maps__for_each_map util/maps.c:471
>    #12 0x561d663784a0 in maps__find_symbol_by_name util/maps.c:546
>    #13 0x561d662093e8 in machine__find_kernel_symbol_by_name util/machine=
.h:243
>    #14 0x561d6620abbd in test__vmlinux_matches_kallsyms
> tests/vmlinux-kallsyms.c:330
> ...
> ```
> dso__process_kernel_symbol rewrites the kernel maps here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/symbol-elf.c#n1378
> which resizes the maps_by_address array causing the maps__for_each_map
> iteration in frame 11 to be iterating over a stale/freed value.
>
> The most correct solutions would be to clone the maps_by_address array
> prior to iteration, or reference count maps_by_address and its size.
> Neither of these solutions particularly appeal, so just reloading the
> maps_by_address and size on each iteration also fixes the problem, but
> possibly causes some maps to be skipped/repeated. I think this is
> acceptable correctness for the performance.

An aside, shouldn't taking a write lock to modify the maps deadlock
with holding the read lock for iteration? Well no because
perf_singlethreaded is true for the test:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/rwsem.c#n17
Another perf_singlethreaded considered evil :-) Note, just getting rid
of perf_singlethreaded means latent bugs like this will pop up and
will need resolution.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Namhyung
