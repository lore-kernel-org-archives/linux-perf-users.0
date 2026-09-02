Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6413AF2;
	Wed,  2 Sep 2026 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332977; cv=none; b=PFuNSmscHuoWHpEieEiYPO6nVGGSDAIOPg6qy/6fW+86bxVNVI8742LWWRrrwjO107zf9LHYC5LKjDOZLAC4RgqpJd+t99cksIyVZ7NBbgF2falqLQTyU2avOGACb15KuCg9yB1DVkS+g622PefK1UmueFRE6puxZq0yQeWFm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332977; c=relaxed/simple;
	bh=djTETq3/L+pMQHSmKxNkofrEnCXepJq8qYnghLVcZRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiJ/mQAM0493wWyjpcj3qRQIeD4hNIQRiiKt8nwx7cUcCxCwT4/OFRMDCKsRU+D8dc06I4LAcBJ38L+jJo0JSN8/d2LlNaYBnvgOVa+rj3jVM1a6nIzQUdw1RUOMmdTAbCiugx5E/M/eTzxVloAukilSaMc8drpv2OILGCL3PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cf8b664a69d11f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7a5ad44e-fe2c-4b9a-8052-89e590bb65c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:5eb3c0f4635fac47f60dedcbaaa44301,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3cf8b664a69d11f19a56ed5b684f684d-20260902
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 960213064; Wed, 02 Sep 2026 15:09:28 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] perf bench numa: add NULL check after calloc()
Date: Wed,  2 Sep 2026 15:09:13 +0800
Message-ID: <20260902070913.1424-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two calloc() calls in the numa benchmark lack NULL return checks,
leading to potential NULL pointer dereferences on allocation failure:

1. worker_process(): the allocated `pthreads` array is used in the
   following for-loop via pthreads[t] without checking for NULL.

2. __bench_numa(): the allocated `pids` array is used in the following
   for-loop via pids[i] without checking for NULL.

Add BUG_ON() checks after each calloc(), consistent with the existing
NULL check style used elsewhere in the same file (e.g., node_present
and nodes allocations).

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/perf/bench/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 42d7afc03f9b..371a74e3da1b 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1419,6 +1419,7 @@ static void worker_process(int process_nr)
 	bind_to_cpumask(td->bind_cpumask);
 
 	pthreads = calloc(g->p.nr_threads, sizeof(pthread_t));
+	BUG_ON(!pthreads);
 	process_data = setup_private_data(g->p.bytes_process);
 
 	if (g->p.show_details >= 3) {
@@ -1625,6 +1626,7 @@ static int __bench_numa(const char *name)
 		return -1;
 
 	pids = calloc(g->p.nr_proc, sizeof(*pids));
+	BUG_ON(!pids);
 	pid = -1;
 
 	if (g->p.serialize_startup) {
-- 
2.43.0

