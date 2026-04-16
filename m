Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8B1E520A
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338087; cv=none; b=jGWBegXilF2K/3XShuGMb1VfFRFixioY+aOr+P/WbKZg/UvHmiDw7Ucp/3V3FK6v8fEfNSrAm/2Ivo2XLDp3D4Prj44LtySiHzkdUxW72V0nMJbMFV8rbrBQq/PJJs/mfqzc1RjcoWbhxQt5cxP0gUIj0olzYVNmWhBTUaTaPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338087; c=relaxed/simple;
	bh=ri0j4icrJgokH6uQmEeEQ3FGijtNUEPvPHmBr6dkpYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJEjKSu8c1Z50LRFDqasAlyLbl9+tFNLe+2p9FLHq9OKlrwslw8fznd9RyDexNJm5IBRBZnSZ+MTvCzHvNSSI/HPlB9kCa3Dok3HpTMpQPnt00E3wp0qQvSOed1Y9y0g/xNnJgOPvzQgzh897Nvxrs5XnWu5NcjdZqbbMkWKXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ge7J1VUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge7J1VUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lW4lCH3pSVgY5RxZrxgXk0fjUTHB4q8wJfRYCZ274wc=;
	b=ge7J1VUUINp5Olv/zimlTBq/IAkjdI1o1qnkdDgeTUQC3PR2KCtALm2aaqeSb6V1KiJsHX
	AQvJRgsAlwAsFcr17nVUT2agO2yYL6do2mZd+xsRnnqBVm1WDbG20p/Qc3JqIXbVaGBlpK
	mrTrxhv1Ns/43Q8iO3wJz+2jkeMYJFo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-QHUU7yC2Ol-HbZd7Im41WA-1; Thu,
 16 Apr 2026 07:14:42 -0400
X-MC-Unique: QHUU7yC2Ol-HbZd7Im41WA-1
X-Mimecast-MFC-AGG-ID: QHUU7yC2Ol-HbZd7Im41WA_1776338081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 132121800370;
	Thu, 16 Apr 2026 11:14:41 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DC59180047F;
	Thu, 16 Apr 2026 11:14:38 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 7/7] perf test: Fix relative path for 'stderr-whitelist.txt'
Date: Thu, 16 Apr 2026 13:14:19 +0200
Message-ID: <20260416111419.385010-8-jbrnak@redhat.com>
In-Reply-To: <20260416111419.385010-1-jbrnak@redhat.com>
References: <20260416111419.385010-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test scripts for 'perf report' profiles were failing to locate
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
2.52.0

