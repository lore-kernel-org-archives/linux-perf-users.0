Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5E379EF2;
	Fri,  3 Apr 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209735; cv=none; b=ANNqMfANZgXWzDhDzLPBaNBLoMC63NBlIEmVnEaHut0enTJUwZG9hp9Z/8QVg+OUwCeW9nTAJ3pwAwmHeCsj9BYvhfJMpLTzGOi3NMOp4Twz3aJveVKwF55Z+dVaPhTS9mluBI2BhN91ior1he03A/cGdYl5wPey4uDOGAieYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209735; c=relaxed/simple;
	bh=CP/NbafyqnF4Hdetr8HN6E963hPsmSsryQwjgKakKaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWotI7SAiZDA15wrJzXCJznl3QoKYJcmJGL4eJCwnMgw6y9Iy8SIW4TXG7WOnWrbfRHUWPKVimcH3NdUPw64FLLx+FlxbsFOYCbWQcYNVoYy9pr1Ax0xP4K7Ih+xMt8XbzprQo+5FkKrxSeqJLPX/ia7IHWI3c7dU7ToPMutUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS76nTDzYQttc;
	Fri,  3 Apr 2026 17:48:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5CCD040575;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S5;
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
Subject: [PATCH v2 03/16] perf annotate-arm64: Generalize arm64_mov__parse to support standard operands
Date: Fri,  3 Apr 2026 09:47:47 +0000
Message-Id: <20260403094800.1418825-4-wutengda@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCr48ArWDJr4UKFyDAF1xAFb_yoWrJryrpw
	4qk34DKr48KrZ5Kw43JanYqryfWwsag3yfWFyxtwn5Aw4fKryrJ3Z3KF12kFs5GFy8CrWU
	JFnYyr15CF4UGaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRXpnmUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The current arm64_mov__parse() implementation strictly requires the
operand to contain a symbol suffix in the "<symbol>" format. This
causes the parser to fail for standard instructions that only contain
raw immediates or registers without symbolic annotations.

Refactor the function to make symbol matching optional. The parser now
correctly extracts the target operand and only attempts to parse the
"<symbol>" suffix if it exists. This change also introduces better
handling for whitespace and comments, and adds support for multi-register
check via arm64__check_multi_regs(), ensuring compatibility with a
wider range of arm64 instruction formats.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 .../perf/util/annotate-arch/annotate-arm64.c  | 85 ++++++++++++++-----
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index 33080fdca125..4c42323b0c18 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -14,12 +14,38 @@ struct arch_arm64 {
 	regex_t jump_insn;
 };
 
+static bool arm64__check_multi_regs(const char *op)
+{
+	char *comma = strchr(op, ',');
+
+	while (comma) {
+		char *next = comma + 1;
+
+		next = skip_spaces(next);
+
+		/*
+		 * Check the first valid character after the comma:
+		 * - If it is '#', it indicates an immediate offset (e.g., [x1, #16]).
+		 * - If it is an alphabetic character, it is highly likely a
+		 *   register name (e.g., x, w, s, d, q, v, p, z).
+		 * - Special cases: Alias and control registers like sp, xzr,
+		 *   and wzr all start with an alphabetic character.
+		 */
+		if (*next && *next != '#' && isalpha(*next))
+			return true;
+
+		comma = strchr(next, ',');
+	}
+
+	return false;
+}
+
 static int arm64_mov__parse(const struct arch *arch __maybe_unused,
 			    struct ins_operands *ops,
 			    struct map_symbol *ms __maybe_unused,
 			    struct disasm_line *dl __maybe_unused)
 {
-	char *s = strchr(ops->raw, ','), *target, *endptr;
+	char *s = strchr(ops->raw, ','), *target, *endptr, *comment, prev;
 
 	if (s == NULL)
 		return -1;
@@ -31,29 +57,48 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
 	if (ops->source.raw == NULL)
 		return -1;
 
-	target = ++s;
+	target = skip_spaces(++s);
+	comment = strchr(s, arch->objdump.comment_char);
+
+	if (comment != NULL)
+		s = comment - 1;
+	else
+		s = strchr(s, '\0') - 1;
+
+	while (s > target && isspace(s[0]))
+		--s;
+	s++;
+	prev = *s;
+	*s = '\0';
 	ops->target.raw = strdup(target);
+	*s = prev;
+
 	if (ops->target.raw == NULL)
 		goto out_free_source;
 
-	ops->target.addr = strtoull(target, &endptr, 16);
-	if (endptr == target)
-		goto out_free_target;
-
-	s = strchr(endptr, '<');
-	if (s == NULL)
-		goto out_free_target;
-	endptr = strchr(s + 1, '>');
-	if (endptr == NULL)
-		goto out_free_target;
-
-	*endptr = '\0';
-	*s = ' ';
-	ops->target.name = strdup(s);
-	*s = '<';
-	*endptr = '>';
-	if (ops->target.name == NULL)
-		goto out_free_target;
+	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
+
+	/* Parse address followed by symbol name, e.g. "addr <symbol>" */
+	if (strchr(target, '<') != NULL) {
+		ops->target.addr = strtoull(target, &endptr, 16);
+		if (endptr == target)
+			goto out_free_target;
+
+		s = strchr(endptr, '<');
+		if (s == NULL)
+			goto out_free_target;
+		endptr = strchr(s + 1, '>');
+		if (endptr == NULL)
+			goto out_free_target;
+
+		*endptr = '\0';
+		*s = ' ';
+		ops->target.name = strdup(s);
+		*s = '<';
+		*endptr = '>';
+		if (ops->target.name == NULL)
+			goto out_free_target;
+	}
 
 	return 0;
 
-- 
2.34.1

