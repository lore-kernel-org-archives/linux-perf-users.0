Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEB379EDF
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310879; cv=pass; b=F8WxJdX9rPm/wjCjeyz4xAN+yE1pFYWK2HhD97v3ExMcYFg1s2f93oQzG2YOiaQ68B6HDB/sTr4Y6M1i/VXG9WElUPBF6c2L43glQYqJde1KJXZVyiK1Y5Jn14VwqWUxQO/m0Pk6NAmGuy05VQ5z9iTledSl4/uxhi1715DIkLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310879; c=relaxed/simple;
	bh=0PQSZCDfkneD7hCu9hsmatADZ1nhi52QCJHeif6524U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TROON13MKkdek+cpfivb2P/5csn6sdbN4d6CKz1ieG2JFr2iyJmmCRoi9bpIr8w5BLHbBzQzR0RuMK3XF2+n4s8DluCwhEfL3H4OkmleIxjjNOfdpFdPY1eWPDGptq2TU4z5YsG2ODDYFNZkj7y2E2AdWxkc9UzbPq5JyhahNPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQbBJaAD; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQbBJaAD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133362c30cfso7c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 14:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779310877; cv=none;
        d=google.com; s=arc-20240605;
        b=i9Oxia+UNRH9jUpQxR8y4gi/LqHH9kWR2nC7CTK2/xaFX1usa0NAWwOYrK1cQAoSM7
         nssbj6rTNkLjGMwm7nLmwYXR9QRvUnEFozgqPEyO+N5ZgJNcJVqLBXilMrmj2QhKuFhp
         gDEqO2ZVSNftzi2ya3IAVUtgqA9rWlANCH56d7maoXit+WZZV1Ld1aJBjUA3BS4aLf66
         +N3HZnHpjrgQA1ZaQWdFrMpwK+yA9Krj8ZCElA+HXoNt0SlaarxlDS80Pcly0Q3A3gSq
         4xmO89cBWw1IG7uEQW0CECoU+V4U9uR/DbzRKjHATkiG54JYYzEBT39ggKBV7M8lgr+Q
         b9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZOcbKmBNGd8oVd6HLn2Nt6dJvnBom/169T0PkRrsc40=;
        fh=m7m2WV1/gU0rHVxNHUXAFIib1g5OgmOo0KCkdAOv/vw=;
        b=Qi8A2dmK40MQOZ+gjXO5n+QRfjY71hduiJbzFXYCegI6f+IO4cpFa58NjQJXB7UvZC
         ZmwzEtlQf1UuCp3VQCThxiI33KmbBZUTBrw8nvR2VC5ABDYkKwlzJV+50wl6o1wlc14D
         +zbtMZc9zHEE9QXV+Zp0kZHg5RhzR2vLOcUAgVafpNpsoYwErmhgl1gt48+uo09PbuM8
         Ek/WVCSy96yY1bIcpgApYcpG6ESyhIhgRQeRlNYzJqWGI8U4zYAElhPhX4Sc3iIPr9Km
         4cD8jFJBTxHWXu7AjCY6R+NDWI4Erqu7jkrWU7EkGtxdeBhKHtFp3QWwrx17z3a8h7/l
         A16w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310877; x=1779915677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOcbKmBNGd8oVd6HLn2Nt6dJvnBom/169T0PkRrsc40=;
        b=sQbBJaADLb6/cjR/lRzWb066wcEQDTd8Pz0aNDeX8IiG1icU/NX0xShd9ITIleVpIW
         IopnVmnm/aa/ukQ0DiRbOnMBiJh4/mIfQN7ssqNljlcb1l4zzx4zFTJ4+tmD4vZXc3+8
         f7HG1UWxi2sh6pPckvCXXQ1j9yiadmPVaqJ1t1n0J9X3fI4DHADAH+umHRAsRnzfMLpM
         l4gGQX7u/XHM45ASp+E50byBdOJLCZliW6HwiyF4/grs73GlRyyvfRDRt7eHQS2rfo7G
         RWImZK/i7ytKyd1IcJp8M2gNxbn7eyr9av409qCxhyNTTlgGWj/yJ0OJQ0o9ROrVyOCU
         OXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310877; x=1779915677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOcbKmBNGd8oVd6HLn2Nt6dJvnBom/169T0PkRrsc40=;
        b=dK8jixq480tjbTXHPTTeEaH0T63O0op4NjAv+6djJovTSi+UzH7jdzzn7gBwb2mCZE
         mt/2wcdRNlcmDkQPXQYUUgULfzdhz/5EtQwatdef3OJBAdQQIkxuDB7W96l1ozc4aBiT
         O1T4InHcAUYetZJJjOlPuuTPwGuNgWniS6iNy+QAwD4Bxyn7UPPc9tojhIpmkZv6RfOu
         UVix0kDCU1AEapFKnK5PTVTloQhXss6kD346MkA8pAun33O2avcj4vH8cLlG5J7aOUnh
         o/nIpNAgLYresXT6XbQp44Vw0V7l50YXxE69U1N7TCprmPc7NCNK+7twd3MY5EbSAxjX
         XzXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9syPKvFvIQ5nImS2wJGHng/YTHxOCzIC8fzNzGmc2tzgb5AWa9y5dRfIDJk4/hThIbeDXlqxKnSALypZrpShc9@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVYMJ8TVy+imfDeuSaSS1OtjawI6pnFVZb53OOKu73P9l4gfw
	CxQ5rvhDKYLvfKio24htmvwGHT7ghHmmzm/1sncg9P3GfXq+u2rJcoMdzbPuwiv6HuM/GMgbi1k
	dkU5RyOypB4ocHNYX1XbSOJznLmT+8SdeNQIU8/rn
X-Gm-Gg: Acq92OHJv/C2HakvsdvVkkvxD2MtayvOcAQOeH0uhZHOwZ2BooC0M2BkS2FNjKau9Tk
	dh7IILpYNmEnDDN3/DmNY5KBq88YM+bCyT68eJGK9aAKyS8vt0OnyWIyfAHgQvA3cLD8vOdtHls
	R3nBH0qt5Y9KKT6cFDqEVVSis0joGfTn2Aj5+Ro8Orrw3WFcrsBJ0HudAFD8NppHr7OeERXclcQ
	FT0L3hKPuh36HZtb/a+bSROES8Slk+MkDTQODq+PXbtYrnbsNE0GdADoXj6iQQPfxtpZIjFhsE+
	LhM3JVt163IZE8LMSP7giGjyxwlO1zBhJm9CPJUeRX9/GbQ9dl+DLa6L+20=
X-Received: by 2002:a05:7022:f40d:b0:133:3bc1:bf2e with SMTP id
 a92af1059eb24-1363382f28dmr2651c88.5.1779310875880; Wed, 20 May 2026 14:01:15
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1> <ag4PpWl-wV7SDpd5@x1> <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1> <ag4e1BNQlZWVWISE@x1> <ag4f1iYyHdkpToXu@x1>
In-Reply-To: <ag4f1iYyHdkpToXu@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 14:01:03 -0700
X-Gm-Features: AVHnY4LzAp4sQkfSX0BmRxXJzXkakZBlVBmjm49znF4pPzYSiTe28uqVE5xPkR8
Message-ID: <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
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

On Wed, May 20, 2026 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 20, 2026 at 05:51:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 20, 2026 at 05:49:57PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Wed, May 20, 2026 at 01:40:48PM -0700, Ian Rogers wrote:
> > > > On Wed, May 20, 2026 at 12:46=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > > > > > > Nearly all perf code ends up passing an evsel with the perf_s=
ample,
> > > > > > > which is problematic if you want to rewrite the evsel (such a=
s with
> > > > > > > off-CPU processing) because all uses of the evsel need to be =
fixed
> > > > > > > up. Since the perf_sample now carries its own resolved evsel =
pointer,
> > > > > > > passing evsel separately is redundant and error-prone (allowi=
ng
> > > > > > > parameter divergence bugs).
> > > > > > >
> > > > > > > This series cleans up the redundant evsel parameter across al=
l perf
> > > > > > > tool subcommands and APIs, ensuring that tools uniformly retr=
ieve
> > > > > > > event attributes directly from the sample itself. This simpli=
fies
> > > > > > > function signatures and improves API consistency.
> > > > > > >
> > > > > > > Additionally, this series incorporates subsequent memory safe=
ty
> > > > > > > improvements, robust bounds checking, and memory leak correct=
ions
> > > > > > > prompted by address sanitizers and Sashiko code reviews.
> > > > > > >
> > > > > > > The original combined RFC patch:
> > > > > > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@=
google.com/
> > > > > > > was split up per reviewer requests.
> > > > > > >
> > > > > > > v14:
> > > > > > >  - Incorporate Acked-by tags from Namhyung Kim.
> > > > > > >  - Re-polish and expand commit descriptions to provide thorou=
gh explanations
> > > > > > >    of the changes and their rationale.
> > > > > >
> > > > > > Thanks, tentatively applying it to perf-tools-next, for v7.2.
> > > > >
> > > > > Had to apply a minor fixup for a conflict with anoter patch serie=
s from
> > > > > you, the LBR one.
> > > >
> > > > Sorry for that and thanks for dealing with the conflict! Any chance
> > > > you could push to tmp.perf-tools-next? I have some other series tha=
t
> > > > will conflict and it would be nice to rebase those changes there.
> > >
> > > I just removed the last two patches, the ones for kwork, as:
> > >
> > > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D NO_LIBELF=3D1 -C tool=
s/perf O=3D/tmp/build/perf
> > > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> > >   BUILD:   Doing 'make -j32' parallel build
> > > Makefile.config:647: Warning: Disabled BPF skeletons as libelf is req=
uired by bpftool
> > > Makefile.config:745: Disabling post unwind, no support found.
> > > Makefile.config:856: Missing python setuptools, the python binding wo=
n't be built, please install python3-setuptools or equivalent
> > > Makefile.config:1045: No libbabeltrace found, disables 'perf data' CT=
F format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-de=
v
> > > Makefile.config:1110: libpfm4 not found, disables libpfm4 support. Pl=
ease install libpfm-devel or libpfm4-dev
> > > Makefile.config:1135: Rust is not found. Test workloads with rust are=
 disabled.
> > >
> > > Auto-detecting system features:
> > > ...                                   libdw: [ on  ]
> > > ...                                   glibc: [ on  ]
> > > ...                                  libelf: [ on  ]
> > > ...                                 libnuma: [ on  ]
> > > ...                  numa_num_possible_cpus: [ on  ]
> > > ...                               libpython: [ on  ]
> > > ...                             libcapstone: [ on  ]
> > > ...                               llvm-perf: [ on  ]
> > > ...                                    zlib: [ on  ]
> > > ...                                    lzma: [ on  ]
> > > ...                                     bpf: [ on  ]
> > > ...                                  libaio: [ on  ]
> > > ...                                 libzstd: [ on  ]
> > > ...                              libopenssl: [ on  ]
> > > ...                                    rust: [ OFF ]
> > >
> > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
> > > <SNIP>
> > >   LINK    /tmp/build/perf/perf
> > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_pop_atom':
> > > builtin-kwork.c:(.text+0x59c92): undefined reference to `work_exit'
> > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_push_atom.c=
onstprop.0':
> > > builtin-kwork.c:(.text+0x5aba8): undefined reference to `work_exit'
> > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `cmd_kwork':
> > > (.text+0x5bb4b): undefined reference to `work_exit'
> > > /usr/bin/ld: (.text+0x5bbae): undefined reference to `work_exit'
> > > /usr/bin/ld: (.text+0x5c3b2): undefined reference to `work_exit'
> > > collect2: error: ld returned 1 exit status
> > > make[2]: *** [Makefile.perf:586: /tmp/build/perf/perf] Error 1
> > > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > > make: *** [Makefile:76: all] Error 2
> > > make: Leaving directory '/git/perf-7.1.0-rc2/tools/perf'
> > > + exit 1
> > > toolsbuilder@five:~$
> > >
> > >
> > > I'm doing some more tests, just a moment and I'll push what I have to
> > > tmp.perf-tools-next.
> >
> > Also:
> >
> > toolsbuilder@five:~$ cat dm.log/almalinux\:8
> > <SNIP>
> > OLLECT_GCC=3Dgcc
> > COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrappe=
r
> > OFFLOAD_TARGET_NAMES=3Dnvptx-none
> > OFFLOAD_TARGET_DEFAULT=3D1
> > Target: x86_64-redhat-linux
> > Configured with: ../configure --enable-bootstrap --enable-languages=3Dc=
,c++,fortran,lto --prefix=3D/usr --mandir=3D/usr/share/man --infodir=3D/usr=
/share/info --with-bugurl=3Dhttp://bugs.almalinux.org/ --enable-shared --en=
able-threads=3Dposix --enable-checking=3Drelease --enable-multilib --with-s=
ystem-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gn=
u-unique-object --enable-linker-build-id --with-gcc-major-version-only --wi=
th-linker-hash-style=3Dgnu --enable-plugin --enable-initfini-array --with-i=
sl --disable-libmpx --enable-offload-targets=3Dnvptx-none --without-cuda-dr=
iver --enable-gnu-indirect-function --enable-cet --with-tune=3Dgeneric --wi=
th-arch_32=3Dx86-64 --build=3Dx86_64-redhat-linux
> > Thread model: posix
> > gcc version 8.5.0 20210514 (Red Hat 8.5.0-28) (GCC)
> > + make ARCH=3D CROSS_COMPILE=3D EXTRA_CFLAGS=3D -C tools/perf O=3D/tmp/=
build/perf
> > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> > Makefile.config:1045: No libbabeltrace found, disables 'perf data' CTF =
format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > Makefile.config:1061: No libcapstone found, disables disasm engine supp=
ort for 'perf script', please install libcapstone-dev/capstone-devel
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
> > ...                             libcapstone: [ OFF ]
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
> >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
> > <SNIP>
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/cache.json
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/counter.js=
on
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/floating-p=
oint.json
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/frontend.j=
son
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/memory.jso=
n
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/other.json
> >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/pipeline.j=
son
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
>
> But:
>
> toolsbuilder@five:~$ export BUILD_TARBALL=3Dhttp://192.168.86.5/perf/perf=
-7.1.0-rc2.tar.xz
> toolsbuilder@five:~$ time dm
>    1     8.77 almalinux:8                   : FAIL gcc version 8.5.0 2021=
0514 (Red Hat 8.5.0-28) (GCC)
>    2    84.96 almalinux:9                   : Ok   gcc (GCC) 11.5.0 20240=
719 (Red Hat 11.5.0-11) , clang version 20.1.8 (AlmaLinux OS Foundation 20.=
1.8-3.el9) flex 2.6.4
>    3:  103.23 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1 20231=
218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0=
.6-5.el9) flex 2.6.4
>    4    90.91 almalinux:10                  : Ok   gcc (GCC) 14.3.1 20250=
617 (Red Hat 14.3.1-2) , clang version 20.1.8 (AlmaLinux OS Foundation 20.1=
.8-1.el10.alma.1) flex 2.6.4
>    5   118.21 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git=
20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
> ...

You can drop the parallelize jevent.py changes and I'll follow up.
Sorry for the breakage.

Thanks,
Ian
