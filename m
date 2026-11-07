Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026494;
	b=UOInUDXuoPOD/XmTx9HglfSJdKYOy/zKas4dnB6dlKEIgrZupP7mN/SvFnJ6eq1kHb7v
	 dr04d0Npoaf40nIrr1MjUnnJ2Hgu8N0tRZ7Bd8lLMc7OEHhoZP+09Z4AVcV3vJwKgcKN1
	 eqN4M89QHXjEmZ7M4LrHTRecB4m48VQajp9guNazpe4E7zH3KrQe7oEWSwXFYSn1ALtT6
	 LT0fYrNo0z/jtahXfLJPaQA7PVDPkPLPiH0iVq9GGqX2EkZAG3sgUDaCGK46BZHG2z23f
	 eo3h9BU789q39Ew4JmbexHl6iNPO/eDq4LSfhUMJsr9PHOvSbenKgC0AiSlxM01ojSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=F+by7u1BFJT4b4TWAdAafRvzASUd5HXLmuE7W7FAfx0=;
	b=wZ9QqzY9PTS5oGCt62R08S9t6WEOTyXYsjF+sFH3uvjcLM4YKtBGh6jFNac8BAZKov3G
	 x6zkejg+4b+I6ZlWNdPs2lRBlkmfLOh0aMIDpVWcpqvsnVVQVSyYvSfffkH8eXy+vfu0u
	 8QN8oSxnl7oJC7JwKYYgfbTVRCZ261qUenNeqR8xJEki+jDLHjo1R3UrQAVA46qWKFXDt
	 P09/Pc+y3VqPZm/p/86NWE44ZA0FIEtEsSOvY1GK8OMbbYAoa4g+IA2RI+4iqlQpiHMq2
	 99Z7XUcpqu2eNRyUlZYytbQoQAhJ1X9GVr8vuAgtsTJfh1AdvYHJwbnMNvVrVM4m8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HqRDU2YQ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54CC606D810
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54CC606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HqRDU2YQ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36de26cb4b3so1664410eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026493; x=1794631293; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+by7u1BFJT4b4TWAdAafRvzASUd5HXLmuE7W7FAfx0=;
        b=HqRDU2YQa/AqsIPd4Ku7xttN2NtuaHFkYllgoKYcrjecivi7HipD37p48u0ccY+R2U
         luxpD0/Ypz5FyFARSjkPO2GLwRwYlLlEd9qQZlJBLPpi0+jiWvpC+/SIshXnb8Qrz3su
         5EXM6wCilggmIcn5YNcMhMtbD/HG8uSENP5hVap82UmTbcxql31HXaRe5WK6MYnt8Xsx
         kWBYdeTQsyme0Y3eWf1TSi/zr9/tm2MTLWwJpSt/Qk9OUSHtjAlv8YKBxlm4J1IhhRd7
         kmBtpJYyKHA2A1gdWTKEkD3gl1t9AZJ4MPxafhN8daiSiHCOUVqKqgpS/G4miDifwcBY
         MwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026493; x=1794631293;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+by7u1BFJT4b4TWAdAafRvzASUd5HXLmuE7W7FAfx0=;
        b=0lC1MrAH40ePhDFE9N3P+rQkJD3NbDCh+gBVY1usaZt+kzFKWNnUMkHmIMURsjAa6h
         1ax4Nl3zGxMHEfqUqc81rRwBtFGS+YFmXrAk5XFqWxZwTfpF2KxWNNHqJ4Dne5EQtBU0
         9vJLLQgTxWH53pmAXgbObeFn4IUD5gF2D3BrRPUwS0NJ3nAoBV+gvYrzJI+7quZWD4o0
         L+DiNevdQGjIC7boT7AXylBM3FVL7wRVpbnzgJ8rSITesjPuccprTBWOc1Upp/DJpI/F
         x6pCiMoEId8dFpeHOvjfTSHUyoI57g7rWCdx+tOeDbFW2qcDU65ORBxEVF5Y0RXXekf6
         027g==
X-Forwarded-Encrypted: i=1; AL+hErHYaCV5D3LVIK1kcDfpVQBIXofNC+O7tTBPzIZNhh+/jvb8bOtSjmmAtUwtZ8ZHibKWDqwSTn8HFCE1QJNfFE0x@vger.kernel.org
X-Gm-Message-State: APuU4Z8n/pasKscgKDrnnLH1icBVbJ3tWTtc43RuCfde6wXbg5yMNywA
	JJ1ctn4Wds6rJEbkHudFgwuPz8NDN4hzd5uXjE+Sd3hLx7JleAcVbCf4EwPPm8A4Gy/J/LfrisU
	AS0QwCnALcQ==
X-Received: from dycol4.prod.google.com ([2002:a05:7301:db84:b0:351:4a2a:1ece])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:680b:b0:36d:394d:e690
 with SMTP id 5a478bee46e88-36f785b760bmr5719519eec.40.1794026492432; Fri, 06
 Nov 2026 20:41:32 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:53 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-13-irogers@google.com>
Subject: [PATCH v11 12/20] perf dsos: Use read lock fast path in dsos__findnew_id()
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

