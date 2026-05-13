Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905444CAC9
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688392; cv=pass; b=PkJ+QSgeCxkGKU6OJFh5pRzSf8GNXZ8bO5UQT9gb6N+Wh5xytWBLAnKS3RK3HHD09n1sikWbxPSWPQf8TgIu57emkWmQJmtwLPsgbPeoNEUk6CxUu+hlD5C3nHw5ZWBwByrnAyK6O9pWrnirpb/JYdEAlr1zqUzC+qrYCErwUWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688392; c=relaxed/simple;
	bh=5gVdoRtx+/oJDKPbcePSY3tcQb+AQveAM26Qqidc02U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfeg74GGsHiYmzTnfTNIMqFWzYVUgyeboLedPmZFj/3+DxVzmxCuMPr1aYWihGOVN8ythEXxPW6cLUSEuW4o2gyShMUe6Fk1e/kHnRRtAkrg3d5SSNyl5jDHtenWxDgk5vpB9dSfg6wBwGTIO+UW1yk5WRs+3upPaVeDrialW+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V07TfdJ7; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V07TfdJ7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so2085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778688389; cv=none;
        d=google.com; s=arc-20240605;
        b=Co53thlfSEyhfzVNFQEknkZSe7h0tqJC1rEtLdXxvJ6666rrD5BVYf66lKEXt+so4X
         hoIgHVV/HqTwqGTl1456MWo5JpQX4sNqqMD7EOiOGZql5/294f2wRwjUTnIg6pWa8vrh
         KiPxWkxgdzX7GGJS5aQkRzQsPKELYjjZ2NO213f8Y0dfrn7eWRbhCG8ghi4ErJqRKJSn
         UKmoxz9eW2mCI3orCRl8oOSiS5MNEyY2TjB8JXIsOhYZLfRg0UZB5nGTfg42wWv5SiqF
         YvSZ4tGwJW/NhtgWjsH3r0QhjpjlsgffbVLCKzpbYlrJ7wuvqgrao4trh6SzH0d5MCKP
         zFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfdFc0iMLkO9PaSDrq4HVjIy2VtP5THJX+boWxtFUYI=;
        fh=jVg17BULXQP8pGQqqVPPQRJDsH/6xtL49fqEcHudzIo=;
        b=LZRhb4cfPttjglxPMpLB8GIveQ7IlC4SaYIXYPk41SJAnMmxuwLK1NX2AxFgmXdOLe
         MEzRbF6LHH1uSeKqN9GVYsYQkW+l2VqHON2D23Uxz+AQS9k1xdmL4N23Ts0EShtKSBM2
         LQTesgHvGCFRMJ40SeCvCkTuR6v3Y8Dfhbi/FRwX82Uj9gZM4gpNQ2m893jaWcPw6AZJ
         u9sTrjrFV3AT30X2lETQDVcJRW5sPMn2IMMN1BvBHI3fgXfTvewDH8DBjatnf0aJo/0v
         83v8xw2v+tX6cYn0Tc6MihE5sTsuArFTURk4zKfNL8mv05k69MoS4AQuBjOMEzA2WfH1
         +WNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688389; x=1779293189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfdFc0iMLkO9PaSDrq4HVjIy2VtP5THJX+boWxtFUYI=;
        b=V07TfdJ7tfHaGalLIjA7jcrdfpSbI4p37XDks9zs6ktRaE6zm3utuY/28WD6ugS/sG
         2kdoqEm5xd5qCdYB9FAdez0+tK+ju4zZr9Be3PQ0MtxgscMQAe/wYhdnp+80MxrFLuMK
         gmzzBizvRMA0OWBDZxE6fbkVWDVzMvqHkuurDf9buH005RB5osJRmM5ynJH+cZEeIxBd
         tfsF/VEq66jxdXiuf2MYNCrmpOkwKEF4TZBK8OaYCs90WSXpxetDynKkbeXDSXfL+Xx+
         mlc5jtbsWpZTFpoMGpT7PEi6afnkrq80xCgi6GdHjBhSvPvxnYImg5op+J62Y+pQWZVx
         2f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688389; x=1779293189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfdFc0iMLkO9PaSDrq4HVjIy2VtP5THJX+boWxtFUYI=;
        b=BJocqio9lrJE4J9qX/Dyd3fbORgc/v4bwxmuTa31kXHeM1cJUmPsVwC9w1hInjAwUy
         sNWhRzoqQSkQvDkgG+/vVn6ATpM2j530TsTLJfTKiRinXrChu/ZM4bAro+NKEEIgfVRj
         nLqIW2VtKx+Yr8gKtelsEO79tU6qN8UH7Nx9Zdd3RjiwZt7iCsEXPx49E/+7nm51lYe0
         rvFZ+PzGSDxFobWb1+006XI5xYLZdbUs6Jt+duZ5Lb07RzJCH/4UQfunPgSZUw52+zUb
         B2m7B/PwDMdcbNEQ5voL2SEzsQJ8n1l006yEFKyR/XM4aeWYt++9Uf5lTQQStedGJSaq
         P+mA==
X-Forwarded-Encrypted: i=1; AFNElJ8QyVnuyTOoqvgvbE1xPE68FG+mfN9ppEzCORYKLNcR5IsWrrff2YL4h68ODhIUNswF3Qc1GXcUDaiYxC6pB9IP@vger.kernel.org
X-Gm-Message-State: AOJu0YwoS7ivF4Ioaa0PiTfGod9kAPAudNqlKIvt9vaWAwY7ASjtPcI4
	9ZVXR9fJhdm5w37zzUNV89g/dRJhsIxUCzEL/0wQGwETmA8Mksct1fMw+kBneZ4MvngF+4ql4//
	fWmwO2ANs9VZ9dQog4dsa1iEY2yDC6r8BQDd8GlVS
X-Gm-Gg: Acq92OEqpBL/Eln7bQrFjkEdVVjwkD1tDwx6rbqlMGQWcqsguPpt62kmyZNkgd3z84G
	4KPt0KBt849+UKWZlUDvWEmRhW6eChEi3XOXdw2kVIbS7bzy12f/v8xShUBfRg8jE8cqs0i6Z7Q
	PNccrnskydjX3O4xs2L6XT5E1+RYav4RFhbh2CQcOZarbbhxZnk8SdIv/QEPfnobRraYOIhAYmL
	9STqG3SR9rdgNlmSvDH12+6uMxyGDQQaf/ZOgtnIqYFTPM4WpAHM1PZ/aPfxhIwfAA9C1bq6V+w
	ua3cjqZqMNEcbb8IMTKXGZKPaqpq3qnINAFzxqBZyrPM6p73
X-Received: by 2002:a17:902:f650:b0:2b4:58ad:e987 with SMTP id
 d9443c01a7336-2bd2c114e66mr2771085ad.17.1778688388372; Wed, 13 May 2026
 09:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com> <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com>
In-Reply-To: <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 09:06:17 -0700
X-Gm-Features: AVHnY4IIefO6Zi2QefMUkDbEWRJ24KOntGHV7efaecHqUkYcHzmLqas9FE-rJsg
Message-ID: <CAP-5=fVnNyScv=fWy++iucCWWe8G7jcEn=AiDbLEV6PaeBooHQ@mail.gmail.com>
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
To: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 7:14=E2=80=AFAM Michael Jeanson <mjeanson@efficios.=
com> wrote:
>
> On 2026-05-12 17:54, Ian Rogers wrote:
> > On Tue, May 12, 2026 at 12:47=E2=80=AFPM Michael Jeanson <mjeanson@effi=
cios.com> wrote:
> >>
> >> The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and ha=
s
> >> been unmaintained since 2022, efforts have started to remove it from
> >> popular distributions.
> >>
> >> Babeltrace 2.x offers a very similar 'ctf-writer' library that can be =
used
> >> with minimal changes for the '--to-ctf' feature and has been packaged
> >> since Debian 11 and Fedora 32.
> >>
> >> This patch replaces the 'libbabeltrace' build feature with
> >> 'babeltrace2-ctf-writer' using pkgconfig detection, adjusts the naming=
 of
> >> the public headers and applies minor API cleanups.
> >>
> >> No changes to the output ctf traces, this API still implements version
> >> 1.8 of the CTF specification that can be read by either Babeltrace 1 /=
 2
> >> or any CTF compliant reader.
> >>
> >> Also remove some ifdefs in the cli option parsing to allow printing th=
e
> >> helpful error message with '--to-ctf' when built without babeltrace2.
> >>
> >> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> >> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Derek Foreman <derek.foreman@collabora.com>
> >> Cc: Ian Rogers <irogers@google.com>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: James Clark <james.clark@linaro.org>
> >> Cc: Jiri Olsa <jolsa@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> ---
> >>   tools/build/Makefile.feature                  |  5 +--
> >>   tools/build/feature/Makefile                  |  6 ++--
> >>   tools/build/feature/test-all.c                | 13 ++------
> >>   ...ltrace.c =3D> test-babeltrace2-ctf-writer.c} |  3 +-
> >>   tools/perf/Makefile.config                    | 28 ++++++++--------
> >>   tools/perf/Makefile.perf                      |  2 +-
> >>   tools/perf/builtin-check.c                    |  2 +-
> >>   tools/perf/builtin-data.c                     | 18 +++-------
> >>   tools/perf/tests/make                         |  4 +--
> >>   .../shell/test_perf_data_converter_ctf.sh     |  8 ++---
> >>   tools/perf/util/Build                         |  2 +-
> >>   tools/perf/util/data-convert-bt.c             | 33 +++++++++--------=
--
> >>   tools/perf/util/data-convert.h                |  4 +--
> >>   13 files changed, 55 insertions(+), 73 deletions(-)
> >>   rename tools/build/feature/{test-libbabeltrace.c =3D> test-babeltrac=
e2-ctf-writer.c} (59%)
> >>
> >> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.featu=
re
> >> index 0b7a7c38cb88..9e097144817e 100644
> >> --- a/tools/build/Makefile.feature
> >> +++ b/tools/build/Makefile.feature
> >> @@ -113,7 +113,7 @@ FEATURE_TESTS_EXTRA :=3D                  \
> >>            gtk2                           \
> >>            gtk2-infobar                   \
> >>            hello                          \
> >> -         libbabeltrace                  \
> >> +         babeltrace2-ctf-writer         \
> >>            libcapstone                    \
> >>            libbfd-liberty                 \
> >>            libbfd-liberty-z               \
> >> @@ -162,6 +162,7 @@ FEATURE_GROUP_MEMBERS-libbfd =3D libbfd-liberty li=
bbfd-liberty-z
> >>   # Declare list of feature dependency packages that provide pkg-confi=
g files.
> >>   #
> >>   FEATURE_PKG_CONFIG ?=3D           \
> >> +        babeltrace2-ctf-writer \
> >>            libtraceevent          \
> >>            libtracefs
> >>
> >> @@ -208,7 +209,7 @@ ifeq ($(feature-all), 1)
> >>     $(call feature_check,compile-32)
> >>     $(call feature_check,compile-x32)
> >>     $(call feature_check,bionic)
> >> -  $(call feature_check,libbabeltrace)
> >> +  $(call feature_check,babeltrace2-ctf-writer)
> >>   else
> >>     $(foreach feat,$(FEATURE_TESTS),$(call feature_check,$(feat)))
> >>   endif
> >> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefi=
le
> >> index 1fbcb3ce74d2..7735e257c263 100644
> >> --- a/tools/build/feature/Makefile
> >> +++ b/tools/build/feature/Makefile
> >> @@ -48,7 +48,7 @@ FILES=3D                                          \
> >>            test-pthread-barrier.bin              \
> >>            test-stackprotector-all.bin            \
> >>            test-timerfd.bin                       \
> >> -         test-libbabeltrace.bin                 \
> >> +         test-babeltrace2-ctf-writer.bin        \
> >>            test-libcapstone.bin                  \
> >>            test-compile-32.bin                    \
> >>            test-compile-x32.bin                   \
> >> @@ -301,8 +301,8 @@ $(OUTPUT)test-backtrace.bin:
> >>   $(OUTPUT)test-timerfd.bin:
> >>          $(BUILD)
> >>
> >> -$(OUTPUT)test-libbabeltrace.bin:
> >> -       $(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-li=
bbabeltrace)
> >> +$(OUTPUT)test-babeltrace2-ctf-writer.bin:
> >> +       $(BUILD) # -lbabeltrace2-ctf-writer provided by $(FEATURE_CHEC=
K_LDFLAGS-babeltrace2-ctf-writer)
> >>
> >>   $(OUTPUT)test-libcapstone.bin:
> >>          $(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-lib=
capstone)
> >> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test=
-all.c
> >> index 1488bf6e6078..145abdee049d 100644
> >> --- a/tools/build/feature/test-all.c
> >> +++ b/tools/build/feature/test-all.c
> >> @@ -98,17 +98,9 @@
> >>   # include "test-sched_getcpu.c"
> >>   #undef main
> >>
> >> -# if 0
> >> -/*
> >> - * Disable libbabeltrace check for test-all, because the requested
> >> - * library version is not released yet in most distributions. Will
> >> - * reenable later.
> >> - */
> >> -
> >> -#define main main_test_libbabeltrace
> >> -# include "test-libbabeltrace.c"
> >> +#define main main_test_babeltrace2_ctf_writer
> >> +# include "test-babeltrace2-ctf-writer.c"
> >
> > So I still think the comment about libbabeltrace is probably valid:
> > most distributions won't have it by default, so a separate test is
> > likely better than testing with test-all. You also need to update
> > FEATURE_TESTS_BASIFEATURE_TESTS_BASIC.
>
> I went by the comment in 'Makefile.feature' that says features in
> FEATURE_TESTS_EXTRA should be included in 'test-all.c'. I'll remove it.
>
> >
> >>   #undef main
> >> -#endif
> >>
> >>   #define main main_test_lzma
> >>   # include "test-lzma.c"
> >> @@ -178,6 +170,7 @@ int main(int argc, char *argv[])
> >>          main_test_libzstd();
> >>          main_test_libtraceevent();
> >>          main_test_libopenssl();
> >> +       main_test_babeltrace2_ctf_writer();
> >>
> >>          return 0;
> >>   }
> >> diff --git a/tools/build/feature/test-libbabeltrace.c b/tools/build/fe=
ature/test-babeltrace2-ctf-writer.c
> >> similarity index 59%
> >> rename from tools/build/feature/test-libbabeltrace.c
> >> rename to tools/build/feature/test-babeltrace2-ctf-writer.c
> >> index 10bb69d55694..9c89082e9f88 100644
> >> --- a/tools/build/feature/test-libbabeltrace.c
> >> +++ b/tools/build/feature/test-babeltrace2-ctf-writer.c
> >> @@ -1,7 +1,6 @@
> >>   // SPDX-License-Identifier: GPL-2.0
> >>
> >> -#include <babeltrace/ctf-writer/writer.h>
> >> -#include <babeltrace/ctf-ir/stream-class.h>
> >> +#include <babeltrace2-ctf-writer/writer.h>
> >>
> >>   int main(void)
> >>   {
> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index 15fbba9f4ca8..f2f5051c94e3 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -196,13 +196,13 @@ FEATURE_CHECK_CFLAGS-libdw :=3D $(LIBDW_CFLAGS)
> >>   FEATURE_CHECK_LDFLAGS-libdw :=3D $(LIBDW_LDFLAGS) $(DWARFLIBS)
> >>
> >>   # for linking with debug library, run like:
> >> -# make DEBUG=3D1 LIBBABELTRACE_DIR=3D/opt/libbabeltrace/
> >> -ifdef LIBBABELTRACE_DIR
> >> -  LIBBABELTRACE_CFLAGS  :=3D -I$(LIBBABELTRACE_DIR)/include
> >> -  LIBBABELTRACE_LDFLAGS :=3D -L$(LIBBABELTRACE_DIR)/lib
> >> +# make DEBUG=3D1 PKG_CONFIG_PATH=3D/opt/babeltrace2/(lib|lib64)/pkgco=
nfig
> >
> > Delete?
>
> Sure.
>
> >
> >> +
> >> +ifneq ($(NO_BABELTRACE2),1)
> >> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> >> +    $(error Error: $(PKG_CONFIG) needed by babeltrace2 is missing on =
this system, please install it)
> >> +  endif
> >>   endif
> >> -FEATURE_CHECK_CFLAGS-libbabeltrace :=3D $(LIBBABELTRACE_CFLAGS)
> >> -FEATURE_CHECK_LDFLAGS-libbabeltrace :=3D $(LIBBABELTRACE_LDFLAGS) -lb=
abeltrace-ctf
> >>
> >>   # for linking with debug library, run like:
> >>   # make DEBUG=3D1 LIBCAPSTONE_DIR=3D/opt/capstone/
> >> @@ -1058,15 +1058,15 @@ else
> >>     NO_PERF_READ_VDSOX32 :=3D 1
> >>   endif
> >>
> >> -ifndef NO_LIBBABELTRACE
> >> -  $(call feature_check,libbabeltrace)
> >> -  ifeq ($(feature-libbabeltrace), 1)
> >> -    CFLAGS +=3D -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
> >> -    LDFLAGS +=3D $(LIBBABELTRACE_LDFLAGS)
> >> -    EXTLIBS +=3D -lbabeltrace-ctf
> >> -    $(call detected,CONFIG_LIBBABELTRACE)
> >> +ifndef NO_BABELTRACE2
> >> +  $(call feature_check,babeltrace2-ctf-writer)
> >> +  ifeq ($(feature-babeltrace2-ctf-writer), 1)
> >> +    CFLAGS +=3D -DHAVE_BABELTRACE2_SUPPORT $(shell $(PKG_CONFIG) --cf=
lags babeltrace2-ctf-writer)
> >> +    LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs-only-L babeltrace2-ctf-=
writer)
> >> +    EXTLIBS +=3D $(shell $(PKG_CONFIG) --libs-only-l babeltrace2-ctf-=
writer)
> >> +    $(call detected,CONFIG_BABELTRACE2)
> >>     else
> >> -    $(warning No libbabeltrace found, disables 'perf data' CTF format=
 support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
> >> +    $(warning No babeltrace2 found, disables 'perf data' CTF format s=
upport, please install libbabeltrace2-dev[el])
> >>     endif
> >>   endif
> >>
> >> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> >> index f7b936deeaa2..1f4e84a8472e 100644
> >> --- a/tools/perf/Makefile.perf
> >> +++ b/tools/perf/Makefile.perf
> >> @@ -79,7 +79,7 @@ include ../scripts/utilities.mak
> >>   #
> >>   # Define NO_ZLIB if you do not want to support compressed kernel mod=
ules
> >>   #
> >> -# Define NO_LIBBABELTRACE if you do not want libbabeltrace support
> >> +# Define NO_BABELTRACE2 if you do not want babeltrace2-ctf-writer sup=
port
> >>   # for CTF data format.
> >>   #
> >>   # Define NO_CAPSTONE if you do not want libcapstone support
> >> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> >> index 3641d263b345..e9d14a960a03 100644
> >> --- a/tools/perf/builtin-check.c
> >> +++ b/tools/perf/builtin-check.c
> >> @@ -43,7 +43,7 @@ struct feature_status supported_features[] =3D {
> >>          FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
> >>          FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
> >>          FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated=
, license incompatibility, use BUILD_NONDISTRO=3D1 and install binutils-dev=
[el]"),
> >> -       FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
> >> +       FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_SUPP=
ORT),
> >>          FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT)=
,
> >>          FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
> >>          FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
> >> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> >> index 85f59886b5cf..260d74476439 100644
> >> --- a/tools/perf/builtin-data.c
> >> +++ b/tools/perf/builtin-data.c
> >> @@ -40,10 +40,8 @@ const struct option data_options[] =3D {
> >>                  OPT_INCR('v', "verbose", &verbose, "be more verbose")=
,
> >>                  OPT_STRING('i', "input", &input_name, "file", "input =
file name"),
> >>                  OPT_STRING(0, "to-json", &to_json, NULL, "Convert to =
JSON format"),
> >> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
> >>                  OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CT=
F format"),
> >>                  OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wal=
l clock time"),
> >> -#endif
> >>                  OPT_BOOLEAN('f', "force", &opts.force, "don't complai=
n, do it"),
> >>                  OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"=
),
> >>                  OPT_STRING(0, "time", &opts.time_str, "str",
> >> @@ -65,29 +63,21 @@ static int cmd_data_convert(int argc, const char *=
*argv)
> >>                  pr_err("You cannot specify both --to-ctf and --to-jso=
n.\n");
> >>                  return -1;
> >>          }
> >> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
> >>          if (!to_json && !to_ctf) {
> >>                  pr_err("You must specify one of --to-ctf or --to-json=
.\n");
> >>                  return -1;
> >>          }
> >> -#else
> >> -       if (!to_json) {
> >> -               pr_err("You must specify --to-json.\n");
> >> -       return -1;
> >> -}
> >> -#endif
> >>
> >>          if (to_json)
> >>                  return bt_convert__perf2json(input_name, to_json, &op=
ts);
> >>
> >>          if (to_ctf) {
> >> -#if defined(HAVE_LIBBABELTRACE_SUPPORT) && defined(HAVE_LIBTRACEEVENT=
)
> >> +#if defined(HAVE_BABELTRACE2_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> >>                  return bt_convert__perf2ctf(input_name, to_ctf, &opts=
);
> >>   #else
> >> -               pr_err("The libbabeltrace support is not compiled in. =
perf should be "
> >> -                      "compiled with environment variables LIBBABELTR=
ACE=3D1 and "
> >> -                      "LIBBABELTRACE_DIR=3D/path/to/libbabeltrace/.\n=
"
> >> -                      "Check also if libbtraceevent devel files are a=
vailable.\n");
> >> +               pr_err("The babeltrace2 support is not compiled in. En=
sure you have both\n"
> >> +                       "libbabeltrace2-dev[el] and libtraceevent-dev[=
el] installed or set\n"
> >> +                       "PKG_CONFIG_PATH to find a local installation =
of those libraries.\n");
> >>                  return -1;
> >>   #endif
> >>          }
> >> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> >> index 6587dc326d1b..04f9b686cec0 100644
> >> --- a/tools/perf/tests/make
> >> +++ b/tools/perf/tests/make
> >> @@ -93,7 +93,7 @@ make_no_libbpf            :=3D NO_LIBBPF=3D1
> >>   make_libbpf_dynamic :=3D LIBBPF_DYNAMIC=3D1
> >>   make_no_libbpf_DEBUG :=3D NO_LIBBPF=3D1 DEBUG=3D1
> >>   make_no_libllvm     :=3D NO_LIBLLVM=3D1
> >> -make_with_babeltrace:=3D LIBBABELTRACE=3D1
> >> +make_with_babeltrace2 :=3D BABELTRACE2=3D1
> >>   make_with_coresight :=3D CORESIGHT=3D1
> >>   make_no_sdt        :=3D NO_SDT=3D1
> >>   make_no_libpfm4     :=3D NO_LIBPFM4=3D1
> >> @@ -170,7 +170,7 @@ run +=3D make_no_libbpf_DEBUG
> >>   run +=3D make_no_libllvm
> >>   run +=3D make_no_sdt
> >>   run +=3D make_no_syscall_tbl
> >> -run +=3D make_with_babeltrace
> >> +run +=3D make_with_babeltrace2
> >>   run +=3D make_with_coresight
> >>   run +=3D make_with_clangllvm
> >>   run +=3D make_no_libpfm4
> >> diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/=
tools/perf/tests/shell/test_perf_data_converter_ctf.sh
> >> index 334eebc9945e..65d49a10c028 100755
> >> --- a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
> >> +++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
> >> @@ -24,11 +24,11 @@ trap_cleanup()
> >>   }
> >>   trap trap_cleanup exit term int
> >>
> >> -check_babeltrace_support()
> >> +check_babeltrace2_support()
> >>   {
> >> -       if ! perf check feature libbabeltrace
> >> +       if ! perf check feature babeltrace2-ctf-writer
> >>          then
> >> -               echo "perf not linked with libbabeltrace, skipping tes=
t"
> >> +               echo "perf not linked with libbabeltrace2-ctf-writer, =
skipping test"
> >>                  exit 2
> >>          fi
> >>   }
> >> @@ -97,7 +97,7 @@ test_ctf_converter_pipe()
> >>          fi
> >>   }
> >>
> >> -check_babeltrace_support
> >> +check_babeltrace2_support
> >>   test_ctf_converter_file
> >>   test_ctf_converter_pipe
> >>
> >> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> >> index bcccad7487a9..7f3b67c8eeab 100644
> >> --- a/tools/perf/util/Build
> >> +++ b/tools/perf/util/Build
> >> @@ -233,7 +233,7 @@ perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunw=
ind/x86_32.o
> >>   perf-util-$(CONFIG_LIBUNWIND_AARCH64)  +=3D libunwind/arm64.o
> >>
> >>   ifeq ($(CONFIG_LIBTRACEEVENT),y)
> >> -  perf-util-$(CONFIG_LIBBABELTRACE) +=3D data-convert-bt.o
> >> +  perf-util-$(CONFIG_BABELTRACE2) +=3D data-convert-bt.o
> >>   endif
> >>
> >>   perf-util-y +=3D data-convert-json.o
> >> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-=
convert-bt.c
> >> index ba1c8e48d495..91d8cdc9e8c7 100644
> >> --- a/tools/perf/util/data-convert-bt.c
> >> +++ b/tools/perf/util/data-convert-bt.c
> >> @@ -11,14 +11,13 @@
> >>   #include <linux/compiler.h>
> >>   #include <linux/kernel.h>
> >>   #include <linux/zalloc.h>
> >> -#include <babeltrace/ctf-writer/writer.h>
> >> -#include <babeltrace/ctf-writer/clock.h>
> >> -#include <babeltrace/ctf-writer/stream.h>
> >> -#include <babeltrace/ctf-writer/event.h>
> >> -#include <babeltrace/ctf-writer/event-types.h>
> >> -#include <babeltrace/ctf-writer/event-fields.h>
> >> -#include <babeltrace/ctf-ir/utils.h>
> >> -#include <babeltrace/ctf/events.h>
> >> +#include <babeltrace2-ctf-writer/writer.h>
> >> +#include <babeltrace2-ctf-writer/clock.h>
> >> +#include <babeltrace2-ctf-writer/stream.h>
> >> +#include <babeltrace2-ctf-writer/event.h>
> >> +#include <babeltrace2-ctf-writer/event-types.h>
> >> +#include <babeltrace2-ctf-writer/event-fields.h>
> >> +#include <babeltrace2-ctf-writer/utils.h>
> >
> > This is cool, I'm surprised at how non-invasive the change is. I'd
> > done a similar thing but keeping both babeltrace 1 and 2. I'll post my
> > WIP in reply just as a heads up, but I have to do much more heavy
> > engineering.
>
> I think I can rework this to try babeltrace2-ctf-writer first and fall
> back on libbabeltrace1. The change is non-invasive because
> bt2-ctf-writer is basically just a compat API for the ctf-writer of bt1
> but it doesn't expose any of the new features of bt2.
>
> Your WIP patch that uses the proper libbabeltrace2 API is definitely the
> way to go for the long term. In the meantime would you like a v2 of this
> patch?

We have a problem with the perf tool in that it carries too much
baggage due to its library dependencies, so I'd prefer we stick with
v2 support and your cleaner/simpler patch. I'm also hugely
appreciative of the work you've put in! I'm too busy to review my own
work right now, and cleaning this up ASAP offers an advantage.

Thanks,
Ian

* We support libbfd although libbfd is GPLv3 and license incompatible
with perf, which is mainly GPLv2. We carry around libunwind support
but that project appears unmaintained. We have LLVM support but the
LLVM dependency is huge in terms of size and dependencies it brings
in, so people avoid building with it, etc.

> Cheers,
>
> Michael
>
> >
> > Thanks,
> > Ian
> >
> >>   #include "asm/bug.h"
> >>   #include "data-convert.h"
> >>   #include "session.h"
> >> @@ -121,13 +120,13 @@ static int value_set(struct bt_ctf_field_type *t=
ype,
> >>          }
> >>
> >>          if (sign) {
> >> -               ret =3D bt_ctf_field_signed_integer_set_value(field, v=
al);
> >> +               ret =3D bt_ctf_field_integer_signed_set_value(field, v=
al);
> >>                  if (ret) {
> >>                          pr_err("failed to set field value %s\n", name=
);
> >>                          goto err;
> >>                  }
> >>          } else {
> >> -               ret =3D bt_ctf_field_unsigned_integer_set_value(field,=
 val);
> >> +               ret =3D bt_ctf_field_integer_unsigned_set_value(field,=
 val);
> >>                  if (ret) {
> >>                          pr_err("failed to set field value %s\n", name=
);
> >>                          goto err;
> >> @@ -374,10 +373,10 @@ static int add_tracepoint_field_value(struct ctf=
_writer *cw,
> >>                                          data + offset + i * len, len)=
;
> >>
> >>                          if (!(flags & TEP_FIELD_IS_SIGNED))
> >> -                               ret =3D bt_ctf_field_unsigned_integer_=
set_value(
> >> +                               ret =3D bt_ctf_field_integer_unsigned_=
set_value(
> >>                                                  field, value_int);
> >>                          else
> >> -                               ret =3D bt_ctf_field_signed_integer_se=
t_value(
> >> +                               ret =3D bt_ctf_field_integer_signed_se=
t_value(
> >>                                                  field, adjust_signedn=
ess(value_int, len));
> >>                  }
> >>
> >> @@ -471,7 +470,7 @@ add_bpf_output_values(struct bt_ctf_event_class *e=
vent_class,
> >>                  goto put_len_type;
> >>          }
> >>
> >> -       ret =3D bt_ctf_field_unsigned_integer_set_value(len_field, nr_=
elements);
> >> +       ret =3D bt_ctf_field_integer_unsigned_set_value(len_field, nr_=
elements);
> >>          if (ret) {
> >>                  pr_err("failed to set field value for raw_len\n");
> >>                  goto put_len_field;
> >> @@ -500,7 +499,7 @@ add_bpf_output_values(struct bt_ctf_event_class *e=
vent_class,
> >>                  struct bt_ctf_field *elem_field =3D
> >>                          bt_ctf_field_sequence_get_field(seq_field, i)=
;
> >>
> >> -               ret =3D bt_ctf_field_unsigned_integer_set_value(elem_f=
ield,
> >> +               ret =3D bt_ctf_field_integer_unsigned_set_value(elem_f=
ield,
> >>                                  ((u32 *)(sample->raw_data))[i]);
> >>
> >>                  bt_ctf_field_put(elem_field);
> >> @@ -545,7 +544,7 @@ add_callchain_output_values(struct bt_ctf_event_cl=
ass *event_class,
> >>                  goto put_len_type;
> >>          }
> >>
> >> -       ret =3D bt_ctf_field_unsigned_integer_set_value(len_field, nr_=
elements);
> >> +       ret =3D bt_ctf_field_integer_unsigned_set_value(len_field, nr_=
elements);
> >>          if (ret) {
> >>                  pr_err("failed to set field value for perf_callchain_=
size\n");
> >>                  goto put_len_field;
> >> @@ -575,7 +574,7 @@ add_callchain_output_values(struct bt_ctf_event_cl=
ass *event_class,
> >>                  struct bt_ctf_field *elem_field =3D
> >>                          bt_ctf_field_sequence_get_field(seq_field, i)=
;
> >>
> >> -               ret =3D bt_ctf_field_unsigned_integer_set_value(elem_f=
ield,
> >> +               ret =3D bt_ctf_field_integer_unsigned_set_value(elem_f=
ield,
> >>                                  ((u64 *)(callchain->ips))[i]);
> >>
> >>                  bt_ctf_field_put(elem_field);
> >> @@ -728,7 +727,7 @@ static struct ctf_stream *ctf_stream__create(struc=
t ctf_writer *cw, int cpu)
> >>                  goto out;
> >>          }
> >>
> >> -       ret =3D bt_ctf_field_unsigned_integer_set_value(cpu_field, (u3=
2) cpu);
> >> +       ret =3D bt_ctf_field_integer_unsigned_set_value(cpu_field, (u3=
2) cpu);
> >>          if (ret) {
> >>                  pr_err("Failed to update CPU number\n");
> >>                  goto out;
> >> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-con=
vert.h
> >> index ee651fa680a1..d174e6f2729d 100644
> >> --- a/tools/perf/util/data-convert.h
> >> +++ b/tools/perf/util/data-convert.h
> >> @@ -11,10 +11,10 @@ struct perf_data_convert_opts {
> >>          const char *time_str;
> >>   };
> >>
> >> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
> >> +#ifdef HAVE_BABELTRACE2_SUPPORT
> >>   int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
> >>                           struct perf_data_convert_opts *opts);
> >> -#endif /* HAVE_LIBBABELTRACE_SUPPORT */
> >> +#endif /* HAVE_BABELTRACE2_SUPPORT */
> >>
> >>   int bt_convert__perf2json(const char *input_name, const char *to_ctf=
,
> >>                           struct perf_data_convert_opts *opts);
> >> --
> >> 2.47.3
> >>
>
