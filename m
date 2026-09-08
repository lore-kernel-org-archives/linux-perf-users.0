Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA854856C;
	Tue,  8 Sep 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872543; cv=none; b=fcD0RwHClScLLwogECYl0ISjX8UDE3cziJrV2piKJAO7Nvlppr+EE3ih5JFJ9cNPD5L2k+inTK5qGHqbSZDC4/TWwUVAJ6Op7OWoD5h3z9qNVeHg8BWB71A1LmKAymlpPYe7ngF853CIEr2/YQnHrfbu4x+EJoBbErCXs+kfV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872543; c=relaxed/simple;
	bh=I8s3IRLIG6/0sh4VgQx4eFZKk5wCQhypjzz0IrTQSWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrRiZiTPc9GT2n8urKJ9y/iEpqwxBOAmKlIaQilPxiuEUgmqKZxl2EEej4zaguKO09AqZJt/U1E8Mn48mHPESXwZMHQHGjKFPI2XzkFYHexP/d82X/cbtpqBE8TTCci++el5h5e7ze9XaEKA2VXnctNTv7QMh1cC+tXWssa6FuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPGS6X68zKHN6M;
	Tue,  8 Sep 2026 21:01:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 399544058D;
	Tue,  8 Sep 2026 21:01:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAni5gpB6BqC9rlBA--.34632S13;
	Tue, 08 Sep 2026 21:01:53 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v5 11/26] perf arm-spe: Set default synthesized event period to 1
Date: Tue,  8 Sep 2026 13:01:07 +0000
Message-Id: <20260908130122.633500-12-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908130122.633500-1-wutengda@huaweicloud.com>
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni5gpB6BqC9rlBA--.34632S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7CFyxXFWkWw1kJryftFb_yoW5uw43pr
	nFga4ftr1kJry8Kw17Ar4UuFy3tw4FvF1fGF1xGrWUAw1UKry8tr17try5Cr4UWr1Fyr12
	qFyqgw1UGr1Utr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
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

However, adding the -n option (show-nr-samples) reveals non-zero sample counts:

Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
============================================================================
 Samples     offset       size  field
      15          0       0x10  struct mmu_gather_batch  {
      13          0        0x8      struct mmu_gather_batch*    next;
       2        0x8        0x4      unsigned int        nr;
       0        0xc        0x4      unsigned int        max;
       0       0x10          0      struct encoded_page*[]      encoded_pages;
                                };

The root cause is that when --itrace is used with non-i/y options
(e.g., --itrace=M), the period remains zero after parsing. During
subsequent propagation, the final percentage calculation results
in zero:

   arm_spe_prep_sample()
      sample->period = spe->synth_opts.period;

   __hists__add_entry()
      he.stat.period = sample->period;

   annotated_data_type__update_samples()
      h->period += period;
      h->addr[offset].period += period;

   print_annotated_data_value()
      double percent = h->period ? (100.0 * period / h->period) : 0;

Fix this by defaulting the period to 1 in the ARM SPE auxtrace info
processing path if it is not explicitly specified. This ensures that
downstream tool components can correctly accumulate periods and compute
event percentages for all synthesized SPE events.

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
 tools/perf/util/arm-spe.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index ae7a5e9c3892..7805a1a98a89 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -2043,6 +2043,17 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		err = -EINVAL;
 		goto err_free_queues;
 	}
+
+	/*
+	 * When --itrace is used with non-i/y options (e.g., --itrace=M),
+	 * the period remains 0 because the parser does not apply a default
+	 * for those paths. However, synthesized SPE events such as memory
+	 * accesses, TLB walks, and cache misses still require a valid
+	 * sample->period to correctly accumulate periods and compute event
+	 * percentages. Set it to 1 to ensure proper accounting.
+	 */
+	spe->synth_opts.period = spe->synth_opts.period ?: 1;
+
 	if (spe->synth_opts.period > 1)
 		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
 			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
-- 
2.34.1

