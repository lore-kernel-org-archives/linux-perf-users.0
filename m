Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BBA1DF246
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086230; cv=none; b=OS0KviGEIqoDx+jmmGiQL0DLzcST90t8dc7crYUxPzreiVIA4rEYfRG/T02nC7dwD8cUBasfgR5lxPT+y4BdF8KpGOd9oIwOPAgyKwBhfNMjkeQg9s5ROITiqkxAJBj6fsBrC5FHqOZWmZBs6fdinvw80tB+5cGktla6P5BsM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086230; c=relaxed/simple;
	bh=CuNNYaRNbKsylBNGOkjg5SXXAoZc6Cs9jtkyMAwXq+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWv7d7jIjiP6xhtLPNDzsCCARz/VrS3dMfPKk1LoHmox864DccHl1RrmSbKTU4ZK/ILNhHmu6W/wNamlYVUd8Jxekl1exS509iY52zF+Wn9gW3j8npZCKrZqKIxPrPkWmkPVLOYl7n9KR10GiaJUFkMPboGtO8JeWpBzhIg/mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYJu8mDo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYJu8mDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764086227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTOS1n1dnvgvpZi0lGBe8+OmECYGl6LP41qHJk852BE=;
	b=HYJu8mDo7ZKQsqtOVsdKZi46eEmmMJs3hwtrLqW39q6BkPkybq7ATNbmbcyVf6IHqOWpky
	5vSoxcoeqOvuq/QbpmXhf1CtBgbZJZKPsI/H6sEGdp09ulRJvjqc1yuu96tygb9CCgKl4J
	Z1j+W2P25q9gCwKWrq0kSJMpDb6CeLc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-LYtI1mPzMeWhuxRK_J1DmQ-1; Tue,
 25 Nov 2025 10:57:05 -0500
X-MC-Unique: LYtI1mPzMeWhuxRK_J1DmQ-1
X-Mimecast-MFC-AGG-ID: LYtI1mPzMeWhuxRK_J1DmQ_1764086224
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5304C180028A;
	Tue, 25 Nov 2025 15:57:04 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DAE91800361;
	Tue, 25 Nov 2025 15:57:02 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v5 5/7] perf test: Format log directories for shell tests
Date: Tue, 25 Nov 2025 16:56:46 +0100
Message-ID: <20251125155648.197527-6-jbrnak@redhat.com>
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
 tools/perf/tests/builtin-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e5a4e86db644..7de7baed1254 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -283,6 +283,7 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
+
 static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
 						 int typeflag, struct FTW *ftwbuf)
 {
@@ -331,12 +332,19 @@ static char *setup_shell_logs(const char *name)
 {
 	char template[PATH_MAX];
 	char *temp_dir;
+	size_t i;
 
 	if (snprintf(template, PATH_MAX, "/tmp/perf_test_%s.XXXXXX", name) < 0) {
 		pr_err("Failed to create log dir template");
 		return NULL; /* Skip the testsuite */
 	}
 
+	/* Replace non-alphanumeric characters with _ in the name part */
+	for (i = 15; template[i] != '.' && template[i] != '\0'; i++) {
+		if (!isalnum((unsigned char)template[i]))
+			template[i] = '_';
+	}
+
 	temp_dir = mkdtemp(template);
 	if (temp_dir) {
 		setenv("PERFSUITE_RUN_DIR", temp_dir, 1);
-- 
2.51.1

