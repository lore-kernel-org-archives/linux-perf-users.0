Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9812C549;
	Wed,  7 Aug 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045148; cv=none; b=kB3+1ZJrw6cgBe09lqKHjEQZdXTaM7oTGl+G6dZTM6XUlFaC8/5bztKRMcHFble2JJ4PUV+REpoPP6YKFKt9mRnOZbM8f6Z1v9G6/OS8fydzahVP8yMa+SDTQhKmH2hF5imgzF9z63Rb2EdoDR4JeFj9pbl02cu0uzrSyS9xB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045148; c=relaxed/simple;
	bh=cMY9Ig50Ah0NrntV3IC9Hc0Iik17OIwSKC/iyfTHx74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqgHKKSlofLuL8YQ9vkq30tgNDl5mQCDQslVrTcFwSS4xxV0GvBg8BX1RWbH4P1glgRSB1Red3bTuat3njDVPen3UtN/mgmGmX+CtoCZyh84AxtcpKmWqDWfIvgiQQ+LL+qi9aKt37XC2eibDvGhd6iYWMaawAYo1Rcb8FU2Vpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOZ5XuGr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOZ5XuGr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc491f9b55so331485ad.3;
        Wed, 07 Aug 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045146; x=1723649946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tZ51s1InZzXSfbxVagPKImUEHCYLFou2I7mGe5EjcQ=;
        b=FOZ5XuGrhmAKgxMGwktVO9vSQzlCOag6u0Y5BTUJnqkKyycAkN9QxmhOi+CpS+57s0
         jj6AIXGpuInS6zH50B3cR0RzLivcg829CiRguD/RbdNz2+1laCmDt8tjktqFcqyFEzVt
         1NfHdx66fECFDErlmzsdyBg3HL+hKRKGptajqqXHKLMpTAEpi0xz1IzZ0lhQ2RAGqvNG
         eoAmguTKJ0riwaMrpT/KtJj6zyk0zxPdmgKFoP3UQNWKkLQyX7362P+r2udBDk+rKUga
         h7IxgpwaNtqWsTB4OzZYum8m5W5QMz8Il56hT8fxkpCmv6KbtyrJOI7Wmq6C/Q5RNxs5
         ihxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045146; x=1723649946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tZ51s1InZzXSfbxVagPKImUEHCYLFou2I7mGe5EjcQ=;
        b=Oc8PKD1cBIA4jCvkT0gNMCohkL7kbwR27Ed6hRq1Xr37Gm/ciDUiXSQsBJgckCjtHJ
         ZR/axG8sjJ+RplbdkRajnibbQ/w9u7+LNf/29oWn1kmm+sfuskbnxnqrdJuigLDMpzic
         /FZBGdla5TvvHtr7ogaGKY6W+VifDYJ0Z/rx/gpHDeTqxx8ohx2X9A4rQ47dUdFPLrdi
         MWcQZ3OxZSzu0/wUw1BdnSm9YdMGw0iB1qbfx0AW4epMFcl3Av1C3nppNaRuxrbStbNg
         m69swpVU5h5BFpYV/gEu6A3F32ziD45zjx0hBRZMGWQdsmHq0q13sEHZKRLgmEeL9P6/
         olog==
X-Forwarded-Encrypted: i=1; AJvYcCUJf9PNQljXpqcU9w/0pqo4SDmRqgKAaBQXQteTMkSOMefQ5DJeechvJbn6VlWwTIH1IwbHMi8G9161yqeu/jG7bv3wf9wjikTmLoDyc2ZiNSEsYHm+JFP66/l/Nx91QUqq0yVJ9+STtCqm2YWiZg==
X-Gm-Message-State: AOJu0Yzmp21XJF/ywwUSXEhjKCzsRIRmh9lQoAMlUGDv4acW7mXCRiF/
	Izs/+Dn544thSrVypvIbc6+IHM6g1x68SZxVt0awcB+1CdprEKZy
X-Google-Smtp-Source: AGHT+IFpNk5jpD/lueIdcpc/BMbJag2YHK7eOJM3LxEZJwR71i4rba15G7VdQdcVt0U3lsrpAp249A==
X-Received: by 2002:a17:902:ecd2:b0:1fd:93d2:fb94 with SMTP id d9443c01a7336-1ff573cc1f2mr195280415ad.48.1723045146188;
        Wed, 07 Aug 2024 08:39:06 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:05 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] perf record --off-cpu: Add --off-cpu-thresh
Date: Wed,  7 Aug 2024 23:38:36 +0800
Message-ID: <20240807153843.3231451-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --off-cpu-thresh argument to specify the off-cpu time threshold.
If the off-cpu time exceeds this threshold, dump the off-cpu data
directly.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-record.c            | 26 ++++++++++++++++++++++++++
 tools/perf/util/bpf_off_cpu.c          |  2 ++
 tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
 tools/perf/util/record.h               |  1 +
 4 files changed, 31 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 72345d1e54b0..60c6fe7b4804 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3133,6 +3133,28 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+static int record__parse_off_cpu_thresh(const struct option *opt,
+					const char *str,
+					int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+	char *endptr;
+	u64 off_cpu_thresh;
+
+	if (!str)
+		return -EINVAL;
+
+	off_cpu_thresh = strtoul(str, &endptr, 10);
+
+	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed. */
+	if (*endptr || (off_cpu_thresh == 0 && strcmp(str, "0")))
+		return -EINVAL;
+	else
+		opts->off_cpu_thresh = off_cpu_thresh;
+
+	return 0;
+}
+
 void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
 {
 }
@@ -3326,6 +3348,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh      = OFF_CPU_THRESH_DEFAULT,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -3560,6 +3583,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
+		     "Dump off-cpu samples if off-cpu time reaches this threshold. The unit is microseconds. (default: 500000)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 6af36142dc5a..1e0e454bfb5e 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -272,6 +272,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000ull;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index d877a0a9731f..cca1b6990a57 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -96,6 +96,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 sample_id, sample_type, offcpu_thresh;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..3c11416e6627 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	int	      synth;
 	int	      threads_spec;
 	const char    *threads_user_spec;
+	u64	      off_cpu_thresh;
 };
 
 extern const char * const *record_usage;
-- 
2.45.2

