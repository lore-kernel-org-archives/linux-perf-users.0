Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB422F6919
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799602; cv=none; b=X6m2mnbul1kS4UqxKR5NX5X7dUf81HSmnvzlmh7PhqgPqLf2Um3I2zNggnx8jCs5Rcsn2EzrIU3of3TkBg9vsHxihOe3ITTzd9L4CHdPOgkOVWlr4OVmrEDsRP/bpzRwsFs1mfmyic2EP9MK1k5ToIdZKi9oPDY18NsBiWIRGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799602; c=relaxed/simple;
	bh=rm1IqrKBPHLzJkcMCtYYI8jd1FLWutvG90VSMPspXtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e8RYEW0EQVsHaPPX/1WlQYzg2KgBQtMfQaNdfO7RAExarZw2i8uuNuw6GYP8MDLUK8DaKoCCox5ww+IgUC+f4vvm0aqUZ9f4chxC8C1rz/amxCt7oVtVUg/uxyOxDaGDVBkgFSaoy1z5OFquPyHru2FnRDLqWuY7ny0/Hmd8Jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3xk5U47; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3xk5U47"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so2638662a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799600; x=1764404400; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGR4BXI5WcGpKIWk+D2mRg8n/v4+474MDwz+X0FyE40=;
        b=G3xk5U47A2JsIkp2AMxFOC2GRi8q2e5qRg+9Qi7DTK2w/r+XxkKk9UmzM7NSQXR+bh
         5s1urlp3Bti5i9p0BIKDEcqWrwcPgE6AjnSK/4Uqvn/fWuF2XdQghcjblqWdu0wju6G9
         xvsgvtlVRmJ0BQp5BDeLOvNFdp3uTIaum3UEIPCdqK4kyjR3zp8ZnM7UruvHxBkJ9z1o
         8nCX5HO1eOi2sqHMs9Xm/YiQnrU4t/7CFLuayR8mRy7jPSMZaqlYddog6MqrUZt5Eg1b
         bvFjmNBKyDmes2yVMpe+7nBwKQoBTTwo45MJcG1ckQ7K3ppaDXuwdLXuuszEn+lfJNdW
         Rdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799600; x=1764404400;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGR4BXI5WcGpKIWk+D2mRg8n/v4+474MDwz+X0FyE40=;
        b=MjpWfhpeecLJHq81C976OAdzaaauvM4C/fLNcr6J4oqWMWI+CU6EAOe1Lg9nP/PgAE
         C9Lo+ycSNtGENcKDJbdiwZDv5zljtP/+GMXjq7wOBtj7PgD6r5XvZBdKoVeny/47lr4x
         K3xfz8wiHXUjTaltk2rW7cLNWYZ/E5uVb0LbMTIfWia8e9WijNs4iBxo7B3YYT+17DE/
         +ZjRr4g6DIUUouTabhOyJ/CPgUMAhtytThoWC6HygjDhIYT6taa3pTnBzXD81E5iGlSD
         JdEBf15vYrcs1ShcW/YhI/dD0+wz3N7SbA6pSQKWFjqTyGxN+JbI5W076gMaQJKfHUAb
         DF6w==
X-Forwarded-Encrypted: i=1; AJvYcCVpedSEcp2WmPFJLQWPFPpWeskw/OmQKx+YJqBsx2pNiF22G75kL1PUc2eMVF029yHwIO5fc9xwcyXnJSqKcrra@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr63vnic+Ptvx3SgOyJ1HzpLiLMQWr5+SyxLP8i2wSvMtzicBp
	sbFARzeMZz5V6xegBx910Ksd1TqkIKp7xYlR560yKInMqPWzKTWyq/EvvzP52Gya8mVdjYyvlg0
	cDiztOwNXjw==
X-Google-Smtp-Source: AGHT+IFwXD0UPsR32BV1vhsitlbMopKgA+delZqUK7OlNd63rhYZA7+H0e0oSXCCw0pVxEMPrNNFg8+wDt/t
X-Received: from dlbdx41.prod.google.com ([2002:a05:7022:e29:b0:11a:3780:4b65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8085:b0:2a4:874c:ba92
 with SMTP id 5a478bee46e88-2a7192d457bmr2103902eec.36.1763799600458; Sat, 22
 Nov 2025 00:20:00 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:25 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-14-irogers@google.com>
Subject: [PATCH v1 13/17] perf tests timechart: Add a perf timechart test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Basic coverage for `perf timechart` doing a record and then a basic
sanity test of the generated SVG file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/timechart.sh | 67 +++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/perf/tests/shell/timechart.sh

diff --git a/tools/perf/tests/shell/timechart.sh b/tools/perf/tests/shell/timechart.sh
new file mode 100755
index 000000000000..b14b3472c284
--- /dev/null
+++ b/tools/perf/tests/shell/timechart.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# perf timechart tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_timechart_test.perf.data.XXXXX)
+output=$(mktemp /tmp/__perf_timechart_test.output.XXXXX.svg)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${output}"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_timechart() {
+	echo "Basic perf timechart test"
+
+	# Try to record timechart data.
+	# perf timechart record uses system-wide recording and specific tracepoints.
+	# If it fails (e.g. permissions, missing tracepoints), skip the test.
+	if ! perf timechart record -o "${perfdata}" true > /dev/null 2>&1; then
+		echo "Basic perf timechart test [Skipped: perf timechart record failed (permissions/events?)]"
+		return
+	fi
+
+	# Generate the timechart
+	if ! perf timechart -i "${perfdata}" -o "${output}" > /dev/null 2>&1; then
+		echo "Basic perf timechart test [Failed: perf timechart command failed]"
+		err=1
+		return
+	fi
+
+	# Check if output file exists and is not empty
+	if [ ! -s "${output}" ]; then
+		echo "Basic perf timechart test [Failed: output file is empty or missing]"
+		err=1
+		return
+	fi
+
+	# Check if it looks like an SVG
+	if ! grep -q "svg" "${output}"; then
+		echo "Basic perf timechart test [Failed: output doesn't look like SVG]"
+		err=1
+		return
+	fi
+
+	echo "Basic perf timechart test [Success]"
+}
+
+if ! perf check feature -q libtraceevent ; then
+	echo "perf timechart is not supported. Skip."
+        cleanup
+	exit 2
+fi
+
+test_timechart
+cleanup
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

