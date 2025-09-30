Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956A309DDB
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248594; cv=none; b=abDiiFvFgqK8T90XxCZzNdthg9Kw5J1s6V1vPAfR1QNssAjbG92G83Jjrl0JIQ76B7YPFg4Vxt1PPy3jJgKHi2SMlQtndvl13gKd0O0lWMgAhMxSuC8091u9E4LVx85pHZxHyZXB3DVQ2cDcsoAkisw5aqAkcvJZCn8rAq6bKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248594; c=relaxed/simple;
	bh=eET/CVW+q+oW9y3TGWNz+mBjq9oMByY6P4qAsMweSaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8eUJ69AsKBRSj4uohy36AUBkxzN3y3rv/7IH+7afGJpWtyJ8vgTvB56mbDWi80f4pDn/S4JrUKUUzzqi2aY/earTj+gmVJG8PasWRY7V2Eh8x/xbxn9NzQPlY7hC5b5ZBfUU/zGipf0noG8nCdklIFEnFIv6Ed8AEHwGu67nB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMuUdPSN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMuUdPSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1YEq6ELy8K8Nqeq5N3oXfqKNia1SV+oHLs2P3JgDuY=;
	b=fMuUdPSNTLVimDDtCHVSfoalFT+Ct1exELi+Ds8ZzoDezzi9ZBz8en+BIRK24TJxJf8+8n
	mV367+iH1fxFmO0io187eVxI1iU7Ytmx0b+sypq0PQPA4p1aWrgA/T6k6kLoBEBNf364f0
	rY780RrtJ9dWz4s5/Chx51N6uTU37Uk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-UPzPFjkRP-u1g8MnGyYMHg-1; Tue,
 30 Sep 2025 12:09:47 -0400
X-MC-Unique: UPzPFjkRP-u1g8MnGyYMHg-1
X-Mimecast-MFC-AGG-ID: UPzPFjkRP-u1g8MnGyYMHg_1759248586
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D2F219774EB;
	Tue, 30 Sep 2025 16:09:46 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D3E330002C5;
	Tue, 30 Sep 2025 16:09:43 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v4 6/7] perf test: Format log directories for shell tests
Date: Tue, 30 Sep 2025 18:09:22 +0200
Message-ID: <20250930160923.13728-7-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-1-jbrnak@redhat.com>
References: <20250930160923.13728-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 tools/perf/tests/builtin-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a943f66cbac0..c5f923d6f9fa 100644
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
2.50.1

