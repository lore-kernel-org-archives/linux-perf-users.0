Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0D45038;
	Thu, 16 Apr 2026 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298492; cv=none; b=B7xKZvNU/0x9sK8LnPSayyUczz4/mDv3Cgfuh4dsDMQedw3Qe1YoxiJQGP+sSnse6GpbZjCBmMf+vT01ZhowoOeKokuv0G8tjJRnnXcDKlyd+swjCxSh6SLIPd1gv+swFpTt8Ayf5p5C9VDPCStbgJoX7a1D8+Gj/t2ck3eCnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298492; c=relaxed/simple;
	bh=Am0ZlfVcYLK1tQUibREREbOUED8fvS23fUj/JUt2YnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYpZAtO91EZ7QGgQRl6oPyIy2ud0e/mDW7nO6mdJL/pvCcGRTTpoc1A2XskRyMZ9gjoyiFxqrniJNeDC7SQxjjDABOcBnNEnZIlDWN58rgI4g9ueE6eGGzvcwdowTQPLVgXAf+zPBt66gHz66kfGXOTiS+1zQ5aJlrrUg4JY+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV/PjF/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV/PjF/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE7C19424;
	Thu, 16 Apr 2026 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298492;
	bh=Am0ZlfVcYLK1tQUibREREbOUED8fvS23fUj/JUt2YnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tV/PjF/vQQFEmdKai5aJpvnh9zGCwO2d1e/IORrjyra7pHOesEPigU29q1hlo9iUQ
	 wknijgUXayNFXetHm1PXo9+jrClBJeThG0mwUg0Ka1w3DT6e4fDrEDR5l47kqwW7Rs
	 KG4ziGpZo8F9Bz17eoHjfpbe036Ghufs2P5rxkoZXZ4uNYb4Oy7ACVxvjtXxbWWXhA
	 gIAEwiCm4/omiSFpKm2EZXoMjq3K/8wfZcoLKrriQx/Q10xTSH0ySdih6eRVHU6OXT
	 KXpy4H5Wo3NbXFcg+gxrB0QTZ50j9/pGjL5PTNeGrfjOebkS41TasaT9o+gK4eKbd+
	 uIqzwulH2797w==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org
Subject: [PATCH 4/5] perf header: Validate bitmap size before allocating in do_read_bitmap()
Date: Wed, 15 Apr 2026 21:14:23 -0300
Message-ID: <20260416001424.362797-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416001424.362797-1-acme@kernel.org>
References: <20260416001424.362797-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

do_read_bitmap() reads a u64 bit count from the file and passes it
to bitmap_zalloc() without checking it against the remaining section
size. A crafted perf.data could trigger a large allocation that would
only fail later when the per-element reads exceed section bounds.

Additionally, bitmap_zalloc() takes an int parameter, so a crafted
size with bits set above bit 31 (e.g. 0x100000040) would pass the
section bounds check but truncate when passed to bitmap_zalloc(),
allocating a much smaller buffer than the subsequent read loop
expects.

Reject size values that exceed INT_MAX, and check that the data
needed (BITS_TO_U64(size) u64 values) fits in the remaining section
before allocating.

Currently used by process_mem_topology() for HEADER_MEM_TOPOLOGY.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425@smtp.kernel.org/
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3302748bac786fdf..e1fed6f1c5e2fa4b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -300,6 +300,11 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
+	/* bitmap_zalloc() takes an int; reject u64 values that truncate. */
+	if (size > INT_MAX ||
+	    BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64))
+		return -1;
+
 	set = bitmap_zalloc(size);
 	if (!set)
 		return -ENOMEM;
-- 
2.53.0

