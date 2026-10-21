Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622374;
	b=UcDZXXoG6XN3rX45ukmBIlgvhpWfAqU5WsGhidK0omQk2GbM12tq3bccE34jhDden4Q+
	 suJYd/xwbUzcNscclUs9G19Tpm99+9vy7IGsCbSp9vk7gtK/EMsAUIYjPGHqSR4Q/zNxz
	 S/xd2TINyLrwB0DYbWSeCO7+/PPbbwNIDDcRIkcozm0fcRRUhX2xyInxbbaELvpD3C+Zm
	 zMgvrY/g1I5WXe2ZHcN/snCWMRNPpdAjCTLI+SmJl4QaTyIKaA7CV9qQ+wGaDf8RfD4Tz
	 tnuT0KUz/DgM8TRAQL5Taj4KLnPSAGCnI8Icq634vJuKP08hX3vBFelFJJpoEeT0qhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8yD69uT8OzBgCMK82/DZER0A0HpZ/t80pTFtRy6AltA=;
	b=t8RIZ6GhaRUcPQVKV969lMRFljjDH43Ev92xxL+hxrGSROWrBEqtiEUOjE6323CghP+A
	 FA6QKEu3Mnq8TBCzunyGIR019AcSOEEzy2vPJRwoi2apHPwdnfh9jZE+RjXTi/0v+gxLR
	 LKAJzsIB+JvhYubdR9z1MlZgI4+Cz3DUGNjdnXzKi8Ia0uRrk3xn7md3w4Z+da3IXezCb
	 l1l22eURunSzUITfJV6vn8YWuAGM4ODdC3wILmywfjnEnCDQJZV6Wax9ylU4Uk3RM5hOC
	 iA6AzF2v9siT1kGQ6nRSX4TuCHgSxSiygtVr86otM/rvse3E1xjy83q/wQVsjoWh4YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fvHLyB4k;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189C606A322
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B189C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fvHLyB4k
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2251991eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622373; x=1793227173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yD69uT8OzBgCMK82/DZER0A0HpZ/t80pTFtRy6AltA=;
        b=fvHLyB4k4n9g/gUoYvL0mBeTV+VWZif/gpqlAvFetRV93KxALBF+etnuZF3Fadm1BW
         QatEEuiY6hVsxCEc2DnbJNbwlkZmSGPbdOp+Jw8Rq4DbODbQrFlcc6iBaww8ys6AoL09
         cmrLg2NyLPziCppuCdBYzYChizSZrLIkN/++Otoyuksw7K0DYRm52w6svb1lgbAMAQlh
         ydMWiJIm9sFD4Ca1dCB/YKnDuK/HbURDfk98QdMcL8BbrpqsUNe8m1tYB+R5RCTUCymv
         yDfS1hw+fG1/NLysBi5E3fL5PBpho2wHnc5mFaLYzr14w6sFPGwZy7OQ33/1JUt2sN9s
         uK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622373; x=1793227173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yD69uT8OzBgCMK82/DZER0A0HpZ/t80pTFtRy6AltA=;
        b=lgL2eTEA/4PTnXilaE2RL88kzElqXuj5jEONO95q47nkzU5K0Kw7+Wy9maLEcNE3Lp
         G2+ej6p+/iTXxWYZ9lshMFO+awh3qdfBC3lFONAtwTgFYkznEQyiOG4Ri8IiXx14KBjC
         apI1y/Fmc8bDYVBTT96vmFdqi3pAXI1Q28gbEIbNUYlAHUqx++Lg2PTTF5rtTsVpZ/wf
         35y1a4fwjJgdc2MmF7rJvh0diRBKrWgLY4v56agfLc9DtLlnaq0NKpEELf2SzlIdL0H8
         inD63/GFjv1IpkDTbrUefoLUB43T//blaQzJ1yqSj/vDBphLtFolPjPG4N6FGHgnd8Le
         Ym8A==
X-Forwarded-Encrypted: i=1; AKwUvBw5i2QW46YYpDsCybNPjFz9Me5LY8t4g0nHKITDVUDWRPofGE/rlio8QlsJRrYr9iDp9iuMAHLR6CuFWU2gf0fD@vger.kernel.org
X-Gm-Message-State: AFq9FYJCIQfdEkzqMxgI9XKZloEvM64mEtRLnNq+Ac0Ra3tekkzgxRZo
	hMJQ+z1WDNeuTZEHTXtuTbIULxF6cv5n0SutBZGiCRnNLdEc872ZJq/FUzItFMBNBIyPg3wQRG5
	iEzgpI3YBNA==
X-Received: from dycak12.prod.google.com ([2002:a05:7301:1c0c:b0:353:82df:8a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:414b:20b0:367:5e31:ce29
 with SMTP id 5a478bee46e88-3675e31ce6bmr4921809eec.20.1792622372488; Wed, 21
 Oct 2026 15:39:32 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:38:55 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-8-irogers@google.com>
Subject: [PATCH v7 07/17] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
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
2.56.0.218.g1ec904b173-goog

