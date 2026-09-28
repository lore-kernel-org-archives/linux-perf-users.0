Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60B3624B3
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557366; cv=none; b=FeAsGKz05YPHlV13pfW9QmvPqE7QPZGebo/gm/zAsdkhzZTHf1VKtpkIyI3HSAYQErZrLOp4TPTngSA8e5yjvoTNhL2zyhCXEQehu4iTSk8SzN65YgBAZHA4z3xnGfPkyXoMa8jRzmpk83mGO2AGtYX/u18UmjVxsvo+MUtMgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557366; c=relaxed/simple;
	bh=eL4VmYxKZVn7w/eWA9nGuI80ywjmKUwXCi3wAdb0ZNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqQlLfAYTYl+NN0yLBa6kH8lCdzl7D+oVIzhuWsPdCVkx9FWYG+GFQzqCUgzk3gEJvaAzLyfheCkixqyjenm/Z3bzwVE7QSADEhe2yR1hQWI9pdDgx4gOSUT/dKOM/5MXO37oK3maZShUjMUJ9mx/NVzzIDc7JgQgmVG4Lgqdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMpVj9Nt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMpVj9Nt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso14358325e9.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 18:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557363; x=1791162163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OzyQDgQq1bA/wltiHBCWNPbU1mUF4Aonoih9p/CUirA=;
        b=RMpVj9NtGW3ULqxUwYazQuvbnDRJcoCzP3OOtKzaFsJaemCcLKtGfwUwD2yByUVAq6
         mmJFyzJsK622kJLP/oHVkNWQS9MEEZTcUQaxq5azx3j7sj4VvqEi7pz0QrUyeD9DbShG
         YJS8vGMpk31t56bIeGfPFKDz4MoYPcngvkhUCLWWpPXkwVrI1UIYCMAsAW8WeLRKhhid
         Xi6nnDt3pdIusBFpxzmWtgtKSVObLRCNOq+/paTSMBM+YU67OUOZysMgnTxVmlncgNjL
         OQsglcjoHm1jopkFqPpfQKgKIQi8MnKkvEW8v9BvRscmYDBVPYrhVFSaG2ilzGZxsbln
         Afqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557363; x=1791162163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OzyQDgQq1bA/wltiHBCWNPbU1mUF4Aonoih9p/CUirA=;
        b=1IjOuJrahqJHoQi4Slsd4O6BavVWhQhWq+TYQUnNvxUUT6E8T0ulLyJCLELWXgkbi3
         ivtMEfcic+aSLETxW9w8oxBYkLiIHbiNfjTUHS5ocmOxyOn4sGrWKtD1hlJA7ujnMi++
         9AOyeqEdiY8gLVDHWCFCEeLE4P8SosYcsKVC/U4t9fdl8Yl3zinmiVbf57uyJZk4/R+R
         TO/JKypdmr7OX8b2uOxkBza6C4vWg4W9TYN8aACdX9X4gTEusTgf1wgWQXNKqxQYuiDr
         j8Y+dJ5mOz6pYjGGRkR9Zr46HmfaHBbWRxqw/9jeqoow4Fr1jfiCo+gipyhcPlh0BuwJ
         huSA==
X-Forwarded-Encrypted: i=1; AKwUvBzCKKwz9pWabW5YHAnJ3+6re5913INN3jLxrc6n4Ah6YlUgc1vnLaRhAvf3Ht7vSr79jmQXzqFEWd8YhYKqvqrU@vger.kernel.org
X-Gm-Message-State: AFuF++l7BqKRv7p4ggmQsmF4Ph1JO9eGlOjMe+tipdz+OO9i1VdyhVH+
	lqUq9a5wHY9nqLEq/sSV9k84Eo93CqI8kZKFKiNXMkHj0dhBHbb5R7hv
X-Gm-Gg: AYBFou3Vfsz/ZmZHY8CDuQ3Y06Ie8xQWxI3B7aPQy0jAgvFmLZ+rgh36GFbvB34lBHV
	I6oarHSDKwVa/AgsdCo9PiexWrjdEd/ySdZZNNlHC7AtPdwnBBO7qHsq6Q2Jw9JafqzrroU49F7
	pH7Ve2cSckBeUV7OqK+hzXg3v927g+G6iVjaHEXMYBZi0uZ96qTaTZs7IH6MnATurAnpivKQo23
	NYhMWYf8uRulWCuFfWsHNVLtKG0g8mxdhKEr8PM0clCfH89ZsDtLuentXlK8/kPioKWg3mTqgxm
	1KVK820Cg2LHwUqFD+BBg8MNNVI/KXsJLuhoIKaDs1ZOd+auTxR2KXc7pfUchvGactHay5t4Wm2
	LagoTklsfF6oaXXyZ/L9FAZmFSweVlAf97eT4ZjdxltOAyMn2YEiZrvaPH/5gIDzcW2Go13fzMp
	hgHITSm/Ea/p4XFjtIssBWnsWNDQKjMD3S8QiuyQyKhvbpcX8hIfN/uR5R2kPdf8oBU4Ri3gcaV
	Ds3vOAqPQ7BJQCQjBZ/fTjcVrCW1fM508Mla/bXdMaK0Y9xYKVwhUP7p2ikJcKOEN9McVKgW+vX
	4CRyo3LDtYegSWLv7FHJ56TQRVVjFk+VN9BqWhWRqZeC1zcsSuE=
X-Received: by 2002:a05:600c:4ec7:b0:49f:ff6b:bc82 with SMTP id 5b1f17b1804b1-49fff6bc143mr59883395e9.20.1790557362894;
        Sun, 27 Sep 2026 18:02:42 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm144207825e9.5.2026.09.27.18.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:02:42 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf symbol: Move Rust demangling into its own function
Date: Mon, 28 Sep 2026 02:02:27 +0100
Message-ID: <20260928010227.1903673-6-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928010227.1903673-1-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dso__demangle_sym() is the only place that implements demangling logic
inline.  The other three are one call each to a helper.  Move the Rust
parsing and buffer growth into rust_demangle_sym(), with the same
signature as the other three.

A Rust name that fails to demangle now falls through to the other
demanglers, matching how the other demanglers chain into each other.
A v0 name can't be misread by any of them, since none accepts its "_R"
prefix.  A legacy name can only fail here on allocation failure or
hitting the output bound, neither of which is language-specific.

Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/util/symbol.c | 61 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 858a14a91f79..89db9a670833 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2740,47 +2740,56 @@ char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unuse
 /* Buffer limit for a demangled Rust symbol name. */
 #define RUST_DEMANGLE_MAX_LEN (1024 * 1024)
 
-char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
+static char *rust_demangle_sym(const char *elf_name)
 {
 	struct demangle rust_demangle = {
 		.style = DemangleStyleUnknown,
 	};
 	char *demangled = NULL;
 	size_t buf_len;
 
+	rust_demangle_demangle(elf_name, &rust_demangle);
+	if (!rust_demangle_is_known(&rust_demangle))
+		return NULL;
+
+	if (rust_demangle.mangled_len == 0)
+		return NULL;
+
+	for (buf_len = min_t(size_t, roundup_pow_of_two(rust_demangle.mangled_len * 2),
+			     RUST_DEMANGLE_MAX_LEN);
+	     buf_len <= RUST_DEMANGLE_MAX_LEN;
+	     buf_len *= 2) {
+		char *tmp = realloc(demangled, buf_len);
+
+		if (!tmp)
+			break;
+		demangled = tmp;
+		if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
+						   /*alternate=*/true) == OverflowOk) {
+			tmp = realloc(demangled, strlen(demangled) + 1);
+			return tmp ?: demangled;
+		}
+	}
+	/* Failure to grow output buffer or buffer exceeded sensible bounds. */
+	free(demangled);
+	return NULL;
+}
+
+char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
+{
+	char *demangled = NULL;
+
 	/*
 	 * We need to figure out if the object was created from C++ sources
 	 * DWARF DW_compile_unit has this, but we don't always have access
 	 * to it...
 	 */
 	if (!want_demangle((dso && dso__kernel(dso)) || kmodule))
 		return demangled;
 
-	rust_demangle_demangle(elf_name, &rust_demangle);
-	if (rust_demangle_is_known(&rust_demangle)) {
-		/* A rust mangled name. */
-		if (rust_demangle.mangled_len == 0)
-			return demangled;
-
-		for (buf_len = min_t(size_t, roundup_pow_of_two(rust_demangle.mangled_len * 2),
-				     RUST_DEMANGLE_MAX_LEN);
-		     buf_len <= RUST_DEMANGLE_MAX_LEN;
-		     buf_len *= 2) {
-			char *tmp = realloc(demangled, buf_len);
-
-			if (!tmp)
-				break;
-			demangled = tmp;
-			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
-							   /*alternate=*/true) == OverflowOk) {
-				tmp = realloc(demangled, strlen(demangled) + 1);
-				return tmp ?: demangled;
-			}
-		}
-		/* Failure to grow output buffer or buffer exceeded sensible bounds. */
-		free(demangled);
-		return NULL;
-	}
+	demangled = rust_demangle_sym(elf_name);
+	if (demangled)
+		return demangled;
 
 	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
 	if (demangled)
-- 
2.43.0

