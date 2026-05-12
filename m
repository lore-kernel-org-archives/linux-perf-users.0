Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE33AF67F
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625085; cv=none; b=YCUwjuHEts+acgdQlxvGwGfuVYTITVEby5ABgX+u5FGUZdq4NNMhzWHAFsJ+bUQd+QQgYegQUk05MabbEr1Hsbob8k35rBDIS83DWrEhfppdUtD5NzpqXtX7i7rtcZtYMK4VpoGsQBZAlNjHucYyrkhKjyTcHMVV/57hnq3s1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625085; c=relaxed/simple;
	bh=dx+WuMTApC/fTgGyH7O/jan1RI+gBU8qEOBCan9Cx0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ck9nOVZv2O3Wv+rtxa4zcMBTegqikz5Mo/l4+9yj/qzQKzpxYTMPAp/3VbeqmrK2W45Rr3Suzslg7XQNiefpizFmaUuc9IdRb9dsKTgbmXw0knGeFmIratrQkcYNBGM8M0ZJZ2h+oTyIqi2Fm2hrliOOFRP15vwF3zPvMqEvRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mdp8sdZj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mdp8sdZj"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12df8bc580cso3731959c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625083; x=1779229883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAlPdM1JccJbFc98Py7wClS17w1Cd2LpeNhSMTs+2QE=;
        b=Mdp8sdZjyhUt21z2Ye5T9yBGFwsOJRNQmpsr/EyeIH0w+VJ1y4SRMpyyyxsnlgNqUE
         UfOJuT3lJki1GWWu/F/jTVHC41PLVKLq/qSPhNkvg+IqSfH35/r6qvy/hD13b/QkXiz7
         zwkkYlQgRrH004iaEhChxVI3y7SKZpfoB4njVAXqXTGgZLU1GUEwAPoHcuybAqxhqxN2
         +iAM7Gze0srXRTAZb279di2+2Swjq12H1NtISVmSZVNzPKPBiy0pBE54JhpzkEzUDHCS
         pchi4/xI8W/KzUL78+uxIG5eY+E9toq87qV/Y4UwdUBWvoZsm7hTm+M5djSMajPuV0cT
         hOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625083; x=1779229883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAlPdM1JccJbFc98Py7wClS17w1Cd2LpeNhSMTs+2QE=;
        b=H8aDoTC5SFG0WcoR53UujUCQ1rCwMP97TnPdPOQOU/9Jx90iaRKc6hWipSk6BJF2zL
         qqPsYXgUBFS+FLViWrZORUKeqAxeZW500rzrlPz5yJooRSGvrh6oFY6zRRRsRiA9S+yA
         rBcfoLa/y+CeSycoM69/y6e2xXSI5y5kWQBnpCcrOk8ycdyY4wIhN9QMUTNC0FL36zEy
         QsQP0Y+NuPyf0J032ixAzzg0KdFgKPpsPmChvP+q7vKLZirn8piUAUaxbRt8wZG1Wrig
         251bVrfmQ7oGvgmHT1jBQdHAgHXEnExI0QsroZdZ/PdQcJaXpr34qvhtbM9ybDqfoIJS
         I3MA==
X-Forwarded-Encrypted: i=1; AFNElJ/mDsY43sC6SIZFnsF272ZEGpnUkK4mzuy7LGzaS4zRLA1jjqQkFCODBhS0Ns4tE9SpnrOr08+NWpn+JSZE3zqE@vger.kernel.org
X-Gm-Message-State: AOJu0YxvklzhxBq09NqOHceRcXTEfr2Pd00aD5c4yVch10utg2WGq86N
	u/QsgimWaf5gmO4Ta2If0dQngeb2L1plhVkK0p0l3DfkFoYlIMkc18xMS64+UCXrk8OXCTOETaA
	N459yp6m54g==
X-Received: from dlbpt6.prod.google.com ([2002:a05:7022:e806:b0:12d:e552:d429])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:210:b0:12c:1288:ce63
 with SMTP id a92af1059eb24-1333b2d9c4amr3299364c88.13.1778625082904; Tue, 12
 May 2026 15:31:22 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:56 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-28-irogers@google.com>
Subject: [PATCH v13 27/32] perf kmem: Add bounds checks to tracepoint read values
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Avoid out-of-bound memory accesses by bound checking order and
migrate_type when coming from page_alloc_event and page_free_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index daf2272c7337..33585e353efe 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct perf_sample *sample)
 		.migrate_type = migrate_type,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
+	if (migrate_type >= MAX_MIGRATE_TYPES) {
+		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
@@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct perf_sample *sample)
 		.order = order,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
-- 
2.54.0.563.g4f69b47b94-goog

