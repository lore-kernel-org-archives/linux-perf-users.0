Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A371770E9;
	Thu,  9 May 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278957; cv=none; b=m5yM3c7f6HPQHxhZyMU1kRlKDzN5geYd/jJHUjT5ikoaSNdcgHtrLB8eOH96JA1LilCDwYv/DCwRY3XHZuWy1xXIHvr+Ez+koCdeOuo4hLu3GEjdzwyOSmf/oyQ+kytJdHPytZ90zIOWtrVPd2axRn8A6sAOlkay0TNWfbPMHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278957; c=relaxed/simple;
	bh=jMd03m9y9hcSedZb9MgnwXrJphDXO+YD9iDPVE56dQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdPFS7hyl+Y3eKZz/p/YQPHmtpVyZImwZ95VTQCR7Nli8soqSuma3+s53FW0/8c78Omal8NBm1E88L1H/QaLLzNO1VtBAxvLbhiJC2fm8UsfsOVPp3Xg9W9sqy1+/CjDkidE8XZqvu7kWOPjZRzJLhOLDBOuM6yselQlDVMtfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsKlmE2a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsKlmE2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74C8C116B1;
	Thu,  9 May 2024 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715278957;
	bh=jMd03m9y9hcSedZb9MgnwXrJphDXO+YD9iDPVE56dQw=;
	h=From:To:Cc:Subject:Date:From;
	b=YsKlmE2aEV3lsraj2kterY3Irz7WtBt7qP9STqBtK5qe552R+gVsMi9EtGb+yuR7d
	 jEw1fcnDaONUznVcjyLxAEMdkMruG65GVKb2g2gAJUNBDlcHPEZv4c9CRNOyC6mg+Q
	 2lEW0N5fC7zrJzACKepfiMpLhwAJCPwQ3OQHDukm5HKOGlDTRpsIhqbVBcLqV2LDrT
	 mVFZwtCSXPxlpkqpiZsX7PSNjK6xGL2N9h9ON4G+fwXhbqfaGC5Xa9GfLpXrw3pKVX
	 3oXoHVzUVXuCYV0/yAlSUskMLx9xEculyU2v2ict2fijRXJ03JkFr/+7pSejtK9K/J
	 zB+WtY1/PSBtQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Ignore deleted cgroups
Date: Thu,  9 May 2024 11:22:35 -0700
Message-ID: <20240509182235.2319599-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a large system, cgroups can be created and deleted often.  That means
there's a race between perf tools and cgroups when it gets the cgroup
name and opens the cgroup.  I got a report that perf stat with many
cgroups failed a quite often due to the missing cgroups on such a large
machine.

I think we can ignore such cgroups when expanding events and use id 0 if
it fails to read the cgroup id.  IIUC 0 is not a vaild cgroup id so it
won't update event counts for the failed cgroups.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter_cgroup.c | 5 ++---
 tools/perf/util/cgroup.c             | 4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 1c82377ed78b..ea29c372f339 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -136,9 +136,8 @@ static int bperf_load_program(struct evlist *evlist)
 		cgrp = evsel->cgrp;
 
 		if (read_cgroup_id(cgrp) < 0) {
-			pr_err("Failed to get cgroup id\n");
-			err = -1;
-			goto out;
+			pr_debug("Failed to get cgroup id for %s\n", cgrp->name);
+			cgrp->id = 0;
 		}
 
 		map_fd = bpf_map__fd(skel->maps.cgrp_idx);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index fcb509058499..0f759dd96db7 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -465,9 +465,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 		name = cn->name + prefix_len;
 		if (name[0] == '/' && name[1])
 			name++;
+
+		/* the cgroup can go away in the meantime */
 		cgrp = cgroup__new(name, open_cgroup);
 		if (cgrp == NULL)
-			goto out_err;
+			continue;
 
 		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
-- 
2.45.0.118.g7fe29c98d7-goog

