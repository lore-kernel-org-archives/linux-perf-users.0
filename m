Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA644F5E0
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195329; cv=none; b=XSeMKqQdZ+r/oiPEnCe3jd1lOlvq3S5RYsjckfah5pvSftIGktsmrX9aWq+iqtLY+VNNTkEwupRj0L/+Ng+OpkVVcnUHOfamoarssg8aMKoLocIpstfSioVgFGAfx8vniJk0jEGRD4KDWbyspqp146MhptFXe3yKJrDwfto+/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195329; c=relaxed/simple;
	bh=bpFNZaYuwTCMcr+uQiesvng45mUPfxfYKl8zKxZwNI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twpeTgNFcAx83Psyjjp2iAcaCyq+7H1/n6MbW6gxA0QNFKrMBbt1hrCkGzIrJcPG/Y2OSrpAOMhLatHONCTirrxzdOgrYhezEwQFx0yyQNZTFYUVfoXZArrksVnI6/XTuOlXvxYE+qNNbRcAL42vXnw+y0xyXWouj4EwtcaHCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNq1Nn/0; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNq1Nn/0"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67921b515a7so627115d50.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195327; x=1792800127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMX1yKnizXoHYuUYwiXKhlsMcTLb0C4TkTtJpsCQmZc=;
        b=nNq1Nn/04ZeGibXNKy2NxhLYvt9MPedMGfkskb3+mFmjHUiOWz2cnN3KI/2zQbFuY0
         NMGmOIjx5rBcQLeMVAeBpLM/d/u9CmFBDm/9t7uC8PDqAS0KP8Lqem7aiYuC9ZYo7Eeq
         Kw6e8Jq+a6tiL7cT9jr+tIvmBnYNMd1NUkI8AypALTcxIe46zNCyOAXidXrF33VromxD
         XRmpbX1IKoyqrptYyqtVgX9xJ7rmCzEnnIfYYfj/PrMatkAFbwmUqJ5ZyVRVGhN6mZrz
         1MczS5wN2W16twZECEQi0Qs3vQxFl/wdYGTcKlssT7ogIIu7MKwo9NBzKGgRf+7tygm5
         Y2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195327; x=1792800127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMX1yKnizXoHYuUYwiXKhlsMcTLb0C4TkTtJpsCQmZc=;
        b=yKKxLJJe5qpagWDz9hGUX6hn0kaOCiUNsTYATQiFpP0fPUkXalvMd00IO7xJ567zZa
         lj5esM989i+Y/Isxq/dqFyJg14sj4oJS8RlLdbLt5WlZ0fabR/sRt14AjFmnxXzpaw/3
         pSaOYOYtOkLUshS1+vqLXa6m4PTtTQ6f63zctlRWoz0Drdm2yAfjqBaHeeOKLNeR79as
         YVn6mCybYD3CwziTP6i2Zn78p/4tsbNkYyw+K1lmBz7i9+GFeJbWCO7JOkpg7i9nx+7F
         U1AMihY/2DESqtltyft7cbR0206Qf5dxZ0WYAbnceRWr2t8n6cYoUlF2C/e6RGw+YWtg
         ZwpQ==
X-Gm-Message-State: AFq9FYKjM5QxTmL8XwURarfD4Vcw96Uw8he4G0u+/XwSC+ffpjp+LykU
	N9/Xfw3UXMGcaDnv+ClVQTLNEGuXICZojtAcVoiWEaFjElUaQEfeIJnb
X-Gm-Gg: AYBFou0E+UVumVSlSVF5cbhzEzJ5lFUU7Ut422Hq2sA2aCu5HIeQR9owFIrKYO/wWls
	buSrgpwwpGOcaRCqcB4gIJVSq7LPrVpVo14RAnCCklO4NPx6089pvGudll1RXrU+Of3ouC9EW+D
	b6VAkCti/JpH9Lo61nHZnoecyT5JLxck5Pi5WxhuNN6i0NPBOsb2DloWnDti98hq7i7OZA2SyLs
	Zjkwwaxpruq0lLN2TAnjsnX+G13wXctgaaeBnNXHFO/U0zmQd2uWAoSqjkPuxremo/FNtBSaQFx
	02t4GYsEsCE4ppTP5t3scLBF4sAXCYN15NcpcWBq1uTzRgfHxrDRgBk5wn0UDyyi0TE7WQP3GPp
	HgssXwqo8akKZaL2nlHWPUtxQ7RvHezmr5aqd6m/yYVFxPsKgHTFkAt4bIPeVTTYo4xsx5hbCM9
	eI1sztA+Ket94m66bmwgQJqIuKDFBfM0IAlRoj4MPg56HF56QNnxm78eS4XriLgv6Y0FRmJTQNE
	/cDKVoPbQ==
X-Received: by 2002:a05:690c:c4e9:b0:8a8:6a39:37e0 with SMTP id 00721157ae682-8b0f21973f2mr5598407b3.42.1792195326755;
        Fri, 16 Oct 2026 17:02:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e591c51bsm15065347b3.34.2026.10.16.17.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:02:06 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] perf dso: Move dso__read_build_id() from perf inject to dso.c
Date: Fri, 16 Oct 2026 17:01:52 -0700
Message-ID: <20261017000158.1178269-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017000158.1178269-1-thepacketgeek@gmail.com>
References: <20261017000158.1178269-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dso__read_build_id() reads a DSO's build-id from inside its mount
namespace when it isn't known yet. The libdw unwinder is going to need
it, so move it out of builtin-inject.c and make it available to the rest
of perf.

No functional change.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 tools/perf/builtin-inject.c | 25 -------------------------
 tools/perf/util/dso.c       | 29 +++++++++++++++++++++++++++++
 tools/perf/util/dso.h       |  1 +
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 70bbfad5653e..7e4b45a5062c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -892,31 +892,6 @@ static int perf_event__repipe_tracing_data(const struct perf_tool *tool,
 }
 #endif
 
-static int dso__read_build_id(struct dso *dso)
-{
-	struct nscookie nsc;
-	struct build_id bid = { .size = 0, };
-
-	if (dso__has_build_id(dso))
-		return 0;
-
-	mutex_lock(dso__lock(dso));
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
-		dso__set_build_id(dso, &bid);
-	else if (dso__nsinfo(dso)) {
-		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
-
-		if (new_name && filename__read_build_id(new_name, &bid) > 0)
-			dso__set_build_id(dso, &bid);
-		free(new_name);
-	}
-	nsinfo__mountns_exit(&nsc);
-	mutex_unlock(dso__lock(dso));
-
-	return dso__has_build_id(dso) ? 0 : -1;
-}
-
 static struct strlist *perf_inject__parse_known_build_ids(
 	const char *known_build_ids_string)
 {
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b51..e03e2cb9212b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -569,6 +569,35 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
 }
 
+/*
+ * Read the build-id from the DSO's file, inside its mount namespace, if it
+ * isn't known yet.
+ */
+int dso__read_build_id(struct dso *dso)
+{
+	struct nscookie nsc;
+	struct build_id bid = { .size = 0, };
+
+	if (dso__has_build_id(dso))
+		return 0;
+
+	mutex_lock(dso__lock(dso));
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
+		dso__set_build_id(dso, &bid);
+	else if (dso__nsinfo(dso)) {
+		char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
+
+		if (new_name && filename__read_build_id(new_name, &bid) > 0)
+			dso__set_build_id(dso, &bid);
+		free(new_name);
+	}
+	nsinfo__mountns_exit(&nsc);
+	mutex_unlock(dso__lock(dso));
+
+	return dso__has_build_id(dso) ? 0 : -1;
+}
+
 static char *dso__get_filename(struct dso *dso, const char *root_dir,
 			       bool *decomp)
 {
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 55c4aaa53c38..ece54b9b8552 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -805,6 +805,7 @@ static inline bool dso__has_symbols(const struct dso *dso)
 }
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename);
+int dso__read_build_id(struct dso *dso);
 
 bool dso__sorted_by_name(const struct dso *dso);
 void dso__set_sorted_by_name(struct dso *dso);
-- 
2.53.0-Meta

