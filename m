Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BC3ACA7E;
	Wed, 16 Sep 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522222; cv=none; b=YR9GIQY6tq9Y3am20cofRKULWNIramdoa5t98cR8i+kMDr2xTVmxwDcV+p0giQPRGxJvzlDKjqjOsqw+1xqW3axTUeysw9sZNNozJYuDfiad54xwQMgYvLJWZNZrbfkGgBienA+KDfP9lxyEVdbUd1tnT9fmbi1FrvY7lIJCauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522222; c=relaxed/simple;
	bh=I8s3IRLIG6/0sh4VgQx4eFZKk5wCQhypjzz0IrTQSWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOIrse6SxnAVWNwgRnA6qYNjUGMvCqsKM4N7sYCKEfTbfiwdv9VA5pCDHdghZTQEnmB1FI+5KdaQ/Qf/vWIg+kf/1wI3U5osDXJu80FGt2rD0DGOp8XZh+UQyNE9FwmG4WY0BhMyOxVGbV1d4K/rgISNTGH47dOoYPAnuAb4ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hl1XJ2wZPzKHMRB;
	Wed, 16 Sep 2026 09:29:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 02D7E4058F;
	Wed, 16 Sep 2026 09:30:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAn+CoH8alqUcjbAQ--.36458S13;
	Wed, 16 Sep 2026 09:30:05 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
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
Subject: [PATCH v6 11/26] perf arm-spe: Set default synthesized event period to 1
Date: Wed, 16 Sep 2026 01:29:25 +0000
Message-Id: <40acb41b77fcb4aef1efe720c651563043800ff3.1789521520.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn+CoH8alqUcjbAQ--.36458S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7CFyxXFWkWw1kJryftFb_yoW5uw43pr
	nFga4ftr1kJry8Kw17Ar4UuFy3tw4FvF1fGF1xGrWUAw1UKry8tr17try5Cr4UWr1Fyr12
	qFyqgw1UGr1Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxc
	IEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRNg4S3UUUU
	U==
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

