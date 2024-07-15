Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDC13BC31
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078533; cv=none; b=qjH+/G+NWcfrPLtVzTVzA9Ap1xs++QH301+bnHd8eteAdfkMvvzCgR/xpk5u0uAv0cZur1IDaGsf2jrbzq09uoiR+Qk/XU7j06Fk1zLcUdMscUJAslWpNcF7GnOokjdGQl3/5mNyEJoAUmkSEbaItt9ADZq0WYiXqxUCMRA6tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078533; c=relaxed/simple;
	bh=+znBDLWti/kGJuT7jIDxa1fCKXjDkR7CRkAvMMjBnV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAcDpvCeMLxSEpoYfDb8DducP1lQJN+78vfR3PMkfz2EBN0JY1FBrpH1IuBbT+FBjyo3M4ktH4X/wDtHzUmbxsYRxnfey0Qvqnjgb0/qthszE5wf+uGQ03//fg/ZNWUPX9QfBD3dsw9TTC7iiLR+xvlOQsZO3mSYe69ifpIZtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9T1kRNq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9T1kRNq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447df43324fso39451cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721078529; x=1721683329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Nm3+ofBqebN7d/pyhZLsk5L485DH/suo9KLxMPv8I=;
        b=M9T1kRNqsMcqG9JZ+qi0yMTmdU9hoWkztLXzsBWdicDM79yXP2wXFHn2DkafDdgJ/2
         2MfC/ZQsVbt5YpmCYvxAdQjPFne6+i6pI4Xm1k61QVXz6pflXrLpECovr+Fn9tJnNRXG
         XNHT3mzRpJXuXZJPM9EmjFefoCLARvhbP3JoQaVLyjrLrSOGAPdQvxbuNKfuoO8NDep8
         qKP5BlsB8Y5Y1Y3tdsrO7CYkPxLfQPXfFs3CsDJB33gavlkfhXUMCFzPylDWZHqReBB/
         xVY4hCs8cqfjarrjl7odNM+eeN9d4J6vB/JX+gIDVByvhbmwbJrfLj8S8K5J6AtDjYqL
         1HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721078529; x=1721683329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Nm3+ofBqebN7d/pyhZLsk5L485DH/suo9KLxMPv8I=;
        b=J0WSQo0EG73YV1xT8SKPEYAaB2tD69jeohaIaXS2wg6j49kYXVEPJiWJf0gEIsrYwL
         TYzHGuJ+YYE29PWa+P2oIu2W96Bw9iDltgFEb1bYLlyDJtLQrJ+3Rw1U8iKsdu5axL4T
         Vz2ny4fWYn7sTQ23wK/KqxCSyOi/yRFnkv4nF+p8EN8cjjEi+K3zv5j75tCsENzGnzVy
         +/TaNSsPHYAzVe90oxLHsTHcxlhBQihv9RgHUEOgcjt52Q2x98OXjwxaZEUwJ49KqGjq
         6BFkKk2n8x46wgry+fr1mr7UywuSwGIzzn2vxaJo9y8KwCmMktD7dW8Yy2j72/ZS9XOq
         x3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4SBMAijIwKFWFQtJKGu/vpcpwQqWQLj2s6Jo56ocrEGAU+a+HAm+doAJyFrGGvQIMKIfTWlPTM0u+vWs23mfP/JRneLcfbagV3TTpHdyzvg==
X-Gm-Message-State: AOJu0Yx/Zkx86w1XpTHc1ciqwiY2r/sdbx2KgvDJ/d2udiAE900WItOv
	d6ImXYi8nPiTfbe8+XsMN+oY/fLn3EYYRGtSmKy0B4lirhur+rep61X+nGNAU12i391405OCnI2
	GEd2Nhn0BOKfJ+5FFZujSnbbMPUeuHj3G6FzQ
X-Google-Smtp-Source: AGHT+IGRBg1MEx2t5L1qt0HNnd12qrvNuy1HoT/abY82f5acAhSwMp5kv9wh/3u3A5l72tu4b5WBSmrcFCmo5Xpm8vc=
X-Received: by 2002:a05:622a:4885:b0:447:f108:f80e with SMTP id
 d75a77b69052e-44f7a6706e1mr1039841cf.16.1721078529421; Mon, 15 Jul 2024
 14:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com> <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com> <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
 <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com> <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com>
In-Reply-To: <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 14:21:57 -0700
Message-ID: <CAP-5=fU=LguHNi861L4gmgZWXrrgZtG1w5cdw7hXDxnfWyJyMQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 1:36=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On 7/15/2024 9:06 PM, Ian Rogers wrote:
>
> [...]
>
> > So if I add (somewhat taken from tools/testing/selftests/lib.mk):
> > ```
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 5271a4c1d2b3..9edf5f41d6e4 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -19,6 +19,35 @@ detected_var =3D $(shell echo "$(1)=3D$($(1))" >>
> > $(OUTPUT).config-detected)
> > CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNI=
NGS))
> > HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> >
> > +CLANG :=3D clang
> > +
> > +CLANG_TARGET_FLAGS_arm          :=3D arm-linux-gnueabi
> > +CLANG_TARGET_FLAGS_arm64        :=3D aarch64-linux-gnu
> > +CLANG_TARGET_FLAGS_hexagon      :=3D hexagon-linux-musl
> > +CLANG_TARGET_FLAGS_i386         :=3D i386-linux-gnu
> > +CLANG_TARGET_FLAGS_m68k         :=3D m68k-linux-gnu
> > +CLANG_TARGET_FLAGS_mips         :=3D mipsel-linux-gnu
> > +CLANG_TARGET_FLAGS_powerpc      :=3D powerpc64le-linux-gnu
> > +CLANG_TARGET_FLAGS_riscv        :=3D riscv64-linux-gnu
> > +CLANG_TARGET_FLAGS_s390         :=3D s390x-linux-gnu
> > +CLANG_TARGET_FLAGS_x86          :=3D x86_64-linux-gnu
> > +CLANG_TARGET_FLAGS_x86_64       :=3D x86_64-linux-gnu
> > +
> > +# Default to host architecture if ARCH is not explicitly given.
> > +ifeq ($(ARCH),)
> > +CLANG_TARGET_FLAGS :=3D $(shell $(CLANG) -print-target-triple)
> > +else
> > +CLANG_TARGET_FLAGS :=3D $(CLANG_TARGET_FLAGS_$(ARCH))
> > +endif
> > +
> > +ifeq ($(CLANG_TARGET_FLAGS),)
> > +$(error Specify CROSS_COMPILE or add '--target=3D' option to lib.mk)
> > +else
> > +CLANG_FLAGS     +=3D --target=3D$(CLANG_TARGET_FLAGS)
> > +endif # CLANG_TARGET_FLAGS
> > +
> > +CC :=3D $(CLANG) $(CLANG_FLAGS) -fintegrated-as
> > +
> > # Enabled Wthread-safety analysis for clang builds.
> > ifeq ($(CC_NO_CLANG), 0)
> >   CFLAGS +=3D -Wthread-safety
> > ```
> > I was able to build with:
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/perf
> > O=3D/tmp/perf NO_LIBELF=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBPYTHON=3D1 CC=3D=
clang
> > CXX=3Dclang++
>
> This command doesn't work for me.
>
> Built with 'CROSS_COMPILE=3Daarch64-linux-gnu-' option, the perf tool is =
still
> built with GCC:
>
>   $ strings perf | grep GCC
>   GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
>
> After removing the option 'CROSS_COMPILE=3Daarch64-linux-gnu-', still fai=
led
> building.
>
> Anyway, thanks a lot for sharing.

Hmm.. I can repro but I don't see where the string comes from and my
build is definitely using clang:
```
$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/perf
O=3D/tmp/perf NO_LIBELF=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBPYTHON=3D1 CC=3Dclan=
g
CXX=3Dclang++ V=3D1
...
clang --target=3Daarch64-linux-gnu -fintegrated-as  -Wbad-function-cast
-Wdeclaration-after-statement -Wformat-security -Wformat-y2k
-Winit-self -Wmissing-declarations -Wmissing-prototypes
-Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
-Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef
-Wwrite-strings -Wformat -Wno-type-limits -Wshadow -Wthread-safety
-DHAVE_SYSCALL_TABLE_SUPPORT -I/tmp/perf/arch/arm64/include/generated
-DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -DNDEBUG=3D1 -O3
-fno-omit-frame-pointer -Wall -Wextra -std=3Dgnu11 -fstack-protector-all
-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I~/src/tools/perf/util/include
-I~/src/tools/perf/arch/arm64/include -I~/src/tools/include/
-I~/src/tools/arch/arm64/include/uapi -I~/src/tools/include/uapi
-I~/src/tools/arch/arm64/include/ -I~/src/tools/arch/arm64/
-I/tmp/perf//util -I/tmp/perf/ -I~/src/tools/perf/util
-I~/src/tools/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
-DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT
-DHAVE_GET_CURRENT_DIR_NAME -DHAVE_GETTID -DHAVE_FILE_HANDLE
-DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
-DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DNO_LIBPERL
-DHAVE_TIMERFD_SUPPORT -DNO_LIBPYTHON -DHAVE_BACKTRACE_SUPPORT
-DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT
-I/tmp/perf/libapi/include -I/tmp/perf/libsubcmd/include
-I/tmp/perf/libsymbol/include -I/tmp/perf/libperf/include -I/tmp/perf/
-Wl,-z,noexecstack \
        /tmp/perf/perf-in.o -Wl,--whole-archive
/tmp/perf/libapi/libapi.a /tmp/perf/libperf/libperf.a
/tmp/perf/libsubcmd/libsubcmd.a /tmp/perf/libsymbol/libsymbol.a
/tmp/perf/libperf-bench.a /tmp/perf/libperf-test.a
/tmp/perf/libperf-ui.a /tmp/perf/libperf-util.a
/tmp/perf/libpmu-events.a  -Wl,--no-whole-archive -Wl,--start-group
-lpthread -lrt -lm -ldl -Wl,--end-group -o /tmp/perf/perf
$ strings /tmp/perf/perf|grep GCC
GCC: (Debian 13.2.0-13) 13.2.0
$ find /tmp/perf -name '*.[oa]' -exec sh -c "strings {} | grep GCC" \; -pri=
nt
GCC: (Debian 13.2.0-13) 13.2.0
/tmp/perf/fixdep.o
GCC: (Debian 13.2.0-13) 13.2.0
/tmp/perf/fixdep-in.o
```
fixdep is being compiled with HOSTCC which isn't clang. Some more digging:
```
$ aarch64-linux-gnu-readelf -p .comment /tmp/perf/perf

String dump of section '.comment':
 [     0]  GCC: (Debian 13.2.0-13) 13.2.0
 [    1f]  Debian clang version 16.0.6 (20+build1)
```
So I suspect that the GCC is coming from crt0.o and that the binary
was built with clang.

Thanks,
Ian

> Leo
>
> > Obviously not a complete fix as it is unconditionally forcing CC to
> > clang, but I don't think we're too far from having a clang/llvm cross
> > compile build that can work.
> >
> > Thanks,
> > Ian
