Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622486;
	b=2fz/GaZCDmwMg1pPB5ebCKckFAgAYvvzab2lY0EQz/qe5TpbcW8DOlvT88l30QJsQaMz
	 i1FR0xNUMO4450dfO+dd12TvrHKUzjF99kl1y3VHkdwaX+1X5iyuVE0+9RQmaN7wO14UJ
	 QofelG3UI0kzE3S9YDFbWoo3HJL5g+sXU+wBSAWJJA0MZa3gavxMvMYZbxEGB7iP14EOL
	 jnLIeysFDo/zmSPfp2hqgBfEmN3Vz+eDIt5zAKdccvsFxnjGnhAPgGaM6XGYuFIGOwaw9
	 mn98f+IdxTs6245BKchbt8TUfq83mni98p3KzynQjovttBZA29kASlNXM4MQJk1bmFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622486;
	h=DMARC-Filter:Received:Received:Message-Id:Received:Received:
	 X-Zmail-TransId:X-Mailer:Date:Mime-Version:From:To:Cc:Subject:
	 Content-Type:X-MAIL:X-MSS:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=fdAPgHc1hzHvc6kUAV52VbpNBIqGtUPErmz2SALGr2Y=;
	b=UkiILvHbrcIh9FtA/kNFFJmlc/bhhmsdMZk29K2WEwKQ1nGc/IyUBydeSBL87hm0FyT1
	 vAlVigsmbLXi9hD+BHbQl/zoeJuMtVdeKxTsscEZjkJj+mzVjG0LrT8/aSie+83XpHPpa
	 Vbp6Z40U2QOFQog678X4gOI9QnCEQU28H6YILKyYWzAPlCxDf+70sprSEOYn/cGGHkfnK
	 7XW9L+oqdLn/FnI31tJaPXYpj8R2phyzGR8RMiBcD57gIMWHIXYwtuLnRnbi7f4KA8wRm
	 +PId3MbyqvfWunminuNnTDXX6EAeCfcgOK7ID5RKmp455M4UDU6N0pdMrrWyJLgJ+aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F4606A324;
	Mon,  2 Nov 2026 12:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0F4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJ9w20QT5z4yjjK;
	Mon, 02 Nov 2026 20:28:02 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 6A2CRwkO000175;
	Mon, 2 Nov 2026 20:27:58 +0800 (+08)
	(envelope-from lv.yating@zte.com.cn)
Message-Id: <202611021227.6A2CRwkO000175@mse-fl1.zte.com.cn>
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 6A2B2Qp1057247;
	Mon, 2 Nov 2026 19:02:26 +0800 (+08)
	(envelope-from lv.yating@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid16;
	Mon, 2 Nov 2026 19:02:28 +0800 (CST)
X-Zmail-TransId: 2b096ae86dc4bf4-04f0b
X-Mailer: Zmail v1.0
Date: Mon, 2 Nov 2026 19:02:28 +0800 (CST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <lv.yating@zte.com.cn>
To: <irogers@google.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <adrian.hunter@intel.com>, <james.clark@linaro.org>
Cc: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liu.qingtao2@zte.com.cn>, <he.yilin@zte.com.cn>,
        <zhang.cheng35@zte.com.cn>, <ye.zhihao1@zte.com.cn>,
        <shen.lin1@zte.com.cn>, <dai.hualiang@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0hdIHBlcmYgdGVzdDogQWRkIExCUiBjYWxsIHN0YWNrIGJyYW5jaCBmaWx0ZXIgdGVzdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A2CRwkO000175
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: lv.yating@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 02 Nov 2026 20:28:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE881D2.000/4jJ9w20QT5z4yjjK

From: lvyating <lv.yating@zte.com.cn>

While debugging a NULL deref in resolve_lbr_callchain_sample()
triggered by "perf record -j stack" (fixed in commit
4626d370ae89b8af4d46a45372b269f926ec662d "perf machine:
Fix NULL deref in thread__resolve_callchain_sample()"), the "-j
stack" filter was found to lack coverage in the perf record LBR
tests.

Add "call stack" tests, sequentially and in parallel.
Use a 100% empty stack threshold, as with ind_jmp and ind_call,u,
since the stack filter is more restrictive and can leave branch
stacks empty more often.

Signed-off-by: lvyating <lv.yating@zte.com.cn>
---
 tools/perf/tests/shell/record_lbr.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 8d51afeb437b..d52124355f06 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -109,7 +109,7 @@ lbr_test() {
   sam_nr=$(echo "$out" | grep -c 'PERF_RECORD_SAMPLE' || true)
   echo "$test: $sam_nr samples"

-  bs_nr=$(echo "$out" | grep -c 'branch stack: nr:' || true)
+  bs_nr=$(echo "$out" | grep -cE 'branch (call)?stack: nr:' || true)
   if [ $sam_nr -ne $bs_nr ]
   then
     echo "$test [Failed samples missing branch stacks]"
@@ -146,6 +146,7 @@ lbr_test "-j ind_call" "any indirect call" 2
 lbr_test "-j ind_jmp" "any indirect jump" 100
 lbr_test "-j call" "direct calls" 2
 lbr_test "-j ind_call,u" "any indirect user call" 100
+lbr_test "-j stack" "call stack" 100
 if ! ParanoidAndNotRoot 1
 then
   lbr_test "-a -b" "system wide any branch" 2
@@ -177,8 +178,10 @@ else
   parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
   pid9=$!
 fi
+parallel_lbr_test "-j stack" "parallel call stack" 100 &
+pid10=$!

-for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9
+for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10
 do
   set +e
   wait $pid
-- 
2.27.0
