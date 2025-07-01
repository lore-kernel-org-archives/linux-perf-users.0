Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3821FF35
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385280; cv=none; b=Z5Tss8J0MBB8PWWB3Do6jK7qC+Lrz62NtnNRcCOAeZMqIEpvg1rEe/5sshsQNEfuZkpEqh3rb8f8YmgCGbHr+hcAw56JwTij0zzmdk885ELpNdfwUnLCvjftX6ZjMG3aZCyDCUXwDQBo6GyeLSrZWGdbh4FgVFp+11BBvK8PRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385280; c=relaxed/simple;
	bh=pavnK8r4k7ivsAAUfUke1OpxqAoDMSlKzXmkxpUctr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCoocnsJZ5lxmXZySjSdHL1dfw5qSwTPE+PsG43oZaZaIFYqntincVXn012Mxxl2AjVOQwcIQfVvDLH56SvqLv2d6/vbtIESDXr/oYOLt4YJN0mSSzYlgPOgke1op6I6bh3LC4eZ9DcXdHpgrAl4N31Crj5VPV4LLeemQZJc07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIGQ+Ex8; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIGQ+Ex8"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so250895ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751385278; x=1751990078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V93l2e0CU1jpLggkzbTD0Khkkuv7j/sVEwGZBjfSvRE=;
        b=dIGQ+Ex8edP25OaC5bRYVgYqVvalWtLX4B80X4mOu4nRLzgIJZgv3YIdZzI95unLuX
         xjLnQqHl2C8Mf/eajBK5obvurvPfGZqkSAOgt6znk0GXto2N1TXSngcOdyEtSQd2Bfad
         jo09o/Wgo/ZMF/Xq7EORjwI7BDqXomP4+J2yd7+BNWAlCcjNr3fcFp+dwk3ac8lFAmED
         IauVBxFqpF4ZAhLisaiiJQSZPW1W2qnh+7O6fMbeVMyho2Vt8G60prHyaRWsnz3AoGlW
         +sKhSyFikecNVBi7NCEaZw/iH7kG9ujAn9l3Lvl2MPwnvGk4NSK0cyP4iAYm4Ne9NxfX
         f/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385278; x=1751990078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V93l2e0CU1jpLggkzbTD0Khkkuv7j/sVEwGZBjfSvRE=;
        b=Galb+zrK6Z9U0zios59DxFgRY+ZGHrkHa4YL8Cpttuh8qNq9aTDzCb9XAdn+QB6KBa
         dSqhXP/M5wYUE5K4KkLFtK6uMrvMuUF4zI5/JON040Tn/Ou8w2PiMZnzGkloh6kD+djk
         NjmgQdTgqC1LcpRgQuCjIeSIE0CnSXdZXUD0l2YdmZ3EyukVyBN7Kq+N3TuTKKBF7Gq2
         MJzYiZrmU4lRjZ5D2gJEH3inW3Xn3jRCECVhfCBf28UNeCQdViHcX4pB8cjxNnsMShNC
         DF8ciXp9FEbs+U4CI46XAf699iWgdXxLnauNmus1D4U3qP1p99LL/dNTr49Z5jLXLFYM
         Obug==
X-Forwarded-Encrypted: i=1; AJvYcCXBCDCH8zZJTUsiKtMO/2VdUSYjikGhCvlSz1h6MaAY4txtNJ1ctl8MJ6onzdN5X1WOyg+28bX0ebxSkqgfFYIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kB6TA3RxOCxMiLPn4SimwbwmZJmU8IQH3ADXW45bu5ARIuoo
	3gTq+MJPU7c3oMhDDy/tNwEw403kuIy7ld7UhFL5+sZMzPGYYRjO5XqnaDS/ozXfJiBdq2qjT3A
	7XhgbtRaJuKbirrRNjNKY33VpChWdUf/o422rU6RO
X-Gm-Gg: ASbGncvf0atKvwc3DxT+rUGcEAujzg1anRiWljfdPC90z9bQF1xSUCVV0ssK8xYKdPA
	X9xsReWZD47x8GYvkN2BToP9t3blq//DcF2j6hUPQjSlDPTPwMxLRCdWbnRkdXT38N2cAuyTcJf
	6tc/5Mkbw2rgMWbVI1/bw42FKwgMvXidZkHIKAjgpfvmPRcbZAL9HjzV/Q+V4UWA3e4dfflXg=
X-Google-Smtp-Source: AGHT+IG9gb8Y0pABoRd4upZozeVCtTaYVQkj5GtmzpQ//9wN3IqpgtCmBakn3aC/kbt0VA2k3h8nabKeOY5VTjisKQo=
X-Received: by 2002:a05:6e02:3c81:b0:3dd:be3e:7b0 with SMTP id
 e9e14a558f8ab-3e04a04b158mr3147685ab.13.1751385277809; Tue, 01 Jul 2025
 08:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630233246.1063977-1-namhyung@kernel.org> <20250630233246.1063977-2-namhyung@kernel.org>
In-Reply-To: <20250630233246.1063977-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Jul 2025 08:54:25 -0700
X-Gm-Features: Ac12FXyDv9c6unv_Cx9z_56ScA933hQgADqf7j1cwoPj9W302oTQaBmbeHRAyx0
Message-ID: <CAP-5=fVBrysrjdhabfbGO3P6wsQL_mfECzCC_MmJLBMKK8SrOw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf test: Add libsubcmd help tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a set of tests for subcmd routines.  Currently it fails the last one
> since there's a bug.  It'll be fixed by the next commit.
>
>   $ perf test subcmd
>    69: libsubcmd help tests                                            :
>    69.1: Load subcmd names                                             : =
Ok
>    69.2: Uniquify subcmd names                                         : =
Ok
>    69.3: Exclude duplicate subcmd names                                : =
FAILED!
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/subcmd-help.c  | 109 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  4 files changed, 112 insertions(+)
>  create mode 100644 tools/perf/tests/subcmd-help.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2181f5a92148b0b9..13a81154ec1e4cd2 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -69,6 +69,7 @@ perf-test-y +=3D symbols.o
>  perf-test-y +=3D util.o
>  perf-test-y +=3D hwmon_pmu.o
>  perf-test-y +=3D tool_pmu.o
> +perf-test-y +=3D subcmd-help.o
>
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index dfaff4185eb05a1a..2da9b69864da53c2 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -139,6 +139,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__event_groups,
>         &suite__symbols,
>         &suite__util,
> +       &suite__subcmd_help,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-hel=
p.c
> new file mode 100644
> index 0000000000000000..d31259340ae302af
> --- /dev/null
> +++ b/tools/perf/tests/subcmd-help.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "tests.h"
> +#include <stdio.h>
> +#include <subcmd/help.h>
> +#include "debug.h"

nit: I don't think stdio.h and debug.h are used here.

> +
> +static int test__load_cmdnames(struct test_suite *test __maybe_unused,
> +                              int subtest __maybe_unused)
> +{
> +       struct cmdnames cmds =3D {};
> +
> +       add_cmdname(&cmds, "aaa", 3);
> +       add_cmdname(&cmds, "foo", 3);
> +       add_cmdname(&cmds, "xyz", 3);
> +
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "aaa") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds, "bar") =3D=3D 0=
);
> +       TEST_ASSERT_VAL("case sensitive", is_in_cmdlist(&cmds, "XYZ") =3D=
=3D 0);
> +
> +       clean_cmdnames(&cmds);
> +       return TEST_OK;
> +}
> +
> +static int test__uniq_cmdnames(struct test_suite *test __maybe_unused,
> +                              int subtest __maybe_unused)
> +{
> +       struct cmdnames cmds =3D {};
> +
> +       /* uniq() assumes it's sorted */
> +       add_cmdname(&cmds, "aaa", 3);
> +       add_cmdname(&cmds, "aaa", 3);
> +       add_cmdname(&cmds, "bbb", 3);
> +
> +       TEST_ASSERT_VAL("invalid original size", cmds.cnt =3D=3D 3);
> +       /* uniquify command names (to remove second 'aaa') */
> +       uniq(&cmds);
> +       TEST_ASSERT_VAL("invalid final size", cmds.cnt =3D=3D 2);
> +
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "aaa") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "bbb") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds, "ccc") =3D=3D 0=
);
> +
> +       clean_cmdnames(&cmds);
> +       return TEST_OK;
> +}
> +
> +static int test__exclude_cmdnames(struct test_suite *test __maybe_unused=
,
> +                                 int subtest __maybe_unused)
> +{
> +       struct cmdnames cmds1 =3D {};
> +       struct cmdnames cmds2 =3D {};
> +
> +       add_cmdname(&cmds1, "aaa", 3);
> +       add_cmdname(&cmds1, "bbb", 3);
> +       add_cmdname(&cmds1, "ccc", 3);
> +       add_cmdname(&cmds1, "ddd", 3);
> +       add_cmdname(&cmds1, "eee", 3);
> +       add_cmdname(&cmds1, "fff", 3);
> +       add_cmdname(&cmds1, "ggg", 3);
> +       add_cmdname(&cmds1, "hhh", 3);
> +       add_cmdname(&cmds1, "iii", 3);
> +       add_cmdname(&cmds1, "jjj", 3);
> +
> +       add_cmdname(&cmds2, "bbb", 3);
> +       add_cmdname(&cmds2, "eee", 3);
> +       add_cmdname(&cmds2, "jjj", 3);
> +
> +       TEST_ASSERT_VAL("invalid original size", cmds1.cnt =3D=3D 10);
> +       TEST_ASSERT_VAL("invalid original size", cmds2.cnt =3D=3D 3);
> +
> +       /* remove duplicate command names in cmds1 */
> +       exclude_cmds(&cmds1, &cmds2);
> +
> +       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt =3D=3D 7);
> +       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt =3D=3D 3);
> +
> +       /* excluded commands should not belong to cmds1 */
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "aaa") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "bbb") =3D=3D =
0);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ccc") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ddd") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "eee") =3D=3D =
0);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "fff") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ggg") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "hhh") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "iii") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "jjj") =3D=3D =
0);
> +
> +       /* they should be only in cmds2 */
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "bbb") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "eee") =
=3D=3D 1);
> +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "jjj") =
=3D=3D 1);
> +
> +       clean_cmdnames(&cmds1);
> +       clean_cmdnames(&cmds2);
> +       return TEST_OK;
> +}
> +
> +static struct test_case tests__subcmd_help[] =3D {
> +       TEST_CASE("Load subcmd names", load_cmdnames),
> +       TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
> +       TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
> +       {       .name =3D NULL, }
> +};
> +
> +struct test_suite suite__subcmd_help =3D {
> +       .desc =3D "libsubcmd help tests",
> +       .test_cases =3D tests__subcmd_help,
> +};
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 4c128a9594413b32..13cabf85185ed2d3 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -177,6 +177,7 @@ DECLARE_SUITE(sigtrap);
>  DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
>  DECLARE_SUITE(util);
> +DECLARE_SUITE(subcmd_help);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints u=
sing the
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
