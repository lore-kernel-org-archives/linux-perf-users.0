Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79837C0EB
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311942; cv=pass; b=hATd5VRd4pn3qIZoYRkM6JFyKZvKFHFzqQwQTtofD06zLe7HbeCSY8k9AzkPdV8r1MbBm8QEh2Hb02H8ejMUeqh36aGp+7M/frZVQh5K4IEWf2plMKkpw2sudVMPOlHXKKmu+HP51RWxsJNK1Bg4WXtZ2rBkwPC3T0B7OX7/Mls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311942; c=relaxed/simple;
	bh=aHQumoK8wqleOpnqdbBw0hdx0snTFFqGE6debS6GC7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg9/bhkmdNk5IRb3G8jtBm8P33HsyINAm/VaLz71zooi1rbR49W+zvx2moMb01BTIIk5DSln8cc3Ci43Ub1rB9mfTV6rvaHLriuRugJIexRLYvk6BtPNWWhL6z6Wz6OOptqmqH1pcIezEOfyIqELb/t4G5NPHRSvJbzwkKxxoBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I20s5q/d; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I20s5q/d"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso635ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 14:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779311939; cv=none;
        d=google.com; s=arc-20240605;
        b=OaD2rMMBjKJ7cuO8pRwfDFNuYKFpqDDuSZF4E4LMhCh7C6jM6LmflAqO5Dnd82Vd2n
         Rp2WNdBC2I9EWGb6CYMaQ1k8Klt7ztXBMD4fWCg0u+dVCCHdPQ2706PdzUhlmAop7xpB
         eOrQstbSCOP8frMgYl74N/UhU/1f7qcNDHizPTr8WTdQzCaiu90cSGdj1hXmXiiQvVpI
         jf0usZEPS22uwjpL4p8Jwo3zonRvd+yfYaptWcr/2S/yUQtD1G2xvZDpHmpd1OXYrro/
         cpQnwDZLVnizirlGacsyweGjsfE8OhLvaR7ok0Pl5WAqGaxQaysYGPhCqUXZk9qigXrY
         w7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aeu1cXM4cCs9o3KxNXV1hgrS94TrhXeXdINiDCAteO0=;
        fh=HpkFcp0ayEIXqKi2TZWNU/k/+44GTbTSJH/xKhvMVlU=;
        b=B1MRgzc6P4pcCg3NKZQnZINPObNOFVakx/NL+rGULh6w+pXh+q8iYPNoNF8jOAfZV1
         HMf3gQJ227868Z5F0Qx+PfvidnzPnL+CJnyyEhfv5hjDvelskD38Ss6tOKXKXlde8kZ/
         /Xr8nP4W8L3jw3gD67QSatOv5QK1OLhmvtnBoAWCmq2K4l6e3yLmVfBAPDZw/3OOZpwS
         yqBrh6snlsP8qqvnZ2d3j82RS0vggYMu48KYWjC9zNcEnknED5rFITpVzDNzWx4PjSi/
         UaE9iE2+D5akI0Nzzqt3/LQ2jSS0+QG2ndhOR/8pJbpcuhAa0MoP0OlTJ6OCfRqQv7eT
         tnrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779311939; x=1779916739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeu1cXM4cCs9o3KxNXV1hgrS94TrhXeXdINiDCAteO0=;
        b=I20s5q/dKkJZl+eQLNv5h1oOP2SHEDc3Pqo8KHalQtnBqE90QYMN5zBmGv2fyR4eA3
         FriT8dDTu7CSHzYXBvRZN7EV1SJlkRED15z2X4ATbwSl4+x25UiGfNT4qTmqbZBnuZ6D
         a0qzvvyJeMzrLasRBq84JGU6B9ipreyVjcmx4cweOLuLhOJXRzKTPmIQlm6AMG2R8LvC
         +TTQLDq5GelufOkMoO0JF1B62wdZ21XEsIeGYz7Si/k/1S9lwNlXwa7GO3blhyHaeEue
         1DGZxJqvJgTHtsMefx2PEM7mi0vzLpmxtmuxT5WTL9OQVhYjLfsu+6a2cIAMdvxhDZhz
         kFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311939; x=1779916739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aeu1cXM4cCs9o3KxNXV1hgrS94TrhXeXdINiDCAteO0=;
        b=JiGxFgAHInkfNWdzlSPUc8ZI5c+iETNN5vnXNViub/mfYfUhQJfNmgaRVAix4+TllT
         UyWRci10u2U6Xh3+SqzS6miAaC3eJoRWfadYSPiUbUWviUfXnDIxsU7xnQocq26fzqaS
         oCW9F3LHNbB8Rec8m124+22RfqoWgp2EaArFpBhG91pdUoSbp4YKmkiU6BWRwDf6GI70
         9o9JKNiUqVkox4iV0eYSv/OY+3VXKY9DSIKfqXSX93Sc8qPoEvCgOaeAy0NCaMck38v0
         2kUVCKh/zgrxM+z4E0o9mBFTaNYmXkucCl16u5f2hV76polZwhujMqVsb1U9yrc2BDdl
         53FA==
X-Forwarded-Encrypted: i=1; AFNElJ8hquk/cAiAmQqxLRH8tH6Xe2b/goj/0dMKC0S8/9lcHPbJJD+ndPIgY+cp8+x2FRQj7FbtJPlwSMEPTf+6Bi63@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxSe34jT2ElQtHkHdci2nkvfkdC0XVaMKZmVUUXXir217Ecxd
	PHg6NODAYsI1dlwYb31zrZat2WjqcslWvnFapp5aA3pZrVQg/UaXf5veIQfeH3kkfjLEm5MdLAJ
	fKl/mgFnyKmCklW90Xs3EB8G40Ga5+GG5lzJG8AfL
X-Gm-Gg: Acq92OGoG23p3vOk3LTiX11tHd934IGW11PdWcZXIGoRMjnXOsSVaV0WnrQB3STfsFG
	py1wyrVENc6D+vk8zq4Oe7Iane5PMq7E6auBhUv9dSaOmcRctJcJoncNpnw+GSpXUlvl411dSHr
	t/6H04cUhVwfqOSgYWWKX5qGHU9ctFVbpfgN5hhcVuhkOPLVrulSqXg70nu0kfiksZl7r0RIEXt
	OSvmij/FhMPdeoY5iDnCYpRnanrf2VuleiZABaxR5x7IlZU6aqitjknW8GbK0nd3ZxEs82Jpzjg
	UzJilMHf3VIMaOt7bDE8Py+dt734sjq8WyCVFxTOxhsr/3Wm
X-Received: by 2002:a17:903:2c07:b0:2bd:6dad:3df8 with SMTP id
 d9443c01a7336-2bea21d63camr147295ad.22.1779311939067; Wed, 20 May 2026
 14:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1> <ag4PpWl-wV7SDpd5@x1> <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1> <ag4e1BNQlZWVWISE@x1> <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
 <ag4j-dzzaa2xMr4y@x1> <ag4kauWBogiPBhRh@x1>
In-Reply-To: <ag4kauWBogiPBhRh@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 14:18:46 -0700
X-Gm-Features: AVHnY4LQhZwIe9cZJen8ePy9LwAW0wm5teNqU6oa65pjn1WL4Wdy7kIDydUY8O0
Message-ID: <CAP-5=fW5DbyqPJwxO87YQ4DC4bRnhXxCe93Fkdbr3RMjT8-AQw@mail.gmail.com>
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

On Wed, May 20, 2026 at 2:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 20, 2026 at 06:13:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 20, 2026 at 02:01:03PM -0700, Ian Rogers wrote:
> > > On Wed, May 20, 2026 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, May 20, 2026 at 05:51:36PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Wed, May 20, 2026 at 05:49:57PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, May 20, 2026 at 01:40:48PM -0700, Ian Rogers wrote:
> > > > > > > On Wed, May 20, 2026 at 12:46=E2=80=AFPM Arnaldo Carvalho de =
Melo
> > > > > > > <acme@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho =
de Melo wrote:
> > > > > > > > > On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrot=
e:
> > > > > > > > > > Nearly all perf code ends up passing an evsel with the =
perf_sample,
> > > > > > > > > > which is problematic if you want to rewrite the evsel (=
such as with
> > > > > > > > > > off-CPU processing) because all uses of the evsel need =
to be fixed
> > > > > > > > > > up. Since the perf_sample now carries its own resolved =
evsel pointer,
> > > > > > > > > > passing evsel separately is redundant and error-prone (=
allowing
> > > > > > > > > > parameter divergence bugs).
> > > > > > > > > >
> > > > > > > > > > This series cleans up the redundant evsel parameter acr=
oss all perf
> > > > > > > > > > tool subcommands and APIs, ensuring that tools uniforml=
y retrieve
> > > > > > > > > > event attributes directly from the sample itself. This =
simplifies
> > > > > > > > > > function signatures and improves API consistency.
> > > > > > > > > >
> > > > > > > > > > Additionally, this series incorporates subsequent memor=
y safety
> > > > > > > > > > improvements, robust bounds checking, and memory leak c=
orrections
> > > > > > > > > > prompted by address sanitizers and Sashiko code reviews=
.
> > > > > > > > > >
> > > > > > > > > > The original combined RFC patch:
> > > > > > > > > > https://lore.kernel.org/lkml/20260126071822.447368-1-ir=
ogers@google.com/
> > > > > > > > > > was split up per reviewer requests.
> > > > > > > > > >
> > > > > > > > > > v14:
> > > > > > > > > >  - Incorporate Acked-by tags from Namhyung Kim.
> > > > > > > > > >  - Re-polish and expand commit descriptions to provide =
thorough explanations
> > > > > > > > > >    of the changes and their rationale.
> > > > > > > > >
> > > > > > > > > Thanks, tentatively applying it to perf-tools-next, for v=
7.2.
> > > > > > > >
> > > > > > > > Had to apply a minor fixup for a conflict with anoter patch=
 series from
> > > > > > > > you, the LBR one.
> > > > > > >
> > > > > > > Sorry for that and thanks for dealing with the conflict! Any =
chance
> > > > > > > you could push to tmp.perf-tools-next? I have some other seri=
es that
> > > > > > > will conflict and it would be nice to rebase those changes th=
ere.
> > > > > >
> > > > > > I just removed the last two patches, the ones for kwork, as:
> > > > > >
> > > > > > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D NO_LIBELF=3D1 -=
C tools/perf O=3D/tmp/build/perf
> > > > > > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> > > > > >   BUILD:   Doing 'make -j32' parallel build
> > > > > > Makefile.config:647: Warning: Disabled BPF skeletons as libelf =
is required by bpftool
> > > > > > Makefile.config:745: Disabling post unwind, no support found.
> > > > > > Makefile.config:856: Missing python setuptools, the python bind=
ing won't be built, please install python3-setuptools or equivalent
> > > > > > Makefile.config:1045: No libbabeltrace found, disables 'perf da=
ta' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-=
ctf-dev
> > > > > > Makefile.config:1110: libpfm4 not found, disables libpfm4 suppo=
rt. Please install libpfm-devel or libpfm4-dev
> > > > > > Makefile.config:1135: Rust is not found. Test workloads with ru=
st are disabled.
> > > > > >
> > > > > > Auto-detecting system features:
> > > > > > ...                                   libdw: [ on  ]
> > > > > > ...                                   glibc: [ on  ]
> > > > > > ...                                  libelf: [ on  ]
> > > > > > ...                                 libnuma: [ on  ]
> > > > > > ...                  numa_num_possible_cpus: [ on  ]
> > > > > > ...                               libpython: [ on  ]
> > > > > > ...                             libcapstone: [ on  ]
> > > > > > ...                               llvm-perf: [ on  ]
> > > > > > ...                                    zlib: [ on  ]
> > > > > > ...                                    lzma: [ on  ]
> > > > > > ...                                     bpf: [ on  ]
> > > > > > ...                                  libaio: [ on  ]
> > > > > > ...                                 libzstd: [ on  ]
> > > > > > ...                              libopenssl: [ on  ]
> > > > > > ...                                    rust: [ OFF ]
> > > > > >
> > > > > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
> > > > > > <SNIP>
> > > > > >   LINK    /tmp/build/perf/perf
> > > > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_pop_a=
tom':
> > > > > > builtin-kwork.c:(.text+0x59c92): undefined reference to `work_e=
xit'
> > > > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_push_=
atom.constprop.0':
> > > > > > builtin-kwork.c:(.text+0x5aba8): undefined reference to `work_e=
xit'
> > > > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `cmd_kwork'=
:
> > > > > > (.text+0x5bb4b): undefined reference to `work_exit'
> > > > > > /usr/bin/ld: (.text+0x5bbae): undefined reference to `work_exit=
'
> > > > > > /usr/bin/ld: (.text+0x5c3b2): undefined reference to `work_exit=
'
> > > > > > collect2: error: ld returned 1 exit status
> > > > > > make[2]: *** [Makefile.perf:586: /tmp/build/perf/perf] Error 1
> > > > > > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > > > > > make: *** [Makefile:76: all] Error 2
> > > > > > make: Leaving directory '/git/perf-7.1.0-rc2/tools/perf'
> > > > > > + exit 1
> > > > > > toolsbuilder@five:~$
> > > > > >
> > > > > >
> > > > > > I'm doing some more tests, just a moment and I'll push what I h=
ave to
> > > > > > tmp.perf-tools-next.
> > > > >
> > > > > Also:
> > > > >
> > > > > toolsbuilder@five:~$ cat dm.log/almalinux\:8
> > > > > <SNIP>
> > > > > OLLECT_GCC=3Dgcc
> > > > > COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/8/lto-=
wrapper
> > > > > OFFLOAD_TARGET_NAMES=3Dnvptx-none
> > > > > OFFLOAD_TARGET_DEFAULT=3D1
> > > > > Target: x86_64-redhat-linux
> > > > > Configured with: ../configure --enable-bootstrap --enable-languag=
es=3Dc,c++,fortran,lto --prefix=3D/usr --mandir=3D/usr/share/man --infodir=
=3D/usr/share/info --with-bugurl=3Dhttp://bugs.almalinux.org/ --enable-shar=
ed --enable-threads=3Dposix --enable-checking=3Drelease --enable-multilib -=
-with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --en=
able-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-on=
ly --with-linker-hash-style=3Dgnu --enable-plugin --enable-initfini-array -=
-with-isl --disable-libmpx --enable-offload-targets=3Dnvptx-none --without-=
cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=3Dgener=
ic --with-arch_32=3Dx86-64 --build=3Dx86_64-redhat-linux
> > > > > Thread model: posix
> > > > > gcc version 8.5.0 20210514 (Red Hat 8.5.0-28) (GCC)
> > > > > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D -C tools/perf O=
=3D/tmp/build/perf
> > > > > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> > > > >   BUILD:   Doing 'make -j32' parallel build
> > > > > Makefile.config:1045: No libbabeltrace found, disables 'perf data=
' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ct=
f-dev
> > > > > Makefile.config:1061: No libcapstone found, disables disasm engin=
e support for 'perf script', please install libcapstone-dev/capstone-devel
> > > > > Makefile.config:1110: libpfm4 not found, disables libpfm4 support=
. Please install libpfm-devel or libpfm4-dev
> > > > > Makefile.config:1135: Rust is not found. Test workloads with rust=
 are disabled.
> > > > >
> > > > > Auto-detecting system features:
> > > > > ...                                   libdw: [ on  ]
> > > > > ...                                   glibc: [ on  ]
> > > > > ...                                  libelf: [ on  ]
> > > > > ...                                 libnuma: [ on  ]
> > > > > ...                  numa_num_possible_cpus: [ on  ]
> > > > > ...                               libpython: [ on  ]
> > > > > ...                             libcapstone: [ OFF ]
> > > > > ...                               llvm-perf: [ on  ]
> > > > > ...                                    zlib: [ on  ]
> > > > > ...                                    lzma: [ on  ]
> > > > > ...                                     bpf: [ on  ]
> > > > > ...                                  libaio: [ on  ]
> > > > > ...                                 libzstd: [ on  ]
> > > > > ...                              libopenssl: [ on  ]
> > > > > ...                                    rust: [ OFF ]
> > > > >
> > > > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
> > > > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
> > > > > <SNIP>
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/cach=
e.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/coun=
ter.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/floa=
ting-point.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/fron=
tend.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/memo=
ry.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/othe=
r.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/pipe=
line.json
> > > > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/virt=
ual-memory.json
> > > > >   GEN     /tmp/build/perf/pmu-events/test-empty-pmu-events.c
> > > > > Traceback (most recent call last):
> > > > >   File "pmu-events/jevents.py", line 1524, in <module>
> > > > >     main()
> > > > >   File "pmu-events/jevents.py", line 1487, in main
> > > > >     with concurrent.futures.ProcessPoolExecutor(initializer=3D_in=
it_worker, initargs=3D(_arch_std_events,)) as executor:
> > > > > TypeError: __init__() got an unexpected keyword argument 'initial=
izer'
> > > > > make[3]: *** [pmu-events/Build:176: /tmp/build/perf/pmu-events/te=
st-empty-pmu-events.c] Error 1
> > > > > make[3]: *** Deleting file '/tmp/build/perf/pmu-events/test-empty=
-pmu-events.c'
> > > > > make[2]: *** [Makefile.perf:554: /tmp/build/perf/pmu-events/pmu-e=
vents-in.o] Error 2
> > > > > make[2]: *** Waiting for unfinished jobs....
> > > >
> > > > But:
> > > >
> > > > toolsbuilder@five:~$ export BUILD_TARBALL=3Dhttp://192.168.86.5/per=
f/perf-7.1.0-rc2.tar.xz
> > > > toolsbuilder@five:~$ time dm
> > > >    1     8.77 almalinux:8                   : FAIL gcc version 8.5.=
0 20210514 (Red Hat 8.5.0-28) (GCC)
> > > >    2    84.96 almalinux:9                   : Ok   gcc (GCC) 11.5.0=
 20240719 (Red Hat 11.5.0-11) , clang version 20.1.8 (AlmaLinux OS Foundati=
on 20.1.8-3.el9) flex 2.6.4
> > > >    3:  103.23 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1=
 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundatio=
n 17.0.6-5.el9) flex 2.6.4
> > > >    4    90.91 almalinux:10                  : Ok   gcc (GCC) 14.3.1=
 20250617 (Red Hat 14.3.1-2) , clang version 20.1.8 (AlmaLinux OS Foundatio=
n 20.1.8-1.el10.alma.1) flex 2.6.4
> > > >    5   118.21 alpine:3.16                   : Ok   gcc (Alpine 11.2=
.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
> > > > ...
> > >
> > > You can drop the parallelize jevent.py changes and I'll follow up.
> > > Sorry for the breakage.
> >
> > It was just that almalinux:8 so far, its an old system, so I'm keeping
> > it to see what other systems fail, if any.
> >
> > So far:
> >
> > toolsbuilder@five:~$ export BUILD_TARBALL=3Dhttp://192.168.86.5/perf/pe=
rf-7.1.0-rc2.tar.xz
> > toolsbuilder@five:~$ time dm
> >    1     8.77 almalinux:8                   : FAIL gcc version 8.5.0 20=
210514 (Red Hat 8.5.0-28) (GCC)
> >    2    84.96 almalinux:9                   : Ok   gcc (GCC) 11.5.0 202=
40719 (Red Hat 11.5.0-11) , clang version 20.1.8 (AlmaLinux OS Foundation 2=
0.1.8-3.el9) flex 2.6.4
> >    3: almalinux:9-i386WARNING: image platform (linux/386) does not matc=
h the expected platform (linux/amd64)
> > WARNING: image platform (linux/386) does not match the expected platfor=
m (linux/amd64)
> >    103.23 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1 2023121=
8 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6=
-5.el9) flex 2.6.4
> >    4    90.91 almalinux:10                  : Ok   gcc (GCC) 14.3.1 202=
50617 (Red Hat 14.3.1-2) , clang version 20.1.8 (AlmaLinux OS Foundation 20=
.1.8-1.el10.alma.1) flex 2.6.4
> >    5   118.21 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_g=
it20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
> >    6   106.13 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_g=
it20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
> >    7   102.80 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_g=
it20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
> >    8   114.48 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_g=
it20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
> >    9   109.53 alpine:3.20                   : Ok   gcc (Alpine 13.2.1_g=
it20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
> >   10   116.20 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) =
14.2.0 , Alpine clang version 20.1.8 flex 2.6.4
> >   11   109.83 alpine:3.23                   : Ok   gcc (Alpine 15.2.0) =
15.2.0 , Alpine clang version 21.1.2 flex 2.6.4
> >   12   119.23 alpine:edge                   : Ok   gcc (Alpine 14.2.0) =
14.2.0 , Alpine clang version 19.1.4 flex 2.6.4
> >   13    93.22 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 202=
40719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4)=
 flex 2.6.4
> >   14    93.40 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 202=
21121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn=
2023.0.2) flex 2.6.4
> >   15   102.98 archlinux:base                : Ok   gcc (GCC) 15.2.1 202=
50813 , clang version 20.1.8 flex 2.6.4
> >   16     9.58 centos:stream                 : FAIL gcc version 8.5.0 20=
210514 (Red Hat 8.5.0-21) (GCC)
> >   17: clearlinux:latest
> >
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/virtual-me=
mory.json
> >   GEN     /tmp/build/perf/pmu-events/test-empty-pmu-events.c
> > Traceback (most recent call last):
> >   File "pmu-events/jevents.py", line 1524, in <module>
> >     main()
> >   File "pmu-events/jevents.py", line 1487, in main
> >     with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_wor=
ker, initargs=3D(_arch_std_events,)) as executor:
> > TypeError: __init__() got an unexpected keyword argument 'initializer'
> > make[3]: *** [pmu-events/Build:176: /tmp/build/perf/pmu-events/test-emp=
ty-pmu-events.c] Error 1
> > make[3]: *** Deleting file '/tmp/build/perf/pmu-events/test-empty-pmu-e=
vents.c'
> > make[2]: *** [Makefile.perf:554: /tmp/build/perf/pmu-events/pmu-events-=
in.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >
> > Auto-detecting system features:
> > ...                         clang-bpf-co-re: [ on  ]
> > ...                                    llvm: [ on  ]
> > ...                                  libcap: [ on  ]
> > ...                                  libbfd: [ on  ]
> >
> >   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/b=
pf
> >
> >
> > centos:stream is the bleeding edge, so I'll drop that as you suggested,
> > ok.

Sgtm. I'm confused though, something old and something new broke?
In the "Minimal requirements to compile the Kernel"
(https://www.kernel.org/doc/html/latest/process/changes.html) they
state Python must be version 3.9, so it'd be nice to set that as the
baseline wrt APIs. We could probably automate that in the build and
make the build NO_PYTHON if the version is older than 3.9.

> So I removed these, i.e. from the parallelize onwards:
>
>   28 O T May 18 Ian Rogers      (  43)           =E2=94=82         =E2=94=
=9C=E2=94=80>[PATCH v7 14/14] perf build: Convert llvm-config shell queries=
 to simply expanded variables
>   29 O T May 18 Ian Rogers      (  62)           =E2=94=82         =E2=94=
=9C=E2=94=80>[PATCH v7 13/14] perf pmu-events: Convert recursive shell assi=
gnments and macros to Make built-ins
>   30 O T May 18 Ian Rogers      (  47)           =E2=94=82         =E2=94=
=9C=E2=94=80>[PATCH v7 12/14] perf build: Prefix SCRIPTS with output direct=
ory to fix continuous rebuilds
>   31 O T May 18 Ian Rogers      (  97)           =E2=94=82         =E2=94=
=9C=E2=94=80>[PATCH v7 11/14] perf pmu-events: Parallelize JSON and metric =
pre-computation in jevents.py
>

Could we keep 12, 13 and 14? They are independent changes and offer
significant build performance improvements.

Thanks,
Ian
