Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182185;
	b=oH4+IncRXobbywJKufsBU62PxLxYRFJqX4BYJ7g/BjXvwnka9XmWMys62GULMP9kAJST
	 ya485qBD9D8D/gV+H5ODDyz8DAdZKaWSs5R3GMSVZGz9fZ06/EG1EYQhtmA11PjHBV08d
	 FF+jT65Efu3dE9ruc+3GKT3ldGE+LaxHmfoXpA/rBU3V13ChnJhBNPh88HLGVOHqeKOZ8
	 UPEMHIYIpntLSHjSXtOQQw2DHIuymUepQmkcG8SaYGHXIOp79V/zpkqtPReK2CXYDV3NZ
	 UDYAqjzRB18uOenaL3MCflW56Nt4me5OsJPGW4DLgSu2bi1UlP32rv/hrgwe5/KuKLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cYXD2FWmrnnRZk6eOj0Jj2xBjZH/opG+pmsIgNjn1qM=;
	b=nYprgwW2oZZgl0VaUaf9shJvGh2RamX2UwTCkjsQ/jCs+2T5lGMq9cHRAL0ICYi2Qi43
	 DV0DAO7HD/YZPxFmhP+USp5mUUYvNThcijv1oaN6Joz+RFpYswugoRdUvYaF9ZxqEk8Ai
	 HqqFUKL8M1E57XfKpQRS8OzMarrQSH4YSLientHupp46Cl2oznT0On/23PVzNXWj9Oaxv
	 FYMcp0CBCGEOne9ie4umIUwF7tPbUGHbAPQH2sDUK46vc45CAEB5gXKinLeiubrUHBh1c
	 EL2C+9f6VZku4yydxIzeXLcN0I86Ah8y4FLUwEc0Qy4w9S8ovqSPuCc+9w0Q0hyDexQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWMOhzPc;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281F60A2600
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 13:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F281F60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWMOhzPc
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so2397838eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182183; x=1795786983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYXD2FWmrnnRZk6eOj0Jj2xBjZH/opG+pmsIgNjn1qM=;
        b=fWMOhzPcYN0UpLMPegxJSOPZR1y33brbSICxb79t0XSxcz7Rn1I5DvxrS9W4GL0dxf
         LPbq+RyVjBQfn23lJYx3GGBzPzvnhyhm7aC9I8Om9vT/WUIRjw/Ejb3GWBLorimx9Zzf
         A8d4qbyGn9SnNJEuONtuC9+S9qwhH7irx7W0ECh8ANXEcJxxHvtRbUwU2Lr7TLRTuHd1
         rYDx+qJzHnRR6j6J1l6tvRkGEZfnVHv0uw31frMqGDQDstwqa97L2OFv1BZD+xJf2BdI
         XaYSZxw5IHaS70Hs8hZq9EjmCPT/iDPMf5UP6XrHDRzyL43+zy0ZtiOAsEvPr3dsIO2h
         hCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182183; x=1795786983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYXD2FWmrnnRZk6eOj0Jj2xBjZH/opG+pmsIgNjn1qM=;
        b=T2rM41auoDLt/an/1KwzZeZWBWRAJvLEq7G0BFKm+c3WGnPiPcpmVgGfq3d0lOH6F7
         +UeRJY0OC9LzVbbkjLIGFYqi3nfZ5l8MrWkxB53Io2mvmnn+EZgyLn4vCiq0dF00//ol
         7hn/K7G9lRR16zjDR/zu6FDMHTwhkPMuBMg3T8TbYV7ojQcVCXuRDrYtBTy2pa4e23yV
         rzenU+t/YOhZWVDkre/WAoP+Gp2rwrAJqsnVYrXappt6F0/lvUoGMjEciQXpUATIfi+R
         ZLuFpCfQhGx8QskkFNguG8TaIM6Df1ouCXQ+yY2XYeiF2FJvWIKvfhHG682TOF0K3LI5
         Esag==
X-Gm-Message-State: APuU4Z+kRKULx+HQV2dzQtJCFu98nfl9CnbI0RjTS8LGSvH2tn1H/AIP
	expFqWNeG6woa2OR7iie8wIlsFL/wJrB3QwiZ+ZtmUoaDTl9R5gIatJutXDd+PB1
X-Gm-Gg: AYBFou0erbM3znCsagVncADEIdM3rrzeNYhFyDGE/hxJMaJhW9NYoY2TjSVbXJ7wrtI
	ws70Ogp6VUofT+DvQmRwBBZ9+PFllJgyqsPZW836wmeXuJsq2jYC1KsxzNy8uZ/8lBfgZM8PU9V
	bac5Wtehnsqo/Mc1/Yc3o44WroD/cbVAgF6j8FSIAViLM9mCmCSVi/BVLhfHPfx8JxsAm2VOrIg
	WkLPa88sKXtD//j8NKS4eney+o0lMocaAr2ZChz8IFsY35F5OYw0oCpBJs/jVBzaWf+19qpuQ0X
	JyWZ8tfVZLT7c/bpRiP6vr8Du4NCkobIm76H/JATCt0q1oqtdaGyS+jvrJrL1O7Yckb4qqSz3SE
	o95FZ6+rr2KuVYaJUMn5yFc1Mvrf5PuErrSEXAa6SM5JjBuf+K8LW1NcF6/JxxfErq7ozkefT0y
	Ln+0nzCqyNQoh9izdkzpbvGaP9pzM4DjUFpUfZ+woupuSE1ccPx5QcW5gXSTnCgePqfr4qWpU1H
	M6wmLz61hN4qOaEBBh9gmSUvoQXbDCSg9gpx1S2K7QmyirSslAhC+OLgcDYyFaNmkDcosZZk8Rn
	sRZE5mV0KIjry+IUklQC
X-Received: by 2002:a05:7301:d805:b0:385:ce95:2e14 with SMTP id 5a478bee46e88-385ce953221mr2127751eec.30.1795182182938;
        Fri, 20 Nov 2026 05:43:02 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm9590857eec.28.2026.11.20.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:43:02 -0800 (PST)
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
Subject: [PATCH v12 2/2] perf jevents: Fail the build on a key the tables may not carry
Date: Fri, 20 Nov 2026 13:42:52 +0000
Message-ID: <20261120134252.1036963-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120134252.1036963-1-takano32@gmail.com>
References: <20261120060931.711483-1-takano32@gmail.com>
 <20261120134252.1036963-1-takano32@gmail.com>
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

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran the generator on every arch directory, with and without a key the
tables may not carry.

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

