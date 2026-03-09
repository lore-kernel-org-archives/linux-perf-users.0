Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749D262FDC
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071872; cv=none; b=RYWYqWm77ClZNZ6Rxn/bJMUml4vBmOhbBZA00EojB7YBX52oODGFSGq9NXup3h4Y4hD6JI+uOD6o78U5TRuGP70HfNR51gKm/weURY2UlHWs5Q662p2pShuvK5U7HuhLurvMTIxfunySAXbQWoA7weJnxcceNb3oXJEzhhrtVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071872; c=relaxed/simple;
	bh=KQS2PPwV3MLasLoPpuDruw3WF/8dHwawvXc4CooJGaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGk/rKnzhaMhI7EUsVeJg9lUQB9jIiaLqVGKAHAqsWp06jl6QaMYHdVXWYlb3kiz1fmvFwk/9fLx9WUAYSYeBV+fnKjYCNWpkgxA1tGMTmjWbtCcszIy+e7F6k92Zx/woaSrGlYgG4Sl+6QL+iZHYvgiEFV5zCAQYwbKi1PErww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5iSfmGo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5iSfmGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773071870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXKbmNqN462v4kFz6GSVUeCrN4cJT672fycZHd0W6sg=;
	b=R5iSfmGoQNz/1HFizuydkkW1fVwd2AtyChxHQ+oENB6vL9F5BYDof1FYPtGifhBvu2thL9
	5ZsX3vbiZxEQeA1Gk80C5xLHvqcFABYGLdsKhjLILLxOiVcnqBRUf40XwDoJlkpOOnuXh1
	OV9D4LAkvcn46rYStf6pGHMjfKlosZo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-cqbUcv-qPxGIRgT0Ua1f8Q-1; Mon,
 09 Mar 2026 11:57:48 -0400
X-MC-Unique: cqbUcv-qPxGIRgT0Ua1f8Q-1
X-Mimecast-MFC-AGG-ID: cqbUcv-qPxGIRgT0Ua1f8Q_1773071867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90E91800245;
	Mon,  9 Mar 2026 15:57:47 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AB7F30001BB;
	Mon,  9 Mar 2026 15:57:45 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v6 7/7] perf test: Fix relative path for 'stderr-whitelist.txt'
Date: Mon,  9 Mar 2026 16:57:28 +0100
Message-ID: <20260309155728.98026-8-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-1-jbrnak@redhat.com>
References: <20260309155728.98026-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The test scripts for 'perf report' profiles  were failing to locate
the 'stderr-whitelist.txt' file.

The path was specified simply as "stderr-whitelist.txt", which relies on
the current working directory when the script runs.

This patch updates the path to use the relative directory variable
'$DIR_PATH' (which points to the current directory of the test script),
ensuring the correct file is found regardless of the current working
directory.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/shell/base_report/test_basic.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
index 0dfe7e5fd1ca..b42726655d20 100755
--- a/tools/perf/tests/shell/base_report/test_basic.sh
+++ b/tools/perf/tests/shell/base_report/test_basic.sh
@@ -240,7 +240,7 @@ PERF_EXIT_CODE=$?
 	"# Overhead   Latency  Command" < $LOGS_DIR/latency_default.log
 CHECK_EXIT_CODE=$?
 "$DIR_PATH/../common/check_errors_whitelisted.pl" \
-	"stderr-whitelist.txt" < $LOGS_DIR/latency_default.err
+	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/latency_default.err
 (( CHECK_EXIT_CODE += $? ))
 
 print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "default report for latency profile"
@@ -255,7 +255,7 @@ PERF_EXIT_CODE=$?
 	"#  Latency  Overhead  Command" < $LOGS_DIR/latency_latency.log
 CHECK_EXIT_CODE=$?
 "$DIR_PATH/../common/check_errors_whitelisted.pl" \
-	"stderr-whitelist.txt" < $LOGS_DIR/latency_latency.err
+	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/latency_latency.err
 (( CHECK_EXIT_CODE += $? ))
 
 print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency report for latency profile"
@@ -271,7 +271,7 @@ PERF_EXIT_CODE=$?
 	< $LOGS_DIR/parallelism_hierarchy.log
 CHECK_EXIT_CODE=$?
 "$DIR_PATH/../common/check_errors_whitelisted.pl" \
-	"stderr-whitelist.txt" < $LOGS_DIR/parallelism_hierarchy.err
+	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/parallelism_hierarchy.err
 (( CHECK_EXIT_CODE += $? ))
 
 print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "parallelism histogram"
-- 
2.52.0

