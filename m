Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.181.50.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611120;
	b=MFHgCOIybdMfoDREYz+SYRvsdKHfQzaU4hhzzGc2TsKoRmPXUwMjVm11cOc9WYH3IF1t
	 EyTHbwJxQPbfD3j2bqr54grsoAYuLs9HmP+IMVT1xisnTq/NcIpPtN1MSlD2bjA0g8RHd
	 Q0NBlwXb15NFfs+igREx+qJ6+Dw1h3nFCLH0RERHH1ud6PIsYVUGl6J0IPrY+qWTCvS49
	 U1EOxyC5qPWJuA+3rjSaHaqRVOUx1IGdnLIG+zDJlUsc4pPRkuJkJQ7aLqyzI3Kr5JGJy
	 bw/nSaSpSu59MZvKaHeHhRj2RHLTawJCKQLEpg/MMpXVYwXlt8VsjvxwH6jhA22DE+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611120;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=XcbRLYGB82m3MgaPiEO3IYAwJ6GpxW8GbWCS3Wtb9Xo=;
	b=OY9eC122TzpTL3Z12qTyBvsUKdYJzux9xqO21AXC14kcnvHKQd23cT9iwWchSWLO4qK0
	 QFSPTnb3K34hfsAKZ/WycD+UmXuzALRGNORWYaq+muFPW7NK4wVqPlGHZW/rWgvjEqW2B
	 vyWUIpoq1n/HyMNX9FWTu+zigj0YgPQjCAVfh+5Nj++rkfpj+vE9ZlxwZOzQSYHciWnHY
	 TB6zKGTP49xxU7TcKprg3vWK5XI4lbudxAoUFJ+fIYN1cX3r97+g/G8VQEKpAUJJtr2l6
	 /ffsJ/ggEQRfDEgAgZxvkQsTob/G/El5Gc5d0Re4CLYXryhdBNi9WjralkeI4zd4ggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=PTzjI6Yc;
	arc=none smtp.remote-ip=220.181.50.185
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 03FEC606A326;
	Mon,  2 Nov 2026 09:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03FEC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=PTzjI6Yc
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Li RongQing <lirongqing@baidu.com>, Atish Patra
	<atishp@rivosinc.com>, Anup Patel <anup@brainfault.org>, Shenlin Liang
	<liangshenlin@eswincomputing.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH] perf kvm: Fix RISC-V VM-exit duration accounting
Date: Mon, 2 Nov 2026 17:18:09 +0800
Message-ID: <20261102091809.2215-1-lirongqing@baidu.com>
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
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793611108;
	bh=XcbRLYGB82m3MgaPiEO3IYAwJ6GpxW8GbWCS3Wtb9Xo=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=PTzjI6YcIneIl1tRREGTk2ZIzFO5J92jC9mJFjLOfjkucfnleKxuOmUXFg25MG/8s
	 k70lmraZJt9yU8NyVoX+EFDlhL5uw3I4kwsb/GX9NKqV7J9yYad2P2WqMZuJNinkRY
	 qiDzTAwSrbFCiYstQRANrj8hZ6Jf0JP6SGGhlLxRafXli0vxEXhaspicTTMY+J9Udk
	 7e7kKE8Wu5MwcSc+0Exkhhi8FDVIjv57UansihXsOHHsiUkexpfP1VwMYQyr9Ik8Og
	 Tv1oeGpL7hAmLfbbUmBhueY+jN3yMQ0Ae2vUvOjNzlGvmaT2UWjY4AaZcjFpYgSyd0
	 8XViBWC25ljhw==

From: Li RongQing <lirongqing@baidu.com>

Use kvm_exit as the start event and the following kvm_entry as the
end event for RISC-V VM-exit statistics. Keep decoding scause from
the exit sample.

Before this change, RISC-V measured guest runtime as VM-exit time.

Fixes: da7b1b525e97 ("perf kvm/riscv: Port perf kvm stat to RISC-V")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
index 967bba2..09c9c7d 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
@@ -31,13 +31,7 @@ static void event_get_key(struct perf_sample *sample,
 }
 
 static bool event_begin(struct perf_sample *sample,
-			struct event_key *key __maybe_unused)
-{
-	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_RISCV));
-}
-
-static bool event_end(struct perf_sample *sample,
-		      struct event_key *key)
+			struct event_key *key)
 {
 	if (evsel__name_is(sample->evsel, kvm_exit_trace(EM_RISCV))) {
 		event_get_key(sample, key);
@@ -46,6 +40,12 @@ static bool event_end(struct perf_sample *sample,
 	return false;
 }
 
+static bool event_end(struct perf_sample *sample,
+		      struct event_key *key __maybe_unused)
+{
+	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_RISCV));
+}
+
 static const struct kvm_events_ops exit_events = {
 	.is_begin_event = event_begin,
 	.is_end_event	= event_end,
-- 
2.9.4

