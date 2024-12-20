Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200122618F
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732257; cv=none; b=FTPcFNBBCArryCbmcFbt9R81ullMt6bXSU5r27ZrJe20odHX8AYMXkp2Pu9rq6JnHdQDKW3nb9Mtl9VmhYPh/aJA7r/mn2y/ibdnoKeZbYQ9dMBsJIZylMAfwFkRuekGmY5COnYh9Z2xQ7fIW5TlvlR2bV9BFzlXkSeIdWGrUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732257; c=relaxed/simple;
	bh=sA/9dEIbKuwOUymTtSJlENUquC25SlB4XZX4SyfDJ7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSXayHHylVIXyZoxJGR3FzxTd63z0yzezKblzpgLt4dFd9gIq6X52U9nHCJWsvxec7mITVDk1ipZf0VXl1nK4GyU1p/n/dL6aMSbqGfWsEVkv/rz81J1/w54h89iRo/ZBbiqhnR23p2xsFChGZmkW0Ch4SiyPEummwVymbkItt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYIPqOQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYIPqOQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5QGb/n83WBEMPbcqyUNdqdVVY+jof7GeI1W7lRpwyk=;
	b=KYIPqOQCgrgrYoN6kQmsAfnv31NwVHvxsTvB8/bZ0SAH6AaCqzf6udbvrjY7haMqNwYf4V
	ZGUK+M95A/FIAqhYrPiS8zW6VW8CkuxDN9byYVSBQBnCbq6fvD2xeMGnxseCktkZglCYXL
	XW5x0LLiBD8cMoYMDNkh3bUhXy/86nE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-6kuyJjNDMQeYASNxNf-TrA-1; Fri,
 20 Dec 2024 17:04:09 -0500
X-MC-Unique: 6kuyJjNDMQeYASNxNf-TrA-1
X-Mimecast-MFC-AGG-ID: 6kuyJjNDMQeYASNxNf-TrA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E2E919560BE;
	Fri, 20 Dec 2024 22:04:06 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9273719560A2;
	Fri, 20 Dec 2024 22:04:04 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 09/10] perf test: Format log directories for shell tests
Date: Fri, 20 Dec 2024 23:03:33 +0100
Message-ID: <20241220220334.69198-10-vmolnaro@redhat.com>
In-Reply-To: <20241220220334.69198-1-vmolnaro@redhat.com>
References: <20241220220334.69198-1-vmolnaro@redhat.com>
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
---
 tools/perf/tests/builtin-test.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3458db9c41e370a5..eb32284b3bbed59d 100644
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
@@ -218,6 +219,21 @@ static bool test_exclusive(const struct test_suite *t, int subtest)
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
@@ -263,10 +279,12 @@ static bool create_logs(struct test_suite *t, int pass){
 
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

