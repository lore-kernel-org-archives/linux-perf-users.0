Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700138;
	b=a1Sk1558O3WyFMPpqCQV+yhx/ajvOZWGf557zDCEhzn94qGwkjgsZE2G/GBwdQBoLTew
	 ooDNzfUZcpPtYyv7o89PlfASveZcKrWKKqG8mVpTbipwTCg4k/KCaaEdVtera7sGesthD
	 48fu0rE2kVxFFDEBTRmo2M7uwvLl3XUTfiy+zlYRxaCGWT5R1qqy/AdsVhqu1MgL+ldhm
	 Ob9z82GHk43zWy0IF3ZfyvlFlvcOhwYNv9kOE96nC0PHHmq92bxMbeCzULOrEucHVCFX4
	 HYrdQeZQBNjc7n5UNb+Dg4b2BlPutlHsJ4WKLVaDsd9U7B0ksE9ODbYXal4AG+ln97w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rC4lnjftw6rIxuKKEP8wYqbMgtFehbcRX6Ia8qs7pZI=;
	b=vYyAunj8hHhrboNkdjz6YQbOXEx7WvDeAoMUDHDMMdvSN7AbUbO8nDbdMkI4KF71Zv0O
	 GOc5wNFbxOntwVXaNZXrc3/dl4EpFdQBscoVZNSy2XrlDLqWKWQDAXpM0kAKpjglwJLKt
	 vtlZpiNX5XxAykzICd665UlmBIasfk1g6q78/HHnKtDVR5Z6Xt4Grv7RDEXPUZOJrvhAm
	 UMBcntPNjykWvg/tie30y/fLBhHHdp7CR+Wbj67fhnHtSUnzkeXjb8I4/szs2RpTW+b80
	 ePVvCbppdxGiAhYmrivmvBJWTvQxRYhZ/isevUI3k7C3MutvfgQmrfFSgBTLshKSuog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LxC4v93W;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933460A262E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4933460A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LxC4v93W
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-193b5eb133eso170697c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700136; x=1793304936; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC4lnjftw6rIxuKKEP8wYqbMgtFehbcRX6Ia8qs7pZI=;
        b=LxC4v93WT5J6QA11ow/EiaxkSAio7NS7fI6kJeHGEa2tzf4vDvpaOPbh8L4Isk1trQ
         d4agkrj9WQrNSxCoHr+S5zTizHo4DFpF7fGre9PubBMaatGRQFfACDG3gjZY0fstqxvg
         hfeGK5wv/plgEoA9tndwmPWDX4oCW9ViQqz/i5RzcEc0df8mxyrl2psV2nj9Dm9QQHqV
         lkJobyw79GskvIG0EWzc3S8fdPbAHgtMV4NiCgJhSyMnE9yzTKlb3iK3lJTi4s/52/wq
         WfQPWY+AK8tDorDDYtq79bxbRdhlRsLLtdHd0QAG+J4++VpWh/EHpFCwE26FVuAUJVHA
         O5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700136; x=1793304936;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rC4lnjftw6rIxuKKEP8wYqbMgtFehbcRX6Ia8qs7pZI=;
        b=WaZfdbV7/nUzOFarMpDLBNWmyBjafgbF4r8onghggcnY3XA4K1ip5maN5EbJE7fKn7
         43YzsbVyHFpj8LxboSBqa7xkEc3nvvkkl1eByReimnHqjOrOS1+76Z/IYHMQ8omnkWxr
         Av4cUFy0izJ4EuX4aifYpb6UDv+txgR0u9B+wjkPegeOaT8Y5eUZvbMkVLTXqaBTi5NG
         +ti6PjppfRDLQciQWa1a5yGkcbP1LbZBF52ARLY59QlVN9Y/4/AJaXhRgz0kbf7re1Kk
         G+DdJE3jawHFiIJ24EyG2SFbshqzW1UkLkONuObzTu/Zkb8fsH3Uxt1KMUPONelsif3U
         dhHA==
X-Forwarded-Encrypted: i=1; AKwUvBxsA/AXajYZP6jgdwWsRu/ecjYtN5foyLfJW52qJKupw27pY9udSYFcyx9gWmP4i1jvyXqNoY/ZfL/7kW5JmPU+@vger.kernel.org
X-Gm-Message-State: AFq9FYIlNN/jOmMdNLelDEcqz7HmXA4m5OmUnS4Z7yrsJCAFeuYctLie
	6zkufQqG08p4mNEGJ72a2CVxJEQGEQDCUfInh/5fhM7qh1+stzJ6d+GIQ69wRXPzjesEi25WGFt
	v9dMlFhPt8g==
X-Received: from dled6-n2.prod.google.com ([2002:a05:701b:42c6:20b0:191:8b40:a632])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4511:20b0:18d:5ef2:1644
 with SMTP id a92af1059eb24-19599707360mr525513c88.30.1792700135908; Thu, 22
 Oct 2026 13:15:35 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:45 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-13-irogers@google.com>
Subject: [PATCH v8 12/19] perf dsos: Use read lock fast path in dsos__findnew_id()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
index 2df0ce58421e..ff58ac2566cf 100644
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
2.56.0.307.g5fe7bd680c-goog

