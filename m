Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF73812E4
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296861; cv=none; b=OlYv1BZs0omQ0m2Dhzgz4JziJfhhNVyudjHbgq1lBGEoTn7RhkswN7FOx1U0qyulLuL+8SQV1YChsQEg+NHaANPBfdViMksPXvJfiMHsY+RAg721c7zrjYzPRSxRKaUCzfikWQHWeCsB1AyRQIcaJm7OZxhF1vTjlqiqXq7c2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296861; c=relaxed/simple;
	bh=48MTwwxutkWuwNYEB0j4Z6toHbvDR1lbDWS17/rbrec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IdFIDLB2QbRN9eky61mlFmcX8QXhem10+cMjI7iBf7siZARxGAM/g/9WXXODeEKoycTKF7xp9S8/9fiQzS7Iur4nXkg1WqxtwN47e4XrCTIy5IP0OhA70x5aSZ/UHSeWosuWmuoFB1poJXp2CcrD3HYq70aOGuLekcXHNTYs6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HciQggJV; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HciQggJV"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137e32a2facso2221397c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296857; x=1780901657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWCzjKtw1MKO6Le8nWoWhxrpaG2iRVskYU2y07AMluU=;
        b=HciQggJVGiXWSl9v+0WyfxUV7LCm9U7GimZCwrPDDRb6cBi0bh5buRZHFTtqrZinil
         NWuca02MbkMxxJtYq6r1VTW9BEGUz12KM2DvP1/Uv9agW47B9/W2e/DKvTVSbCWbhuKB
         0amqOUeSNR7NIDYUAFM6MCKj4yBw1XUFKXqV4r5YoUN6k0/s7mo+U7rYmUNLTXfFM70Z
         3BezFzaUcugIQWUI75XiFHObl9ZNs/qreC7FhJwc8sf/9/l+qMT+81yJ4kO99TJvDlX0
         dic0D7NIVaoCh292Oe7Kj/bzriX1ZRLr1HW1IgnAWOplHFeXggYU9NhZuOWki0t2ABzt
         e7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296857; x=1780901657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWCzjKtw1MKO6Le8nWoWhxrpaG2iRVskYU2y07AMluU=;
        b=QCFm8X1MsJWkoo81Jd/EVl6uSnfEVotZeQhC5sTvNg4zutuz5ATxOMOQaHqLyrH3r7
         A2J4YpH3ghytMQ7PKIaUun7hxev6C4dx1Bmmn5sEdyp+LbRgYiXEjqm/U37ABNEiIdez
         tr1FqRnRXT21gNBuzkxtcJ60chF7PRirNJCHDy0RZwc2TXG3OwiawegYa2EAHCZl1Ejr
         SpgAk+TRxDiR0hMlN0wSndywOoP0psrofCyDwEK156f9jL1LB74IaObneihxgFNUPQW/
         Nx9NGAbm9I5IyZjfAr4ftJ9zQNasEWZ2v1KLM54ecAkYBi6oTq7BLRWKAcUBk2olGGR1
         Jezg==
X-Forwarded-Encrypted: i=1; AFNElJ/ipRBXRO/+MkjXDRqayFqGIHz+2G3duFudi1K4ky+sMo3yaPbzGjGwW9K9QEK7pDq/bURD4qmBUZttARXip7pS@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWvY2hstYnH+SAlY0LVbk5OI08u3zyslyPId2JMh9RfktrKOo
	ukxfSJULoF1rzdksp8QjZeXP/ug/sBF71ZnrOEzr7UM4QLbJvv0e4zdjNv/f4LROp+gDfD73DRW
	FQZNt4OWMRA==
X-Received: from dlbpt1.prod.google.com ([2002:a05:7022:e801:b0:136:ac69:b0eb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f414:b0:11b:f056:a19b
 with SMTP id a92af1059eb24-137d4012ceemr3520584c88.18.1780296856820; Sun, 31
 May 2026 23:54:16 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:51 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-3-irogers@google.com>
Subject: [PATCH v10 02/18] perf tests topology: Switch env->arch use to env->e_machine
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
2.54.0.823.g6e5bcc1fc9-goog

