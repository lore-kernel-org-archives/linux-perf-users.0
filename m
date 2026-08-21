Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2C472F87
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305802; cv=none; b=tEPEiJXNhQmJe7qlTPFQ2WZlehUKWo920Q+WqCivEM/gPphX75qrG6JyCgolQk0I3Tg4kjAGu/ZTlslFrFZ50OaiqMdzRMNPbvMXd6L98ACQmX77TWIFcAXUqEhBXt4yZsOSe/2PH68HMz3HWF/OOXHCmZpr9N0eL0Qo3u+YVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305802; c=relaxed/simple;
	bh=45ewM2dvFaY12LY151swUHBTvievnc3sust8Ep02uoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWAsqSkTGX0zDiIrVUwVzJ6XismzeHEKyxxw9q9QosPKQkI34egOCudGeVAKfzR5jr7bZzs0EyY/5xyjsdIn3ZtDr3wQ8Ak5SEtvmekr9su5FlHcBW+p+SDZ7ltATk0mbET4Q/O1lkMtsR2lIgEATZ0AcpcWJ0ta1Qoj/6n4EAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RfttxknL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfttxknL"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso399080f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305785; x=1787910585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghssS34122+SF9JGQaRPjJsmiH0qvioNjK1NWp3olSk=;
        b=RfttxknLuTZt2Qr2BtWUT3atEqCHAqw/Kv7RKtHnY/+qIU84Zu5F5Dh80192T7cCVL
         2pxI1RM+McHyqNi2AAJbuESxWxi8cO7LcyLZfqrjgDZ7j5/s5q0M/SW8vNJm23o0eSFd
         0bM5WO76hYjOHcaeVznou36UFTGx9dxW5sNYPFpF8pLR/kPjzUJWB7PcBQTv6xVy1e/o
         oos/aItt3jG7nDxA+RPrMJSCt5Jg9IgFjsisZ7iUx78ZbLSVVeCRvu9Y+T/fr0ssYOoJ
         hM6hULoeJsruVz9ebMTSkfH6iyQm/9OuBDA2mLnAm/BfChtDIC6gCme69mNqh8K2X+jw
         UmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305785; x=1787910585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghssS34122+SF9JGQaRPjJsmiH0qvioNjK1NWp3olSk=;
        b=i65wVijefk3tWh9PfuogDGjkkeV9zpqO7GazVrha2lLUAYf4+H2jDJ+XSFAFKop00L
         TQa9UNdGJDZKto/BVxED02Z9RnZFWB60Ann6+bzP8eCk/UJyrHeCI0j6Nd1n3vNDApnH
         4gHB2H3jym0Qb5mx8ntppQvkV9qfdVFNX7z3n0lJjbeDZE7IoAV8JJBHihtiSK0arDY8
         Dty/Vnidexp5BH64EMfyjttIKK507FED6e+17me00HVyz1QuTX2MruIyJgR438djm8nV
         8Mg4cNJ7aTSZZzDNN518TvMR972kBzXza5aXe0hZAeM9STTFj5InR9XpTXlWwDk6GnHz
         r3Fw==
X-Forwarded-Encrypted: i=1; AHgh+RodhslDR+AFjLYo7fl1VD22ilR7nQ2AR5iH7CuQJ/jWIs7jsAE0W8JSZ6KahvTGmyaYUO0h/4ZFmihgK2fFh38D@vger.kernel.org
X-Gm-Message-State: AFuF++lyv2ABjFQoccOW78deMYTG9R58CP/93/QvJxjnCO/d1fxwdRhn
	Fy/6DfEB+TdqDCqjon52pnHKHqx/ZgbTGYwkW8MVd0mBprqDTgBX8JII7Y+iaf79twg=
X-Gm-Gg: AR+sD120tn+Ua4cvjGJMgVwAOkC7l30fq42S8KYXkCWIZU0Q9vPDwBFbW1rDPIcvwqu
	+TPODoHAES2rj+aGjoCwVKBWhaKNcJX3bupXrS754WxHPAEcOI2eFHj9x2NRTfdYa7sG5TrIJnr
	7gLBPSqyotaCmR4qi/0xChT59N+/R1c/bMFrw7HdFrwQ7iqaNOsFdF5bap06oCPuz+Lw9k1oZ1L
	CK1otH16DkCZ9v24zYEkCDAg/jfa+LFBfJrAOap6zW/OnipBFs95ZRPnTrlaGIt3mHQ5IJkP48/
	QUxuTky2B6Al1vIbDzgXtWx9mIB6ymgRqFhXV0aNQXK/WmjDaPrIK4V3FmO//4ZkX4ZGpsDpCk/
	/2/bH/Y35Gzb1l3IwNDvF06zpG3WMBil8A62deina7vxrXYjZdFkl0NQBwVvbNCsCYZ1y/20ilc
	oIgTqJopczai/gjVogLi0WOqug0if37iUuC/joFyP6vqb91QMZQ7RCjW+jvHhgbunLjKCQOZ3ts
	8s=
X-Received: by 2002:a5d:5846:0:b0:481:3124:c71f with SMTP id ffacd0b85a97d-482c0b907camr6412779f8f.17.1787305784814;
        Fri, 21 Aug 2026 02:49:44 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:12 +0100
Subject: [PATCH v2 14/14] perf cs-etm: Test multiple per-thread threads
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-14-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Launch something that has multiple child threads, attach to it and
make sure that all child threads are present in the samples

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/tests/shell/coresight/per-thread-multi.sh | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools/perf/tests/shell/coresight/per-thread-multi.sh
new file mode 100755
index 000000000000..ea525ed5e18b
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/per-thread-multi.sh
@@ -0,0 +1,78 @@
+#!/bin/bash -e
+# CoreSight per-thread multiple threads (exclusive)
+
+# SPDX-License-Identifier: GPL-2.0
+
+# If CoreSight is not available, skip the test
+perf list pmu | grep -q cs_etm || exit 2
+
+if ! tmpdir=$(mktemp -d /tmp/perf-cs-callchain-test.XXXXXX); then
+	echo "mktemp failed"
+	exit 1
+fi
+
+cleanup_files()
+{
+	if [[ $parent ]]; then
+		kill -9 $parent
+		wait $parent || true
+	fi
+	if [[ $perf ]]; then
+		kill -9 $perf
+		wait $perf || true
+	fi
+	rm -rf "$tmpdir"
+	trap - EXIT TERM INT
+}
+
+trap cleanup_files EXIT
+trap 'cleanup_files; exit 1' TERM INT
+
+# Launch 2 threads to run indefinitely
+nthreads=2
+perf test -w named_threads $nthreads 0 &
+parent=$!
+
+# While parent still exists, wait for the 2 children to spawn
+while kill -0 "$parent" 2>/dev/null; do
+  threads=(/proc/"$parent"/task/*)
+
+  if (( ${#threads[@]} >= $(($nthreads + 1)))); then
+    break
+  fi
+
+  sleep 0.1
+done
+
+echo "Recording..."
+perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -Se -m,64K --pid $parent > /dev/null 2>&1 &
+perf=$!
+
+sleep 1
+
+kill $parent
+wait $parent || true
+unset parent
+wait $perf
+unset perf
+
+echo "Decoding..."
+perf script -i "$tmpdir/data" > "$tmpdir/script" 2>/dev/null
+
+# Exit early unless there is a dedicated sink per core which only TRBE
+# guarantees. This is because shared sinks will report BUSY if two threads try
+# to use them at the same time
+if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
+	echo "No TRBE sinks, skipping output validation"
+	exit 0
+fi
+
+# Check all threads were traced and they have the correct thread name and symbol
+for i in $(seq 1 $nthreads); do
+	if ! grep -q "thread${i} .* named_threads_thread${i}" "$tmpdir/script"; then
+		echo "Error: thread${i} missing" >&2
+		exit 1
+	fi
+done
+
+exit 0

-- 
2.43.0

