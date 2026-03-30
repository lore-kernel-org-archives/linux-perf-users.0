Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAA274FD0
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899662; cv=none; b=f8h4494ouyVAJl3RF0FDXT0y3gKEqzJhVaZA2mt/Y+uZAsif7QeTdaQX915uCezn6AlybTVFnRLOIUq2EqGRSwsuAkYSbDWCMopaVdZhwoMVIuc7Uaq4JR6X338CYrhVV3Rh5/qCKiC+MGDv+OAXzr+yNm75Cz83a+C9dSCalHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899662; c=relaxed/simple;
	bh=NWGn9a7ziDSWwIvyG9ckiotofwWuL/EXu+QvXaesdtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G50N0olI8YNoVyO7a6UQTXpDH/S8JGjLEYbmkP+nyaNRvq4GF9Wb0/D8fZnkFo/yOKhmfZIQfpQd8wEjpgkRfFSPpch6QaEv4xFRODjrgjy/itkBJzEH/yBThufetkpNXIK+5+nVkULzIgwWLIJdLxstb9mFX+jBzMYkGB2xRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MATL0Guk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MATL0Guk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hYstAIu2Z41UFTnpSv7Ku2K8mlvOM2XlePwSeHib0FI=;
	b=MATL0GukL0+wE49ffGc7B0OwDSkONWwzwKQz+RBEgEBWp2OXKGN+ErYaxRJs3jBsUupLm+
	YIFiQyEODXN5J9yvnx0CiY6oG4n5X7LZrFE4wRlhGdvXplWmXiU3pNGMK4QxyxSGZuTrix
	Bt55jG0S8/qv9UOWRi5aL//kya1jQy8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-FhrlxAi-Oc28AdNYmC5wMw-1; Mon,
 30 Mar 2026 15:40:54 -0400
X-MC-Unique: FhrlxAi-Oc28AdNYmC5wMw-1
X-Mimecast-MFC-AGG-ID: FhrlxAi-Oc28AdNYmC5wMw_1774899653
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2747C1800345;
	Mon, 30 Mar 2026 19:40:52 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4DDC1955F42;
	Mon, 30 Mar 2026 19:40:48 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	james.clark@linaro.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] perf dso: prevent null dsos from being added and add comparator checks
Date: Mon, 30 Mar 2026 15:40:22 -0400
Message-ID: <20260330194021.212912-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently comparator functions in dsos.c don't check if the dsos array
entry contains a null value. This can lead to undefined behavior when
doing the comparison. So add null checks to comparator functions. Also
prevent __dsos__add from adding a null dso to the dso array.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/dsos.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 0a7645c7fae7..fcfed7dd37ff 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -118,7 +118,12 @@ static int __dso__cmp_long_name(const char *long_name, const struct dso_id *id,
 static int __dso__cmp_short_name(const char *short_name, const struct dso_id *id,
 				 const struct dso *b)
 {
-	int rc = strcmp(short_name, dso__short_name(b));
+	int rc;
+
+	if (!b)
+		return -1;
+
+	rc = strcmp(short_name, dso__short_name(b));
 	return rc ?: dso_id__cmp(id, dso__id_const(b));
 }
 
@@ -126,7 +131,16 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 {
 	const struct dso *a = *((const struct dso **)va);
 	const struct dso *b = *((const struct dso **)vb);
-	int rc = strcmp(dso__long_name(a), dso__long_name(b));
+	int rc;
+
+	if (!a && !b)
+		return 0;
+	if (!a)
+		return -1;
+	if (!b)
+		return 1;
+
+	rc = strcmp(dso__long_name(a), dso__long_name(b));
 
 	if (!rc) {
 		rc = dso_id__cmp(dso__id_const(a), dso__id_const(b));
@@ -146,6 +160,9 @@ static int dsos__cmp_key_long_name_id(const void *vkey, const void *vdso)
 	const struct dsos__key *key = vkey;
 	const struct dso *dso = *((const struct dso **)vdso);
 
+	if (!dso)
+		return -1;
+
 	return __dso__cmp_long_name(key->long_name, key->id, dso);
 }
 
@@ -196,6 +213,9 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
 {
+	if (!dso)
+		return -EINVAL;
+
 	if (dsos->cnt == dsos->allocated) {
 		unsigned int to_allocate = 2;
 		struct dso **temp;
-- 
2.52.0

