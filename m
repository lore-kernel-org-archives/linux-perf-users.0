Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026482;
	b=YvUtdZ/qbMkGQEvkxagL2e/npzwc2ln6UTvfvzmlisPg2FpQo30YKOYo6hsfZDGBdcgl
	 1mELWYCj8TioMuUz5crsQpR3CRZ9IEizEqOxuoNt5ijEeaOJhkjcXexlOkFHQyZJfkvWz
	 lG2B0VP3j8d7iUQuFLFk+NUzLFTDXktrQzb/H4dLFOZSuJXCG6D3qIhJtmZs97uMeTNSX
	 GGQCvCGzTEYQ08zG6GcSlEWso/WxWzYI92jxVzQoLUfJns223xQrF0NK+rCRVgRJtzVAX
	 4R4jIG5FiF3rgnmOkTuqAyGWrwDlIAQpfpu2FTi86Ab1Fls+9PBvpyKvACVPtkCNljg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lOeR8RzemfDpp4D3hAa7zuXnUCxjXzQiGwjs9g5Q/fs=;
	b=FfLUCxGkN6Qd6PrqPsRN1/pkMV/W4Z2W9QNKeDPLY6DiccTeFBEQSMUUurlp0ia7usmc
	 ki8zkJ6ZZa7tLgdy+GQJz9BurMx0REFr6FJ9DPnJgxaZJuPGxosmKqu7P+c1fAsxtAU44
	 5x0mJaJ+pDIlMTQleYuOAjYT6qr7wO0iyfzsh62Vt2idu9higuiIa4vqNtYZE1hoXCynY
	 LXMGrIirRP8uAfpI0FTkK1lDJlC9nG3i9HbVEVC1Ln8cApNdS3g1dh+4ehPYzrZFmuqtn
	 5+VrGaebMa/6C8c4wLiyLOzxl8Z/qAYRri/Qtug+iKM5y+YrqRdCwtbLbll5X0UAt8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PMVORd6a;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D619606A33F
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D619606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PMVORd6a
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so2263847eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026481; x=1794631281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOeR8RzemfDpp4D3hAa7zuXnUCxjXzQiGwjs9g5Q/fs=;
        b=PMVORd6anxH86cR/gIj8ALq/yxEF6PEqaTWgCLoXHljX6CBykRRvmDGYihe3j3VF/O
         KH795DhVmNzI8N56WIp1w1gVVRX8noDSBu/eD/O5QXso/opVCRWTGhbf3jZVmIjKYpmJ
         y9g1BZsi7gd1VtLSxBJAgPl7fif4ggRJkaKePO2P3OApt9mhutUcylot93CT1H7AD0Mx
         9mKdcukCFfA04Kko6lWY17F26hQ0UjU1sBzu+pwpT3QgK/8ukqySNLNNf7GcKf6Bb6kq
         7lZfNkjCpRnRNOuH4cM/mJMSJG9dEZqOFWOrJILfd/FB+9hnoWKNvRA2q4mOB/cySmjm
         cSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026481; x=1794631281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lOeR8RzemfDpp4D3hAa7zuXnUCxjXzQiGwjs9g5Q/fs=;
        b=gJyW3tsl6elBRX4i8zIcW+8nTbUsk1ZEw27HrSbsgsSiNnNfMM61JkGbFcm1zwd7Yp
         3xN58WlgoPYbeWH+byS8JoP+NLuzVg8HWkpMu/9JrGvMPMg3796+3/zYRThfPXm195DZ
         z+22LvTqknG90VxMyGF2QyJGjih5IA8NWB4QV+1B4JQ2FWt8vM86z7aWu2WrxNkhGqFe
         vz2cl486UTGvtKdRthLK9nXn02a3wucnMD2FoAS1/sP6Q3KBrI/c4Rt3PLyRrXcR8ofK
         NpYc3JGr7xdBNEolOE/oLOmcOgxrtCApduRcG8E28NM7mglzXuXi7Z36cJp70l0mwzAj
         YxWQ==
X-Forwarded-Encrypted: i=1; AL+hErEL1fW+7+TQPpohkSmRjd3mF00ZVLq8HJXe2zVlb6vLsehtCciZOvipJc7lV8FgCXXwqKcXY2lAeiz8ETtR/b4v@vger.kernel.org
X-Gm-Message-State: APuU4Z/6Q2s340A3kcuxtaxvJbfuDr5T3K3p8YIeRHCzEQuxb8NzAaZK
	HFZZGCuGmGK1vAvnbzTDOYb2DGLvmy2QNv/QAb1CqNjR6tRlnCZWP8hI2hG1so7MUs8yhXADCqz
	cMTfTNJ5/ng==
X-Received: from dybmb9.prod.google.com ([2002:a05:7301:1909:b0:36f:7f0f:e2e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1525:b0:369:f9c4:1fda
 with SMTP id 5a478bee46e88-36f7671e12fmr5713721eec.27.1794026480981; Fri, 06
 Nov 2026 20:41:20 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:48 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-8-irogers@google.com>
Subject: [PATCH v11 07/20] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
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

