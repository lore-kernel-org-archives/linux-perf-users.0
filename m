Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8737FF46
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643857; cv=pass; b=tDsOKkKVOh7nJEpzQ039/i6fRkpANwkVip6Au3xd0/KHnjd5JZ4LQQd050W2VlGjTWEVngqzgTddWIOIBeYhNQItTeyh6adqHR79FIFe0wV/k3UZkpfWbWnf1b/ZSh2Z7S3BIGWMhqfhxfFduGtHZ9oEGKefHAZyqT8omBgBmuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643857; c=relaxed/simple;
	bh=/6EnNsb3KWjHJp5ch/JS93p/JTuXA+Y0fDjHLHQvRAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTHjzDdHQzoqCHPyS19rixq/4/7lY/0FpFXFmDgezWxXe+/QOvsmVpdyb5/BbUYks3mKriVTm0c+Sksm4cPSqe2gv/VqEPFjICJkOKpXlFqdYKEXelz5PqbFt5bNDnYUoY//J9jDiDwXV6ERemBC3NL8UXCrUmB+l1wevqnH6q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNPNVjlF; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNPNVjlF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052562254so25135ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 13:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774643853; cv=none;
        d=google.com; s=arc-20240605;
        b=lvO51+FzdQax5XRTc1eA+2aZv+TBh8wPOWDv48B58jJDEexApD97w/cwJUha6yD02+
         YXyl9rQDwYjlQG+FDGz/5bpGNTqE3Sh4E6Xw7qhu9PH26MeGlQ6SaRrWOxToxmAUuA2+
         2SKaeVVS9Lb0XkFXdO/NRy8DNY6DQkAGwQsWWsujWxeyQnH+tJLt3aqlRjSxMjdlh+Ju
         LTLsAf16wdHAadrBDBsD2jCrKWOZTtbMeZ7ZD4lyPMm7C6j095rSfuRBLX5auYhomb/j
         4PGcTXna5/Y0F6mYtW6RlqtaQkCMyImcUBFdqsbP9alnfL27+l2snoOEo+1Y6vFVoLI8
         S3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r13fetV/vaHgIfifc7hlGntVBBme+u6085WHF3DN3JA=;
        fh=eFU93s921wNI1OAu2D+kX193gqIvSi1vcQInjYWqGWo=;
        b=c38HLQWwqto1exrlnPms+ny62gJoYOKzklCJ2ljuflhylXpDFsQ7xFcFctA+g8iQvn
         Bi7p6e4vZEyU8rdlyAyjIolLh6KsiPb60MLECwI8kmkNOZwGQJPdskeHaKgGGJ86ebb2
         sI/fF9TP3a8BPIbKTFVekAoEP3cQQvbZEKJxDMz/APWrQiBz+YJ0Km01SxIyrC1GDtKf
         QQYrnXh0/qAegWzzUn7seDt7dThC9YdyjEPVjSZEhw50zY0AchzY3H47MfLSgE+f211a
         ly35mpqaX+ih+Jj3/lsmZONKTazhAVyWv4t81fEDqDmlUcwi/SKknwC1vFEZO3hyX9c0
         FEgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774643853; x=1775248653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r13fetV/vaHgIfifc7hlGntVBBme+u6085WHF3DN3JA=;
        b=jNPNVjlFBndVRAIaR8Yhptqe200t7NVQPKkDHixAVAHnKmabmqspZXtc+qLjLQlTSN
         X8ajVO3kpjaRGaDbXZ26qIXl5kPI0hrAWdHb5UQxnS7bqaj0Uyo8cTQvKePAvNz03F5D
         +SGLlJPMXkN7/OM+hid/xqutZ47pqS4eeU9h2+36c6zX+d7fZvhd2B3xeN2xqNq1gCT5
         8bw6JJu9asTwQrI2RNgqy1gYZ+731TrWf+bGo16uYZS0/Y13S6DiGAS2/6eO32ocSF0b
         ttQzUwTbYajs8RaF1oQPnxiZljHLyPAQLvkw9twXDMHpX92oOstLDjt5c5NGwdwFBEgo
         qgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643853; x=1775248653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r13fetV/vaHgIfifc7hlGntVBBme+u6085WHF3DN3JA=;
        b=ncvRbLFZwAY78P+D11fINceeMaKV3d8r7DmSBP5hpKv6aXC7fmrDXIb+PpkJP70/2p
         DaGgRzg3yLRR68rY8N1vjWrh82SqBAhQLr+eJKf8KlPybShT1j004To9LU9r81R5xNWX
         z92AP+pWEVuGMw0TdkviMRzWhRNhuyHjEteBHCsPfcCDRiU6awSQu2CadQDHa71ubQH7
         JhWeDtwqP/XyHNd8KIK2TF0iXaf3Q0x30RRe0AtNzQAR1O+iNg88bUoHz+ko6jtmlTpV
         A7OFDqgSssO1U5JRJz8ab4TPlK6n9hCA/CfNUxvjfeili0beLC7ftv1lB+z7HvDo748Z
         qahg==
X-Forwarded-Encrypted: i=1; AJvYcCWRW0lrXk0JHW+LigimcCQW6wOEfhA3cIJUz1JZbFsxDitO9PsuUw8C30VIm89+kTRD5tP6ySBiQcSlyz45pHJ1@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3mQ8aw2uXLQEYIKokSpidUWyCCFPWY4vO6rvKnX6/qETYGq7
	W6yDTFpEo7cieIuK8QeWn+Pr9WhZFcW9pJs6/LNquaJnjkxyLfha3LC/xYeEQYLZqkbIdSHXuHw
	QBtIawobTlBPmFVuzdoW33Z/XB9RyF5uMpdKipp9L
X-Gm-Gg: ATEYQzx3eu67EvwLK8O+6aclHydzlsH6JIoGtNNgef03RX1ZBcgdSAA18yz4KvDxf+L
	TRk6KSLASra9LqPOPwyZFsBVlOpcxYXCrzo1ZEMab6XeO3EuQNIL2/EzjSr0PeaOgxPJG1nCVFU
	SaLqb56WciBcbikWp2pvn4gAz59Mlf7ZcC+CCm8sHVidzO/Fyih1xTv1Ev1VAUpe3BlDo7sODpc
	NQTaCZrIPRLjc+bmZkKkeiDD96cHP6Nh0GBLdrr2uFpp3kMcuXEjbPdhGAWKHDeSyCy4USvL1Ez
	SJz1hSNb
X-Received: by 2002:a17:902:ccd0:b0:2ae:45cc:aeb6 with SMTP id
 d9443c01a7336-2b241c7f196mr850315ad.6.1774643852395; Fri, 27 Mar 2026
 13:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abxs-2rozL1tBEO1@google.com> <20260321234220.848859-1-irogers@google.com>
 <acW4Z2KJbyPZM1SG@google.com> <acbjjwc-WCk1CwtF@x1>
In-Reply-To: <acbjjwc-WCk1CwtF@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Mar 2026 13:37:20 -0700
X-Gm-Features: AQROBzDJTFOWNO9COXQqi_3nMqcHYJ2jcRoNemZtTIaoZQj3JBfEfCB9aE6Pq8Y
Message-ID: <CAP-5=fXmBpqP86FT85sA_BZYRnzwbZ5joYLogCqON6fjXCkRHQ@mail.gmail.com>
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

On Fri, Mar 27, 2026 at 1:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Mar 26, 2026 at 03:51:19PM -0700, Namhyung Kim wrote:
> > On Sat, Mar 21, 2026 at 04:42:18PM -0700, Ian Rogers wrote:
> > > libunwind support exists for "--call-graph dwarf", however, libunwind
> > > support has been opt-in rather than opt-out since Linux v6.13 as libd=
w
> > > is preferred - commit 13e17c9ff49119aa ("perf build: Make libunwind
> > > opt-in rather than opt-out"). A problem with the libdw support was
> > > that it was slow, an issue fixed in Linux v7.0 in commit 6b2658b3f36a
> > > ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every
> > > unwind"). As such libunwind support is now unnecessary.
> > >
> > > The patch series:
> > > https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.=
com/
> > > looked to make the libunwind support in perf similar to the libdw
> > > support, allow cross-architecture unwinding, etc. This was motivated
> > > by the perf regs conventions being altered by the addition of x86 APX
> > > support:
> > > https://lore.kernel.org/lkml/20260209072047.2180332-1-dapeng1.mi@linu=
x.intel.com/
> > > It is necessary to translate the library's notion of registers to the
> > > perf register convention so that the stack unwinding state can be
> > > initialized. On this series it was stated that removing libunwind
> > > support from perf should be an option, rather than updating support:
> > > https://lore.kernel.org/lkml/abxs-2rozL1tBEO1@google.com/
> > > This was also what motivated making libunwind opt-in rather than
> > > opt-out.
>
> > > Given that 7 minor releases have happened with libunwind "deprecated"
> > > by making it opt-in, let's remove the libunwind support. There doesn'=
t
> > > appear to be any disagreement to this on the mailing list.
>
> > I'm not sure if we want to remove it now.  I think we need more time to
> > verify libdw unwinding is stable and fast enough.  Also maybe we can
> > add build- or run-time warning when people try to use libunwind.
>
> We have:
>
> acme@x1:~/git/perf-tools$ perf -vv | grep LIBU
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecat=
ed, use LIBUNWIND=3D1 and install libunwind-dev[el] to build with it )
> acme@x1:~/git/perf-tools$
>
> acme@x1:~/git/perf-tools$ perf check feature libunwind && echo perf built=
 with libunwind
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecat=
ed, use LIBUNWIND=3D1 and install libunwind-dev[el] to build with it )
> acme@x1:~/git/perf-tools$
>
> Building with both, as Ian mentioned ends up with:
>
>   LD      /tmp/build/perf-tools/util/perf-util-in.o
> ld: /tmp/build/perf-tools/util/unwind-libunwind.o: in function `unwind__g=
et_entries':
> unwind-libunwind.c:(.text+0x2a0): multiple definition of `unwind__get_ent=
ries'; /tmp/build/perf-tools/util/unwind-libdw.o:unwind-libdw.c:(.text+0x94=
0): first defined here
> make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:164: /=
tmp/build/perf-tools/util/perf-util-in.o] Error 123
> make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158: u=
til] Error 2
> make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] Er=
ror 2
> make[1]: *** [Makefile.perf:289: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> =E2=AC=A2 [acme@toolbx perf-tools]$
>
> So what Namhyung is suggesting is to disable libdw when libunwind is
> asked for?
>
> I.e.
>
> alias m=3D'rm -rf ~/libexec/perf-core/ ; make LIBUNWIND=3D1 NO_LIBDW=3D1 =
-k O=3D/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test =
"import python" && cat /tmp/build/$(basename $PWD)/feature/test-all.make.ou=
tput' ; export PYTHONPATH=3D/tmp/build/$(basename $PWD)/python
>
> Which builds and ends up linking with both:
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ ldd ~/bin/perf | egrep unwind\|dw
>         libunwind-x86_64.so.8 =3D> /lib64/libunwind-x86_64.so.8 (0x00007f=
bf430b6000)
>         libunwind.so.8 =3D> /lib64/libunwind.so.8 (0x00007fbf4309b000)
>         libdw.so.1 =3D> /lib64/libdw.so.1 (0x00007fbf38570000)
> =E2=AC=A2 [acme@toolbx perf-tools]$
>
> I.e. that NO_LIBDW isn't really disabling linking with it, just some
> features based on it, likely.
>
> Hum, we also have NO_LIBDW_DWARF_UNWIND, which probably is what we want
> here... nope:
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ alias m=3D'rm -rf ~/libexec/perf-core=
/ ; make LIBUNWIND=3D1 NO_LIBDW_DWARF_UNWIND=3D1 -k O=3D/tmp/build/$(basena=
me $PWD)/ -C tools/perf install-bin && perf test "import python" && cat /tm=
p/build/$(basename $PWD)/feature/test-all.make.output' ; export PYTHONPATH=
=3D/tmp/build/$(basename $PWD)/python
> =E2=AC=A2 [acme@toolbx perf-tools]$ m
> rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace=
-Util/lib/Perf/Trace/__pycache__/Core.cpython-314.pyc': Permission denied
> make: Entering directory '/home/acme/git/perf-tools/tools/perf'
>   BUILD:   Doing 'make -j12' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm=
/svm.h
>
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                               libpython: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> ...                              libopenssl: [ on  ]
> ...                                    rust: [ on  ]
>
>   INSTALL libsubcmd_headers
>   INSTALL libperf_headers
>   INSTALL libapi_headers
>   INSTALL libsymbol_headers
>   INSTALL libbpf_headers
>   LD      /tmp/build/perf-tools/util/perf-util-in.o
> ld: /tmp/build/perf-tools/util/unwind-libunwind.o: in function `unwind__g=
et_entries':
> unwind-libunwind.c:(.text+0x2a0): multiple definition of `unwind__get_ent=
ries'; /tmp/build/perf-tools/util/unwind-libdw.o:unwind-libdw.c:(.text+0x94=
0): first defined here
> make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:164: /=
tmp/build/perf-tools/util/perf-util-in.o] Error 123
> make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158: u=
til] Error 2
> make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] Er=
ror 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:289: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
> =E2=AC=A2 [acme@toolbx perf-tools]$
>
> I expected NO_LIBDW_DWARF_UNWIND=3D1 would resolve this case, and maybe i=
t
> should?
>
> Or maybe it did it in the past as by now it is just a comment:
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ git grep NO_LIBDW_DWARF_UNWIND
> tools/perf/Makefile.perf:# Define NO_LIBDW_DWARF_UNWIND if you do not wan=
t libdw support
> =E2=AC=A2 [acme@toolbx perf-tools]$
>
> Its from:
>
> # Define NO_LIBDW_DWARF_UNWIND if you do not want libdw support
> # for dwarf backtrace post unwind.
>
> As we need libdw for 'perf probe', etc, so being able to disable it just
> for DWARF backtrace is what we need here to make them mutually
> exclusive, i.e. the default is for building with libdw for backtraces,
> but if the user asks for LIBUNWIND=3D1, then a warning that libdw won't b=
e
> used for DWARF backtraces and select NO_LIBDW_DWARF_UNWIND?
>
> We could then have a regression test that builds perf with one, does
> some backtraces, then with the other, then compare? This would be
> followup work, if somebody has the cycles, but making them mutually
> exclusive should be doable with not that much work?
>
> This is an area that is tricky and since we _already_ have two
> implementations, the good thing for regression testing would be the
> compare their results until libunwind becomes completely rotten and
> unusable?

My series:
https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/
makes libdw and libunwind supported together:
https://lore.kernel.org/lkml/20260305221927.3237145-2-irogers@google.com/
"""
This commit refactors the DWARF unwind post-processing to be
configurable at runtime via the .perfconfig file option
'unwind.style', or using the argument '--unwind-style' in the commands
'perf report', 'perf script' and 'perf inject', in a similar manner to
the addr2line or the disassembler style.
"""
That series cleans up several other issues, which is why I think it is
worth landing while we wait for libdw to become stable.

Thanks,
Ian

> - Arnaldo
