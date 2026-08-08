Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99790412BE7;
	Sat,  8 Aug 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193077; cv=none; b=aYKVIc0VXP5SpLWoak6lBEW4Kntm+lnJYjEdEYhRZzwwi8MvvFBUtvNLWA36iuFirQC+Aisu7/gz+F0vGx4ed1Fnv7RKfDv7jL+C4PA+qjtYFidcRGGncFUEBCvFArAW3mdPK4GNND3tTIKr4SB/FE7EdkrBi6OnhJLSGZMIHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193077; c=relaxed/simple;
	bh=UPiUQgX3q0791H0AcDHImRuVLupx4M60p6QkrChycjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRUt3i/EYH/pdPX48nQBdqfavVmd33MPhCpSZsnYg2AxtsBXUrs3uIWP+9G5LSxzA1aGtt911gGZ3Po0CrDxpU6bgNEDJz0KT77u+8bCsciAsx613UosJFiSE5H2Zrq5+LIcdNX8V446OwUEEdLk7+LLv4rS5PmoTkoUVJIwhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvC1qkpzKHNFH;
	Sat,  8 Aug 2026 20:24:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 59BC44096E;
	Sat,  8 Aug 2026 20:24:18 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S12;
	Sat, 08 Aug 2026 20:24:18 +0800 (CST)
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
Subject: [PATCH v4 10/23] perf arm-spe: Set default synthesized event period to 1
Date: Sat,  8 Aug 2026 12:23:47 +0000
Message-Id: <20260808122400.2961238-11-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808122400.2961238-1-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7CFyxXFWkWw1kJryftFb_yoW5uw43pr
	nFgFyfJr4kJry8KwnrAr4UuFy3twsYvF1fGryxGrWUAw1UKry8tr17try5Cr4UWr1Fyr17
	XFyqgr1UGr1Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRQYFCDUUUU
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
index 1721882423f6..0f656398f2a8 100644
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

