Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC57426419
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625597; cv=none; b=juLtPD0EobqXVINr0cAU62ieXleTFiLSLxJsxm3LjC3OgqvmxgsTFLbw8c+kakfKSGJWPJao7nPyYLVJ4sr/7en1iHNlHp9tlwqqO29LwtJhh56EhV6gA5Z7oACulsDZfvlFWiq8eZWibYNwvTlk6Z80SJXlNbz6/cR+8coiPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625597; c=relaxed/simple;
	bh=ijT4boAwnzJnfq+SCNqL6tC+vol3nqZ/S1x+Pf6e67g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=aqP7hAoMb4qI2+4FZ3J/BfGPolp1X3kB+qnw3Ct7TGryzjfbBg3oQ8C9Sb+QFx728bevbytneb4gYM7IN4D9oaZ/UPenoeMu7d7AvyqY6oN9o8yZv/KHc4R63Wlj5O5OD2dPIU+wtjde5dV62o+zf3ZtenHoAd0HJ8s1LRftR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuFNZg+6; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuFNZg+6"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso926210a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789625595; x=1790230395; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nqhdqQO4kyM++89l5qEyG3TcG5/Vl/XXQ79cpkINaJQ=;
        b=LuFNZg+6PC93+ttNk6P51RTS/uN2hp7mPUq0qsragimJ9OMhrEaEUlXLsIVHiCJG6L
         /43HM0O5IoA5UzZnY/T6segiL8cQliAitIl3O9rlvAO3g4k2IomI6/gS2+zAVap49VeW
         msrKPYC8WuCKJa+PtCc7RSxThnqtg8PwWen+9AV4FaBKqq2L60jh4zMRFajUi6GCJRRN
         C+rQUtz2UPAZltSLFrUZeJ7aSd6nuROhhevbu5KAL9jmG4M+C6peQscJivqbpdQg+x7E
         lR3HtfH7C/z7Gydu4XNqySZiC5/DmuvPYI/QQC4B7KMDfTsrP1LGwF6f5/2HXSchfbCT
         VgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789625595; x=1790230395;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqhdqQO4kyM++89l5qEyG3TcG5/Vl/XXQ79cpkINaJQ=;
        b=HHVHt1O8t9k14e3cFuei0dBLwGoh1voH9U6Gjyqa/xAo+TQYFXg/RL/2+PnR4c3Pk4
         HODWSW4o+Di9yxHzdVBoyWMh5W7kaR9/1ZE+6L91UCVU279I0L/czBjOOCvTPDTqAB6s
         uAQo8Noq29ZvIkXJSF9sYQIAkGdVkl4l2LHJ4mJPDEbeJhpncqxwacpF4uZ39BbtvQco
         OlCRzL4NhHKH+R2ksS1rnHA9HgGCN3H/2aaMTSbpm0NJo8annqzXeodxlzR/gFGjHVPD
         N91VLCIabFPnVZ8NWh0XKEHaiQ/UOhvDdcqkDfg1/P3SCSD3xTQp+BmECqC6WdjLNlbu
         qwwQ==
X-Forwarded-Encrypted: i=1; AKwUvByf5B/MzUo3FNfQ4bGWDe76xN/Nfm+IMFyVTehmKT2jqCXm5IjvRpD96jWel81UiH9Z0+SsrgLeANXwIPfRawgx@vger.kernel.org
X-Gm-Message-State: AFuF++lBbNxly18xjH7XJadGL/8qvsw3Q54v60ftb1M4zZm5vDTA9sNl
	tro4q0XgXKtNSbtrA9VsCz8HorVDLszWiwa1N3fRgu3exuYADV1EMnwmz+SI75e64NElBTFUAZx
	PIXazM8ojbA==
X-Received: from dlbsj14.prod.google.com ([2002:a05:7022:f90e:b0:143:74ec:e888])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5624:b0:39e:b7:cbef
 with SMTP id 98e67ed59e1d1-39e1e5612d3mr19386637a91.25.1789625595255; Wed, 16
 Sep 2026 23:13:15 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:13:12 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917061312.820074-1-irogers@google.com>
Subject: [PATCH v1] perf test: stat metrics cgroup strip possible slash from
 cgroup name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The grep to match cgroup name in metric output assumes no leading / on
the cgroup name, however, cgroups in /proc/self/cgroup may have a
leading /. Strip the / if it exists to avoid failures to match the
cgroup name in the perf stat output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_metrics_cgrp.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
index d4226ee0ae98..0728f48f21fa 100755
--- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
+++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
@@ -86,6 +86,13 @@ check_metric_reported()
 
 	for cgrp in "${cgrps[@]}"; do
 		# Find metric lines for this cgroup
+		case "$cgrp" in
+			/)  # The root cgroup, leave unchanged.
+			  ;;
+			/*) # Strip any starting slashes.
+			  cgrp="${cgrp#/}"
+			  ;;
+		esac
 		# We use exact cgroup match with surrounding commas
 		local cgrp_lines
 		cgrp_lines=$(echo "${output}" | grep -F ",${cgrp}," | grep "insn_per_cycle" || true)
-- 
2.55.0.1082.g2b9226bbc0-goog

