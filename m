Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD41C5F37;
	Wed, 12 Mar 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795623; cv=none; b=YJhQkGNVES+8QKBW2wnLkvEYCFPMHG6UIMZBRA7yL2XE+VURwVLQMWqNC6CMkV2CPtONedUSG5neGPG1twWmVXmKbrDx8XgO5WpCagPMM6Z96ftVqmvgbBDqTWGvGjAA2s/eTP6vpRuz7eHf01sueZ4fcwj7kAVTpU8ARuGSihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795623; c=relaxed/simple;
	bh=GqdBr8LrfZqs36fRS7w681t9jhkPCqwSChpCjCHB7zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG8tI3pGJ24G8HauUPZXPCUvvM0J2VbO3H9qsm0OuRO8VuP6AOE6xsumhz8fSO0WvZV/PWTWRo0om9KgFJhu2W5Nele/nvOU17BdSzIw8i05dJLBrVry6Z7XRcY01Nbvo4mpjTL3R51zf96APUlz7Bi/49pvocJXAbbjeIUWApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMNOUn8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMNOUn8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80651C4CEEA;
	Wed, 12 Mar 2025 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795622;
	bh=GqdBr8LrfZqs36fRS7w681t9jhkPCqwSChpCjCHB7zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMNOUn8m7nYE8nk+1Ar60fALXBNWzmLey12auIuWCGOPDlyABo5Ct/3b16g8CVmE0
	 ltu3vUx3PDYgP01HRyknQIyJEP763Yr4jYSQbXzTw3pr89R0DvObHL74ec9Mw7SmKj
	 LZN4Wq92RDag69Am6msZD+uMUt+wzxdzfRpYc4ERoyTE11k0oOEsPbX787pfLOT58l
	 AFh9hhWRvxaETlKV2maO3vpOai2WcoPI5jAnYKJV34qiRrIfL81No7jNDRDym2GTEQ
	 r4C9vhH8LvM93BdfXUrRVk2ldP4Iy7zsO38vUfADN69ivfeRRPMKFfx33G/HoCoF3j
	 CNbQHT1PU2otA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/3] perf python: Fixup description of sample.id event member
Date: Wed, 12 Mar 2025 13:06:49 -0300
Message-ID: <20250312160651.280817-2-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312160651.280817-1-acme@kernel.org>
References: <20250312160651.280817-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some old cut'n'paste error, its "ip", so the description should be
"event ip", not "event type".

Fixes: 877108e42b1b9ba6 ("perf tools: Initial python binding")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 69ec2ad60d98ba38..6c5bb5e8893998ae 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -49,7 +49,7 @@ struct pyrf_event {
 };
 
 #define sample_members \
-	sample_member_def(sample_ip, ip, T_ULONGLONG, "event type"),			 \
+	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
 	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
-- 
2.48.1

