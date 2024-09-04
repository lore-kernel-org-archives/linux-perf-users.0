Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA01465B4;
	Wed,  4 Sep 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432098; cv=none; b=jAAX9QCcv86uKcq28cN2W0T6ErUvJqAZA941ArUAmzVl1lzI3gyDQO45WLEMuCAVUr75qzq6E62bhUZo8PbaQ3D9JnnkfYDpPJChVl2rPhqoyl0UBdsVTkkDS/ZnktpIyOU4NYZu/JeJBgoH3Tpr1QyXS7q9WGwCGM07a3MyKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432098; c=relaxed/simple;
	bh=TmIFCaE1AKmdJtUY+0uQgGv3/Z/VYVtTf9w6MMhxPkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTWrpk8lFEc9zse1csAoDCDu3l+IrsGfhrL/gKNWuRrue9WB9RPmGauORlKOvBH8F8KL4HdmvqTuPgOe8u1DGFwGT7Z58xVpUbDxx/FVjhfcSjWLnlrD8iR3SMPCbxVzWyNqAULuNDNC0pRXnSd7zpb/g+amLblA8W53Q8Q8aM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ7V0cIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ7V0cIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23919C4CECB;
	Wed,  4 Sep 2024 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725432097;
	bh=TmIFCaE1AKmdJtUY+0uQgGv3/Z/VYVtTf9w6MMhxPkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJ7V0cIpCwuS75lK2j47IkuY0xU63BsTmIGoNlYQMfvXIhpUdP5EtjkitmAiE8jn7
	 bO2KgdGyCdgzPO9a6gnU/sMl6QnC7/imm8P04zzSWPXuB8bE+h0mHGQN9njmWyPMh9
	 nPAKjTNtEbjL3CiT8hXUmB/lk5se7lL4IU2Wgh7Os7DoNlIvaTXZXDm+4clolHp3jV
	 oWJ/zHM2BpjDNs7idhF9NfzZMKH05IxRxiMTO4e6L1SGwjhQ0xKMACjDMZrm1msy2Y
	 hGrow/ty3V+7a1Ll577E6BCvLsKxibDC94mSjGcX+crTENkmgaY1PHmVWruTuSvtcx
	 EBqRhDWY/esJg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 6/8] perf tools: Separate exclude_hv fallback
Date: Tue,  3 Sep 2024 23:41:29 -0700
Message-ID: <20240904064131.2377873-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904064131.2377873-1-namhyung@kernel.org>
References: <20240904064131.2377873-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exclude_hv was added to address branch stack samples on Intel PMUs.
As some other PMUs might not support that, let's separate the bit from
exclude_kernel to make sure it can add the bit only if required.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6456c28326144528..0de0a72947db3f10 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3389,10 +3389,16 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		free(evsel->name);
 		evsel->name = new_name;
 		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
-			  "to fall back to excluding kernel and hypervisor "
-			  " samples", paranoid);
+			  "to fall back to excluding kernel samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
-		evsel->core.attr.exclude_hv     = 1;
+
+		return true;
+	} else if (err == EACCES && !evsel->core.attr.exclude_hv &&
+		   (paranoid = perf_event_paranoid()) > 1) {
+		/* Intel branch stack requires exclude_hv */
+		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
+			  "to fall back to excluding hypervisor samples", paranoid);
+		evsel->core.attr.exclude_hv = 1;
 
 		return true;
 	}
-- 
2.46.0.469.g59c65b2a67-goog

