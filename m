Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CE20FA81
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256928; cv=none; b=kVuI2tIHM9tjLohpFwV5wy9JlpNvBaE4NlmfWU3DBMUZ/5BOS2lF5z7lHHGaJNefc+EtvI/X8XvjZyMur96YUW/vqS+IYC6JgemFt+Anwdv+JQQ8d7zCU+8jVKZB5X0vhL9zYUWbYGagNCPUKRuPTkNb3MGHqDMGNBAXYl5WDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256928; c=relaxed/simple;
	bh=tc5bdXrHw8E+knwEcdnLVL3uWc1DS1Ur5fVP5XFD9Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhr5DKagglZFCNnz5lKoav1/0PSo8Ar4G9FD3cRxI14lGShRe+Z9HdkFlDHZJYKOZxpoFj13tjFENOGTcbUa4OImA1he8cy7+ZesUiFqH7ams9QLcmWCSMLR22xdR12pK1ojalgewK9wjE/fjJHtaoflrmuXxqRCiXLX81IqGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQuLtGLr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQuLtGLr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so32415ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759256925; x=1759861725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3kY3IP+50J0eN4J8rSvjmYA5niO67esNWhAUhM7uhA=;
        b=MQuLtGLrzShAgeO0re3YSLPXg7wU5KqXp+2Zv2IHtj8HH23flZOftUH34njVvITAij
         RUhSWh/OzUJ4kJmlpg8Yj6S+sWYWxEXIsMs7+lHyOea5UnIbkP0x5xhIQJr5bQpRWEpW
         XNehAOsSl25GCJ+04dxAN3rCT+zdYKeCZSWLZ/SN2/EKDQW304uoLSBZBOZUNbkKJ/rX
         5ksWjW8t1PNI3R/zsfnyCWM3a07j+6YVIptgHqNjc7pO1NSl+GwIjKS74t+ahscdDdO+
         K+kpHj40gZlRpC5nbqvfaBko8eg+mC/qZtd4JMpChQY/kysLo7K3PNy8pGQkHtMu1kF6
         D4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759256925; x=1759861725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3kY3IP+50J0eN4J8rSvjmYA5niO67esNWhAUhM7uhA=;
        b=LljlYoLt5CUuUISuRT3XfxOglWHVcou/nJiQio+we7SVFYT5VhST6/29aEFAeG5vlP
         PGb7v6xgtZWMOHjOQ1hFeYWrXS48rXSnA/MK+WB8R0o6P2G5qu1pfEyyGe0klPntBarr
         7xbzmgY9l202R3qAl2DywKXXT9p5/vPPklGeAwlCMLfK19rmLQpQVhJCuqplEctFTcLh
         fENXOUVtFhtevTyABx5peQnPuCYx8iepvfRr/X/ELdJzvPP7BRoTB4INbj7f4hKIv44E
         r6nDPcoKZZamO+bTaFuQsNy45HzJjQ80x2s/AbP0L62iVZpBerMxUgnrYzC6XkKeQTLI
         B0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnw155FRwLlb08LOyylhYB+hBiZVHoT9nBxB2HuoP94iCEZWQWarzbwg4VZhIbW3xyPjrxSFefTcFMRitCwCJl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xn/kwqaTbap0ntGAW9asExm1M0LHZDf+r0HrhaO2altSVTRO
	hCylU5va65YkRboN7HKWuI+x7QULq4HFX/Xy+tyGhMjDScrxk0LNvvKTX5YmAW8Y7FNi5/4FEW9
	qx6GZkEr3FoRgUgBLJTlpW5OpWfksUrxW99HyPmvB
X-Gm-Gg: ASbGncvkrSsXTJhR291tLnvV+x+rkBb2ddtp8uiSCfy2RaDCI1pr+kYPT2Kl/5vf5wr
	f/XgVNVvBLJnTSbDPiMfm+fcgSLBpLgXI5TL5vxjWfqThfE2cBXlAIj1qyZl2/eRiE3GuEykGCI
	gkENXE0EHkfhyRuUG2sd9UNwYoCMwuIlbZ2BiQTUjWlkntI+69guci0CQUbZs94XY22t4MOM1or
	9tN7kofGSYyzA1J76R7Bvim0AOFV2SqeqHgTgux9PygX2r1mieTIjJZukclkmOMo7QF
X-Google-Smtp-Source: AGHT+IHoswh1wR9ayAkqJP4SJjh55qDP33gBSFm6a8xwvN0PL2aADFHVHGaR4DJpMl1QSxjchMgKo8c7u30jTO6p9T0=
X-Received: by 2002:a17:902:f68c:b0:24b:131c:48b4 with SMTP id
 d9443c01a7336-28e8028119fmr486995ad.5.1759256924292; Tue, 30 Sep 2025
 11:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930160923.13728-1-jbrnak@redhat.com> <20250930160923.13728-2-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-2-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 11:28:33 -0700
X-Gm-Features: AS18NWChBLP2WDd3OoLHH_wIm5q9WraZ-SRYauHiyQEG-h1w6vwb71h_ELYDIL4
Message-ID: <CAP-5=fWyq9_Dvgz+X1+=e28yBG7wX4LKOf34AXrEBt=5o7tMdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] perf test perftool_testsuite: Use absolute paths
To: Jakub Brnak <jbrnak@redhat.com>
Cc: namhyung@kernel.org, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:09=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> Test cases from perftool_testsuite are affected by the current
> directory where the test are run. For this reason, the test
> driver has to change the directory to the base_dir for references to
> work correctly.
>
> Utilize absolute paths when sourcing and referencing other scripts so
> that the current working directory doesn't impact the test cases.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Although not changed here, any chance of making the naming of the file
and variables better fitting to inclusive language guidelines?
https://www.aswf.io/inclusive-language-guide/

Thanks,
Ian

> ---
>  .../base_probe/test_adding_blacklisted.sh     |  20 +++-
>  .../shell/base_probe/test_adding_kernel.sh    |  97 ++++++++++++-----
>  .../perf/tests/shell/base_probe/test_basic.sh |  31 ++++--
>  .../shell/base_probe/test_invalid_options.sh  |  14 ++-
>  .../shell/base_probe/test_line_semantics.sh   |   7 +-
>  tools/perf/tests/shell/base_report/setup.sh   |  10 +-
>  .../tests/shell/base_report/test_basic.sh     | 103 +++++++++++++-----
>  tools/perf/tests/shell/common/init.sh         |   4 +-
>  8 files changed, 202 insertions(+), 84 deletions(-)
>
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh=
 b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index 8226449ac5c3..f74aab5c5d7f 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -13,11 +13,12 @@
>  #      they must be skipped.
>  #
>
> -# include working environment
> -. ../common/init.sh
> -
> +DIR_PATH=3D"$(dirname $0)"
>  TEST_RESULT=3D0
>
> +# include working environment
> +. "$DIR_PATH/../common/init.sh"
> +
>  # skip if not supported
>  BLACKFUNC_LIST=3D`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /dev/=
null | cut -f2`
>  if [ -z "$BLACKFUNC_LIST" ]; then
> @@ -53,7 +54,8 @@ for BLACKFUNC in $BLACKFUNC_LIST; do
>         PERF_EXIT_CODE=3D$?
>
>         # check for bad DWARF polluting the result
> -       ../common/check_all_patterns_found.pl "$REGEX_MISSING_DECL_LINE" =
>/dev/null < $LOGS_DIR/adding_blacklisted.err
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "$REGEX_MISSING_DECL_LINE" >/dev/null < $LOGS_DIR/adding_=
blacklisted.err
>
>         if [ $? -eq 0 ]; then
>                 SKIP_DWARF=3D1
> @@ -73,7 +75,11 @@ for BLACKFUNC in $BLACKFUNC_LIST; do
>                         fi
>                 fi
>         else
> -               ../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE=
" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$R=
EGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DI=
R/adding_blacklisted.err
> +               "$DIR_PATH/../common/check_all_lines_matched.pl" \
> +                       "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" =
\
> +                       "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" \
> +                       "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" \
> +                       "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklist=
ed.err
>                 CHECK_EXIT_CODE=3D$?
>
>                 SKIP_DWARF=3D0
> @@ -94,7 +100,9 @@ fi
>  $CMD_PERF list probe:\* > $LOGS_DIR/adding_blacklisted_list.log
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defin=
ed events" "Metric Groups:" < $LOGS_DIR/adding_blacklisted_list.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" \
> +       < $LOGS_DIR/adding_blacklisted_list.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing blacklisted prob=
e (should NOT be listed)"
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/to=
ols/perf/tests/shell/base_probe/test_adding_kernel.sh
> index df288cf90cd6..555a825d55f2 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -13,13 +13,14 @@
>  #              and removing.
>  #
>
> -# include working environment
> -. ../common/init.sh
> -
> +DIR_PATH=3D"$(dirname $0)"
>  TEST_RESULT=3D0
>
> +# include working environment
> +. "$DIR_PATH/../common/init.sh"
> +
>  # shellcheck source=3Dlib/probe_vfs_getname.sh
> -. "$(dirname "$0")/../lib/probe_vfs_getname.sh"
> +. "$DIR_PATH/../lib/probe_vfs_getname.sh"
>
>  TEST_PROBE=3D${TEST_PROBE:-"inode_permission"}
>
> @@ -44,7 +45,9 @@ for opt in "" "-a" "--add"; do
>         $CMD_PERF probe $opt $TEST_PROBE 2> $LOGS_DIR/adding_kernel_add$o=
pt.err
>         PERF_EXIT_CODE=3D$?
>
> -       ../common/check_all_patterns_found.pl "Added new events?:" "probe=
:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_add$opt.err
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE"=
 \
> +               < $LOGS_DIR/adding_kernel_add$opt.err
>         CHECK_EXIT_CODE=3D$?
>
>         print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding probe $TES=
T_PROBE :: $opt"
> @@ -58,7 +61,10 @@ done
>  $CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list.log
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defin=
ed events" "probe:${TEST_PROBE}(?:_\d+)?\s+\[Tracepoint event\]" "Metric Gr=
oups:" < $LOGS_DIR/adding_kernel_list.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$RE_LINE_EMPTY" "List of pre-defined events" \
> +       "probe:${TEST_PROBE}(?:_\d+)?\s+\[Tracepoint event\]" \
> +       "Metric Groups:" < $LOGS_DIR/adding_kernel_list.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: p=
erf list"
> @@ -71,7 +77,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing=
 added probe :: perf list
>  $CMD_PERF probe -l > $LOGS_DIR/adding_kernel_list-l.log
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "\s*probe:${TEST_PROBE}(?:_\d+)?\s=
+\(on ${TEST_PROBE}(?:[:\+]$RE_NUMBER_HEX)?@.+\)" < $LOGS_DIR/adding_kernel=
_list-l.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "\s*probe:${TEST_PROBE}(?:_\d+)?\s+\(on ${TEST_PROBE}(?:[:\+]$RE_=
NUMBER_HEX)?@.+\)" \
> +       < $LOGS_DIR/adding_kernel_list-l.log
>  CHECK_EXIT_CODE=3D$?
>
>  if [ $NO_DEBUGINFO ] ; then
> @@ -93,9 +101,13 @@ REGEX_STAT_VALUES=3D"\s*\d+\s+probe:$TEST_PROBE"
>  # the value should be greater than 1
>  REGEX_STAT_VALUE_NONZERO=3D"\s*[1-9][0-9]*\s+probe:$TEST_PROBE"
>  REGEX_STAT_TIME=3D"\s*$RE_NUMBER\s+seconds (?:time elapsed|user|sys)"
> -../common/check_all_lines_matched.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_V=
ALUES" "$REGEX_STAT_TIME" "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < $LOGS_DIR/a=
dding_kernel_using_probe.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" \
> +       "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < $LOGS_DIR/adding_kernel_usi=
ng_probe.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_all_patterns_found.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_=
VALUE_NONZERO" "$REGEX_STAT_TIME" < $LOGS_DIR/adding_kernel_using_probe.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUE_NONZERO" "$REGEX_STAT_TIM=
E" \
> +       < $LOGS_DIR/adding_kernel_using_probe.log
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using added probe"
> @@ -108,7 +120,8 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using=
 added probe"
>  $CMD_PERF probe -d $TEST_PROBE\* 2> $LOGS_DIR/adding_kernel_removing.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" =
< $LOGS_DIR/adding_kernel_removing.err
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "Removed event: probe:$TEST_PROBE" < $LOGS_DIR/adding_kernel_remo=
ving.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "deleting added probe"
> @@ -121,7 +134,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "delet=
ing added probe"
>  $CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list_removed.log
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defin=
ed events" "Metric Groups:" < $LOGS_DIR/adding_kernel_list_removed.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" \
> +       < $LOGS_DIR/adding_kernel_list_removed.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing removed probe (s=
hould NOT be listed)"
> @@ -135,7 +150,9 @@ $CMD_PERF probe -n --add $TEST_PROBE 2> $LOGS_DIR/add=
ing_kernel_dryrun.err
>  PERF_EXIT_CODE=3D$?
>
>  # check for the output (should be the same as usual)
> -../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_=
PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_dryrun.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" \
> +       < $LOGS_DIR/adding_kernel_dryrun.err
>  CHECK_EXIT_CODE=3D$?
>
>  # check that no probe was added in real
> @@ -152,7 +169,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "dry r=
un :: adding probe"
>  $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_01=
.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_=
PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_01.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" \
> +       < $LOGS_DIR/adding_kernel_forceadd_01.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: f=
irst probe adding"
> @@ -162,7 +181,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force=
-adding probes :: first pro
>  ! $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_=
02.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "Error: event \"$TEST_PROBE\" alre=
ady exists." "Error: Failed to add events." < $LOGS_DIR/adding_kernel_force=
add_02.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "Error: event \"$TEST_PROBE\" already exists." \
> +       "Error: Failed to add events." < $LOGS_DIR/adding_kernel_forceadd=
_02.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: s=
econd probe adding (without force)"
> @@ -173,7 +194,9 @@ NO_OF_PROBES=3D`$CMD_PERF probe -l $TEST_PROBE| wc -l=
`
>  $CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_for=
ceadd_03.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "Added new events?:" "probe:${TEST=
_PROBE}_${NO_OF_PROBES}" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forcead=
d_03.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "Added new events?:" "probe:${TEST_PROBE}_${NO_OF_PROBES}" \
> +       "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_03.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: s=
econd probe adding (with force)"
> @@ -187,7 +210,9 @@ $CMD_PERF stat -e probe:$TEST_PROBE -e probe:${TEST_P=
ROBE}_${NO_OF_PROBES} -x';'
>  PERF_EXIT_CODE=3D$?
>
>  REGEX_LINE=3D"$RE_NUMBER;+probe:${TEST_PROBE}_?(?:$NO_OF_PROBES)?;$RE_NU=
MBER;$RE_NUMBER"
> -../common/check_all_lines_matched.pl "$REGEX_LINE" "$RE_LINE_EMPTY" "$RE=
_LINE_COMMENT" < $LOGS_DIR/adding_kernel_using_two.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$REGEX_LINE" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" \
> +       < $LOGS_DIR/adding_kernel_using_two.log
>  CHECK_EXIT_CODE=3D$?
>
>  VALUE_1=3D`grep "$TEST_PROBE;" $LOGS_DIR/adding_kernel_using_two.log | a=
wk -F';' '{print $1}'`
> @@ -205,7 +230,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using=
 doubled probe"
>  $CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.er=
r
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "Removed event: probe:$TEST_PROBE"=
 "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_=
wildcard.err
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "Removed event: probe:$TEST_PROBE" \
> +       "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_=
removing_wildcard.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes=
"
> @@ -217,7 +244,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "remov=
ing multiple probes"
>  $CMD_PERF probe -nf --max-probes=3D512 -a 'vfs_* $params' 2> $LOGS_DIR/a=
dding_kernel_adding_wildcard.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "probe:vfs_mknod" "probe:vfs_creat=
e" "probe:vfs_rmdir" "probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_=
kernel_adding_wildcard.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" \
> +       "probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_kernel_addi=
ng_wildcard.err
>  CHECK_EXIT_CODE=3D$?
>
>  if [ $NO_DEBUGINFO ] ; then
> @@ -240,13 +269,22 @@ test $PERF_EXIT_CODE -ne 139 -a $PERF_EXIT_CODE -ne=
 0
>  PERF_EXIT_CODE=3D$?
>
>  # check that the error message is reasonable
> -../common/check_all_patterns_found.pl "Failed to find" "somenonexistingr=
andomstuffwhichisalsoprettylongorevenlongertoexceed64" < $LOGS_DIR/adding_k=
ernel_nonexisting.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "Failed to find" \
> +       "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexc=
eed64" \
> +       < $LOGS_DIR/adding_kernel_nonexisting.err
>  CHECK_EXIT_CODE=3D$?
> -../common/check_all_patterns_found.pl "in this function|at this address"=
 "Error" "Failed to add events" < $LOGS_DIR/adding_kernel_nonexisting.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "in this function|at this address" "Error" "Failed to add events"=
 \
> +       < $LOGS_DIR/adding_kernel_nonexisting.err
>  (( CHECK_EXIT_CODE +=3D $? ))
> -../common/check_all_lines_matched.pl "Failed to find" "Error" "Probe poi=
nt .+ not found" "optimized out" "Use.+\-\-range option to show.+location r=
ange" < $LOGS_DIR/adding_kernel_nonexisting.err
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "Failed to find" "Error" "Probe point .+ not found" "optimized ou=
t" \
> +       "Use.+\-\-range option to show.+location range" \
> +       < $LOGS_DIR/adding_kernel_nonexisting.err
>  (( CHECK_EXIT_CODE +=3D $? ))
> -../common/check_no_patterns_found.pl "$RE_SEGFAULT" < $LOGS_DIR/adding_k=
ernel_nonexisting.err
> +"$DIR_PATH/../common/check_no_patterns_found.pl" \
> +       "$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  if [ $NO_DEBUGINFO ]; then
> @@ -264,7 +302,10 @@ fi
>  $CMD_PERF probe --add "$TEST_PROBE%return \$retval" 2> $LOGS_DIR/adding_=
kernel_func_retval_add.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_=
PROBE" "on $TEST_PROBE%return with \\\$retval" < $LOGS_DIR/adding_kernel_fu=
nc_retval_add.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "Added new events?:" "probe:$TEST_PROBE" \
> +       "on $TEST_PROBE%return with \\\$retval" \
> +       < $LOGS_DIR/adding_kernel_func_retval_add.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: =
add"
> @@ -274,7 +315,9 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "funct=
ion with retval :: add"
>  $CMD_PERF record -e probe:$TEST_PROBE\* -o $CURRENT_TEST_DIR/perf.data -=
- cat /proc/cpuinfo > /dev/null 2> $LOGS_DIR/adding_kernel_func_retval_reco=
rd.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECOR=
D2" < $LOGS_DIR/adding_kernel_func_retval_record.err
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" \
> +       < $LOGS_DIR/adding_kernel_func_retval_record.err
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: =
record"
> @@ -285,9 +328,11 @@ $CMD_PERF script -i $CURRENT_TEST_DIR/perf.data > $L=
OGS_DIR/adding_kernel_func_r
>  PERF_EXIT_CODE=3D$?
>
>  REGEX_SCRIPT_LINE=3D"\s*cat\s+$RE_NUMBER\s+\[$RE_NUMBER\]\s+$RE_NUMBER:\=
s+probe:$TEST_PROBE\w*:\s+\($RE_NUMBER_HEX\s+<\-\s+$RE_NUMBER_HEX\)\s+arg1=
=3D$RE_NUMBER_HEX"
> -../common/check_all_lines_matched.pl "$REGEX_SCRIPT_LINE" < $LOGS_DIR/ad=
ding_kernel_func_retval_script.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script=
.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_all_patterns_found.pl "$REGEX_SCRIPT_LINE" < $LOGS_DIR/a=
dding_kernel_func_retval_script.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script=
.log
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function argument probin=
g :: script"
> diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf=
/tests/shell/base_probe/test_basic.sh
> index 9d8b5afbeddd..162838ddc974 100755
> --- a/tools/perf/tests/shell/base_probe/test_basic.sh
> +++ b/tools/perf/tests/shell/base_probe/test_basic.sh
> @@ -12,11 +12,12 @@
>  #              This test tests basic functionality of perf probe command=
.
>  #
>
> -# include working environment
> -. ../common/init.sh
> -
> +DIR_PATH=3D"$(dirname $0)"
>  TEST_RESULT=3D0
>
> +# include working environment
> +. "$DIR_PATH/../common/init.sh"
> +
>  if ! check_kprobes_available; then
>         print_overall_skipped
>         exit 2
> @@ -30,15 +31,25 @@ if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" =3D "y" ]; then
>         $CMD_PERF probe --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR=
/basic_helpmsg.err
>         PERF_EXIT_CODE=3D$?
>
> -       ../common/check_all_patterns_found.pl "PERF-PROBE" "NAME" "SYNOPS=
IS" "DESCRIPTION" "OPTIONS" "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYN=
TAX" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" \
> +               "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         CHECK_EXIT_CODE=3D$?
> -       ../common/check_all_patterns_found.pl "LAZY\s+MATCHING" "FILTER\s=
+PATTERN" "EXAMPLES" "SEE\s+ALSO" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+AL=
SO" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_all_patterns_found.pl "vmlinux" "module=3D" "sour=
ce=3D" "verbose" "quiet" "add=3D" "del=3D" "list.*EVENT" "line=3D" "vars=3D=
" "externs" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "vmlinux" "module=3D" "source=3D" "verbose" "quiet" "add=
=3D" "del=3D" \
> +               "list.*EVENT" "line=3D" "vars=3D" "externs" < $LOGS_DIR/b=
asic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_all_patterns_found.pl "no-inlines" "funcs.*FILTER=
" "filter=3DFILTER" "force" "dry-run" "max-probes" "exec=3D" "demangle-kern=
el" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "no-inlines" "funcs.*FILTER" "filter=3DFILTER" "force" "d=
ry-run" \
> +               "max-probes" "exec=3D" "demangle-kernel" < $LOGS_DIR/basi=
c_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_no_patterns_found.pl "No manual entry for" < $LOG=
S_DIR/basic_helpmsg.err
> +       "$DIR_PATH/../common/check_no_patterns_found.pl" \
> +               "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
>         (( CHECK_EXIT_CODE +=3D $? ))
>
>         print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
> @@ -53,7 +64,9 @@ fi
>  # without any args perf-probe should print usage
>  $CMD_PERF probe 2> $LOGS_DIR/basic_usage.log > /dev/null
>
> -../common/check_all_patterns_found.pl "[Uu]sage" "perf probe" "verbose" =
"quiet" "add" "del" "force" "line" "vars" "externs" "range" < $LOGS_DIR/bas=
ic_usage.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" \
> +       "line" "vars" "externs" "range" < $LOGS_DIR/basic_usage.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results 0 $CHECK_EXIT_CODE "usage message"
> diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/=
tools/perf/tests/shell/base_probe/test_invalid_options.sh
> index 92f7254eb32a..44a3ae014bfa 100755
> --- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> +++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> @@ -12,11 +12,12 @@
>  #              This test checks whether the invalid and incompatible opt=
ions are reported
>  #
>
> -# include working environment
> -. ../common/init.sh
> -
> +DIR_PATH=3D"$(dirname $0)"
>  TEST_RESULT=3D0
>
> +# include working environment
> +. "$DIR_PATH/../common/init.sh"
> +
>  if ! check_kprobes_available; then
>         print_overall_skipped
>         exit 2
> @@ -33,7 +34,9 @@ for opt in '-a' '-d' '-L' '-V'; do
>         ! $CMD_PERF probe $opt 2> $LOGS_DIR/invalid_options_missing_argum=
ent$opt.err
>         PERF_EXIT_CODE=3D$?
>
> -       ../common/check_all_patterns_found.pl "Error: switch .* requires =
a value" < $LOGS_DIR/invalid_options_missing_argument$opt.err
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "Error: switch .* requires a value" \
> +               < $LOGS_DIR/invalid_options_missing_argument$opt.err
>         CHECK_EXIT_CODE=3D$?
>
>         print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument =
for $opt"
> @@ -66,7 +69,8 @@ for opt in '-a xxx -d xxx' '-a xxx -L foo' '-a xxx -V f=
oo' '-a xxx -l' '-a xxx -
>         ! $CMD_PERF probe $opt > /dev/null 2> $LOGS_DIR/aux.log
>         PERF_EXIT_CODE=3D$?
>
> -       ../common/check_all_patterns_found.pl "Error: switch .+ cannot be=
 used with switch .+" < $LOGS_DIR/aux.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "Error: switch .+ cannot be used with switch .+" < $LOGS_=
DIR/aux.log
>         CHECK_EXIT_CODE=3D$?
>
>         print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "mutually exclusiv=
e options :: $opt"
> diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/t=
ools/perf/tests/shell/base_probe/test_line_semantics.sh
> index 20435b6bf6bc..576442d87a44 100755
> --- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> +++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> @@ -13,11 +13,12 @@
>  #              arguments are properly reported.
>  #
>
> -# include working environment
> -. ../common/init.sh
> -
> +DIR_PATH=3D"$(dirname $0)"
>  TEST_RESULT=3D0
>
> +# include working environment
> +. "$DIR_PATH/../common/init.sh"
> +
>  if ! check_kprobes_available; then
>         print_overall_skipped
>         exit 2
> diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tes=
ts/shell/base_report/setup.sh
> index 8634e7e0dda6..bb49b0fabb11 100755
> --- a/tools/perf/tests/shell/base_report/setup.sh
> +++ b/tools/perf/tests/shell/base_report/setup.sh
> @@ -12,8 +12,10 @@
>  #
>  #
>
> +DIR_PATH=3D"$(dirname $0)"
> +
>  # include working environment
> -. ../common/init.sh
> +. "$DIR_PATH/../common/init.sh"
>
>  TEST_RESULT=3D0
>
> @@ -24,7 +26,8 @@ SW_EVENT=3D"cpu-clock"
>  $CMD_PERF record -asdg -e $SW_EVENT -o $CURRENT_TEST_DIR/perf.data -- $C=
MD_LONGER_SLEEP 2> $LOGS_DIR/setup.log
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECOR=
D2" < $LOGS_DIR/setup.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data fi=
le"
> @@ -38,7 +41,8 @@ echo =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  cat $LOGS_DIR/setup-latency.log
>  echo =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECOR=
D2" < $LOGS_DIR/setup-latency.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup-latency.l=
og
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data.1 =
file"
> diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/per=
f/tests/shell/base_report/test_basic.sh
> index adfd8713b8f8..0dfe7e5fd1ca 100755
> --- a/tools/perf/tests/shell/base_report/test_basic.sh
> +++ b/tools/perf/tests/shell/base_report/test_basic.sh
> @@ -12,11 +12,12 @@
>  #
>  #
>
> -# include working environment
> -. ../common/init.sh
> -
> +DIR_PATH=3D"$(dirname $0)"
>  TEST_RESULT=3D0
>
> +# include working environment
> +. "$DIR_PATH/../common/init.sh"
> +
>
>  ### help message
>
> @@ -25,19 +26,37 @@ if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" =3D "y" ]; then
>         $CMD_PERF report --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DI=
R/basic_helpmsg.err
>         PERF_EXIT_CODE=3D$?
>
> -       ../common/check_all_patterns_found.pl "PERF-REPORT" "NAME" "SYNOP=
SIS" "DESCRIPTION" "OPTIONS" "OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DI=
R/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" \
> +               "OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DIR/basic_hel=
pmsg.log
>         CHECK_EXIT_CODE=3D$?
> -       ../common/check_all_patterns_found.pl "input" "verbose" "show-nr-=
samples" "show-cpu-utilization" "threads" "comms" "pid" "tid" "dsos" "symbo=
ls" "symbol-filter" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "input" "verbose" "show-nr-samples" "show-cpu-utilization=
" \
> +               "threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-fi=
lter" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_all_patterns_found.pl "hide-unresolved" "sort" "f=
ields" "parent" "exclude-other" "column-widths" "field-separator" "dump-raw=
-trace" "children" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "hide-unresolved" "sort" "fields" "parent" "exclude-other=
" \
> +               "column-widths" "field-separator" "dump-raw-trace" "child=
ren" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_all_patterns_found.pl "call-graph" "max-stack" "i=
nverted" "ignore-callees" "pretty" "stdio" "tui" "gtk" "vmlinux" "kallsyms"=
 "modules" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "call-graph" "max-stack" "inverted" "ignore-callees" "pre=
tty" \
> +               "stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_all_patterns_found.pl "force" "symfs" "cpu" "disa=
ssembler-style" "source" "asm-raw" "show-total-period" "show-info" "branch-=
stack" "group" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "force" "symfs" "cpu" "disassembler-style" "source" "asm-=
raw" \
> +               "show-total-period" "show-info" "branch-stack" "group" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_all_patterns_found.pl "branch-history" "objdump" =
"demangle" "percent-limit" "percentage" "header" "itrace" "full-source-path=
" "show-ref-call-graph" < $LOGS_DIR/basic_helpmsg.log
> +       "$DIR_PATH/../common/check_all_patterns_found.pl" \
> +               "branch-history" "objdump" "demangle" "percent-limit" "pe=
rcentage" \
> +               "header" "itrace" "full-source-path" "show-ref-call-graph=
" \
> +               < $LOGS_DIR/basic_helpmsg.log
>         (( CHECK_EXIT_CODE +=3D $? ))
> -       ../common/check_no_patterns_found.pl "No manual entry for" < $LOG=
S_DIR/basic_helpmsg.err
> +       "$DIR_PATH/../common/check_no_patterns_found.pl" \
> +               "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
>         (( CHECK_EXIT_CODE +=3D $? ))
>
>         print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
> @@ -57,9 +76,12 @@ REGEX_LOST_SAMPLES_INFO=3D"#\s*Total Lost Samples:\s+$=
RE_NUMBER"
>  REGEX_SAMPLES_INFO=3D"#\s*Samples:\s+(?:$RE_NUMBER)\w?\s+of\s+event\s+'$=
RE_EVENT_ANY'"
>  REGEX_LINES_HEADER=3D"#\s*Children\s+Self\s+Command\s+Shared Object\s+Sy=
mbol"
>  REGEX_LINES=3D"\s*$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux=
)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
> -../common/check_all_patterns_found.pl "$REGEX_LOST_SAMPLES_INFO" "$REGEX=
_SAMPLES_INFO" "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_basic=
.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$REGEX_LOST_SAMPLES_INFO" "$REGEX_SAMPLES_INFO" \
> +       "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_basic.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/basic_basic.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_basic.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
> @@ -74,9 +96,11 @@ PERF_EXIT_CODE=3D$?
>
>  REGEX_LINES_HEADER=3D"#\s*Children\s+Self\s+Samples\s+Command\s+Shared O=
bject\s+Symbol"
>  REGEX_LINES=3D"\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER\s+\S+\s+\[kerne=
l\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
> -../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINE=
S" < $LOGS_DIR/basic_nrsamples.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_nrsamples.=
log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/basic_nrsamples.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_nrsamples.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "number of samples"
> @@ -98,7 +122,10 @@ REGEX_LINE_CPUS_ONLINE=3D"#\s+nrcpus online\s*:\s*$MY=
_CPUS_ONLINE"
>  REGEX_LINE_CPUS_AVAIL=3D"#\s+nrcpus avail\s*:\s*$MY_CPUS_AVAILABLE"
>  # disable precise check for "nrcpus avail" in BASIC runmode
>  test $PERFTOOL_TESTSUITE_RUNMODE -lt $RUNMODE_STANDARD && REGEX_LINE_CPU=
S_AVAIL=3D"#\s+nrcpus avail\s*:\s*$RE_NUMBER"
> -../common/check_all_patterns_found.pl "$REGEX_LINE_TIMESTAMP" "$REGEX_LI=
NE_HOSTNAME" "$REGEX_LINE_KERNEL" "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$R=
EGEX_LINE_CPUS_ONLINE" "$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.lo=
g
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$REGEX_LINE_TIMESTAMP" "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNE=
L" \
> +       "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" \
> +       "$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "header"
> @@ -129,9 +156,11 @@ PERF_EXIT_CODE=3D$?
>
>  REGEX_LINES_HEADER=3D"#\s*Children\s+Self\s+sys\s+usr\s+Command\s+Shared=
 Object\s+Symbol"
>  REGEX_LINES=3D"\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\=
s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
> -../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINE=
S" < $LOGS_DIR/basic_cpuut.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_cpuut.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/basic_cpuut.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_cpuut.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "show CPU utilization"
> @@ -144,9 +173,11 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "show=
 CPU utilization"
>  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --pid=3D1 > $LOG=
S_DIR/basic_pid.log 2> $LOGS_DIR/basic_pid.err
>  PERF_EXIT_CODE=3D$?
>
> -grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | ../com=
mon/check_all_lines_matched.pl "systemd|init"
> +grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | \
> +       "$DIR_PATH/../common/check_all_lines_matched.pl" "systemd|init"
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/basic_pid.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_pid.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
> @@ -159,9 +190,11 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
>  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbols=3Ddumm=
ynonexistingsymbol > $LOGS_DIR/basic_symbols.log 2> $LOGS_DIR/basic_symbols=
.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "$RE_LINE_COMMENT"=
 < $LOGS_DIR/basic_symbols.log
> +"$DIR_PATH/../common/check_all_lines_matched.pl" \
> +       "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/basic_symbols.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/basic_symbols.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_symbols.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing symbol"
> @@ -174,9 +207,11 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-=
existing symbol"
>  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbol-filter=
=3Dmap > $LOGS_DIR/basic_symbolfilter.log 2> $LOGS_DIR/basic_symbolfilter.e=
rr
>  PERF_EXIT_CODE=3D$?
>
> -grep -P -v '^#' $LOGS_DIR/basic_symbolfilter.log | grep -P '\s+[\d\.]+%'=
 | ../common/check_all_lines_matched.pl "\[[k\.]\]\s+.*map"
> +grep -P -v '^#' $LOGS_DIR/basic_symbolfilter.log | grep -P '\s+[\d\.]+%'=
 | \
> +       "$DIR_PATH/../common/check_all_lines_matched.pl" "\[[k\.]\]\s+.*m=
ap"
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/basic_symbolfilter.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_symbolfilter.e=
rr
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "symbol filter"
> @@ -189,7 +224,8 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "symbo=
l filter"
>  $CMD_PERF report -i $CURRENT_TEST_DIR/perf.data.1 --stdio --header-only =
> $LOGS_DIR/latency_header.log
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl ", context_switch =3D 1, " < $LOGS=
_DIR/latency_header.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       ", context_switch =3D 1, " < $LOGS_DIR/latency_header.log
>  CHECK_EXIT_CODE=3D$?
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency header"
> @@ -200,9 +236,11 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "late=
ncy header"
>  $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/la=
tency_default.log 2> $LOGS_DIR/latency_default.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "# Overhead   Latency  Command" < =
$LOGS_DIR/latency_default.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "# Overhead   Latency  Command" < $LOGS_DIR/latency_default.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/latency_default.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "stderr-whitelist.txt" < $LOGS_DIR/latency_default.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "default report for laten=
cy profile"
> @@ -213,9 +251,11 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "defa=
ult report for latency profi
>  $CMD_PERF report --latency --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $L=
OGS_DIR/latency_latency.log 2> $LOGS_DIR/latency_latency.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "#  Latency  Overhead  Command" < =
$LOGS_DIR/latency_latency.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "#  Latency  Overhead  Command" < $LOGS_DIR/latency_latency.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/latency_latency.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "stderr-whitelist.txt" < $LOGS_DIR/latency_latency.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency report for laten=
cy profile"
> @@ -226,9 +266,12 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "late=
ncy report for latency profi
>  $CMD_PERF report --hierarchy --sort latency,parallelism,comm,symbol --pa=
rallelism=3D1,2 --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/parall=
elism_hierarchy.log 2> $LOGS_DIR/parallelism_hierarchy.err
>  PERF_EXIT_CODE=3D$?
>
> -../common/check_all_patterns_found.pl "#           Latency  Parallelism =
/ Command / Symbol" < $LOGS_DIR/parallelism_hierarchy.log
> +"$DIR_PATH/../common/check_all_patterns_found.pl" \
> +       "#           Latency  Parallelism / Command / Symbol" \
> +       < $LOGS_DIR/parallelism_hierarchy.log
>  CHECK_EXIT_CODE=3D$?
> -../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR=
/parallelism_hierarchy.err
> +"$DIR_PATH/../common/check_errors_whitelisted.pl" \
> +       "stderr-whitelist.txt" < $LOGS_DIR/parallelism_hierarchy.err
>  (( CHECK_EXIT_CODE +=3D $? ))
>
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "parallelism histogram"
> diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/she=
ll/common/init.sh
> index 26c7525651e0..cbfc78bec974 100644
> --- a/tools/perf/tests/shell/common/init.sh
> +++ b/tools/perf/tests/shell/common/init.sh
> @@ -11,8 +11,8 @@
>  #
>
>
> -. ../common/settings.sh
> -. ../common/patterns.sh
> +. "$(dirname $0)/../common/settings.sh"
> +. "$(dirname $0)/../common/patterns.sh"
>
>  THIS_TEST_NAME=3D`basename $0 .sh`
>
> --
> 2.50.1
>
