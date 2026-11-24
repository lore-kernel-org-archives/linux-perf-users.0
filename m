Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545996;
	b=siOV0iMxMNH7onF0a3gqCDYKwSV7s+mjk5TJeZ5mv+gTe6IQdjxomkk8OSWl8GTZ3Vp/
	 2fv6jYneQa+yoZuMNPerULzn0RGPR4jUOq6+3BZ/W3uDEeVWNe4LUbRjiyHJEOomkYVtx
	 88sZlCVtO6TPqDZI8D7+TnPbl4JRr4Jgyq1RACb1VBX0NzUs9IbWUJmDfxG9MF0FO9x4L
	 gw5/r6n+BW9U20ub2HhGBOXdNuSHEwCXuLywyKLByZQU0vG/9+S5HzlSfMzoj1C0niMWi
	 UWGDyCm3qtHqHjqj7qYbUmBPQ1d2tqAhMQQd0L2+sUSo5pNuCYpjKqi+fD5krPX9iXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J4HOAwRWZ2T7aeMHrNI8QgoOb/3uRqSNgQrOW58ToxM=;
	b=zmWxT1IMcBd5hpLxVGlfx8HpcDWfngfk7w/BHOHFzCi2nrJt+NGNUYl54Q56McDUCw80
	 0O1vpHItm0TYP+7rVGoMRcLfF7aDvSNZpJqRehhR5VAdd9E3vKiJEAEqmbaA6MC/m7EAz
	 eYXn7cnaSFmQHU6FHowV9oQOOLQXl6fyqvP6Rsv9tvmF790xLWcX97Ai3BjeOp9Ke//hs
	 u4AoACtiasDz4KRvCridKxjyuInddeDT1rZzeE8s0MHE7t8XUkzqqBAPI9BnpZyHdiYcP
	 pXBq+44YfE/YdmRtzpsmLB0hWJWx5gIzbyqA/QMC3Ju2WBopBp1QtmZtP/6pLQGtOKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMh0Fy3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F6606A329;
	Tue, 24 Nov 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMh0Fy3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F81F000E0;
	Tue, 24 Nov 2026 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545996;
	bh=J4HOAwRWZ2T7aeMHrNI8QgoOb/3uRqSNgQrOW58ToxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMh0Fy3S/R/Jnwd9YBFynt58aFXlTJgunlPEoO+QFVETs7s0/SzhEp+PBknTsfqNO
	 QIQh6asBNmfi9HK/hEj3xoB918UGdqCdTGCE2v9eb7jVgIDBwX8Eo7lUdO8dYB03pQ
	 0LoK889p2O5k7EpkD+LzjLapQ2y9vF+wheJQUnlrBf97VpcCGO50O2o4qoKEFiXie1
	 SWt/KLTy/wGsOl4VTBzvUxxp4EPhvLuGDBc6x6352qFaroV/2DpFxw+NX0W14bTB0d
	 UTfOuqPZVgibx+60o7+36jD9kWHq/CSxMMikU3IrBY/zN1+kCbWI5k6+UjRMJw5nvS
	 awotOTUZWweSQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 07/17] perf tests diff: Exercise the output options
Date: Tue, 24 Nov 2026 15:45:54 -0300
Message-ID: <20261124184604.24983-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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
 tools/perf/tests/shell/diff.sh | 191 +++++++++++++++++++++++++++++++--
 1 file changed, 184 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
index 88f37b8ef8936be4..d2fbc8a8c2c3680a 100755
--- a/tools/perf/tests/shell/diff.sh
+++ b/tools/perf/tests/shell/diff.sh
@@ -8,14 +8,18 @@ err=0
 perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+diffout=$(mktemp /tmp/__perf_test.perf.diff.out.XXXXX)
 testprog="perf test -w thloop"
+testprog2="perf test -w noploop"
 
 shelldir=$(dirname "$0")
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
+testsym2="noploop"
 
 skip_test_missing_symbol ${testsym}
+skip_test_missing_symbol ${testsym2}
 
 cleanup() {
   rm -rf "${perfdata1}"
@@ -24,6 +28,7 @@ cleanup() {
   rm -rf "${perfdata2}".old
   rm -rf "${perfdata3}"
   rm -rf "${perfdata3}".old
+  rm -f "${diffout}"
 
   trap - EXIT TERM INT
 }
@@ -36,13 +41,15 @@ trap trap_cleanup EXIT TERM INT
 
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
@@ -53,12 +60,12 @@ make_data() {
 
 test_two_files() {
   echo "Basic two file diff test"
-  err=$(make_data "${perfdata1}")
+  err=$(make_data "${perfdata1}" "${testprog}" "${testsym}")
   if [ "$err" != 0 ]
   then
     return
   fi
-  err=$(make_data "${perfdata2}")
+  err=$(make_data "${perfdata2}" "${testprog}" "${testsym}")
   if [ "$err" != 0 ]
   then
     return
@@ -75,17 +82,20 @@ test_two_files() {
 
 test_three_files() {
   echo "Basic three file diff test"
-  err=$(make_data "${perfdata1}")
+  err=$(make_data "${perfdata1}" "${testprog}" "${testsym}")
   if [ "$err" != 0 ]
   then
     return
   fi
-  err=$(make_data "${perfdata2}")
+  err=$(make_data "${perfdata2}" "${testprog}" "${testsym}")
   if [ "$err" != 0 ]
   then
     return
   fi
-  err=$(make_data "${perfdata3}")
+  # The third file is recorded with another workload, so that the
+  # baseline-only and order option checks below can tell which entries
+  # are shown and in what order.
+  err=$(make_data "${perfdata3}" "${testprog2}" "${testsym2}")
   if [ $err != 0 ]
   then
     return
@@ -100,8 +110,175 @@ test_three_files() {
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
+  if perf diff --time 9000000000000000000, "${perfdata1}" "${perfdata2}" | \
+      grep -q "${testsym}"
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
+test_options
 
 cleanup
 exit $err
-- 
2.56.0

