Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE238887C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176394; cv=none; b=Ir2UYPgeEg2Cd0TCKW/CjcZDT/OHdqHQDHtJg97ADdcy5SYg8+phdecReYmYkZsLdTGv3zlVcb5gZi3HmD49qpMjbnYN9LMC48kELFflcR1NpmvBFlkIL7ggIQYiFDZHVdgiv31WTX9fXaqdSTMT1TP4fhBtF3jVZECDQY5lSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176394; c=relaxed/simple;
	bh=vGl4tCWC6XmoeUT9EluY6FtlT9J2IYBqxQu5uqu/7os=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jimiDB7Pb7cjgHwcueS8WGJNWae4oIkIRrO6FIdRp3KwJWhIB0d2aB020Xh5VI5/DFk0S+AI4eTQJjwRvS4peP5MA7by/XyZ40L+mhF6ZAAu8vTJHhK/+Av0qJzMB+YwVI5Sirlv30qmxXHGZY5B6FgEM2qEI7+qhqeH5rceK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRFL5HC+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRFL5HC+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca8aee88725so9145895a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176392; x=1784781192; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJYAVkaPoyTHHP/SZhmg8GoGiAJrE4cdA9XN/tRK8Ko=;
        b=LRFL5HC+m5BP3E0lvvU5hkaLwcVQbwk7F+MGMyNsXMqUk6T5ah3R9MAud+H63vRwWa
         jId5IdpldXklnyHtmNKadv4Tqp/gDv7qd4EaUrieQ4TQ00lLxjoG7q1nM8z/PIWGrtGF
         l+3ow8Tdb8S5iIDoPBPsXzA/JpcrcjK/bkXIjhtQGJENDLi3KDKnOZIAQAljV4apLMP8
         gqxnAm1X+KrFanxF0OdmNMB5EUjsRZP2HePEErsGbD2rxrvxD/wOLW9KaXvYuLdYHUOD
         gV5416CptHJmaog5rczzaOZowzhJ7FnFA9ae4AqLJ6LpZFph+FeUbCzatRbXeemnuEVH
         mjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176392; x=1784781192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJYAVkaPoyTHHP/SZhmg8GoGiAJrE4cdA9XN/tRK8Ko=;
        b=SI2GdqTioxTbROqFWyzE8EZGKhihqG1DlvMUFC83a8mPRLvAmj/GCzyYxnmB38tgTF
         FPBVaex9ThlRkti411bLyNXB2cLAwj+G+ybwjDVND/VymQI/e56gOc6wQRJ9n+1/UQo6
         MoBQuTt5Hpfj9e2LoEhYKZxDDeqOlVqYKuPFzANEiYhlKiwGdbRR1pUWFTzKj/F5KD6Q
         /GmejxqQxrfUPBnXlTFCihxun4WilM7gjh5RvRoh+arDRwikxdN4ZmVhLKOXoePaxP2f
         Qv6OB+5q2DEPzVATBiNp1sfwW1hcSWybn/WHCv0XztoRkAUW83Az0C8iZEqUInpIeuj/
         jOvw==
X-Forwarded-Encrypted: i=1; AHgh+RpGm2k9TS6YoLf+G0cW1pWL2HN1xo94u25w8po//f9FziCSzXD6NEnJ7hD9Softi6301+ssC8k64G8zfdpvmIRK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rFeEvQn9g180BDuDSIbuDp5MxJIxUkxQqt0DdP8GJnCNbrtd
	6joz3SxpGPoy++tacK1EmQl5rWkPnqGpF78J3F4O58LdGCz9gkWeKHeFhp6o1UYR3CrBc7uJhLf
	S6qfW9jbZ+Q==
X-Received: from dlaj7.prod.google.com ([2002:a05:701b:2807:b0:139:a243:2e06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10e:b0:3b9:5efb:cb2a
 with SMTP id adf61e73a8af0-3c34d529812mr12213898637.3.1784176391485; Wed, 15
 Jul 2026 21:33:11 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:17 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-9-irogers@google.com>
Subject: [PATCH v3 08/14] perf stat: Extend CSV output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run all
basic and core aggregation linter checks a second time under the --new
CSV print flag:

  - check_no_args
  - check_system_wide
  - check_interval
  - check_event
  - check_per_thread
  - check_per_node
  - check_system_wide_no_aggr
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that CSV outputs produced by the decoupled printing
engine are formally verified and column-valid across standard and
interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index cd6fff597091..e4153a03d716 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -88,5 +88,21 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API CSV checks
+perf_cmd="--new -x$csv_sep -o ${stat_output}"
+check_no_args "CSV (New API)" "$perf_cmd"
+check_system_wide "CSV (New API)" "$perf_cmd"
+check_interval "CSV (New API)" "$perf_cmd"
+check_event "CSV (New API)" "$perf_cmd"
+check_per_thread "CSV (New API)" "$perf_cmd"
+check_per_node "CSV (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "CSV (New API)" "$perf_cmd"
+	check_per_core "CSV (New API)" "$perf_cmd"
+	check_per_die "CSV (New API)" "$perf_cmd"
+	check_per_socket "CSV (New API)" "$perf_cmd"
+fi
+
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

