Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122776;
	b=Box4JAI4nzYF0xocrIEhcw7C9ODrJh6osKW9gor55+bVP9pJn6UVfoZPNyLajdjajLLG
	 SVDGoNp9ouGknHjGCWmEtffdYbznHCTiHtW22N1Zx2lS07AI79J7fC7IG49zS9AXuecGK
	 hwyNliApMy//DsHSGmhs8QOhFDAWNygvowO9IfT8D7shRYgsjAEuWQVYGsmR6+pAdPh0N
	 Yox3VQUM5/WsxOyJPk/73DIxuxYY/qyP4WWIL5bTnjIx1iphUBgoEvqFST84uvnUrQAmM
	 LGquli5CseHqloHQNn9b/pq7aqfL9vWMRE/0LyZCc1nFgLGEeB/m9XyFaUKji39yTAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122776;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0rj8aNlRTuSxfRGPYit8bnUu7xqxVCkNmfnsVMROY7k=;
	b=jP8r1gNpJ9eRCuN8ErOlWwGusvT5uPbPgDTcHQzlHNU2koMw8S5Nhk/vKl7vUsh5NQVB
	 iO9NPWOx0MSg3uIBCWpgAGZhO6b7AHqEfHJmBj/oqiytexqDzeFmYuoQ1jKDoxuOeysTN
	 L4HHmigAVmJgf8h1S2GOZJVekB3DZ7N3cBj3ff6P+SvFPBurkx2o+TQm3JcJyhUoyDV2O
	 7/DC4djV+KowCvjLLzwqnA2IoXbJuWMjSkeQ2TSLE9XXtPFFZwmIG+4uX84S3OuEAG6Ws
	 jvYWpbP0zQxk4NUqB/grfm+DKfToKrfxvX792u80DpTihMcRJdg2Fs8HRGC7g/oa2Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c7QnrtHM;
	arc=none smtp.remote-ip=95.215.58.141
Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862660A2620
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 21:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D862660A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c7QnrtHM
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KJ8Xuzkuur/Mtlz2jvvLp3177Z50iWSACGW1WctvTBo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795122774; v=1; x=1795727574;
 b=c7QnrtHM/UPNO1wJ8NOHqAxKxhIl5yV/Ps/c+qQs+NfF28BH/udzCt2v4oo/yeURR7rPRGef
 FzmFwCELLmWIp1uDY4zwl3rdIU9JnWdOrbOFwjrnypyXQAJttsfiqdZmWanusC3vWcdYkFYGqGx
 ppOa+gfo+rifIu7u/ycOhWuM=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ca55b60b1c17543b;
	Thu, 19 Nov 2026 21:12:54 +0000
X-Mizu-Trace-ID: ca55b60b1c17543b
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rkeilty@meta.com,
	atish.patra@linux.dev,
	dgreid@meta.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] perf/core: Don't let BPF programs read an uninitialized sample address
Date: Thu, 19 Nov 2026 13:10:45 -0800
Message-ID: <20261119211235.99805-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119211235.99805-1-usama.arif@linux.dev>
References: <20261119211235.99805-1-usama.arif@linux.dev>
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

A BPF program attached to a perf event gets a struct
bpf_perf_event_data, and reading its addr field turns into a load from
the perf_sample_data the sample is being assembled in. The verifier
allows that load no matter which fields the event samples.

perf_sample_data_init() used to store the address unconditionally, so
the program read 0 when there was none. To touch fewer cachelines, it
now stores the address only when it is non-zero, and
perf_prepare_sample() fills it in only when the event samples it
(PERF_SAMPLE_ADDR, PHYS_ADDR or DATA_PAGE_SIZE). For all other events,
including context switches, cpu-clock and hardware counters like
cycles, the program reads whatever was left in that stack slot, often a
kernel pointer.

Kernels built with CONFIG_INIT_STACK_ALL_ZERO, the default when the
compiler supports it, mostly hide this by clearing the struct on
function entry. With INIT_STACK_ALL_PATTERN the program reads the fill
pattern instead.

Clear the address before running the program if nobody filled it in,
the same way the SIGTRAP path already checks PERF_SAMPLE_ADDR before
using it. Events without a BPF program are not affected.

Fixes: 7b0846301531 ("perf: Use sample_flags for addr")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1c1ffd103c74a0..57ea7e3c01a025 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10819,6 +10819,9 @@ static int bpf_overflow_handler(struct perf_event *event,
 	prog = READ_ONCE(event->prog);
 	if (prog) {
 		perf_prepare_sample(data, event, regs);
+		/* bpf_perf_event_data::addr is readable without PERF_SAMPLE_ADDR */
+		if (!(data->sample_flags & PERF_SAMPLE_ADDR))
+			data->addr = 0;
 		ret = bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
-- 
2.53.1-Meta

