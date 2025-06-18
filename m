Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044952EBDE1
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257238; cv=none; b=rMmjsuHMkSwe+qbLPHuexA+ZinTeqVfYVQnOr6gSGisuotJYyyj+0C8Tx4HI38g/l13YdtikmJXQgIRds4Oc9LVlgHRGKc0IAI5R1i9eIMvatwfoZ6PW5b0Y5vb2sBGXuLZFsY/CBdszV4CSn0HB90E/bRvv1h//mU4mUy3SHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257238; c=relaxed/simple;
	bh=IuclGL3p30oIbP2AKB4NxZtY4r0crOI62MBuyy+OHB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5D8cQmVWxreMPz+6/ErQfzjvj/Jq4ihbKoqW7MUXloerLTpZkaNeoT8BT3uIFLqn2Tt/Ypzp+VGNK5d3IXJ7edMaIJEt1F3sC/zae6DTHocyzeskGWmSBp5vRmh/aGXaBrJRssmZwN7YkX6RJ6szSWExEUOIgX+40NW5wn3+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhLhgqRu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhLhgqRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750257234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3buU+XoaO5NA67HTQ3GyaQ6Tb90oSBtpsv3wtaow9eI=;
	b=HhLhgqRuSLD6y5hcqBD90l8Hlcdceb7ZdXeGJChgar1DtGxcMveDH9JZ/6EBQ5F+1EnHpH
	rteZ6BDXZbpJBUY8MM2TTLmOaZoLa90FEkLVl0y/5n088KuuYilEvs4sxFI/YBlou4u/le
	+JRRHVQUzVTgyq8litoX6bKykfsOnGA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-LscT4CICM-egzQvatlxhhg-1; Wed,
 18 Jun 2025 10:33:52 -0400
X-MC-Unique: LscT4CICM-egzQvatlxhhg-1
X-Mimecast-MFC-AGG-ID: LscT4CICM-egzQvatlxhhg_1750257231
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02AE819560B3;
	Wed, 18 Jun 2025 14:33:50 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.89.123])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CB4619560AF;
	Wed, 18 Jun 2025 14:33:43 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	james.clark@linaro.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] perf header: remove unecessary core id test
Date: Wed, 18 Jun 2025 10:29:22 -0400
Message-ID: <20250618142921.4053400-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It is possible for systems to have a greater socket id number than the
number of cpus present on a machine, so this test is obselete and should
be removed.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/header.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..d7f6ff6974aa 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2559,7 +2559,6 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	int cpu_nr = ff->ph->env.nr_cpus_avail;
 	u64 size = 0;
 	struct perf_header *ph = ff->ph;
-	bool do_core_id_test = true;
 
 	ph->env.cpu = calloc(cpu_nr, sizeof(*ph->env.cpu));
 	if (!ph->env.cpu)
@@ -2614,15 +2613,6 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 	}
 
-	/* On s390 the socket_id number is not related to the numbers of cpus.
-	 * The socket_id number might be higher than the numbers of cpus.
-	 * This depends on the configuration.
-	 * AArch64 is the same.
-	 */
-	if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
-			  || !strncmp(ph->env.arch, "aarch64", 7)))
-		do_core_id_test = false;
-
 	for (i = 0; i < (u32)cpu_nr; i++) {
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
@@ -2633,12 +2623,6 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
 
-		if (do_core_id_test && nr != (u32)-1 && nr > (u32)cpu_nr) {
-			pr_debug("socket_id number is too big."
-				 "You may need to upgrade the perf tool.\n");
-			goto free_cpu;
-		}
-
 		ph->env.cpu[i].socket_id = nr;
 		size += sizeof(u32);
 	}
-- 
2.49.0

