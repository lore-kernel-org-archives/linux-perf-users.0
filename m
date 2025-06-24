Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5B4C74
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750742528; cv=none; b=JthdUOppcaHf/epKKdlBcnce6Ab9h8e4TF3qz7EcRBYfQdYd9rgCHBspIlrx/1F+i5JJnwbGicH/nxmT+PyJSq6F9eZm1Nq4Z8HXnyq553I55Lkcl3DprRP0Kde6QajNNeOdOhPFjMM/x80AzeVH763BwcDdfWDuMiGmX2+gHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750742528; c=relaxed/simple;
	bh=KtEsaRn2ETJkbhbCSbWLAa5+wM11aEHcRIUaqZZDS2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQOzDmtOBaNERS7CniT3EvJgVftzjzeWwbgf1q9ZrlofUuZUOyDsObCyopfLyFru3vyOA+kGA66uoHB9nW+9Nhj3b/f3Ojqx/nvZIaMW+uZe7MAUurOVgpPqKebNlKC4JUAuwI7/AVZL9dLAWOKTCbVILvvEUtqGVamrvKzuZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4efpwxoB; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4efpwxoB"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo94245ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 22:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750742526; x=1751347326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hOJz+vcYO1Ne6k1cj2BIklVK/EVgqHSD2CylG69hPc=;
        b=4efpwxoBV5ccqzyp97UEer8P3rmvOECMxQOueJ/oxGdbdD+JIopzVAy7sbSjMcQauC
         HemGvB+wUw1o9Bxt20AdTFjrqK+YcGYng0TvHLyYUjxbKzftQAbC5KkBrJ6B7T0sIV7R
         jwGvY4jXq7BsKDJmT1+4P4Qe1mdN0oc4+LP+aU/g5qe2C3X6WArcYO85hCfaF7aJmXMf
         IjdMZTfXqctyyjhumBtUMVq250EPGL5u/QhibbhQ6Eo+v2NMpEZx+MlRG7Fni7Ph/n3C
         w3JLBFYCISfbPmBm5lhA7O1nmuX8iozFclImQlRUSA1EXPNJpg3cBFJuFQU5zJlw9wMA
         d+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750742526; x=1751347326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hOJz+vcYO1Ne6k1cj2BIklVK/EVgqHSD2CylG69hPc=;
        b=Lut0AE/QG8CJTUcNgrFG934Ro5ysGlKyH/ar31tTt1B6KU4TPvyk8N/WY3IftPyZWq
         EkieqSOEEoa5G7qcaALTMvntYc0Vi8h4Zy4VW+4tDNAmHbKJ6Rb1q/++dq/E11+sWoL/
         wAMquXXgTAidQT053EC7eLBnHKZ19sZmcOv9j+/nIty49QhiC+QixmhcODbwRuynh1yH
         /nDnab0uc2+vqo9Bds7EnA11pKjI9S8dr4Ks+XZPWZkkloYfuR0HcDlpMJ1EGFwoVXi/
         GLbjQW81ldhq4Ym9yiru4QSP61vUbJjGquba7KPBddd8xiHN16OBY035/Kc3u055ERka
         YCDw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LPmAXbrgtUUw+wd/CuabUSSFakpY4DxkQ5b1KIBCChXlRPpP/Br2ZF35H+MGAA+aMRX+pRvhK2gkQYDABSfR@vger.kernel.org
X-Gm-Message-State: AOJu0YwncaoITjD6DesdTsjV79KAKC9MiWzUbJubiq4xOPEn0OM1exex
	IY8PeGgGURNV69vPeot/NAwWhH1zBHLYQVg7crzlXiFy9bpg10WarKoU+D87xSoDO/26TIz25Bd
	YbAYguFAl5Cw4J2z4ckibqUQUo+xoO6vDhNp6+sF0
X-Gm-Gg: ASbGncv9d8nU0Mb/LAQVdfYXtXBAaorJX8T/8hZ+VzNbg6SKKH2DrEoxmyXrSQwvrEU
	pD9VeBlKPGX0cmberA6VaW14soUx0vExPyTB3fgzmN2+MMy6Tx70Ce8D+ksF1AM83/c20xDChTs
	dyod+YSLB9R4FUVkNmDSISc1So/sMWbYC+zahavOv1yoDH
X-Google-Smtp-Source: AGHT+IFVqH7OvylcO+Y1qV4xlPImLec6uOKV0F01y1TW8TSTcJ3ASrVe91IKe2Xd1R9DM6S+4E80byID6TwQBCtI4/4=
X-Received: by 2002:a05:6e02:3809:b0:3db:854b:9f52 with SMTP id
 e9e14a558f8ab-3df2a55432dmr1280505ab.7.1750742525777; Mon, 23 Jun 2025
 22:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <f7ea3a430dc2bd77656c50f93283547d1245e2fe.1750730589.git.collin.funk1@gmail.com>
In-Reply-To: <f7ea3a430dc2bd77656c50f93283547d1245e2fe.1750730589.git.collin.funk1@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 22:21:53 -0700
X-Gm-Features: AX0GCFveVTpPnPVsvCk22_5Lnue0d5YCoQm35akDg8ARSVTlDG7uuJgVAjr95I0
Message-ID: <CAP-5=fW6oMGcGcBgxVWOrkxcPRo1EDVAHe4m0F-ratRkpKjL0w@mail.gmail.com>
Subject: Re: [PATCH v2] [PATCH] perf build: Specify that shellcheck should use
 the bash dialect.
To: Collin Funk <collin.funk1@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 7:06=E2=80=AFPM Collin Funk <collin.funk1@gmail.com=
> wrote:
>
> When someone has a global shellcheckrc file, for example at
> ~/.config/shellcheckrc, with the directive 'shell=3Dsh', building perf
> will fail with many shellcheck errors like:
>
>     In tests/shell/base_probe/test_adding_kernel.sh line 294:
>     (( TEST_RESULT +=3D $? ))
>     ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((.=
.)) is undefined.
>
>     For more information:
>       https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone (=
(..)) is...
>     make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kern=
el.sh.shellcheck_log] Error 1
>
> Passing the '-s bash' option ensures that it runs correctly regardless
> of a developers global configuration.
>
> This patch adds '-s bash' to the SHELLCHECK variable in Makefile.perf
> and makes use of the variable consistently.
>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  tools/perf/Build                | 2 +-
>  tools/perf/Makefile.perf        | 2 +-
>  tools/perf/arch/x86/Build       | 2 +-
>  tools/perf/arch/x86/tests/Build | 2 +-
>  tools/perf/tests/Build          | 2 +-
>  tools/perf/trace/beauty/Build   | 2 +-
>  tools/perf/util/Build           | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 06107f1e1d42..e69665bf9dce 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -73,7 +73,7 @@ endif
>
>  $(OUTPUT)%.shellcheck_log: %
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > =
$@ || (cat $@ && rm $@ && false)
> +       $(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ ||=
 (cat $@ && rm $@ && false)
>
>  perf-y +=3D $(SHELL_TEST_LOGS)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d4c7031b01a7..6810d321ff73 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -252,7 +252,7 @@ endif
>  ifeq ($(NO_SHELLCHECK),1)
>    SHELLCHECK :=3D
>  else
> -  SHELLCHECK :=3D $(shell which shellcheck 2> /dev/null)
> +  SHELLCHECK :=3D $(shell which shellcheck 2> /dev/null) -s bash

Could we also place the "-a -S warning" warning here too?

Thanks,
Ian

>  endif
>
>  # shellcheck is using in tools/perf/tests/Build with option -a/--check-s=
ourced (
> diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
> index afae7b8f6bd6..71e2553e5af1 100644
> --- a/tools/perf/arch/x86/Build
> +++ b/tools/perf/arch/x86/Build
> @@ -10,6 +10,6 @@ endif
>
>  $(OUTPUT)%.shellcheck_log: %
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (c=
at $@ && rm $@ && false)
> +       $(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ ||=
 (cat $@ && rm $@ && false)
>
>  perf-test-y +=3D $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/=
Build
> index 5e00cbfd2d56..fd3af16f63bb 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -22,6 +22,6 @@ endif
>
>  $(OUTPUT)%.shellcheck_log: %
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (c=
at $@ && rm $@ && false)
> +       $(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ ||=
 (cat $@ && rm $@ && false)
>
>  perf-test-y +=3D $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2181f5a92148..4a27fde30eb6 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -89,7 +89,7 @@ endif
>
>  $(OUTPUT)%.shellcheck_log: %
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (c=
at $@ && rm $@ && false)
> +       $(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ ||=
 (cat $@ && rm $@ && false)
>
>  perf-test-y +=3D $(SHELL_TEST_LOGS)
>
> diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Buil=
d
> index f50ebdc445b8..727ce0a5c30a 100644
> --- a/tools/perf/trace/beauty/Build
> +++ b/tools/perf/trace/beauty/Build
> @@ -31,6 +31,6 @@ endif
>
>  $(OUTPUT)%.shellcheck_log: %
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > =
$@ || (cat $@ && rm $@ && false)
> +       $(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ ||=
 (cat $@ && rm $@ && false)
>
>  perf-y +=3D $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 7910d908c814..626a359fee1e 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -421,7 +421,7 @@ endif
>
>  $(OUTPUT)%.shellcheck_log: %
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (c=
at $@ && rm $@ && false)
> +       $(Q)$(call echo-cmd,test)$(SHELLCHECK) -a -S warning "$<" > $@ ||=
 (cat $@ && rm $@ && false)
>
>  perf-util-y +=3D $(SHELL_TEST_LOGS)
>
> --
> 2.49.0
>
