Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9303D386
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uT7w4lEc"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E810D4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b53a48e5so64765797b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186268; x=1698791068; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/WYylQjwixRJXAqoqT9x2vsT/egkNyyGQzseJqJY9U=;
        b=uT7w4lEcUTQXJpCxjyDA/TSOS6e54jIhBLpvXasOjLYIoosAK7q2RldpGD5bsFz2Hl
         4WibsMTU5PYsS12Lb6iMR5AKHHZEhAFUbW7FyAf/fdqHr0KuuLmcRmHLi98Srsqc1j7w
         URJ+83mJ5RWs4be6uAGHMoYyGoQpX+jFmSYNDHwPPD42UqnlXo1MKVHASfxJLu+ZxPzw
         a5ZcpmOovxvmtoo4hoJLDgDdjNS2Pm4CRsQQMARVAzqlat11bLb1eNkRtmcIM3XDh5wP
         KK+DRATMsBx1DWH7gPycIrobSjpCz/+4X9eVnb6shk7EnuS2Ps8fvOvlcjGsuDfSIED/
         qpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186268; x=1698791068;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/WYylQjwixRJXAqoqT9x2vsT/egkNyyGQzseJqJY9U=;
        b=VELiKzSZv2v5hRZIfvwavTTO8RCi3yF+jDepbRIQt0ePTmiPqknq6DK+fkMAu8bdRS
         JjMwFgEtb2o4GO4DV5fDmRaPLAL4T+7nft8UDGlMGSy6EZkBRVHW6n3RgXgunlMT+wfK
         7pf7wCMgTdXlO1RUSGHpwfhLD9BAQxF0uls2/yHFOBn+eEZRLF8JpWXjYhgSrvbV5avI
         izNilUPcvtJTxg3+hMh+j+VNIRwV6Wg9uH+enocLqY2M22thw2LypwgNjiRfWcZ6ZTvX
         AhInwZBsYordAuvKz/+DehcWWw3QRSRTTSrnLqF4knW9aEMpi5hW977e1PcvMbVBRfw7
         jxoQ==
X-Gm-Message-State: AOJu0YxbV2PhWiJhPtLd5glTPEkiHPv9ZEbamt0YGmkOYhjRMFzV0Uuu
	I7mQpSwm6vj8m14ScVaaFLz60kZwZV9r
X-Google-Smtp-Source: AGHT+IEVRRWngcmzL9hheCR6+iyVRg4xT0ZCocehuI57VI8KP971CkhaKYhrnCw4jBnJQ57Sze30WMx5ZR00
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a81:4c8f:0:b0:59f:3cde:b33a with SMTP id
 z137-20020a814c8f000000b0059f3cdeb33amr57926ywa.6.1698186268457; Tue, 24 Oct
 2023 15:24:28 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:10 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 07/50] perf offcpu: Add missed btf_free
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Caught by address/leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 21f4d9ba023d..6af36142dc5a 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -98,22 +98,22 @@ static void off_cpu_finish(void *arg __maybe_unused)
 /* v5.18 kernel added prev_state arg, so it needs to check the signature */
 static void check_sched_switch_args(void)
 {
-	const struct btf *btf = btf__load_vmlinux_btf();
+	struct btf *btf = btf__load_vmlinux_btf();
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
 	type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
 					 BTF_KIND_TYPEDEF);
 	if ((s32)type_id < 0)
-		return;
+		goto cleanup;
 
 	t1 = btf__type_by_id(btf, type_id);
 	if (t1 == NULL)
-		return;
+		goto cleanup;
 
 	t2 = btf__type_by_id(btf, t1->type);
 	if (t2 == NULL || !btf_is_ptr(t2))
-		return;
+		goto cleanup;
 
 	t3 = btf__type_by_id(btf, t2->type);
 	/* btf_trace func proto has one more argument for the context */
@@ -121,6 +121,8 @@ static void check_sched_switch_args(void)
 		/* new format: pass prev_state as 4th arg */
 		skel->rodata->has_prev_state = true;
 	}
+cleanup:
+	btf__free(btf);
 }
 
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
-- 
2.42.0.758.gaed0368e0e-goog

