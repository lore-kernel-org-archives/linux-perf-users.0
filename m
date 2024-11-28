Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34EE1BFE01
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801045; cv=none; b=JQVZpIj0K+wcm4oiBLl/MphCDHhsQElS2ff+XIjANSpepuLf2YR/NeNZkGcAT0EGFlUsKHCbRw2vhbOG/h4XixzoPLiGkRMGUopBf1t+WcanIH6lset4UneU+UkWMLrj0jhNXIVDvzXCiI+aKNKn8WRXWTo/hrF1qNwB9fR/mDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801045; c=relaxed/simple;
	bh=Ku4hN7xfqlPUv5w30C4DCKNBadD3qKAbjpkGgl0RasU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQsPx8pIs79zlyJppoxrAPKNWQFC6/lbThYQ6Edv8uXpgunmCa5xlqDjko68errwavng5o3yosYigP1wnCvPyZCvOEgEnca77/CgX5WSvKRvjwha2obD8CsVa6iQrBoTXkmQDfoESWUvzMxrPgK6UvzVIgmdSfIylEPJxW9mQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j1gmhwxI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j1gmhwxI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21262a191a5so7322845ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801043; x=1733405843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEQuel0RUI05tTYvOewxgm0mSB+lb7Esf6H6O4xZV1s=;
        b=j1gmhwxIMg4u/5OJ7PCjiCw94uQTNdIXIoJhvQNmv4QczEWkbWOZsOQX235Bo8jcqb
         Uf4k9najhsdEAUa1TdnLOrx35360hGkIxc6bgZMj9h+kSj9NRoGGz3IS0u8PJdVCTC3C
         QnrnKHGYZ+g36Gl7EvtO+YIjHnGJuD9RC24muouOW2EKplO0mVDCZhC2fbi6w7Nscqwq
         EM8JDAP733LEotG0kwzZ8931vVRMZafcv/AnDhVZurrQzdX9vFD89qScB3s1AQ+ilHCC
         IQjP9z/c4THJuQmXlpTxCw6kFWxoIW6piIJJhl75IwCFdecnIwaP5z06QIYC9BJQ9hN9
         A3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801043; x=1733405843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEQuel0RUI05tTYvOewxgm0mSB+lb7Esf6H6O4xZV1s=;
        b=nk8xg82ie8JWJD0TX64+Bz1aeznXHPrWDPtie+rpBQP7JMjUX8ki73OEDw16trBXkr
         eDIYwa3p9NwBQcRRmJtEp2TO9V44JwEq7KEw527Lt1ej1b7e78ecu8j4Sb3hzLONChDA
         +Wa4RNuEA9FyzcKzW5Ftxld6qutU2faIQTYCLN7SK8x8nc7x/+nvIcVPQoc4gferO3ts
         azFJA/smCrDAB9daiwQRrWEF+uyFwvg8dFmR3eeigwEXidvB0f2cwchg4l5y9GYl+sWF
         mgP66AhzNzxDAcfNM9l1E85gMTnEP3NJSpo9n3oBscothi3iUZ0Ww2ruAi6inz/zQ0Nf
         ex0w==
X-Forwarded-Encrypted: i=1; AJvYcCXPcqSdSyMdOJuensD5E4qcu1ThV5Nu7K4+Dqmle1zqzXdvik0R6eaxnjaKrVUDwCw4FVPFeUDPynLuyotV1Ecd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wAAeRtyYOxjyFQ28td9duZ+1mnjMeLqXKa/89kcJsQYxKm7S
	4i/HDoS5SQ/rHlUb680TdKSnxmayJzqSgWoudJIlbP5a8JW0wY3KQ74x+AxwK0c=
X-Gm-Gg: ASbGncu1vSxsnIQBdVBQRJWmC9TQtANdql9HoYmF72cKdTXRg9x6XgguvVgx5aDtScX
	iPctMsrEJ0c8hAMk7O8fv/vqdRWlZpTiQF1LWP7F0QAVhXFNfg7apd6/vc/BXLHEiTCrCCe2Xmp
	rC+2aeJmr/vzC4cXfJIXx7PczRjlbtpe4t7fzyvxbPfGQbA4OvbLcrb7YT33n4Jf2GYJcMseXVg
	bM4b8fkh1vsvot8N8ZtV7GaTXSH79/Vuy/pdCP0jR4IlWIw7jZBZDXlxw==
X-Google-Smtp-Source: AGHT+IGJDPD9pE+AeJXDwNp8BJXO/DIHoUo2WDZp9IvM7Np2ou1DN2+QaRrIFaalT7td21LjD7k1Vw==
X-Received: by 2002:a17:902:fc47:b0:20c:6bff:fcae with SMTP id d9443c01a7336-21501095f5fmr92201495ad.5.1732801043131;
        Thu, 28 Nov 2024 05:37:23 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:37:22 -0800 (PST)
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
Subject: [RFC 12/12] perf event action: Add parsing builtin time expr support
Date: Thu, 28 Nov 2024 21:35:53 +0800
Message-Id: <20241128133553.823722-13-yangjihong@bytedance.com>
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

Support parsing of builtin time expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("time = %llu\n", time)' true
  time = 787661350481404
  time = 787661350483823
  time = 787661350493754
  time = 787661350623109
  time = 787661350482984
  time = 787661350642538
  time = 787661350647575
  time = 787661350649706
  time = 787661350650968
  time = 787661350653686
  time = 787661350654928
  ...
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/bpf_skel/bpf_record_action.h |  1 +
 tools/perf/util/bpf_skel/record_action.bpf.c | 14 ++++++++++++++
 tools/perf/util/parse-action.c               |  1 +
 tools/perf/util/parse-action.h               |  1 +
 tools/perf/util/parse-action.l               |  1 +
 tools/perf/util/record_action.c              |  4 ++++
 6 files changed, 22 insertions(+)

diff --git a/tools/perf/util/bpf_skel/bpf_record_action.h b/tools/perf/util/bpf_skel/bpf_record_action.h
index 325964b7aac9..e514ac14705e 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -11,6 +11,7 @@ enum __output_format_type {
 	__OUTPUT_FORMAT_TYPE_PID,
 	__OUTPUT_FORMAT_TYPE_TID,
 	__OUTPUT_FORMAT_TYPE_COMM,
+	__OUTPUT_FORMAT_TYPE_TIME,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index f809305b16be..ed36f121e90b 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -84,6 +84,17 @@ static inline int output_comm(__u8 *data, int size)
 	return __TASK_COMM_MAX_SIZE;
 }
 
+static inline int output_time(__u8 *data, int size)
+{
+	__u64 *ts = (__u64 *)data;
+
+	if (size < sizeof(__u64))
+		return -1;
+
+	*ts = bpf_ktime_get_ns();
+	return sizeof(__u64);
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
@@ -115,6 +126,9 @@ int sample_output(u64 *ctx)
 		case __OUTPUT_FORMAT_TYPE_COMM:
 			ret = output_comm(data + total, __OUTPUT_DATA_MAX_SIZE - total);
 			break;
+		case __OUTPUT_FORMAT_TYPE_TIME:
+			ret = output_time(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 8bc1646abe27..4f40e4a24357 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -16,6 +16,7 @@
  *     - pid
  *     - tid
  *     - comm
+ *     - time
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index 39fb521f3193..57df6f8294f5 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -31,6 +31,7 @@ enum evtact_expr_builtin_type {
 	EVTACT_EXPR_BUILTIN_TYPE_PID,
 	EVTACT_EXPR_BUILTIN_TYPE_TID,
 	EVTACT_EXPR_BUILTIN_TYPE_COMM,
+	EVTACT_EXPR_BUILTIN_TYPE_TIME,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index ddac305c1ca4..9029ac19c128 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -107,6 +107,7 @@ cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
 pid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_PID);  }
 tid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_TID);  }
 comm		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_COMM); }
+time		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_TIME); }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index ead7eeffb7cc..4de6afcbfb26 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -108,6 +108,10 @@ static int set_expr_builtin_output_format(struct evtact_expr *expr,
 		*format = __OUTPUT_FORMAT_TYPE_COMM;
 		size = __TASK_COMM_MAX_SIZE;
 		break;
+	case EVTACT_EXPR_BUILTIN_TYPE_TIME:
+		*format = __OUTPUT_FORMAT_TYPE_TIME;
+		size = sizeof(u64);
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1

