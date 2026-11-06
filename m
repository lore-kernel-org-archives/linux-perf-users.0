Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948647;
	b=M1MrxVVxD7q0K2d+Og2Va5VINdJ36xgeV7Og+pp/yWqyRq8voYnqzVkjenJYwtbSu6VU
	 53uQ2kXXIJvoAQybNcGVcFP5kBMcAQPRSWDe0/RMmNJ1s/6t0ABUR/6BmdmKV4S2g3TXN
	 ZeG2XbaAxSqssTaoE3bAPtfHcHKnnr6bVxAgphmiLzTLoeb+x3JKU+GnB9fnA3iJCwr2z
	 p/DehcR+I0tFobmzt95neLkUcoI6AfWDZSnI0tH1FCTvtyslT1nkZTr9cIn4Y+asJGpWL
	 AC4SxEe7b5sB7BJQY3RFRmbqGVzEr7UUCr4eGxvwlXi03z4vwW1mxyWvE/lETkOWpHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XKfZSIPsTc0RF8AF2ugTHpT+Ir+cil0epfxw5x9ZBj8=;
	b=ZoyAV/PnLjN1srEN0zwdKRyezyyEVvNJTBZ5rj33UAAUK8vWhLaJKEPUZuQy+s2zAkvX
	 B3WPx/BYMTjcoXVnxYdX2SChDXEZwbq+FZHBROJ+yAHqulohB3q/ykjMIRnbTG6KspAsf
	 HfOXe+SqMVWOfsC8TOp/aWSW6tuelZlDri2o6IIk8/O6AcFaakBOvezH5BOtTaITIlFk8
	 Q43t7itYuMmKB9gPKe7MchsbiQAlE9vMyqJAHRCzvWkxfwlT3zCKO6Q8j588Vh03GIppw
	 xMK/p3wfDpgdGgNBYMw8sspehJetajM6OiaxZySCUm+OvUBWUU8TfxH5x2Sj1Jk1asg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U1jHBs3m;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF878606A33B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF878606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U1jHBs3m
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so770866eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948646; x=1794553446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKfZSIPsTc0RF8AF2ugTHpT+Ir+cil0epfxw5x9ZBj8=;
        b=U1jHBs3mHHjOAytBENWLsSqanI3f41HtYIxAPbmGeWOK8Kw/cg7ZgiuvOsjIAuL9NO
         yt4UJ95r1xBFDOjRlNo9H5vsAl/Z8YA4mlSxKv6FZObgY/zAPt5X5z5TJv2vXwga1tjK
         mb/7ByECxjaFWTLWs8m1RUAbRU3DATOtGmqZpHeP06Usnz52bBwLAR4L7emT4M5WeUen
         Vp86L315ENazjcYDjHf+zx1/36o4GYJJGq7ftDHnferrdsteks0JLB3PcOpT/0Xzulpx
         6wjkMO0hnU3uJsTAap0xAZZW36YMbFXSK8E4oRTgaiDM1x1EI0waWWrmb2Qbx/iGCTTv
         BpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948646; x=1794553446;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKfZSIPsTc0RF8AF2ugTHpT+Ir+cil0epfxw5x9ZBj8=;
        b=E1wB7uslqSiBJRswNpIy9czK2ptN/NSFEKiJHsp179YC8NCfdYNnMn6tHSwqnD7F/T
         0oed58GRYWlHSf/UMUUrXSop3rKGu2nIV8tmA8tcpdndkCCIRV1elp76aKT05+2NlLlU
         Q5GUJwrRG+Vwly1tvkxqPjy3q9KEW0zPRxGWrBuMmHBuifZHPwkbnJ27kWUEMc00p5L5
         l7VBA+mYv+cvqREk/siQ41o8O8iLwO4Hq8x8CJUDdNBX5XRJFSf/fjIvMoQv2xdrcKQm
         WPjHJUMizjnMcFVMlD8IdYCA0BJ32t1InYe5wDkQJep4MTrtUi0qN7q03Dp48XALExtz
         KMnw==
X-Forwarded-Encrypted: i=1; AKwUvBx2LsIK4DHM0Xb2oAwJ7gbX3JtIm2W0pm24MsZXOD0NeH2D0Qvhm9yHidjAqfPOwUkk8nwbbRfsXti6TGvdthff@vger.kernel.org
X-Gm-Message-State: APuU4Z/5cjHzbcywzlosVzKXhXeD2jBJ0BiQD8OuA1KCIMljGB5r6q6y
	lVMomnbCvbP98aOemrOE+NhtFHV6WsVmXmHM0DjN4pt3xodYJh1TR9reLkWvjFUgsakpiAoWK9g
	O5l3ryKDXww==
X-Received: from dybqr3.prod.google.com ([2002:a05:7301:6083:b0:369:f60c:3f6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:885b:b0:36e:535c:60b4
 with SMTP id 5a478bee46e88-36f75254432mr2518362eec.13.1793948645515; Thu, 05
 Nov 2026 23:04:05 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:31 -0800
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
Message-ID: <20261106070344.329897-8-irogers@google.com>
Subject: [PATCH v10 07/20] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

__machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
holding machine->dsos.lock, and machine__findnew_vdso() and
__machine__findnew_compat() initialized machine->vdso_info and created
temporary VDSO files without synchronization. Acquire
machine->dsos.lock in write mode across machine->vdso_info
initialization, duplicate checking via __dsos__find(), temporary file
creation, dso__set_long_name(), and __dsos__add().

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
index c12f5d8c4bf6..93828e660672 100644
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
 
 bool dso__is_vdso(struct dso *dso)
-- 
2.56.0.455.g6c5a503b38-goog

