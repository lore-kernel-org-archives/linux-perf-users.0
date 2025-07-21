Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9872D9489
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104426; cv=none; b=BOnYAX36vffqA4giOo0fu7CJ7QAvs8Vu9CrrrFVD9VgqalG2VnYJnPWAkHosZb/dEC4xsqGHn7u/ELhynjrM1yRs5VAgxf1iNXl2SL+UnKyokMqD8HA6uAdh7CyvNVo6iLEbkx6hPheMp8UT6ZKu1k1iDAvFDg+h56+41RbaYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104426; c=relaxed/simple;
	bh=YUxVUb00HUs0njCWtEiMn1sXzp8MPioVuV5RDubPauc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPFINn7392wl7YnONnWV/SMpMpf3qfx9NjdwnxVk3EZGce4LaSeceBeKPxzpd8YlThd0W/hCJBwXzCjnThilYn65SLcDUaEc8fFDW3Q71OVsHRUx9fVqx8RBIlkMuOegl7IJQGX9wzrYjJM91O6wlOnpoYLwWQmERyoy5ahDV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKQJEtRb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKQJEtRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/PUPw+4RFlXfjAT9t38nOmsDIJ+KAn5fY2r+K/1XvY=;
	b=aKQJEtRbL9QSVEClCoFosmTKGmOsmO7/2Gc3s6JemSbuPOfY1ZgTTr8RVKuTvn/O5+zEZk
	+3tMrgTx0MdhlqhdRWhsoASj2YcZvO5UCIczBEYZEARCxP3DqT1euTZYnSKKI1DyqkO+q+
	MxTWYZ6f6cKg7iJcfd4vo1vlleBOtlQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-9c6MVV8mOCO1P6vqiXgCog-1; Mon,
 21 Jul 2025 09:27:02 -0400
X-MC-Unique: 9c6MVV8mOCO1P6vqiXgCog-1
X-Mimecast-MFC-AGG-ID: 9c6MVV8mOCO1P6vqiXgCog_1753104421
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05DD418001C6;
	Mon, 21 Jul 2025 13:27:01 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 382A119560AF;
	Mon, 21 Jul 2025 13:26:58 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: vmolnaro@redhat.com
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v3 6/7] perf test: Format log directories for shell tests
Date: Mon, 21 Jul 2025 15:26:41 +0200
Message-ID: <20250721132642.40906-7-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-1-jbrnak@redhat.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

The name of the log directory can be taken from the test suite
description, which possibly could contain whitespace characters. This
can cause further issues if the name is not quoted correctly.

Replace the whitespace characters with an underscore to prevent the
possible issues caused by the name splitting.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 89b180798224..9cb0788d3307 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -283,6 +283,21 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
+/* Replace non-alphanumeric characters with _ */
+static void check_dir_name(const char *src, char *dst)
+{
+	size_t i;
+	size_t len = strlen(src);
+
+	for (i = 0; i < len; i++) {
+		if (!isalnum(src[i]))
+			dst[i] = '_';
+		else
+			dst[i] = src[i];
+	}
+	dst[i] = '\0';
+}
+
 static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
 						 int typeflag, struct FTW *ftwbuf)
 {
@@ -328,10 +343,12 @@ static bool create_logs(struct test_suite *t, int pass){
 
 static char *setup_shell_logs(const char *name)
 {
-	char template[PATH_MAX];
+	char template[PATH_MAX], valid_name[strlen(name)+1];
 	char *temp_dir;
 
-	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) < 0) {
+	check_dir_name(name, valid_name);
+
+	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", valid_name) < 0) {
 		pr_err("Failed to create log dir template");
 		return NULL; /* Skip the testsuite */
 	}
-- 
2.50.1

