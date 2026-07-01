Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38E36BCC9;
	Wed,  1 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878098; cv=none; b=ovrrs7AZL9TwYQ+xFA0FOhRFUdpz0ze4ghwRdJR+/l8DlJUIlrm0Eq48Z/CixHdNh42xGXt1U7nLwi2F52B0Wr1CzhqYOLmY1/j1jtYmctKGCM5eBALims4eOGNd4qNQ8dCfEfG5h7QJ5my+XbdDPR4tP0Qc4EL6M2g3pu1YdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878098; c=relaxed/simple;
	bh=JjH5p8pGbrHjHBxzf/IowxQWNFOae1tY1vCyJtis+9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWOhstRd/rT6V2N4b/0vELhjiPMtJrnOWfX49oaCncNS5iXqwFQVt0oHhxGwuMK+i8ZtgbQz+xvcoFP1SSWSXxStwCaFcifscCjW7JpNg7G86hK8cg64EWw6TlKaPMqSUTaYO1ZB6zyXgSgSokq6JPAe5KbaPUjGckoCX5/z3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqmN00xS2zYQtsD;
	Wed,  1 Jul 2026 11:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0294F40593;
	Wed,  1 Jul 2026 11:54:46 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXiyWAj0RqCne9AQ--.26189S13;
	Wed, 01 Jul 2026 11:54:45 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v3 11/21] perf auxtrace: Set default period to 1 for PERF_ITRACE_PERIOD_INSTRUCTIONS type
Date: Wed,  1 Jul 2026 03:53:45 +0000
Message-Id: <20260701035355.752944-12-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035355.752944-1-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXiyWAj0RqCne9AQ--.26189S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7tF1UGF4fWFyftF47Jwb_yoW5Xrykpr
	n8t34fJr4kJry8Kw1xAr4UuFyfJw4YyF13GryxAryYy342gr18Jry7tr1Y9r4xWr1Ykr9r
	Zr90g34UGr17JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkF7I0Ew4C26cxK6c8Ij28IcwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0piPkusUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When using --itrace=M for data type profiling on arm64, the 'Percent'
values in perf annotate output are all zero:

Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
============================================================================
 Percent     offset       size  field
    0.00          0       0x10  struct mmu_gather_batch  {
    0.00          0        0x8      struct mmu_gather_batch*    next;
    0.00        0x8        0x4      unsigned int        nr;
    0.00        0xc        0x4      unsigned int        max;
    0.00       0x10          0      struct encoded_page*[]      encoded_pages;
                                };

However, adding the -n option reveals non-zero sample counts:

Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
============================================================================
 Samples     offset       size  field
      15          0       0x10  struct mmu_gather_batch  {
      13          0        0x8      struct mmu_gather_batch*    next;
       2        0x8        0x4      unsigned int        nr;
       0        0xc        0x4      unsigned int        max;
       0       0x10          0      struct encoded_page*[]      encoded_pages;
                                };

The root cause is that when period is not explicitly specified in the
--itrace option, it remains zero after itrace_do_parse_synth_opts().
The zero period then flows through annotated_data_type__update_samples()
where h->period accumulates to zero, and print_annotated_data_type_value()
calculates the 'Percent' as zero.

In itrace_do_parse_synth_opts(), non-'iy' options have their period
type set to PERF_ITRACE_PERIOD_INSTRUCTIONS, but period remains zero.
Since a zero period is meaningless for this type, default to 1 (one
sample per instruction).

With this fix applied, the result is as follows:

Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
============================================================================
 Percent     offset       size  field
  100.00          0       0x10  struct mmu_gather_batch  {
   86.67          0        0x8      struct mmu_gather_batch*    next;
   13.33        0x8        0x4      unsigned int        nr;
    0.00        0xc        0x4      unsigned int        max;
    0.00       0x10          0      struct encoded_page*[]      encoded_pages;
                                };

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/auxtrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0b851f32e98c..415b68a2bba9 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1759,6 +1759,12 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 			synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
 	}
 
+	if (!period_set &&
+	    synth_opts->period_type == PERF_ITRACE_PERIOD_INSTRUCTIONS) {
+		/* Indicates a sample is taken for every instruction. */
+		synth_opts->period = 1;
+	}
+
 	return 0;
 
 out_err:
-- 
2.34.1

