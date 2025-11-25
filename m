Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9451DF246
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086235; cv=none; b=D+3IFgYYbvSLrnks7bPZ4LxGFp/c3r/jrIQg55hWX7Obv58nOpTbKOqE15Kb3ZcWGDZ9xsuGroKbfum5M2RBUTD9Lo2U769BaHbp1j/rHFqhSf9flhlF4B91N4L5jHpg/ErHWrHjFKHB4ul0wU+/d/EzDFILvQTqkpiJBQqvUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086235; c=relaxed/simple;
	bh=l+xy/P46jjTDlmoJhtieeNi9uzVPEMm+C/Ej8hdo2ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJull+pa/3VV3sv8tyLFtJfRyeMJua9t8lH1RiKsHTa2/9CO7Lga6RIQVRxsc8XH8kr1BqSjfbg/FfAYg/mqa2+8NQkdP/VGcC+L5Xzt8WIA+s1C1B2SwgQ8YFTWRhvvUOkbHHDFlf1UxotVIa5mxyKtE/5iWfZ6RSUHtUKqiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVxKE2mK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVxKE2mK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764086233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOmw131+gQ1vRhVkDull868gAuS9VAMIaxP9O7rOZ/M=;
	b=cVxKE2mKzT7xBkc71x6CbtHewpxvp7U00QdHBjZNrty2oHYiPnbr2Ar7GIsQRissVzRTaS
	n5hL6/JXQOeYPN41Ybc/ixOLOOjhJV8wXgVPmlbfK4an0MdUCm1bBLrUPVkxTUMLjT7hOl
	QWYswfqb45JepYs5vl4cfUmCGfKRdlA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-rDDwmJKCMiiKQIMmwnBqMg-1; Tue,
 25 Nov 2025 10:57:09 -0500
X-MC-Unique: rDDwmJKCMiiKQIMmwnBqMg-1
X-Mimecast-MFC-AGG-ID: rDDwmJKCMiiKQIMmwnBqMg_1764086228
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D15FB180034A;
	Tue, 25 Nov 2025 15:57:08 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D609A180047F;
	Tue, 25 Nov 2025 15:57:06 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v5 7/7] perf test: Fix relative path for 'stderr-whitelist.txt'
Date: Tue, 25 Nov 2025 16:56:48 +0100
Message-ID: <20251125155648.197527-8-jbrnak@redhat.com>
In-Reply-To: <20251125155648.197527-1-jbrnak@redhat.com>
References: <20251125155648.197527-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The test scripts for 'perf report' profiles  were failing to locate
the 'stderr-whitelist.txt' file.

The path was specified simply as "stderr-whitelist.txt", which relies on
the current working directory when the script runs.

This patch updates the path to use the relative directory variable
'$DIR_PATH' (which points to the current directory of the test script),
ensuring the correct file is found regardless of the current working
directory.

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
2.51.1

