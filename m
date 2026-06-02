Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C33A6F1A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381519; cv=none; b=m1VxbhgLdtR7LwhKnOjUXbAFTvN9osggRjDkoXiQH2nNs5moDIt6HjX/SnxqpSVgDziJDY8eamFgR3kiU3lFIb5BiV6uuVJwnFXnLvtQo8LD4inP1rrDMky0bYijyX9iwVGAblp/6lOoyCY+RVR6xOhiJJJVHuq4zQmxIo1W9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381519; c=relaxed/simple;
	bh=N60q5hQpJzgcj0gMAcG8lAo3SHZ3TJCXTm5Qt0ml33o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LbrKVbO3g3UVl3++F+XG/LWBv6xk5h5rWPYRJYC/gcc09wm4tyaAW68CxYuBh4woG3yKHwd8tfov+FszbGW0aM4Kcu3y0ZzsVMxGef0sAqPivUDG1ek99q+M9a3ENPae2n0Al7uyVe/eSDzsqqVLLkSlJQoWj7QKiYYdG5fR2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v8CvCraB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8CvCraB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32259e0eso41268475ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jun 2026 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381516; x=1780986316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fn3ycVGPkqm/HwQfVKkDuGLWZA0DVIOGZWD1+VZ2w=;
        b=v8CvCraB8D4PdTshoGoVd5mGBcvXtaWaJktnijPXVVEwLjRNmgZOYUquMo/4GEcjp+
         BTydK+TsnElNZzHWEtdYWlPzVji8Y6IRe4E1g6KR418FMjYGvVev/WjCJgD+oMq4plgc
         9ByQ5x7ue4e8m+gt5EieGtFhnXVPDdo5+6iNdleLVXZvB3gNfkkmqgFseX1/VGg3ekiy
         wFC9xpuWgmk6L7VY9IKukcBuS+dJi/4EOKvYt8u0AAVuk+DxDSUEXwGFfsufzcYU9TN9
         8Fj/gmBZD3WfywdLSkx7lKfjWdnFQ91vRLIYRUVlOMTciDtnRuG39U/zkHj5GK2gg+wb
         okag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381516; x=1780986316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fn3ycVGPkqm/HwQfVKkDuGLWZA0DVIOGZWD1+VZ2w=;
        b=cvQ4QrhxknB+o+K/d4WFsiIyVtN5yT+3cwfOgdVjZL3xvtfmAgrFE6RoUtLZJhL2WO
         40drVGPbvwTcHjrJ8qBaabApUtXgnRyF2qTvYfW0hDBBS4waCcki4YX9uE4Jwq8rSQnX
         cS49Jt9Z5smdPKp9KdNF/EvBZviIlJ2clbjGq152/aH1SHvt5B/8dQ4Fs+qLq7RLoAkp
         7ZGWQzEN46sUQ0MliDR4G6F459n5TI7GId/itFok2Fym2g1OORQnGDKz6XkCbvwoabdB
         BsUenoUEOg7FXWEC4X4OVX2VIa5yzEwKNioYUy+5j8doc6sJmUYxheE5Bqm22rntLxNl
         hQDg==
X-Forwarded-Encrypted: i=1; AFNElJ972k2+npAl3T1lS9UPlRxctIP6YUWmoTtcIMJo6c8BkWQBsrMaGnZVvYYqJVogERlEYGTyRjn1FBNi1imEvqXx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxvu0hEqBnYqEEmb01jKJLdEMCQjRbUaBVgZKuPha09/CTR3w7
	FeF30Hod+yvbsU9MxOz2Tz+Y8MVYleNgFJYv+0tsCNRJtfbO0srMiR7MOpmqRnlQ6hzCe1EV5JP
	F6fhY/rE8CQ==
X-Received: from plbkv3.prod.google.com ([2002:a17:903:28c3:b0:2c0:b770:dcd7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc87:b0:2bf:372f:12c
 with SMTP id d9443c01a7336-2bf372f02e7mr160363465ad.26.1780381515609; Mon, 01
 Jun 2026 23:25:15 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:34 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-3-irogers@google.com>
Subject: [PATCH v11 02/19] perf tests topology: Switch env->arch use to env->e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Some arch string comparisons weren't normalized. Avoid potential
issues with normalized names vs uname values by swtiching to using the
e_machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index f54502ebef4b..bd7b859dea66 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -11,6 +11,7 @@
 #include "pmus.h"
 #include "target.h"
 #include <linux/err.h>
+#include "dwarf-regs.h"
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 #define DATA_SIZE	10
@@ -74,6 +75,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	struct aggr_cpu_id id;
 	struct perf_cpu cpu;
 	struct perf_env *env;
+	uint16_t e_machine;
 
 	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
@@ -101,7 +103,9 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 *  condition is true (see do_core_id_test in header.c). So always
 	 *  run this test on those platforms.
 	 */
-	if (!env->cpu && strncmp(env->arch, "s390", 4) && strncmp(env->arch, "aarch64", 7))
+	e_machine = perf_env__e_machine(env, NULL);
+
+	if (!env->cpu && e_machine != EM_S390 && e_machine != EM_AARCH64)
 		return TEST_SKIP;
 
 	/*
@@ -110,7 +114,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 * physical_package_id will be set to -1. Hence skip this
 	 * test if physical_package_id returns -1 for cpu from perf_cpu_map.
 	 */
-	if (!strncmp(env->arch, "ppc64le", 7)) {
+	if (e_machine == EM_PPC64) {
 		if (cpu__get_socket_id(perf_cpu_map__cpu(map, 0)) == -1)
 			return TEST_SKIP;
 	}
-- 
2.54.0.929.g9b7fa37559-goog

