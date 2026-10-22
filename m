Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700125;
	b=nMl4FMXYRQGW8TrXS6fWWB9TeVtxAqEaNVS7RqIUMxtwusweomqz7Brt1lmUecBwScIO
	 CI9wG84M2yrCeNbInFi5ipPDIYTRM+3Cmo1Gseo0sVPWL+Jj9utijL484G6T2Zm/AdG9X
	 CcR0swmlEFhxicwxTLeuUYG3T2bKvyPyWN5ubT0Ikk9EyKQ63L91ELWnzjliFaOcjcAjw
	 QSsdp+jSgDtUt9cXeWrIgf2UtfXRKtd6pSCpS7ypDsoI9UD0vWZfPJFJ/boCZSzX6Yxkb
	 OpONMhyAdoAlnqHTojLr+sEjFo4imwdKgozvv5KEwRXx4DUDTKzrRHU4q2qYdG8Yx/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Io+g6hIKWvFq2IWPAUSEo1ar0ouYOg7HxlaXmXYkNnQ=;
	b=ANsRihx3MeezqDIknbDuaGekykkm/8DzPN+585hSkKNRzKe46kvgqMnjIfCoZeNPNAaU
	 xV6Zd/syIvtut72QPKCCsvD/uJ2eoJMcwF15lnxH3l9wf9bERDSZOuOcq8HEpjNBtF1ab
	 +fLGUMlBLV/8xqdsy1Ue8XeHsO+C84EgqkaHhgH3z5ycKK5h0tcC+pnzgIfzbR59GxqyD
	 a/WdsrGGtfHzmrY6HC2eW3YIsjr+siEA7QKT38QrU3HshclHwbIKecoDIIWb0/VrYE/Kx
	 jBvJ1RXNRQiA042apU+Xb6TOOXIhCNAzXTleBm3mU24TE073d3XrEV3BeHerL7vSOHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uVLWRb2f;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C5606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uVLWRb2f
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510d0baf63so452290eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700125; x=1793304925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Io+g6hIKWvFq2IWPAUSEo1ar0ouYOg7HxlaXmXYkNnQ=;
        b=uVLWRb2fWrvgQ8HU/ZWJbsW3McCkWRdC9H7gMr7Qla1zkQguMpp34kbi8w9/fWWL13
         ippeyEqml+lZYOaJ1w/g/aZtLDgWT4vvRCVXd0uqQJt1LYGQPXQ7k5Oje1wblgVPWAwP
         UE3HCOid6BqJdls5HLpi5ErifirJdgeY+vKdpWvuNFn40b22A5HCfEMdtvvePvAok139
         eDkrLgWHgU23oP/GhThjmBe7UERV9V3merXHGfWSvvPOm8GW5jysl8D2IeU4QUFEnIRT
         Wjxnj/p90Sz4fpzi75AH7gXL+OorsoqcSyAbbs/l6RgMHRJ4PUqS0ds13GzNMSSj2jNz
         LTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700125; x=1793304925;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Io+g6hIKWvFq2IWPAUSEo1ar0ouYOg7HxlaXmXYkNnQ=;
        b=naTIVPSYUe0ACE2Raztgntws/8FQbjr8xAS+YewQhGfXTYe2wxdaT+07v4a/zjILsU
         qLH+UMtAb7NWNTJNonq25F0Y/85XwduVhN53s33e2kbL7XRb9JxiYdtYRJlMMVvRY8NY
         j1JAMHOoE7apXioPNTCccAHo72BV6FgQAfOludAy/cUGCT16OU7JiVu96gJxW8MUhMPa
         JeJyrSn7Sf9OPu2RfIqZbW0tcrP9piRrxPWKziO1aLuC1a3KpJtdgQRmN5XPvfacIWx2
         BWelJ0bCawGECm2WlYl9PXGNjt10m6p5mrQPsCrvZ7rgxrVsi/FNuFyG0XK/wnn2gkHs
         WcMA==
X-Forwarded-Encrypted: i=1; AKwUvBweEAdNznuoa3c+DbnhNuLiL7ZYULpYhqXc3K0jSa2FYwOC/Sit9Hzh2kwcZ064DF/fNa5vSQlvIlWIMXFpvLoc@vger.kernel.org
X-Gm-Message-State: AFq9FYIeQ8cl6jYbRS2UrlXAfO7DUyQa7kdCAemIXOxu0DRWyH+q0Td9
	2Z4/JFakQXjn1yyUSccL/euzkx9+QSlBQY9jP3dL77sjYc+0km+fkX6PhDFpnVeTLxIhLd9w0aS
	47KGgR3rKMQ==
X-Received: from dlbsj2-n1.prod.google.com ([2002:a05:7022:f902:10b0:191:45cb:f8d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b8f:b0:170:64b:b388
 with SMTP id a92af1059eb24-195c7e602f0mr528936c88.46.1792700124050; Thu, 22
 Oct 2026 13:15:24 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:40 -0700
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
Message-ID: <20261022201453.1717523-8-irogers@google.com>
Subject: [PATCH v8 07/19] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
 tools/perf/util/dsos.c |  7 +++++-
 tools/perf/util/dsos.h |  1 +
 tools/perf/util/vdso.c | 52 +++++++++++++++++++++++++++---------------
 3 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index a2cd37bd1660..40267d3a725d 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -284,12 +284,17 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, const st
 	return res;
 }
 
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked)
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
index a26774950866..857a79fd8805 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,6 +30,7 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked);
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
2.56.0.307.g5fe7bd680c-goog

