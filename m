Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E52FB966
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450341; cv=none; b=Y7rppHrJtxco2j2GRjiJSK8qEQlqQqeY28ZgS+yb7YK2HgIGhVXUSi6Mm1FB79WxQoHrWfF/N0bSmhFJ7svcM2uYER98YOWEhfuyNOlKhd/R7Sr0Ptqoci+hINI5wNhH/miKQdK+k05IQdPa0xTiCbo7biaz9e2BeT+l34M8sAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450341; c=relaxed/simple;
	bh=2uMV07QsVQb4mWfWCNLGJtXwI7fwj7Ix+ZbFY8kzrlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHKtDH/uWKr0HB3MH6oReSZR5ATaSuEu/GDyp5lcf2QKKDfFt7aYSVAgwFzrT/F9GSuDjQGUVHPKvmI4XspS08mlgt0vRxajwGIVhCzvmXrW0LiDr0feSSCXEbMR791TW2FPWKFrAHPNc7vCX4se1xBld3Si3EoXf9NJPWg0Hc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUKv53qG; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUKv53qG"
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5958931c9c7so3617683e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 23:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763450338; x=1764055138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/3OD0uGzkyRBt1bBejM7UqfvaXU3I+cRSlcGrOqawc=;
        b=eUKv53qGme+kUMBNSHJwfbk6jJ0Eo3DCirqKAB3nin162wVKbURSwB0rFRu32y6/r2
         ESEwAgGsaxMZA6Rsj4JluskikNG1MBYBlNaVYsZJ1pUK6DQ+Adx7TTZmLZyeSxgbKIW3
         4e/OjSesQzpDoNisKO6CZVjcHiSgn8fCvcD26tvdwtivEGsUDJrkn6y6/sgyUlj/VCOV
         +SDv0zzXy0SMp+9ozWXmqAVlSNpsFN6iA1DYHV1k0DzLQK9Tlu5SaRZUeww4rnDPFik2
         moUH+HUC6lyCN93s1rwxO1Ft38hRt+K/2/PIPTVYEeVhGGYKoASeGEAZf2RRCdhu5HcC
         LrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450338; x=1764055138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/3OD0uGzkyRBt1bBejM7UqfvaXU3I+cRSlcGrOqawc=;
        b=Kc/pnzte3pC9wnHHYU06mBdeHbUw+cAPp0EV5dGLGt25tSNqUDSQCoxPvpEjAMp8NR
         JZzJEga4bSoui1sDB/OVpgLL9kj/xUr6pAZEvSwX36W3XcRWloJQ1CWcJB4yg0Ue9twp
         WuReS7o7fcnxUNGBEdgPrLt1BrkoHVN4GnEIXs1vllJ7iGeLBxau+bWoJQXR2UwxBkKk
         HO4OZc35mfoFcZtBd1fCXEWsLUBPKwze0JH5ZWLtd+hbBu3L5iBUgsa33sx0KrywEQ7f
         BoWo32cT1xT6UJvBQtlwz7/qNfxu4zre9A4Rvq4e7g+gymzQX9sqrA21GnFva4CZ9yEh
         XuDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5PseoU7KgDKW09tq9sN/U7WRFf7WPLJJPCvN5umsVARtpXJN2spdxDPkBkLuUEBIS13fM8Mc2hpVMLU9jlgZI@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyhesL4xQ4hZkvBgEOVrAwPSGT5tlmU4P7AIFE2+Pxjoh5s+L
	yXv1CbEL8Lm+xJmKT0ITQOvdx1bJ1K5lF7ZetTOjZUDLvaXrUNMVsGaIHOZ+rlQMP2zDb1cBdib
	qr6XKKpDLKxNCXpq2xojf9CETJrv6T4Q=
X-Gm-Gg: ASbGncsJCb+qt+uoIS8Eg+M1s8M83cPL3OJgkDUhjOgRQ79UDcwGLZdtRFrmeVRXPDv
	0iKB2lYUCHNgrSfVyBrkRC89HiMNkhMC7kgeU46UwKxpXJ2/zIoOrDAFPz+CA9wdYOOy3DqJOxd
	/GJoGOL0FgjEYYjOCXKPJd3k1EgePziv2YjAcebEGdB0Vz9yCDeFWmYmDipLIYCFZTX46IHtZ9I
	+UThhF8SZSCSsdnAWAgiao3c6rYqZzjYUaYehjlrBYQ8A2nOUDI1BMUiVIP5WT8FgVxXiA=
X-Google-Smtp-Source: AGHT+IFSpbpqKmvAeDebzVmJHGIWSktKPVe7EK2SfZmYO4+SSlYzUQnrEWg8N1sm1CShpoVMaZwJNWR+N5tpArxoxYM=
X-Received: by 2002:a05:6512:2246:b0:594:27c6:a18 with SMTP id
 2adb3069b0e04-5958419f54bmr5793196e87.4.1763450337318; Mon, 17 Nov 2025
 23:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com> <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
In-Reply-To: <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 18 Nov 2025 15:18:45 +0800
X-Gm-Features: AWmQ_bnEQ60bucIxVtI6eAclIsBoomcVk0KB73zwx-PeO8-x0P5nQO7lPoEt_qQ
Message-ID: <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo and Namhyung,
Sorry for the late response, and thanks for the guidance on
prioritizing self-contained headers from the kernel source.


> > > To be clear, now we are not talking cross build for perf program or a=
ny
> > > targeting a CPU arch, it is a build failure for eBPF program.
> > >
> >
> > I=E2=80=99d like to clarify the background and scenario once more:
> > I=E2=80=99m building an SDK that includes a cross-compilation toolchain=
 for
> > the target architecture along with a copy of the kernel source tree.
>
> I am not preventing to use toolchains in you mentioned SDK.  I just
> prefer to give priority the headers provided by the kernel source.
>
> Seems to me, a more reasonable series would be:
>
>  - Fix the eBPF program build with using self-contained headers;
>  - Extend to support external headers.
>


I added the following diagnostic output to Makefile.perf to print
CLANG_OPTIONS, BPF_INCLUDE, and TOOLS_UAPI_INCLUDE during compilation,
to identify the header search paths used when building the eBPF
program.


diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..33fe2d8f16c6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1249,6 +1249,12 @@ else
        $(Q)cp "$(VMLINUX_H)" $@
 endif

+$(warning AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)
+$(warning CLANG_OPTIONS: $(CLANG_OPTIONS))
+$(warning BPF_INCLUDE: $(BPF_INCLUDE))
+$(warning TOOLS_UAPI_INCLUDE: $(TOOLS_UAPI_INCLUDE))
+$(warning AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlin=
ux.h
        $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \


The compilation output is as follows:


Makefile.perf:1252: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Makefile.perf:1253: CLANG_OPTIONS: -Wall -Werror
Makefile.perf:1254: BPF_INCLUDE:
-I/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_sk=
el/.tmp/..
-I/home/hupu/work/code/explore/output/build-mainline/tools/perf/libbpf/incl=
ude
-idirafter /usr/lib/llvm-18/lib/clang/18/include -idirafter
/usr/local/include -idirafter /usr/include
Makefile.perf:1255: TOOLS_UAPI_INCLUDE:
-I/home/hupu/work/code/explore/linux-mainline/tools/include/uapi
Makefile.perf:1256: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA


From the above BPF_INCLUDE and TOOLS_UAPI_INCLUDE prints, perf was not
prioritizing the kernel=E2=80=99s self-contained headers when compiling the
eBPF program.

I then added KHDR_INCLUDES to BPF_INCLUDE, pointing it to the kernel=E2=80=
=99s
self-contained header directory so that the build prefers headers
provided by the kernel.


diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..65c6e871988b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1202,7 +1202,8 @@ endif

 CLANG_OPTIONS =3D -Wall
 CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARC=
H))
-BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCL=
UDES)
+KHDR_INCLUDES :=3D $(abspath $(OUTPUT)/../../usr/include)
+BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
-I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE :=3D -I$(srctree)/tools/include/uapi

 ifneq ($(WERROR),0)


With this change verified, perf compiles successfully even without
explicitly specifying the cross-toolchain sysroot in the compile
command.

Therefore, before sending PATCH v4, I would appreciate your review and
any suggestions.

Thanks,
hupu
