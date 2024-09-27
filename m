Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CCE1C2329;
	Fri, 27 Sep 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468875; cv=none; b=P6LwPWyBsMLT7SmOQ0B21IR1TRLWdgdb98L8Nvnxb3LiodlsDw/i469Id4gZFn3uSgnIhbjnSpJ7DAXiyYk/SbI9ods/TMLW9md6AjyjT+hYUutBkI8Lr3e5+ABb2NNosFUAvBKOpA3w5tc8f/115qFkQLYLa5tQ+Ky8GliXc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468875; c=relaxed/simple;
	bh=eK1FtnbY9Tri45jB5Cvw0onFqkVbxt9kUVvxXDph0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzlLg586/X5H5qnZ+5sw3ohGawiR7GooPLSXmTbllnPHatIRK2V4j+ZGlDrTCcP+uyAZ8pZgbM7YuT1yglxBIkx8R6PG3glS2FHc0WI+JEcP+XIHlvjIy7DXFVVNyblTn7LdRta+S48YhUhuLpG8yKl+9OfRnGwLCPIm9CdzQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGScaCTx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGScaCTx"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71b00a97734so2173266b3a.1;
        Fri, 27 Sep 2024 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468873; x=1728073673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdYP7hS3yJ4h9q1j2wrX5tkUAb8rgBuRj2nZ/ENMYog=;
        b=cGScaCTxObbrCYiJZtLsxTzPIW53lV++2cF4s2M7iaAKy/KrRL2aoRNmVPSYIjrHCv
         dujqKzLhMAcQ156dN6y7g28gbTRaJUyUbrv0G7W4oWwF3SlIgbay02qTexor4NOrNIT/
         gWXsy7NmXk966VSVQb1/8EIsdtTKzXyv/W8QX1Adp2OFa/XLd5jOB6Ntq9y/j1dDzhA1
         iD07/GOSMXlHOdpvSDAluVgNzh8sfdS0gqzvHl3+L8sbkQr1s4rVDKOUtNSBoau5jFd0
         ohVpfhEDJdtptfIXT2UwXStJvUJzs4f1Vxhfox5q3Z+FTFGhrWzuIxFIxeIcmIra+Nd8
         BALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468873; x=1728073673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdYP7hS3yJ4h9q1j2wrX5tkUAb8rgBuRj2nZ/ENMYog=;
        b=Xl8zVX8xjObMKzCw5zqIAQ5ER/ZGoWsDEzrIr8arj1U9yNMkx8kDCze4pySHlqwNfG
         IPJsNiG6R9F9WaXXdsoSot858WWaPt5TyRENw2OGlKfHNCS6g1PUg5unGkseVSA1gL+E
         a+15ZfGg6dvH9zQmP4yBznDl+ZEE/YzpXUs2yAwXLKLtKQ6GpkkxVIkiyeD9jKUNuS+h
         UblZtvHAD6G1hSkoyGS8VZRyu/jmgEUaG4xjGwM9ApwB8ggPwCfcw+TLTEZx2fL0BTZe
         g6p6aZottKzA9/k5HAfLqUeLl4HYORDvxYABTrr9q4oxYjvHH4iWbZoRBqToxcanyU9M
         4RuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/5LEroh/TzLFu3D1fDhrcNjewkkamHM4J+R/JVqcgXpbFB86Ke+tP5qrgmpbzs+TDERgqStKSFrfS6+vgJypGXA==@vger.kernel.org, AJvYcCVuOHhAz0o0xU+jRcL3NJBvKap7SS/cRq2DmjE7p5JYBUW4WPrOXwmwA/BU5G4US961jZAbn1CUcO3o8xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38ykR9D6qQtFmY9ra8dFf8fT10Nj316415fWvCYYP89UyZR9M
	9Q14/hsyvN9DAUbF9I2EJywtvLeaBPCt0XMWgNgSxPZXvqkh0av1idZa6dL2
X-Google-Smtp-Source: AGHT+IHJqXEKdYzDG09TMUZ3imL1DXHy6rViWAevy6VNRTYtBnlplaimxJzvT5OqpzBPeCJqF6i33g==
X-Received: by 2002:a05:6a00:2d29:b0:714:1f6d:11e5 with SMTP id d2e1a72fcca58-71b25f6efb0mr7241083b3a.12.1727468872977;
        Fri, 27 Sep 2024 13:27:52 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:27:52 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v6 2/8] perf record --off-cpu: Add --off-cpu-thresh
Date: Fri, 27 Sep 2024 13:27:30 -0700
Message-ID: <20240927202736.767941-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927202736.767941-1-howardchu95@gmail.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
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
 tools/perf/util/off_cpu.h              |  2 ++
 tools/perf/util/record.h               |  1 +
 5 files changed, 33 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..bd53fb3c98ec 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct option *opt,
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
+	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed */
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
@@ -3342,6 +3364,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh      = OFF_CPU_THRESH_DEFAULT,
 	},
 };
 
@@ -3564,6 +3587,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
+		     "Dump off-cpu samples if off-cpu time reaches this threshold. The unit is microsecond (default: 500000)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index a590a8ac1f9d..eaef643f50e3 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -272,6 +272,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c152116df72f..5ea320aa9a53 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
+__u64 sample_id, sample_type, offcpu_thresh;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..357231cb1c38 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -10,6 +10,8 @@ struct record_opts;
 
 #define OFFCPU_EVENT  "offcpu-time"
 
+#define OFF_CPU_THRESH_DEFAULT 500000ull
+
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
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
2.43.0

