Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEC2F26
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D9A2
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Oct 2023 22:09:05 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57b706f604aso2620038eaf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Oct 2023 22:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696828145; x=1697432945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWDnPnF1OCc5vf9heslFGBMmr8J6rEXocS0apphbrFQ=;
        b=H2Ybp3fNrgPa8NTlMBzK6yWRjEje56sjmOEnWXrHpO2GBECUn0HMCQnUUuw6EIGnpr
         R4NsMWMmxzK3eMYouBQhxogNi3Ki3m7WCNLl0TOeF9FsSsLfMMyrTD8pd35ixgvfDKhO
         7TZ3E00Jyi2nLCsj/5xFWrO0Pz+aFHvl2Y3nTdYdWUQDuo7Aat4zfgHo0Yi5mvTATqlg
         lOlj5afNVYWOgm5WpKDAJAurSX2qpxvGFCzCRDdXk+hDlUJNaBZ0t4jXbafzSahKsGzz
         dGM7MFaY1LfbZAw45yY92KcexQs/fW6NMYsfvu09pnGcDpGnYJ6QQgf+9qiqpG7vVGFQ
         H7cQ==
X-Gm-Message-State: AOJu0Yz4o71fpMAN9ZGyg4o1Ybv5l1PmShfv2MvaDC51jv2z2KgEw3rB
	+2RJklXzQwsWVEyBW0RkN/wSxC39jeynLcTR7oQ=
X-Google-Smtp-Source: AGHT+IEzjZC/ws2OIAwmu2DLXEe8HKR2brU1F/rdIg5O2IWEcz3IYZ24bEr2Qpw6QbB+pXverxjKaOMHT2RdGGzQDQg=
X-Received: by 2002:a05:6358:7e92:b0:142:f97f:7acb with SMTP id
 o18-20020a0563587e9200b00142f97f7acbmr14270778rwn.12.1696828144807; Sun, 08
 Oct 2023 22:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929064909.1152-1-atrajeev@linux.vnet.ibm.com> <DFCC944C-02D9-4BF4-B4CB-358BF1C14A08@linux.vnet.ibm.com>
In-Reply-To: <DFCC944C-02D9-4BF4-B4CB-358BF1C14A08@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 22:08:53 -0700
Message-ID: <CAM9d7cj75AzZ29tzuDbo2=1+s_t_kzQEakoUFs8o9vh9NYqCKA@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf: Add perf binary dependent rule for
 shellcheck log in Makefile.perf
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Sorry for the late reply.

On Thu, Oct 5, 2023 at 8:27=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 29-Sep-2023, at 12:19 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com=
> wrote:
> >
> > Add rule in new Makefile "tests/Makefile.tests" for running
> > shellcheck on shell test scripts. This automates below shellcheck
> > into the build.
> >
> > $ for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do shellchec=
k -S warning $F; done
> >
> > Condition for shellcheck is added in Makefile.perf to avoid build
> > breakage in the absence of shellcheck binary. Update Makefile.perf
> > to contain new rule for "SHELLCHECK_TEST" which is for making
> > shellcheck test as a dependency on perf binary. Added
> > "tests/Makefile.tests" to run shellcheck on shellscripts in
> > tests/shell. The make rule "SHLLCHECK_RUN" ensures that, every
> > time during make, shellcheck will be run only on modified files
> > during subsequent invocations. By this, if any newly added shell
> > scripts or fixes in existing scripts breaks coding/formatting
> > style, it will get captured during the perf build.
> >
> > Example build failure with present scripts in tests/shell:
> >
> > INSTALL libsubcmd_headers
> > INSTALL libperf_headers
> > INSTALL libapi_headers
> > INSTALL libsymbol_headers
> > INSTALL libbpf_headers
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/record_sideband.dep] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/test_arm_coresight.dep] Error 1
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/lock_contention.dep] Error 1
> > make[2]: *** [Makefile.perf:675: SHELLCHECK_TEST] Error 2
> > make[1]: *** [Makefile.perf:238: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> >
> > After this, for testing, changed "tests/shell/record.sh" to
> > break shellcheck format. In the next make run, it is
> > also captured:

Where can I see the actual failure messages?

> >
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/record_sideband.dep] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/record.dep] Error 1
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/test_arm_coresight.dep] Error 1
> > make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Ma=
kefile.tests:17: output/tests/shell/lock_contention.dep] Error 1
> > make[2]: *** [Makefile.perf:675: SHELLCHECK_TEST] Error 2
> > make[1]: *** [Makefile.perf:238: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2

So is this reported at build time before I run the test command?
I'm ok with that but maybe I need to build it even though I know
some test is broken.  Can we have an option to do that like with
`make NO_SHELLCHECK=3D1` ?

> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > ---
> > Changelog:
> > v1 -> v2:
> > Version1 had shellcheck in feature check which is not
> > required since shellcheck is already a binary. Presence
> > of binary can be checked using:
> > $(shell command -v shellcheck)
> > Addressed these changes as suggested by Namhyung in V2
> > Feature test logic is removed in V2. Also added example
> > for build breakage when shellcheck fails in commit message
>
> Hi All,
>
> Looking for feedback on this patch
>
> Thanks
> Athira
> >
> > tools/perf/Makefile.perf        | 14 +++++++++++++-
> > tools/perf/tests/Makefile.tests | 24 ++++++++++++++++++++++++
> > 2 files changed, 37 insertions(+), 1 deletion(-)
> > create mode 100644 tools/perf/tests/Makefile.tests
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 98604e396ac3..56a66ca253ab 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -667,7 +667,18 @@ $(PERF_IN): prepare FORCE
> > $(PMU_EVENTS_IN): FORCE prepare
> > $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3Dpmu-events o=
bj=3Dpmu-events
> >
> > -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
> > +# Runs shellcheck on perf test shell scripts
> > +
> > +SHELLCHECK :=3D $(shell command -v shellcheck)
> > +ifneq ($(SHELLCHECK),)
> > +SHELLCHECK_TEST: FORCE prepare
> > + $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests
> > +else
> > +SHELLCHECK_TEST:
> > + @:
> > +endif
> > +
> > +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) SHELLCHECK_TEST
> > $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
> > $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
> >
> > @@ -1130,6 +1141,7 @@ bpf-skel-clean:
> > $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
> >
> > clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)=
-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-core=
sight-targets-clean
> > + $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
> > $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archiv=
e $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> > $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -dele=
te -o -name '\.*.d' -delete
> > $(Q)$(RM) $(OUTPUT).config-detected
> > diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefil=
e.tests
> > new file mode 100644
> > index 000000000000..8011e99768a3
> > --- /dev/null
> > +++ b/tools/perf/tests/Makefile.tests
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
> > +
> > +PROGS =3D $(subst ./,,$(shell find tests/shell -perm -o=3Dx -type f -n=
ame '*.sh'))
> > +DEPS =3D $(addprefix output/,$(addsuffix .dep,$(basename $(PROGS))))
> > +DIRS =3D $(shell echo $(dir $(DEPS)) | xargs -n1 | sort -u | xargs)
> > +
> > +.PHONY: all
> > +all: SHELLCHECK_RUN
> > + @:
> > +
> > +SHELLCHECK_RUN: $(DEPS) $(DIRS)
> > +
> > +output/%.dep: %.sh | $(DIRS)
> > + $(call rule_mkdir)
> > + $(eval input_file :=3D $(subst output/,./,$(patsubst %.dep, %.sh, $@)=
))
> > + $(Q)$(call frecho-cmd,test)@shellcheck -S warning ${input_file} 1> $@=
.log && ([[ ! -s $@.log ]])

What is the last part?  I guess it checks if shellcheck found no errors.
Can we just check the exit code of the shellcheck?  Is there a case
it didn't work?

Thanks,
Namhyung


> > + $(Q)$(call frecho-cmd,test)@touch $@
> > + $(Q)$(call frecho-cmd,test)@rm -rf $@.log
> > +$(DIRS):
> > + @mkdir -p $@
> > +
> > +clean:
> > + @rm -rf output
> > --
> > 2.31.1
> >
>
