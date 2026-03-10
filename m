Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BA2857F0
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165597; cv=none; b=Pj5EbNSwjKr4/b3FPOIeiO/Ogj4okYlJUdVrS5JawnHUkOJHeDEYkEZ4Au5sCbCfbLF6Z+1Ud1uEtrFP3JWkvmG2uJdIkpdinBFiJcLG+Hr54aSH7L0FXv7gyG5MLKALmOCmAKDKK5Lh/oGGaoXRrnJPRzw20hVrp7HyEzfdxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165597; c=relaxed/simple;
	bh=BulqueY2ZgnknkLPrfAhmT9uh9IL/k8A192OgroQeIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CF5pMWM3h5fM9dyIowYP6szfRSKGoMHQR6pllAiVChsYqjHE3sGnSgU2z4o8KF91BrTUSCovoTleoVUH5imNSOLORZjfsC75qlC6Ts6hPunT0PHhibGyZipZYHkKVmtl+T+pVzxem58peLB8c6vWmg+9RQqKJwBnADanoXHpWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgqIRDzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgqIRDzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA48C19423;
	Tue, 10 Mar 2026 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165596;
	bh=BulqueY2ZgnknkLPrfAhmT9uh9IL/k8A192OgroQeIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CgqIRDzrxhNOi0KIehID6ibIDjVZuSaeQVgiGZ4yznVNzIcSnTturBO2URGSBxMqF
	 SjVNUXqiKJ2NMuAegH/nzxoywACJu71Mg19O8AXLtmsJHbzH+Oe0rlDo7JEltEWLrs
	 xH8u5ToGt+C2+10deaTcs7NQWnZsOXI0UVNUm3GVydB5EszWBbjftUvXW6RlwrjNq9
	 91qgX+wDcISCSJP1iOY4pAQY+yhrOCwREOPHQ+AaPMkHRARiJ44WqxYXoXR5bfr1Ws
	 qW/kcac4uO/F60n4F2u2e0ilYPVCLOyIGlfu7kj10iIwQ9Nrdvk8YnW06cB7VGZtKa
	 XH2KH1h2D+WtQ==
From: Chuck Lever <cel@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] perf synthetic-events: Fix stale build ID in module MMAP2 records
Date: Tue, 10 Mar 2026 13:59:51 -0400
Message-ID: <20260310175951.29500-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

perf_event__synthesize_modules() allocates a single union
perf_event and reuses it across every kernel module callback.
After the first module is processed,
perf_record_mmap2__read_build_id() sets
PERF_RECORD_MISC_MMAP_BUILD_ID in header.misc and writes that
module's build ID into the event. On subsequent iterations the
callback overwrites start, len, pid, and filename for the next
module but never clears the stale build ID fields or the
MMAP_BUILD_ID flag. When perf_record_mmap2__read_build_id()
runs for the second module it sees the flag, reads the stale
build ID into a dso_id, and __dso__improve_id() permanently
poisons the DSO with the wrong build ID. Every module after
the first therefore receives the first module's build ID in
its MMAP2 record. On a system with the sunrpc and nfsd modules
loaded, this causes perf script and perf report to show
[unknown] for all module symbols.

The latent bug has existed since commit d9f2ecbc5e47 ("perf
dso: Move build_id to dso_id") introduced the
PERF_RECORD_MISC_MMAP_BUILD_ID check in
perf_record_mmap2__read_build_id(). Commit 53b00ff358dc ("perf
record: Make --buildid-mmap the default") then exposed it to
all users by making the MMAP2-with-build-ID path the default.
Both commits were merged in the same series.

Clear the MMAP_BUILD_ID flag and zero the build_id union
before each call to perf_record_mmap2__read_build_id() so
that every module starts with a clean slate.

Fixes: d9f2ecbc5e47 ("perf dso: Move build_id to dso_id")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/perf/util/synthetic-events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ef79433ebc3a..ddf1cbda1902 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -703,6 +703,11 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
 
 		memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
 
+		/* Clear stale build ID from previous module iteration */
+		event->mmap2.header.misc &= ~PERF_RECORD_MISC_MMAP_BUILD_ID;
+		memset(event->mmap2.build_id, 0, sizeof(event->mmap2.build_id));
+		event->mmap2.build_id_size = 0;
+
 		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
 	} else {
 		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
-- 
2.53.0

