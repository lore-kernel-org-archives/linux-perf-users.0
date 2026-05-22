Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86771391E4E
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489274; cv=none; b=QkauXcabS6HBk7d3o73EQFNJlCh1JG7KqRbj9H1Pj8JkOJSXm1Qxd3zAXsuTNRua1dHtDFy3DZKPQFpG399poukXZo6TQSObQgagLIuEsVUrS5wer5iJO9EB3ACLt3ANS7lIbnJ2J5sYKeDyZsUlHx3Wbm5mtRZPW88Z22b3dMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489274; c=relaxed/simple;
	bh=tvhSffwPee9SSUcUYA6HQ3/aeT7HT6qFfUHo3kEyz70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nGMLTu5WNlzhjcsJ8d29Rv73zNjtaTn9EseVeGEovP0+ZojBvbxfR3md/QntO06LLtNIFxuKo1WZ49hN5X3ZDH3vJUf4c0hYLdLQihq6b1C4D54UzamFQ4dd5vBW8WV2WkorYFhxnTJzO26+Fr+bAGLIMMKKzY4fwcRAKpSJnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MinXX8f6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MinXX8f6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f2d983d109so4384785eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489272; x=1780094072; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVqEIj3RzCuef4mURYGhNpGwQ7/i8dQl4B1awkm/B+0=;
        b=MinXX8f6V2E4i4XE2tofw8CXWyJBCLY8SKWUJfKhMGiLkFt6ZO6ff1cvvfaA2Dmw4g
         U625x42SW5eJPM+8vEkINZ1TnOXnWxlsClDcpNQblMboWjSvNMbMiCl55jUQAAqJJTHU
         CBCpmj5gwoqzEbtbgM+41+2aYZWaIO4gjfumbplUFdlz9NGYfuoizaTAcihbh8IMal+b
         KJylRREyrZyDi7wipBWZ0Pldywd6ck40NgvUX0+1vPtCLAOy0WxflsNFQUXOHXK6w6Hr
         GSB9YQWS5UxQ69Jzh4/O+lTTXLVyWirXrJUec41ySdfTWntuYREFt11pzqc65Tps24Qm
         nEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489272; x=1780094072;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVqEIj3RzCuef4mURYGhNpGwQ7/i8dQl4B1awkm/B+0=;
        b=RL5zusrw7sPhIW3Bc3l2itpQPB45ogsdLCInjs5Jnz3zX8i37qeJ+KwjMTZQyCi/4/
         PseEhX4WHvC0nuwXeh6wCbG2S6kq9CevTrLlK3EUUROZ8LIfXcV/dROQQB+mKVrku0zt
         fU46sHYaqhJTjph7wjAHQ+fXjCSF+IrYDuVIhgGCginZfr4rKROcov6u3WvCLKsFdzMx
         56aDcLZ12QqjyaEPKdZHwscjdCYXfhaLeZbv8XONWzEXti7zWUBGX4n70vlrN+BCEjpB
         bTBHXahS10gFOGHKKTRadIf068O0f1Ar+oYSJ4E3eA48EAc58NCS96EoSgZVUNDNpcIW
         cSRg==
X-Forwarded-Encrypted: i=1; AFNElJ8cMis0xZqez+0iK6cGLsG4GkcirriSYN91U1KacAXKHElISxNV3+ieqdsLdfwVXAnF9uKvTb9ZUDGyVBuv8Z9N@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnlbZTez2lXG0Z6jLdiN+oadx+S699tYbE8HinoNRAx+jbkej
	ZE0Hk5uLwrjewwPb+P8gTGHWKliGhWjmrnjRYYAlWAikH320fHEYSEyZrkCFsBLxg4Sbus6QxBo
	93wNe+mUg+A==
X-Received: from dycnn6.prod.google.com ([2002:a05:7301:1406:b0:303:9118:b1ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6920:b0:2c5:ed1b:ca9
 with SMTP id 5a478bee46e88-30448ffc876mr2782355eec.1.1779489271486; Fri, 22
 May 2026 15:34:31 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:42 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-15-irogers@google.com>
Subject: [RFC PATCH v1 14/14] perf stat: Extend PMU metrics value linter to
 validate --new outputs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch updates tools/perf/tests/shell/stat_metrics_values.sh to run
the metrics value validation linter twice: once for the legacy path,
and once under the --new print flag using the newly introduced python
validator `-new` argument:

  $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir ... -new

This mathematically guarantees that calculated Intel PMU metric values
staged inside the decoupled streaming JSON callbacks are parsed and
validated cleanly against the formal rules engine.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat_metrics_values.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 30566f0b5427..02c0bcf6e078 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -22,9 +22,20 @@ for cputype in /sys/bus/event_source/devices/cpu_*; do
 	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
 		-cputype "${cputype}"
 	ret=$?
-	rm -rf $tmpdir
 	if [ $ret -ne 0 ]; then
 		echo "Metric validation return with errors. Please check metrics reported with errors."
+		rm -rf $tmpdir
+		exit $ret
+	fi
+
+	echo "Testing metrics for: $cputype (New API)"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
+		-cputype "${cputype}" -new
+	ret=$?
+	rm -rf $tmpdir
+	if [ $ret -ne 0 ]; then
+		echo "Metric validation return with errors (New API). Please check metrics reported with errors."
+		exit $ret
 	fi
 done
 exit $ret
-- 
2.54.0.794.g4f17f83d09-goog

