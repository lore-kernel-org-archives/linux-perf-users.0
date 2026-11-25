Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579229;
	b=RD4Gkf8nhnKXcJvZo2sIpxJLrLlzxZGjlZzB56YPqtv4oiUeaAAC2F6H0nAhdiYblMIL
	 6LvZAwOEcAD8JPWGJNFaPn4dtlcvFcc7jYnPrrbwgZelu2eLujwZEBCvK2iiSR/4GBZgX
	 c1sdFk+eOG7dBI1GS9+1+0cIQ3XsUneDpRO/SeetDBjQKmd8wZP2ONleKWLiGHz5iNbVC
	 qI90q3BdYHJhWlxN2/LHrzkpgb8bIR0LuNpztyxfL5c5pO0xJnngnE3Vp5U5syvF+Hh4y
	 HHakfDsQD4QThcOOziP4br1SDQvhJywQE1IRKWfTVEoqP6DEtuF4Tk4nd1UfqB6UjZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JHAmRX/r0jGQ38tK1sD0aSaAzLRfe9WNovc4CDTshWQ=;
	b=qsQb+BauYXx1nCiS1mYD8SvOirkkP5yxX5px+i0kd1yKACz+v8uafwDA/JkDS+AJhwnC
	 Fa8Xf0+qtmFN4JzoSjYE8Et1xYAZut0eXAxW47dsElzjYm2m2Z5tU6PY+acvYtn46xEHJ
	 hhvFa41hOC2w5+4KdsOnIS4cMLWNZVp9GVTMttsScxCt3dWTMgCaTdzL0QG7zxS+ei7pg
	 Prw7K7CKTlcgmf903pMqcsmwcHp0uFspNVmveS+TnGQxhMKEEWC/fznG3IzWSFXPeM8jc
	 xm+IX9S4HG4wDqPCCFTshwiy0E+KUTZwlWiiDhFrrHWfXbfiApufzleHKgYPx65kPzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azTs2ayq;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F2606A682
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 04:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252F2606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azTs2ayq
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso6934963c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579228; x=1796184028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JHAmRX/r0jGQ38tK1sD0aSaAzLRfe9WNovc4CDTshWQ=;
        b=azTs2ayqcGGJOwQZg2Z5UfsjopJ1lCasD3A64Gmwp6Bu1mSi5ZZQVXQgQ3kWoPyGR+
         0VzzO4arSJYCvIfxnzy33npdI1bm907lwraamPiJbiapgduHes2yG2bies35bMvPc4++
         8/Oo21FIRN8KfdW2HhiRogkMZ3+m6shwRECXNDt2uOjzcA/ShzbeBa9T6vQilbc4roPF
         tFWczK5XytFl44Tbqw0XF0ScNwyHT+5Kk3jsjsHsdFa43LfiPPs+KjYhjCICD7DiHOY+
         OqGemCt+ul0ZGVoU/7p4eyN98z7ktNX+tHlQbs/wk1z4jA84kvbbPcVwRDUov3qx7DkM
         vqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579228; x=1796184028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHAmRX/r0jGQ38tK1sD0aSaAzLRfe9WNovc4CDTshWQ=;
        b=CA9UCdp53YCpig2GOy5WopslrTJeAeE+i9aTcfbBQRGQ8rlGIDcNuaJQIynrzJxzcv
         daR2O4e15+jzOrSp3DQIN0dxprfJKJuGTU95t6y+sRNb4ZGudPKKR9WYgv3GcPcLHaE5
         O1cklQ/fl5dWISf0M3yCnGiVvNoDPPDrbnug8G80qmUSnT0AoSujEqjAeyec6bCwRCRb
         D3apKa867CCXFNM6e2oUX1cTZD+S4rD9lgEBzgSrLHEvhapYXkagLR1co9ki7jG/1ZqE
         kcKAUAwXAVu+T0n2kLm5/67VBJdjEWzYDjZ9N05BoxianMykbrz5yFSQJkEhJdwsPhMC
         Hz2g==
X-Gm-Message-State: APuU4Z/BqtRBNjcMNLJ8RTRbJ9xOiv6RZRje71naUxr/NzEEhuYOp+6f
	l/q4AAff7zTjsJaMP5KarIpfuIw9rvOFBvRx0/nu2uwrDLXTNSaA7P1jqKru/Yfw
X-Gm-Gg: AZFdTZd7t6i1HettykYTv8nufdwIb0bg7IFaQNnHHILwyT+VKe4KBLiqPExsO6NVnNP
	BE0IEAf8ivHHdWlfNwah3gAetJ87BT2zNtNRb33y/BItxc9zG69z9pvruvY3j4AdXDtzJmrnSF1
	mIFc3sJcsHkQVJucygyGWTT0kNbF/EJ8Mg/Vdi+Q6kEaA2g2QXugf4OODnby1IcPIqQcqRCBS0L
	1GjmrAZoMFwRMNJRTN/DSgCmd13kQ4p0dbWL8z8N7iOGfBshkTUFVqS6Aw9wYsOhHlcSHk4EX0T
	8RiAznnbnE0rRlSfoTP+9fv5ZbnQgN7YdZh1oQtDA8jqawMai8BHPqtBQlXAlZKGcmVyTliGnOk
	jWzacDjrBy4iluaCKl/VOxVERWBYbWVdlq3bteFmT85V23lQxFkmRKcp7UIqhPTiWQRLCk6GqrW
	zHT696gTdyocx+eK7qfo0t8XwvmTju2mc7QgPqsOwVvzBkDuBtq3buU/z5g2OVYZjasPBAzcRPd
	tV4fDYWgBubEBFBlez6UMnQsik4FCCD+2gDzTW1vWoViA5k81uw/XOCQt37fxuPUlnIakjioBk/
	FMeFYK8i+8CLeG25SekxXg1rBcylISKqIINl3944SQ==
X-Received: by 2002:a05:7022:2218:b0:19a:20d3:a3d6 with SMTP id a92af1059eb24-1b57da14988mr6075197c88.1.1795579227824;
        Tue, 24 Nov 2026 20:00:27 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm57094127c88.14.2026.11.24.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:00:27 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v13 2/2] perf jevents: Fail the build on a key the tables may not carry
Date: Wed, 25 Nov 2026 04:00:16 +0000
Message-ID: <20261125040016.1675748-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125040016.1675748-1-takano32@gmail.com>
References: <20261125040016.1675748-1-takano32@gmail.com>
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

jevents.py takes the fields it wants out of each JSON object by name and
ignores the rest, so a key that is spelled differently is dropped without
a word and the object is built without whatever that field held.

Compare the keys of each object with _valid_keys, the keys a table may
carry, and fail on anything else.  The generator already names the file it
was reading and the exception names the keys it did not expect, so the
build stops with a message that says where to look.

A shell test, jevents_bad_key.sh, puts a key the tables may not carry
into a table and checks that the generator fails and names the file and
the key.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran the generator on every arch directory, with and without a key the
tables may not carry.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/jevents.py          | 24 +++++++++++
 tools/perf/tests/shell/jevents_bad_key.sh | 52 +++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_bad_key.sh

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..1baeae76349f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -63,6 +63,27 @@ _json_metric_attributes = [
 # Attributes that are bools or enum int values, encoded as '0', '1',...
 _json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
                          'default_show_events']
+# Keys a table under arch/ may carry.  jevents.py takes the fields it wants by
+# name and drops the rest without a word, so a key that is spelled differently
+# is only visible as a field that went missing; a table carrying anything else
+# is an error.  The list holds the keys jevents.py reads, plus the ones the
+# tables carry and it does not read: Counter, CountersNumFixed and
+# CountersNumGeneric (read by nothing) and Experimental (read by metric.py).
+_valid_keys: Set[str] = {
+    'AggregationMode', 'AnyThread', 'ArchStdEvent', 'BriefDescription',
+    'Compat', 'ConfigCode', 'Counter', 'CounterMask',
+    'CountersNumFixed', 'CountersNumGeneric', 'Data_LA', 'DefaultMetricgroupName',
+    'DefaultShowEvents', 'Deprecated', 'EdgeDetect', 'EnAllCores',
+    'EnAllSlices', 'Errata', 'EventCode', 'EventidCode',
+    'EventName', 'Experimental', 'ExtSel', 'FCMask',
+    'Filter', 'Invert', 'LegacyCacheCode', 'LegacyConfigCode',
+    'MetricConstraint', 'MetricExpr', 'MetricGroup', 'MetricgroupNoGroup',
+    'MetricName', 'MetricThreshold', 'MSRIndex', 'MSRValue',
+    'NodeType', 'PEBS', 'PerPkg', 'PortMask',
+    'PublicDescription', 'RdWrMask', 'RetirementLatencyMax', 'RetirementLatencyMean',
+    'RetirementLatencyMin', 'SampleAfterValue', 'ScaleUnit', 'SliceId',
+    'ThreadMask', 'UMask', 'Unit',
+}
 
 def file_name_to_table_name(prefix: str, parents: Sequence[str],
                             dirname: str) -> str:
@@ -196,6 +217,9 @@ class JsonEvent:
   def __init__(self, jd: dict):
     """Constructor passed the dictionary of parsed json values."""
 
+    if extra := set(jd) - _valid_keys:
+      raise ValueError(f'Unknown keys: {sorted(extra)}')
+
     def llx(x: int) -> str:
       """Convert an int to a string similar to a printf modifier of %#llx."""
       return str(x) if x >= 0 and x < 10 else hex(x)
diff --git a/tools/perf/tests/shell/jevents_bad_key.sh b/tools/perf/tests/shell/jevents_bad_key.sh
new file mode 100755
index 000000000000..6084205b5f4d
--- /dev/null
+++ b/tools/perf/tests/shell/jevents_bad_key.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check jevents.py reports unknown keys as errors (no_mlock)
+#
+# A key that is spelled differently is dropped without a word, so jevents.py
+# compares the keys of each object in a table against the keys a table may
+# carry and fails on anything else.
+
+jevents=$(dirname "$0")/../../pmu-events/jevents.py
+python=${PYTHON:-python3}
+
+# An installed perf has the test but not the generator, and a python that is
+# not there or too old to run it is a skip, not a failure of the check.
+[ -r "${jevents}" ] || exit 2
+[ "$("${python}" -c 'import sys; print(sys.version_info >= (3, 9))' 2>/dev/null)" = True ] \
+  || exit 2
+
+tmp=$(mktemp -d) || exit 2
+trap 'rm -rf "${tmp}"' EXIT HUP INT TERM
+tables="${tmp}/arch/x86/model"
+mkdir -p "${tables}" "${tmp}/arch/common"
+printf '[]\n' > "${tmp}/arch/common/empty.json"
+printf 'Family-model,Version,Filename,EventType\nGenuineIntel-6-97,v1.0,model,core\n' \
+  > "${tmp}/arch/x86/mapfile.csv"
+printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
+
+if "${python}" -B "${jevents}" x86 all "${tmp}/arch" \
+    "${tmp}/pmu-events.c" "${tmp}/pmu-events-string.c" \
+    > "${tmp}/out" 2> "${tmp}/err"; then
+  echo "jevents.py accepted a key it does not read" >&2
+  exit 1
+fi
+
+# The generator says which file it was reading, and the exception says which
+# key it did not expect.
+grep -qF -- "Exception processing" "${tmp}/out" || {
+  echo "jevents.py failed without naming the file" >&2
+  cat "${tmp}/out" "${tmp}/err" >&2
+  exit 1
+}
+grep -qF -- "${tables}/events.json" "${tmp}/out" || {
+  echo "jevents.py failed without naming the path" >&2
+  cat "${tmp}/out" "${tmp}/err" >&2
+  exit 1
+}
+grep -qF -- "NotAKey" "${tmp}/err" || {
+  echo "jevents.py failed without naming the key" >&2
+  cat "${tmp}/out" "${tmp}/err" >&2
+  exit 1
+}
+
+exit 0
-- 
2.53.0

