Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EB156F41
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365107; cv=none; b=kYy0qTW75feisnhCUhxOlOyzA5WZ/2QJZr3FuCjfTUvENSA+FUsGCqQyQHAGMg0vm3wmgssujdxcX4QKQwKK3+FLxdoIct8JgPhA4vVqV0n4KyFDnat8F4v+k1/fDfaXrrF9npR5YWHZlzLaQpPdKs2u0i9cPOthN0zJZ9EmmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365107; c=relaxed/simple;
	bh=MtnIYrVef/9wlQ5Bbhe08rBUgCkg/svBpTGTyJoh1kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9TECX7eQALi9X+xlTMDmYJ7rIptRIkQdw4SLg4jdbhI50EvvRbMSFZ86tLo59t7kYdv2/JFokgTafrzcrwbX6XkvPb+Wk4DYqwHO7V3221J5ryHAw43GWzqp0272oCLnB/rtIqXbejocwR7E8/FnY/p4yCOYprbUAqHd/YR8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ym23BIDl; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ym23BIDl"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a1a662a633so301055ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727365105; x=1727969905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSri9JL680J91pgRRJJsc/rmEXXxa1PyovY5FHVdhDU=;
        b=Ym23BIDlA6UHv0tRTpvCVGGbV3QGN0BirvP23SV3l+GF3N6bXq0kb0lTAxYyVsABQS
         jd5sQWt7GL520E83o4o8sde13m66lbeEmEpdh/3J3Up/cYFSw8USSMt5Z+BcgtMKLsJY
         fnbjd29SsWTazI4xX0XOx5Mx9S6lg4znJOf/3Q+x0VtvF2GmkyYUHbaQ5mBM/0lZcqLq
         1DUUI6alwEdvXMk0qOvAHFaNXk7J8vAnLI3JZULiL6TimStY4KtdO1YG5HbHSJBH8m5w
         WtNDQX6uXUc7WFCoYZcODIukQkiwQnHJkiPQOKKwgWYcnI8w8kFQaPvFiw2y+dVoq38F
         O0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365105; x=1727969905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSri9JL680J91pgRRJJsc/rmEXXxa1PyovY5FHVdhDU=;
        b=SNI3DLbyziUrnMV+D0dTvXa1qOuJb4KIcW2tdR3XXGdK2E1X7YbIhd5Ib1jmrPZM8b
         NrUBYqgsyZNzc74YHACXO2bbmamn7uZ3n6h2ujRe+X9N3z6Gw3L/Dl/6rOfAsMAER0Bj
         ES/5g9a7DQIqAWpElIud7ncoQgygGU8hud+UBQfCXEGYRA8t64w5MNsrF3L5CKhTyNGi
         99+7IIHMLHSocgpDNvqo8N1Wz5JJTqWUIk7nwiQe57tHPmHgv4U2sJemEDqyC/auio5b
         A0FpMZJfrXtPJASCWt46bs+Js/O7meoTcWobq4m8h5foVERZozhyUQ252Qwb0hlPseZV
         M7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWlutgxJpf/46mQziyWpNATFUXISC8hT3+ijlTzyDObMxx7wzouYGTYSZ9MhtPl6w/qIhPao0OP7QwST01/keE3@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxN+sfkWT+CnHugS98sJwuFMNw85QFH9L3E3jg4WrZPhReZM2
	s9UB/2bLaaF2abm/TbYEEal6V1L0ncLvabX7O7Ek+Zs7GJmzRxoEGeWKsm+JcCL+kB2zQcGYUcB
	JeIKNuQUSZtPcrxZ6hZC/2oo3I+D5an1R3fne
X-Google-Smtp-Source: AGHT+IE3N9U8tdbhUlxIIB8MdRCQVW9qGJcOYMmpnFzzoYwGPnvng+GiHqYqAABVIO1rsCaeFX34UA1ILBkpv6PKOHg=
X-Received: by 2002:a05:6e02:198e:b0:3a0:922f:8e9b with SMTP id
 e9e14a558f8ab-3a31b666110mr3754735ab.11.1727365104620; Thu, 26 Sep 2024
 08:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-4-irogers@google.com>
 <ZvSqkGVhD1ETzkDH@google.com>
In-Reply-To: <ZvSqkGVhD1ETzkDH@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:37:51 -0700
Message-ID: <CAP-5=fVvG1h+OA5cO8f=fHX0J-0vDLM190cM178oFYE+i-v5Tg@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] perf build: Rename test-dwarf to test-libdw
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:10AM -0700, Ian Rogers wrote:
> > Be more intention revealing that the dwarf test is actually testing
> > for libdw support.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/build/Makefile.feature                     |  6 +++---
> >  tools/build/feature/Makefile                     | 16 ++++++++--------
> >  tools/build/feature/test-all.c                   |  6 +++---
> >  .../build/feature/{test-dwarf.c =3D> test-libdw.c} |  0
> >  tools/perf/Makefile.config                       |  6 +++---
> >  5 files changed, 17 insertions(+), 17 deletions(-)
> >  rename tools/build/feature/{test-dwarf.c =3D> test-libdw.c} (100%)
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.featur=
e
> > index ffd117135094..6025810cc346 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -30,7 +30,7 @@ endef
> >  #
> >  FEATURE_TESTS_BASIC :=3D                  \
> >          backtrace                       \
> > -        dwarf                           \
> > +        libdw                           \
> >          dwarf_getlocations              \
> >          dwarf_getcfi                    \
> >          eventfd                         \
> > @@ -120,7 +120,7 @@ ifeq ($(FEATURE_TESTS),all)
> >  endif
> >
> >  FEATURE_DISPLAY ?=3D              \
> > -         dwarf                  \
> > +         libdw                  \
> >           dwarf_getlocations     \
> >           glibc                  \
> >           libbfd                 \
> > @@ -233,7 +233,7 @@ endef
> >
> >  #
> >  # generates feature value assignment for name, like:
> > -#   $(call feature_assign,dwarf) =3D=3D feature-dwarf=3D1
> > +#   $(call feature_assign,libdw) =3D=3D feature-libdw=3D1
> >  #
> >  feature_assign =3D feature-$(1)=3D$(feature-$(1))
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 5938cf799dc6..bece326ac93b 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -5,7 +5,7 @@ FILES=3D                                          \
> >           test-all.bin                           \
> >           test-backtrace.bin                     \
> >           test-bionic.bin                        \
> > -         test-dwarf.bin                         \
> > +         test-libdw.bin                         \
> >           test-dwarf_getlocations.bin            \
> >           test-dwarf_getcfi.bin                  \
> >           test-eventfd.bin                       \
> > @@ -168,9 +168,9 @@ $(OUTPUT)test-libopencsd.bin:
> >       $(BUILD) # -lopencsd_c_api -lopencsd provided by
> >                # $(FEATURE_CHECK_LDFLAGS-libopencsd)
> >
> > -DWARFLIBS :=3D -ldw
> > +DWLIBS :=3D -ldw
> >  ifeq ($(findstring -static,${LDFLAGS}),-static)
> > -  DWARFLIBS +=3D -lelf -lz -llzma -lbz2 -lzstd
> > +  DWLIBS +=3D -lelf -lz -llzma -lbz2 -lzstd
> >
> >    LIBDW_VERSION :=3D $(shell $(PKG_CONFIG) --modversion libdw)
> >    LIBDW_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBDW_VERSION)))
> > @@ -179,18 +179,18 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
> >    # Elfutils merged libebl.a into libdw.a starting from version 0.177,
> >    # Link libebl.a only if libdw is older than this version.
> >    ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
> > -    DWARFLIBS +=3D -lebl
> > +    DWLIBS +=3D -lebl
> >    endif
> >  endif
> >
> > -$(OUTPUT)test-dwarf.bin:
> > -     $(BUILD) $(DWARFLIBS)
> > +$(OUTPUT)test-libdw.bin:
> > +     $(BUILD) $(DWLIBS)
> >
> >  $(OUTPUT)test-dwarf_getlocations.bin:
> > -     $(BUILD) $(DWARFLIBS)
> > +     $(BUILD) $(DWLIBS)
> >
> >  $(OUTPUT)test-dwarf_getcfi.bin:
> > -     $(BUILD) $(DWARFLIBS)
> > +     $(BUILD) $(DWLIBS)
> >
> >  $(OUTPUT)test-libelf-getphdrnum.bin:
> >       $(BUILD) -lelf
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-=
all.c
> > index 6f4bf386a3b5..d60e072b6eca 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -38,8 +38,8 @@
> >  # include "test-glibc.c"
> >  #undef main
> >
> > -#define main main_test_dwarf
> > -# include "test-dwarf.c"
> > +#define main main_test_libdw
> > +# include "test-libdw.c"
> >  #undef main
> >
> >  #define main main_test_dwarf_getlocations
> > @@ -187,7 +187,7 @@ int main(int argc, char *argv[])
> >       main_test_get_current_dir_name();
> >       main_test_gettid();
> >       main_test_glibc();
> > -     main_test_dwarf();
> > +     main_test_libdw();
> >       main_test_dwarf_getlocations();
> >       main_test_eventfd();
> >       main_test_libelf_getphdrnum();
> > diff --git a/tools/build/feature/test-dwarf.c b/tools/build/feature/tes=
t-libdw.c
> > similarity index 100%
> > rename from tools/build/feature/test-dwarf.c
> > rename to tools/build/feature/test-libdw.c
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 182e14e39cd5..c8e157cc0c5e 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -159,8 +159,8 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
> >      DWARFLIBS +=3D -lebl
> >    endif
> >  endif
> > -FEATURE_CHECK_CFLAGS-dwarf :=3D $(LIBDW_CFLAGS)
> > -FEATURE_CHECK_LDFLAGS-dwarf :=3D $(LIBDW_LDFLAGS) $(DWARFLIBS)
> > +FEATURE_CHECK_CFLAGS-libdw :=3D $(LIBDW_CFLAGS)
> > +FEATURE_CHECK_LDFLAGS-libdw :=3D $(LIBDW_LDFLAGS) $(DWARFLIBS)
>
> s/DWARFLIBS/DWLIBS/ ?

The patch is changing the name of a feature test. It is possible to
change this Makefile.config variable in the same patch but I think
they are distinct things and the variable rename is follow up work.

Thanks,
Ian

>
> >  FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind :=3D $(LIBDW_CFLAGS)
> >  FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind :=3D $(LIBDW_LDFLAGS) $(DWARF=
LIBS)
>
> Ditto.
>
> Thanks,
> Namhyung
>
>
> >  FEATURE_CHECK_CFLAGS-dwarf_getlocations :=3D $(LIBDW_CFLAGS)
> > @@ -470,7 +470,7 @@ else
> >          $(warning No libdw DWARF unwind found, Please install elfutils=
-devel/libdw-dev >=3D 0.158 and/or set LIBDW_DIR)
> >        endif
> >      endif
> > -    ifneq ($(feature-dwarf), 1)
> > +    ifneq ($(feature-libdw), 1)
> >        ifndef NO_LIBDW
> >          $(warning No libdw.h found or old libdw.h found or elfutils is=
 older than 0.138, disables dwarf support. Please install new elfutils-deve=
l/libdw-dev)
> >          NO_LIBDW :=3D 1
> > --
> > 2.46.0.792.g87dc391469-goog
> >
