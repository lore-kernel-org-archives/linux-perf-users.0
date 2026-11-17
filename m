Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941359;
	b=ZnLaKsFp8n6uE7qCU546mltBF1NBteNpH//0Y91RSlKLAuCdnRrJXK9+0/3U9VGURanO
	 G5vG8HEv4RaDCUpft10L5ajUXD0VPTU2LVM63Qy2btOSFUBjih4zh8M1/C37V7AqmLpj3
	 o03PKQ/rhTPV3K6pdAud23pGBmC5caTjAb3AmXiPZefJYwXEagZf8az5bBvX2qlDris+5
	 cn1aVyWirL439Mflm/ptn9MQrn3Zyixdjle8MDQoD1LYsDc1+Ex1eVkOmnXnyobHvLU9E
	 z17E8k6MgwsYvD4k83kPF8fijMOfajZSIwuEIqm14k5HXGAinOlbloTXa+lTH04itug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=62z/VlGVHaKO8QRbOL3odF4Lg0oOU7m2/hlIIPvhmuA=;
	b=hz4k1DrLYxQpTjnMROp4HqY0DsuyC+7tWb3jaoRvYy0PemBUiQFMyKmV1MpTinjHszRV
	 3lkQmr5IGXfn0SCT24Z1IGmqp43TZJfFp8eHsntlREiPsHgmxo5Xj2mEUReq/Izrzyoih
	 9nL8/t8ROD0llQNmrTmFs4IxERWAbGXGwHY9HSLqk2Sazr8aAdQ8cZl40v0Tlyx/8If0W
	 qmKA3sSf9NZacjWSTfKK4DhEJWNP1VCB/WymkdNje8KPjboxAcvMTooH6cYbUZemYC4iE
	 igGVt9Nd7IBFYVaf1JwXjS8x3k1lXiOgn63onQdAjxm2ZXGJIf1oecumJN6F1vIMZ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pdHovzjC;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B96606A333
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B96606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pdHovzjC
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so238048eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941358; x=1795546158; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62z/VlGVHaKO8QRbOL3odF4Lg0oOU7m2/hlIIPvhmuA=;
        b=pdHovzjCWcPU5nojlh3bzyZJVMleggRi4PDyNf4LgHrAb2jGlXoGp+tHTV69fLVRfG
         tASLIW3TCQZ9XxhVTEbN0Z3j8qOHZjbPMbqpHtnzchfeGEVqBCDYTh+uySNVuA1qpi0x
         AH9kmuDXQvpDmJd2GWq5E7wXHbakmQ5dZy+PNq8swML+tm/UdcrmhdVTwydv2gQgHjVw
         BK3vMjE1DUxbJCCh/Hn6TDunhRttRCCjZlU9zi5udT+QqDGq1DjvMdg8EzOaUC5JIop8
         YC+jV0n8JxyY84pZ9BsKgZpix9YeKMlTcKT2JsBU0F6IOTEnqWzhG1ObEEkMzexgDl7G
         Pjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941358; x=1795546158;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62z/VlGVHaKO8QRbOL3odF4Lg0oOU7m2/hlIIPvhmuA=;
        b=oCAR8UW8AOGLdENq7UjUedSMmhhAFkvt2RKbrTnhuKeY/eTy586OxPWRqVuOjpNd4q
         MhgSCY+QFs4KXqovmNsCj/GLRK/onSIFexWpKip8GJKdq5ytzck/CFcG1kAAtwMduXVN
         sNlhmE+Z08mdWI0oVqqXCw2gCiOKrYWSoyK/64DL1RbJ/DvEt4JEztPzchbWCxHe9ofZ
         TlKRLBJWA385Yntqj65zITRdNRgglTgAv0GdaPO7yXgDTHTBYZU/i7MH9c1bV1e+qRB7
         kMz4RqBjRrC/CFNzxh+CbekG3QvQ+HUYoJ+L+digSNhSnkn3hMWScS3KJ+61dCT7aEjB
         g7cg==
X-Forwarded-Encrypted: i=1; AL+hErGzTamQS7TQHuVF6zm6kCa2fOnL5ySLQZ65L1MuDuV2Z7Y1+N+wOWltSFKmoiIcppHTpNPDR/dTnPPND1QfeLt0@vger.kernel.org
X-Gm-Message-State: APuU4Z8g1rEMTjOFaU4VzuxNYlIoRjc/pOki3SKASaVRuxU3JvZz16y1
	Pef1WEVXjf5lUap2DPq/iX1DNn0FCvzGZ30eT9Xhb0AzqMiBO9Mdi9yCldydTpKIxN7bN05rwk/
	OgLnr15V2ig==
X-Received: from dlbur7-n2.prod.google.com ([2002:a05:7022:ea47:20b0:1b3:b4d2:9bba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:455a:10b0:1a9:d04f:1b55
 with SMTP id a92af1059eb24-1b543cebbc1mr403105c88.26.1794941358056; Tue, 17
 Nov 2026 10:49:18 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:28 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-8-irogers@google.com>
Subject: [PATCH v14 07/23] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

__machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
holding machine->dsos.lock, and machine__findnew_vdso() and
__machine__findnew_compat() initialized machine->vdso_info and created
temporary VDSO files without synchronization. Acquire
machine->dsos.lock in write mode across machine->vdso_info
initialization, duplicate checking via __dsos__find(), temporary file
creation, dso__set_long_name(), and __dsos__add().

Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c |  8 ++++++-
 tools/perf/util/dsos.h |  2 ++
 tools/perf/util/vdso.c | 52 +++++++++++++++++++++++++++---------------
 3 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index a2cd37bd1660..1574c8885d78 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -284,12 +284,18 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, const st
 	return res;
 }
 
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked)
+	__must_hold_shared(&dsos->lock)
+{
+	return __dsos__find_id(dsos, name, &dso_id_empty, cmp_short, write_locked);
+}
+
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 {
 	struct dso *res;
 
 	down_read(&dsos->lock);
-	res = __dsos__find_id(dsos, name, &dso_id_empty, cmp_short, /*write_locked=*/false);
+	res = __dsos__find(dsos, name, cmp_short, /*write_locked=*/false);
 	up_read(&dsos->lock);
 	return res;
 }
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a26774950866..dbd06f420753 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,6 +30,8 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked)
+	__must_hold_shared(&dsos->lock);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id);
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 7f2dde70f3e4..8bf81e2c9e78 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -131,8 +131,13 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 
 	dso = dso__new(short_name);
 	if (dso != NULL) {
-		__dsos__add(&machine->dsos, dso);
+		/*
+		 * Set the long name before adding to machine->dsos so that
+		 * __dsos__add() inserts it in sorted order without needing to
+		 * re-take machine->dsos.lock.
+		 */
 		dso__set_long_name(dso, long_name, false);
+		__dsos__add(&machine->dsos, dso);
 	}
 
 	return dso;
@@ -250,15 +255,19 @@ static struct dso *__machine__findnew_compat(struct machine *machine,
 	const char *file_name;
 	struct dso *dso;
 
-	dso = dsos__find(&machine->dsos, vdso_file->dso_name, true);
+	down_write(&machine->dsos.lock);
+	dso = __dsos__find(&machine->dsos, vdso_file->dso_name, true, /*write_locked=*/true);
 	if (dso)
-		return dso;
+		goto out_unlock;
 
 	file_name = vdso__get_compat_file(vdso_file);
 	if (!file_name)
-		return NULL;
+		goto out_unlock;
 
-	return __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
+	dso = __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
+out_unlock:
+	up_write(&machine->dsos.lock);
+	return dso;
 }
 
 static int __machine__findnew_vdso_compat(struct machine *machine,
@@ -332,33 +341,38 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 {
 	struct vdso_info *vdso_info;
 	struct dso *dso = NULL;
-	char *file;
+	const char *file;
 
+	dso = machine__find_vdso(machine, thread);
+	if (dso)
+		return dso;
+
+	down_write(&machine->dsos.lock);
 	if (!machine->vdso_info)
 		machine->vdso_info = vdso_info__new();
 
 	vdso_info = machine->vdso_info;
-	if (!vdso_info)
+	if (!vdso_info) {
+		up_write(&machine->dsos.lock);
 		return NULL;
-
-	dso = machine__find_vdso(machine, thread);
-	if (dso)
-		return dso;
+	}
 
 #if BITS_PER_LONG == 64
+	up_write(&machine->dsos.lock);
 	if (__machine__findnew_vdso_compat(machine, thread, vdso_info, &dso))
 		return dso;
+	down_write(&machine->dsos.lock);
 #endif
 
-	dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
-	if (dso)
-		return dso;
-
-	file = get_file(&vdso_info->vdso);
-	if (!file)
-		return NULL;
+	dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true, /*write_locked=*/true);
+	if (!dso) {
+		file = get_file(&vdso_info->vdso);
+		if (file)
+			dso = __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
+	}
+	up_write(&machine->dsos.lock);
 
-	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
+	return dso;
 }
 
 bool dso__is_vdso(const struct dso *dso)
-- 
2.56.1.703.gf848ed807c-goog

