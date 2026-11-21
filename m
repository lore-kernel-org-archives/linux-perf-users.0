Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244344;
	b=CxyzMLDxMMUKcvp/vbIIVNDAKb34Uc5V63mOJFOju2sABjctMHe3DrYFwZoCpbDMV+mT
	 ZQzu0edytny1xSt5beE8piGJDhcFpB8S3bXTOONVw/6/RC0CaeK9VhqnJOM3w/tJWV62U
	 QztLSqeAcWwVAKMi+cUv/kn6IQMAOrd79brJBvYDeurz9nj/ttd0Sg/ma5KSW1JctzmKF
	 TiBTB6O/NbbzsMEOnJBfDE8y2vmhLq88nF0nl88l6kCjBTSe0n8FaX2uQgy0x7UjNkd8l
	 mnEXm98PsJkX6/RiojvioFRo+taENMifIqoEoVsplBOgoECdNo/5eBpsg8elRo/O8XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ceOCiUal3x2CUb6+gSFDn+xj67LposR+qOo8ZKtSNko=;
	b=bMteyLmYv7fYr12QfEwY3wkBKEOWcvykdVb2G706Eoahze8lUyAmN25DJaZWvX31609j
	 BxKl01iyWuFQwoxbHBA+EDC0OubghKbD3uzrG5dF61Y2NGsgm3jzsj9PONEXWqNS4+INM
	 ubinwhmnuCsj/8gY/rQVD6pVq9fr6iLwBn7BkGjJfLdT8ysh/exZoyTbN5RHGFilAZFQV
	 /ZF15aHNesKK6kWjKuL4BFyfCQ+E7Kl2BSPMk1eOuYuBKI1lFlOZgFizvA8vKllJYZQxL
	 fTB+XehJjLGvXPiF17oin/Zrlkya2L3pSQtSsnzQe4rompf/wjcULDJ6lS/xg2hq+cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QYPeg/GU";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72112606A339
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72112606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QYPeg/GU
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-38355b03cb8so1604603eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244343; x=1795849143; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ceOCiUal3x2CUb6+gSFDn+xj67LposR+qOo8ZKtSNko=;
        b=QYPeg/GUH0W8t0GKwXHdQVkNgatdDcUR+sG+6SpGYag03+hy1WTBQnWeuuILssHCAy
         VI0NQYGzGHlET0gPM7krnXW6BZX8TVBhUm8MHNAlWAkYEUgWpOqflYHOMYGcoYX5fpIS
         cibXR77KZqBpmRdQ5gdHvlkjb878WoaxpbDEmSWVLPYcmuNCa0LtHPriQcoZg2WXuVvf
         OYbtxe1IbcmYoxi5cyAo6Y3iKafgj4w2UGf/Nbe3dQyf5/XEBWd9bRg6dzfG9wtFr+rR
         0pWBIBv/gZUDiIH3vOROTYYqStKon4w/iHD8sVI3j3PUr6bTTiSgTaS1gXjyayoYO9td
         vQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244343; x=1795849143;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceOCiUal3x2CUb6+gSFDn+xj67LposR+qOo8ZKtSNko=;
        b=SDVFUIf9ZSwzLQZlzBSj3hZUgVvkdixJVBLnpDeaR/QuOxuPEx41G7oWuXGD6Brd/D
         IPtmgsC2fGYNe+NnO8RAqpSyKjvtzTX1fvJ8ElSQY7Bgf6ta5AlGet0J2yhREm3tDt/m
         /yhwqsDLQraKQNfpeLIJHMEOwBUcvB1MWi7v+PoGRR5Q3kBegWyTWAqNXNdHtANbMv8e
         TemNy5vxE7zOYxO1gGyA3WzMS7fVrZT/b+tJKGi9MauQnj/obbRf2JgInP9TpjXY6wHE
         OrieI2NLMW9zX15JQkzOqa3xxSw3BnSGUjgbwJNM3JjNeKE5MABhC+RJIlBZz0btXSee
         9lEg==
X-Forwarded-Encrypted: i=1; AL+hErGAsKuSb2K+FImVMXLgz4zFOMx9nQyk164OmB2ye50oRXVn0edloaty0ZPX33iIPZBcdxk0B/GQ/9vzHUByLwoq@vger.kernel.org
X-Gm-Message-State: APuU4Z+HlK+mojNmQE8ueW63P9t3+yJE82WL8fWHd1cxXZGll0QfJI+2
	uzz67qh5g3SkmCohTujNUembCa7d6cOfQM4tpzmiZiXxo0f76nWI122AN73EPE+itHzSc7Orvmp
	f8MRWdNvvog==
X-Received: from dyjz27.prod.google.com ([2002:a05:7300:b1b:b0:381:fb4c:34e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8641:20b0:383:50b7:1d78
 with SMTP id 5a478bee46e88-38571223ee7mr5801142eec.40.1795244342218; Fri, 20
 Nov 2026 22:59:02 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:56 -0800
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
Message-ID: <20261121065813.4143649-8-irogers@google.com>
Subject: [PATCH v15 07/23] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
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
2.56.1.750.gf70dc682cf-goog

