Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A220B7F1;
	Fri,  8 Nov 2024 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098512; cv=none; b=KxupFhzDnTJCzsAKvjLt4iPoV8OVRc0scZ5ujJ5YJ3qgG0pj1Zq4XnMD4y0CGVkXF2zDmozKj4s3PKHEB4ukyFIYkFWkn2H0XWS9c4FaI9mmEpnW6UIXqDew+VxmUXzn9rSL1fju22pIHQYszuCsTnreIr5k/sPWFtEmG6fBUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098512; c=relaxed/simple;
	bh=kU2mz8BbKOcRd2Dn2h3z3TC1djUFPkPBe7wwzIDw8eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuO9QQJE0jHE5X1kxSFKVIYevhYqQgkw9SxHCojXN+AOo+eP2AH8wFWHFv8+a2tp6yRnNYFWsDkhS3NHfKdBbSOI4SIbzzrLCvPw+Y4vuepkNUVGjD+R/cnsv6oUWkPM3FYieDgnZm3My4Lyb62KZRejSS32c0Y2ajS1zjJZ5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWXdFCUL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWXdFCUL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso2263311b3a.2;
        Fri, 08 Nov 2024 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098510; x=1731703310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHhcbRkHBVYZ1gs3jQbFCFGApL4t6RWueBDb3aZux68=;
        b=DWXdFCULeyv/QBy/2uMKV4D0rGQMD4UKexDAFMDoDdcADlywgxXu9h07vhGU+lZ2sf
         oN0eRg6uhaPb7N7WULS10LBez7VpLxz/vFK3MSEqVT9AQerLPWXansd0qIizEwMB7Dl7
         YYvEhaZP936OvvdSGx1Jx1o2MJxim8sF0qNvrgqEg88brmM9KKKN/ohVkix/PbN56d48
         23owNMfv6+rSam1p1wAMp82NGiMKfUWlbjFWM6cPzC96RqDBS7AG6DCHbumCu7sI4Zl7
         OFJLeOOPKlHt5UutZRZrnjyuBPEmAQ/tlkxubOh+pNjLyIihp/GT6dOFdDmCkBAQ7aRV
         ZfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098510; x=1731703310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHhcbRkHBVYZ1gs3jQbFCFGApL4t6RWueBDb3aZux68=;
        b=HWxxz3NTnFspLWBUzM/ZuUkmWjTbUlSP62vvh8cPxsTeHeBzXVYxFtmg7AvSIa2hKX
         065i6IkrEb/e5kPnow4kak+cQs4yIgYpKsUHPKNUtfEL1qZnqrHZ4/RV3JGL6VcnnQIJ
         zkc2O4IqTb/oXfLpxZgAGyroP2MoZDBknQBIgxZxrP2ZL2EsZ+Mp4RWsH3w5ZD5OAGL9
         24XlL8lmnKloCcKELZ7XDjLjzY5MLD6wD8yWmgQRNQtyMXiQ8y1kpOPjzl/t6RfpDPs4
         U5PVBE7mmLp0uV6ZWNo/aYBKGT1U1uiTBcGDmIEKql65BWQyRQ5/oMnz0OBq6FMpNuZ0
         MqAw==
X-Forwarded-Encrypted: i=1; AJvYcCWWhfWeDAqfQoa0Mk4jmarfi7oXX1XoYAgSdnyuSkg6auWxO0tP69TPvDYcSDsu5TU2YJPIzlwHFr2c7Mw=@vger.kernel.org, AJvYcCXtgrqW8uFmMdgUTenQOEz3v1OlOmljrdeByR7wwrf/UqLwxv/vlM///91yVx/J+ACCxDopDo1EKtlaQGgtpzNeyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybpZNYINFAs7ZlyxRZt6DvIjvkxx4LGuBUAsruFPfzmeiKrAu2
	LY2dP2eU2RS6gwokRn/72iY6kqTmeJ2o6DiQ/yBwT6U7nhXWRcWb
X-Google-Smtp-Source: AGHT+IGXYvt9kIQbrdyodf6HiIih9pJ84IS2nevmoCyS/Yi4NVs04O4lPpnRfGNjPXpnpMqrldUZ/g==
X-Received: by 2002:a05:6a00:198a:b0:71e:692e:7afb with SMTP id d2e1a72fcca58-7241325f64amr5306390b3a.5.1731098510276;
        Fri, 08 Nov 2024 12:41:50 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:50 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 04/10] perf record --off-cpu: Preparation of off-cpu BPF program
Date: Fri,  8 Nov 2024 12:41:31 -0800
Message-ID: <20241108204137.2444151-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the perf_event map in BPF for dumping off-cpu samples.

Set the offcpu_thresh to specify the threshold.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/bpf_off_cpu.c          | 20 ++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 558c5e5c2dc3..cfe5b17393e9 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -13,6 +13,7 @@
 #include "util/cgroup.h"
 #include "util/strlist.h"
 #include <bpf/bpf.h>
+#include <internal/xyarray.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -73,6 +74,23 @@ static void off_cpu_start(void *arg)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	/* update BPF perf_event map */
+	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
+	if (evsel == NULL) {
+		pr_err("%s evsel not found\n", OFFCPU_EVENT);
+		return;
+	}
+
+	perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
+		err = bpf_map__update_elem(skel->maps.offcpu_output, &pcpu.cpu, sizeof(__u32),
+					   xyarray__entry(evsel->core.fd, i, 0),
+					   sizeof(__u32), BPF_ANY);
+		if (err) {
+			pr_err("Failed to update perf event map for direct off-cpu dumping\n");
+			return;
+		}
+	}
+
 	skel->bss->enabled = 1;
 }
 
@@ -261,6 +279,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c152116df72f..dc6acafb9353 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 offcpu_thresh;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
-- 
2.43.0

