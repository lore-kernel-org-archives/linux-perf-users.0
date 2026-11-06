Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948656;
	b=Z4BsuwD6RxlopptnOU40g4OfSdSy/gG0L6hqMHlkEdgYWFCXP4p0Y6r9DWty6bFBpe31
	 uycwNPNl39rbqNnhgKaH8kGw9IAIzxkOYaj8x32NsOtVrOQa2uRDgieqNF6LMJoQElrQg
	 GM/nP8K3ZGs+oWEaOLsw85btjAeJYZzsExthEjSgqlpc1/OK5MFoa7gQp67v3fn05bOiP
	 KQ7IP1sL1o8DA1pM/uikfsQGAvQe1RqltvvcfG7H333kT7MieZzuQ+Bx5E/dnceWRCQEs
	 FSX/7MsEEKOLu+oRTbFt6HMkXz8DpS7dRJpXCCfBvjRXDhD1toBUzgztz4GUqlriy3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=F+by7u1BFJT4b4TWAdAafRvzASUd5HXLmuE7W7FAfx0=;
	b=trEE/16WtTDWutxDnQbZ0UiCpdb1cCzbpoREKqscbVQNRm6xify7pRCDJSBFAE88m5c6
	 IggvYL8U5iSjEjL0GbsBikxQovbHpD0nbQhTBaQkAiH81ti+MDsvC4UT4ZAl0cviyQtNk
	 xwU0mXrPV5NVhtJAX5p2Qc9g20q6glGkiaGCpoFvGRDRI6SVo9smiQn1SAfRR7FfyWP3b
	 T5iRlbvvrEOh2F8w47OrqHw5pHBsc/bPLh4BGce76b+CMavx9GniKS4l+PopP003kATCy
	 mXIOHEhTy90yqWS6ZMMePLYU+wDhqDpImm9q6U8OLC5p/Ia619jgS1k1PO2zhJIAQmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ADIvD+iW;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEF606D82B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FEF606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ADIvD+iW
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so771454eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948656; x=1794553456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+by7u1BFJT4b4TWAdAafRvzASUd5HXLmuE7W7FAfx0=;
        b=ADIvD+iWShet2v9b/zznP6u7ewuKDEHiK16YKtfcTjMfJV95NlU4ondLGWHNubwQIN
         cd3qUL11r9jPJf3FI9d/8r24q3odMzZlKj3pHEW5Qb62HJ5qgsI1J8BnpnBRdvrF9dHl
         fK6CRbhtIc9eqefcI1OmEzzF1coNyzsRC4c4lik/2haDcn05tbA/F20eEtia5DLCqETY
         /X1xZ9ehw/Y6cbkh7MaTGBnITDr616VYmF8PdAPZWgTqZrmnCAtYqOfK8m8Woep9duHG
         zr1z3Mz+dMkMtdxfuaIdO+/K4eEEfC1YEFgENCAiFdBTUfXb6e74Nea9Oic4cmelmhQi
         Z6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948656; x=1794553456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+by7u1BFJT4b4TWAdAafRvzASUd5HXLmuE7W7FAfx0=;
        b=KDHE/PwI7G6OZhkE8xWK9x9EIR2WuigO9jdYaiabwtLzhgKF4aA25Xn+tiRa+OpGik
         8xh1tctWkY/X6yM5yeScAtRxugjaGlHqO72jCvtM4m6DtcHxWC7NMhv61VlGSPOONBSf
         MyTdd72j845dn2XZCP71lipPkMkHOiehvHP7Ta2QTTxrSpa6DwAD9i0NSoKe2flQyps/
         BfrEp/Vs02FNpRKsKY9Sa9FAnuROQ13erpUOOkTn68RCtZS9Lj4O74bgVO4330uQLsB3
         qnJF6x73y6fPzWCAJQt+DEq20SWTPEd3zeOM4nowJzJWECiKPRJsRc1tca4z6QSBJLd4
         9ASw==
X-Forwarded-Encrypted: i=1; AKwUvBxiGnaO8qcNMkhyoc8VL6g5HkIXpIXn56BFGn6ww7TqTX/xmcFtRh2D8p+NhdqIVapA/7L7mp3IReQD/goAq1TZ@vger.kernel.org
X-Gm-Message-State: APuU4Z/D8mXkcLzLQHbBaGuEFGS+GqRV/wfGycqMlsG1Rey/ZOaB7kgG
	XUVgxu7VbybLA+hlTW8MMiRU+yYveJxrnQn0u8kB6xRcvr7C6jO6fwG6JGycTws9fNi4OQ4qyk5
	vcz9dd4wNBw==
X-Received: from dlbeg11.prod.google.com ([2002:a05:7022:f8b:b0:189:49c0:62ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4292:20b0:15a:4155:3d9d
 with SMTP id a92af1059eb24-1b25d37e36dmr1929835c88.31.1793948655551; Thu, 05
 Nov 2026 23:04:15 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:36 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-13-irogers@google.com>
Subject: [PATCH v10 12/20] perf dsos: Use read lock fast path in dsos__findnew_id()
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 16 +++++++++++++++-
 tools/perf/util/dso.h  |  1 +
 tools/perf/util/dsos.c | 10 ++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f0e02062c09c..4dc518f7cb7d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1685,6 +1685,18 @@ const struct dso_id dso_id_empty = {
 	}
 };
 
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id)
+{
+	const struct dso_id *dso_id = dso__id_const(dso);
+
+	if (!id)
+		return false;
+
+	return (id->mmap2_valid && !dso_id->mmap2_valid) ||
+	       (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) ||
+	       (build_id__is_defined(&id->build_id) && !build_id__is_defined(&dso_id->build_id));
+}
+
 void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 {
 	struct dsos *dsos = dso__dsos(dso);
@@ -1692,6 +1704,8 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 	bool changed = false;
 
 	/* dsos write lock held by caller. */
+	if (!id)
+		return;
 
 	if (id->mmap2_valid && !dso_id->mmap2_valid) {
 		dso_id->maj = id->maj;
@@ -1715,7 +1729,7 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
-	if (a == &dso_id_empty || b == &dso_id_empty) {
+	if (!a || !b || a == &dso_id_empty || b == &dso_id_empty) {
 		/* There is no valid data to compare so the comparison always returns identical. */
 		return 0;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 9e38b3b69e9b..df1748763d95 100644
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
index fbbf98c4ccae..1b3f8b84ed30 100644
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
2.56.0.455.g6c5a503b38-goog

