Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7B401493;
	Wed, 13 May 2026 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687425; cv=none; b=ChoU5AAcbNTUv0YVeg7OA+PwzROhoO4lsM9GzpIO01A6OzAvEd2T5mCgh47juOW1oBtn/zaLqeoxL+adgEhAtnfbBOtr0uJjTU8f9ymwu0KzCxGn5BY8notMKGvywZeUXPaeJlxVaEN4YX5ipRC4JB2rjWyyg/qH7l8DsHfQM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687425; c=relaxed/simple;
	bh=AfI9pfMVssm/KgEkahsqPoEM0bifhlJN582tQcirdRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdkipUjI/s2mATJ82so8cPYGPQ6V8Cgt6NTmiteOMJrLHJgUXrjcZtE9DnG6txn0bL1dtuct/BWq1zZAUT2pRrV8Son1bqqkloQlGgXLlFxuRwlQjGWJWnIVYp/8ojc2t5rWu4pt+H9cG2mnQOCoJu5F/ob18f5urSfRiK8THeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Lee.localdomain (unknown [39.152.152.253])
	by APP-01 (Coremail) with SMTP id qwCowACHMm6MnQRqEXQgEA--.35827S5;
	Wed, 13 May 2026 23:50:11 +0800 (CST)
From: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	adrian.hunter@intel.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Subject: [PATCH 3/3] perf script: Provide weak stubs for instruction decoding
Date: Wed, 13 May 2026 23:48:51 +0800
Message-ID: <20260513154851.1085334-4-guanli.oerv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHMm6MnQRqEXQgEA--.35827S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48JF4DZF13uFy5Wr47XFb_yoW8XF4kp3
	9ru3y5Zr1UXF4avw1fG3ZYqr1a9r9aqF1SgFyIk39rWr43Jw1xtry2kF9Ygr17Ar48JryU
	AF129FZ5WryrAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: hjxd0znlorv2ny6l223fol2u1dvotugofq/

When cross-compiling perf for architectures that do not yet implement
hardware-specific instruction decoding (such as RISC-V and ARM64),
the linker fails with undefined references to `dump_insn` and
`arch_is_uncond_branch` in builtin-script.c.

Provide global __weak stubs for these functions to ensure successful
linking across all architectures. Architectures that support these
features will automatically override these weak symbols.

Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
---
 tools/perf/builtin-script.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a3..80a8f0e80b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4608,3 +4608,25 @@ int cmd_script(int argc, const char **argv)
 out:
 	return err;
 }
+
+/*
+ * Provide weak stubs for architectures that have not yet implemented
+ * instruction decoding. This prevents linker errors (undefined
+ * references) on non-x86 architectures (like ARM64, RISC-V) when
+ * building perf script.
+ */
+const char * __weak dump_insn(struct perf_insn *x __maybe_unused,
+			      u64 ip __maybe_unused,
+			      u8 *inbuf __maybe_unused,
+			      int inlen __maybe_unused,
+			      int *lenp __maybe_unused)
+{
+	return NULL;
+}
+
+int __weak arch_is_uncond_branch(const unsigned char *buf __maybe_unused,
+				 size_t len __maybe_unused,
+				 int x86_64 __maybe_unused)
+{
+	return 0;
+}
-- 
2.54.0

