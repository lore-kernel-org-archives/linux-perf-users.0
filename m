Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8683C063E
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935056; cv=none; b=Y3LtujsFpsiOAml43Fnqflml29Zn9xtiiC9s27ITkn8XuTaxEphIVh6uT1+JK3ESm658HpZ+61xiU1S/tmK/PJRX6M7b6lsdcGNd8AmMdNXDKecmtlTODRoY0dbTls2ZMCIaiGkU+AwjUDanMURC4Yo3LZcnRxobuH10wyUGSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935056; c=relaxed/simple;
	bh=7DLuXWzqSIL2retVeMJj3OZEmlA0F6lhyp+Bekl45bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YeKvyNQnDFfWBlUJ+Zfn5k/VM59ct0N44IcACyHLw0dQFzOBO9+qdQXscgPzNSGymY5ypusSNC2AjPrkZRe3AarfhjtuM+PsMTcY72dmgFhtAKKtyezuA2QNgg5u2UfPFcsh/N/B32J2fNYFOFhK9Wzi6G7GbxfS1A5OTX3ncKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiAaTnYJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiAaTnYJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso1720665eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935055; x=1776539855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpMQz9BtqhH5QFTNLQH9VXJ1GuG48kQiZEjqAB6l0AE=;
        b=jiAaTnYJBgbDSPjYpZOAIVxF2Hg6dPv1i8f78bXB9QTQiv7PaXsZA3D51EB6tXG4DZ
         pkHJ3jHLzfETnTviD96ZvB6+EXJo40ZFaO6LgToFE42VIBMh/iu/vN/VT2DtuQDzxvTd
         MLpOT+58a/YxK+WeEjLYHpifNX/MUlWgkwx5hYtstAQQMBGcX7bZPYKFfck6R4DGMcQT
         DmgfyealCPRPkRdQXZzr2ueBKO0pNGCKsy0RVdk8rJT3Quu4O4W9CyA/i+us063sKzwi
         nJYURZJSeiMRNUF4+pX4GecGMHxpyikkfaFDaDtvkabQqWsPrS3az7DFOVGWrtd2Xm+w
         EFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935055; x=1776539855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpMQz9BtqhH5QFTNLQH9VXJ1GuG48kQiZEjqAB6l0AE=;
        b=JvNl6+U1oY1NXU8ZdGFGOAAPo5m860DfWldaITrJxvEfWU1/c8mUvy8kwmrtO3Vtdm
         cpPF2jxoa746xg0bUuKo4jni+wp9tT6eEnlvRwX/tmIpQAJWfgbc6o0JeqSJ9D8In9jw
         B6jtDc3uX7W+HajQ9aBJRjXyLzPnVC3PcXUv4qS/7D08oZTiGOdFXQYOGmR0ISUV83NK
         gvdd/DnP3za7Jwcye7iZmF+UZKxNOsd3IZXO+P+XHFOZEGN5i7gWBbzBwgmLJEUmFyBW
         avFZyGZanmsiU6z+tYhu0aEG43hw3fJstFDdm1t3fqzcAwootwUWjK4AJKrfNACeETw+
         mQXw==
X-Forwarded-Encrypted: i=1; AJvYcCV9PdBil/NFQjckKB+YKixoq/k0vOyEB/sg0HVTcSAOkdPFIwIpGYQF8COxlt1Cou6riLKevuSEKhH9zFP9ttb9@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiXmYGdA1lrEwzgO4XMuHTarlad7vu8plh4u2oFUcSiffLVf2
	yAWFnHTlUNfz1PSSbCBWYEJVNG2uVIk+DTT+QF4Yd14jXsKAIrvulbTkkSikKSJvWCTRkPxF2AH
	e8Xfc0NyuFQ==
X-Received: from dlbsi6.prod.google.com ([2002:a05:7022:b886:b0:12a:c4ed:5eeb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6885:b0:12b:ebf6:a3bc
 with SMTP id a92af1059eb24-12c351a0d3amr3585349c88.3.1775935054144; Sat, 11
 Apr 2026 12:17:34 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:49 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-9-irogers@google.com>
Subject: [PATCH v9 08/29] perf lock: Constify trace_lock_handler variables
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
index 2a6fc4c97dcd..09fce546b31f 100644
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
2.53.0.1213.gd9a14994de-goog

