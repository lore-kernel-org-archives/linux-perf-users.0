Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223189;
	b=5j9+QIZTDfAbJ7eHQtUoQGpbfBvf0bCA8Fr4QzgX8s16P+kpCClgrNK0KlyRugcys+tE
	 Wpqa9Z5ZAWxzVXsG9tKy5vITHXQUD5AGkA0kA7NFpecBsUFdiWxajtLODANgUmfIr/Yc3
	 4dtJZ3yuZGfRojgeDJiQH5oAtmBbb1Uj/B+M1eRj6V0bHrQX1eT39dgzmHisRWpMfzEwp
	 /cSxD3f7JSH/9HT4kCStW9wpc+h4v3TgxHHCUC+XdhLv8aEa24b5lHC1fwBIyHuTbhpUO
	 h/2h+7PxnDqOg2OM0MGRztrhhb/UGpNp5lnOJa6BRH8JcEyaShi1qkTrCZ1/qlKpGeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223189;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:Subject:Date:
	 X-Lms-Return-Path:From:X-Mailer:Content-Type:To:Cc:Message-Id:
	 Mime-Version:Content-Transfer-Encoding;
	bh=nrTj8/1DomOwvHqcUIcxM/6KsnFRHawVripj6enYjDE=;
	b=KFdMhMb6LFX/AGdP/pPuvoy74af35YtXYW5nktxUlRaQNGRkL4Ohh1ZbmYrBfqVp8BcK
	 joHY3P0OedqfL1T07nNbiY0ZN6CuhaL3RrBNw1HODUx/dHOw2VGdeS1BLM5WLPUFBRFet
	 PhVKY63MrrJAUwVUfv3zRtBbVaTqLCH1X17dLgcBg4Z1MGcW+RRr7h2lICaRhth6Faybt
	 0GbA7kSEOvZ1XilOoqPfqReRXO7isLnB41aRPZMqD0+SyGnU9RfTiZVmNSKMBEWUFV49Z
	 8P6PlgcZoAGwBI3ye7G2oQfLTi+10eLDKDxuxCzW5005rhvnF7hXVK4NT/a0RIcXubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=H3rX9E0R;
	arc=none smtp.remote-ip=209.127.230.113
Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA482606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA482606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=H3rX9E0R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794223183; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nrTj8/1DomOwvHqcUIcxM/6KsnFRHawVripj6enYjDE=;
 b=H3rX9E0RE21NXqy7N1salj1TMq04PbW2OFcO+j7c00H5N/78drhbBYVTzmGzj8+Tm0BHQj
 ZxxSoLKdaSGih5euq0dZ5oXk/n9YCd1q+noTxrT5wbMf0baizDizclTvJ/6yXlVhnS9QDY
 FoZhEkyycCZM5aJ0XLrnjnFmYOo+rUeWzcEiyHL7W1SXXvQl2ZBl2h2VkOBv/uEV79VmtR
 3/XCAQ1T7YOyCH1ktLfKgl3HGFTcR0rKpGZOIseOdC4d37+s7rUs/EGpogdy1n9aVTPpRp
 wZVydDWIXZqbnTw2FCD/Rkw3uGdypEsrChI4i2erDZu1ov4YYhEbYly5HAXz0A==
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Subject: [PATCH] perf/x86/amd: Avoid double-decrementing n_pair on failed transactions
Date: Mon,  9 Nov 2026 19:19:09 +0800
X-Lms-Return-Path: <lba+26af1ac4d+dbe2b5+vger.kernel.org+zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=UTF-8
To: <peterz@infradead.org>, <mingo@redhat.com>
Cc: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>, 
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, 
	<irogers@google.com>, <adrian.hunter@intel.com>, 
	<james.clark@linaro.org>, <tglx@kernel.org>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>, 
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20261109111909.31712-1-zhaogongyi@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On a failed PERF_PMU_TXN_ADD commit, x86_schedule_events() releases
constraints for newly added pair events. The AMD put callback decrements
n_pair, and x86_pmu_cancel_txn() then subtracts n_txn_pair for the same
events. This undercounts active pairs and overstates the GP counter budget
for later scheduling.

Leave transaction rollback to x86_pmu_cancel_txn(). Keep the AMD
decrement for constraint releases outside transactions.

Fixes: 871a93b0aad6 ("perf/x86: Fix n_pair for cancelled txn")
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 arch/x86/events/amd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce..3363cfd3b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1251,7 +1251,8 @@ static void amd_put_event_constraints_f17h(struct cpu_hw_events *cpuc,
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (is_counter_pair(hwc))
+	if (is_counter_pair(hwc) &&
+	    !(cpuc->txn_flags & PERF_PMU_TXN_ADD))
 		--cpuc->n_pair;
 }
 

base-commit: f5a78ecccd98a04c47cea1cd63c2a2fdce8a4b48
-- 
2.39.5 (Apple Git-154)
