Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C413C3F6;
	Wed, 23 Apr 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390072; cv=none; b=gBbeBhIjYfMRGTl/9ZGbSTb2QteWCQ9fB4y1EFZf3XnukSNsaNaS1zWTkCtmmgezwa71OCxP0lOkD+pprZ6wgvF4vto4F7vPb6fWYXpDf7tldG9UQAAhqH6VtxeYtr/fUaomoPplqnkkaASgL6PJsnp0I7aB1eyGeIAivyFY8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390072; c=relaxed/simple;
	bh=Qlt8fOU7S3qN3z2CYEB2iLHJtb0RRgm0RQ9Hv1XYFIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OOzGgsSpvuloulz2VwGDlld4LReFktBZWv6PPjmyPYqfUUkm9VHx2kec0YqY7RjRCtWVEurs6ns+MHAZDp0LS3KYVhASWKEeFbpuaMPyjxaaetLiNjGovJ+gIqoI/LOBEm/gOlEwkJR3hMutokkYPxjK4TuST5ikATXWCtpwbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zj8T45MPnz4f3lCm;
	Wed, 23 Apr 2025 14:34:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3BD031A06DC;
	Wed, 23 Apr 2025 14:34:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl_wiQhoEV49KQ--.26381S4;
	Wed, 23 Apr 2025 14:34:25 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86: Fix open counting event error
Date: Wed, 23 Apr 2025 06:47:24 +0000
Message-Id: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl_wiQhoEV49KQ--.26381S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1xGF1rZr45JryrCFyfWFg_yoW8Gr15p3
	47Crn3KFyIgrn8Wwn8JF4Iya1UZF4ktr9rJ3WfWr45A345WwnxXFWxKFs8Wa15Ar1fJ34f
	tanagF9rurWkA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Perf doesn't work at perf stat for hardware events:

 $perf stat -- sleep 1
 Performance counter stats for 'sleep 1':
             16.44 msec task-clock                       #    0.016 CPUs utilized
                 2      context-switches                 #  121.691 /sec
                 0      cpu-migrations                   #    0.000 /sec
                54      page-faults                      #    3.286 K/sec
   <not supported>	cycles
   <not supported>	instructions
   <not supported>	branches
   <not supported>	branch-misses

The reason is that the check in x86_pmu_hw_config for sampling event is
unexpectedly applied to the counting event.

Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6866cc5acb0b..3a4f031d2f44 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -629,7 +629,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (!event->attr.freq && x86_pmu.limit_period) {
+	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
-- 
2.34.1

