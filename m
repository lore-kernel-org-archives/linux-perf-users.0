Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514228;
	b=XFAZyJqEzXAkLh4gEsDJLsKR7hi+u9t8bZqsspXmuXIOr81Be6P3GlbZL0iquhp4UHwT
	 wXHQRTRvKbXDgkeu+1Kk9Y2bxZ31oKUZM2Qr/EjSLzv8guZDYGI1Lb+4eqEMTRkHJw6v7
	 ojJfncNpIXSfKmfwjG1xz+SUcSEpKmYvIYDtzAT5cZ9UEyX/f9lW8GjDbrYwq9xMBlf11
	 4z5vtjzXUkzkvwNNSMI+eNd4EKCKZb7kqyd6Q7EfDOolXMUPtTqN12cElMUaKunGrpem0
	 zyMBojhXq5v0SuCDKEIFBdYJhwIq/pnEUDYE2i8jcSR9+gr4DnLyTse6hUSlWc98WDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wQLFJHwsU3MBb+ClSSSakwCLT+FhipoiHayuTmyc88E=;
	b=5fJKt2rgUiYg7sVcO5l/HJmP7/Y3aoz+Ncy17qCNZwa0zMHchXQ5qkq0vjZkdZcM1B3E
	 DnpMjPBZ4jmdWFxdQ/qIlWCe33hLVq3h8SzHql+fYbiL88RPbbElEdkyqoAACCPwkopet
	 HZ0HyQT27P96QSOIHZnX4Qo+xOCa8R0/i6yV/EaZd3OLYW+IR8djhJeye3q0RyBWAfyO1
	 4b/LahrbXk1IlNlvEFjcC4ZIqfwhkyz3CxbFHWforTLZ3rZ8Ao9dIIBEa+W7tl0a0zSFl
	 Rv+ukj2gVFrtEyZaMjm+uKRLg/2nvxRK5pbStGVbcQGcKA6RLo+kEkgT7nqsdURnoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZfiKGoxd;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF860A263B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24CF860A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZfiKGoxd
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-18eb2616974so829427c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514227; x=1793119027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQLFJHwsU3MBb+ClSSSakwCLT+FhipoiHayuTmyc88E=;
        b=ZfiKGoxdfATcf1qK4Skv+chsHF6ONInLM31Efdh14H5f39kvN5fJaaZs+5g9yMHWB/
         OV7p95f4shMdmMHFGxk3DOKTT4UZ2ev8IM0qs6X9Y2EDPnkwpROPxyjJ7g7nj8oAPNP2
         0SpNw+KqNFLnwysUz3O3X+ZVfw1S0yMFgz+Y8nBC7+FCfPVvjFsUVcgvQQDodg/zw3nn
         cUzxBt5u9SNz+2Z+TGgtAM5J3xVjcqTQmTamkU1ksYCOLR4KmnlIKo9ddpx9lRYH6WN1
         56JNizUduxeQSsRpLvQlnOSkp9vtA3S82k095vG70ruuGd2q4FV/2TziRgIdPenP6daF
         x3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514227; x=1793119027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQLFJHwsU3MBb+ClSSSakwCLT+FhipoiHayuTmyc88E=;
        b=f3ccjoXK22zikft8Uj1zrFkiJetUpq4fvnc+VelqNUbcyV/NWH4cKojV9O4eFP7Ymw
         5B24KQTuU+Bd7JMAWkICAlVPIz8WQuaOKYweA3QQCVikMj1SbXl+VG6OEEczKQvGyEjg
         YkU5py6OwLiTmtYSueRYy37zPla068d40da8AvT2ouxJ2EoCQmem9KA2aZ9WX0aVSvkA
         +3d1mpZCam7IKrTkg6LyztX2lZq6SC0eww+zrc6YUw4Lu3kBkWvpF1FyNzRpMpSuoG6J
         qDg5cGVjROuBGj+np3OHXEWnwJvNximjd9hT5GeKH8vjUAtb3j6X3H4C1PpvCi8pmZHw
         qY/g==
X-Forwarded-Encrypted: i=1; AKwUvBwzO5R+1przCyrn+/MQjBD1BYUSn/uH57Sd9Gv03yqa2GwPaDOWaDl90rbSYTr5CXuARafl1tuEgy4JGK28HhVn@vger.kernel.org
X-Gm-Message-State: AFq9FYLuTTlI0kHz7WB/DtPedg+QJfqSld0N1jHtwecLCvyzN+7U5Bt/
	DFBE/kuvh37CDFwiwhjY4jwIwg9RMTU8TLh5z/cwyuRu52iH6JUKjh5VASbgYHunsxeA3Ark0o7
	P0WuJoHEa2Q==
X-Received: from dlah17.prod.google.com ([2002:a05:701b:2611:b0:14f:4204:735e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea44:b0:181:83c:5df8
 with SMTP id a92af1059eb24-1851238b3e7mr15524858c88.11.1792514226408; Tue, 20
 Oct 2026 09:37:06 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:30 -0700
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
Message-ID: <20261020163640.746159-8-irogers@google.com>
Subject: [PATCH v5 07/17] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.212.g129ede20d9-goog

