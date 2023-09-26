Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DF11731
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 23:55:17 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467861A1
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 16:55:16 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-79fe8986355so46664139f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 16:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695772515; x=1696377315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9fuw7vlBW33aEkoq31xbJWBTUGJNFSeBY2qgqsAAOM=;
        b=WGBMPTteaUDFa8TyrO8Rsao76CtuGaKcbzoocDU+xiMiqyPzDtBZ1a5qsiK/ryechF
         u5JCL+sozxiIpNRe4q7IOLuSiF/40PJOMXJaagJ5hQLDljIIDiqD+Fh/z5LiFZ8vYU00
         wxHFjPvUx8wkhwuyCE/0T+lQcdDt36LPtbPsZ0w7phXmrIDp9ajJKGAMRLaFcaEMTJXF
         pThkcfAJEKXu3GGDZA3DeAGXplpWfrPtLe4V6wAgLit2+mQn3wx/ofHi7Hlkov3wzV0I
         4xwUxmulurOL5ZnP5I2Xqji3OeCJ9byU31OzFCzyz26sXGqBJOGDUNZLxm2yORBV2fXf
         /4yA==
X-Gm-Message-State: AOJu0YwDtdmfWq25uHbFsF0061zLBwEEtiIj/O1d2Gkgwd52j0s2BDVJ
	x7wXxNcFcrIvsFpWBboNk1Va7d/aaTJh755i8rI=
X-Google-Smtp-Source: AGHT+IF9iPwgGfSkymfXxlcH6A295migBELQK8vAzkdBIsbJ4h9w+6ovIhi4e+fgg6HSMT1LeiIJllBn8i3zehO7xfA=
X-Received: by 2002:a5e:8306:0:b0:783:63d6:4c5 with SMTP id
 x6-20020a5e8306000000b0078363d604c5mr328990iom.12.1695772515257; Tue, 26 Sep
 2023 16:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914171827.98507-1-atrajeev@linux.vnet.ibm.com> <20230914171827.98507-2-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230914171827.98507-2-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 16:55:04 -0700
Message-ID: <CAM9d7ciBmHrjB98E6SoVrcULgeviYa=K8ONk1KAP3T5nqnYU4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/perf: Add perf binary dependent rule for
 shellcheck log in Makefile.perf
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 10:18=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Add rule in new Makefile "tests/Makefile.tests" for running
> shellcheck on shell test scripts. This automates below shellcheck
> into the build.
>
>         $ for F in $(find tests/shell/ -perm -o=3Dx -name '*.sh'); do she=
llcheck -S warning $F; done

I think you can do it if $(shell command -v shellcheck) returns
non-empty string (the path to the shellcheck).  Then the feature
test logic can be gone.

>
> CONFIG_SHELLCHECK check is added to avoid build breakage in
> the absence of shellcheck binary. Update Makefile.perf to contain
> new rule for "SHELLCHECK_TEST" which is for making shellcheck
> test as a dependency on perf binary. Added "tests/Makefile.tests"
> to run shellcheck on shellscripts in tests/shell. The make rule
> "SHLLCHECK_RUN" ensures that, every time during make, shellcheck
> will be run only on modified files during subsequent invocations.
> By this, if any newly added shell scripts or fixes in existing
> scripts breaks coding/formatting style, it will get captured
> during the perf build.

Can you show me the example output?

>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/Makefile.perf        | 12 +++++++++++-
>  tools/perf/tests/Makefile.tests | 24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/Makefile.tests
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f6fdc2d5a92f..c27f54771e90 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -667,7 +667,16 @@ $(PERF_IN): prepare FORCE
>  $(PMU_EVENTS_IN): FORCE prepare
>         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3Dpmu-ev=
ents obj=3Dpmu-events
>
> -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
> +# Runs shellcheck on perf test shell scripts
> +ifeq ($(CONFIG_SHELLCHECK),y)
> +SHELLCHECK_TEST: FORCE prepare
> +       $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests
> +else
> +SHELLCHECK_TEST:
> +       @:
> +endif
> +
> +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) SHELLCHECK_TEST
>         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
>                 $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
>
> @@ -1129,6 +1138,7 @@ bpf-skel-clean:
>         $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETON=
S)
>
>  clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-=
clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-cores=
ight-targets-clean
> +       $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
>         $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-=
archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>         $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd'=
 -delete -o -name '\.*.d' -delete
>         $(Q)$(RM) $(OUTPUT).config-detected
> diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefile.=
tests
> new file mode 100644
> index 000000000000..e74575559e83
> --- /dev/null
> +++ b/tools/perf/tests/Makefile.tests
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
> +-include $(OUTPUT).config-detected
> +
> +log_file =3D $(OUTPUT)shellcheck_test.log
> +PROGS =3D $(subst ./,,$(shell find tests/shell -perm -o=3Dx -type f -nam=
e '*.sh'))
> +DEPS =3D $(addprefix output/,$(addsuffix .dep,$(basename $(PROGS))))
> +DIRS =3D $(shell echo $(dir $(DEPS)) | xargs -n1 | sort -u | xargs)
> +
> +.PHONY: all
> +all: SHELLCHECK_RUN
> +       @:
> +
> +SHELLCHECK_RUN: $(DEPS) $(DIRS)
> +
> +output/%.dep: %.sh | $(DIRS)
> +       $(call rule_mkdir)
> +       $(Q)$(call frecho-cmd,test)@touch $@
> +       $(Q)$(call frecho-cmd,test)@shellcheck -S warning $(subst output/=
,./,$(patsubst %.dep, %.sh, $@)) 1> ${log_file} && ([[ ! -s ${log_file} ]])

This line is too long, please wrap it with some backslashes.

Thanks,
Namhyung


> +$(DIRS):
> +       @mkdir -p $@
> +
> +clean:
> +       @rm -rf $(log_file) output
> --
> 2.31.1
>
