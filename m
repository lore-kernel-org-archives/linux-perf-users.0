Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7EDE556
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253498; cv=none; b=OV33QVNwZH7F89Da8go49ru4mJ8Wmly8XsZ8X+JcBopRR/R1WQ8PiiARyONb7kjCDlK0OwmPw7jF7K+xlgBPOIEUvBwihmKJ6TwTLRXAbf9+lzwJ6MBeO0LHKReFs/dzKR+pFWwZT7c5eZ38liPSJTDvRKJTY04fOsOiNy/aEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253498; c=relaxed/simple;
	bh=NLbFF4wpLQqt64smYdSlaSLO+obgcomAoDAU3uN1XUA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A1MNsl39YS27MwEnvEppl9wn5VjKsX4YCKRhj6j0CKMRDDwTCVMvdb8XpiF/jIvsS0DPdY8YnaAATo9GetJRp2jHN8WLdVpym4PcQjJ1yy7UkjFQWHpqD/IC0LRx9P2wOop+TEimJO9uZ0MVpH4xpbnouenp7C5tgbYHM2uMCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jWRcA1W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jWRcA1W"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9675ae5aso207855977b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 May 2024 18:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253495; x=1716858295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPhSRWInrCDvmRK05i6c8rW1j8fIs+rTeSWmpel6vAA=;
        b=3jWRcA1WDUWvyXnConPHJx9JHeAoWbqnC9Y1KmocYF+EmNBOfn4SZ39jx047U89Gbj
         4lqK3HRRjSxT4nPUPUuhnVzbIPFYRqd6vTfVfCbNfSQ/8eyPCTug70M+/Aeplbd/ehj2
         qkPR1St11IjbNq01DtTheGcqYPPfac+7G2r8BayVxer7UkCcnpBcyFnjUs9/KzO6DHqu
         k9MKMVbwTMNXTdR9cQEMdHURd2AnWLgA8Ql6duK6oIqm9ERPNJE28+iX3Svs8ShrDU3+
         eW8VU7G3ISy2MZdINDpn7fldcEHc4Cb8m6EBSjJgDr6Ltbm44MZoXcJTYXuPMmIbwJA7
         ja3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253495; x=1716858295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPhSRWInrCDvmRK05i6c8rW1j8fIs+rTeSWmpel6vAA=;
        b=Cbkqefi6u1X72OSBqiSCsDg/P7GidvkCn+gYzDsMnHq2Uur+dGdi72VyGTx3H27uG4
         zWOdzx127y2jgzGf0vyEEL86FNMK9Plve5BEAdB5lHr+FeFAxp8wFJ4S41MxqTxfgBTt
         Lo5MU9BaR55T/p28b674JL78iqVyCJT8tAiaxr24Aat61JwnN0R9yCVWYxJVHpPETbgq
         219t1OyaFufpV+aaG5IvAtAtwwUG/mW8+DZSM4lmI+GchnM3xP0dbpi92i0xcpnITRcL
         0KLB8iOL84SyymvSaBRTbA7ggQ6LWaQJl5zkUYT70twfIlwIqCDTacVcX5nv1uQf3ycN
         RkNA==
X-Forwarded-Encrypted: i=1; AJvYcCUYmrZer9bmS8zMnIqjL3knjKtGoG6l4wrxJIWeyIkAbyVoqO5AhUrwVRad8WKWds98dtrcpKe8i9dIpQ1qiIjWeYaFC4UCsZMXlLJCkXNNAw==
X-Gm-Message-State: AOJu0YxfEVXUNg9vo8D4XvRTSnder5i6OR8tlL/a0LebVw4b12PqEjYj
	YAjUguFsmJahe/jDK6SXYNubFClmkatJiP1pMPJb8/wujfppXuycjnqHuuuzj3H2g5wNmvUCnkC
	yIgfukw==
X-Google-Smtp-Source: AGHT+IHLfOoCMImGs7w7lqZWNgQwsLGxz8Z7RCiXrdTaUAEQA/bv4s4AKRtMBPsJ8ZKc+n6Evf9N3mll9Wf0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:690c:b9d:b0:61b:ec24:a014 with SMTP id
 00721157ae682-622afd6d351mr70898027b3.0.1716253495438; Mon, 20 May 2024
 18:04:55 -0700 (PDT)
Date: Mon, 20 May 2024 18:04:38 -0700
In-Reply-To: <20240521010439.321264-1-irogers@google.com>
Message-Id: <20240521010439.321264-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521010439.321264-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2 2/3] perf bpf filter: Add uid and gid terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the BPF filter to use the uid and gid terms determined by the
bpf_get_current_uid_gid BPF helper. For example, the following will
record the cpu-clock event system wide discarding samples that don't
belong to the current user.

$ perf record -e cpu-clock --filter "uid == $(id -u)" -a sleep 0.1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     | 2 +-
 tools/perf/util/bpf-filter.c                 | 5 +++++
 tools/perf/util/bpf-filter.l                 | 2 ++
 tools/perf/util/bpf_skel/sample-filter.h     | 3 +++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..059bc40c5ee1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -200,7 +200,7 @@ OPTIONS
 	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
 	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
 	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
-	  mem_dtlb, mem_blk, mem_hops
+	  mem_dtlb, mem_blk, mem_hops, uid, gid
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index f10148623a8e..04f98b6bb291 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -63,6 +63,11 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
 		return 0;
 
+	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
+		/* Not dependent on the sample_type as computed from a BPF helper. */
+		return 0;
+	}
+
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
 
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 62c959813466..2a7c839f3fae 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -95,6 +95,8 @@ mem_lock	{ return sample_part(PBF_TERM_DATA_SRC, 5); }
 mem_dtlb	{ return sample_part(PBF_TERM_DATA_SRC, 6); }
 mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
 mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
+uid		{ return sample(PBF_TERM_UID); }
+gid		{ return sample(PBF_TERM_GID); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 31bfab7e8d6c..dd98bd1a2669 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -49,6 +49,9 @@ enum perf_bpf_filter_term {
 	PBF_TERM_CODE_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 23, /* SAMPLE_CODE_PAGE_SIZE = 1U << 23 */
 	PBF_TERM_WEIGHT_STRUCT	= PBF_TERM_SAMPLE_START + 24, /* SAMPLE_WEIGHT_STRUCT = 1U << 24 */
 	PBF_TERM_SAMPLE_END	= PBF_TERM_WEIGHT_STRUCT,
+	/* Terms computed from BPF helpers. */
+	PBF_TERM_UID,
+	PBF_TERM_GID,
 };
 
 #define BUILD_CHECK_SAMPLE(x)					\
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 7bcf0c3de292..1fc319ec5e3f 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -121,6 +121,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
 	case PBF_TERM_NONE:
 	case __PBF_UNUSED_TERM4:
 	case __PBF_UNUSED_TERM5:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

