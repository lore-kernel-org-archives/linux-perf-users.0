Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377085;
	b=3v30w22vCvQfFz0FLZAWmri31AuRFieLKMtIIw+ammYhMi1023l49aEwPiG9HX4aTrnI
	 M4tr5fJuMeW9rQMehbbLFPGe1K2W9mzipIZ/T1EebR7YIErAECUgKRp7R41Q7BWtX+Cqj
	 +I2QsdtlI4OQBPr/QWWlw8Jlm9SSeYd1h8/zuk4n6xYlp/Cf5G0S/s5eDVTY/y7k/46xm
	 vnOQ2m5UQFs1O2QMXQGRrMucVYAp7DiqJqN5OCgC8+pvsb1q1okwycj5oKr0IahrEm+7T
	 hqTtsSqkcTroSq2SStkigSFL2U6pNMifA24wrnWQnn+0TSz62rjzDku7jl4ELFWQ6PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377085;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/tRUYN2i/+hTnIgV7K4+afN0OwNPqEU1lHoM8NyxiRY=;
	b=XUXMg90rk23QUBaFCcoPKo3x+nqOVEvSBNBr2U9qMBybrV83cqyRPuGEp7KGZb4Ljpht
	 uooxIW8fJYYXOwCAzATJmoji2j4bxP07x+jXj6w6heu3nI81vimdtmZZ0TRRxR7ie65TG
	 qDJJ+atM0blCjX6IFitaUlBorD0V4qvTOJUU6E97ySTdCKC3PdmpA6gFmvAg/ZiBW0K9j
	 E/MJUSKNPlTuF4A8x0rBbtqVFCOeqLWQOpCy4cE84rWO9lK/kjdmfCer6v4xlpE0zL0hV
	 omNF5VOR1/PE8JGIBLoKBSOYGTc31CNHme4FEpyCZykGsTPAUdLNi35KamwjrtmqJYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0aOzIQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A2606A31C;
	Wed, 11 Nov 2026 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0aOzIQw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377085;
	b=KBcT8jGIYYuSzq9GWUj947iXk46AcankyaOEsVuIIyW3aXD4WEFJeGQ9mxrawnn3cYDh
	 85R3jqgkxXn7fxT+2p/kaPJRj0dk5/5uHs1wXLrWuQeraqG/zAW+X0CUFTJqKJc+koT04
	 t1laZyT6G6UJZacyhUrbcZsGCznSpnDwvINdrDx7wkTsJLl6XWSfp+wSkDEU4ChWAn0jl
	 jwEHR3Mf60BSNbUA9oe8WVyD/YEKY5kCUNwqitlVVtm+W2n968j4emrNzEs0T8rf27Nl+
	 dUIbn7uUHj533wK5MQjesS8u6iluGmzxFb6l8r4gjlYUZvUnRPgpJiPxHnokcytz7CA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377085;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/tRUYN2i/+hTnIgV7K4+afN0OwNPqEU1lHoM8NyxiRY=;
	b=lo34T8cgk3c0gLAO1SyUEA+D+ButaRxQAjFfnieYnk5JchOVu8xPtk2zz4ptZPrnekKm
	 0wWvMnSt3K8sl5p9Jy+l+8l8oBLrD53YQ5+eiHWFlpOvej2U+SVY6ER2AqR5lK6zCk4Ow
	 r4SHFG/mMrM5BJQccsTLcvK8rwlNZeqYnGOa6aU242TBAgdb9GX4INE6KF/aZpEvXa9Z7
	 /2lFCuy5x7XuYitDycmldao7/hDLUscOJHXoW1mU3PJepQk0rG1Obq4ZRdaN90+N5qjol
	 g0lbKyefuHd5nd+22S561J/9KzG3FPZz/SE2txzlPD4qe2icAR15uGSm8GU31/IL3fw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C7E601F00A05;
	Wed, 11 Nov 2026 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377085;
	bh=/tRUYN2i/+hTnIgV7K4+afN0OwNPqEU1lHoM8NyxiRY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=R0aOzIQwRzeRrxtXOMHzDH+Z6lDGqSa+hBtO3C5LsnqxiF8/YTHWIyF6yExNE+yZh
	 CYOBpP+1sakoQ+Yzp6uhSzQ3/LevBvRK34lNwRpUPf5dmiNFxJDcwiKFKw9MVvbs6K
	 r7SpQLGMlyG0+e7M7OE1muzhKJfTkbipNs2uTDGmElDgyuY8kWUCqF01abjnad/if1
	 5FUTADwoCECsMllULd0zW3an+3dNl3G5aUKFyFwiTXvntyusJBnx99pjsbvP4GChkB
	 +OQE1D4mqmo4ItGzs/JKVmaReQ7/m8oB4r3Oxdf0iuhhB6/zItptu7MeUT7UPQtsE8
	 kELTOwnVn+eRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2786F48DD4;
	Wed, 11 Nov 2026 06:04:44 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 14:04:41 +0800
Subject: [PATCH v2] perf stat: Count kernel events in a group led by a tool
 event
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPy27DIBBFf8ViXSIehhirqvofURYDHieoxqTgW
 Kki/3sxWXTV2d2R5sy5T5Ixecykb54k4eqzj3MJ4q0h7grzBakfSiaCCc3L0CXGid7CnU4IAyY
 6CDVix5VUxpBydUs4+kclns6vnPD7XsDLa0kC5gwV3DfvlcuEZJ3Swhy4Nq1pOS1/4AvmKMXnJ
 YCfDi6Gjx1vISMtIfilb5wzTAHvQLdH6FDC0Ao3cGW0BWDIutGC0GjJLnL1eYnppzZdeTX5t9S
 6G2h+lFYpbUZl/izIedu2X9zanL83AQAA
X-Change-ID: 20261111-tool-pmu-leader-d25fe8153599
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 TAKANO Mitsuhiro <takano32@gmail.com>, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377083; l=4370;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=M1/caRbl8ok29UtGPD8dLXYXGCUc8+9tdV+yKMNQmW4=;
 b=9CUe61prZppY25kmgHtgvIcuxAisnPFupsBvenXEB6mnjX7FEqiKvPiY/zzfMuho0cI/SWkcQ
 6eiEGejZMAFApW8oBY1KR20V5bHxrNJnXcMhpAl2gxSOl62eMPhz7DG
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

A tool event like user_time has no perf event in the kernel, but
get_group_fd() still passes its fd, the /proc/stat fd, as the group_fd
of the members.  The kernel rejects each member with EBADF and nothing
is counted:

  $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
                   0      user_time
     <not supported>      cycles
     <not supported>      instructions

Open the members with group_fd = -1, as the enable/disable code already
assumes.  They are then on their own, so read them without
PERF_FORMAT_GROUP and open them disabled like a leader, so that -D,
--control and enable_on_exec still apply.  Keep reporting a broken
group when the leader failed to open.

  $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
                   0      user_time
            38257394      cycles
            21228043      instructions

The kernel events in such a group are no longer scheduled together.

Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
This goes on top of TAKANO's segfault fix, as asked in that thread.
A tool event as a member, as in '{cycles,user_time}', is still not
counted; I'll send that separately.

Ian, the other way is to take tool events out of such groups in perf
stat with a warning, the way mismatched cpus are handled, which also
covers the member case.  I went with the group_fd = -1 that
0b18bced5444 describes; happy to switch if you'd rather split them.
---
Changes in v2:
- Open the members disabled like a leader, so -D, --control and
  enable_on_exec apply to them (sashiko)
- Report a broken group when the leader failed to open, as before, so
  perf record is unchanged (sashiko)
- Limit to tool event leaders: a hwmon leader can't enable its members
- Link to v1: https://lore.kernel.org/r/20261111-tool-pmu-leader-v1-1-6173b5569f59@gmail.com
---
 tools/perf/builtin-stat.c | 10 ++++++----
 tools/perf/util/evsel.c   |  8 ++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..07d01028bdea 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -719,9 +719,10 @@ static int create_perf_stat_counter(struct evsel *evsel,
 	/*
 	 * The event is part of non trivial group, let's enable
 	 * the group read (for leader) and ID retrieval for all
-	 * members.
+	 * members.  Members of a tool event leader are opened and
+	 * read on their own.
 	 */
-	if (leader->core.nr_members > 1)
+	if (leader->core.nr_members > 1 && !evsel__is_tool(leader))
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
 	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
@@ -748,9 +749,10 @@ static int create_perf_stat_counter(struct evsel *evsel,
 	/*
 	 * Disabling all counters initially, they will be enabled
 	 * either manually by us or by kernel via enable_on_exec
-	 * set later.
+	 * set later.  Members of a tool event leader are opened on
+	 * their own and enabled with it, so they need it too.
 	 */
-	if (evsel__is_group_leader(evsel)) {
+	if (evsel__is_group_leader(evsel) || evsel__is_tool(leader)) {
 		attr->disabled = 1;
 
 		if (target__enable_on_exec(&target))
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 560741d9599d..e3ed645cc289 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2378,6 +2378,14 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (!evsel->supported || evsel__is_group_leader(evsel))
 		return -1;
 
+	/*
+	 * A tool event leader has no perf event to group with, so open
+	 * the member on its own, or report the group as broken (-2) if
+	 * the leader failed to open.
+	 */
+	if (evsel__is_tool(leader))
+		return leader->supported ? -1 : -2;
+
 	/*
 	 * Leader must be already processed/open,
 	 * if not it's a bug.

---
base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
change-id: 20261111-tool-pmu-leader-d25fe8153599
prerequisite-message-id: <20261023085629.1694941-1-takano32@gmail.com>
prerequisite-patch-id: b92ce8b0c6248a4af182670458912b760b98a410

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


