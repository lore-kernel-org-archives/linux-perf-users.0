Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C93BBFB9;
	Fri,  5 Jun 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702732; cv=none; b=jrJvQYiZqRKdzOtXQ9YCsXf4nETbPzQ/ETiW8lUgdxe3vtJgxY5kE7N4G4LoimDXWiryZCG5FJgeTTd8vGEfuvxHetq/w6ENYI4yIdg2izYKMAyUCIZ5GVFv9cTDullhng2xAV8iK0jsUvaqeu1H1I2z2ibla8spoxumMyj0vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702732; c=relaxed/simple;
	bh=FOd6JyZeWlr24mktVwuzD6FYgJzFTfIwVsNwD10nF5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huzqIeD1bpQ6fmUuOA9E1UAYN6xaOlkY/8BkaXj2lpDOn10Dw3M6/MPXhBiDfrWd/mZ7s+zAGZHq5s+TdAGL9LIXDOdGW12Gd/1pvpTx8LbaLW/IUa2w/0/bdeLYe/Gtrd3IuZ4tN/WxOK0q3AplBTDkbGhM38JxSh6Wmm98Mx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ1/684Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ1/684Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C693F1F00898;
	Fri,  5 Jun 2026 23:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702731;
	bh=HuLCee+v//zB3kkmxSNkXDO1Qjnhp5eVfzOoWiMeB9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJ1/684QVnYOG2y0z6PT9nFSTq8+DutL08Lw7GBcxmmGsi2pc6xlzKJKyg12OgWbG
	 ddlZyaZtzdrIl9EQdYcHhoNZyw4d8zfK2ckTv+QPFiKL0spfTHniH95qtYufArJAtQ
	 A3jO4SXGz1laB3gAS3cJ1b5sCO1kRUf+CheV/qWhUFE58NvUfgY/H+LKuw+5SoCfe/
	 NBqaeyBJCLAtMqCjs6pI+8W3OnIe4gVpT7baLEJPMEFlt5ldB4Q3mcvLtrOWE/dMAw
	 GCa2JWOgdlzjkO65NeuODTwAm1URxiRgyXaTmdr7hIq1Zu+rfsH3nluRfAf2Rke9oR
	 Xw5MOobcXiaSg==
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
Subject: [PATCH 1/9] perf mmap: Guard cpu__get_node() return in aio_bind()
Date: Fri,  5 Jun 2026 20:38:29 -0300
Message-ID: <20260605233837.1773732-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233837.1773732-1-acme@kernel.org>
References: <20260605233837.1773732-1-acme@kernel.org>
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

