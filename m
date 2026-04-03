Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A73396D28;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209735; cv=none; b=XCrFkQxUybBqC7eMpEm7hUarR7giUraZCcoWrIkI9V+ufgLM+f6+MaKLDmSDNJlsoTPUENI5v2tmd3DANVVsZplX1EppVNwMuhK44WrTyzycW95KavJvUNb4ws3dY9YoQrsin7S3WzNMmKxmM0H4ttnMK23qxzW1sl3KKVwJaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209735; c=relaxed/simple;
	bh=h2s9+QBMsE/oXiIBTDbwT57w7AUq3GoAMzRsOcdToEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEoDDu2kvwosPWapKUGdG7klfz3V6z74s2dLnR1i0nWrwDZYhdVydhYJDDF5QlptgN+c9LTtlbST+aGXlFMAy/7SzYDRm/NdV7rQH5A9saxDK5d8IrYCpGb7sSPsyW0EGGcv4KL8JEGK/DRTZ1dCxhi7dYLGDu+qFfPABEwPa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fnDRd2YbbzKHMXS;
	Fri,  3 Apr 2026 17:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id ECB4B40570;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S12;
	Fri, 03 Apr 2026 17:48:49 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 10/16] perf annotate-arm64: Support store instruction tracking
Date: Fri,  3 Apr 2026 09:47:54 +0000
Message-Id: <20260403094800.1418825-11-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403094800.1418825-1-wutengda@huaweicloud.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S12
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy7Jr45Zw1ruF48KF1rZwb_yoW8XF4xpF
	4DC345tr4jgrsYqwnxZF4IgFyfC3WfJ3WYkr4aywnxZF42yrn3tFWkKF1YkFW5JrZxCw1U
	Zwn8Kr4DZ3yxCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRGMKuUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Extend update_insn_state() for arm64 to handle store (STR) instructions.

Unlike load instructions, store operations do not change the data type
of the registers involved. However, arm64 store instructions sometimes
use pre-index or post-index addressing modes (e.g., str x1, [x0, #8]!),
which modify the base register as a side effect of the memory access.

Call adjust_reg_index_state() for store instructions to ensure the
base register's offset is correctly updated in the type state. This
maintains synchronization between the hardware register state and the
instruction tracker's model during sequential memory operations.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-arm64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index cac2bf0021c9..28647a778802 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -335,6 +335,16 @@ static void update_insn_state_arm64(struct type_state *state,
 		}
 		return;
 	}
+
+	/* Register to memory transfers */
+	if (!strncmp(dl->ins.name, "st", 2)) {
+		/*
+		 * Store instructions do not change the register type,
+		 * but the base register must be updated for pre/post-index
+		 * modes.
+		 */
+		adjust_reg_index_state(state, dreg, dst, "str", insn_offset);
+	}
 }
 #endif
 
-- 
2.34.1

