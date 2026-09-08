Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889055C1A2;
	Tue,  8 Sep 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872761; cv=none; b=DOoHzoYpUXcEzuVwQLsErezp9A6TcgsOSNIfGwXM9v0OpytnMZdDHzeO1TwCgwcLPjSevBrHNWxTGlDu7c+GMvzP0hpcPjdZNXkP8bndPt+uaedl+1pphr/2aiyDiUiwC/eFeJfjF5A4bXHd2h/uv5aX9LwE3RhoNLTjHSrvrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872761; c=relaxed/simple;
	bh=I8s3IRLIG6/0sh4VgQx4eFZKk5wCQhypjzz0IrTQSWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWcZADnn/paN6xyyMxbsJ9pmNOHzy7XR1v89nGMwj1d+cStZ25SETMi9rjPs1WJbBw8y5s1khyygMgmLbuQcGnJurVQ+u08nkP9OWzO5TW8eKHUIz5ttxQtLO2LdOeqJppPBEdbw5P/a11nrHbWLICuziGJO1bvupiPgj4W8l00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hfPLs6LCTzKHN82;
	Tue,  8 Sep 2026 21:05:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 37E534057D;
	Tue,  8 Sep 2026 21:05:43 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHLUoeCKBqX3XjBA--.22748S13;
	Tue, 08 Sep 2026 21:05:42 +0800 (CST)
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
Date: Tue,  8 Sep 2026 13:05:14 +0000
Message-Id: <59d7bfeddd5ee06561e91876662d40fbf202ac6b.1788872630.git.wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHLUoeCKBqX3XjBA--.22748S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7CFyxXFWkWw1kJryftFb_yoW5uw43pr
	nFga4ftr1kJry8Kw17Ar4UuFy3tw4FvF1fGF1xGrWUAw1UKry8tr17try5Cr4UWr1Fyr12
	qFyqgw1UGr1Utr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkF7I0Ew4C2
	6cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa
	7xRxnoUUUUUUU==
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

