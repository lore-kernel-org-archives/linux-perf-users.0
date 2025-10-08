Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654452C0F62
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959798; cv=none; b=ipzjwRfkfMgqPQ68Y+c/cLc9XIgPNB7n4m2ulDTEpP7XoXixpCDn/xKapai10LVSzKlbUU6jWg48T8GjvVDM9jCMRohlmUqLApyKvPWdl9BxAqDp5XQVtK1WEjIPKPCOI+nisGu+0JL4pt74tX3Hx+l08Y8vWOR5ThGeSy5O9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959798; c=relaxed/simple;
	bh=ARXYGRH0hqA9+AeyMzxmDEW0dBxT+zTXpJjEa0sXjmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbIXJbOwSYyC128Rv+JehHBGhBokWHQ/BjiRgELi1Yvvyn4vRNrMTt1HJLNRWQMLIBfm2s8ip4X00hO86FRPeeN7HFEjIQxuik9lDCexvohJlgz2+JXV5qwi5jmX4g3dKcYMcTzMPfebp1QnMQVDvcXZ2fHDCs0EuewGMjngkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBgCsz8J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBgCsz8J"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so78965ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759959796; x=1760564596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2fuMCP1sy89+lhYN3DsuIIe7UgVwgx4dMuIb3MIPfg=;
        b=mBgCsz8JSBmUyNks9qwqnvxfX+kzUCEhZNk47DN0ho1kagoBUsBepNWBYomam+73OV
         FmUD/0R94c4WlnK7k3V/RTaAMPHEkqRgnui4kw9ne4nL1wPB+H+kbXgXztfB9CbVGQdf
         uqylEKUXZNTWyifsAP7vOJ0iUxoBMT2BseiZ4uf/wE3Z0gca/YcjcYN0o+LB+POdULnL
         5AHCW5hOOLh30JFN+UciAU2Vw4zkCuhvLNzUILJCBEi7K43YC5qvlDNL3oe7GCjIeBNP
         1gSMtX35J0OjJ7fxffgwpWOZU3HLI68Bi3rUKXbglSJLvBfMClmlGAXER9ed6d2a/KS4
         sZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959796; x=1760564596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2fuMCP1sy89+lhYN3DsuIIe7UgVwgx4dMuIb3MIPfg=;
        b=gyy7CD23Sq0sm+zMbYyl/6aJTz/1r2C8jCAZQ5WRynHuiiLSbfFZ4zRiEXiMxFSZQu
         z+px2RVM33NBg8fLRFBFY2WAkA1Q8NTKmvPaMlJVnz/ffaVVZJMSljnymCPga5tabd4q
         2WmccE/R7dE2kB3a5to9DS/lxNUcpE5CDnGaoCE31TnwZVWl9ea15EeXlyElzWrpoThA
         SqlLRm7kVmApdeX1ZComnis7orOsKnQKcyp/O75eGu4zrZ2Own8e5CapNJhoxbsXuoO4
         4KZuYXzaZP2t7ou9KaOXWotdZ1mUV+H7q40vUi2KM7TGSZQ71oqbpUFF2Fg7f5KIDip9
         ceIg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ptfJ/kUwXm6H5t7oE4RFPQ7MjW65RsMqQyn+QaUBdUhxPgKNuXQTJAdpbQrToYbyNngNxKZrx2r6KgoBZcje@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2XRQiC9jfMB6BZH5XbfQk2IGaCPp1w2nF0djYupRbzLzFWR1
	cF+I5rJ1AI5lGzgG8aWP0Zq+PuRBAJi7qIQ1QG3ElDKyaJHEAdYDeTtm34OTmQ3Mc2YrDIHvbE0
	W3gULuyNN9gD/bUaZ4rtuV1GmIjyBPX+84QXsAUns
X-Gm-Gg: ASbGncsn87qj2UW/Rp2fKPVkrN/W0NFiUvSCeXO82KCSNWlT5O0SfnMwtFUhsI2dx+9
	divNTq5lIrwuN2qNiO8i8jniIuYOFq5qCbL9KGHpZQcR4nYH3MrvHI3zgteVApCTOyeEwPXiE5N
	/Hc89q9JmXBcihaGlb5eaLx5TH/00ULgJ4mU+prXU/bLxZrmSONOUi7qEkBajOuO1PpMCO54h6U
	wub7ndWHkuDr1JpSKptX03QPm1kUAhyf19z0EiX2SafVKR9z9wKZdrH+hnXKTJRPKrG
X-Google-Smtp-Source: AGHT+IFxnsq2l/VAiZk5mWvuxYgF3CQXfnpHofl+6taTokvrZwh7Sdn4YSXETaHvpi7HQ0E16Ci6oHNCDywBNSrwBWg=
X-Received: by 2002:a17:902:da85:b0:24b:131c:48b4 with SMTP id
 d9443c01a7336-290276035b7mr8435375ad.5.1759959795207; Wed, 08 Oct 2025
 14:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com> <20251005182430.2791371-6-irogers@google.com>
 <fcba9459-9a5a-44c9-976a-323a6f4e0429@linaro.org> <CAP-5=fVervG=fmG7naTut3ERzwTTp7yQvuwqNkoKxSBSLsbgGA@mail.gmail.com>
 <947c4e39-ee4e-4798-b783-8dec9a58f75d@linaro.org>
In-Reply-To: <947c4e39-ee4e-4798-b783-8dec9a58f75d@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 14:43:03 -0700
X-Gm-Features: AS18NWDCYIaft8DrNuOj6VtwSQS0-WqQy6TsOFCzOxDNw3H_Rxxf_w3tcmlRKoY
Message-ID: <CAP-5=fWLH4GjgKBt3_QERoYyHreswj8qTQ326gRKkFL0SROyUw@mail.gmail.com>
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

On Wed, Oct 8, 2025 at 8:14=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 08/10/2025 3:58 pm, Ian Rogers wrote:
> > On Wed, Oct 8, 2025 at 4:10=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >> On 05/10/2025 7:24 pm, Ian Rogers wrote:
> >>> The jevents command expects all json files to be organized under a
> >>> single directory. When generating json files from scripts (to reduce
> >>> laborious copy and paste in the json) we don't want to generate the
> >>> json into the source directory if there is an OUTPUT directory
> >>> specified. This change adds a GEN_JSON for this case where the
> >>> GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
> >>> specified. The Makefile.perf clean code is updated to clean up this
> >>> directory when present.
> >>>
> >>> This patch is part of:
> >>> https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.=
com/
> >>> which was similarly adding support for generating json in scripts for
> >>> the consumption of jevents.py.
> >>>
> >>> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>
> >> Hi Ian,
> >>
> >> This commit breaks the build on x86 for me, but not Arm. I also had to
> >> do a clean build when bisecting as it seemed to be sticky in some way.
> >>
> >> It fails on the empty pmu events file diff check:
> >>
> >> diff -u pmu-events/empty-pmu-events.c
> >> /home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-even=
ts.c
> >> 2>
> >> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.lo=
g
> >> || (cat
> >> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.lo=
g
> >> && false)
> >> --- pmu-events/empty-pmu-events.c       2025-10-08 11:49:46.341849139 =
+0100
> >> +++
> >> /home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-even=
ts.c
> >>    2025-10-08 11:54:40.619999115 +0100
> >> @@ -19,239 +19,8 @@
> >>    };
> >>
> >>    static const char *const big_c_string =3D
> >> -/* offset=3D0 */ "software\000"
> >> ...
> >>
> >> The output continues with the rest of the diff, but I assume it's not
> >> important to reproduce the issue.
> >
> > I've similarly had issues with empty-pmu-events.c and the test that as
> > you say are resolved by a clean build. When I've investigated in the
> > past it is the dependencies on the files are accurate but some are
> > added or removed, I think adding the Makefile as a dependency for
> > building empty-pmu-events.c was a resolution but in general we've not
> > done that so I didn't send out a fix.
> >
> > Thanks,
> > Ian
> >
>
> Yeah this is the second time I've hit this, but this time it didn't get
> me stuck for too long because I recognized it.
>
> I double checked building the last commit of the series after a clean
> and it still fails, so I think that's an issue in addition to the
> dependency issue. Considering this change touches the Makefile maybe we
> can ignore the dependency issue for now and assume that a clean is requir=
ed.

Agreed. I'm wondering if/when this series will get picked up for
perf-tools-next now that it has tags?
I need to rebase the python metrics on it. I'd also like to migrate
the hard coded metrics to being in json using the legacy json events.

Thanks,
Ian

> >> Thanks
> >> James
> >>
> >>> ---
> >>>    tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
> >>>    tools/perf/pmu-events/Build | 18 ++++++++++++------
> >>>    2 files changed, 28 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> >>> index 7d6ac03a7109..278e51e4b5c6 100644
> >>> --- a/tools/perf/Makefile.perf
> >>> +++ b/tools/perf/Makefile.perf
> >>> @@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
> >>>    bpf-skel-clean:
> >>>        $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELE=
TONS) $(SKEL_OUT)/vmlinux.h
> >>>
> >>> +pmu-events-clean:
> >>> +ifeq ($(OUTPUT),)
> >>> +     $(call QUIET_CLEAN, pmu-events) $(RM) \
> >>> +             pmu-events/pmu-events.c \
> >>> +             pmu-events/metric_test.log \
> >>> +             pmu-events/test-empty-pmu-events.c \
> >>> +             pmu-events/empty-pmu-events.log
> >>> +else # When an OUTPUT directory is present, clean up the copied pmu-=
events/arch directory.
> >>> +     $(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/ar=
ch \
> >>> +             $(OUTPUT)pmu-events/pmu-events.c \
> >>> +             $(OUTPUT)pmu-events/metric_test.log \
> >>> +             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
> >>> +             $(OUTPUT)pmu-events/empty-pmu-events.log
> >>> +endif
> >>> +
> >>>    clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSY=
MBOL)-clean $(LIBPERF)-clean \
> >>>                arm64-sysreg-defs-clean fixdep-clean python-clean bpf-=
skel-clean \
> >>> -             tests-coresight-targets-clean
> >>> +             tests-coresight-targets-clean pmu-events-clean
> >>>        $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)pe=
rf-archive \
> >>>                $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> >>>        $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' =
-delete -o \
> >>> @@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBS=
UBCMD)-clean $(LIBSYMBOL)-clean $(
> >>>                $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)=
util/*-flex* \
> >>>                $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
> >>>                $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocati=
on}.c \
> >>> -             $(OUTPUT)pmu-events/pmu-events.c \
> >>> -             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
> >>> -             $(OUTPUT)pmu-events/empty-pmu-events.log \
> >>> -             $(OUTPUT)pmu-events/metric_test.log \
> >>>                $(OUTPUT)$(fadvise_advice_array) \
> >>>                $(OUTPUT)$(fsconfig_arrays) \
> >>>                $(OUTPUT)$(fsmount_arrays) \
> >>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Buil=
d
> >>> index 32f387d48908..1503a16e662a 100644
> >>> --- a/tools/perf/pmu-events/Build
> >>> +++ b/tools/perf/pmu-events/Build
> >>> @@ -1,7 +1,6 @@
> >>>    pmu-events-y        +=3D pmu-events.o
> >>>    JDIR                =3D  pmu-events/arch/$(SRCARCH)
> >>> -JSON         =3D  $(shell [ -d $(JDIR) ] &&                         =
   \
> >>> -                     find $(JDIR) -name '*.json' -o -name 'mapfile.c=
sv')
> >>> +JSON         =3D  $(shell find pmu-events/arch -name *.json -o -name=
 *.csv)
> >>>    JDIR_TEST   =3D  pmu-events/arch/test
> >>>    JSON_TEST   =3D  $(shell [ -d $(JDIR_TEST) ] &&                   =
    \
> >>>                        find $(JDIR_TEST) -name '*.json')
> >>> @@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
> >>>        $(call rule_mkdir)
> >>>        $(Q)$(call echo-cmd,gen)cp $< $@
> >>>    else
> >>> +# Copy checked-in json for generation.
> >>> +$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> >>> +     $(call rule_mkdir)
> >>> +     $(Q)$(call echo-cmd,gen)cp $< $@
> >>> +
> >>> +GEN_JSON =3D $(patsubst %,$(OUTPUT)%,$(JSON))
> >>> +
> >>>    $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
> >>>        $(call rule_mkdir)
> >>>        $(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && fals=
e)
> >>>
> >>> -$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(MET=
RIC_PY) $(METRIC_TEST_LOG)
> >>> +$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $=
(METRIC_PY) $(METRIC_TEST_LOG)
> >>>        $(call rule_mkdir)
> >>> -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-e=
vents/arch $@
> >>> +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUT=
PUT)pmu-events/arch $@
> >>>
> >>>    $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_P=
MU_EVENTS_C)
> >>>        $(call rule_mkdir)
> >>> @@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
> >>>        $(call rule_mkdir)
> >>>        $(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ =
&& false)
> >>>
> >>> -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(M=
ETRIC_TEST_LOG) \
> >>> +$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY)=
 $(METRIC_TEST_LOG) \
> >>>        $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PM=
U_EVENTS_PYLINT_TEST_LOGS)
> >>>        $(call rule_mkdir)
> >>> -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH)=
 $(JEVENTS_MODEL) pmu-events/arch $@
> >>> +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH)=
 $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
> >>>    endif
> >>>
> >>>    # pmu-events.c file is generated in the OUTPUT directory so it nee=
ds a
> >>
>
