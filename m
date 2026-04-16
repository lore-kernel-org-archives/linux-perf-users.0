Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABD383C7E
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338080; cv=none; b=riYWlQMO34WxuEHGB6XDmKKjDmox5Sx/QiTAhpJI7m1zjRmCIMA4XHqNvnp12Sg0EzrgRP86hXDuBQ//nS5mJqbyN8q8NqwsJtkZyvjmnUP6qqdW3y4hrSvMCjmIDKnt34WPw0UCKo1Mvc0OMo+Vx22nlOH/+BVQkbLxHkTNrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338080; c=relaxed/simple;
	bh=TNbskKcGxWaVsii3DvZi6ldJtlFWYiu274Jj3QxE+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5TyQyfmy6blsdO/i2tQhYpuEVJ+cbYF1NphMIJNbq+dCK3QZOBqZAqULNV/gsOaSVS2K65lfksIFaAk/lhJJqHzTJ01ablMzfiS+UY7gaOgHgIXwWDQDhjjkAMp4Bi8KstnhsmM2HWaYzzIJTQM77GhZ+lUN4zHG6lWRJjFzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSwj7zZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSwj7zZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWO+gyeZiddRYEOQjBbGUMaJSKSggtq8pUwd58Xfnhg=;
	b=aSwj7zZT9gRtM0+EeW8yUZqK9pke1vgPIgM3s1X017+Wow89ICAdtj5oxPh2KD8TpTouXv
	+m6usW/gYBdrnjwXcxANyV+vSLf1fNFqYPWslEcvRPr4tPp3YA8alC4PbvQ+k/Xo0fEqyV
	W6hBgtZ7qQCZnd4zg9hp5tB0BLEt7sg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-5VxzRv2BN6me6JamMfOSYQ-1; Thu,
 16 Apr 2026 07:14:37 -0400
X-MC-Unique: 5VxzRv2BN6me6JamMfOSYQ-1
X-Mimecast-MFC-AGG-ID: 5VxzRv2BN6me6JamMfOSYQ_1776338076
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AC88195608B;
	Thu, 16 Apr 2026 11:14:36 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67B78180047F;
	Thu, 16 Apr 2026 11:14:34 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 5/7] perf test: Format log directories for shell tests
Date: Thu, 16 Apr 2026 13:14:17 +0200
Message-ID: <20260416111419.385010-6-jbrnak@redhat.com>
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

The name of the log directory can be taken from the test suite
description, which possibly could contain whitespace characters. This
can cause further issues if the name is not quoted correctly.

Replace the whitespace characters with an underscore to prevent the
possible issues caused by the name splitting.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 306ecfe5e22f..6cdff3687a82 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -342,16 +342,28 @@ static bool create_logs(struct test_suite *t, int pass)
 	return false;
 }
 
+static const char PERF_LOG_PREFIX[] = "/tmp/perf_test_";
+static const char PERF_LOG_SUFFIX[] = ".XXXXXX";
+
 static char *setup_shell_logs(const char *name)
 {
 	char template[PATH_MAX];
 	char *temp_dir;
+	size_t i, len;
 
-	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) >= PATH_MAX) {
+	if (snprintf(template, PATH_MAX, "%s%s%s", PERF_LOG_PREFIX, name,
+		     PERF_LOG_SUFFIX) >= PATH_MAX) {
 		pr_err("Failed to create log dir template");
 		return NULL; /* Skip the testsuite */
 	}
 
+	/* Replace non-alphanumeric characters with _ in the name part */
+	len = strlen(template);
+	for (i = sizeof(PERF_LOG_PREFIX) - 1; i < len - (sizeof(PERF_LOG_SUFFIX) - 1); i++) {
+		if (!isalnum((unsigned char)template[i]))
+			template[i] = '_';
+	}
+
 	temp_dir = mkdtemp(template);
 	if (temp_dir) {
 		setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
-- 
2.52.0

