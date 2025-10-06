Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542032248AE
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773463; cv=none; b=ENaGZxbb9LcNwbrjxMwvByorNBkUAf1LqSj826w5lGxyLW9450CAAxufAu1nIDRDjFHYEMHZIIwwDNwbPHl/1Kl6Cyt8GQGfi/2m+r8y1r5Q4cMMD1ezA8/nDh/3awEWgwzSN/mxidCRcVj1iAeQBzHewdgTyWxYMWBIG6z48A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773463; c=relaxed/simple;
	bh=t8zZ5OspnjJ69t+/iJjAhC1FhP+39NniT01uLiLSSAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoIMHpbM3ykNSwKTpJuWxpD1BZE9FUgYVb15AMtkEUy1XW3TlKEHbHxDdw4QipnJyZK7GBQHCabRTA0RzcsPOlxh+ga1HmU35Z5ranteyjr2vODzdrcf9bw+FChJ0ItzEfFl3ary9TziJaZv5aodnkYhc2NtB0mjGRN+I7D1Tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=We8+QZaW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We8+QZaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759773460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5deb51mMV7rTWcAaFItZJsNp2cPy3FQMgCASF2mu0zQ=;
	b=We8+QZaWf3zDIhdgwb6QUBzG8XZhWHQ3Jk5QzboXMRrj639uXijcVJWzDx1TFQ1g7Aq3DQ
	NHKIxwidm7FUwezQG4DBhgIWA/R1+FAH5IuhQooHE1eEByZd7lGVflNorIumkAXyHuauCx
	ZCsezhlZ6zy0rWxLMxgPcNqx+g4WJog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-NOI7p-r-M1ixfR4p_h38_A-1; Mon,
 06 Oct 2025 13:57:37 -0400
X-MC-Unique: NOI7p-r-M1ixfR4p_h38_A-1
X-Mimecast-MFC-AGG-ID: NOI7p-r-M1ixfR4p_h38_A_1759773455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEFBF18005A2;
	Mon,  6 Oct 2025 17:57:19 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.22.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4544419560A2;
	Mon,  6 Oct 2025 17:57:15 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	irogers@google.com,
	namhyung@kernel.org
Cc: jmario@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 1/4] perf tools: Remove /SYSV from no_dso maps
Date: Mon,  6 Oct 2025 19:57:07 +0200
Message-ID: <20251006175710.1179040-2-mpetlan@redhat.com>
In-Reply-To: <20251006175710.1179040-1-mpetlan@redhat.com>
References: <20251006175710.1179040-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We will need it for upcoming commits. Also adjust the function
calls in perf-inject, in order not to break the logic.

Suggested-by: Jiri Olsa <jolsa@kernel.org>

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/map.c       | 5 +++--
 tools/perf/util/map.h       | 6 +++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a114b3fa1bea..cc090da5c445 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -773,7 +773,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 
 	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
 		return 0;
-	if (is_no_dso_memory(filename))
+	if (is_no_dso_memory(filename) || is_shared_memory(filename))
 		return 0;
 
 	if (inject->known_build_ids != NULL &&
@@ -813,7 +813,7 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 	/* Return to repipe anonymous maps. */
 	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
 		return 1;
-	if (is_no_dso_memory(filename))
+	if (is_no_dso_memory(filename) || is_shared_memory(filename))
 		return 1;
 
 	if (dso__read_build_id(dso)) {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b46c68c24d1c..6d13b4602970 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -133,12 +133,13 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 	if (ADD_RC_CHK(result, map)) {
 		char newfilename[PATH_MAX];
 		struct dso *dso;
-		int anon, no_dso, vdso, android;
+		int anon, no_dso, vdso, android, shared;
 
 		android = is_android_lib(filename);
 		anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
+		shared = is_shared_memory(filename);
 		nsi = nsinfo__get(thread__nsinfo(thread));
 
 		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
@@ -174,7 +175,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		assert(!dso__kernel(dso));
 		map__init(result, start, start + len, pgoff, dso, prot, flags);
 
-		if (anon || no_dso) {
+		if (anon || no_dso || shared) {
 			map->mapping_type = MAPPING_TYPE__IDENTITY;
 
 			/*
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9cadf533a561..616f32504e46 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -258,10 +258,14 @@ static inline int is_anon_memory(const char *filename)
 static inline int is_no_dso_memory(const char *filename)
 {
 	return !strncmp(filename, "[stack", 6) ||
-	       !strncmp(filename, "/SYSV", 5)  ||
 	       !strcmp(filename, "[heap]");
 }
 
+static inline int is_shared_memory(const char *filename)
+{
+	return !strncmp(filename, "/SYSV", 5);
+}
+
 static inline void map__set_start(struct map *map, u64 start)
 {
 	RC_CHK_ACCESS(map)->start = start;
-- 
2.47.3

