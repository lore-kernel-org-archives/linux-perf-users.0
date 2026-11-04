Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758807;
	b=BsNAMQ1BvdsuOdw4rW2VVHp+uXtdmaoUWnzSKBuq9XjPFKT1l2B95TMHmuEuSmG5AltE
	 EByWHfIwS1OfGKuhwqyDJuaWVruDxhtwLBe1JBziPpWvX7RoKC9R8g6rYq2rtVOvoeFfp
	 vcz/dABSG9PhA2WqsaUtVfHuuLbIvKtdGOR23dnG9TbClZbbRk/tJI3WvmCF8CXUWXzY9
	 MmrmpsXQdLLsgco87jzJBzWTUW4vPSR6GPhc2xmbOi9+oebpiPBNdGbpBCkDoTiYFbFse
	 AKssjrA5qawHjlmMSKsVNiL80eMHdM2QQc6j5JM9eot7ogw246Aquk6Fr+MQXxhEWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758807;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=rHf127pk9WGdSZi9BQIix2hNk6XvY8AkvT6osPYX0a4=;
	b=bD8hl87D5xouf7Diaf5m8AJqL/A/b1xZueQSW6HclPLizYQ3QGuRI+AdheVtbR5Io9vo
	 ObUebY3BcIsu/nnhiEWkkemAX21eWB7E6eEuFY4575Wia916BGh+7Ba3uw+5Qt950FdrR
	 leBJKB/Qn8kXxUsCxnYM12c3dRLVy/YveIUBgQVVMvpxurTouo0IBcPolK+U/8E9bLDCM
	 zMGcwIW1TBGiTj35i47tnnYrzLKeGEI1EvBZkIeaIDbztq1ykGrK8FbmuhI+2uHzINUDd
	 5L6x3mRyhfDPKRONxr9OtzfoxqZSJX76LNWnaLJBzNYVTb62ORKFtxk6zvsMILlsW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BF860606A32E;
	Wed,  4 Nov 2026 02:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF860606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf intel-pt: Free the old snapshot reference array after growing it
Date: Wed, 4 Nov 2026 10:19:51 +0800
Message-ID: <20261104021951.1779-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793758802;
	bh=rHf127pk9WGdSZi9BQIix2hNk6XvY8AkvT6osPYX0a4=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=WpVLBf8QNKnCziaRfjIk8RJRi7bm1jLz58Jwt+O3g49QeYh96BVX29P6N7TPdKddM
	 9b+jo1Z3S0GxOPvfSxYlI2V/n8qMR7lykeiFEI2U6j/fsveyPGCGNo/9sqcROveOf/
	 NfFSrrcw6aHwn1CZtXPvBBqQBjxImvkUVpvRKtY1qYYgjp2pXpnHjCVKNtHZ6yqeLF
	 5cLTRUnRv3j2yCzcW5RcEtK8c0fIs7vj70jX/LQliWF7t/CkbimJJmZTDUjo5fhFoI
	 H62NJO7S57/b1CbuKvXMdiKerZOjSZdGH5/9cqoY8C/WVVa6HTzqRwBGl4yKPaMQaY
	 3XQRAw0Z+bWJg==

From: Li RongQing <lirongqing@baidu.com>

Growing snapshot_refs allocates a new array and copies the old entries,
then overwrites the only pointer to the old array. Snapshot recording
with more than sixteen AUX mappings leaks that allocation on expansion.

Free the old array after copying its entries. The reference buffers are
still owned by the entries copied into the replacement array.

Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 5e38b9c..f034e3d 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -941,6 +941,7 @@ static int intel_pt_alloc_snapshot_refs(struct intel_pt_recording *ptr, int idx)
 
 	memcpy(refs, ptr->snapshot_refs, cnt * sz);
 
+	free(ptr->snapshot_refs);
 	ptr->snapshot_refs = refs;
 	ptr->snapshot_ref_cnt = new_cnt;
 
-- 
2.9.4

