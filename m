Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4129D265;
	Wed, 13 May 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687424; cv=none; b=kjQEnShMX8f12ucXZjkrCehX/eHjnxNxNuuhkEjdCf8eUg40IwDt4w9DsD1/LA7VgSqeG5KjPI0DbEoSHErhHyPqSmPEUfIjagHeyB0fZZMZOAU+6m0f3afCpC5YUWQ0CvLGntPG3rnIjD5Vq/wYTB+Iug01cywtEfVJkiv24dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687424; c=relaxed/simple;
	bh=eyA1KLhJADVxE+cMb/ou9bRwJWwO3SYP+u4TA06xkw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2QU0lHdwD84jbaavr9w+lkHRANVHOtwnzAF25eZCcdtEB9gxRedMKMojB2CWIU1ibLM2Dted5n5xdBK3+mNkxfYRhTR2CtCrElPK8CYdOZPEytPAHS/BUPTdmNAvJOCzBQtayWapzUj3HcpzyoC7dlWUuxxGFwIj6K2CLZ6aWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Lee.localdomain (unknown [39.152.152.253])
	by APP-01 (Coremail) with SMTP id qwCowACHMm6MnQRqEXQgEA--.35827S4;
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
Subject: [PATCH 2/3] perf riscv: Fix discarded const qualifier error in _get_field()
Date: Wed, 13 May 2026 23:48:50 +0800
Message-ID: <20260513154851.1085334-3-guanli.oerv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHMm6MnQRqEXQgEA--.35827S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfuFy5urWUtw1DAr47urg_yoW8XFyfpr
	s7Cwn0qa4rurnIkr4jvrZ29FW5urs3Wa4Svrsay3yavr4YgryfJFyrtw15KF1Uur4UJws0
	kr15u395Ar48Ar7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUj5Ef7UUUUU==
X-CM-SenderInfo: hjxd0znlorv2ny6l223fol2u1dvotugofq/

When building perf for the RISC-V architecture (e.g., with GCC 14), the
build fails due to strict type checking on pointer assignments. The
compiler flags the return value of strrchr() being assigned to a
non-const pointer while processing a const string, triggering
-Werror=discarded-qualifiers:

    arch/riscv/util/header.c:24:15: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
       24 |          line2 = strrchr(line, ' ');
          |                ^
    arch/riscv/util/header.c:29:12: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
       29 |          nl = strrchr(line, '\n');
          |             ^

Resolve this by adding an explicit (char *) cast to the strrchr()
return values, which satisfies the compiler's qualifier checks
without altering the runtime behavior.

Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
---
 tools/perf/arch/riscv/util/header.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
index 4b839203d4..d01ba64aec 100644
--- a/tools/perf/arch/riscv/util/header.c
+++ b/tools/perf/arch/riscv/util/header.c
@@ -21,12 +21,12 @@ static char *_get_field(const char *line)
 {
 	char *line2, *nl;
 
-	line2 = strrchr(line, ' ');
+	line2 = (char *)strrchr(line, ' ');
 	if (!line2)
 		return NULL;
 
 	line2++;
-	nl = strrchr(line, '\n');
+	nl = (char *)strrchr(line, '\n');
 	if (!nl)
 		return NULL;
 
-- 
2.54.0

