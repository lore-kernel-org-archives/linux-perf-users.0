Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019234;
	b=C9UEHqAexKK3NcRVkMuWbMqnG/Dw1joxZ8NBzb4jqWluZ9KdFuCAOR9niewu7RXHCRQR
	 D+HueVSZLcRXHIS24xq4ZqSqdRABufqZiACTMwc1lyl5Q5aFmoaEUIuQmIoY420LooHLh
	 GVjN+WW0hyhYPobQgmEVF+NrEwsXoQ/KWidyK/khhiF/A1y1VAZ2MuRYKZXXJQgDlmfP1
	 3dIjnf0v++qevXfWZwLN5/ya4xzq1oKnk9ob0OqhqZAOGQGLtZO6EiJWvmKzRciyGpOIT
	 uQiFgZZhT/7OXNDNVmzEF+EggL6UfV4KKbAtgXXFjcYhL4YY+7t1aZIwvMH4AQS/JIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019234;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3GIOH+/c8ZlwAH4hdy3vTg9Fnv+nr6QlL6HrUi9JjUI=;
	b=s14icH9M7TmThmulHZkwcV2EPflMPFnUrV+hbqwB/fiLgjh6x8XWCrCU+1a5ZhXoc3Kz
	 kYTNiR9Y4CKYLzn4ZFrfv62ISGSjVb3ooPaPEFJxEgjDRDHys4IWG2o42E7QObiImpMjE
	 BQmQZki65xAFznM5KUjIwNYO2sAWx5GkYEyMhwSyPrtk/U5QR09mV7osZz8RVW7b1MhE8
	 BuxEiur/Xg26ujP3oa9zf0Qe6XkXkmMR2wcOOQx0YaQiFkCWcclloKhhiRDoKy5pIKYzB
	 /9ir+jsznTi/e0P62xXli9hHC38qNN2mw36I3TgV9EF4MfaGTzjOPHTXVF8jIj+isMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nop8ZZz5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KPIvxkBy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39F606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C39F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nop8ZZz5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KPIvxkBy
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A72Axgt4113401
	for <linux-perf-users@vger.kernel.org>; Sat, 7 Nov 2026 02:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3GIOH+/c8Zl
	wAH4hdy3vTg9Fnv+nr6QlL6HrUi9JjUI=; b=nop8ZZz50KWkS8urDJT3hxpTV4k
	BAEPCnNgvlCV5nW/ALTCX9VJTey5w3I10a/mjLDouG3WOysCbGYEzn7gNFkNg8M/
	nzpOsFkzTU0Z/dY4mPagcZ7QvQcIjZqzc44YLqeoKSxhr7/j/HR9z2FI+0DuoyDV
	i1bCmfL8UTAFZpvehzU413xo0+FAgXLAC7BKlCtlyydehZhLOkP/Qs49TEO2o2Rm
	Tt6kwxWKzdvHE5kMzJ0E0bXvcpYIna7EiRYtn8YmVfbrX5esD/ex4wFvDxncrpOF
	kmJbd5Xw6pX9NV4pmdQJWV8D0BfLJPqH+N0rZNvJ+7Dyq9HYKMns1MG1JZg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqs668-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 02:40:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso3044634eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794019233; x=1794624033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GIOH+/c8ZlwAH4hdy3vTg9Fnv+nr6QlL6HrUi9JjUI=;
        b=KPIvxkByE1KosgLgqW5Sb95C1rvj70WDTN6BwrXk8vyEP6VBYI8yomA40wDJHuSNM2
         Kp8cLocrUsVZPMGIFgRVEL1QAeWWnRrlRH8Yw5U3c4qSVUoahCveUzk4mwnC7qMxiMJ2
         +yYfiRK6saosxIPN0EsLqmAP84GCPJbSN5JENUXsmb3TQNKqBy8jDIQGbLcnY6K/YS/k
         KxQqVL7KkJbfHAelgU+7/8j+85aVZOiL+pW4aorm5yQEqVd62fTBcMp8KMbUgqYTMfo8
         wb9P1MrgmtvSm5HCHlH3timskyIg1ODJ5Gv7oTW2LwweiIXHlO9uMAXQx8fIf/6eCS5r
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794019233; x=1794624033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3GIOH+/c8ZlwAH4hdy3vTg9Fnv+nr6QlL6HrUi9JjUI=;
        b=vBKT6UXA9Dh/Vz+FnyYjixep9mvU3EAguFjt5farsz3P2bAAQISqm1oxdSatt9zXe6
         owiEPtmGWSoO1g5buLAW2qcJZUQSyL7SEN+GM87Zv9JR4FW9Jr4iHfbirjjI8wBve0NL
         4EIIDLg5mDSvUe+KM/Hmk+iFG8393tOzMAolmzFx9NsJUtaXc2eOkty1Ymfv1vHhlzXb
         MGa21a2CrqcGSpbJFoD3cdyKNKSrEKLIggX/2oU7nXS1TYH1jnibWdiCcyf1rpBr2vu9
         kIaQgqR8wPgYrws0+GysxCikXXPfKGIfKReREAZaMm3F3Z6zpYLqgwwjg/tpQU0+zm4A
         RZgw==
X-Forwarded-Encrypted: i=1; AL+hErHriAUi0RkRkLabPhxljMuSnOTvw6wTr1MSHasDbw6FTQdX9GYm/2839rhhztmgVwZ5ODW9qWFbyrBNUsATDBM5@vger.kernel.org
X-Gm-Message-State: APuU4Z9SI2dNGZ3eM9l++mt/Y2LIooQHV9FRCnqzr6WNtfosGgskoQ/9
	4mj/CT5blECBNXcOZi7dXb9oEJ40YvMPz/zY2P34mwRuqFxD+JMkx2FFpBEI7KSu0bLapWJMIsG
	wfXdqzjQfqKKsE0mUG429GU3LcHgd6Sg35sgMYAjptykjgqCF4Vj3yntwxKmU9J0xi3zsEwv7
X-Gm-Gg: AYBFou3BlDdGNwYr3OZYG0IR1m5VoKkqpNr7AePPf83A8ML1cK9ThpMerD16WTrb5+4
	aGa9Qka/lTi3v6mLMFtQXx42ztujLwjm8WTga/ohkLnoYlXmU5sQqOsNLMymp7GH9HXlN4YTVoA
	8h3O3efhN0J7jde7o3yfSwgOl7aWr9RZ2148yeb4vfKHnMgMgOzY4TKvnW7BwkD+pz0ZqJ/Iq+w
	QbPRoPgYwbaRSnHeRGYx9Pz/CvfpClUU1MTSyxoyUCutMfsFYcR6SlmkOUaZZR1YfM+TxlBQmUD
	hcQ97S0QFf+9ZQlubXzeDAJqhgLeugXYSgxlKZJd8He8P+e+cuTFcIoQTVBCuMl/TZhGuQMqoGk
	xjvKTU3koBnf3kdwn+Ls8Cxma0hz8OscTnyY09vD3y+/Pd19flN1zkDXY+z0eEYNkLZbkW/PQEy
	ijKQ34PIzRLRb42J6up/fRqx+oS0y3z2fyehzP0cTX1me0ycD0xdGRLkCwwqtPNsP6lg40a9vBW
	w==
X-Received: by 2002:a05:7301:d805:b0:362:fa87:2aa6 with SMTP id 5a478bee46e88-36f6fc79169mr4866618eec.0.1794019232619;
        Fri, 06 Nov 2026 18:40:32 -0800 (PST)
X-Received: by 2002:a05:7301:d805:b0:362:fa87:2aa6 with SMTP id 5a478bee46e88-36f6fc79169mr4866588eec.0.1794019232016;
        Fri, 06 Nov 2026 18:40:32 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm11069040eec.29.2026.11.06.18.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:40:31 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jtaubepe@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v8 8/8] perf tests: keep bp_signal memory accesses visible
Date: Sat,  7 Nov 2026 08:09:17 +0530
Message-ID: <20261107023917.40606-9-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 815tABU0s10Pxq1gkgEC0b5BRMdi0GZt
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee8fa1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=tsqkxpHE8OKeFbBeJjEA:9 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX97Opiq2u7bWH
 oVTPo6r2cwGhE197MqS+HoyQ26vVoD4wYoBUfwT3jth47hPtnqDLM6W/RqHh9/yS7vVq7nX69Ew
 Mu9+Mvnv+oX5QZwg/wk9GVBmKhvxIT0=
X-Proofpoint-GUID: 815tABU0s10Pxq1gkgEC0b5BRMdi0GZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfXwg4cOvyszp6T
 9icNWYMdHeSkt+XAwZnufWxuxPwuzEpmZjij8AhoIINnAtTwFei0kNrpIsJUfJWApggNure/g6B
 YBmgMhPJ3uhE6DGypP/SIZcvQRitfokdS8Kk0z/zHfV008stK6/myupvIb/G7Dm+lfZ+YAEBgZM
 hHx8eVHWhFoY7omGGLs0sVki1mOFRrSayjOxNLmx4vnFr26r+bi/1f2V4VZnXyrtkHQGYPSbaW/
 sEWcmkbmbn0RYgj5mW1a2SZaDy7qbHnoY5wrolPhpft3X4RS2CClYZmmI/+LX/AtWOAtVBfovHn
 5R8peShXnf9+gUlXsR1W5TCczBcb4MhynG0D4ExycH/Y6843tS0ayNpJGqA0d/ryq0e6DBdELgK
 GEKYweHZd2xvHpUKmyMARHey9h90jNQCJAxaO8iSwTiT+//0SfGp9Yidd8OdBoAE5NAmLdENLfo
 aMaxV7R3ueweNfcrdcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070010

In the breakpoint signal handler test, a breakpoint is set on
__test_function. Keep that helper as a real call target so the breakpoint
has a stable address.

The test also relies on the watched variable being accessed as distinct
memory operations. Use READ_ONCE() and WRITE_ONCE() for those accesses
instead of making the object volatile, so the source marks the exact
operations that must be preserved.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 tools/perf/tests/bp_signal.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index f580ba7486b1..2e4f7747d32f 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -36,15 +36,14 @@ static int fd3;
 static int overflows;
 static int overflows_2;
 
-static volatile long the_var;
-
+static long the_var;
 
 /*
  * Use ASM to ensure watchpoint and breakpoint can be triggered
  * at one instruction.
  */
 #if defined (__x86_64__)
-extern void __test_function(volatile long *ptr);
+extern void __test_function(long *ptr);
 asm (
 	".pushsection .text;"
 	".globl __test_function\n"
@@ -54,16 +53,19 @@ asm (
 	"ret\n"
 	".popsection\n");
 #else
-static void __test_function(volatile long *ptr)
+static noinline void __test_function(long *ptr)
 {
-	*ptr = 0x1234;
+	WRITE_ONCE(*ptr, 0x1234);
 }
 #endif
 
 static noinline int test_function(void)
 {
+	long value;
+
 	__test_function(&the_var);
-	the_var++;
+	value = READ_ONCE(the_var);
+	WRITE_ONCE(the_var, value + 1);
 	return time(NULL);
 }
 
-- 
2.43.0

