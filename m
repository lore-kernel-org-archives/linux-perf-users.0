Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244355;
	b=FlwsRWwjG89qcDlQ0Kvnvrsrbm0PP2ss6iFExoBUPjggppwBrc7Hk33+v0fzJLqnJBK4
	 5mVmfL/KFyEjvbHJIQQe9hVM39BND/6vORxo+oasYx9PxiPKjY40yy8Tny68i0VgguFB+
	 nILADSG7XyiOLIvIiJRDxx769fvEgaduZuT47Bebami4+hU8fQsbkZa2xGRxpWZhe+t6B
	 lkidyt49VNovXfXQ7RDU7Sv/c+rWY83H5YvfAoXTiLCDcpDqVEkkcT8UeWEYDId0WyQjt
	 f59v1nWrbWqBwhbFa4u7h2TK6vmjzJUYk+Aft+x83LfWQZIvMjHojhKbNXh2PGhLhZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eypqNFLgLpXUHRcqXnjliravXE92Pjb7dAJMkh1LWac=;
	b=yIiFtizo0UiRTwND/ENksBeiXwxY+b+xA2ZAmAwSFb6Yt6ojvZ2X25d3teeBnOnrWIC8
	 JuN+41gX5fMWaRcMqGmgQ3dhFTG0IbCJMZrDrd/xd4wy3dT29zn4aXQDlaPPf8Eqa1BPp
	 PjK6Ttq+cfT7t+m7H6/8aXbclBS6KQhXYLRQlkSLP98h+NFUev6w1Ss4CvngeT2zN/XTO
	 AUoIfNdLs/19KNEk537jQFCoAKxEFCsjliSWZhePG/tKCITNXSXHkL64OU0vQKozg9uKj
	 Ac7+uvK0ZZ/hS+SIFfExm6/Wg/+vvTUkzW+oZell5nWTP7nBa/YCF1m6zmb5wGc/l/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dCYimgCo;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9B606A33D
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F9B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dCYimgCo
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso1323521a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244354; x=1795849154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eypqNFLgLpXUHRcqXnjliravXE92Pjb7dAJMkh1LWac=;
        b=dCYimgCoyuiyDHRGkwM6x9RkgC17CbJLvAC6uxqbGEjDMPHn6Z8IfZg71tjuLPYCfY
         hKrc+gfR+UuycuntKOrMy6LuHzmN9AiQVDIfbQjRXAR4BvvYfQpcOA5qiGx91sMZbvSZ
         mU/ecwp4U+ha13CoQYObaxIzuaX36p7BKtYpQQGbPZ3qvLAFjOca+YK5oNuGC2jw3Oyw
         dKEIgNIjXdX7oep5I0o4u2X0oOIW8dB3QUfYY9ceUS/qS++Hlsz0+no8TkxDTua0cwrF
         5Pv1/QD0AC5k9oXsMiSVfcuEK6TDAqa542+jIJu5Bqzbi7QUsaHXGit87JJHICAM2pdB
         bKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244354; x=1795849154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eypqNFLgLpXUHRcqXnjliravXE92Pjb7dAJMkh1LWac=;
        b=Axv9IXByEbqx1uzI3DNAXXYf+ltAdl1VyFrIKqsebDG0cUGO1G175C45NUyV/J8iqD
         N/F8FjsIqj7ffbhZ+PSpkXnO8lo85UpflfbQKTpGtbC6WGqKxxCJOZLLV7ojmAJGkxsK
         tmu6rCuRbt7zWhzrO2CwfBQRTEfXlMRaPU+++wZv4pK3w3zKLxviUYwA/fgdNLuEYYya
         yFx9JjT7/mIbgI90MHvCMabXK92m4bIQOn8DolUZf5yc8VEZcvlk1iMAgscKkzzWPTr1
         r15eq2uMhHKM+AKMGkdeMq5O86koyiJL2SKrW6lV7mo3KuIucQi9dfJnOMcvdtuW4Oda
         qHxQ==
X-Forwarded-Encrypted: i=1; AL+hErF2VzDQwFJ9Gm96AbU92exP1ZzitIu19WPn3hVeBYjU1M5KFn+1AfpDEzgqamAurxhkGvyjcRvRWfPxIwDIr9uv@vger.kernel.org
X-Gm-Message-State: APuU4Z8vWlynkhoopcnEHEJEp+wvs7VJKQGFUJ/UV9BITf6rdNaY+7zk
	Y8BcxPhBFzg8KtfDgOxzbpIXjfqhCY1vvci4MDW3RXWR/cld01WsxHUj0/Pxqm/QdqeGPsXMwVc
	S6e8zSL8h3w==
X-Received: from pjbrm1.prod.google.com ([2002:a17:90b:3ec1:b0:3b3:f9ba:d0b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4483:b0:3ac:bc3d:6fe8
 with SMTP id 98e67ed59e1d1-3b41c92f8f9mr4652569a91.34.1795244354221; Fri, 20
 Nov 2026 22:59:14 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:01 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-13-irogers@google.com>
Subject: [PATCH v15 12/23] perf dsos: Use read lock fast path in dsos__findnew_id()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In dsos__findnew_id(), try finding the DSO under the read lock first and
only acquire the write lock when a new DSO must be inserted or an
existing DSO needs its ID updated (checked via dso__needs_improve_id()).
Prioritize build IDs over inode fields in dso__needs_improve_id() and
__dso__improve_id() so an existing DSO with a defined build ID is not
updated with inode metadata.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 45 +++++++++++++++++++++++++++++-------------
 tools/perf/util/dso.h  |  1 +
 tools/perf/util/dsos.c | 10 ++++++++++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5be5d224b246..1c938d1b11e9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
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
2.56.1.750.gf70dc682cf-goog

