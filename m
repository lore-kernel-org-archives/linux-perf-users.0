Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47213DFC7E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071870; cv=none; b=s3s+XC1PbAohJJV/VmUq2H1w9pLwV1v5U40dfVL3WRTe89vjkL31xqFSWxwR56GDP7Kq72W3RShQsaVbwfNIhD/NzYJCPEnaQRX3IX2Og0pj7ecIfX3O+4njYTRPTRjE2QjOYstkUkNEy3oskXXvhDEkgnixIF/MKdAe1cstupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071870; c=relaxed/simple;
	bh=zSL++E3TsfmJPSrorVdMLuXRix+Z/YAAoxKcfezDdxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZhhCN9TGzG0yNh1WdPkI/EWEMewkcdgm0T7FG3u2/8ETZlXVuP6YASB/XQlzC7PeMHc1d525//RXKCmo5tXau3B6SPelC5Kir2LpA2p1Ow+cDasZiYqH1Pb84WEv+Orz4ZrQ1jUQr8K10eaEAEpy9hvyK9oJEMW2mO0EX84GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHLaLDod; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHLaLDod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773071867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tH+kVrAKCVv4+Ko8hf4nVXeH469nDjKaaxHS9iFqfc=;
	b=dHLaLDod3RQDjchWKeriZuBS5gSLGfO8yD1I47sz+qHb2PNofExdC2XBdKLWaO5gbOeq11
	3aFcJ5Mc6GmC5slEn9Qx4+XzpuWx54bIP/BbqXvix8lSoIj8fluAsPbr9pgq8OR2igIY/a
	xBu6O32AfcXcOkmpqmP+cIscwO1mZZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-Llp0GWmDMQ2K1L2rRfO-KQ-1; Mon,
 09 Mar 2026 11:57:44 -0400
X-MC-Unique: Llp0GWmDMQ2K1L2rRfO-KQ-1
X-Mimecast-MFC-AGG-ID: Llp0GWmDMQ2K1L2rRfO-KQ_1773071863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE7B418005B0;
	Mon,  9 Mar 2026 15:57:43 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBE6730001A2;
	Mon,  9 Mar 2026 15:57:41 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v6 5/7] perf test: Format log directories for shell tests
Date: Mon,  9 Mar 2026 16:57:26 +0100
Message-ID: <20260309155728.98026-6-jbrnak@redhat.com>
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

The name of the log directory can be taken from the test suite
description, which possibly could contain whitespace characters. This
can cause further issues if the name is not quoted correctly.

Replace the whitespace characters with an underscore to prevent the
possible issues caused by the name splitting.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/builtin-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 70f4a61357ec..cbfae7dcf2b6 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -292,6 +292,7 @@ static bool test_exclusive(const struct test_suite *t, int test_case)
 	return t->test_cases[test_case].exclusive;
 }
 
+
 static int delete_file(const char *fpath, const struct stat *sb __maybe_unused,
 						 int typeflag, struct FTW *ftwbuf)
 {
@@ -340,12 +341,19 @@ static char *setup_shell_logs(const char *name)
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
2.52.0

