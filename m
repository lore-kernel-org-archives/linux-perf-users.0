Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514236;
	b=IFad4TJNb9iqmOkJhkWbK5gVFV9rDGUlNjq5O63JjbhjS6y0C56WNDWKOHIVO4DKEMt4
	 H3dlyKRw0Tzj158rHPNJe8DpQ6kE13/t/0ayzhxCUEoZggVJeH7PjlSEaC+RsdHopyxCd
	 XdtDy5C/KDDn7v5lHLyos8X9eBDDe4YMzLVJEatLTw+bSvXRq0BVLAQlpdHR2JqgHUrpI
	 FizU1ekxzYpIHtEeamBQj0PCRvTXr9cQrIvGGoNBjBecye7rT7IdOu5RhPPR/3X7qWXSZ
	 sFm0quxQeeItD3TJnhJU+WChAlIO99zgoLchMAiPVZ5SuvaTYeUbwaf6ukHE8ZKLRxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hxCnvxUTZp1il/bb781Ce5TYlehlCEiYcvgLpzeabqc=;
	b=xd65moeGdXh2sEN5xLzKPvjNAI5nclqDA0Iyxfk3iCkHubiF1ycN1ZndbeqIBDiSCkcx
	 H+YWyX/bGmgC937y5q4+lI5ym/a20qQL+9tySfo+h+1AN8Jzc8BKJmYHriJ167rrEBwm7
	 muztKoNBFOCatLbAItdJTD8hFBhOO9gfIa7TrQcEYHTWMWRAMO3QHRQMRoi484aQPP7bW
	 0xDqvr5cq5/PdYbJ0+eSdU/lSPg4ok5VspDtn/LV7vi1XwJaol0WIdzvVGluqwhr1ax76
	 FwN1JMeIDk1QpRH+2ZN/oqGfNmAMcAYd1klL3ayaHXEVlyCgLuND5gRtSqfoNxtYjvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s4ZKQKWB;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737860A3838
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7737860A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s4ZKQKWB
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so9679215eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514235; x=1793119035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxCnvxUTZp1il/bb781Ce5TYlehlCEiYcvgLpzeabqc=;
        b=s4ZKQKWB92M/srgDlk6Iccq6hKE8pmTTiTtIYvKjhiJ/+Z1m/RCnihKeW573kDd+wS
         /ngH6vIsqonzIuwTtooXVv/xKNsk2Sd/l5yd4tm7ZYrBPSaKMSp8b94g9yWSK1hIt5+Y
         fKjVlQKmJ7Dg3Y5Ijh/osj/6kwoH9sZx16Bz0xXxT9AZvJhb0X2zbrVMIFwZ2NaJTfva
         IOtef0ColYVToLuAX9RjkP19sSnSfSThfiV4fZynw3mjDWpVMASsRzen8RzrVptYiIi9
         q7PeVeD1SUFocEcp3aMPaRD+DsL11K0VVFD8I+TuUC0WOr0HKPCsiXaocWxe64zKdlaT
         Hz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514235; x=1793119035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxCnvxUTZp1il/bb781Ce5TYlehlCEiYcvgLpzeabqc=;
        b=YoRpYZyWJeYJa9N/psYaYZjv5v/oEOyEyV3LC5R4bylULCLBZKW7gcaQp0rM4Gx780
         9Ey4EJNJYluUD+4YmFwAQstLiODl/KcblvEC9zOpumcMxsuY3dCbNUUDFI5bfpb5mYTM
         KouczaPYxXm0RsqNciq1KtNCaeE1gUg/pCIZ5XTSkYCEAg/2XFhLopDxGAV5zVjUEY0r
         UvWLrRLYIyQdVztX4nYAafF+qt9Ts0d+h2OlqXL5S2LGdjza/jMXzi5Zh+FuT1UI01c7
         BssWdOEFpT/6hRZj6w1o8p32B9StJwoSFLc8/3T9KCo5xERoIFeN+sCnYbMPMvdzaS3P
         FkwQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9e228yOyfRoF9BHQQt+hKmT98p9XNAvUIWA6TamJPQCdLnHPx18brhvyXF3Ud4ghI3D0iXLHpb+539hLJfHff@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1BV1dMWrL9ymto027lZ3dxPpCPZTz6XeOju4HvrrW8Ak9PkOc
	/8Vu0VSZ45meKK7rMiclVuK8VJjAyW1zeXQflVCwBwwm9RB1ud/uPV+JqNfnYVlw14NnW5RPgPk
	opoX/QEL5GQ==
X-Received: from dlai13.prod.google.com ([2002:a05:701b:270d:b0:190:ad1:4d8e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4309:b0:168:3243:c91a
 with SMTP id a92af1059eb24-18511eb6891mr17156154c88.13.1792514234420; Tue, 20
 Oct 2026 09:37:14 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:33 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-11-irogers@google.com>
Subject: [PATCH v5 10/17] perf dsos: Use read lock fast path in dsos__findnew_id()
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

