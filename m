Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332CA3;
	Thu, 14 Dec 2023 04:33:10 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VyUW05Z_1702557186;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VyUW05Z_1702557186)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 20:33:08 +0800
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
Subject: [PATCH 0/3] perf scripts python: arm-cs-trace-disasm.py:
Date: Thu, 14 Dec 2023 20:33:01 +0800
Message-Id: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the instruction flow disasmed by arm-cs-trace-disasm.py is
ambiguous and uncorrect, fix them in one patch set. Please refer to
each patch for details.

Ruidong Tian (3):
  perf scripts python: arm-cs-trace-disasm.py: print dso base address
  perf scripts python: arm-cs-trace-disasm.py: set start vm addr of
    exectable file to 0
  perf scripts python: arm-cs-trace-disasm.py: do not ignore disam first
    sample

 .../scripts/python/arm-cs-trace-disasm.py     | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.33.1

