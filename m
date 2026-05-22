Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696202BEC2E
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430394; cv=pass; b=TmQ5cji57JKg4XsnW4lbFsh2uOPgRs1RMJ3hpfe76px4KH023f0+TJHkMoiF5e3Q+rrGFydyx24HYqvGg5CXM3YoVIkQy/EspMs3knqHb4ZcRfIZr8bO04f3PUmcAsMR7f2C+NjxSHaiuY5GEIbRJLQhl0RsT8rvS6oHSFPIHVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430394; c=relaxed/simple;
	bh=rPcpoX3Qk1Pylpp3Heuv6/28MhL7jdNIpI5VOZh8DGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1YkP62Q8DA5tp25kUP995ssMkKcY+uuUaIdCXyKlUS/7G1cSGSOD3k3EPt84Y0AXasHUG/d6BQlbaXxPsRIWkb7x/2qPI20YijLTrEBF7Qhm+77+q29ouUdgGNI8SIfX8outpDqZZztDkz0VG6zb/6xLCYTSeeVChExOe4MB8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4bD3XFa; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4bD3XFa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba180a022dso1605ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 23:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779430391; cv=none;
        d=google.com; s=arc-20240605;
        b=Q37/78eiUB1hwEww/Z5wAWcvKyYKiJzqxYNTQycyCFJMsGXvO2xSWz5Gvljye0fwZy
         Y+vIfxU21l/WVvHeu/r96F4xU/q7oSXOg/wEwzbD14G70qaEvZ8ZXbMTtDI2q0RN6olS
         GJ8BeBpDH7Ib4XhXB8wwPqRnkUZb/YWXWUm3ez+mQhKMcLCBS3yIpCVheTmQGxC+ayDG
         Hhjmbi5EFwbwRnp3vql70nb419Dp9fD09rBRkpvGGTUN+V2MXNWvOtFJlDLdWAkwV6GS
         Z0eFoIJ6yyuDRDp7KsWEn8iMbC1TCsrTcxjTK6WGdbNMXYQRLqTQ+UHDfE5sWk09r9mS
         7e1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lr4QtBfhsyhGZcG8eATYUHSKcornWThV5QKB+uCzZ+Y=;
        fh=r4SIQ35QuSP/r6ZZJF58XEOKXbFbkTLQ+Zwaqnyg5g4=;
        b=EVLOQaJIX3uWTrppa3zmVwVvNQ63txExYyhpHiw9vrOt8OC66moEdAZwhj+B/5xVF/
         nNOITxGrhEzMIfphlc11AsxxWBQ019uSIx02Dh1x6NYKdHBGRslZrxjUei56UafyM25U
         uvofG2SeqYA6MKBmJKCIpE84sMTuvEC6YEo8FGN2BNk6AAIunzpozUgE6DLCA75vlnPT
         AoKnlR7Clf0wGsrpuf06QGlR+agLsepON1dwvJOWAHsng8dvgMciGKn5FnMv6AUxfI8t
         gYlOP1ql2x71MN8FsZUs5IYM7YHWYR/IeOypezUXzu0+BqTCgFPjUrg/oyjX5A5acvgK
         SWcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779430391; x=1780035191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr4QtBfhsyhGZcG8eATYUHSKcornWThV5QKB+uCzZ+Y=;
        b=a4bD3XFaG3EpEHSX7uOpEmAAWEoa+Ub3yrCrYWFadDSk4tTza8qqDHdE9MGM9RO6of
         HQLwZYjBIAYzzPVy/6XPpwjOJ5Nn3ugrwo8dlnQ63zJLhPFikcf8WsMJ24ysp2qoEs6o
         5x0az1krO84K98rDuj2Ar0g5OrCPRzTJAdxRXI067rOtjA0HDbpOFjeJudgosNWkdNi7
         ZzI8yW6cSxGde7aRDG2YwPNMyT3WisII9g9XU6iCgMKZ3nfUxRZzAy3w7+HwPE3x3eLH
         gEbZMjkjXT4ltthQExSTTx978i4UoIdDDGWaCaEnIAIdLpNC+bANwB2AZb9rrr3BtGZQ
         H7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779430391; x=1780035191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lr4QtBfhsyhGZcG8eATYUHSKcornWThV5QKB+uCzZ+Y=;
        b=TqUtHp9Sgn9MklUVkSO4zCzDELg+vRGji7BxGYuxOYzSC5mC0PQkPlmeiKYRMn/JQ8
         +HAxj7//kYm0tw3sThvKOB9aGfqfXuDIEs4qdYivH7RkSZGV12eFkniG+I3zaWSxWZgp
         L5G8vkZ+Kqo+ytzzJ3jW1pvrG+FVq6O9TnlReQS+xYMcDSV/RsIVDte6UWKS8vCzkqY5
         mlMuss1vxgh52d1okAWRnIoGoeFqkOYvzrEZRhC8MI0V8OjosONX8+tVxNJGXrmAvpdP
         S8hkLlD6MWY506kVKnxYnp4qAdAXZ2vbv9HBVg4/4+/aOjjZLTLtDR0Wz5qiv+TqdH05
         MS8g==
X-Forwarded-Encrypted: i=1; AFNElJ9m+peU4TM2nCZ9f/DvYLWAvGZvfY/mG4lezTxAMhwLghnzltxZ3Z8WBeTGBRIHPbHcRhMfcjI3johdq00bL02b@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxl7XPa9hGnli8xGub7VIaKDO5Nwfr+bkKCKKoXQxm+XWfzD+W
	0KXS+OyRAIxxZillPX7ckBz1d6firDQRKD3WBHkDvwpfVs1NAaI0opbofkr+CQtraECveFC2lXz
	XNGc/69pdtny2lPv2WmdyyOYtHwsmrADNWmncJJaU
X-Gm-Gg: Acq92OExC5v+nqZFg4m2r+9fahkb1eCfzH+v0HNX1aMaK7+z+3rEf30TT04YeJO1B2d
	fSsnOl0pq/m5GKynlQJz5FlFj4fL8GFrsbaIgf4z92h2/9hgSYI5a9z0HRBBU/BKE7rkiwNIq9d
	OqMKc8EBX3D4gW9umGhqfJEbuEZ9pVUFnFUm19F76VYxe/3ksxX5bo55GH8R8A736t8+DlHQrxa
	v4p8qOzSwvRM4FOyDsUcdHp1FxZMaPMHz1IZtjxOkvU8VYPNxHg0rwzaNl8LFzqtH73/eNxr9vv
	0UNF0xsa7T/kMVtHSmk=
X-Received: by 2002:a17:903:3c4d:b0:2bd:6dad:7cca with SMTP id
 d9443c01a7336-2beb1b658cemr1180455ad.22.1779430391073; Thu, 21 May 2026
 23:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1> <ag4PpWl-wV7SDpd5@x1> <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1> <ag4e1BNQlZWVWISE@x1>
In-Reply-To: <ag4e1BNQlZWVWISE@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 May 2026 23:12:54 -0700
X-Gm-Features: AVHnY4K_YjoYwc33WRwzKH411ugSALQOiJtS3o7vjCvDA7TS3hWu7FKTEEF6zO4
Message-ID: <CAP-5=fV2hoKa+rCA89jW3CuFnZ71Q_ZYxJhSOYp+CHKtBu7r2g@mail.gmail.com>
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 1:51=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 20, 2026 at 05:49:57PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 20, 2026 at 01:40:48PM -0700, Ian Rogers wrote:
> > > On Wed, May 20, 2026 at 12:46=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > > > > > Nearly all perf code ends up passing an evsel with the perf_sam=
ple,
> > > > > > which is problematic if you want to rewrite the evsel (such as =
with
> > > > > > off-CPU processing) because all uses of the evsel need to be fi=
xed
> > > > > > up. Since the perf_sample now carries its own resolved evsel po=
inter,
> > > > > > passing evsel separately is redundant and error-prone (allowing
> > > > > > parameter divergence bugs).
> > > > > >
> > > > > > This series cleans up the redundant evsel parameter across all =
perf
> > > > > > tool subcommands and APIs, ensuring that tools uniformly retrie=
ve
> > > > > > event attributes directly from the sample itself. This simplifi=
es
> > > > > > function signatures and improves API consistency.
> > > > > >
> > > > > > Additionally, this series incorporates subsequent memory safety
> > > > > > improvements, robust bounds checking, and memory leak correctio=
ns
> > > > > > prompted by address sanitizers and Sashiko code reviews.
> > > > > >
> > > > > > The original combined RFC patch:
> > > > > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@go=
ogle.com/
> > > > > > was split up per reviewer requests.
> > > > > >
> > > > > > v14:
> > > > > >  - Incorporate Acked-by tags from Namhyung Kim.
> > > > > >  - Re-polish and expand commit descriptions to provide thorough=
 explanations
> > > > > >    of the changes and their rationale.
> > > > >
> > > > > Thanks, tentatively applying it to perf-tools-next, for v7.2.
> > > >
> > > > Had to apply a minor fixup for a conflict with anoter patch series =
from
> > > > you, the LBR one.
> > >
> > > Sorry for that and thanks for dealing with the conflict! Any chance
> > > you could push to tmp.perf-tools-next? I have some other series that
> > > will conflict and it would be nice to rebase those changes there.
> >
> > I just removed the last two patches, the ones for kwork, as:
> >
> > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D NO_LIBELF=3D1 -C tools/=
perf O=3D/tmp/build/perf
> > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> > Makefile.config:647: Warning: Disabled BPF skeletons as libelf is requi=
red by bpftool
> > Makefile.config:745: Disabling post unwind, no support found.
> > Makefile.config:856: Missing python setuptools, the python binding won'=
t be built, please install python3-setuptools or equivalent
> > Makefile.config:1045: No libbabeltrace found, disables 'perf data' CTF =
format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > Makefile.config:1110: libpfm4 not found, disables libpfm4 support. Plea=
se install libpfm-devel or libpfm4-dev
> > Makefile.config:1135: Rust is not found. Test workloads with rust are d=
isabled.
> >
> > Auto-detecting system features:
> > ...                                   libdw: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                             libcapstone: [ on  ]
> > ...                               llvm-perf: [ on  ]
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
> > ...                              libopenssl: [ on  ]
> > ...                                    rust: [ OFF ]
> >
> >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
> > <SNIP>
> >   LINK    /tmp/build/perf/perf
> > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_pop_atom':
> > builtin-kwork.c:(.text+0x59c92): undefined reference to `work_exit'
> > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_push_atom.con=
stprop.0':
> > builtin-kwork.c:(.text+0x5aba8): undefined reference to `work_exit'
> > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `cmd_kwork':
> > (.text+0x5bb4b): undefined reference to `work_exit'
> > /usr/bin/ld: (.text+0x5bbae): undefined reference to `work_exit'
> > /usr/bin/ld: (.text+0x5c3b2): undefined reference to `work_exit'
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [Makefile.perf:586: /tmp/build/perf/perf] Error 1
> > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > make: *** [Makefile:76: all] Error 2
> > make: Leaving directory '/git/perf-7.1.0-rc2/tools/perf'
> > + exit 1
> > toolsbuilder@five:~$
> >
> >
> > I'm doing some more tests, just a moment and I'll push what I have to
> > tmp.perf-tools-next.
>
> Also:
>
> toolsbuilder@five:~$ cat dm.log/almalinux\:8
> <SNIP>
> OLLECT_GCC=3Dgcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
> OFFLOAD_TARGET_NAMES=3Dnvptx-none
> OFFLOAD_TARGET_DEFAULT=3D1
> Target: x86_64-redhat-linux
> Configured with: ../configure --enable-bootstrap --enable-languages=3Dc,c=
++,fortran,lto --prefix=3D/usr --mandir=3D/usr/share/man --infodir=3D/usr/s=
hare/info --with-bugurl=3Dhttp://bugs.almalinux.org/ --enable-shared --enab=
le-threads=3Dposix --enable-checking=3Drelease --enable-multilib --with-sys=
tem-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-=
unique-object --enable-linker-build-id --with-gcc-major-version-only --with=
-linker-hash-style=3Dgnu --enable-plugin --enable-initfini-array --with-isl=
 --disable-libmpx --enable-offload-targets=3Dnvptx-none --without-cuda-driv=
er --enable-gnu-indirect-function --enable-cet --with-tune=3Dgeneric --with=
-arch_32=3Dx86-64 --build=3Dx86_64-redhat-linux
> Thread model: posix
> gcc version 8.5.0 20210514 (Red Hat 8.5.0-28) (GCC)
> + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D -C tools/perf O=3D/tmp/bu=
ild/perf
> make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Makefile.config:1045: No libbabeltrace found, disables 'perf data' CTF fo=
rmat support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1061: No libcapstone found, disables disasm engine suppor=
t for 'perf script', please install libcapstone-dev/capstone-devel
> Makefile.config:1110: libpfm4 not found, disables libpfm4 support. Please=
 install libpfm-devel or libpfm4-dev
> Makefile.config:1135: Rust is not found. Test workloads with rust are dis=
abled.
>
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                               libpython: [ on  ]
> ...                             libcapstone: [ OFF ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> ...                              libopenssl: [ on  ]
> ...                                    rust: [ OFF ]
>
>   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
>   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
> <SNIP>
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/cache.json
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/counter.json
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/floating-poi=
nt.json
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/frontend.jso=
n
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/memory.json
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/other.json
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/pipeline.jso=
n
>   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/virtual-memo=
ry.json
>   GEN     /tmp/build/perf/pmu-events/test-empty-pmu-events.c
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 1524, in <module>
>     main()
>   File "pmu-events/jevents.py", line 1487, in main
>     with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_worke=
r, initargs=3D(_arch_std_events,)) as executor:
> TypeError: __init__() got an unexpected keyword argument 'initializer'

The `initializer` and `initargs` parameters were added to
`concurrent.futures.ProcessPoolExecutor`.futures.ProcessPoolExecutor
in Python 3.7. Python 3.7 is past its end of life and the kernel build
specified that Python 3.9 is the minimum supported:
https://docs.kernel.org/process/changes.html
A fix for this is to disable jevents for older Python versions, but
detecting this will incur a build-time cost.

Thanks,
Ian

> make[3]: *** [pmu-events/Build:176: /tmp/build/perf/pmu-events/test-empty=
-pmu-events.c] Error 1
> make[3]: *** Deleting file '/tmp/build/perf/pmu-events/test-empty-pmu-eve=
nts.c'
> make[2]: *** [Makefile.perf:554: /tmp/build/perf/pmu-events/pmu-events-in=
.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>
