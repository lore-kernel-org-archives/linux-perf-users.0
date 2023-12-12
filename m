X-Greylist: delayed 147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 00:35:43 PST
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC712E;
	Tue, 12 Dec 2023 00:35:43 -0800 (PST)
X-QQ-mid: bizesmtp76t1702369740tggbgcmn
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 16:28:58 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: aBJFcW+uBGZOIRSRO8DCOUwTInVzTYjBETeL0cf/Z9l32nz/XJIwpk4Ia+x8O
	qSoY3kzIRnkTKft/UdrEKONsHv8i0Or+bOURHFN64urNRvsmkUYiTstYB9WkGUc0H4AyiI/
	y5Rh/py1UY9vdgNj/u5P3AFZgvoZtTCBpUVdu8n191TWAQL6ipsp+/41OS5ss3hFNkDZVvw
	jUrNNFgxXp4FwK3YNa75dPjYtn/G4vA/xXaHiEZNoEgaqzTqdBRqfEPxMgSYYQT+FgXWyOR
	DX/rV+c55mDOnrzKDhMZmW49m5O2Y4kEod61nM1ZxfBK6UJsJZTSwEzO0ju9ZemGsREAAq8
	sw5F3Gy2xGw/BNf1LHTTInBq+TG0/dHuHBFTLfPanexCat+VxxwF2G9MMomGnsaw6/O5wa3
	60+RSDEeRCdPjtAel6CVXQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2540312450627616497
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: "JiaLong.Yang" <jialong.yang@shingroup.cn>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/perf: PVN for HX-C2000 CPU with Power8 Architecture
Date: Tue, 12 Dec 2023 16:28:43 +0800
Message-Id: <20231212082843.9664-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

HX-C2000 is a new CPU made by HEXIN Technologies Co., Ltd. And a new
PVN 0x0066 has been applied from the OpenPower Community for this CPU. Here is
a patch to make perf tool run in the CPU.

Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
Link: https://lore.kernel.org/all/20231129075845.57976-1-ke.zhao@shingroup.cn/
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index f4908af7ad66..599a588dbeb4 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -11,8 +11,7 @@
 #
 # Multiple PVRs could map to a single JSON file.
 #
-
-# Power8 entries
 0x004[bcd][[:xdigit:]]{4},1,power8,core
+0x0066[[:xdigit:]]{4},1,power8,core
 0x004e[[:xdigit:]]{4},1,power9,core
 0x0080[[:xdigit:]]{4},1,power10,core
-- 
2.25.1

