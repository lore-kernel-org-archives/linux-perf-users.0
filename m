Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B438C2AA
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176406; cv=none; b=WF6i/+xy9xkGbSpXId+uy2AItei2sZog2BCgdVJnIMOLENRp7BB3jLequSituOhXVyzt/TFuLMrfFhJ4RPDgRFpMjViSmEZGTGU2iyi7gyBbQyLWyoE/4/Pk+qdMlLTwO71G6SnwtXr7ejjevnWtQQffDZUunyHNyrNMgV79MI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176406; c=relaxed/simple;
	bh=VDUmLuSZcvBj8Pc0HkUyVB9RsVfDT4G+/3WiPg0VcDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sNnClufT2611eIsdYN5608wPZupQKDBaeP1Nw18DtzdJenTSct/BYv2PflOXclMnIwqKUPOfoR/hwHl5mFADuk3olBeniGzLXPEAlJBj23Ptv1rgxUtxgP5gr+ZjXQ6qVuNG3tbdjvh9oRJ7Qd/Y0aAo1NIE+j7aW0bBmYfW86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tgx+8ZMe; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tgx+8ZMe"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso9000888a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176403; x=1784781203; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uydAi+vK6q1cioWG+UZXBfJqvaBaHWiznGYu8rZg/b0=;
        b=Tgx+8ZMeKyhrdz3vVetdgQVHPWCYDh+RtJ4pQgCtVvsuoI7TCH8gG3otvjQF2TJO9e
         e1dNV5bHc9hrwwU+8XIU3DF4eAIRMkKUXPHWyus/NtgDx1kQwA9VP1EuFaK2B3pTQuZ5
         lARuBUKQXgndK75A8r3f05qxb83HtItHz7heSjFx7GQTZs3ZVRhIcStrTBZEc4sAGzbz
         vj/wpVHgNSDB4U0OmmB9aYjUBtCY1CYMVbjQqqqOTV24STn9KTnbFea0Wx8z4jlsnRAl
         l/hlEMxbsD/Jme4gVuyfOspUFB8UZ4zaS4YdLlBQWdrvzxv2l0X3W8L129VUIQbYK4sw
         7kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176403; x=1784781203;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uydAi+vK6q1cioWG+UZXBfJqvaBaHWiznGYu8rZg/b0=;
        b=qtEH6ckjkxF31DtiiNTlXre5Gz1p+2P0KiZgfAVCTMlC3NO+/1V5QYs7T7cSpqklCP
         lE15fyVQFy1rsX8Z4vi8Qv+ExrYompAvYVSEEtL6Uu7icgUlZvU8isu5gD3VzaBgiOtu
         Mey1TsN8GHkVkDgOJqXXRzKIMaNWoLuXnSmhxNNF6HCW4rXqvNZaQ63w783URoLbCoIq
         zBEzxP/bsj4S1zhnVq9MvplSPKbbB7BhBWNoYc8/1K3UfcaRmWYsTV2yBcUWoY9+3pVD
         xnpSdfj0oYxXac9AgnvQaVHfD5/UY5l5aD9HdCp89lQpzYZrm8GCINYJXnvWvR4zMLUD
         JvoA==
X-Forwarded-Encrypted: i=1; AHgh+RrOIZNUGeYMnkbHTOwGMKl/vskcdha6BbWF85QlwNPPJ2+g7EbBpdS9CeltQiLJEG7OHU9Cm9cTyIZqbPSDnx78@vger.kernel.org
X-Gm-Message-State: AOJu0YyD99oFISYkWp8UzfDn3wfXBOadYvE8K6QBpY4F/ErewAe3lBAZ
	0p0JcbcDBs8aRq00idTRczbc74BLftz20Akr+DfyiLv5CbrXIJsztj0VKQtUoiBhlVqFeUNH+ck
	OqKD8IM87Tg==
X-Received: from dlbbo10.prod.google.com ([2002:a05:7022:438a:b0:13b:847b:5d65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:69c:b0:3c1:85d:fa2f
 with SMTP id adf61e73a8af0-3c36c34dd88mr5937557637.36.1784176403130; Wed, 15
 Jul 2026 21:33:23 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:23 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-15-irogers@google.com>
Subject: [PATCH v3 14/14] perf stat: Extend PMU metrics value linter to
 validate --new outputs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch updates tools/perf/tests/shell/stat_metrics_values.sh to run
the metrics value validation linter twice: once for the legacy path, and
once under the --new print flag using the newly introduced python
validator `-new` argument:

  $PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir ... -new

This mathematically guarantees that calculated Intel PMU metric values
staged inside the decoupled streaming JSON callbacks are parsed and
validated cleanly against the formal rules engine.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat_metrics_values.sh | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 86c5c7f70933..3f545e88b69f 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -26,13 +26,29 @@ echo "Output will be stored in: $tmpdir"
 for cputype in /sys/bus/event_source/devices/cpu_*; do
 	cputype=$(basename "$cputype")
 	echo "Testing metrics for: $cputype"
-	$PYTHON $pythonvalidator -rule $rulefile -output_dir $tmpdir -wl "${workload}" \
+	mkdir -p "$tmpdir/legacy"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir "$tmpdir/legacy" -wl "${workload}" \
 		-cputype "${cputype}"
 	ret=$?
-	rm -rf $tmpdir
 	if [ $ret -ne 0 ]; then
-		echo "Metric validation return with errors. Please check metrics reported with errors."
+		echo "Metric validation return with errors. " \
+			"Please check metrics reported with errors in: " \
+			"$tmpdir/legacy"
+		exit $ret
+	fi
+
+	echo "Testing metrics for: $cputype (New API)"
+	mkdir -p "$tmpdir/new"
+	$PYTHON $pythonvalidator -rule $rulefile -output_dir "$tmpdir/new" -wl "${workload}" \
+		-cputype "${cputype}" -new
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		echo "Metric validation return with errors (New API). " \
+			"Please check metrics reported with errors in: " \
+			"$tmpdir/new"
+		exit $ret
 	fi
 done
+rm -rf "$tmpdir"
 exit $ret
 
-- 
2.55.0.141.g00534a21ce-goog

