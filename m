Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636238333F;
	Sun, 13 Sep 2026 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270041; cv=none; b=PxYzjnE9S5gjKZ36YBeK1FoXqN05nt69m2OVp1AwG4W5Kiese3SZOOuRWHEC/gE2lWa9+xfMD2bTq8VJi/8G8C2xI+WSYTKzOGN81yFeT/ka+ypkks+Fwkf1omll6hS8gz6vDidIDF91ZHa82ERBBTxxRkxSrvabGl2RuVZWZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270041; c=relaxed/simple;
	bh=apH6VZyAnmLAyezMqL9Ah7ks15w3tPV5R2LG2bJnac0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgKkrgPRK1oCQ4uqwRMqUfyZTLlRoSQ+eJOSApv2RR0+0GEeJRrnLpMAV3T5V4+dyIEtS97jv9rI8Gh57OG3+4RElbVB20grQ/pSkceunAqs1+yJLFDvOobPTqnr1wbjS907a2goXKVRd6rGvbkvVen9fq91lJBz7Wj2oN2wrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1gXYsPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1gXYsPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C85F1F000FF;
	Sun, 13 Sep 2026 03:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270039;
	bh=TqR2Opoff9JKJPpDA+/gIuMlr5T0eNpJWAK21U2cxek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1gXYsPPUkIF52bm65CNMDA7iIV4hvpxjMEKYiHgEMjRjt9YKKmCU7akLv2SG6goL
	 OeET67aRh3UZ/DvCN3rIc405TqOreB6cpOr5yuaoVLzm4BooMqGBAgoDmateU0uwIW
	 nKwncE56EM1dxxnBZMx1dApy3krYGHE004c7e5OU3nKWjVX5ZJbD3fSSxoapOOoXx9
	 74wff8xJNWN6M9G1kq7XQBzwLgsFB/dtxeaXee4Bz0XQdg1JSvUUeLXMRn7gp+tlAP
	 LlummIDo+YpCWRJtfGB/hqY7GXjaMhZ3gF+Tm2CeungcgJC/9DcHl35Hc4UkHF/yhc
	 L7T61kyH2wWZA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 8/8] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Sun, 13 Sep 2026 00:26:28 -0300
Message-ID: <20260913032632.116277-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913032632.116277-1-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data-type profiling per-sample stream keys cross-CPU contention on
sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
CPU info" sentinel, documented as such in perf_session__deliver_event(),
and same-instance reads and writes from different cores are
indistinguishable from same-CPU traffic, so pahole's false-sharing
detector cannot tell them apart.

builtin-record.c already defines --sample-cpu and 'perf mem record'
forwards unknown options to the record parser, so passing it explicitly
works today; make it the default, next to the -d (addr) and -W (weight)
the command already requests, documenting it in perf-mem(1).

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 4 ++++
 tools/perf/builtin-mem.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 4d164836d0943119..fe51c5e3333dc4a0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -14,6 +14,10 @@ DESCRIPTION
 -----------
 "perf mem record" runs a command and gathers memory operation data
 from it, into perf.data. Perf record options are accepted and are passed through.
+It also requests the address (-d), the weight (-W, where supported) and the
+CPU id (--sample-cpu) of every sampled access by default; the CPU id is what
+lets per-sample analysis tell reads and writes to the same data from
+different cores apart from same-CPU traffic.
 
 "perf mem report" displays the result. It invokes perf report with the
 right set of options to display a memory access profile. By default, loads
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 6101a26b3a781e69..a708e2549bae4ce7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -135,6 +135,15 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	rec_argv[i++] = "-d";
 
+	/*
+	 * The data-type profiling per-sample stream keys cross-CPU
+	 * contention on sample->cpu (PERF_SAMPLE_CPU); without it the cpu
+	 * field is the (u32)-1 'no CPU info' sentinel and same-instance
+	 * reads and writes from different cores are indistinguishable
+	 * from same-CPU traffic.
+	 */
+	rec_argv[i++] = "--sample-cpu";
+
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-- 
2.55.0

