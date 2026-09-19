Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32552E0B5C;
	Sat, 19 Sep 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850471; cv=none; b=CgTu/I5nxr6gw1Jv8Gg03iMBTB2wxFQCrMsznPX/xl2tKgKpBK4wSTwKC5M+BY3CuwD9I05TznRmW+211TMbCtQqp7p7sahqU+ksJIkSa3lovh5FsAoYo75FOAnLj09F0RgxfhYGvpuQHj08v4ZxLX+ZZixTPmBb6xjXBEMnAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850471; c=relaxed/simple;
	bh=MGTXjif7xTswKs0E+znM0wCKYAnwpLrgIKOtWM0szIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LalIBAIl16OCWdhbCDHiq/wNYR8aNQPQ530qDqJ1+CrBJvdTPKMWms3mkaiJZryz24TT/fa28SPWE+LPv1h59y+pHO8JZzayPsGLa1Mh5QKXHA4KBQdpnqXKGHSPDKxb8/B3VTftwWQ/CPG7DBNil+ixUovvRHVQ7rHqkT1/ZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHTTZZF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHTTZZF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91111F000FF;
	Sat, 19 Sep 2026 20:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850469;
	bh=BncCxjTiKQVF3SwqHJrsuzqMd2UO7T1iZGDHgAE23rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHTTZZF6alGZ45oWmpcwo/8UFjTlCvKo4ad75bP8Rh5/eLULb7SLIps1JFm6X1VNK
	 SggjTrd1CxrjvqxFJOj7oiEGb7rPBbrbZ4wJ59WVjFF0EvPk/xxV47l71J4TFGAWWr
	 vRlZ9YEVNnxVcgWLwqyvb9PKXSetSfn4s1BcEJY7LJGZyuOVICY9myGUDVZtY/6/bS
	 VBQlfKxFm2redONz1uRCb0ihTV9pACAlcLeViXWIlhge3WWuEnt0ASNvfaI2wbM3oW
	 0b+UF7He0st/p5DRnpRMaGgvdS/tcB3TrQpvQwtC6kMi4kz9tCRYZxOUPVSeD17YvP
	 dvlvjcXErGllA==
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
Subject: [PATCH 6/7] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Sat, 19 Sep 2026 17:40:26 -0300
Message-ID: <20260919204027.8504-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260919204027.8504-1-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data type profiling per-sample stream keys cross-CPU contention on
sample->cpu; without PERF_SAMPLE_CPU that field is the (u32)-1 "no CPU
info" sentinel, so same-instance accesses from different cores are
indistinguishable from same-CPU traffic.  'perf mem record' already
passes -d (addr) and -W (weight) explicitly to the record parser, add
--sample-cpu as well and document it in perf-mem(1).

The rec_argv array only had room for nine arguments per PMU plus the
user arguments, not counting the up to eight __cmd_record() adds itself,
which a new argument would overflow on PMUs with separate load and store
events; reserve space for the fixed arguments too.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt |  4 ++++
 tools/perf/builtin-mem.c              | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 6101a26b3a781e69..f25592bc52728655 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -99,8 +99,8 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 	argc = parse_options(argc, argv, options, record_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	/* Max number of arguments multiplied by number of PMUs that can support them. */
-	rec_argc = argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
+	/* Max number of arguments per PMU plus the fixed ones added below. */
+	rec_argc = argc + 8 + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
 
 	if (mem->cpu_list)
 		rec_argc += 2;
@@ -135,6 +135,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	rec_argv[i++] = "-d";
 
+	/*
+	 * The data type profiling per-sample stream keys cross-CPU contention
+	 * on sample->cpu; without PERF_SAMPLE_CPU it is the (u32)-1 'no CPU
+	 * info' sentinel.
+	 */
+	rec_argv[i++] = "--sample-cpu";
+
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-- 
2.53.0

