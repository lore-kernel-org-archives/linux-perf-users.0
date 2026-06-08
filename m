Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6493009F6;
	Mon,  8 Jun 2026 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882294; cv=none; b=LNHsArIzXKVD589Einfcu0Nb/RgmlZahRtCBDuonyEcWhalUFbRiZEieWAVpXP+k7RYJzXJ9egqXN7KQPq4hWVJFoGStDXFvQQUBohrqploE5Da19+NGe/tknM43qeLmn15PyHNzCUadDxEGdqiyYhVIUqbDFj1FUT7fWo8R0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882294; c=relaxed/simple;
	bh=fp5aNOc0QaAaB+df522Lom/3m5C8UWJLa1uYJNH8s5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ7p2aO16UFOiqddYwsTAzuX5pdXhbdHEz1rXf0W7mO9o/4CsSKr1VdVhMPpuFnquuAbxx0PlkKSThOw9YX/6WZAp1Ew4nNCDRti+seNF1HjfvLC2MpMmWh3ATI4KMRSJdXbK6Bdrixw/NB/vEJG6jA7hMAAV5CKTKki3i9DKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9YL4WzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9YL4WzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65D91F00893;
	Mon,  8 Jun 2026 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882293;
	bh=DqRSKCvwdIVxBFjQ5Fuic688QpH8RP/c6GYvhZYObl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C9YL4WzGuOO7APrErDtk6hCtQg0PtlsA7LZFUQWMA2lqGDQZy/GiEC8NA87qUuNKQ
	 uctMVpQlikB60JfVzIVKIU7krbc63wfZtpbShHnNZN/Innvk3fgfhcB9FxyJw1OrY9
	 t2TpFI7FwHaIlvmrjQEVc7Fpp83lvBvAaFhwsWjxat/NpjeCuI8LK9mVorB0jbZbyz
	 wr8CTFyu3JrYlbqgnOjJ90AIerytdL3K7/ma0vW9aBqkucB5HZR3kbJOjZmyk83Bj3
	 q70RYxdrp5ct2VfOUEgLxXM05IdCGhYUFynPsw7CEkTqx+GfCYPVVdp470PGI6xdj4
	 DPgNk+ASIXTDQ==
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
Subject: [PATCH 04/11] perf mmap: Fix mbind() maxnode vs bitmap allocation mismatch in aio_bind
Date: Sun,  7 Jun 2026 22:30:48 -0300
Message-ID: <20260608013057.1942953-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_mmap__aio_bind() allocates a node mask bitmap with
bitmap_zalloc(node_index + 1) bits, but passes node_index + 2 as the
maxnode argument to mbind().  The mbind syscall interprets maxnode as
the number of bits to read from the mask.

When node_index + 2 crosses a BITS_PER_LONG boundary (e.g.
node_index = 63 on 64-bit), the bitmap occupies 8 bytes but mbind
reads 16 — an out-of-bounds read of user heap memory into kernel
space.

Allocate node_index + 2 bits to match what mbind will actually read.

Fixes: 44d462acc0bf3eab ("perf record: Fix binding of AIO user space buffers to nodes")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index d64aec6c7c843e81..8012301d3cf2ac9a 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -113,7 +113,8 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, struct perf_cpu cpu, i
 		if (node < 0)
 			return 0;
 		node_index = node;
-		node_mask = bitmap_zalloc(node_index + 1);
+		/* mbind's maxnode is node_index + 2 — allocate to match */
+		node_mask = bitmap_zalloc(node_index + 2);
 		if (!node_mask) {
 			pr_err("Failed to allocate node mask for mbind: error %m\n");
 			return -1;
-- 
2.54.0

