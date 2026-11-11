Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418966;
	b=LHp2YBIB7I6jbLSVcW7F6hVyLCt4CeZTTkOwuO/GolvlX6pQ38s+mnx61sVZmdMKgBXI
	 QBL/L9qE3DO99Jxy2YoBjQ2UvJJZsfTHSY7BadCq8VWA/3WqpB20VCsMglXg/rBM2kNAv
	 JQRdfB9rHZiIBf0j/ltIa4v/cZOEytLtq9n4besNv6MjdlUaot8AkHiYKYQBohST9Bi3i
	 R5pgyHct0wd3xtu1M4I0g39vsli/qtxjwVuoAUMIEteuYjVTWC3Po7hHNlj7I7mYMHjeO
	 VV7RaBGkLn8sVPwQfeJiqi0Mwpi0t2Ay1pz1zkxJKp2N8BKOl9YdjF/mfhIVS50tIFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GQ2ckN4vaa+KXjzW/GKuXDFFblYx5Cv+ssPO2h9zXiE=;
	b=l7J4GeLQi2hgztWHUOerKEfuncgn425J9CRFiMWHgryU/83RzSloj/MAUdcM1pOqcMj8
	 k9j8UE3D4SR69N2PinBZEdipv4yCiXnsqQR0r8i31CFlV+TgSgp03XfO5MU96mmDx/9rw
	 twRb89y0Ml/m7eIZEvMQpxLXLJjVkvNiQQZbGSLqY/UiGwIyS/sDYpoO/A7teFmqI3qND
	 M1ow1JuploNn3VkULGXWADuOZxo8NpTnEli+BQywMFUexFH9taBezCoRLeEUCaO+pXKm0
	 NtzyjZ+SafpEmycQezaPKQ+zMYNwV+tKgDSiR7pYvaolLYVuAigGnxrQCK+pSDF/44g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B4ZiGOHw;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A8606A8AC
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 151A8606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B4ZiGOHw
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so6978974eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418965; x=1795023765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GQ2ckN4vaa+KXjzW/GKuXDFFblYx5Cv+ssPO2h9zXiE=;
        b=B4ZiGOHwBJQcc1QvZGW/jus68FHOokxgMg8MHItLPEPYZno9UGluZJPx3Y4qtC1gcC
         3ddJta0xWHrGc1eqS3yHB+Pk61fsgnBp6rcS1VlLN4NigihlJYVHzrn/1suLxr9rQhta
         CzQ111NlWFapqWt3EfModifpICBjlsI7K/yEzID+mKIVoTg/1ET8Qy05FWQ6j20sObaw
         G3Ngf2S7Cr4KVo4oq3w8PfA8MuuoYfk1J592eoXhfIlzYt0Fwp8bcgROnRuVTuAbXR9v
         PHVta+5hECbbkyx+wiTqNBZOKfnMMPrEgslqLVj9UaHwlLaOIcrPAwJrHkWSRrDkM5r0
         bFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418965; x=1795023765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQ2ckN4vaa+KXjzW/GKuXDFFblYx5Cv+ssPO2h9zXiE=;
        b=ZkzQM9mXOFJ5ccVG2RXq1ZJ0ns8+5g/3dUCvMJgYPTxua0UOVSoFL8eKCnanIyf2PV
         MrtprqYfKt7cG16TxZmttGFX2vFx8e9UHbAR9FG3MJeYU+M+CqFFYiG82fr/VJy6bxux
         5hkW178Kr3kXT0IuP4upw9IcIAgJeQyq8ZndoG5HJBAJhybp4MLnP4SPbvAfCLsdZ/JP
         RW7ZSblVaLEijddJOVVjsMrV3jLZwd8rCfoB9zlvIU0SGzEJdpb9N+N3AS3d2BAz5tWR
         mLqBN8B9ZA772DRSnGMGR2cZ83AgOhX/QAnTZiL/zTyA2vXfAVkmR12OCkxGc5NvEj02
         EH6A==
X-Forwarded-Encrypted: i=1; AL+hErHu/YO0lJW32xIuo8KS3r67RSVkPRNsG24ONnyEaOUvvLNx9DybOa26g2q32LcVj5Qe3d5w99AeE0wnEKcZNiZt@vger.kernel.org
X-Gm-Message-State: APuU4Z/L+dLLFxRKmjOs8Y3aBAUNaoFJjtZ0/rtdLFW1eCJYWow4MT6v
	HAICxYzdKj8vGoMZT1GiIkASCQezOeuO1yoP4eim97wPf10cF+VD7FebERuasadTyAwLe2fnQZ8
	nwZHrIu8WUA==
X-Received: from dlbrj24.prod.google.com ([2002:a05:7022:f418:b0:19a:9ffd:b30e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:ca05:b0:166:5552:780a
 with SMTP id a92af1059eb24-1b3c02f379amr2988632c88.8.1794418964501; Wed, 11
 Nov 2026 09:42:44 -0800 (PST)
Date: Wed, 11 Nov 2026 09:42:04 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-13-irogers@google.com>
Subject: [PATCH v12 12/20] perf dsos: Use read lock fast path in dsos__findnew_id()
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
2.56.0.542.g3ef89b7020-goog

