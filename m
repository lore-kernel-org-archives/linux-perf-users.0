Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B434AAE3
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751169; cv=none; b=W0bU1+aEM72po516NNZpeE24AFemvzqx/FMCvtPKua4NNN2pySuuJlXAero/fk0g8E6NFXKUXta5PJAJuzj8/vtVKKBpKqbVdBQU20wmw5y70CjXH7Ku1hhwiIlB4TivkDRd4lkDoyQ1v8096uNbKen/tvg7iI+OB9TlezYh+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751169; c=relaxed/simple;
	bh=OqCGNIWQE4SGgQW9dylZWrPK9fmTcI8i2GJr+bk6yfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOCDmOVS1fEhTI44xKJ6jucxGX9jOBQcsQcqAv8ncPYODGts9/kI1mDj5F3MjyqlzdpyENisf/SU6/pK4lAkTOO7PGAJ2dx+tpcNdw4p1RZJc1VIZUlLQNcb3CuYT0qKsy1V4kEAY6QqjrHsOB2TA3CcFI79JUfnrdwFTpmDUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7sziPzX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7sziPzX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so15671025eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751167; x=1780355967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMbgr0fXMrIqPCRvG6UsLccNRcvJPlMGrNsKwpwREcU=;
        b=E7sziPzXJO0L1y1cK/13tvt93TjvUORSxZTdy9OisampHtX4NYxclGk54hfd1r8U9g
         On8VTFs8QpGNYWIGzxG2Z++b3cJbS3X9m/F7z0AIyM1ol8NGEtzAYgAA/KDSbXtlnNbr
         xL4l1RavWDbAn+4sfa4LOIdy4/MA9oiJAmrlnIBxIBQMdViaCQlN6f5z2eoWzp6XymlV
         gNbmJGRaVkiCbf7plysS1J/97qNQhOAo2jvofSCU5epCq8yIymE9PY/fhNF6HfKI5BeO
         DACLfGZLFZPvUsF5KXwDTSGKSrN9y9xJBm7kQMFCCZOoJWigrkoGB91/aTqlimjeo1I5
         w4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751167; x=1780355967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMbgr0fXMrIqPCRvG6UsLccNRcvJPlMGrNsKwpwREcU=;
        b=LafM9ssYj/Ss42AuCCINMkCHh0JD7SqNgaM6bifNlLz03OCuTAd1S5KfAB7qXKxA8i
         j3m0z9xMLOByc4Q9eAWGXnJ2HUrzb/dvkouZhCOBtIXDmlTv5X/EDO3dL3B4h26FygQC
         6zj2/EAUqlb8khvZqFP1kqcRQjzfqbENIvY/u3Q5v5a+JFhX8cx8xkRQw/IHVs+Sti7T
         VybzIw4EGThQeSRW4tkcXmBVzEu9VbXMgVlr+6zDqt+PTnX4jkH6sADk8gtK8B5PFP5u
         bxdchMq30Y0VZnHofhHsn2wXI5v1WuAWitfB7kHXF0Ui1VVKxsM1Egsg8e7DVadECYPT
         6nhg==
X-Forwarded-Encrypted: i=1; AFNElJ8OJFaqxYbcp0U1tXZMKZbPgA3fX8Isv8XvKoRyYAw6E89T1UYUaaLXRtPqKAhKxlbeISCNwWBaR14p35x8ACrA@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNPMaUNONfGykxPyj9WWdflQHUS61DQ7YQ3rCAGAfKkoggWrM
	ZlbBNLZZywuOCLPzYCRbYhhg+EuN8BTzg/pDQzfSDySG5iBOHIUQXJToHzHZFGxPhWM/F6ySutP
	+oAxeYEXTeA==
X-Received: from dlber12.prod.google.com ([2002:a05:7022:264c:b0:135:53c6:ecc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60c:b0:12d:b329:987d
 with SMTP id a92af1059eb24-1365fa3828emr5999771c88.24.1779751166786; Mon, 25
 May 2026 16:19:26 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:54 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-9-irogers@google.com>
Subject: [RFC PATCH v2 08/14] perf stat: Extend CSV output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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

This guarantees that CSV outputs produced by the decoupled printing engine
are formally verified and column-valid across standard and interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
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
2.54.0.794.g4f17f83d09-goog

