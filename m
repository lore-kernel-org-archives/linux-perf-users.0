Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F576CD
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 19:23:23 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Sq3pv6kGTzPyQ
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 11:23:19 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4Sq3pt5mRDzB6crv
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 11:23:18 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Sq3pm5r75z8XrRC;
	Tue, 12 Dec 2023 11:23:12 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Sq3pd2xBtz4xVbv;
	Tue, 12 Dec 2023 11:23:05 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 3BC3Mtte091763;
	Tue, 12 Dec 2023 11:22:55 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Tue, 12 Dec 2023 11:22:56 +0800 (CST)
Date: Tue, 12 Dec 2023 11:22:56 +0800 (CST)
X-Zmail-TransId: 2af96577d2100ce-8cd53
X-Mailer: Zmail v1.0
Message-ID: <202312121122562881958@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <peterz@infradead.org>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
        <liam.howlett@oracle.com>, <ojeda@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBlcmYgaW50ZWwtcHQ6IHJlcGxhY2Ugc3RybGNweSgpIHdpdGggc3Ryc2NweSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3BC3Mtte091763
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6577D226.000/4Sq3pv6kGTzPyQ

From: Yang Guang <yang.guang5@zte.com.cn>

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated.
No return values were used, so direct replacement is safe.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index b450178e3420..5b14c6701ecb 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -507,7 +507,7 @@ int intel_pt__strerror(int code, char *buf, size_t buflen)
 {
 	if (code < 1 || code >= INTEL_PT_ERR_MAX)
 		code = INTEL_PT_ERR_UNK;
-	strlcpy(buf, intel_pt_err_msgs[code], buflen);
+	strscpy(buf, intel_pt_err_msgs[code], buflen);
 	return 0;
 }

-- 
2.25.1
