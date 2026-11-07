Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019190;
	b=c4O4jaKhDUXS1DydS6OdqMMQE2c0JkmfXxb1IqdV9MzB1nlxcLGesTb9FgjNrIGvx59q
	 HFY7SytjEWq4ZLDOrOtir3iD/skGukVvXtwGqkYe5C0eZ8Y+GOU08R1ChggmT0CXGmO0O
	 g6J4h+jfF9H9QJY3Y9fLATp+sJtlNBnv9/lPqLnhhXZpZAYppRYBtLM7DYJifFaGJuNVo
	 M0vHiwRCcJwkMZxgaqZoY3bXz7huAsMMPWts5cq+nZC0c9Kf875HqpPXSxLYUojyLaGo3
	 RMb7QYa4afOcNoXCfL1VU0hFn/JX7nboHtBp9KNpNf7aVhibvTXPoVAbbUACYuDk/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L420166GSS4TE+K47OptRNcFOTisOIHTM/2QMseJ/eQ=;
	b=otMQ3uuqGcQ53YWnRjptCM+IIUiVrPp9OVkS06qasBnSRmQYCh/LetrEl1haw5nTkByW
	 1ffU7t8bEuSJgTc+aAIAbNTZmuqsEVET9fCkUj76yBpAPrDISidk/Kv4r5ZE+P4iqdGzU
	 RMHufJbfmHJ43QVPD/9JNjwPryj8coIaODh3s3FNt8LKjIjeC7/iBPxylgtXM9Uh81dhX
	 Ut9jcvQeOXQF+JgXPKweFJqQm2sfYBcV9liT9hvxkrWjgDiik1v73FXst3Jm9xwiE9bio
	 6b7j9Nvt3oCaDXKc9KZWHcKOsMsX3Z9B4AuQUdcERMC8Nan2jD6TDDqF89tTJCrJIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lbXY0gAz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JNPueRbZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7338606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7338606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lbXY0gAz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JNPueRbZ
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A72B28K1521122
	for <linux-perf-users@vger.kernel.org>; Sat, 7 Nov 2026 02:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L420166GSS4
	TE+K47OptRNcFOTisOIHTM/2QMseJ/eQ=; b=lbXY0gAz5PjhZ53/zvhjXNUzRVe
	2M8GWGe8UczDg43WWUJiAcU22wyjOmftVZWAKG/fBBUx6RC2ZGJdQW3zl20ggfIv
	jptojMcEOJJkSiicXOzxyARK0CjvbSqTYi+u3W5FtsBXHTygxuYYyIn+Hb0GWGik
	OUzC7GcOR/Pury2piCPxQeGZr/KFSXlNJdz/j00AzbYm085PJY1og9odi1OFxaJk
	4dNQhQEFGKqcZnxGD9CPfgqtcSu52bSU6cpcBgKDmki5xTBRzuqSjEfWPFLoo63G
	DLWGWbNaP2C7TaBPQgHdHyNjv41eQPUq9QOaAinxsUDhE5bouNUB/JXXAAQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hssbnr9fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 02:39:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3700be873ebso307440eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794019188; x=1794623988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L420166GSS4TE+K47OptRNcFOTisOIHTM/2QMseJ/eQ=;
        b=JNPueRbZT8SL+ynqbJF1FgUeQJ1iulUCqfFfl2bCT4TRKRje8VdmO3hm2pzQB0IC0x
         gsfeY2OJk2t2G8AGZNg2QMdD2DcfdPTQNM6urUlrHvzOu15dip65UACrtBPrgyf1pmEe
         TDHjZQUCxnWne/8UBW5vn534EpXh1C4WavGkwLFQh9Xo9nOMSF7h/SI1M1X18atJ2GMK
         TofGrlJP5iikBqW0wecj74WlLZ1GmWaYvGqTaBR0aGqhiCWBzAyI4N7pRiXmnlr6RLwh
         keNiXYRwnclMyXeZpzj9YATjkR7J/2vLyXRpbAG9YAKdnZ3b4YTyRsunZXX4KLHCRSMO
         TxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794019188; x=1794623988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L420166GSS4TE+K47OptRNcFOTisOIHTM/2QMseJ/eQ=;
        b=SaZJU0SyVMX8+7NU5tOMS5F3QIVvISNr8+ynbkrXxCXaJHXQb7+gKfWVN/FYOklrNe
         QSviEi+NlLoEBlMIDHcHHo1qMFmAwVxTqrH11FGRuBQCNWS2NVZpfnrScnDcbS/AcgHA
         d0wWZVfQcJwsuw1xA/j48GY+7L0j3zrm5RqbRBQrueZvTzP4rS4+3Td4IrTobgCIej8O
         wKtnGj/+NCL5n4bljSz7Fxm6+UK7lrpW5hZ3pIZr4LOKCUMI5/FOYWRtIdQV3StmdQO1
         d9Lldo85sAQJgLTJxJDZ13arVvMKJtrBCpojDJn1Rz2BxZJcZj12iaMaP/tHpv0EkJ35
         PlDA==
X-Forwarded-Encrypted: i=1; AL+hErEc0KvEOq3eZLxclLFkbCsJZ0GcVrGtnelzHa5bi1XmNDRy82j+GZ92M4RNbp/uCsWoBz4CN2ZUmKifZ2/RczTN@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ua9HKKTSDF2fW+aH6rSMG6mUDi5toAcQlB764xjhIEwe08Hzt
	AdpabP+I40NOk0Ygc2Tq2arBXeYUl+BwYjraU/J4HXvx3+JnxTqSY5LuK+98SRMCRuOE5vswYFF
	e5cwswHc8QvCRzGvKbnODmeZptdwSEClXN8ynxNruAYsEhIaLPFCssfakEgDP82RPa3CXZorm
X-Gm-Gg: AYBFou0ol+x9oFlyTM8czHtkYmYpuJycMX1sgpmBnO0XulCl08h/gK7XkEbWvp8uhvo
	gj9Gx9S7GD4zORjjO98XA9aoBFijcFCbAvmDk8UMg+eU+2Ro565fL56UU9yCWFnEeHgOune3HSs
	gnk6kHlbcHhgZqX9W2wwasBRVpVa/lkY9XmCjIEcQ8mI6i6djI7hHKXFDOMtVTcw545br7zLWPh
	DzF/0KwMyypSgYyNNveZ55schf2H3hFtkE56lb7Hc9iIytQHEV/3vQ7WKNwem8/yy8wMmASUxKK
	O9Q6Jg1OKXuupb0dele57CZTpNgB5JICVE+hGsPSA7iJAhGmNaLIKtRBrgQWne+7HMYqjASnzww
	1D2dkLT6/mGDK0GoV9Lvix9gwtSjpV357d19uRTrjz7YA17RsJ7Df6+wH321UC+XY7/0YgfC5cS
	W2dnPgMvTRzb1Zhp5sRkd9JLfGdXfWkxPxEXs2008O6IboKBn5cF386m2bXAXh3/z8ISwMh/uBd
	g==
X-Received: by 2002:a05:7301:7c0b:b0:370:7fee:497f with SMTP id 5a478bee46e88-370f8269e21mr1593321eec.26.1794019187432;
        Fri, 06 Nov 2026 18:39:47 -0800 (PST)
X-Received: by 2002:a05:7301:7c0b:b0:370:7fee:497f with SMTP id 5a478bee46e88-370f8269e21mr1593255eec.26.1794019186655;
        Fri, 06 Nov 2026 18:39:46 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm11069040eec.29.2026.11.06.18.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:39:46 -0800 (PST)
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
Subject: [PATCH v8 2/8] riscv: Add breakpoint and watchpoint test for riscv
Date: Sat,  7 Nov 2026 08:09:11 +0530
Message-ID: <20261107023917.40606-3-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-GUID: 2xOAmv4vLfn_h2bAt0a6ZCgtjZSjcOYQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX7M3uIxiKkN4M
 oIVGxm1aK/FTPJzqpYCugqXhemMF2p9sz9zvVyt1vuYHx1FTgPHJgXG3Wxr9ePa8i0wuUwxtCqJ
 ixoyBsyr8WkeZ1pCb/6479eqRUMIUUIHi6pgSA0jRe68AfJbL3c3XYxvy7bkjeHu2WnjUsgdeXY
 3+hlBQqrK1wZAZ1VZ2+/S8o3PMarDreEUkIjc5vm8zX9qAC+q5zpOuRs/0emjEZuyHfA9bbj464
 gDyrPjJHxpkXlT0KbWHnU7JdQWNkYWkhSmpk58NVZVgSYMQPzC8QGZ1Aw1oCNy1luMSC4notGRi
 VfcNtGCjhdGwik2OdHoQie4ZKw0Japx1Ww5Hj1yUjbeD0KyTNwRbm0G5cI+gGtIH1YQ1+mu+hxo
 O2cHEAlEtxYZU0zQbRzmr4fl1zzqaem/V0Lpx8v3FJdULyA+zpz8pu0mKbJ0ZrZBYGh55zXeIwJ
 xQXgLrmD0a3Nfgw521w==
X-Proofpoint-ORIG-GUID: 2xOAmv4vLfn_h2bAt0a6ZCgtjZSjcOYQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfXyCYN3GLjBG7x
 YTv/ek6JO50zOkUppQx/THKXpgUjbEE2YVbiH82ox4Ui9rmgWhlmBaoxrPb/hRVnvIkNvbNGAlF
 3mBTXXJ7QhsUjqK3DQHv5hckN1kCtPc=
X-Authority-Analysis: v=2.4 cv=JtBkP84C c=1 sm=1 tr=0 ts=6aee8f74 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=2Ls8_GQA_paks6FoIQwA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070010

Add self test for riscv architecture. It uses ptrace to ptrace framework
to set/unset break/watchpoint and uses signals to check triggers.

Also add $(KHDR_INCLUDES) to CFLAGS for the riscv test build so the
UAPI headers exercised by the test can be located during compilation.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/breakpoints/Makefile  |   8 +
 .../breakpoints/breakpoint_test_riscv.c       | 215 ++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_riscv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 73b69e8dcba1..baf97e8c39f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24171,6 +24171,7 @@ F:	arch/riscv/include/asm/perf_event.h
 F:	arch/riscv/kernel/hw_breakpoint.c
 F:	arch/riscv/kernel/perf_*
 F:	drivers/perf/
+F:	tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
 
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@kernel.org>
diff --git a/tools/testing/selftests/breakpoints/Makefile b/tools/testing/selftests/breakpoints/Makefile
index 0b8f5acf7c78..1f28f50e8f85 100644
--- a/tools/testing/selftests/breakpoints/Makefile
+++ b/tools/testing/selftests/breakpoints/Makefile
@@ -12,5 +12,13 @@ ifneq (,$(filter $(ARCH),aarch64 arm64))
 TEST_GEN_PROGS += breakpoint_test_arm64
 endif
 
+ifneq (,$(filter $(ARCH),riscv riscv64))
+TEST_GEN_PROGS += breakpoint_test_riscv
+endif
+
 include ../lib.mk
 
+ifneq (,$(filter $(ARCH),riscv riscv64))
+$(OUTPUT)/breakpoint_test_riscv: CFLAGS += -static $(KHDR_INCLUDES)
+endif
+
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
new file mode 100644
index 000000000000..a8a94a788142
--- /dev/null
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_riscv.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Qualcomm Technologies, Inc.
+ *
+ * Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
+ */
+
+#define _GNU_SOURCE
+#include <linux/perf_event.h>    /* Definition of PERF_* constants */
+#include <linux/hw_breakpoint.h> /* Definition of HW_* constants */
+#include <sys/syscall.h>         /* Definition of SYS_* constants */
+#include <unistd.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <time.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <semaphore.h>
+#include <errno.h>
+
+static int gfd;
+sem_t ib_mtx, wp_mtx;
+static int bp_triggered, wp_triggered;
+static int test_func_sink;
+static const int wait_timeout_sec = 5;
+
+int setup_bp(bool is_x, void *addr, int sig)
+{
+	struct perf_event_attr pe;
+	int fd;
+
+	memset(&pe, 0, sizeof(struct perf_event_attr));
+	pe.type = PERF_TYPE_BREAKPOINT;
+	pe.size = sizeof(struct perf_event_attr);
+
+	pe.config = 0;
+	pe.bp_type = is_x ? HW_BREAKPOINT_X : HW_BREAKPOINT_W;
+	pe.bp_addr = (unsigned long)addr;
+	pe.bp_len = sizeof(long);
+
+	pe.sample_period = 1;
+	pe.sample_type = PERF_SAMPLE_IP;
+	pe.wakeup_events = 1;
+
+	pe.disabled = 1;
+	pe.exclude_kernel = 1;
+	pe.exclude_hv = 1;
+
+	fd = syscall(SYS_perf_event_open, &pe, 0, -1, -1, 0);
+	if (fd < 0) {
+		printf("Failed to open event: %llx\n", pe.config);
+		return -1;
+	}
+
+	fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
+	fcntl(fd, F_SETSIG, sig);
+	fcntl(fd, F_SETOWN, getpid());
+
+	ioctl(fd, PERF_EVENT_IOC_RESET, 0);
+
+	return fd;
+}
+
+static void sig_handler_bp(int signum, siginfo_t *oh, void *uc)
+{
+	int ret;
+
+	bp_triggered++;
+
+	printf("Breakpoint triggered!\n");
+	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
+	ret = sem_post(&ib_mtx);
+	if (ret) {
+		printf("Failed to report BP success\n");
+		return;
+	}
+}
+
+static void sig_handler_wp(int signum, siginfo_t *oh, void *uc)
+{
+	int ret;
+
+	printf("Watchpoint triggered!\n");
+	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
+	wp_triggered++;
+
+	ret = sem_post(&wp_mtx);
+
+	if (ret) {
+		printf("Failed to report WP success\n");
+		return;
+	}
+}
+
+/*
+ * Keep a real instruction address for HW execute breakpoints: prevent inlining
+ * and force a visible side effect so the function can't be optimized away.
+ */
+static __attribute_noinline__ void test_func(void)
+{
+	test_func_sink++;
+	__asm__ __volatile__("" : : "g" (test_func_sink));
+}
+
+static int trigger_bp(void)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(struct sigaction));
+	sa.sa_sigaction = (void *)sig_handler_bp;
+	sa.sa_flags = SA_SIGINFO;
+
+	if (sigaction(SIGIO, &sa, NULL) < 0) {
+		printf("Failed to setup signal handler\n");
+		return -1;
+	}
+
+	gfd = setup_bp(1, test_func, SIGIO);
+
+	if (gfd < 0) {
+		printf("Failed to setup breakpoint.\n");
+		return -1;
+	}
+
+	ioctl(gfd, PERF_EVENT_IOC_ENABLE, 0);
+
+	test_func();
+
+	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
+
+	close(gfd);
+
+	return 0;
+}
+
+static int trigger_wp(void)
+{
+	struct sigaction sa;
+	unsigned long test_data;
+
+	memset(&sa, 0, sizeof(struct sigaction));
+	sa.sa_sigaction = (void *)sig_handler_wp;
+	sa.sa_flags = SA_SIGINFO;
+
+	if (sigaction(SIGUSR1, &sa, NULL) < 0) {
+		printf("Failed to setup signal handler\n");
+		return -1;
+	}
+
+	gfd = setup_bp(0, &test_data, SIGUSR1);
+
+	if (gfd < 0) {
+		printf("Failed to setup watchpoint\n");
+		return -1;
+	}
+
+	ioctl(gfd, PERF_EVENT_IOC_ENABLE, 0);
+	test_data = 0xdeadbeef;
+	ioctl(gfd, PERF_EVENT_IOC_DISABLE, 0);
+
+	return 0;
+}
+
+static int wait_event(sem_t *sem, const char *name)
+{
+	struct timespec ts;
+
+	if (clock_gettime(CLOCK_REALTIME, &ts)) {
+		printf("%s: Failed to get current time\n", name);
+		return -1;
+	}
+
+	/*
+	 * Deadlock fix: avoid blocking forever on sem_wait() if the breakpoint/
+	 * watchpoint signal never arrives. Use a bounded wait and fail the test
+	 * on timeout instead.
+	 */
+	ts.tv_sec += wait_timeout_sec;
+	if (!sem_timedwait(sem, &ts))
+		return 0;
+
+	if (errno == ETIMEDOUT)
+		printf("%s: Timed out waiting for event\n", name);
+	else
+		printf("%s: sem_timedwait() failed with %d\n", name, errno);
+
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	sem_init(&ib_mtx, 0, 0);
+	if (trigger_bp() < 0)
+		return -1;
+	if (wait_event(&ib_mtx, "Breakpoint") < 0)
+		return -1;
+
+	if (bp_triggered)
+		printf("Breakpoint test passed!\n");
+
+	sem_init(&wp_mtx, 0, 0);
+	if (trigger_wp() < 0)
+		return -1;
+	if (wait_event(&wp_mtx, "Watchpoint") < 0)
+		return -1;
+
+	if (wp_triggered)
+		printf("Watchpoint test passed!\n");
+
+	return 0;
+}
-- 
2.43.0

