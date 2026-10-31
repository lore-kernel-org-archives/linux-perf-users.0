Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.181.50.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448156;
	b=C8R7vh7sygmxlrG8fjAUBfuY7M52z3r2KZBXuZW+dPGY2vTvRg3ALiUPi7avunAWwIHB
	 JygF2fXaRIrjDKDe8IHjGND5YuWmVU4DkElppREzH2lN25Yca2EIn6Qn/EPz5Ybpu1iup
	 ZhcyQTxaz6J5DtXHUnczH8mh2ixi52GhzW7uveHIYs6RJ1/EWSQSK3irjFDkWFYxbSLBS
	 UAu1+UbUffV00kT0xU3oP167vVti4HruMwL3Zkc2t6+wxfBXS9PQJVx9Lh6BdvuFe2Qa4
	 Uow97ateV6/E2x7h0jeuKjG2WZHp+AUlecsqW/mzxVtVnmbGh0DyZ6PGk79jKlOufqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448156;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=gKxXDM14wcc86nPpzfqS73oHmizbz1JW1PsWVuZdSds=;
	b=wODJ7Ibg/gEXORaZwbAxlS+o8qZhDrpio5Qrx5bCzz/Sczm+bfhZ6OHq288MsVQfkS07
	 mnVW86249uZxB8JhcHJp4uk+7Xkpcohpv19sqZcy0hbUelO6h/cEtbCK+c11NMr1PIJvt
	 cAuwQjHriElnNWI+cIe76mC5tpcxabCpQqh5xeBSfA27LHR/m8pTjTnLm4ADzt3n+VTCe
	 HtULETbQjckAGFwY55aNZEdiALfIHtCxPIRLzj2siZA8COOTAhdpJuzIZ/fSfvbYruUCU
	 BLFsZ8Rdcry7PVGtK5bke3SDOPIr/YoIWRR6Zqi8mrsgwopkL/xAAj9CvNUEoQrBCHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=VVGV4UWC;
	arc=none smtp.remote-ip=220.181.50.185
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A6EFF606A31A;
	Sat, 31 Oct 2026 12:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6EFF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=VVGV4UWC
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, Leo Yan <leo.yan@linux.dev>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf kvm: Fix arm64 VM-exit duration accounting
Date: Sat, 31 Oct 2026 20:01:23 +0800
Message-ID: <20261031120123.2312-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793448145;
	bh=gKxXDM14wcc86nPpzfqS73oHmizbz1JW1PsWVuZdSds=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=VVGV4UWCXBYnc6K908P7Asq52KjzNV8kmof4Dws+2q8rbFd1w7YEEMzpr7unNbKBx
	 ezzCFXzry32eSrma0Rdc8/EEK66jSX1psdwLgwvUf+B1geJmpMFtXR1teLsZcJ5KpC
	 Sr6z9KZcjKYHfV0nxr3tEq/p3lCday8kowGi5+rtB/0r4qy1l3SC5rjl6ixHQ4TT6K
	 Ed0+ot/WONJEwMQ37r7AqD+pga4Qt40srxDgaYxM770RwqXWi3Ckoo0SbU/rmkRFGR
	 IVpgRpO6WEOJofq24+jIkskWztuHqhmJJI4yf+xcKS6je+KdUdkaTYhGfnn7TDpUgf
	 74m9WoflFHTvA==

From: Li RongQing <lirongqing@baidu.com>

Use kvm_exit as the start event and the following kvm_entry as the
end event for arm64 VM-exit statistics. Keep decoding ret and esr_ec
from the exit sample.

Before this change, arm64 measured guest runtime as VM-exit time.

Fixes: 1218838d68f5 ("perf kvm: Add kvm-stat for arm64")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
index 018b0db..ff853ef 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
@@ -36,13 +36,7 @@ static void event_get_key(struct perf_sample *sample,
 }
 
 static bool event_begin(struct perf_sample *sample,
-			struct event_key *key __maybe_unused)
-{
-	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_AARCH64));
-}
-
-static bool event_end(struct perf_sample *sample,
-		      struct event_key *key)
+			struct event_key *key)
 {
 	if (evsel__name_is(sample->evsel, kvm_exit_trace(EM_AARCH64))) {
 		event_get_key(sample, key);
@@ -51,6 +45,12 @@ static bool event_end(struct perf_sample *sample,
 	return false;
 }
 
+static bool event_end(struct perf_sample *sample,
+		      struct event_key *key __maybe_unused)
+{
+	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_AARCH64));
+}
+
 static const struct kvm_events_ops exit_events = {
 	.is_begin_event = event_begin,
 	.is_end_event	= event_end,
-- 
2.9.4

