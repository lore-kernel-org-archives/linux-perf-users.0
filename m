Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D6582B82
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171906; cv=none; b=ck57hl8YD7qYoNWxN3fx7EKw15zy6Z5uvBH9IqcUpgnl4qRHx7anmE/uV5DLHdFsfEty2drZC8OJn27kFO+Olnf2XLUEhpHfQUnfUwjTAptCr90n7qEPZJ5UjYEN9cbLspvUbN7deJCR2eO0GHH5ZknKueqZ4yYWH65BMN/oSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171906; c=relaxed/simple;
	bh=uHzjpn2rehiqi0o3nqXWkTbin9jDsPX5sWThpgvpbwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwLBjbsAjFNQrXHYrLuc9sjnSgXOdEbv/bzMkgzmKNwRZKi36KcmjHbo72wBsdlG+wG9v7zDZdjW6ScPV3a+svNmMPQ/c+Gy2m83b9raynuxSfQywE8iJjVplC7dxdM9LW9J0ujj6+LtWu27ptHwS4+trZGJ33jgWCIc1Z0mgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDjnkFlP; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDjnkFlP"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso170986eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171904; x=1792776704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxCnvxUTZp1il/bb781Ce5TYlehlCEiYcvgLpzeabqc=;
        b=fDjnkFlPOZznqw4r9sLnPJYAPh2CN9Fj92Q+xnCxAPWUIpsY9rcoBk9zAjQc5xhFbw
         fhbdIpzmYNAFQTo/VKTaHmQTJaEu2CZJE9FXJm3brqTDqbl7QW27HVtz+/rLE9kCKyzW
         4j4WK0IgULnKqGvVJ54XuX9+jDSG8WPf875WYicQCt/Xb37YIQ3TIH+5mj00/tpOVmRV
         8fbo/2ceSdZrnE6Jv8CzXXYLzvWSC1gA5Qiwuc3HUY494GDl0uaN0NTRIP2RDvteaRzM
         Cl9/LLZ/GSWUyH+flpp6PGr43kMDwY4ShE0SYCyJU++JKkuo6uPYxXIltKkkjunRTuz1
         4N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171904; x=1792776704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxCnvxUTZp1il/bb781Ce5TYlehlCEiYcvgLpzeabqc=;
        b=DbyHU9FQYgs0mg4+LXS7F+VFXHfJb+7IX0w+DatnOEk9PHqdDF8mmbdQC6M/ZAl663
         Jl3h4NBMgWYxcMvUwBH5fR8KWiZPlff3UvkgaCb7HJbKHV3fOb54EHx/mj7HAu4sI7lt
         Aiy0OD76GxDsoIJ49ZjhbAj1eiJqRkFJPI2g9BIDQJzWR912iZ7w1CLsSmv+cgXRSCrc
         oTslDnLgMUYH9Qwu2RBRxxvhC7aMxY8BlqMKQG/ZaJA+AkfyvbMsjauTXWyk76uxkPgU
         CYEjFHZ5NYfuE43mG/DVkyopeRaBmrJM2+2HQMLbNeiDEILUCVoq/DoGF+YpIGrPjGNA
         9uTw==
X-Forwarded-Encrypted: i=1; AKwUvBw01pzz612JQmasD3fkGjL/oSOb+emOvuf6Yhzha9LA97uv0azzx8mkqFhngexhbgSBjG+cGB1/CBsyHAR+6tUc@vger.kernel.org
X-Gm-Message-State: AFq9FYIgnUe+F3nQDYqY2iasYMpv+JTUfnQFdvUhcGlAgjQyCRFXW0YN
	K6ZNLJbp+1wQBu4bGetWOsqO9+EGoOz7kyukqDxIDCl6bdlpeTIUabca659EInUxLjV1ZUC1Tjn
	Ron5+L5A4Mw==
X-Received: from dlbbz25.prod.google.com ([2002:a05:7022:2399:b0:168:6cd7:1061])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f51b:b0:16a:1fa:58cb
 with SMTP id a92af1059eb24-1850c40d8eamr628355c88.1.1792171903575; Fri, 16
 Oct 2026 10:31:43 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:30:59 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-11-irogers@google.com>
Subject: [PATCH v3 10/17] perf dsos: Use read lock fast path in dsos__findnew_id()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
index 9f026ccb0eb6..394960cd2004 100644
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
index 40267d3a725d..b5c8086941d5 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -348,6 +348,16 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
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
2.56.0.212.g129ede20d9-goog

