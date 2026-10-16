Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D758E2B6
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171899; cv=none; b=Dq989kqevOjFbFD2q+7alSopFrusI7b0cocJdjuLNFdea/fItgnjiwigi1RmwOC6CPWNtt6WiuCuy2qcHyWURsNOMUZDdSx40ntF4mQrgMCC1Cg+nQ+7VrkmJcwjmKSBh5LjjKS8Hr1bOcvnGC3z+2ZAiiUeouxWwVyY47m/nMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171899; c=relaxed/simple;
	bh=XzWZHONgT/0d/n03HpxSQAnMoK9ViAwbiRR7AIBlFK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cj0QCbQJQHMkH3FqW7v5MYEevyEaVLWf9vEcHmDzppzrUKo0zym+uCaKHhT6Is+GcjP2mHsi4k8VMBJEYBlgTb5xwBwbHkF1Rwm0FxSw9cP3ohYaEeyUV9FveSjTI+AQBKFKhKaLOsqzwAgEKEYhqTxrr532y+6Cj/Pa0wHReR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aw6nh+w4; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aw6nh+w4"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso120412eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171896; x=1792776696; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IktZ7k0WQQGq+h8FFQr2kKvApPwIP2MyLekNCFtbtTo=;
        b=Aw6nh+w4O1gqj7jAtrzeCMBDI2iCYsHR32EJgpN5m+8XqdPCeTk+9KDX2t9pQF45Su
         +b7LsHyDZvduaK+7qjntfwvXDQqDmBbkhSwCpRXAIns7nxEvFLKkIHQo7an4DezGep4I
         gpuNsJuP1kEQNPFKaVqfznoAgSIBjoEG0rPK4QoDuvflByJHrqc3MgL3Xr2/nHnqg4dm
         jSuPSus2w6RdgealAa7ky6mcPuaOG+U/l6wnHYub/LvmDFOASMkFXnOEIoveNKUZKJrS
         QdELmdFlQwNHjwylCaiMo/DV5IEhVzH5jDTswnolISFIvOu91DGpDJeIKOmSl0ZDZ3cj
         8Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171896; x=1792776696;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IktZ7k0WQQGq+h8FFQr2kKvApPwIP2MyLekNCFtbtTo=;
        b=XlPKx4AQj9mYZrFo9QUboVZbb3UaEOlA+DAO0PnycqVeZxqkL09odpO59TYQTe20Gd
         r7lVX65prQtAZb+wWuAWrbvT3Tkr4vn3QZPFGWpWRmLCX0TNWLm6xMlvc3XBt6FkWMUL
         zF7Nok+IFEBU278ep3qQbmjYWYGjMG4hMfRHwHK991MU99YrV1HnPXGB9G0O5Rk8YbHh
         ZupqRbsg7NDoHRZdZKAzgLazI1SdhFM2Nbf5rNV7F7dHz3hWUZyQAG3yGWfE3ryVvJyP
         iwWO0V1nVdQh3+pQYdGc05dVKxnUJaWtCz62ZEwUoCS+gUeGWuKW6ZiV0Jvf03LJBW3K
         2epg==
X-Forwarded-Encrypted: i=1; AKwUvBzXvZPlzfqQjK0cOvO4IYlZYmKSpjEnY9FoJyHPBw4D+SkxHgUBnP0t+UoIVcXO5N1UjiKyIbKRkVEAO7mGkKqa@vger.kernel.org
X-Gm-Message-State: AFq9FYIhqE9yStmM0dudDL3WSbw71iwqgP31YySrJ37z9hieKUfchOMT
	P02iX19bdVsvYqhCcSdRCTwSvWHD/UYyvuLkZ51wCg94qbw9Dnurg/auyrMJwnIX5lYNgz6okND
	I8J2Puc2iBA==
X-Received: from dycnb1.prod.google.com ([2002:a05:7301:b01:b0:352:94e:a8c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:de4c:b0:358:eccb:af79
 with SMTP id 5a478bee46e88-361a253ea3fmr458759eec.34.1792171895606; Fri, 16
 Oct 2026 10:31:35 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:30:56 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-8-irogers@google.com>
Subject: [PATCH v3 07/17] perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

__machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
holding machine->dsos.lock. Acquire machine->dsos.lock in write mode,
double-check __dsos__find() to avoid inserting duplicate VDSO entries
when racing with another thread, and set the long name before calling
__dsos__add() so it does not attempt to re-acquire machine->dsos.lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c |  7 ++++++-
 tools/perf/util/dsos.h |  1 +
 tools/perf/util/vdso.c | 17 +++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

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
index c12f5d8c4bf6..dca4f683be9b 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -127,13 +127,26 @@ void machine__exit_vdso(struct machine *machine)
 static struct dso *__machine__addnew_vdso(struct machine *machine, const char *short_name,
 					  const char *long_name)
 {
-	struct dso *dso;
+	struct dso *dso, *existing;
+
+	down_write(&machine->dsos.lock);
+	existing = __dsos__find(&machine->dsos, short_name, true, /*write_locked=*/true);
+	if (existing) {
+		up_write(&machine->dsos.lock);
+		return existing;
+	}
 
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
+	up_write(&machine->dsos.lock);
 
 	return dso;
 }
-- 
2.56.0.212.g129ede20d9-goog

