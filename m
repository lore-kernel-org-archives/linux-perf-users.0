Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39081A5BAE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767799; cv=none; b=V2liTCoLHgtZx68fC/DrWxntzuxzsQBMZ8gWDPHe/SLi5NztoeasCjyfG6a/5cJxWbchmVvtnqhAtfPrf50UX4A1IuQUGxfmgYYPI7fkkDqkDkPxeCTINwNQzwuF31bEHd3FptPFnfoCyiXGxUl1VL3cNOT1SeSojifMX2q0N54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767799; c=relaxed/simple;
	bh=NkDzTpISKGLznN8DpCYnw5FlKY6SegO9ajNHEUGCkJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOyQUjD6CcbQ0gRkjubnYNgOu7zU5GALwNl/HSjNkf4ACCLyYDdWliPAqrqaY37HbCEZUPUKfQilaz1s/exKtwYvh/jIurNRCYLOJvyLe+5HWunzj8idGFtn2MNB3aHKNMmPwEN/GcWKbT5PgtSfwIrIPTfV1szb5woYLht2vR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdYTU2PK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdYTU2PK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfe12d285so762399c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767795; x=1778372595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptY6oVWnZ5/CE0Bj1nWU4voD2W/pshYyEHj8eE03jqQ=;
        b=GdYTU2PKbcSzUH0ZJXIhX+sdJzJ86wlWCswF45l+2j0w/aJ5vIZi4ebKljkMoN2ZQo
         ipGYwFmX7koc3Bmfa++pWetC/9Vy9vbOW0sDhZPx3DP0mawjK3oxF7HpDYTzbYP7rZWo
         OZT35YnZoJlADwMGbnj2QAK9BEVnpMkZWe/HbOaNU375bZRAlbreSPJo+CWt8m2ogGj3
         sxAaMexHkdCQx238dtBMrXxeapbdyw6kFdiB3UlB+zhET+ymwEEQPJrjqxwcDlZFfW/n
         QKsKCJKDJmxZ0b3RRY1ShHI8szOHJGK+935QBcYOXi2JGb93wD7hv5MsqiXFE2pY49+e
         xuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767795; x=1778372595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptY6oVWnZ5/CE0Bj1nWU4voD2W/pshYyEHj8eE03jqQ=;
        b=Nm3Wp3w+Uuk1CCteDwCqjmY4dTqaUEAGyEyBrlKoFGThg7YL5BCDF8xXpaazg0bolD
         r6kgym4DE+71z5MvGCJlau7FRj5klnNYu+rYGnKJTKDyrdYnv19TqUV5sPeckxpUUnNm
         ajX8om0W/MqvxqqH5KMMt7mFCgtdxY2jauoZGSnsAjypn15wD3QZg22SvOfpQC7Qp8pt
         zJ/GXhCRUNaagOIucAWXryXOluFxPcwUcyx4zOn0UbUo8SefXMSZgxJp5UPENdw80g7D
         Q5/ibbYhdydZIcSV0MpJIJq5P2TFklF/woHJggdada0GaEIYLE87z2og5R6THc1tDCr5
         5dYg==
X-Forwarded-Encrypted: i=1; AFNElJ+GtmZLGA7B9CSpRuukm85WO3gn0lSeTGG23bjA/NZjOlbaeI6+mhTkgtfNBaJW3U0r4zrFLN/8EyVhNOFE/yL2@vger.kernel.org
X-Gm-Message-State: AOJu0YygXOTx7P8fW2rloDMhK4ZhSN3Y1fpnejgiL39RZ9FA7qiRhU8V
	VEWGiE0qM1bvkB4L2JYfEoIhk8H0O4CD3g3GpRDGpA35JbwvY2skfDqqEpfrgkiRH8wbYUojpBj
	vycyO0//exQ==
X-Received: from dlbps10.prod.google.com ([2002:a05:7023:88a:b0:12c:b3eb:b31e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:224:b0:12a:72af:83d1
 with SMTP id a92af1059eb24-12dfd7c5ed9mr2445709c88.11.1777767794714; Sat, 02
 May 2026 17:23:14 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:41 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-12-irogers@google.com>
Subject: [PATCH v9 11/18] perf header: In print_pmu_caps use perf_env e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from arch to e_machine in print_pmu_caps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f1ae61392cce..bdf6c5d0fd5d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2348,15 +2348,16 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_env *env = &ff->ph->env;
-	struct pmu_caps *pmu_caps;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
 	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
-		pmu_caps = &env->pmu_caps[i];
+		struct pmu_caps *pmu_caps = &env->pmu_caps[i];
+
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
 
-	if (strcmp(perf_env__arch(env), "x86") == 0 &&
+	if ((e_machine == EM_X86_64 || e_machine == EM_386) &&
 	    perf_env__has_pmu_mapping(env, "ibs_op")) {
 		char *max_precise = perf_env__find_pmu_cap(env, "cpu", "max_precise");
 
-- 
2.54.0.545.g6539524ca2-goog

