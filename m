Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588146;
	b=vQ2HWOHCNIz2Mx0vTJHbfhjQbEQ+HV7WojJE3N3+M1fE4V9JJnXskOzIDFiQEMarEgwD
	 wV9a+e7poEV+HKWBaQRrfb9hl4sxPWZ1Y/D2+shgtnSjspyoVJyny9SMIMmdpxVyK39Wu
	 8fLuITiXuAg5WVzYqADXlcDVdjKH71a9a1Tto9dEVu6+oyCMqT2MyQ3Qtx6Lbfru8MKTg
	 Mx8ZDP+pUPKHWJ9SUeJw/IKWNEKL07b0pwBRSiYOOXrWestRfU0LF41ms9lyLa8JoIW4I
	 w7RCfszFx3cJraL5haReN6zNXh+jlgxK+s7a8KEJJnJ2vVAeyAE9TNWpHo2vrLAGcig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bZ59TM7G2liEoxRRNzPtxFJR0P+j7mMrUkUWg+uPRjA=;
	b=D+/opmKCj9ywSe8ZxK5FvxMnmHkc+8sfXZF6ypOYEr70nKT96sxgrlvAAKpvhszpBKZw
	 K+MFj8DuXx0O9HstagCaxCT0Fp3FzclEGt/DKeeofOAz6Gyq3okcjZQNOVArLwP290Bu2
	 3oMk2I8CIAry2o82Zd4SNflA+GomX0HfgH/4n2BC+drAkKGkVyedgkZkWeW5hH8PUncYL
	 PgmxfqoFAnK0sRiC4XryN23+0YF9pRScElDo2Rl8d9QNtiKw9UPo7H9cuTL5rQHglHxCg
	 ZhiM24yA+fiELmvuwLMUFx9QB4YdeeMCEtLB9/N8AcRHPhRjKrh2T+eP4KYyNYhKW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nVwbKdxK;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3E606C6AB
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C3E606C6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nVwbKdxK
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1421782eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588145; x=1795192945; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZ59TM7G2liEoxRRNzPtxFJR0P+j7mMrUkUWg+uPRjA=;
        b=nVwbKdxKvSXn+3ZKpSu+uem3Ewf5EHCqkj51kB7jGbfryJkTcmMFRtSK6S+v1zsm2L
         CcUl+HH/l+C7EuxGcXPKVs5dBClcWEpHAhIxEiZ0i0kqS8ojQg+T8UMJuHvu1QxOmxmT
         PokFayYdLTXOZbG2DOGzgSOy6BfxIqFKFyHws5SfNclaZGU1nBdF2MeR06Pkf2bieaPA
         MUxrqMkoPObqpmEzfozsCxwzYCiLfbcEX7dnXJM1JxBKjtXzPTvrlg/U8nwmd1eDoJ3X
         zSNBu6Rvq+cdMjbRxgsMSVADjRpa7Zo9mGO1vNCLkj5nxHDY4u2ldqn30gGVYf483sG9
         nshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588145; x=1795192945;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZ59TM7G2liEoxRRNzPtxFJR0P+j7mMrUkUWg+uPRjA=;
        b=HzvrjTeoQfyzHPvOQ2T4nMgDSjaiMUXcp1Z9IIn5etgxxTr9q22tnefzJn9NTLHaLu
         KM7rt3vmodBXSKfjnPCzh+9dsYdJ3pi3NZLN1D8lUx4UsOsKWyv59zEGLtM5aqC97mGV
         ZxRcoFVZCJmQ6yMX4tMjzSU4D4IMhvM7B6ijRuUxd0hwUOJELMg523qwwEdDhBJ7dXmB
         z+V2kRFgdFX/sJ7i4iTNqE+B78hqtJlTNfao9OYwvJkKSje6AnSZaSRW0Qfa1Q5Lo+la
         0gaqEw4cfptmyaX0o7ev+VGD5vRkCdCZgMeqP4gT5gDxBSfzD04DB61eOYV8MInXLIdZ
         wXaw==
X-Forwarded-Encrypted: i=1; AL+hErEySVxAypEyrpftVKJnMNqCM092LbGN974Jkok3NZ4CVOdmoe4PTt8zCEqqDORtdeHGd04TugwmxIdlCbbYMBCA@vger.kernel.org
X-Gm-Message-State: APuU4Z+sLd89dNOy0I2cLkV+XJuQpN0xkAtyq58sjl1Q06CJWq/MD0jd
	3QxDGfZnsgzznfi9PLN4zgKzGkeVUI3OEXlWgmqKcv3RNrnS8CWmYQSv6SKLvzqu+gVysczKeJT
	83yPiQQBMjg==
X-Received: from dybph4.prod.google.com ([2002:a05:7301:4184:b0:370:f640:2508])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c88:b0:36d:7f5f:7e97
 with SMTP id 5a478bee46e88-37967dd734emr3997105eec.40.1794588144737; Fri, 13
 Nov 2026 08:42:24 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:43 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-13-irogers@google.com>
Subject: [PATCH v13 12/21] perf dsos: Use read lock fast path in dsos__findnew_id()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In dsos__findnew_id(), try finding the DSO under the read lock first and
only acquire the write lock when a new DSO must be inserted or an
existing DSO needs its ID updated (checked via dso__needs_improve_id()).
Prioritize build IDs over inode fields in __dso_id__cmp(),
dso__needs_improve_id(), and __dso__improve_id() so an existing DSO with
a defined build ID is not updated with inode metadata.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 55 +++++++++++++++++++++++++++---------------
 tools/perf/util/dso.h  |  1 +
 tools/perf/util/dsos.c | 10 ++++++++
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f0e02062c09c..f736a94a53a9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1649,6 +1649,11 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, bool name_a
 
 static int __dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
+	if (build_id__is_defined(&a->build_id) && build_id__is_defined(&b->build_id)) {
+		if (a->build_id.size != b->build_id.size)
+			return a->build_id.size < b->build_id.size ? -1 : 1;
+		return memcmp(a->build_id.data, b->build_id.data, a->build_id.size);
+	}
 	if (a->mmap2_valid && b->mmap2_valid) {
 		if (a->maj > b->maj) return -1;
 		if (a->maj < b->maj) return 1;
@@ -1663,11 +1668,6 @@ static int __dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 		if (a->ino_generation > b->ino_generation) return -1;
 		if (a->ino_generation < b->ino_generation) return 1;
 	}
-	if (build_id__is_defined(&a->build_id) && build_id__is_defined(&b->build_id)) {
-		if (a->build_id.size != b->build_id.size)
-			return a->build_id.size < b->build_id.size ? -1 : 1;
-		return memcmp(a->build_id.data, b->build_id.data, a->build_id.size);
-	}
 	return 0;
 }
 
@@ -1685,6 +1685,20 @@ const struct dso_id dso_id_empty = {
 	}
 };
 
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id)
+{
+	const struct dso_id *dso_id = dso__id_const(dso);
+
+	if (!id || build_id__is_defined(&dso_id->build_id))
+		return false;
+
+	if (build_id__is_defined(&id->build_id))
+		return true;
+
+	return (id->mmap2_valid && !dso_id->mmap2_valid) ||
+	       (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid);
+}
+
 void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 {
 	struct dsos *dsos = dso__dsos(dso);
@@ -1692,22 +1706,25 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 	bool changed = false;
 
 	/* dsos write lock held by caller. */
+	if (!id || build_id__is_defined(&dso_id->build_id))
+		return;
 
-	if (id->mmap2_valid && !dso_id->mmap2_valid) {
-		dso_id->maj = id->maj;
-		dso_id->min = id->min;
-		dso_id->ino = id->ino;
-		dso_id->mmap2_valid = true;
-		changed = true;
-	}
-	if (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) {
-		dso_id->ino_generation = id->ino_generation;
-		dso_id->mmap2_ino_generation_valid = true;
-		changed = true;
-	}
-	if (build_id__is_defined(&id->build_id) && !build_id__is_defined(&dso_id->build_id)) {
+	if (build_id__is_defined(&id->build_id)) {
 		dso_id->build_id = id->build_id;
 		changed = true;
+	} else {
+		if (id->mmap2_valid && !dso_id->mmap2_valid) {
+			dso_id->maj = id->maj;
+			dso_id->min = id->min;
+			dso_id->ino = id->ino;
+			dso_id->mmap2_valid = true;
+			changed = true;
+		}
+		if (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) {
+			dso_id->ino_generation = id->ino_generation;
+			dso_id->mmap2_ino_generation_valid = true;
+			changed = true;
+		}
 	}
 	if (changed && dsos)
 		dsos->sorted = false;
@@ -1715,7 +1732,7 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
-	if (a == &dso_id_empty || b == &dso_id_empty) {
+	if (!a || !b || a == &dso_id_empty || b == &dso_id_empty) {
 		/* There is no valid data to compare so the comparison always returns identical. */
 		return 0;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e8cd13c101a6..bb887d10a9ee 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -802,6 +802,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id);
 void __dso__improve_id(struct dso *dso, const struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index a7f6a98acbaf..4ff38cb5e2cb 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -349,6 +349,16 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
 {
 	struct dso *dso;
+
+	down_read(&dsos->lock);
+	dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/false);
+	if (dso && !dso__needs_improve_id(dso, id)) {
+		up_read(&dsos->lock);
+		return dso;
+	}
+	up_read(&dsos->lock);
+	dso__put(dso);
+
 	down_write(&dsos->lock);
 	dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
-- 
2.56.1.703.gf848ed807c-goog

