Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D01ADFF9
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801020; cv=none; b=Kx4GmwmXaINqTZXyh8ecGEn7RRpY4xOEYp3R22VGklRt52BKHerD44DaYRHvM3BJs+EvdmXUOiw8roDp+urr9gZcnGdDJE9gKw8vyEgB88rjGu6kp9IM1fP6D4OwcocP19n05IP8x4tBjuW+7325OzLVoNSKQ8vXSTvoIFMAD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801020; c=relaxed/simple;
	bh=BBDOWJUMQQVfP0zujIc5xIWnrs6gRTLQkCf6I2SIpPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwGVBMClDhljlB6HoSng5H47NCJqz0cCWRVRuSOX9xkIwwOAljlervSKBMrKiC8gel8RT7BYx1lKbXChEjz6NMYAAxCAnhOpeandLTIc37byN2bUECYadHxeS/jUyuxaJvzIuPmd7iI102P8pwuOFF1ybHqYECNNCRl0gn3vpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HQiXQNiz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HQiXQNiz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21539e1d09cso162035ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801018; x=1733405818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUD8vqFZbss9TRcSki6gkGZU4MXDWWiXU3SDa6QRj9s=;
        b=HQiXQNiz9WDas3UsP+I/1jTzhW3KK0Q172En91k/gMbcmD+ky1xdDafRqgJVshRMU5
         UQSWDh5DwoKYHp6My2WPaPzS6fqgVcDUTo4haFX9/oGLy8R5ZrPgpjY6IE5ylfWVhFIQ
         eWBDdpiFB2uK8iyX6BHQVgBuV0ZbxXQzpRSFzu3D7OsCwgD2PvxZrliEY+CLF0FM3oNX
         iHQ1hc2z8O5itxY4/ctYWdnbDxaIYokZWxmJvO8q9kzchatFk1IwNAqxgc/0zi/niqwY
         wrD0w7bEhXu817ra+R9KzbBxoC80O/tZuf0mxX1q0Xy+kq3aICOPjklATcoI6Gn6fKqR
         Kq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801018; x=1733405818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUD8vqFZbss9TRcSki6gkGZU4MXDWWiXU3SDa6QRj9s=;
        b=ImbrR2ecCUrSinIWyG/ssd9lXF+ZdcfMHI5ztmEwJWl3imMZd2m59WM3bf4d05+VkP
         DaUyPAQje0wntu0t4SjH8a++qbr8ysVcm7oJw38e0v6K7ymFKreDwLd/UAXQVOIycIyD
         m9oqdiyW2SF5oHW0JiaJwfjVRanOd8qB1yOplAhyVNYKVvGZrtOEGQDmYYWgzcxpGdKu
         LG02pvFtWksngc5MGuVSYpMFQ1dm9X/9ZBNNNv650THy9H6FATLMsSxSMGBqVKhuxJSa
         7analcKapuV7RmgDcEHxH9d8z8fRD0VstMLwJQ5rdGgpHYqD4/ojbRxfyYrNh/Wp+8Sz
         G0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVK5oeqdML+RZ24KaHYwtTFk0uQOBPi0uo/rbjDYOGWKtPExpSrieTfmCT1VCRv2beV27ePAQRN+3RISVdGGUlQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIe6YTH63JTejmDf1uWWqfMnsXsjv6GHPJHl4LFqMvRCodnyG
	7eG2XwX4QMpTIZEx3qW+u+xDPDowEgWCMfsrLFjAUoioYwVq6cs+MPxY32KLeGo=
X-Gm-Gg: ASbGncsyePj4Eclu1SsfOBrrjDDIN7XVaqb1UsJzW+nupkLB7RiYOzYcg+Qqv+MlUYn
	g+l6Kxcm6x1stdnLL+YRDPZGdKVw8i/Y4nmJLBjPE9oRNVMYOL0TEQx8Ti8Ixz+/bJlDA5AXtb0
	4PDjlbdurudTeNlFFQ4+yIMSnsgxCThipWLu+wpvqA8IVxMUbFnGWtCeumYZzifFjGF4GXCrqV5
	dflrKwwW6VGVYBtg2AKg2lxqjMI18SsVwNKXyH3QpPCujqDYtS+pGh4Lg==
X-Google-Smtp-Source: AGHT+IGf15rlbVH2/JLbhmcoCT0wHnv6QABKy0ywOplhv0zyME4662tjPK99hOetjLPgzweDrC1BCw==
X-Received: by 2002:a17:902:d54e:b0:212:5b57:80ed with SMTP id d9443c01a7336-21501087642mr98852365ad.11.1732801018544;
        Thu, 28 Nov 2024 05:36:58 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:57 -0800 (PST)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [RFC 08/12] perf event action: Add parsing builtin cpu expr support
Date: Thu, 28 Nov 2024 21:35:49 +0800
Message-Id: <20241128133553.823722-9-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128133553.823722-1-yangjihong@bytedance.com>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing of builtin cpu expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("cpu = %d\n", cpu)'
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  ...
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/bpf_skel/bpf_record_action.h |  1 +
 tools/perf/util/bpf_skel/record_action.bpf.c | 16 ++++++++++++++++
 tools/perf/util/parse-action.c               |  1 +
 tools/perf/util/parse-action.h               |  1 +
 tools/perf/util/parse-action.l               |  1 +
 tools/perf/util/record_action.c              |  7 +++++--
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/bpf_record_action.h b/tools/perf/util/bpf_skel/bpf_record_action.h
index ee4d03848e58..91a307b89f85 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -7,6 +7,7 @@
 #define __OUTPUT_FORMATS_MAX_NUM 8
 
 enum __output_format_type {
+	__OUTPUT_FORMAT_TYPE_CPU,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index 424fa8c3e6f1..4b7698554ead 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -35,10 +35,22 @@ static inline struct __output_data_payload *sample_data_payload(void)
 	return bpf_map_lookup_elem(&sample_data_tmp, &key);
 }
 
+static inline int output_cpu(__u8 *data, int size)
+{
+	__u32 *cpu = (__u32 *)data;
+
+	if (size < sizeof(__u32))
+		return -1;
+
+	*cpu = bpf_get_smp_processor_id();
+	return sizeof(__u32);
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
 	struct __output_data_payload *sample;
+	__u8 *data;
 	int i;
 	int total = 0;
 	int ret = 0;
@@ -50,8 +62,12 @@ int sample_output(u64 *ctx)
 	if (!sample)
 		return 0;
 
+	data = sample->__data;
 	for (i = 0; i < output_format_num && i < __OUTPUT_FORMATS_MAX_NUM; i++) {
 		switch (output_formats[i]) {
+		case __OUTPUT_FORMAT_TYPE_CPU:
+			ret = output_cpu(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index e6299de99bc5..2bb32cc16ae7 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -12,6 +12,7 @@
  *   - call:
  *     - print
  *   - builtin:
+ *     - cpu
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index b1a33a77c558..ee949ed07111 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -27,6 +27,7 @@ enum evtact_expr_call_type {
 };
 
 enum evtact_expr_builtin_type {
+	EVTACT_EXPR_BUILTIN_TYPE_CPU,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 1c729b7a0248..dab8066a1038 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -103,6 +103,7 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 {num_hex}	{ return value(16); }
 {space}		{ }
 
+cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index 634d6b199bae..15e8b1740e32 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -86,13 +86,16 @@ int bpf_perf_record_init(void)
 }
 
 static int set_expr_builtin_output_format(struct evtact_expr *expr,
-					  u32 opcode, int *offset,
-					  int *format __maybe_unused)
+					  u32 opcode, int *offset, int *format)
 {
 	int size = 0;
 	struct expr_builtin_output_priv *priv = expr->priv;
 
 	switch (opcode) {
+	case EVTACT_EXPR_BUILTIN_TYPE_CPU:
+		*format = __OUTPUT_FORMAT_TYPE_CPU;
+		size = sizeof(u32);
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1

