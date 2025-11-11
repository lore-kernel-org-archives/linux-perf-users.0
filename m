Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA4352FA4
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896164; cv=none; b=eofmzEmvgoikFgYHSty/OOZP8Dzya9ptN6Yq//OwUU78rKQrjFS8WCu+JRmlckqjK3Ww/UASNNezro/i5avS76wUWSTuA6HQpqYn+4vGwRfI2lWBeJGwmoijOMXYAZmapz8OYyDva2sUXR3pwrZ92xl/JpPHJa61+drbcIO/EIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896164; c=relaxed/simple;
	bh=7NP/VCWcDtaQ9ddY1vDzUSspDiDop3c4KIH6lorm7/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EgglAgbvGxX2nabDPNq9xtQXL+odDMJL16Fkho8UggUHuGuIu5Y3CQvvn8kAoxIVFhi5gURxDUYb/9FkiiVMw4+SZNtpcHN94NYXv5VcsGBEQHOLxFHjmKL1z1ywd308R+NbOaaUcuEqftTbIoh07UEnRO581rDVfTG1cyLbIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x593KzL6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x593KzL6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so301818a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896163; x=1763500963; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=x593KzL6g0E/L2txD3DiR07Czu44ihT4HEu0m+644SwPVeUF67hG8l7t8ZeWJ92kTg
         l/JsonecYHqa1lM4h3spcBNWXn7rV/L06Wb6xrTaWvsIpdqiKG1ofjPVel8TddJP/ygC
         wIhxe5vz5FAdz0ZhKWJzICm6EksFD7d65zb7m0xOBPzyZZB3OnKFNmu6dQk1G5rOh0AD
         +ZkX56FbitMdaCgdcy1tJmi8VQEq00uJ35qCgf4SUp/IPnoq0bZg/6k9KwKth39jv7l+
         f5g0/qao80KHSojTP7j7fnf7mhdWOhcHZuKbRG36UTxrPxkS0DRiMApuyQlOI6oS/opx
         P20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896163; x=1763500963;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=azTj1mP+jr4gfnTmJp2g0c9wJ+lfwDRdnowHZgs8Eesa/qpYlT2Qv5yxJ7AtwWdjvL
         Lyb5iH4hWkM+k5J3Kc7MJRsWvmssypkLfDtr2pVR/4wBnzMunHl0LzEf8BfcL5oOYquz
         ulCpLsWLJKLzPrNW9kXhUDaSeB+5of+POPQjsdJ4WmMfauzDCHHElSn3NZ5dymUm5HZn
         NkwKRvPBV5oz4WUYgE+gk7ow+QxdRhNInNXeDNSm4y7g6/U4nftfuZXUcHJqTPBiZF31
         BJJxj1ONdOkkp9pdHkBPHnk9ML5ZhCMfJG7QsRI6b0D34tSNa0cBQqAqrd/5aaClxYGL
         mGtA==
X-Forwarded-Encrypted: i=1; AJvYcCWCyX4M6eNONZyJtmWLU4E4W7axlVUc7P6z3EZYSaTFazfSNbAaRUqS80UJWi9VOkTUV3YIqN2YACAqyWR5+JFW@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwjC+FH2iICBqUzSk8KeKt2MULGLKgpAgpF9Iid5vRbpRAAXm
	ZvWKE03Ni5HD5TnVua1eYGmZQF/zFjR37did9+6qaaCLvdrwo/nivyXq+AXM7VCq9qZNdYCzAR7
	ie2wK6tIYww==
X-Google-Smtp-Source: AGHT+IEaAfbGuKuXofcRBR7ZE0Z8YVSclMV+mGctbsfRk2ZunUgoxJ/7KN6O7H2y2FLf5EBuyNzYuRgphVjY
X-Received: from dycoz6.prod.google.com ([2002:a05:7301:fc86:b0:2a2:47b6:b541])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0d:b0:290:9332:eebd
 with SMTP id d9443c01a7336-2984ed79e33mr8797715ad.10.1762896162843; Tue, 11
 Nov 2025 13:22:42 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:01 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-14-irogers@google.com>
Subject: [PATCH v4 13/18] perf test stat: Update std_output testing metric expectations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Make the expectations match json metrics rather than the previous hard
coded ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index ec41f24299d9..9c4b92ecf448 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -12,8 +12,8 @@ set -e
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
-event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
+event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
+skip_metric=("tma_" "TopdownL1")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.51.2.1041.gc1ab5b90ca-goog

