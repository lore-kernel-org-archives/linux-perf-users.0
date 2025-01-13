Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC41C242C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792827; cv=none; b=XtgdSXQ+qktr8VNlcsjParB7ZRvyzGHYQbLl9fgWHuSstjs/hBh+2zl4PgHedd1l/vjD73z0BL7VLLZuvKM2jPZfpdALeGyEl44ClZZ/+WBWCjaiXDpmgRwTJedRvnAY1xbUGs6MpNpVRgfuhRJS0MXp7Qr/NIQJha/pya/ZX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792827; c=relaxed/simple;
	bh=OM0E0woEBP7P073jF98a/dRKlk6sd9L8dRuNMETBaX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVsoSZqzAQOivsIM+jVswkepF77rYCw1Poo+wsArSZ44odo3jC95EENo1rhZIlEutAV7FisbSel5J4Ff6sIXtX+UcH2rRFNZwao/SZM7oEB3crwtjk01uv4/bXb3diGOZe7/DDKLteC5HuNZ9fDL5rHcgDCRDUa6PBxWuzddsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKRSfE/R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKRSfE/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6HvSh47g4Nz0xxyVe6oxTb9FF22KHwiZYasrtpKJTg=;
	b=jKRSfE/RIts9O9QwknmyT6SlAs+WA/2RecrnvjXE7T05jojIKT7MVJyXBRpJHrXNJqlAfH
	1k8+sNV91yNhYcDf1JxiymcOPB0jqBJhmlC0MjSK2ztXfAliK8b9PgBgDDpj1c7aFIi87O
	jyth6Jvl+eiLERfqOHiG/dSEmqSztSE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-PlY4NpPeP6eV1mbJMcycDQ-1; Mon,
 13 Jan 2025 13:27:01 -0500
X-MC-Unique: PlY4NpPeP6eV1mbJMcycDQ-1
X-Mimecast-MFC-AGG-ID: PlY4NpPeP6eV1mbJMcycDQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A971D1955D81;
	Mon, 13 Jan 2025 18:27:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8573719560BC;
	Mon, 13 Jan 2025 18:26:58 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 09/10] perf test: Format log directories for shell tests
Date: Mon, 13 Jan 2025 19:26:04 +0100
Message-ID: <20250113182605.130719-10-vmolnaro@redhat.com>
In-Reply-To: <Z4UwHy-Kj9XDI9cf@x1>
References: <Z4UwHy-Kj9XDI9cf@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Veronika Molnarova <vmolnaro@redhat.com>

The name of the log directory can be taken from the test suite
description, which possibly could contain whitespace characters. This
can cause further issues if the name is not quoted correctly.

Replace the whitespace characters with an underscore to prevent the
possible issues caused by the name splitting.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/builtin-test.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d9c1453051e5c99c..fd4e315a6f90f477 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -4,6 +4,7 @@
  *
  * Builtin regression testing command: ever growing number of sanity tests
  */
+#include <ctype.h>
 #include <fcntl.h>
 #include <ftw.h>
 #include <errno.h>
@@ -217,6 +218,21 @@ static bool test_exclusive(const struct test_suite *t, int subtest)
 	return t->test_cases[subtest].exclusive;
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
@@ -262,10 +278,12 @@ static bool create_logs(struct test_suite *t, int pass){
 
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
2.43.0

