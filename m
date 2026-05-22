Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA337BE97
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489253; cv=none; b=kD1dp82PX4rcVff5Sl8BPQFuRqHkqIXBm0kG+337UXYIGOaG/cNgTTIFQasHbXh2htW3IRhI7EMSOaAEOtVmk94TZPiTfTGkpo/s1LcHpiSPjlwKyV2Q91tBzxuUrKdyAKHHI6D/qFE99UdRYfCgsdKNK7P+rbhVnXQcv8IStvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489253; c=relaxed/simple;
	bh=QHZVshflFmrjjhMtKUhjVH9MQLmvIRgweRvpXHjw4uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hvzFQPNwxsKfUkbdlVJZcvC/x8G9yei1aXZINA5wLLqnVuWaOZqeOK1ONUTZlK60ZTPpWUpnNZmtH0D5Ibuvg3V6lIq1VR+NcLVULTYSiIL5VDnYta8tXleNsKoY6vo9J+Up+M8mS73I/QArMUiAdV2u4XhQ+8WShJH0P+WJ52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qghj5dG3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qghj5dG3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so12950941eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489251; x=1780094051; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqzxQW2AbIPTH9tTCQP9t1PgzS1BV2Rl09I1wSbSwmk=;
        b=Qghj5dG3sJaXWlK4MXcc1NiTax+P+y2OZ7L82bSb9SI7ZcCfkVWwo3e6jQRpgl9cs6
         jwNSaJebqrZimuoqCr/ATO4WWpwxT/HDg60v38n+puPMFO1bFtMxOHFu1I1+vM61dYUO
         P/KmWJTbpgY1+nULwkRs/nVHFl87VBY//4BkedfMObxA619q122Y3vqnIMq/VdEYfcYD
         WwjxMutEd6LBXLalkcthHm+i3nDi0ntn9KhvNx/WAzeMooBP3z/V0wT6kjpwCj+tGvP0
         FUDct3Gj6B9AG1M5rhqaMDFH4lBndVp9YaWivgug9UBinsfPElIeohuV3LRcKAfWl2RO
         9ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489251; x=1780094051;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqzxQW2AbIPTH9tTCQP9t1PgzS1BV2Rl09I1wSbSwmk=;
        b=dgUEcU9kmsrekSj48jsKKueJbQZ1FHanbWv4dtAJrxHsDFZ0rcBfQs5maY4wb2RQca
         9IbxknpuM644EyX/qWZt+qggToUUFZidrvALUQSpebHKTDxc0uSSaqNaNqlzQ6Zym/Qk
         SObOyyNxXS1/U/5Ty1LVpKWiqA30c7YEnQkYQxp0tljap0Ik7mZmMXftlA7pSWa2dpFt
         9rLPNVP3JkJnZzlSOvtmwLeHADNJ/ExaCS5Z0ZiBf2+JMR0boEFAHlrhCU8AgDxrtQpb
         8+Col0Nn+Aj/wNjopk1JeVm3PkzYgH1n3fMLWpntV9N+xRnx/p1x3JDVL+gd5VE8s5MP
         Ad7A==
X-Forwarded-Encrypted: i=1; AFNElJ+30Neg+OVVK+hijb85Emfqirkt1hGA/H2RFTle+EhOI6AqHhFzo/o95k9wRiJNvhcavYHobcgTvjRL/BloxDGc@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7WrMpLR2cds48ajnxcdGcKh8mrhNR4lAw/v1MwHGTYFSUcMD
	MCK7CWIDujBFf3TxMzDHYlsyZLPhPg3+Ch96KAG/3FaJGaph07BjB9yuKwPv9fckZnjx+IHIL7S
	GrVElGwRBVw==
X-Received: from dlb3.prod.google.com ([2002:a05:7022:603:b0:135:e6d6:d14d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:258a:b0:136:4317:a163
 with SMTP id a92af1059eb24-1365fa35574mr2034112c88.25.1779489250537; Fri, 22
 May 2026 15:34:10 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:32 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-5-irogers@google.com>
Subject: [RFC PATCH v1 04/14] perf stat: Extend STD output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run all
standard CPU and thread aggregation checks under the --new print flag:

  - check_system_wide
  - check_system_wide_no_aggr
  - check_interval
  - check_per_thread
  - check_per_node
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that standard console outputs produced by the decoupled
printing engine are verified across all core CPU-aggregation modes.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+std_output.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 233e0a50eb33..8dee005a7281 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -121,6 +121,17 @@ fi
 # New API basic checks
 perf_cmd="--new -o ${stat_output}"
 check_no_args "STD (New API)" "$perf_cmd"
+check_system_wide "STD (New API)" "$perf_cmd"
+check_interval "STD (New API)" "$perf_cmd"
+check_per_thread "STD (New API)" "$perf_cmd"
+check_per_node "STD (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "STD (New API)" "$perf_cmd"
+	check_per_core "STD (New API)" "$perf_cmd"
+	check_per_die "STD (New API)" "$perf_cmd"
+	check_per_socket "STD (New API)" "$perf_cmd"
+fi
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

