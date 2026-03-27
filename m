Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D1392C48
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644124; cv=pass; b=RypSRb3PzZedOQJNIi0WKAGubZvIFqcwDpEmCOiwBZHFyr0cIPEEfWn9wjIHijLBoWq5f3rue30ByGyHByt3EfajKTEgzN5W0tLn/vnQ4ru5JBaVSJAwrl7JAKvTyCbsZHHcw4Thv4QaBIElVZx5KXNKJGW2m+v768vHViJNJ7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644124; c=relaxed/simple;
	bh=lPdP9vq4wVxFO6psCJasPHdmePqpS1aTjm1D2ZUKjUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0o/Lnq8R71Ha5Dr47jHE3nY0uEs96+9wcCsSOuPZTR0tKje0c4w2xXkItEwECvv0Bf7Avtqu9y+7gxt3wo+lXdr3UCKCDAa+J/t3SluxxZl303o/KFAD2TN26HKJ4jIBEQTv3Bh+GSm0rUj9K8oH3owwMBATgg5VDSuxo2hRW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpKV2KGB; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpKV2KGB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0c12be0ecso24455ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 13:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774644122; cv=none;
        d=google.com; s=arc-20240605;
        b=BNA0J6Oz0nxy2R4av9V2qExHkCQkFJvOq0++vmHASLDin2LizQZFo2Bys1M3EQ4K8P
         oo0ZZCy8lsCB2gBpD8judet0zosC0h4ZR2Aoxc3bBl5qmDpDRBhb4bXwpQt/i0Lg0kxp
         MkdytLeZ7bLGKoBMvMiNVUh7ThL8f6ncv1dE2TwokazGwka+5t2AZ2fp8Q0EHeggf37e
         ExTZOQFrbOleHdaSmYddoYIILpl6DMysp8plzxdvQHSGQvKBLWJJvn8ybGRtM51tPoJb
         5lBJkgN89LhE+jidSWWXjvwlO1q9lXmyPGxyFwrfpuBMmeNopAlzU8rAu9RBkDOADqBx
         BFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LKsbZqDOW86RsCflURAsrZ3I5A4IHa/xWNZwWLO0QRg=;
        fh=P1exl2rgJlqIMZMiiNANSFehLEZX6TTt5c6veqM5L/E=;
        b=NrMOC+oHgdwbGWz8SRg3FYE8ZRlFZvu3WK2O1oJTxVmPG1LM10fnQ2HWx2sxDve/8Q
         UJm5j2uJe2tAkq7QWPF0MDZuWa6KKP51CKoXXJJYKrbmWOBgvnP2dlvAzy+qONQex8/x
         twN6zFimZlL41AfDRZlR482zN8H9Kfqh5dAL34xG8mhpYltDPt2zETKKFksf5sfPJWiA
         mvjzolnecYo9OPFrYmG6ZAN8OMmWxJuKFcfUcmrb2BALhcxI/whalUDbIdRrK70eH21K
         4lTi5D8Oa7IMSvYFLvQO3X2IyxXQKhsekJUADrJtPfZw1nmgrd2R1xoKFucSSFdUqS2G
         QeKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644122; x=1775248922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKsbZqDOW86RsCflURAsrZ3I5A4IHa/xWNZwWLO0QRg=;
        b=CpKV2KGB3DajLZKNaDC6h+5AUrWzhb4lQVSMeH5K7MYkYnBOf5bDwuqMZNCk3P3ohs
         VEfjxy9wNwjiUk2EPrl0trJr0+vn9+qpfF63ynWiycSXdtPWx6Y6N3DIbrRa/G7GJLR8
         YitHurlYg1oikg2i1UkLAAgka9P2pM4y12Gw0ufbk6cZNenO8CRvf3/oOiPks80/hj1d
         WaEZD3Eq5AJKaz9NNYLXqX7fCmaky11Kg3kwzAGh/6g+FEn09ABk+q6QBwKnw9z5jkXj
         IfAd5BKKGDHjgNWajc9EXTie0SCyR4lYbWyd7iDD+Bc2ovy66Tp5TPJ+D1+yw/posrUP
         Of4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644122; x=1775248922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKsbZqDOW86RsCflURAsrZ3I5A4IHa/xWNZwWLO0QRg=;
        b=tJYvavtQs75UiEv0DdQUd8FSU0z8et0Cu4BV4c2Od6oTu4EpJ3TzEDlIhS/FYNcRZQ
         5cNM4c5Ar5DOSatR4AzRxucLth3cVPjppWbP+Qb37ed9XtoBsa3fPShMqyudwaiRf5nt
         TjQ2DK0c5VT7OJHTXwLX6HMUoMd/yR7w1wq1PuHc33EMzfLzZW5G9Tq24mzSclAcVIbX
         mwP4jflnBY6do73OeWSTEKGeYhMFWEicBtuvCmN60fh/Q65h05eestv85HonP//d85k5
         LRDDFhZnypcaUKSTvMePMMoO+vnhcAfMcfKbGyAwSua5U9GZMC5tD/9wv3ehbH+avXof
         5HPA==
X-Forwarded-Encrypted: i=1; AJvYcCX8HVpOYPQ2kogAfmKgevT0gJIsz+S3e9W7gXqC9nMhDl/x3qPXQpVd9lqa9cGrmO3YEvX5DxJLbJ8gbLWnzunG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BMsuC2jLgWO8CjG/2AvNTuORiEOZkQQaPGjB8xLgMXgsoR4R
	PpYsy+vyLxB3WyQOAuSdzWZYIX7eZE498QpQCzh3p6H13a5fcxZ1e+fnLyqyVQJv6/V81Zhvjlt
	cuj6VoXS46yXV7YCduckvGnu3LwdoAtiddmyV4wN5
X-Gm-Gg: ATEYQzzSBiuaxuF/hykY6+GomGdMFtsDZGj6mDNje56hNxdWJHTbP4OBUb/vjahKhjA
	54u/Ue0FsfiPYvEruj0sYCeMqfAWeBDVwAU1Fjtp3daSxhMURvW0mRsoXCCibzDTrt4BaX9yzQP
	YyRqqucXOGwXRc9J5/TZ0p6doXk4XGxWA/3GvtEZQGslBiU267PbnFWTyitFbgaFhIWJU5aV9ux
	ZCj2X2xB9DRTZn4SqohZ5x86vWMyf6COOUTtjGNUKghjubYBrf+Xnw3siulzhMfafz8DpmdLjeY
	SHujF7zh
X-Received: by 2002:a17:902:d4cc:b0:2b0:5683:1cf with SMTP id
 d9443c01a7336-2b242ccce8cmr135195ad.13.1774644121683; Fri, 27 Mar 2026
 13:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abxs-2rozL1tBEO1@google.com> <20260321234220.848859-1-irogers@google.com>
 <acW4Z2KJbyPZM1SG@google.com> <acbjjwc-WCk1CwtF@x1> <CAP-5=fXmBpqP86FT85sA_BZYRnzwbZ5joYLogCqON6fjXCkRHQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXmBpqP86FT85sA_BZYRnzwbZ5joYLogCqON6fjXCkRHQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Mar 2026 13:41:50 -0700
X-Gm-Features: AQROBzB293WK_qIpuDSMa7sKWXMjW4ObLUph7AAbCdTdiYjV0_7RiXziOkhHK1g
Message-ID: <CAP-5=fVVYobbD62SvM=MyTjhKFzBB09-mRykJGB9QVYOMth6mA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf build: Remove libunwind support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org, amadio@gentoo.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:37=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Mar 27, 2026 at 1:07=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Mar 26, 2026 at 03:51:19PM -0700, Namhyung Kim wrote:
> > > On Sat, Mar 21, 2026 at 04:42:18PM -0700, Ian Rogers wrote:
> > > > libunwind support exists for "--call-graph dwarf", however, libunwi=
nd
> > > > support has been opt-in rather than opt-out since Linux v6.13 as li=
bdw
> > > > is preferred - commit 13e17c9ff49119aa ("perf build: Make libunwind
> > > > opt-in rather than opt-out"). A problem with the libdw support was
> > > > that it was slow, an issue fixed in Linux v7.0 in commit 6b2658b3f3=
6a
> > > > ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every
> > > > unwind"). As such libunwind support is now unnecessary.
> > > >
> > > > The patch series:
> > > > https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@googl=
e.com/
> > > > looked to make the libunwind support in perf similar to the libdw
> > > > support, allow cross-architecture unwinding, etc. This was motivate=
d
> > > > by the perf regs conventions being altered by the addition of x86 A=
PX
> > > > support:
> > > > https://lore.kernel.org/lkml/20260209072047.2180332-1-dapeng1.mi@li=
nux.intel.com/
> > > > It is necessary to translate the library's notion of registers to t=
he
> > > > perf register convention so that the stack unwinding state can be
> > > > initialized. On this series it was stated that removing libunwind
> > > > support from perf should be an option, rather than updating support=
:
> > > > https://lore.kernel.org/lkml/abxs-2rozL1tBEO1@google.com/
> > > > This was also what motivated making libunwind opt-in rather than
> > > > opt-out.
> >
> > > > Given that 7 minor releases have happened with libunwind "deprecate=
d"
> > > > by making it opt-in, let's remove the libunwind support. There does=
n't
> > > > appear to be any disagreement to this on the mailing list.
> >
> > > I'm not sure if we want to remove it now.  I think we need more time =
to
> > > verify libdw unwinding is stable and fast enough.  Also maybe we can
> > > add build- or run-time warning when people try to use libunwind.
> >
> > We have:
> >
> > acme@x1:~/git/perf-tools$ perf -vv | grep LIBU
> >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprec=
ated, use LIBUNWIND=3D1 and install libunwind-dev[el] to build with it )
> > acme@x1:~/git/perf-tools$
> >
> > acme@x1:~/git/perf-tools$ perf check feature libunwind && echo perf bui=
lt with libunwind
> >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprec=
ated, use LIBUNWIND=3D1 and install libunwind-dev[el] to build with it )
> > acme@x1:~/git/perf-tools$
> >
> > Building with both, as Ian mentioned ends up with:
> >
> >   LD      /tmp/build/perf-tools/util/perf-util-in.o
> > ld: /tmp/build/perf-tools/util/unwind-libunwind.o: in function `unwind_=
_get_entries':
> > unwind-libunwind.c:(.text+0x2a0): multiple definition of `unwind__get_e=
ntries'; /tmp/build/perf-tools/util/unwind-libdw.o:unwind-libdw.c:(.text+0x=
940): first defined here
> > make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:164:=
 /tmp/build/perf-tools/util/perf-util-in.o] Error 123
> > make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158:=
 util] Error 2
> > make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] =
Error 2
> > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > make: *** [Makefile:119: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> > =E2=AC=A2 [acme@toolbx perf-tools]$
> >
> > So what Namhyung is suggesting is to disable libdw when libunwind is
> > asked for?
> >
> > I.e.
> >
> > alias m=3D'rm -rf ~/libexec/perf-core/ ; make LIBUNWIND=3D1 NO_LIBDW=3D=
1 -k O=3D/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf tes=
t "import python" && cat /tmp/build/$(basename $PWD)/feature/test-all.make.=
output' ; export PYTHONPATH=3D/tmp/build/$(basename $PWD)/python
> >
> > Which builds and ends up linking with both:
> >
> > =E2=AC=A2 [acme@toolbx perf-tools]$ ldd ~/bin/perf | egrep unwind\|dw
> >         libunwind-x86_64.so.8 =3D> /lib64/libunwind-x86_64.so.8 (0x0000=
7fbf430b6000)
> >         libunwind.so.8 =3D> /lib64/libunwind.so.8 (0x00007fbf4309b000)
> >         libdw.so.1 =3D> /lib64/libdw.so.1 (0x00007fbf38570000)
> > =E2=AC=A2 [acme@toolbx perf-tools]$
> >
> > I.e. that NO_LIBDW isn't really disabling linking with it, just some
> > features based on it, likely.
> >
> > Hum, we also have NO_LIBDW_DWARF_UNWIND, which probably is what we want
> > here... nope:
> >
> > =E2=AC=A2 [acme@toolbx perf-tools]$ alias m=3D'rm -rf ~/libexec/perf-co=
re/ ; make LIBUNWIND=3D1 NO_LIBDW_DWARF_UNWIND=3D1 -k O=3D/tmp/build/$(base=
name $PWD)/ -C tools/perf install-bin && perf test "import python" && cat /=
tmp/build/$(basename $PWD)/feature/test-all.make.output' ; export PYTHONPAT=
H=3D/tmp/build/$(basename $PWD)/python
> > =E2=AC=A2 [acme@toolbx perf-tools]$ m
> > rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Tra=
ce-Util/lib/Perf/Trace/__pycache__/Core.cpython-314.pyc': Permission denied
> > make: Entering directory '/home/acme/git/perf-tools/tools/perf'
> >   BUILD:   Doing 'make -j12' parallel build
> > Warning: Kernel ABI header differences:
> >   diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/a=
sm/svm.h
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
> > ...                                    rust: [ on  ]
> >
> >   INSTALL libsubcmd_headers
> >   INSTALL libperf_headers
> >   INSTALL libapi_headers
> >   INSTALL libsymbol_headers
> >   INSTALL libbpf_headers
> >   LD      /tmp/build/perf-tools/util/perf-util-in.o
> > ld: /tmp/build/perf-tools/util/unwind-libunwind.o: in function `unwind_=
_get_entries':
> > unwind-libunwind.c:(.text+0x2a0): multiple definition of `unwind__get_e=
ntries'; /tmp/build/perf-tools/util/unwind-libdw.o:unwind-libdw.c:(.text+0x=
940): first defined here
> > make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:164:=
 /tmp/build/perf-tools/util/perf-util-in.o] Error 123
> > make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158:=
 util] Error 2
> > make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] =
Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > make: *** [Makefile:119: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> > =E2=AC=A2 [acme@toolbx perf-tools]$
> >
> > I expected NO_LIBDW_DWARF_UNWIND=3D1 would resolve this case, and maybe=
 it
> > should?
> >
> > Or maybe it did it in the past as by now it is just a comment:
> >
> > =E2=AC=A2 [acme@toolbx perf-tools]$ git grep NO_LIBDW_DWARF_UNWIND
> > tools/perf/Makefile.perf:# Define NO_LIBDW_DWARF_UNWIND if you do not w=
ant libdw support
> > =E2=AC=A2 [acme@toolbx perf-tools]$
> >
> > Its from:
> >
> > # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
> > # for dwarf backtrace post unwind.
> >
> > As we need libdw for 'perf probe', etc, so being able to disable it jus=
t
> > for DWARF backtrace is what we need here to make them mutually
> > exclusive, i.e. the default is for building with libdw for backtraces,
> > but if the user asks for LIBUNWIND=3D1, then a warning that libdw won't=
 be
> > used for DWARF backtraces and select NO_LIBDW_DWARF_UNWIND?
> >
> > We could then have a regression test that builds perf with one, does
> > some backtraces, then with the other, then compare? This would be
> > followup work, if somebody has the cycles, but making them mutually
> > exclusive should be doable with not that much work?
> >
> > This is an area that is tricky and since we _already_ have two
> > implementations, the good thing for regression testing would be the
> > compare their results until libunwind becomes completely rotten and
> > unusable?
>
> My series:
> https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/
> makes libdw and libunwind supported together:
> https://lore.kernel.org/lkml/20260305221927.3237145-2-irogers@google.com/
> """
> This commit refactors the DWARF unwind post-processing to be
> configurable at runtime via the .perfconfig file option
> 'unwind.style', or using the argument '--unwind-style' in the commands
> 'perf report', 'perf script' and 'perf inject', in a similar manner to
> the addr2line or the disassembler style.
> """
> That series cleans up several other issues, which is why I think it is
> worth landing while we wait for libdw to become stable.

Fwiw, fixing cross-platform MIPS libunwind support (my series does
this) goes someway to address problems with perf raised here:
https://github.com/koute/not-perf

Thanks,
Ian

> Thanks,
> Ian
>
> > - Arnaldo
