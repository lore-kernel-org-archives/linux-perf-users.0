Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537D3A48E0;
	Wed, 13 May 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695940; cv=none; b=Ab9LGWk9fPCdu9H+9DOzE29ZU0jxXZZNxB09uCgZZqGMEO4fQu7kb3zBOOjYeh0PUgTLQKDpcCXCvIFGLSNK9FstZAnvVxiiMevuEixw2XsDBUKdbTcbSMSINb5eVtPXSI1N2Jk1UzjmzWNAwQiqoj5fsiPdH6TzmhLuuEU/AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695940; c=relaxed/simple;
	bh=XuI23e3whQ+sQNNDN6zabV3npSgjjHmlPC7wVR7MWB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOFf6FqhXuwEBbs2UJjqsZjKizI5qy7xOt6UVozVtCrfcpVqO7DvfMLUS8OefthXuF2BHZaBzP+lLC3vhcKjsHbw1gGmTZUNJxKdcPRnct173R05ExaFy0Ad/G1GhKvJZW3vFCAPgtVbBDrqIsiTTopB5I+OPCgA4VoLE2SPe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Lee.localdomain (unknown [39.152.152.253])
	by APP-05 (Coremail) with SMTP id zQCowADXZQnwvgRqayEtEA--.28384S2;
	Thu, 14 May 2026 02:12:01 +0800 (CST)
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
Subject: [PATCH v2] perf riscv: Fix discarded const qualifier in _get_field()
Date: Thu, 14 May 2026 02:07:21 +0800
Message-ID: <20260513180721.1179904-1-guanli.oerv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXZQnwvgRqayEtEA--.28384S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrtr4DtFW5Xw48Aw18Zrb_yoW8Xr18pr
	Z7Crn0k345Wr1a9340vFWI9FWUurs3XayS9FsYy3y2vws8X34xtrWftan8C3W2qryUur1r
	ur43urWkAF48AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: hjxd0znlorv2ny6l223fol2u1dvotugofq/

The assignment of strrchr() return values to non-const char * variables
triggers a -Werror=discarded-qualifiers warning when building with GCC 14.
This happens because in newer glibc versions, strrchr() returns a
const char * if the input string is const.

Properly declare 'line2' and 'nl' as const char * to match the glibc
function signature and ensure type safety. This avoids the need for
explicit type casting and aligns with the design pattern of not
modifying read-only memory in the perf tool.

Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
---
v2:
 - Drop the auxtrace decoupling and weak stub approach as they interfered 
   with the cross-platform analysis intent, per Ian's feedback.
 - Focus on a clean fix for the const qualifier issue in RISC-V header.c
   by properly declaring local variables as const.
 - Use Li Guan as the preferred name format for consistency.
 - Verified that this fix is not yet present in acme/perf-tools-next.

 tools/perf/arch/riscv/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
index 4b839203d4..891984e909 100644
--- a/tools/perf/arch/riscv/util/header.c
+++ b/tools/perf/arch/riscv/util/header.c
@@ -19,7 +19,7 @@
 
 static char *_get_field(const char *line)
 {
-	char *line2, *nl;
+	const char *line2, *nl;
 
 	line2 = strrchr(line, ' ');
 	if (!line2)
-- 
2.54.0

