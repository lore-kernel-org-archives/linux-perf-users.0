Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958C2FC019
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799606; cv=none; b=OYlL9izmE5QpmdvC4GEMZmwENs7wfWNNSS7S/U+P1MI+rgBYQpcaDqXivBXLcSp3Byhdq6sSg1tTOB5JE6/qHHyeWQyacWrwQV5dlOJGMC6r1ug2QiaqNmDZOwKFb7nFlomeBhzP6/0lud4ekxvacQiRxWUXz3t+vdsKoEaO6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799606; c=relaxed/simple;
	bh=fmBkDqhx1PttP/dB41nn3oTLi+QWzIEgzUqcslYwQqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EfWqN4kuyc9XRr6U2Rz+Ows/9b9DRJh9Zer0Pko7ZP4aWMIHo3wpglG10vQ7/9sTx4SrTXo/HAUmRmyS+gojxjejyY1bAfd19PnXCt2TAepDzXOPKIl3Soz7dN8Z20/Xgggo+LMU4VAeS02oPOdDi6p42uWp1Gut/oM9TurJsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nk8F0XFl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nk8F0XFl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so2654312a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799604; x=1764404404; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qagIg4uAZrdvXdo5hL885MqntgeUFGla68aYQTHhYq0=;
        b=Nk8F0XFlEbBgMTTIjOP//Ho/leXPGOeKhu2cZjsrKTqyDHTHqfJDelRSnKjHLvZaZS
         rtnnmXxc2rTQDse4jT9ul+Ig8r2VS8FCC0jeNvwBMK1MNz1CQ5WuGozNQEbRigOmqvbD
         s1dRJvTvijm/yuxlEng9jSSyU7EkeQMrVgXZU1qtR4ArxF4aHL/sUJILJKHKvp07sc+t
         FW5adExOqWYp0FLXOsHQsS1BstRsgn3aJYWPAwmz1iGp5EuwPxpwKkLrBzyW2RLDVMgM
         CIf0kuRLyGd93nu9IsluIxJmwzB6lFjF2p/HDZf1WFmFU0/MnNH7PKMrEIFYeIRd1x96
         S6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799604; x=1764404404;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qagIg4uAZrdvXdo5hL885MqntgeUFGla68aYQTHhYq0=;
        b=J5fkaehsSldAwBbeXM6xefwUq9bLuL5h9GXfpc2sqqPJAz9GeySFx+IlWdt4GOfk2q
         BB0PjpzzZ4+9n2+ybZOqW0vPgFWvJc4Xx1rVU1wfOQAaFU5Rqs0Np5EpQmR0K6rup6v2
         TPJOLOwTLpuQ4YRJ8AsaIo3hJL9sgteL+PMu/pnQyJ9ZnifwvtWV2SnJRDSIBNP9Y1sm
         OvOyXW5BHviOinGhSmFCclTuZCzJYNK/86f1HFSlcHJbdcchBROhZadjBlx7k72Le4vJ
         AaLSCAf8nXGAL2YZ2um2bt9nRhkbPucbHZtH1ccpbWsVz2xiMMl7UcGTS08AGa31jtuq
         CZSA==
X-Forwarded-Encrypted: i=1; AJvYcCUZPZGLmLK2JgSLoq2hKJZNPspH2wv4PdXEIPTFZTLtMmD+4yItwxtVZ3i1XyMNtID0njC2Mylst7Jj8hi6elT5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GpRZg/IZ3zG4zXyl6muz8V5dyOv+TjpSNJvYfu6G1g+aDg8T
	roF3RNFnfl3xLtLBJVspjrHhQwAvkWhG1MvJtJTPeDVqqdzpu6TIXtwBt32e/IjQImB4m4sNMvv
	vgAjnJGLzmg==
X-Google-Smtp-Source: AGHT+IEt4dH04AqO+CjXIyoe+uYefmSRa8ceQS06YbtdgWzSj0GX2or7oPfZlPna9E6bEu5iEskG4hp2bqz1
X-Received: from dyt23.prod.google.com ([2002:a05:693c:8097:b0:2a2:454c:f92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d198:b0:2a4:3593:466c
 with SMTP id 5a478bee46e88-2a719098538mr1676208eec.8.1763799604030; Sat, 22
 Nov 2025 00:20:04 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:27 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-16-irogers@google.com>
Subject: [PATCH v1 15/17] perf tests script dlfilter: Add a dlfilter test
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

Compile a simple dlfilter and make sure it remove samples from
everything other than a test_loop.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script_dlfilter.sh | 107 ++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100755 tools/perf/tests/shell/script_dlfilter.sh

diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
new file mode 100755
index 000000000000..45c97d4a7d5f
--- /dev/null
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -0,0 +1,107 @@
+#!/bin/bash
+# perf script --dlfilter tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+dlfilter_c=$(mktemp /tmp/__perf_test.dlfilter.test.c.XXXXX)
+dlfilter_so=$(mktemp /tmp/__perf_test.dlfilter.so.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${dlfilter_c}"
+	rm -f "${dlfilter_so}"
+	rm -f "${dlfilter_so}.o"
+
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
+cat <<EOF > "${dlfilter_c}"
+#include <perf/perf_dlfilter.h>
+#include <string.h>
+#include <stdio.h>
+
+struct perf_dlfilter_fns perf_dlfilter_fns;
+
+int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
+{
+	const struct perf_dlfilter_al *al;
+
+	if (!sample->ip)
+		return 0;
+
+	al = perf_dlfilter_fns.resolve_ip(ctx);
+	if (!al || !al->sym || strcmp(al->sym, "test_loop"))
+		return 1;
+
+	return 0;
+}
+EOF
+
+test_dlfilter() {
+	echo "Basic --dlfilter test"
+	# Generate perf.data file
+	if ! perf record -o "${perfdata}" perf test -w thloop 1 2> /dev/null
+	then
+		echo "Basic --dlfilter test [Failed record]"
+		err=1
+		return
+	fi
+
+	# Build the dlfilter
+	if ! cc -c -I tools/perf/include -fpic -x c "${dlfilter_c}" -o "${dlfilter_so}.o"
+	then
+		echo "Basic --dlfilter test [Failed to build dlfilter object]"
+		err=1
+		return
+	fi
+
+	if ! cc -shared -o "${dlfilter_so}" "${dlfilter_so}.o"
+	then
+		echo "Basic --dlfilter test [Failed to link dlfilter shared object]"
+		err=1
+		return
+	fi
+
+	# Check that the output contains "test_loop" and nothing else
+	if ! perf script -i "${perfdata}" --dlfilter "${dlfilter_so}" | grep -q "test_loop"
+	then
+		echo "Basic --dlfilter test [Failed missing output]"
+		err=1
+		return
+	fi
+
+	# The filter should filter out everything except test_loop, so ensure no other symbols are present
+	# This is a simple check; we could be more rigorous
+	if perf script -i "${perfdata}" --dlfilter "${dlfilter_so}" | grep -v "test_loop" | grep -q "perf"
+	then
+		echo "Basic --dlfilter test [Failed filtering]"
+		err=1
+		return
+	fi
+
+	echo "Basic --dlfilter test [Success]"
+}
+
+test_dlfilter
+cleanup
+exit $err
-- 
2.52.0.rc2.455.g230fcf2819-goog

