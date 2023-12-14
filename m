Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0DF116;
	Thu, 14 Dec 2023 04:33:24 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VyUUufW_1702557199;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VyUUufW_1702557199)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 20:33:21 +0800
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
Subject: [PATCH 2/3] perf scripts python: arm-cs-trace-disasm.py: set start vm addr of exectable file to 0
Date: Thu, 14 Dec 2023 20:33:03 +0800
Message-Id: <20231214123304.34087-3-tianruidong@linux.alibaba.com>
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

For exectable ELF file, which e_type is ET_EXEC, dso start address is a
absolute address other than offset. Just set vm_start to zero when dso
start is 0x400000, which means it is a exectable file.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 46bf6b02eea1..c9e14af5b58c 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -260,8 +260,9 @@ def process_event(param_dict):
 
 	if (options.objdump_name != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
-		# for kernel dso, so in this case we set vm_start to zero.
-		if (dso == "[kernel.kallsyms]"):
+		# for kernel dso and executable file dso, so in this case we set
+		# vm_start to zero.
+		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
 			dso_vm_start = 0
 		else:
 			dso_vm_start = int(dso_start)
-- 
2.33.1

