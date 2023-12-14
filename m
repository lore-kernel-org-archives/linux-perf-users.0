Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D860120;
	Thu, 14 Dec 2023 04:33:19 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VyUMJ.p_1702557194;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VyUMJ.p_1702557194)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 20:33:16 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: james.clark@arm.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	leo.yan@linaro.org,
	al.grant@arm.com,
	mathieu.poirier@linaro.org,
	tor@ti.com,
	acme@redhat.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 1/3] perf scripts python: arm-cs-trace-disasm.py: print dso base address
Date: Thu, 14 Dec 2023 20:33:02 +0800
Message-Id: <20231214123304.34087-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm-cs-trace-disasm just print offset for library dso:

	0000000000002200 <memcpy>:
            2200: d503201f      nop
            2204: 8b020024      add     x4, x1, x2
            2208: 8b020005      add     x5, x0, x2

This print DSO base address to get complete virtual address for
userspace application:

	0000000000002200 <memcpy>: (base address is 0x0000ffffb4c21000)
            2200: d503201f      nop
            2204: 8b020024      add     x4, x1, x2
            2208: 8b020005      add     x5, x0, x2

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d59ff53f1d94..46bf6b02eea1 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -108,6 +108,8 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
 			m = disasm_re.search(line)
 			if m is None:
 				continue
+		else:
+			line += " (base address is 0x%016x)" % dso_start
 		print("\t" + line)
 
 def print_sample(sample):
-- 
2.33.1

