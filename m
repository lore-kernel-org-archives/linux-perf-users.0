Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743521;
	b=wAV42SyXhkel7G9gUzKBGFa9ZyWxsEXTKTQW1CXwWqEW8QNIaRwbiA17m74Em1cfR2Ct
	 fFRwgUjPlfGieZ2MFEfDAXNRmIO7cLxlu7itWxoV27osL5JkW6JSsWMeV/cH0F80EcMAG
	 ERk8gPfulcJpw13ovt71ACz6W9JPrSHaSR9HFRlyXFtYOveFMrltDtN1fiyWh5Dk8mNop
	 d+2xGu5yDOIcFRA56HC8Qg1vZdS8FP8TY1mkf0fybXGT4+8CdwG0UUjA8y2kATQwJE8VV
	 GPCeLtuzRIMPD17NJ9rl/wZxKrLzypjz5XELQ3Pj3X9Oq16FhJG0lQji1ExMmN2BHLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uTc1iBdqyE/J0AmqpYREouAaxMs5mizaXoqaKFZVMwY=;
	b=wp010EkSxuTfSKBzcIQeC5MOEF0hLL0/JyBS8m1Ic6iL27Kw3gm8na+G3UjGNLoyy1pf
	 VygrZAh3Pzcj96CtZSvJRp6JRQTaBVukAO6D407cNfFvkwBKOmoN3m4dERNVB9zdr0OeP
	 BjbGAzyoZVTmN5jzJC62vCx7GBlm4Cy4K2HjN8Y3yiM+4CTKTyAOj65LFCkawHWvXsk5b
	 ggpm3mLBURHGd2O5Ph5+M3H9rkTMCLq+5OACFgvpNLrvkvteosjqXGXNEVpc8t9HF6oZT
	 BOh4uC6tpD093WtNKskkRyPHFJUdrFYqkQ6yJLtMrPa/nxkBCB1zPdNmam5yyfhB1Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+RXQLku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978E606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+RXQLku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21C11F0089C;
	Fri, 27 Nov 2026 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743521;
	bh=uTc1iBdqyE/J0AmqpYREouAaxMs5mizaXoqaKFZVMwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+RXQLkuQ7OoOswZLNz8CEW2owRS42i4mVEp1X0wkeCmGeBtAkng3KW5I/NwhdubU
	 6239G/ZiB8jtqqFMfFOEbtHSMIa2aytpUEV5n58vrkhAU8YEAspHz2wl1xVGyum8QW
	 nRB5QFcqACvGAb29YCmRuQWPu9HaxTwnhUaK6wVCF2zr56MwZEUHOYwuVOLBYG+1xg
	 yoSGFGLCCXzIGCq2sNU+9X8YnoKMt0AdLEyKMyP/HSFIX4XXh1aKTHOUAQ+6UOTtda
	 JlsXqtNBiONdcmuqHZS78yECmeOVr5nmo/yGpD0WTuKvUm0mH4Qam6ry7jfHYZ5GLO
	 lKjEcxE8mb/sg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 08/18] perf tests diff: Exercise the output options
Date: Thu, 26 Nov 2026 22:37:51 -0300
Message-ID: <20261127013801.14841-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The diff test only diffs files recorded with the same workload.  Add
the compute formulas, each checked by the column it prints, the
formula, period, field separator, sort and raw trace dump options, and
the time window, checked with a window that leaves nothing.

As delta-abs is the default compute, a plain diff prints its column as
well: the default header is pinned before the option runs, and the
delta-abs run then only checks that the option is accepted and that
the column is not dropped.

Record the third file with the noploop workload: with it the
baseline-only and order options can be checked on a second file whose
entries have no match in the baseline.  The --percentage and --verbose
options only change the numbers when entries are filtered in the TUI
and the debug output, they run here as a check that the table is still
printed.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/diff.sh | 232 ++++++++++++++++++++++++++++++---
 1 file changed, 217 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
index 88f37b8ef8936be4..5bddb06166339ce7 100755
--- a/tools/perf/tests/shell/diff.sh
+++ b/tools/perf/tests/shell/diff.sh
@@ -8,14 +8,15 @@ err=0
 perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+diffout=$(mktemp /tmp/__perf_test.perf.diff.out.XXXXX)
 testprog="perf test -w thloop"
+testprog2="perf test -w noploop"
 
 shelldir=$(dirname "$0")
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
-
-skip_test_missing_symbol ${testsym}
+testsym2="noploop"
 
 cleanup() {
   rm -rf "${perfdata1}"
@@ -24,25 +25,37 @@ cleanup() {
   rm -rf "${perfdata2}".old
   rm -rf "${perfdata3}"
   rm -rf "${perfdata3}".old
+  rm -f "${diffout}"
 
   trap - EXIT TERM INT
 }
 
 trap_cleanup() {
+  local status=$?
   cleanup
-  exit 1
+  if [ "${status}" -eq 0 ]; then
+    status=1
+  fi
+  exit "${status}"
 }
 trap trap_cleanup EXIT TERM INT
 
+# Install the cleanup trap before the symbol skips, which exit 2, so
+# the mktemp files are removed on that path too.
+skip_test_missing_symbol ${testsym}
+skip_test_missing_symbol ${testsym2}
+
 make_data() {
   file="$1"
-  if ! perf record -o "${file}" ${testprog} 2> /dev/null
+  prog="$2"
+  sym="$3"
+  if ! perf record -o "${file}" ${prog} 2> /dev/null
   then
     echo "Workload record [Failed record]" >&2
     echo 1
     return
   fi
-  if ! perf report -i "${file}" -q | grep -q "${testsym}"
+  if ! perf report -i "${file}" -q | grep -q "${sym}"
   then
     echo "Workload record [Failed missing output]" >&2
     echo 1
@@ -53,14 +66,16 @@ make_data() {
 
 test_two_files() {
   echo "Basic two file diff test"
-  err=$(make_data "${perfdata1}")
-  if [ "$err" != 0 ]
+  ret=$(make_data "${perfdata1}" "${testprog}" "${testsym}")
+  if [ "$ret" != 0 ]
   then
+    err=1
     return
   fi
-  err=$(make_data "${perfdata2}")
-  if [ "$err" != 0 ]
+  ret=$(make_data "${perfdata2}" "${testprog}" "${testsym}")
+  if [ "$ret" != 0 ]
   then
+    err=1
     return
   fi
 
@@ -75,19 +90,25 @@ test_two_files() {
 
 test_three_files() {
   echo "Basic three file diff test"
-  err=$(make_data "${perfdata1}")
-  if [ "$err" != 0 ]
+  ret=$(make_data "${perfdata1}" "${testprog}" "${testsym}")
+  if [ "$ret" != 0 ]
   then
+    err=1
     return
   fi
-  err=$(make_data "${perfdata2}")
-  if [ "$err" != 0 ]
+  ret=$(make_data "${perfdata2}" "${testprog}" "${testsym}")
+  if [ "$ret" != 0 ]
   then
+    err=1
     return
   fi
-  err=$(make_data "${perfdata3}")
-  if [ $err != 0 ]
+  # The third file is recorded with another workload, so that the
+  # baseline-only and order option checks below can tell which entries
+  # are shown and in what order.
+  ret=$(make_data "${perfdata3}" "${testprog2}" "${testsym2}")
+  if [ "$ret" != 0 ]
   then
+    err=1
     return
   fi
 
@@ -100,8 +121,189 @@ test_three_files() {
   echo "Basic three file diff test [Success]"
 }
 
+test_options() {
+  echo "Diff options test"
+
+  # delta-abs is the default compute, so a plain diff prints the same
+  # header: pin it here, the option run below then only checks that
+  # --compute delta-abs is accepted and still prints its column
+  if ! perf diff "${perfdata1}" "${perfdata2}" | \
+      grep -qE 'Baseline[[:space:]]+Delta Abs[[:space:]]+Shared Object'
+  then
+    echo "Diff options test [Failed: default compute is not delta-abs]"
+    err=1
+    return
+  fi
+
+  # Every compute formula prints a column of its own
+  for compute in delta delta-abs ratio wdiff:1,2
+  do
+    case "${compute}" in
+      delta) expect='Delta[[:space:]]+Shared Object' ;;
+      delta-abs) expect='Delta Abs' ;;
+      ratio) expect='Ratio' ;;
+      wdiff:1,2) expect='Weighted diff' ;;
+    esac
+    if ! perf diff --compute "${compute}" "${perfdata1}" "${perfdata2}" | \
+        grep -qE "${expect}"
+    then
+      echo "Diff options test [Failed: --compute ${compute}]"
+      err=1
+      return
+    fi
+  done
+
+  if ! perf diff -F "${perfdata1}" "${perfdata2}" | grep -q "Formula"
+  then
+    echo "Diff options test [Failed: --formula]"
+    err=1
+    return
+  fi
+
+  if ! perf diff -p "${perfdata1}" "${perfdata2}" | grep -q "Base period"
+  then
+    echo "Diff options test [Failed: --period]"
+    err=1
+    return
+  fi
+
+  # -b keeps the entries matched in the baseline: with two files of
+  # the same workload the loop entry stays
+  if ! perf diff -b "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
+  then
+    echo "Diff options test [Failed: --baseline-only drops common entries]"
+    err=1
+    return
+  fi
+
+  # The noploop workload is only in the third file
+  if ! perf diff "${perfdata1}" "${perfdata3}" > "${diffout}" 2> /dev/null
+  then
+    echo "Diff options test [Failed: diff of different workloads]"
+    err=1
+    return
+  fi
+  if ! grep -q "${testsym2}" "${diffout}"
+  then
+    echo "Diff options test [Failed: ${testsym2} missing from the diff]"
+    err=1
+    return
+  fi
+
+  # and with a second file recorded with another workload its entries
+  # have no match in the baseline and disappear
+  if ! perf diff -b "${perfdata1}" "${perfdata3}" > "${diffout}" 2> /dev/null
+  then
+    echo "Diff options test [Failed: --baseline-only]"
+    err=1
+    return
+  fi
+  if grep -q "${testsym2}" "${diffout}"
+  then
+    echo "Diff options test [Failed: --baseline-only shows non-baseline entries]"
+    err=1
+    return
+  fi
+
+  if ! perf diff -t, "${perfdata1}" "${perfdata2}" | grep -q "Baseline,"
+  then
+    echo "Diff options test [Failed: --field-separator]"
+    err=1
+    return
+  fi
+
+  # -o 0 puts the entry with the biggest baseline first, the loop in
+  # the first file, while the default starts with the loop in the
+  # second file
+  if ! perf diff -o 0 "${perfdata1}" "${perfdata3}" > "${diffout}" 2> /dev/null
+  then
+    echo "Diff options test [Failed: --order]"
+    err=1
+    return
+  fi
+  if ! grep -v '^#' "${diffout}" | grep -v '^[[:space:]]*$' | head -1 | \
+      grep -q "${testsym}"
+  then
+    echo "Diff options test [Failed: --order 0 does not sort by the baseline]"
+    err=1
+    return
+  fi
+
+  # A window starting at the beginning of the data shows it all, a
+  # window starting after the last sample shows nothing
+  if ! perf diff --time 0, "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
+  then
+    echo "Diff options test [Failed: --time]"
+    err=1
+    return
+  fi
+  # 9999999999 is beyond the recording's timestamps and, unlike a
+  # 19-digit value, does not overflow u64 when scaled to nanoseconds.
+  # Capture the output so a failing perf diff cannot masquerade as an
+  # empty window.
+  if ! perf diff --time 9999999999, "${perfdata1}" "${perfdata2}" > "${diffout}" 2> /dev/null
+  then
+    echo "Diff options test [Failed: --time after the last sample]"
+    err=1
+    return
+  fi
+  if grep -q "${testsym}" "${diffout}"
+  then
+    echo "Diff options test [Failed: --time shows samples outside the window]"
+    err=1
+    return
+  fi
+
+  # --percentage only shows up when entries are filtered in the TUI
+  # and --verbose only adds debug output, check the table is printed
+  if ! perf diff --percentage relative "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
+  then
+    echo "Diff options test [Failed: --percentage relative]"
+    err=1
+    return
+  fi
+
+  if ! perf diff --percentage absolute "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
+  then
+    echo "Diff options test [Failed: --percentage absolute]"
+    err=1
+    return
+  fi
+
+  if ! perf diff -s comm "${perfdata1}" "${perfdata2}" | grep -q "Command"
+  then
+    echo "Diff options test [Failed: --sort comm]"
+    err=1
+    return
+  fi
+
+  if ! perf diff -v "${perfdata1}" "${perfdata2}" 2> /dev/null | \
+      grep -q "${testsym}"
+  then
+    echo "Diff options test [Failed: --verbose]"
+    err=1
+    return
+  fi
+
+  if ! perf diff --dump-raw-trace "${perfdata1}" "${perfdata2}" 2>&1 | \
+          grep -q "PERF_RECORD_SAMPLE"
+  then
+    echo "Diff options test [Failed: --dump-raw-trace]"
+    err=1
+    return
+  fi
+
+  echo "Diff options test [Success]"
+}
+
 test_two_files
 test_three_files
 
+if [ -s "${perfdata1}" ] && [ -s "${perfdata2}" ] && [ -s "${perfdata3}" ]; then
+  test_options
+else
+  echo "Diff options test [Skipped: recordings incomplete]"
+fi
+
 cleanup
 exit $err
-- 
2.56.0

