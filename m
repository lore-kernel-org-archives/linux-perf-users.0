Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65987404E;
	Fri,  5 Jun 2026 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691612; cv=none; b=BCUCHhvg9hSoh0tjBEw6LPzA0FO/paB4vcXRbU6q591gwClcsBZuejVAGEqI4f6vmjoVe0BjQPzeajYUi2RsejKf+v1F2lqEeoJbjcdh6XeB12MyCvnjj9aMHU7xEpZ8abkfGiTciffyRdR94VYASwV15JSVWgThp+CpeXvlPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691612; c=relaxed/simple;
	bh=FOd6JyZeWlr24mktVwuzD6FYgJzFTfIwVsNwD10nF5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx35YtTJGwlbTVn2aYX/g82Em/GAxJ+QDGzDj6cJoEY2nB7JRhbcUBK7E6ysbz6nD5OzgMW6fM1ZdS0flu13KfVh8UaNuz0WnjQYN8xj5Nb6HHbGgSxPYfeIDCaAtACTM+TE3zHNMIblmXwPTlD++EtY/2cyqDURBSRldcbmTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCvYYVxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCvYYVxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A35F1F00898;
	Fri,  5 Jun 2026 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691611;
	bh=HuLCee+v//zB3kkmxSNkXDO1Qjnhp5eVfzOoWiMeB9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SCvYYVxm2N+fzHfeCFsPGJ/e4P71UDmZFI+CF0E9jP4crHBR+3VfLJvl5mRVMBsiy
	 kjg1TuBiCqlBaV2jsHvR9zZ9bk4Gkl3jhMDZe4T/k9fTrKb3jaKczx6RhlCB0O24IF
	 Xv/jLKvhyy8RB2vrtdAURIKC+XAtua6Qb6IB1lagIrlqhrnSzWoQzwOQ2DYNjR+8dg
	 HxpB/SRUeY4l/fYQv1yKrwCXNbyMzWV5UcC/aghc76wQCLwMia+pklZNlPRnCm53Ln
	 P135R11AWd7FoHjeddFkmiie10aHBtjz/2SO/tYUM4qrrPEe6IEQUFjyhMSVALPvwU
	 yfDZW9g1yGF4Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 1/8] perf mmap: Guard cpu__get_node() return in aio_bind()
Date: Fri,  5 Jun 2026 17:33:09 -0300
Message-ID: <20260605203316.1758661-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605203316.1758661-1-acme@kernel.org>
References: <20260605203316.1758661-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_mmap__aio_bind() passes the cpu__get_node() return value directly
to an unsigned long variable (node_index).  When cpu__get_node() returns
-1 for an unknown CPU, the implicit int-to-unsigned-long conversion
sign-extends it to ULONG_MAX.

This causes bitmap_zalloc(ULONG_MAX + 1) which wraps to
bitmap_zalloc(0), returning a zero-sized allocation.  The subsequent
__set_bit(ULONG_MAX, node_mask) then writes massively out of bounds.

Check the return value in a signed temporary before assigning to
node_index, and skip the NUMA binding when the node is unknown.

Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index b69f926d314b148b..4404a99eee45f9c3 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -104,9 +104,15 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, struct perf_cpu cpu, i
 	int err = 0;
 
 	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
+		int node;
+
 		data = map->aio.data[idx];
 		mmap_len = mmap__mmap_len(map);
-		node_index = cpu__get_node(cpu);
+		node = cpu__get_node(cpu);
+		/* -1 sign-extends to ULONG_MAX, wrapping bitmap_zalloc(0) and OOB __set_bit */
+		if (node < 0)
+			return 0;
+		node_index = node;
 		node_mask = bitmap_zalloc(node_index + 1);
 		if (!node_mask) {
 			pr_err("Failed to allocate node mask for mbind: error %m\n");
-- 
2.54.0

