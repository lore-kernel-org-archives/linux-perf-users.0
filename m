Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886893;
	b=dw09sZaJaPihbZbkyKSQLW3JvLt+kl1Tr2SaBtJ9hjppWCH2tau9cIWl0TKQI5bSMm2v
	 1y9bXg4Lg4cum3wN6XlClAtf6vZyqDiH9ReIPXMJUzDVsRDxLo1cbOr0PkhYMCQIa/1QM
	 udBVXsLNJ4KQ9o+glQbKgBMEjHDMLlREN9pnp/wlH1jXB4pc+u0rrwAGv5vpYBnDU2JZi
	 U2jN0Y8GQvG1ul2Bl+087pQg1M/KaskrrG7PJMBVZU9UD2f9G9EJ4d/k1++y1XLDbvIbu
	 gUdBVG0hlgm22S8zak6aWWe/FAH1uMXTtXlecEDqqr7kzpq2wfOEnxyEvjPH4P6zEmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886893;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b6QPA+yKpjH2CrVxlAy0E3CtCT2/3EUZFS8yt7Hepkk=;
	b=noUlhoiBOAhgAbuYsZ9jZYDfp/El9ITcEwZvWLnJy02xmmKxy89b9DjDjZLNxoE7p53r
	 99JFLAH6qVQPzsxs4ikiXdRlkV0LVmzGRzInP+12GtFpepMW+FyXMilYY6TyPsj72LfPK
	 Puc0vo9KTnxosnngenNao/oQu/U5gp4aBiIXZ2r10v1KsC1GnzvmUus1SXw5bVwLJ0qhH
	 YQJ6EerjJ/1QmprcJJOlyhkLffljFCz4dE9jIZFKTK5UGJ+dP+pfoBlEZnrfIBPUr6cqC
	 0Je04KXin9KdaVzjTCLIm/WOa7cPAEOcf8L8c2FGMi10qllTATtgbu4r0glzoHZ2hdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D5606A330;
	Thu,  5 Nov 2026 13:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 205D5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793886885; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=b6QPA+yKpjH2CrVxlAy0E3CtCT2/3EUZFS8yt7Hepkk=;
	b=XI96ZbJcHL0C0g14KlbL0xND5LQF983hvTvbGHVXr6jF7IfUSEHD6tCIqvYmKFt0TIORoio3mFsl9WEuruY6+3D1zcc7Sa2qxCSOnYWO2al6bYDH7KuspXc/OJjEz+XKO8b99N3QadjR29jB2MbyCveW6EKSBpUVF85FbCw+mDQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XE8slaV_1793886882;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE8slaV_1793886882 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 21:54:44 +0800
From: fangyu.yu@linux.alibaba.com
To: guoren@kernel.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	aou@eecs.berkeley.edu,
	conor@kernel.org,
	cp0613@linux.alibaba.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	krzk@kernel.org,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	palmer@dabbelt.com,
	peterz@infradead.org,
	pjw@kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: Re: [PATCH v3] perf vendor events riscv: Add C-SKY C930 JSON file
Date: Thu,  5 Nov 2026 21:54:35 +0800
Message-Id: <20261105135435.16251-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
References: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>From: Chen Pei <cp0613@linux.alibaba.com>
>
>Add PMU event descriptions for the C-SKY C930 core so perf can list and
>select its hardware events by name instead of requiring raw event codes.
>The events cover core counters, branch prediction, instruction fetch,
>integer execution, load/store operations, vector and floating-point
>execution, caches and TLBs.
>
>Add a mapfile.csv entry matching mvendorid 0x5b7 and marchid
>0x8000000009201600, allowing any mimpid, to select the C930 event table.
>
>For example:
>
>perf stat -e cache.l1d.rd.miss,tlb.l1d.miss ./workload
>

Tested on C930 core. `perf list` shows the C930 events, and
`perf stat -e <event list>` works as expected on C930.

Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

>Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
>Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
>---
>XuanTie is the RISC-V processor brand of C-SKY Microsystems Co., Ltd.
>[2]. JEDEC JEP106AB lists C-SKY Microsystems Co., Ltd. as the manufacturer
>associated with ID 0x5b7 [3]. Accordingly, use C-SKY in the patch title
>and csky/ as the vendor directory.
>
>This revision is limited to the PMU event descriptions from v2 3/4.
>perf selects the event table by matching mvendorid, marchid and mimpid,
>so the DT binding additions are not required for this patch. The
>derived metrics patch is also omitted from this revision.
>
>Changes in v3:
> - Repost only the PMU event patch. Omit the DT binding patches
>   (v2 1/4 and 2/4) and the derived metrics patch (v2 4/4).
> - Rename the vendor directory from xuantie/ to csky/ and update the
>   mapfile.csv entry accordingly.
> - Change the patch title to "Add C-SKY C930 PMU events".
> - Drop the topdown.* events, uop.spec, uop.ret, ieu.de.inst_cnt,
>   ieu.rn.inst_cnt and vfpu_ex1_rep.
>
>Changes in v2:
>v2: https://lore.kernel.org/linux-riscv/20251121063439.2545-1-cp0613@linux.alibaba.com/
> - Vendor name update.
>
>Previous versions:
>v1: https://lore.kernel.org/linux-riscv/20250910121121.7203-1-cp0613@linux.alibaba.com/
>
>References:
>[1] https://www.xrvm.com/product/xuantie/C930
>[2] https://www.xrvm.com/declaration
>[3] https://www.jedec.org/standards-documents/docs/jep-106ab
