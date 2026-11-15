Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779100;
	b=Ps1T2KuulC4jtnyJygL6nQSugHNifmw4X7S8X9hymmWLUJfyOpZUYsG1WsPnpfdOQJ4H
	 bqMpS+rGc7l/aAUGrCYUEA84egw+falTdX98xmY410R4AvKTnt8Dyp2Jdm7PQoLiot/Yq
	 4oktvOCzy8ghtJ0zz0CBsalJPz817+UOb3jDxmVWQRfor8QKQSW/80vdT4P5E0sZwb+2f
	 WTKbF/6DoNjppDBBfIkxr0BwkCT4aRoKuIIqyci4sJiNk2197+4oB9IT2b8pwxx/twjfq
	 j1TWDyOYP2/pNbOsy2qcNlpIRbXS4Vq4DXQfrC07VBrwDNHkPfJkajb7o1ONgl3wU3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=be7RYON33IZYwY05Ih0DYtMbkJURt0+kxYVAtPk1w1E=;
	b=KgxlEwplcNblJmOwRpz8ujY7i+kWL9gbY6oUTzjHkV4U5GELeRhsvBdc8xQomwplHvpr
	 yLnqSfyrU95o6sIFNLXLCQl0NsdMmgOZWVOqUp14lvH6WmWTnoYieSUwgwRVuHkcUQd2Y
	 irFeKdv0gjCdhsh9KlqE2xEgPu3vHCq9d9fiD/0elBuEP4dsL9tjI7T1j3i6O/O+T5jQm
	 KPpy3haaG0iTvu17g/SpJCf1cJ6rksH0ffjPlbDcVh79UtkP2vVxF0FIewP3LH93Rt53p
	 v94xi6mhieRoNP3BU0E6rOInIGw4Hwgr2AIQfuWszv+eGeKUun2OgbEsUW7d6QVjC4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aobyeNiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCD606A31F
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DCD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aobyeNiu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55c7445cf85so207931cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779099; cv=none;
        d=google.com; s=arc-20260327;
        b=judqkWTN0kY++N3MAcs9gt/bDfrx4G6VLnBOwE6hNmKsEzf859dV5/NSutc8SFCMk6
         vZZot993eG4dOpEsdIil4GO/ntXSCXTwopCdFILvCcrvSJxXc3fp7ZUwkdWLAxpY+Faq
         9NaQQgRnXB80PyHg9n7VTTpspmSSFZIvrpEVBlJyI2PzZ5wzVCNZWvsC0R25Dglno3s8
         BNs+Tg57ToSMR5TAkLpoyolPdtOAUEm56959alSEAzWemR2NI3dq8KnW98+oCOZPV+Pr
         XQ/l5UVf70DvMiaCzGE6Gavdgljr7ygzeKAIwnOuWLJtD6hYRFUKFwGeHDmkOAFqEdBL
         es0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=be7RYON33IZYwY05Ih0DYtMbkJURt0+kxYVAtPk1w1E=;
        fh=7sBoIEfYvD7Ht4DED7qh5pQZQwJhsDh1pH/VHp3X7CE=;
        b=AYa9CrOiUapQqIOlrOiYES/yyR7aXMbfrMQFoKEBLQFeeyMADOIzuuquoE7nHJTeqA
         E7i1WiQQ4os5QkTOlFu2Wd1kbVBMWvn5D2Re99y/oU2MvOVJ1zsI+H/JSBVtDYYDZFPI
         QWVwkTf0PfoZgzz6GAShDrv5dmvN/Ei0AYHfmPj+rOy9k/aIf9hkQRsR8bg9B8hop7ei
         cugY+pPfJmMFw6EejEn2tkmwdYcmhd+6GdhY9uQyQ0F9PGPSEZm+K0xYuf2oDCX3v/L+
         j5gHZ2WOK4vVDVWgBEGKbvLUXruiS4I497wHetKAjhpk15DTbfOf65HnWBtAg6WSDbMO
         NVTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779099; x=1795383899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=be7RYON33IZYwY05Ih0DYtMbkJURt0+kxYVAtPk1w1E=;
        b=aobyeNiuFxZ0QpZ5sABollx3XfzOUTfd6DznyhHb3X07g9Rt1qqMFFW/HlQKo8nTZV
         SDm0mBKLcsOhzX4in3ai4akwfnqVBfY99apYZ7qhNvNNtnnQoc8UMBLeiEh+1yNr4aal
         snr4kCizgzgFa3RxvzaV9vEPF8Ez8zit67X0qiSG51RW+dzfhp+Jc80+0HK5Fh9muowY
         fXzUKY/x8zLbhqMFw5l9172r4pUjAEe1jWhS8yBzi4qshYlZFFilKXFdkj5rQZadDSgX
         k7gqNi3/AlnWh7Z4E+yPzp4lab1hcj7baEF92igOWy0HipoSeHwP2F3yUDx553/NBM/w
         o0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779099; x=1795383899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be7RYON33IZYwY05Ih0DYtMbkJURt0+kxYVAtPk1w1E=;
        b=TlHwCpgf0TZFK4klvm6rZCfiTGfUyU5csBtbMXKTyGGbYw1Sjp6NY/mUZ7JAGOnrur
         MO31G9ZFzBs0PRWMFq2mMIcB7a5n9X0H6w6oX29oyQT9dE8Vvnkn3OQ3UscW+etORcS9
         Mrq5Xv6HPJdJ14gjQBDiU6XDUxBJiK3dBmBKhLu8O8QbB2XRmx4Xz4GFTRfNYCVzs6J1
         le2u7bxpK4Z4PwTUk7+wENjDCfiQ6hvpg2+Ou95Rg/udGeOsQQK+Z+yb2Gucyuwl2ijn
         NpMzYB+lOZOfyKjtkNh8+42isndis/8W69EOHps8NgtB5EOwYNklGsa5AiEjXglHTTXK
         MIdQ==
X-Forwarded-Encrypted: i=1; AL+hErGwvAQw1Saz9xbX+HnIUlqWLI+aB8ekfU5S63VoyYki6YtfDg7hN0Za15rk4BFQEZg3vWA/7lxfp/Hu6iplHM7k@vger.kernel.org
X-Gm-Message-State: APuU4Z/yx9NzlsN1OEyVLkYONRwF80RvJjNRpYp3pYQ3BVQwg8P/+pv8
	n/uXS6GIgH6FyhzOETEtPm9xoz8xptWn1EMZeaVAkdspTvgbGw2AbVw+D4uVhVyqibDPft/bfNn
	WWHOxGO/4kMMHNGwAYEhDL59qL3E+cbpSI/P46MPL
X-Gm-Gg: AYBFou22ntjyj7rwkpXk2taYUmSZgP0hNvvo9lGz1Swy1Be5t8xOdgQY1zwZqBBEp4g
	8pAbm4SRibBw33n4DwJkRz9yDyRoUA/CcqSSQQtMhWXUdj8PnPWhNG55emxELLBdG3wL+MM9oy/
	2LgTjH+5DXyE+spIc01T6ZwxtL08ibylb5JrE6JYzRc8VNkKO6UTFiBkK5jB0ydLBr9WSJqu/JM
	ix4Rea0ZyPMWNDUOHs0zpnX+4KYioZabN5brUVsLKfIXkcRE8ZoTSdvZFFXl/cwBXxX9+ryDC5t
	E3CFstoEtbuM0OFBBnn+FLKbxZf8FlyC26wtfNrksGYnqb6z9a+r6w+L76mjeBYtGv7c4IlXKK9
	+/Hxe2waw2cibyIPUpj5c4gFWlzhy9qy3wxz9
X-Received: by 2002:a05:622a:5c16:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-55c45b33181mr25356941cf.4.1794779097967; Sun, 15 Nov 2026
 13:44:57 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-2-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:44:46 -0800
X-Gm-Features: AclHuK-0mXPWqU_0pb3rSqKkwXlzYInIwSXAtyBChBeSz_b32j07FBSHXTfzdBw
Message-ID: <CAP-5=fW0OQqtazaM8xn8m3ZEqbp1XF+RKjuOSvxa_QFy3FEsrA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] perf scripts: Add a coverage harness for perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Build perf with clang source based coverage, run the complete perf test
> suite, merge the raw profiles and report line and function coverage for
> perf, optionally against a baseline.  This is pahole's
> coverage/coverage.sh + coverage-diff.sh merged into one script, wired as
> 'make -C tools/perf coverage' and listed in 'make help'.
>
> Without -f the report lists the files with the most uncovered lines,
> which is where new tests should try to get more coverage; -t narrows
> the tests, -f focuses on specific files, --html writes a browsable
> report and --table/-T, also available as 'make -C tools/perf
> coverage-table', prints the last run as an ASCII table with the
> per-file line and function coverage, like pahole's coverage_table.py.
>
> The build can be split from the test run: 'make -C tools/perf
> coverage-prep' builds the instrumented perf and records the build
> directory, and a later run as root, which needs no make, checks that
> build, runs the tests and renders the report, or prints the table with
> --table.  This is for running the tests that need root on the bare
> metal host while the instrumented perf is built in the development
> container.
>
> It is a maintainer tool and it already paid for itself: the first run
> found the clang DWARF 5 data type test failing (the DW_OP_addrx gap,
> fixed in patch 3; the default build is DWARF 4, --dwarf-version 5 hits
> it), and the uncovered line list is what drove the
> tests in the rest of the series.
>
>   $ scripts/coverage.sh
>   ...
>   Total: 67436 of 201128 lines covered (33.53%)
>
>     largest uncovered files (>=3D 100 lines)
>     file                                            lines     cover    mi=
ssed  fn-cover
>     builtin-trace.c                                  3657     4.24%      =
3502     0.51%
>     util/intel-pt.c                                  3237     0.00%      =
3237     0.00%
>     util/intel-pt-decoder/intel-pt-decoder.c         3208     0.00%      =
3208     0.00%
>     builtin-sched.c                                  3737    19.72%      =
3000    11.35%
>     ui/browsers/hists.c                              2730     0.00%      =
2730     0.00%
>     util/probe-event.c                               2765     5.39%      =
2616    10.68%
>     builtin-script.c                                 3212    29.98%      =
2249    33.06%
>     ...
>   Report:  /tmp/build/perf-coverage/cov/report.txt
>
> The run above was unprivileged, so tests that need root are skipped or
> fail; the report still points at the gaps.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/.gitignore          |   1 +
>  tools/perf/Makefile            |  11 +-
>  tools/perf/Makefile.perf       |   4 +
>  tools/perf/scripts/coverage.sh | 722 +++++++++++++++++++++++++++++++++
>  4 files changed, 737 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/scripts/coverage.sh
>
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index 3b968c5158b822ce..9052f25597ac9489 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -27,6 +27,7 @@ stats-*.csv
>  cscope*
>  config.mak
>  config.mak.autogen
> +.coverage-build-dir
>  *-bison.*
>  *-flex.*
>  *.pyc
> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index 00baf90e5bda7123..8df8e9ed37f0a8f5 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -140,6 +140,15 @@ check-headers:
>  sync-headers:
>         @./scripts/sync-headers.sh $(SYNC_HEADERS_ARGS)
>
> +coverage-prep:
> +       @./scripts/coverage.sh --prep $(if $(FULL_O),--build-dir=3D$(FULL=
_O)) $(COVERAGE_ARGS)
> +
> +coverage:
> +       @./scripts/coverage.sh $(if $(FULL_O),--build-dir=3D$(FULL_O)) $(=
COVERAGE_ARGS)
> +
> +coverage-table:
> +       @./scripts/coverage.sh --table $(if $(FULL_O),--build-dir=3D$(FUL=
L_O)) $(COVERAGE_ARGS)
> +
>  #
>  # All other targets get passed through:
>  #
> @@ -147,4 +156,4 @@ sync-headers:
>         $(print_msg)
>         $(make)
>
> -.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball=
 check-headers sync-headers
> +.PHONY: all clean tags TAGS FORCE Makefile build-test build-test-tarball=
 check-headers sync-headers coverage coverage-prep coverage-table
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b74b534e1153ffcb..782929b0ba10d8f3 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -873,6 +873,10 @@ help:
>         @echo '  check-headers          - check which header copies are o=
ut of sync with the kernel'
>         @echo '  sync-headers           - sync those header copies with t=
he kernel, creating commits'
>         @echo '                   (SYNC_HEADERS_ARGS=3D"..." passes optio=
ns to the script)'
> +       @echo '  coverage-prep          - build perf with clang coverage,=
 ready for a root test run'
> +       @echo '  coverage               - build perf with clang coverage,=
 run the tests and report'
> +       @echo '  coverage-table - print an ASCII table of the last covera=
ge run'
> +       @echo '                   (COVERAGE_ARGS=3D"..." passes options t=
o the script)'
>
>
>  DOC_TARGETS :=3D doc man html info pdf
> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000000..2f248d61a733938a
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh
> @@ -0,0 +1,722 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2026, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat=
.com>
> +#
> +# LLVM source-based coverage for perf: build with clang instrumentation,
> +# run the complete perf test suite and report line/function coverage for
> +# perf, optionally comparing it against a previously saved report.  -t
> +# narrows the tests and -f adds files to the per-file table; without -f
> +# the report lists the files with the most uncovered lines, which is
> +# where new tests are needed.  --table prints the last run as an ASCII
> +# coverage table, like pahole's coverage_table.py.  The build can be
> +# split from the test run: --prep builds the instrumented perf and
> +# records the build directory, and a later run as root uses that build,
> +# skips the build and goes straight to the tests.  The sampling based
> +# tests move the percentages by a percent or two between identical runs.
> +
> +set -euo pipefail
> +
> +# awk prints dots and printf/sort parse them: keep the numeric locale fi=
xed
> +# so --table doesn't abort where the decimal separator is a comma.
> +export LC_ALL=3DC
> +
> +PERF_DIR=3D$(cd "$(dirname "$0")/.." && pwd)
> +
> +DEFAULT_BUILD_DIR=3D/tmp/build/perf-coverage
> +BUILD_DIR=3D${BUILD_DIR:-}
> +COV_DIR=3D${COV_DIR:-}
> +BUILD_DIR_SET=3D0
> +COV_DIR_SET=3D0
> +[ -n "$BUILD_DIR" ] && BUILD_DIR_SET=3D1
> +[ -n "$COV_DIR" ] && COV_DIR_SET=3D1
> +JOBS=3D${JOBS:-$(nproc 2>/dev/null || echo 1)}
> +LLVM_PROFDATA=3D${LLVM_PROFDATA:-llvm-profdata}
> +LLVM_COV=3D${LLVM_COV:-llvm-cov}
> +
> +DEBUG_BUILD=3D1
> +SKIP_BUILD=3D0
> +REPORT_ONLY=3D0
> +PREP=3D0
> +TABLE=3D0
> +HTML=3D0
> +USE_BASELINE=3D1
> +BASELINE=3D
> +UNCOVERED=3D${UNCOVERED:-20}
> +TOP=3D${TOP:-20}
> +MIN_LINES=3D${MIN_LINES:-100}
> +DWARF_VERSION=3D${DWARF_VERSION:-4}
> +TESTS=3D()
> +
> +FOCUS=3D()
> +
> +ROOT=3D0
> +[ "$(id -u)" =3D 0 ] && ROOT=3D1
> +
> +say()  { printf '\033[1;34m=3D=3D>\033[0m %s\n' "$*"; }
> +warn() { printf '\033[0;33mwarning:\033[0m %s\n' "$*" >&2; }
> +die()  { printf '\033[0;31merror:\033[0m %s\n' "$*" >&2; exit 1; }
> +
> +usage()
> +{
> +       cat <<EOF
> +Usage: scripts/coverage.sh [options] [test name fragment...]
> +
> +Builds perf with clang source-based coverage, runs the complete perf
> +test suite and reports coverage for perf.  Use -t to run a subset and
> +-f to focus the per-file table.
> +
> +Options:
> +  -b, --build-dir DIR    perf build directory (default: $DEFAULT_BUILD_D=
IR)
> +  -c, --cov-dir DIR      profiles and reports (default: BUILD_DIR/cov)
> +  -j, --jobs N           parallel build jobs (default: $JOBS)
> +  -t, --tests "A;B"      test name fragments, ';' separated (default: al=
l)
> +  -f, --focus FILE       add a file to the per-file table (repeatable)
> +      --top N            when no -f is given, show the N files with the
> +                         most uncovered lines (default: $TOP, 0 to disab=
le)
> +      --baseline FILE    baseline report (default: COV_DIR/baseline.txt)
> +      --no-baseline      do not compare against or update a baseline
> +      --uncovered N      uncovered line numbers per focus file (default:=
 $UNCOVERED)
> +      --skip-build       reuse the existing build, just run the tests
> +      --report-only      reuse build and profiles, just render the repor=
t
> +      --prep             build the instrumented perf and stop; run the
> +                         tests later as root with this script
> +  -T, --table            print an ASCII table of the last run and exit,
> +                         like pahole's coverage_table.py
> +      --optimized        build with perf's default -O3 instead of -O0 -g
> +      --dwarf-version N  DWARF version for the instrumented build (defau=
lt: $DWARF_VERSION)
> +      --html             also write an HTML report
> +  -h, --help             show this help
> +
> +Environment:
> +  BUILD_DIR, COV_DIR, JOBS, LLVM_COV, LLVM_PROFDATA, UNCOVERED, TOP,
> +  MIN_LINES, DWARF_VERSION
> +
> +As root, without --prep, the script skips the build, checks the perf
> +prepared by 'make coverage-prep', runs the tests and renders the
> +report.  The prepared build is recorded in tools/perf/.coverage-build-di=
r.
> +
> +Through make:
> +  make -C tools/perf coverage COVERAGE_ARGS=3D"-t 'perf annotate'"
> +  make -C tools/perf coverage-prep O=3D/tmp/build/perf-tools-next
> +  make -C tools/perf coverage-table
> +
> +Examples:
> +  scripts/coverage.sh                       # full suite, fresh build
> +  scripts/coverage.sh --prep                # build only, test later as =
root
> +  scripts/coverage.sh --report-only         # re-render the last run
> +  scripts/coverage.sh --table               # ASCII table of the last ru=
n
> +  scripts/coverage.sh -t "perf annotate"    # a single test fragment
> +  scripts/coverage.sh -f util/evsel.c       # add a file to the table
> +EOF
> +}
> +
> +while [ $# -gt 0 ]; do
> +       arg=3D$1
> +       optval=3D
> +       case "$arg" in
> +       --*=3D*) optval=3D${arg#*=3D}; arg=3D${arg%%=3D*} ;;
> +       esac
> +
> +       case "$arg" in
> +       -b|--build-dir)   BUILD_DIR=3D${optval:-${2?missing value}}; BUIL=
D_DIR_SET=3D1
> +                         [ -z "$optval" ] && shift ;;
> +       -c|--cov-dir)     COV_DIR=3D${optval:-${2?missing value}}; COV_DI=
R_SET=3D1
> +                         [ -z "$optval" ] && shift ;;
> +       -j|--jobs)        JOBS=3D${optval:-${2?missing value}}; [ -z "$op=
tval" ] && shift ;;
> +       -f|--focus)       FOCUS+=3D("${optval:-${2?missing value}}"); [ -=
z "$optval" ] && shift ;;
> +       --baseline)       BASELINE=3D${optval:-${2?missing value}}; [ -z =
"$optval" ] && shift ;;
> +       --uncovered)      UNCOVERED=3D${optval:-${2?missing value}}; [ -z=
 "$optval" ] && shift ;;
> +       --top)            TOP=3D${optval:-${2?missing value}}; [ -z "$opt=
val" ] && shift ;;
> +       --dwarf-version)  DWARF_VERSION=3D${optval:-${2?missing value}}; =
[ -z "$optval" ] && shift ;;
> +       -t|--tests)       IFS=3D';' read -r -a _t <<< "${optval:-${2?miss=
ing value}}"
> +                         TESTS+=3D("${_t[@]}"); [ -z "$optval" ] && shif=
t ;;
> +       --no-baseline)    USE_BASELINE=3D0 ;;
> +       --skip-build)     SKIP_BUILD=3D1 ;;
> +       --report-only)    REPORT_ONLY=3D1; SKIP_BUILD=3D1 ;;
> +       --prep)           PREP=3D1 ;;
> +       -T|--table)       TABLE=3D1; REPORT_ONLY=3D1; SKIP_BUILD=3D1 ;;
> +       --optimized)      DEBUG_BUILD=3D0 ;;
> +       --html)           HTML=3D1 ;;
> +       -h|--help)        usage; exit 0 ;;
> +       -*)               die "unknown option: $arg (see --help)" ;;
> +       *)                TESTS+=3D("$arg") ;;
> +       esac
> +       shift
> +done
> +
> +#
> +# The build directory is recorded by --prep (and by a full run) so a
> +# later root run, which does not build, finds it without arguments.
> +#
> +if [ "$BUILD_DIR_SET" =3D 0 ] && [ -z "$BUILD_DIR" ] && [ "$PREP" =3D 0 =
] &&
> +   { [ "$ROOT" =3D 1 ] || [ "$SKIP_BUILD" =3D 1 ] ||
> +     [ "$REPORT_ONLY" =3D 1 ] || [ "$TABLE" =3D 1 ]; } &&
> +   [ -f "$PERF_DIR/.coverage-build-dir" ]; then
> +       read -r BUILD_DIR < "$PERF_DIR/.coverage-build-dir"
> +fi
> +[ -n "$BUILD_DIR" ] || BUILD_DIR=3D$DEFAULT_BUILD_DIR
> +
> +if [ "$COV_DIR_SET" =3D 0 ] && [ -z "$COV_DIR" ] &&
> +   [ -f "$BUILD_DIR/cov/state" ]; then
> +       COV_DIR=3D$(awk -F=3D '$1 =3D=3D "COV_DIR" { print $2; exit }' \
> +               "$BUILD_DIR/cov/state")
> +fi
> +[ -n "$COV_DIR" ] || COV_DIR=3D$BUILD_DIR/cov
> +
> +# The tests run from the kernel tree root, so keep these absolute.
> +abspath()
> +{
> +       case "$1" in
> +       /*) printf '%s\n' "$1" ;;
> +       *)  printf '%s/%s\n' "$PWD" "$1" ;;
> +       esac
> +}
> +BUILD_DIR=3D$(abspath "$BUILD_DIR")
> +COV_DIR=3D$(abspath "$COV_DIR")
> +
> +[ -n "$BASELINE" ] || BASELINE=3D$COV_DIR/baseline.txt
> +[[ $TOP =3D~ ^[0-9]+$ ]] || die "--top wants a number, not '$TOP'"
> +[[ $MIN_LINES =3D~ ^[0-9]+$ ]] || die "MIN_LINES wants a number, not '$M=
IN_LINES'"
> +
> +# Root does not build: use the perf prepared by coverage-prep.
> +if [ "$ROOT" =3D 1 ] && [ "$PREP" =3D 0 ] && [ "$TABLE" =3D 0 ]; then
> +       SKIP_BUILD=3D1
> +       say "Running as root, using the coverage build in $BUILD_DIR"
> +fi
> +
> +BUILD_LOG=3D$COV_DIR/build.log
> +TEST_LOG=3D$COV_DIR/tests.log
> +REPORT=3D$COV_DIR/report.txt
> +PROFDATA=3D$COV_DIR/perf.profdata
> +# Discovery point for a later root or --table run, so it stays under
> +# BUILD_DIR even when --cov-dir points elsewhere.
> +STATE_FILE=3D$BUILD_DIR/cov/state
> +POINTER=3D$PERF_DIR/.coverage-build-dir
> +
> +#
> +# Sanity checks
> +#
> +[ -d "$PERF_DIR" ] || die "$PERF_DIR not found"
> +
> +if [ "$TABLE" =3D 0 ]; then
> +       if [ "$PREP" =3D 0 ]; then
> +               command -v "$LLVM_COV" > /dev/null ||
> +                       die "$LLVM_COV not found (set LLVM_COV)"
> +       fi
> +       if [ "$SKIP_BUILD" =3D 0 ]; then
> +               command -v clang > /dev/null ||
> +                       die "clang not found, it is the only compiler wit=
h -fcoverage-mapping"
> +       fi
> +       if [ "$PREP" =3D 0 ] && [ "$REPORT_ONLY" =3D 0 ]; then
> +               command -v "$LLVM_PROFDATA" > /dev/null ||
> +                       die "$LLVM_PROFDATA not found (set LLVM_PROFDATA)=
"
> +       fi
> +       mkdir -p "$COV_DIR"
> +fi
> +
> +#
> +# Build: clang, DEBUG=3D1 gives -O0 -g like pahole's coverage build, whi=
ch
> +# keeps the line mapping honest at the cost of slower test runs.  DWARF =
4
> +# is the default; --dwarf-version 5 describes the workloads linked into
> +# perf with DW_OP_addrx, the encoding clang uses for globals in DWARF 5.
> +#
> +check_coverage_build()
> +{
> +       [ -x "$BUILD_DIR/perf" ] ||
> +               die "no $BUILD_DIR/perf, run 'make -C $PERF_DIR O=3D$BUIL=
D_DIR coverage-prep' first"
> +       if command -v nm > /dev/null; then
> +               # No -q: grep reads all of nm's output, so pipefail does
> +               # not see a SIGPIPE from an early exit.
> +               nm "$BUILD_DIR/perf" 2>/dev/null |
> +                       grep '__llvm_profile' > /dev/null ||
> +                       die "$BUILD_DIR/perf was not built for coverage, =
run coverage-prep"
> +       else
> +               warn "nm not found, cannot verify that $BUILD_DIR/perf is=
 instrumented"
> +       fi
> +}
> +
> +write_state()
> +{
> +       mkdir -p "$(dirname "$STATE_FILE")" ||
> +               die "could not create $(dirname "$STATE_FILE")"
> +       {
> +               printf 'BUILD_DIR=3D%s\n' "$BUILD_DIR"
> +               printf 'COV_DIR=3D%s\n' "$COV_DIR"
> +               printf 'DEBUG_BUILD=3D%s\n' "$DEBUG_BUILD"
> +               printf 'DWARF_VERSION=3D%s\n' "$DWARF_VERSION"
> +       } > "$STATE_FILE" || die "could not write $STATE_FILE"
> +
> +       if ! printf '%s\n' "$BUILD_DIR" > "$POINTER" 2>/dev/null; then
> +               warn "could not write $POINTER, root runs will need -b $B=
UILD_DIR"
> +       fi
> +}
> +
> +build_perf()
> +{
> +       if [ "$SKIP_BUILD" =3D 1 ]; then
> +               check_coverage_build
> +               return
> +       fi
> +
> +       say "Building perf in $BUILD_DIR"
> +       mkdir -p "$BUILD_DIR"
> +       local debug=3D()
> +       [ "$DEBUG_BUILD" =3D 1 ] && debug=3D(DEBUG=3D1)
> +
> +       if ! make -C "$PERF_DIR" O=3D"$BUILD_DIR" CC=3Dclang \
> +               "${debug[@]+"${debug[@]}"}" \
> +               EXTRA_CFLAGS=3D"-fprofile-instr-generate -fcoverage-mappi=
ng -gdwarf-$DWARF_VERSION" \
> +               -j"$JOBS" > "$BUILD_LOG" 2>&1; then
> +               tail -20 "$BUILD_LOG" >&2
> +               die "build failed, full log in $BUILD_LOG"
> +       fi
> +       tail -1 "$BUILD_LOG"
> +       write_state
> +}
> +
> +#
> +# Run the selected tests with the instrumented perf in PATH: the shell
> +# tests, the workloads and 'perf test' itself all come from there.
> +#
> +run_tests()
> +{
> +       if [ ${#TESTS[@]} -eq 0 ]; then
> +               say "Running the complete perf test suite"
> +       else
> +               say "Running perf tests: ${TESTS[*]}"
> +       fi
> +       rm -rf "$COV_DIR/raw"
> +       mkdir -p "$COV_DIR/raw"
> +
> +       set +e
> +       # The shell tests only get discovered from the kernel tree root.
> +       (cd "$PERF_DIR/../.." &&
> +               PATH=3D"$BUILD_DIR:$PATH" \
> +               LLVM_PROFILE_FILE=3D"$COV_DIR/raw/perf-%p-%m.profraw" \
> +                       "$BUILD_DIR/perf" test -v \
> +                               "${TESTS[@]+"${TESTS[@]}"}") 2>&1 | tee "=
$TEST_LOG"
> +       test_status=3D${PIPESTATUS[0]}
> +       set -e
> +
> +       # 'perf test' exits 0 even when tests fail, only the summary tell=
s.
> +       if [ "$test_status" =3D 0 ] && grep -qE '^Failed tests +: +[1-9]'=
 "$TEST_LOG"; then
> +               test_status=3D1
> +       fi
> +
> +       grep -E '^(Passed|Skipped|Failed) .*:' "$TEST_LOG" || true
> +       [ "$test_status" =3D 0 ] ||
> +               warn "some tests failed or were skipped, coverage is stil=
l collected"
> +       if [ "$test_status" !=3D 0 ] && grep -q 'Access to performance mo=
nitoring' "$TEST_LOG"; then
> +               warn "perf_event_paranoid=3D$(cat /proc/sys/kernel/perf_e=
vent_paranoid 2>/dev/null)" \
> +                    "denied events to tests recording with callchains;" =
\
> +                    "run as root or lower it for the full suite"
> +       fi
> +}
> +
> +#
> +# Merge the per-process profiles and render the text report.
> +#
> +merge_profiles()
> +{
> +       local count size
> +       count=3D$(find "$COV_DIR/raw" -name '*.profraw' | wc -l)
> +       size=3D$(du -sh "$COV_DIR/raw" 2>/dev/null | cut -f1)
> +       [ "$count" -gt 0 ] ||
> +               die "no .profraw files, was perf rebuilt with -fprofile-i=
nstr-generate?"
> +
> +       say "Merging $count profile files ($size)"
> +       "$LLVM_PROFDATA" merge -sparse "$COV_DIR"/raw/*.profraw -o "$PROF=
DATA" ||
> +               die "llvm-profdata merge failed"
> +}
> +
> +llvm_cov_objects()
> +{
> +       echo "$BUILD_DIR/perf"
> +       local so
> +       for so in perf.so libperf.so libperf-jvmti.so; do
> +               [ -f "$BUILD_DIR/$so" ] && echo "--object=3D$BUILD_DIR/$s=
o"
> +       done
> +       # The Python extension is named after the interpreter ABI and liv=
es
> +       # in its own directory.
> +       for so in "$BUILD_DIR"/python/perf*.so; do
> +               [ -f "$so" ] && echo "--object=3D$so"
> +       done
> +}
> +
> +render_report()
> +{
> +       local objects
> +       mapfile -t objects < <(llvm_cov_objects)
> +
> +       say "Generating report"
> +       "$LLVM_COV" report "${objects[@]}" --instr-profile=3D"$PROFDATA" =
> "$REPORT"
> +}
> +
> +#
> +# Line coverage of a full report for one file: "lines missed cover fn%".
> +# Report paths are relative to the build directory, so match the request=
ed
> +# path as a suffix: a build outside the source tree gives
> +# ".../tools/perf/..." and one inside gives "tools/perf/...".
> +#
> +# -f takes the path as it shows in the report, or a tools/perf/ relative=
 one.
> +focus_path()
> +{
> +       case "$1" in
> +       *tools/perf/*) printf '%s\n' "${1#*tools/perf/}" ;;
> +       *) printf '%s\n' "$1" ;;
> +       esac
> +}
> +
> +file_cov()
> +{
> +       awk -v f=3D"$2" '
> +               function perf_relpath(p) {
> +                       if (p ~ /(^|\/)tools\/perf\//)
> +                               sub(/^.*tools\/perf\//, "", p)
> +                       return p
> +               }
> +               {
> +                       g =3D f
> +                       sub(/^.*tools\/perf\//, "", g)
> +                       rel =3D perf_relpath($1)
> +                       if (rel =3D=3D f || rel =3D=3D g || $1 =3D=3D f) =
{
> +                               print $8, $9, $10, $7
> +                               exit
> +                       }
> +               }' "$1"
> +}
> +
> +total_cov()
> +{
> +       awk '$1 =3D=3D "TOTAL" { print $8, $9, $10 }' "$1"
> +}
> +
> +total_delta()
> +{
> +       local prev=3D$1 cur=3D$2 old cur_cov
> +       [ -f "$prev" ] || return 0
> +       old=3D$(total_cov "$prev" | awk '{print $3}')
> +       cur_cov=3D$(total_cov "$cur" | awk '{print $3}')
> +       [ -n "$old" ] && [ -n "$cur_cov" ] || return 0
> +       awk -v cur=3D"$cur_cov" -v old=3D"$old" 'BEGIN {
> +               sub(/%$/, "", cur); sub(/%$/, "", old)
> +               printf "%+.2f%%", cur - old }'
> +}
> +
> +report_delta()
> +{
> +       local prev=3D$1 cur=3D$2 label
> +       local cur_cov old_cov delta
> +       label=3D$(focus_path "$3")
> +       cur_cov=3D$(file_cov "$cur" "$label" | awk '{print $3}')
> +       [ -n "$cur_cov" ] || return 0
> +
> +       if [ -f "$prev" ]; then
> +               old_cov=3D$(file_cov "$prev" "$label" | awk '{print $3}')
> +               if [ -n "$old_cov" ]; then
> +                       delta=3D$(awk -v cur=3D"$cur_cov" -v old=3D"$old_=
cov" 'BEGIN {
> +                               sub(/%$/, "", cur); sub(/%$/, "", old)
> +                               printf "%+.2f%%", cur - old }')
> +               else
> +                       delta=3D"(new)"
> +               fi
> +       else
> +               old_cov=3D"-"
> +               delta=3D"-"
> +       fi
> +       printf "  %-36s %8s  %8s  %9s\n" "$label" "${old_cov:--}" "$cur_c=
ov" "$delta"
> +}
> +
> +#
> +# With no -f, show where the uncovered lines are: the files with the mos=
t
> +# missed lines are where new tests should try to get more coverage.
> +#
> +print_worst_files()
> +{
> +       [ "$TOP" -gt 0 ] || return 0
> +       local rows missed lines cover fn path
> +       rows=3D$(awk -v min=3D"$MIN_LINES" '
> +               $1 ~ /(^|\/)tools\/perf\// && $8 >=3D min && $9 > 0 {
> +                       path =3D $1
> +                       sub(/^.*tools\/perf\//, "", path)
> +                       printf "%s %s %s %s %s\n", $9, $8, $10, $7, path
> +               }' "$REPORT" | sort -k1,1nr -k2,2nr | sed -n "1,${TOP}p")
> +       [ -n "$rows" ] || return 0
> +
> +       printf "  largest uncovered files (>=3D %s lines)\n" "$MIN_LINES"
> +       printf "  %-44s %8s  %8s  %8s  %8s\n" \
> +               "file" "lines" "cover" "missed" "fn-cover"
> +       while read -r missed lines cover fn path; do
> +               printf "  %-44s %8s  %8s  %8s  %8s\n" \
> +                       "$path" "$lines" "$cover" "$missed" "$fn"
> +       done <<< "$rows"
> +}
> +
> +print_summary()
> +{
> +       local lines missed cover delta file cov
> +       read -r lines missed cover < <(total_cov "$REPORT")
> +       printf "\n\033[1mTotal:\033[0m %s of %s lines covered (%s)" \
> +               "$((lines - missed))" "$lines" "$cover"
> +       if [ "$USE_BASELINE" =3D 1 ] && [ -f "$BASELINE" ] &&
> +          ! cmp -s "$BASELINE" "$REPORT"; then
> +               delta=3D$(total_delta "$BASELINE" "$REPORT")
> +               [ -n "$delta" ] && printf "  (previous %s, %s)" \
> +                       "$(total_cov "$BASELINE" | awk '{print $3}')" "$d=
elta"
> +       fi
> +       printf "\n\n"
> +
> +       if [ ${#FOCUS[@]} -eq 0 ]; then
> +               print_worst_files
> +               return
> +       fi
> +
> +       printf "  \033[1m%-36s\033[0m %8s  %6s  %6s  %8s\n" \
> +               "file" "lines" "cover" "missed" "fn-cover"
> +       for file in "${FOCUS[@]}"; do
> +               file=3D$(focus_path "$file")
> +               cov=3D$(file_cov "$REPORT" "$file")
> +               if [ -z "$cov" ]; then
> +                       printf "  %-36s %8s\n" "$file" "not covered"
> +                       continue
> +               fi
> +               printf "  %-36s %8s  %6s  %6s  %8s\n" "$file" \
> +                       "$(echo "$cov" | awk '{print $1}')" \
> +                       "$(echo "$cov" | awk '{print $3}')" \
> +                       "$(echo "$cov" | awk '{print $2}')" \
> +                       "$(echo "$cov" | awk '{print $4}')"
> +       done
> +
> +       if [ "$USE_BASELINE" =3D 1 ] && [ -f "$BASELINE" ] &&
> +          ! cmp -s "$BASELINE" "$REPORT"; then
> +               printf "\n  per file delta since %s\n" "$BASELINE"
> +               printf "  %-36s %8s  %8s  %9s\n" "file" "previous" "curre=
nt" "delta"
> +               for file in "${FOCUS[@]}"; do
> +                       report_delta "$BASELINE" "$REPORT" "$file"
> +               done
> +       fi
> +}
> +
> +#
> +# --table: render the report of the last run as an ASCII table, like
> +# pahole's coverage_table.py.  Without -f the rows are the TOP files wit=
h
> +# the most uncovered lines, sorted by line coverage; --top 0 lists every
> +# file with at least MIN_LINES lines and uncovered lines.  The total is
> +# the whole report, which also counts the libraries perf links with.
> +#
> +bar()
> +{
> +       local pct=3D$1 width=3D$2 filled i out=3D
> +       filled=3D$(awk -v p=3D"$pct" -v w=3D"$width" 'BEGIN { printf "%d"=
, p * w / 100 }')
> +       for ((i =3D 0; i < filled; i++)); do out+=3D=E2=96=88; done
> +       for ((i =3D filled; i < width; i++)); do out+=3D=E2=96=91; done
> +       printf '%s' "$out"
> +}
> +
> +center()
> +{
> +       local left=3D$(( ($2 - ${#1}) / 2 ))
> +       printf '%*s%s%*s' "$left" '' "$1" "$(( $2 - ${#1} - left ))" ''
> +}
> +
> +dashes()
> +{
> +       local s
> +       printf -v s '%*s' "$1" ''
> +       printf '%s' "${s// /=E2=94=80}"
> +}
> +
> +table_row()
> +{
> +       awk -v f=3D"$2" '
> +               function perf_relpath(p) {
> +                       if (p ~ /(^|\/)tools\/perf\//)
> +                               sub(/^.*tools\/perf\//, "", p)
> +                       return p
> +               }
> +               {
> +                       g =3D f
> +                       sub(/^.*tools\/perf\//, "", g)
> +                       path =3D perf_relpath($1)
> +                       if (path =3D=3D f || path =3D=3D g || $1 =3D=3D f=
) {
> +                               printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\=
n",
> +                                      path, $8, $8 - $9, $9, $10, $5, $5=
 - $6, $7
> +                               exit
> +                       }
> +               }' "$1"
> +}
> +
> +table_rows()
> +{
> +       if [ ${#FOCUS[@]} -gt 0 ]; then
> +               local file
> +               for file in "${FOCUS[@]}"; do
> +                       table_row "$REPORT" "$file"
> +               done | sort -t$'\t' -k5,5gr
> +               return
> +       fi
> +
> +       awk -v min=3D"$MIN_LINES" '
> +               $1 ~ /(^|\/)tools\/perf\// && $8 >=3D min && $9 > 0 {
> +                       path =3D $1
> +                       sub(/^.*tools\/perf\//, "", path)
> +                       printf "%s\t%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
> +                              path, $8, $8 - $9, $9, $10, $5, $5 - $6, $=
7
> +               }' "$REPORT" |
> +               sort -t$'\t' -k4,4nr |
> +               if [ "$TOP" -gt 0 ]; then sed -n "1,${TOP}p"; else cat; f=
i |
> +               sort -t$'\t' -k5,5gr
> +}
> +
> +print_table()
> +{
> +       local rows total path lines hit missed pct funcs funcs_hit func_c=
ov
> +       local row_fmt w d_file d29 d13 d10 d8
> +
> +       rows=3D$(table_rows)
> +       [ -n "$rows" ] ||
> +               die "no coverage data in $REPORT for the requested files"
> +       total=3D$(awk '$1 =3D=3D "TOTAL" {
> +               printf "%s\t%d\t%d\t%.2f\t%s\t%d\t%s\n",
> +                      $8, $8 - $9, $9, $10, $5, $5 - $6, $7
> +       }' "$REPORT")
> +
> +       w=3D4
> +       while IFS=3D$'\t' read -r path _; do
> +               if [ ${#path} -gt "$w" ]; then
> +                       w=3D${#path}
> +               fi
> +       done <<< "$rows"
> +
> +       d8=3D$(dashes 8)
> +       d10=3D$(dashes 10)
> +       d13=3D$(dashes 13)
> +       d29=3D$(dashes 29)
> +       d_file=3D$(dashes $((w + 2)))
> +
> +       printf '=E2=94=8C%s=E2=94=AC%s=E2=94=AC%s=E2=94=AC%s=E2=94=AC%s=
=E2=94=AC%s=E2=94=AC%s=E2=94=90\n' \
> +               "$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
> +       printf '=E2=94=82 %-*s =E2=94=82 %6s =E2=94=82 %6s =E2=94=82 %6s =
=E2=94=82 %s =E2=94=82 %11s =E2=94=82 %8s =E2=94=82\n' \
> +               "$w" "File" "Lines" "Hit" "Miss" \
> +               "$(center 'Line Coverage' 27)" "Funcs" "FuncCov"
> +       printf '=E2=94=9C%s=E2=94=BC%s=E2=94=BC%s=E2=94=BC%s=E2=94=BC%s=
=E2=94=BC%s=E2=94=BC%s=E2=94=A4\n' \
> +               "$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
> +
> +       row_fmt=3D$(printf '=E2=94=82 %%-%ds =E2=94=82 %%6s =E2=94=82 %%6=
s =E2=94=82 %%6s =E2=94=82 %%s %%5.1f%%%%' "$w")
> +       row_fmt+=3D' =E2=94=82 %5s/%-5s =E2=94=82 %8s =E2=94=82\n'
> +
> +       while IFS=3D$'\t' read -r path lines hit missed pct funcs funcs_h=
it func_cov; do
> +               printf "$row_fmt" "$path" "$lines" "$hit" "$missed" \
> +                       "$(bar "$pct" 20)" "$pct" "$funcs_hit" "$funcs" "=
$func_cov"
> +       done <<< "$rows"
> +
> +       printf '=E2=94=9C%s=E2=94=BC%s=E2=94=BC%s=E2=94=BC%s=E2=94=BC%s=
=E2=94=BC%s=E2=94=BC%s=E2=94=A4\n' \
> +               "$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
> +       while IFS=3D$'\t' read -r lines hit missed pct funcs funcs_hit fu=
nc_cov; do
> +               printf "$row_fmt" "TOTAL" "$lines" "$hit" "$missed" \
> +                       "$(bar "$pct" 20)" "$pct" "$funcs_hit" "$funcs" "=
$func_cov"
> +       done <<< "$total"
> +       printf '=E2=94=94%s=E2=94=B4%s=E2=94=B4%s=E2=94=B4%s=E2=94=B4%s=
=E2=94=B4%s=E2=94=B4%s=E2=94=98\n' \
> +               "$d_file" "$d8" "$d8" "$d8" "$d29" "$d13" "$d10"
> +}
> +
> +print_uncovered()
> +{
> +       [ "$UNCOVERED" -gt 0 ] || return 0
> +       [ ${#FOCUS[@]} -gt 0 ] || return 0
> +       local objects file out lines header=3D0
> +       mapfile -t objects < <(llvm_cov_objects)
> +
> +       for file in "${FOCUS[@]}"; do
> +               file=3D$(focus_path "$file")
> +               # No report row means the file was not built: print_summa=
ry()
> +               # already said so, llvm-cov show would dump the whole pro=
file.
> +               [ -n "$(file_cov "$REPORT" "$file")" ] || continue
> +               out=3D$("$LLVM_COV" show "${objects[@]}" --instr-profile=
=3D"$PROFDATA" \
> +                       "$PERF_DIR/$file" 2>/dev/null |
> +                       awk -F'|' '$2 ~ /^[[:space:]]*0[[:space:]]*$/ {
> +                               gsub(/[[:space:]]/, "", $1); printf "%s "=
, $1 }')
> +               lines=3D$(echo "$out" | wc -w)
> +               [ "$lines" -gt 0 ] || continue
> +               if [ "$header" =3D 0 ]; then
> +                       printf "\n  uncovered lines (first %s per file)\n=
" "$UNCOVERED"
> +                       header=3D1
> +               fi
> +               printf "  %-24s %4s lines: %s\n" "$file" "$lines" \
> +                       "$(echo "$out" | cut -d' ' -f1-"$UNCOVERED")"
> +       done
> +}
> +
> +save_html()
> +{
> +       [ "$HTML" =3D 1 ] || return 0
> +       local objects
> +       mapfile -t objects < <(llvm_cov_objects)
> +       say "Writing HTML report to $COV_DIR/html"
> +       "$LLVM_COV" show "${objects[@]}" --instr-profile=3D"$PROFDATA" \
> +               --format=3Dhtml --output-dir=3D"$COV_DIR/html" \
> +               --show-line-counts-or-regions --show-branches=3Dcount
> +}
> +
> +check_stale()
> +{
> +       [ "$REPORT_ONLY" =3D 1 ] || return 0
> +       if [ ! -f "$PROFDATA" ]; then
> +               [ "$TABLE" =3D 1 ] && return 0
> +               die "no $PROFDATA, run without --report-only first"
> +       fi
> +       local newer
> +       newer=3D$(find "$PERF_DIR" -name '*.c' -newer "$PROFDATA" -print =
-quit 2>/dev/null)
> +       if [ -n "$newer" ]; then
> +               warn "profiles are older than source changes (e.g. $newer=
), results may be stale"
> +       fi
> +}
> +
> +update_baseline()
> +{
> +       [ "$USE_BASELINE" =3D 1 ] || return 0
> +       [ "$REPORT_ONLY" =3D 1 ] && return 0
> +       [ -f "$BASELINE" ] && mv "$BASELINE" "$BASELINE.prev"
> +       cp "$REPORT" "$BASELINE"
> +       printf "\nBaseline saved: %s\n" "$BASELINE"
> +}
> +
> +test_status=3D0
> +
> +if [ "$TABLE" =3D 1 ]; then
> +       [ -f "$REPORT" ] || die "no $REPORT, run coverage first"
> +       check_stale
> +       print_table
> +       exit 0
> +fi
> +
> +if [ "$PREP" =3D 1 ]; then
> +       build_perf
> +       write_state
> +       say "Coverage build ready: $BUILD_DIR/perf"
> +       printf "As root: %s/scripts/coverage.sh\n" "$PERF_DIR"
> +       exit 0
> +fi
> +
> +if [ "$REPORT_ONLY" =3D 0 ]; then
> +       build_perf
> +       run_tests
> +       merge_profiles
> +else
> +       check_coverage_build
> +       check_stale
> +fi
> +
> +[ -f "$PROFDATA" ] || die "no $PROFDATA, run without --report-only first=
"
> +
> +render_report
> +print_summary
> +print_uncovered
> +save_html
> +update_baseline
> +
> +printf "\nReport:  %s\n" "$REPORT"
> +[ "$HTML" =3D 1 ] && printf "HTML:    %s\n" "$COV_DIR/html/index.html"
> +
> +exit "$test_status"
> --
> 2.56.0
>
