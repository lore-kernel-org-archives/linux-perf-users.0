Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470033FAE08
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034907; cv=none; b=TnKgUAT1D4yLwUPsFDXscdnVPqhbyuLFDlXrhzXooaHJzxHTrz9d5JbqJixl93VlrCZtMUSr6RmD+5MMBecHgOL3kJliQydSL8m94kYgh0mBGKlTN2P/mvEVTGJ+3il3GME+R4oYs0z5uMjlBI1ySWTjSe8uakLJMJEpQDOeEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034907; c=relaxed/simple;
	bh=RCv6opy0rOqvlNj5z92+NzI29eWRQq7w3cUzbQCiF+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZpH/+Rw5UnLYJS13iEMyIdgUpUYOoSdFuDa+p95WTB+KpRfh+dpZo/k0qQFxp93uNI8oED8UB8vADa7ukuUS6adU44S4CKq1+3ReriPnJkki9RlhWXyDghE3vKyZq4fC72xmchE6iP1kUFGc7YpcBPyevkzmKxMPJRBVIknLYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhYHsT1h; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhYHsT1h"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0c85c38acso1252640eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034902; x=1774639702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d33AbYDTlaS5mB4Y5js7O+MGtwScYB2I0WrPSaITagA=;
        b=jhYHsT1hG/BlMtiP6MLncEGobCsBVcQdUe9geguptaE27QO3XL7gAWINHd/MYZucr9
         nnP7MDyBTUCOvNYApfO3sHEFZvIfnaKaGjByHMldcnYUaiYel3fouL+ZaSDpMjGqNtdu
         rT3jpLg4Nc9ng+sdzVtL1GEnbK272/XrRjjN7XAY8TUWQ+GIrZghDN85J21+RpQSlYGr
         0I89jgMsMbTeeuWzMrLGlEABuIIUKFCSgVVhlzPx8bD92sTC8WV+y99992dXVBkq7KNT
         RwOxzErFeWm746ExspoggayO/5bUZ4ZOGck5UHYe8cJZLe1npwzfjTV3R1Slv9oziHmh
         FUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034902; x=1774639702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d33AbYDTlaS5mB4Y5js7O+MGtwScYB2I0WrPSaITagA=;
        b=sUZ1jooH60BCjG5zTXexlvGh7oMCxfxgFYTSxVGhrHkWHVeo3PCAeSL9If5BVFc31S
         ldmTNeaMa1j7sTXZT4WDRi2Vz3dYprsWNQhW+/hVHkfez/8sHMD1a50ul21UDPZLwt8t
         eBngfq0AL1rgu/jJZe7X8jmr/F9xsX0jveBcJbEtvwcM4kjeZ15hHMDSOJN/SQKIvKg/
         YmFPs9Yvr67xvyWKg6cy67CadCRprS4iNzJnA/DwnLgPeKhLQxTfWC/vCbrdmYmqJMoM
         U/+sKlQzJjeIkrdtEyoEZRxlizk0/yIL02kh63pkpD6rE3FLps8wpSUtrj1Z9fen+QY1
         tblQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2jdxOgNP+l9iLlF3GvbCz3dG48V0dVkFtC8FSI3jjxpmgLxEyZwdauertM+iXhwA5L5vRlYlYFeJiw/oAED66@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ts/5loz6rS3/Vf6EHyX4sD/V4XWiiIg5Xy3v06/LjDNgzSB2
	NL4StJB3EwHKeUqZo9ohU/wqCsnnIG1Kr/qhuod1B4ZXxmFN31/r3oNTadrr5NvR9BOC0/nrReh
	KeyEk3WUgbQ==
X-Received: from dybrc11.prod.google.com ([2002:a05:7300:d80b:b0:2c0:f437:1898])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4198:b0:2c1:27c:75d0
 with SMTP id 5a478bee46e88-2c109622b74mr2063461eec.9.1774034902036; Fri, 20
 Mar 2026 12:28:22 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:12 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-11-irogers@google.com>
Subject: [PATCH v4 10/25] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 78fb39d06e7c..735e6bb234ae 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1179,7 +1179,7 @@ static int report_lock_contention_end_event(struct perf_sample *sample)
 
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
-static struct trace_lock_handler report_lock_ops  = {
+static const struct trace_lock_handler report_lock_ops  = {
 	.acquire_event		= report_lock_acquire_event,
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
@@ -1188,13 +1188,13 @@ static struct trace_lock_handler report_lock_ops  = {
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
-static struct trace_lock_handler contention_lock_ops  = {
+static const struct trace_lock_handler contention_lock_ops  = {
 	.contention_begin_event	= report_lock_contention_begin_event,
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
 
-static struct trace_lock_handler *trace_handler;
+static const struct trace_lock_handler *trace_handler;
 
 static int evsel__process_lock_acquire(struct perf_sample *sample)
 {
-- 
2.53.0.959.g497ff81fa9-goog

