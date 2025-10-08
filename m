Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED15224AEB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935529; cv=none; b=I/x4SYHDnRHvLmCJiwpqHsstDNnUcx5bB0T1h/XiMP2Y0EI+b8QspBYd965UoFIpR4kxjpov6sUZFbnCCSuQ3du/iFyI2G/YRdHnQNWVFHTRq4rGqlKh+7DkHlOn6SqHUi3RH8ek72IB6yURchKvXZNHLXycj7NMrCNmVdUOBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935529; c=relaxed/simple;
	bh=zatW9z7+BlJwtBT1+Ih7xLccccTvW54o/aTpYz4t0QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kD2T/ntRaGOWbUkw39as5fA/r0hVenv+I6Awoo0Q/kZ9pFvGLM1JPLgeyjy59M94CwlrgCvttnqyClInoNZeZfM9434i7uNsi2jdOFZY0DEaQzpuF9Ypc8uUTyn2JTHHlfYyLyMw2+DiCqFZY1OyikgVrWYzcNcYxQfkJyDWMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WeMq0Xw9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeMq0Xw9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eeafd4882so279055ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759935527; x=1760540327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE2Qs8AzdRpLDpT1BMz7CfM7cxp6la5yYDPSZ12gux0=;
        b=WeMq0Xw9/oQHwyafxfbQJ97DnMZgYlaYux2sfwIRUdUc/3NaNY0guyahQxpYG15cBC
         c4YIKGkq/7q5VQngET045QWi5dGVLdN/Y4VWrltGbn+LZohJq7RYAXsQwwIv4z9ww09f
         VBFRK2+sU59diVceHQJuHEGQoHyLmZ5MTF4TC3Ltj+mlQWnPzwdokz44o7YtDtT5abPT
         soomYZMWgOVCCcp4j/Cuzm0zeMhmYRktNVxp8T+H4gZMsXP0ciG2cNvevqIPJFTusz8a
         fmp4UvXyVeigpapNEEyKVzxvqFRxT5AWRsxuCm66CEU9kjphTC3she6WWtf0pEC/vFj5
         UWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759935527; x=1760540327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE2Qs8AzdRpLDpT1BMz7CfM7cxp6la5yYDPSZ12gux0=;
        b=lR1QAdKaMJurRlQnE3x6vzk4qb47g/j6KcGFeV90xStiHq0Qykf4q8mqVe+wpsJ+uA
         oiEooUEJiITQxfJ5la+imBZ8OLOS3CcY6goqpdD7PqdabItuamtyUc8QMuVeJ5TUzc16
         Ue6l+lxpV8fAmF3Ppul9UDJuXdZQ++3Z0aktW731+dubVFc9awTpOcOZC2Kc8hKOlC/6
         CrMBJ2jrBc+y/MzOBqSDX0CWbG5JQif15lT6bs4UXfXI1GYdDK8WaBbAQ+3uzFOh+UMM
         EVVCwqZWfsghU2K5AIfdzOelwyZviR+1TOS01bwcoYJDCMGMX42qaJ+LCSZwAlMwjzfZ
         KncA==
X-Forwarded-Encrypted: i=1; AJvYcCXsSevS69TiWpgIFmQxMxN2loPX11uYX8jB3od0d1Ns5RtxPfY1ti42lufpg2ekDN2Q3fReI+7mxFgSXhXEx/45@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaOr2DgD+H6gnvqnHtPmyqAlAj7m/g8YgOfLh/dF3dpQGi5sL
	vkEgSv99ZulAmsdV3LFAPrZJUiCUd6wsBoBRFTzokq3vbZ9MqODypmtKhtMtuKSjJx/dUPhPata
	C4Q7MgNMRVqwAnquSe8OhXqYxjnjMXENLsPDkcHVV
X-Gm-Gg: ASbGncu9Xd27Qy+id9ATlWUi9gDujyMKxuotQnYYwsGehgSiFYG32FM0Ff9QpB4yob0
	kozO9GpcYPmqJdlJujVmATxm1q06lQvvsucjGmEmqu0p96rGcmqxIz3Uic4FR/5RVzaAZz0jQ5e
	3p7/69JefIkYh6o8e4nTIhUII/lJLV9pgnNY2mSKoWiYfUmCdTcgvJj2LtH9tF/cv3vk4fEX0JD
	B3xMjoD8OAaUKdAGis5hcf69+dKauVKnNI2Ew7+Agu091jGif2g42FLVtXE9XyB5Fy2dv9prmwQ
	5n4=
X-Google-Smtp-Source: AGHT+IFRlzQMIt76FcOgy9rt2zd/DLc7gxGeQb7DYEWr8wcv6vgl0GFuJT2bUyuZEkal3hjLZpnYHVTBO0UBsaFcvkc=
X-Received: by 2002:a17:903:11c4:b0:269:2215:e672 with SMTP id
 d9443c01a7336-29027699a6bmr5063445ad.12.1759935526647; Wed, 08 Oct 2025
 07:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com> <20251005182430.2791371-6-irogers@google.com>
 <fcba9459-9a5a-44c9-976a-323a6f4e0429@linaro.org>
In-Reply-To: <fcba9459-9a5a-44c9-976a-323a6f4e0429@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 07:58:35 -0700
X-Gm-Features: AS18NWDiuoJi-sThA-Lh2RXQOiDwJNmDyu8MKIgLUOZTrcVC_jG6TV2oU_hi3Tw
Message-ID: <CAP-5=fVervG=fmG7naTut3ERzwTTp7yQvuwqNkoKxSBSLsbgGA@mail.gmail.com>
Subject: Re: [PATCH v7 05/27] perf jevents: Support copying the source json
 files to OUTPUT
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:10=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
> On 05/10/2025 7:24 pm, Ian Rogers wrote:
> > The jevents command expects all json files to be organized under a
> > single directory. When generating json files from scripts (to reduce
> > laborious copy and paste in the json) we don't want to generate the
> > json into the source directory if there is an OUTPUT directory
> > specified. This change adds a GEN_JSON for this case where the
> > GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
> > specified. The Makefile.perf clean code is updated to clean up this
> > directory when present.
> >
> > This patch is part of:
> > https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.co=
m/
> > which was similarly adding support for generating json in scripts for
> > the consumption of jevents.py.
> >
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Hi Ian,
>
> This commit breaks the build on x86 for me, but not Arm. I also had to
> do a clean build when bisecting as it seemed to be sticky in some way.
>
> It fails on the empty pmu events file diff check:
>
> diff -u pmu-events/empty-pmu-events.c
> /home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.=
c
> 2>
> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log
> || (cat
> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log
> && false)
> --- pmu-events/empty-pmu-events.c       2025-10-08 11:49:46.341849139 +01=
00
> +++
> /home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.=
c
>   2025-10-08 11:54:40.619999115 +0100
> @@ -19,239 +19,8 @@
>   };
>
>   static const char *const big_c_string =3D
> -/* offset=3D0 */ "software\000"
> ...
>
> The output continues with the rest of the diff, but I assume it's not
> important to reproduce the issue.

I've similarly had issues with empty-pmu-events.c and the test that as
you say are resolved by a clean build. When I've investigated in the
past it is the dependencies on the files are accurate but some are
added or removed, I think adding the Makefile as a dependency for
building empty-pmu-events.c was a resolution but in general we've not
done that so I didn't send out a fix.

Thanks,
Ian

> Thanks
> James
>
> > ---
> >   tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
> >   tools/perf/pmu-events/Build | 18 ++++++++++++------
> >   2 files changed, 28 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 7d6ac03a7109..278e51e4b5c6 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
> >   bpf-skel-clean:
> >       $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETON=
S) $(SKEL_OUT)/vmlinux.h
> >
> > +pmu-events-clean:
> > +ifeq ($(OUTPUT),)
> > +     $(call QUIET_CLEAN, pmu-events) $(RM) \
> > +             pmu-events/pmu-events.c \
> > +             pmu-events/metric_test.log \
> > +             pmu-events/test-empty-pmu-events.c \
> > +             pmu-events/empty-pmu-events.log
> > +else # When an OUTPUT directory is present, clean up the copied pmu-ev=
ents/arch directory.
> > +     $(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch=
 \
> > +             $(OUTPUT)pmu-events/pmu-events.c \
> > +             $(OUTPUT)pmu-events/metric_test.log \
> > +             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
> > +             $(OUTPUT)pmu-events/empty-pmu-events.log
> > +endif
> > +
> >   clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBO=
L)-clean $(LIBPERF)-clean \
> >               arm64-sysreg-defs-clean fixdep-clean python-clean bpf-ske=
l-clean \
> > -             tests-coresight-targets-clean
> > +             tests-coresight-targets-clean pmu-events-clean
> >       $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-=
archive \
> >               $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> >       $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -de=
lete -o \
> > @@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUB=
CMD)-clean $(LIBSYMBOL)-clean $(
> >               $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)uti=
l/*-flex* \
> >               $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
> >               $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}=
.c \
> > -             $(OUTPUT)pmu-events/pmu-events.c \
> > -             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
> > -             $(OUTPUT)pmu-events/empty-pmu-events.log \
> > -             $(OUTPUT)pmu-events/metric_test.log \
> >               $(OUTPUT)$(fadvise_advice_array) \
> >               $(OUTPUT)$(fsconfig_arrays) \
> >               $(OUTPUT)$(fsmount_arrays) \
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 32f387d48908..1503a16e662a 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -1,7 +1,6 @@
> >   pmu-events-y        +=3D pmu-events.o
> >   JDIR                =3D  pmu-events/arch/$(SRCARCH)
> > -JSON         =3D  $(shell [ -d $(JDIR) ] &&                           =
 \
> > -                     find $(JDIR) -name '*.json' -o -name 'mapfile.csv=
')
> > +JSON         =3D  $(shell find pmu-events/arch -name *.json -o -name *=
.csv)
> >   JDIR_TEST   =3D  pmu-events/arch/test
> >   JSON_TEST   =3D  $(shell [ -d $(JDIR_TEST) ] &&                      =
 \
> >                       find $(JDIR_TEST) -name '*.json')
> > @@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
> >       $(call rule_mkdir)
> >       $(Q)$(call echo-cmd,gen)cp $< $@
> >   else
> > +# Copy checked-in json for generation.
> > +$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> > +     $(call rule_mkdir)
> > +     $(Q)$(call echo-cmd,gen)cp $< $@
> > +
> > +GEN_JSON =3D $(patsubst %,$(OUTPUT)%,$(JSON))
> > +
> >   $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
> >       $(call rule_mkdir)
> >       $(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
> >
> > -$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRI=
C_PY) $(METRIC_TEST_LOG)
> > +$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(M=
ETRIC_PY) $(METRIC_TEST_LOG)
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-eve=
nts/arch $@
> > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPU=
T)pmu-events/arch $@
> >
> >   $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_=
EVENTS_C)
> >       $(call rule_mkdir)
> > @@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
> >       $(call rule_mkdir)
> >       $(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && =
false)
> >
> > -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(MET=
RIC_TEST_LOG) \
> > +$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $=
(METRIC_TEST_LOG) \
> >       $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_E=
VENTS_PYLINT_TEST_LOGS)
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $=
(JEVENTS_MODEL) pmu-events/arch $@
> > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $=
(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
> >   endif
> >
> >   # pmu-events.c file is generated in the OUTPUT directory so it needs =
a
>
