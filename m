Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B43DEFE2;
	Fri, 10 Apr 2026 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858981; cv=none; b=Tu/+Q40LoIyHWOPzU41CyrlxKpctHGTbg4X6MD6FcIBGAs9I/diH3cNEw0EugHNVh04EwYK5zbKmPpR6CqRf6JyEpbJOBQZ5qD4u5FdOl9bNb6NJpHiNWXgw++vHpkVJhLntiYmgVk7cPc9OOXbjAZfw8805QYcXAk7gcFEQ5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858981; c=relaxed/simple;
	bh=G4yfJ6TsvEzJY4YRueew+vZgDD6Hdn7BTpARzeBUI+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joI5HqdZJFfhmxymuHf1+D4ZGtmZG837B6AT+a1Ib0TiHSfb+atZ1V/cfSuA5/1MIvxZbm7Wf2MDlIVTlXtPLksRFxnk4YfErCDv8Y8XJLGe7UDN6Lh7XTDfmoR7jiJB8tdPECtFzA5XPGMr8nCK3P7BEC/Sozr6NladnbmzZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezryqw0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezryqw0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6E5C19421;
	Fri, 10 Apr 2026 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858981;
	bh=G4yfJ6TsvEzJY4YRueew+vZgDD6Hdn7BTpARzeBUI+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ezryqw0gGroytcAZxEesRtXMEV0GvdJ1+M0vbAmyj5kF53FRjFlr/bE4gci+MgWv7
	 R6BxRno9s+XOtoePdHdhiNM+rzx43jbkdFindYWkOFe9SWnxboWzKJZHTizP3Qk3ho
	 b38MXMCrMqGFhj3WCPNd+P4ZgZls8joAcAHxoyItFspbufwABL1IG4eHcvoQw0/xyz
	 4uinpjaDCRjgjxshLuXqhpVT9M9zUTkoBVEHsdDruUFPwjqKOqAXn421mZyFC9+XAz
	 +KuKAVRfRYA/r3enOzSqlLTjjPcAfsxVmzxC+PHYGgZs283OX1PEqv4lxfKwvifDrf
	 bFLU+aVF9yGMQ==
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
Subject: [PATCH 06/13] perf header: Sanity check HEADER_MEM_TOPOLOGY
Date: Fri, 10 Apr 2026 19:08:58 -0300
Message-ID: <20260410220905.200051-7-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add validation to process_mem_topology() to harden against malformed
perf.data files:

- Upper bound check on nr_nodes (reuses MAX_NUMA_NODES, 4096)
- Minimum section size check before allocating

This is particularly important here since nr is u64, making unbounded
values especially dangerous.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2f405776e5013c13..2eb909672f826ca4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3308,6 +3308,18 @@ static int process_mem_topology(struct feat_fd *ff,
 	if (do_read_u64(ff, &nr))
 		return -1;
 
+	if (nr > MAX_NUMA_NODES) {
+		pr_err("Invalid HEADER_MEM_TOPOLOGY: nr_nodes (%llu) > %u\n",
+		       (unsigned long long)nr, MAX_NUMA_NODES);
+		return -1;
+	}
+
+	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
+		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu nodes\n",
+		       ff->size, (unsigned long long)nr);
+		return -1;
+	}
+
 	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -1;
-- 
2.53.0

