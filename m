Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510401E7C25;
	Wed, 12 Mar 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811511; cv=none; b=E25lrmHL453zNlg7yupkwA9E/h2rkZto6sCekVK1uNGaFd0q9iQe8mS6n2GJudAYvC08wXhmSt2h3M3779Oyd6kl7OiQ9c9IpbBMxBSrOB0Sxc7zpEXzWnapCPBHg+fepAWg47dasF8r/BBYkkdsQi54o25bwb3WmZgQ343oLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811511; c=relaxed/simple;
	bh=GqdBr8LrfZqs36fRS7w681t9jhkPCqwSChpCjCHB7zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNaQwWpAMos3mCYgApMBNWNtBA3KNSDgy4Y8a4KLYvLWg0t1JUwVz8E4BoseXxUfFCqbd0zi9OLI2xFlCHRxA9I+8xXm4XwP+pomnZxpbprP625ZwHe6lypcTbAMjVERf+lQK/sQgXh0hNVHocvp/tDPOzRN032FF9cA4Krwvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnFsZPpu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnFsZPpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2361DC4CEEA;
	Wed, 12 Mar 2025 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811511;
	bh=GqdBr8LrfZqs36fRS7w681t9jhkPCqwSChpCjCHB7zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnFsZPpuBByNeqNTTTx9GNT1X5mqPEr5UTxDbxnUCU2mgI5u6YuUP1PmMsTcmmBf1
	 z4Km58ZUbS4AdjL+nQHNrrOK4R/70hWxd9a5wKKpnbvYv9Jkd5pR2y8WkipyM78DqA
	 8VfZ1vjUbntaoOnrNzdrwZARywre3W58nl2S2p+LpkupjjMtHF7TIUU9ZB66h7WuSG
	 5GqUpMuiBXjC6BYJ7/Vb/+Q34lwZdANSKxp8R8SZKI6uokj5hoajVafs7tNBibHBjZ
	 /JTvZMQoCYH83cp3Gdm/l/zvZF+OVYKpEDrXjNDfb1orljAOBY5whUgSadfV7bVZPz
	 aJzbAs/jfJ9UA==
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
Subject: [PATCH 1/6] perf python: Fixup description of sample.id event member
Date: Wed, 12 Mar 2025 17:31:36 -0300
Message-ID: <20250312203141.285263-2-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
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

