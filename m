Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139953A1DB;
	Sat,  8 Aug 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191871; cv=none; b=qmcYpUmhUQHvQfQy/U+xNqVREcIsvHFw0dBywPHGro5M2WBFjRCrdjOwH/1xsBq1a56vFYQVn23kzeg8avs62WEkF2mzMP3Ws2JDoB9FAI0LRAkzmjTgWinkDIldQ1PJY/1EOFaWmQ+KCg+kr0m3cEP6Vf9miyUyE9gvGAt3Odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191871; c=relaxed/simple;
	bh=XxKzL2pfua4lVhQeWnY9BQIfIFeHYK7WG8z2gYlpDkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9kn33uLf1tenZreKlMroIuOvSpDUn1ALriniwJzgLzuaNXS+Nl/fd2N9oqml0xBiRYhfkqVfEHd9t2QR0wEC1bmqVkEKm3B2NfIDzR1C741F9WPAo5wBLnBra2c1hneYP5HMi6tE2/DMVZbPWzQu/jgOLfqFLce5ZCUEs43fMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hHKvC3y3SzKHNFd;
	Sat,  8 Aug 2026 20:24:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A5E6F4097C;
	Sat,  8 Aug 2026 20:24:18 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S15;
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
Subject: [PATCH v4 13/23] perf annotate-arm64: Track return type after call instructions
Date: Sat,  8 Aug 2026 12:23:50 +0000
Message-Id: <20260808122400.2961238-14-wutengda@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S15
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3ZFykGF13Xw4kuFWDCFg_yoW8Cw4xp3
	WDu34jkr1UGr47KrnxJrWfXryfC34fW34YkrnrtwnIvFW2yr4fJFZYgryaqa1rXr93Cw48
	ZanFkr45Gw4xC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Enable data type profiling to track function return values in arm64
annotations by looking up the DWARF return type of called functions.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/util/annotate-arch/annotate-arm64.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 44daa0176e51..acff14ca01e0 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -359,7 +359,7 @@ static int extract_op_location_arm64(const struct arch *arch,
 
 #ifdef HAVE_LIBDW_SUPPORT
 static void update_insn_state_arm64(struct type_state *state,
-				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
+				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				    struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
@@ -378,6 +378,8 @@ static void update_insn_state_arm64(struct type_state *state,
 		struct symbol *func = dl->ops.target.sym;
 		const char *call_name;
 		u64 call_addr;
+		struct type_state_reg *tsr;
+		Dwarf_Die type_die;
 
 		call_name = func ? func->name : dl->ops.target.name;
 		pr_debug_dtp("call [%x] %s\n", insn_offset, call_name ?: "<unknown>");
@@ -395,6 +397,20 @@ static void update_insn_state_arm64(struct type_state *state,
 				continue;
 			invalidate_reg_state(reg);
 		}
+
+		/* Update register with the return type (if any) */
+		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
+			tsr = &state->regs[state->ret_reg];
+			tsr->copied_from = -1;
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->offset = 0;
+			tsr->ok = true;
+
+			pr_debug_dtp("call [%x] return -> reg%d",
+				     insn_offset, state->ret_reg);
+			pr_debug_type_name(&type_die, tsr->kind);
+		}
 		return;
 	}
 
-- 
2.34.1

