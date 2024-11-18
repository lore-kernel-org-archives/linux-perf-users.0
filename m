Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C961EC001
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970477; cv=none; b=CWYZoMFlB64rJY2WbQH/ZHs6F6e5DD9Dve7nkQz3fllCdtBh2xF3vuSl5eRPvDoHr3Io2Fia6U3CKzsk6/NO4nKbgDkzvNug78467X9ym4OfDbPWuj31Ny4qKooABxOHqXbrDzNrawH3pqLClxNZJUJ5FFtn9WEe+WhphPKfjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970477; c=relaxed/simple;
	bh=jLMv6psh26jQg+qmfgIhNouYWgAxBlI8CM4lBpCniiI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Uh3JpzsEO/jsjeKV83L9X8NkxL2iIQGVTmAlcyp34AkEunZjd1DM/JZ0GVJe83oZFB9yrAk1M3IiqEghVUziYWumwbEsPiZyJq0lVQ/PQgBrV76e7Pw3mjNkwaSS1LjwOC2+XTE1wRiVBMbd+ZP5vm9rapRILXr+DkG/NKZtZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/qE3qxY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/qE3qxY"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3884e5e828so3351475276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 14:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970475; x=1732575275; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FG3Sh83F7FOGs8gw5xePFCnagv+uNMSUGfyFfbaEqMQ=;
        b=d/qE3qxYvq0s3SEdOaqjJUJbxxCqff56nE8M5v2GZzkTynKSP0TOMHF9CH+/0/OMVc
         be0Xg8W+zuERWtviR1l8VK035m+lSLbb4UzQoE63+/hVNHHOj5rMFy8z0eeo1g8eOqZs
         QN1xpNkB8MNXrTc3WjP1FsP5MD/1FUpd5KZ8fB8kB4Mr6OPd8Gt4bLwQejsIURERx/zV
         5exjcs0ztjwtxFg4QnGiSIC/U8+MevsxtR1wNA0xcLztxRH/vC+lG6G/1Q6JbRVKvFZj
         494FSegvlkQB36X/OsX+9T2ScFAS+kk8IovzdP5zscZDCnQblmwsfPEh09II6FCYZm+h
         1RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970475; x=1732575275;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG3Sh83F7FOGs8gw5xePFCnagv+uNMSUGfyFfbaEqMQ=;
        b=GtCecagmB669UVzFOnQprvxp78Rs8SvyISEEsU6CUi3v57Qp7uqEPdQLEuDDPVNsRF
         5q2ReTqMRuIhwQp6sbSU97NV2QDXd/d4DT9zH6W7LLtfEmht+CZhzUy28lXMQBrAUXxG
         i3ns0fzEYJMG1DRz0Z58Xmjk6eZrvL3xaKfNy1zehQbuWD79eo3eDCkBoH1cX+8RRJCP
         TF9GLkxeecrfUaFjUOsabYmMKy0NxVA5GPKliYvsA/wpXpueVMT6gJruEOvHLfLOU0ep
         buP2J/uVswaOcMyKwuSRP9U6vjWd35K1vPWxSuECl0os0lBCIuwpPSdF500G18kep685
         1Wdg==
X-Forwarded-Encrypted: i=1; AJvYcCUgDZciCrT/jzDm0ZzHegQCRaSpmPiSSejmOIs8ftTNb0ZXbYffFXLDvbqMFD8pTMGMkNTmGAcJsLUJugN8wFmy@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWysG8U+UmNA/HCYtqzUwA+4gZ4pRiVxWwMw080aDrSaeqBF0
	PAnAQshtWh6qJXnhhgHst3OJ2S7HvgRBpi8DEus/BOeZK/1RhTjrq3ILUniIe9N1mSEaDEPpUdx
	FDLABTA==
X-Google-Smtp-Source: AGHT+IGl1aqGhFtUZ1apRuwVVnoRAl8J4uAIA9T+sYV7QTDRk/6WeLhJGKOFjO0Kn4m5EaYRZcmrmTJNmUYv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:e0c5:0:b0:e38:22d8:e5f3 with SMTP id
 3f1490d57ef6-e3825d27591mr174594276.2.1731970474602; Mon, 18 Nov 2024
 14:54:34 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:42 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 4/7] perf trace-event: Always build trace-event-info.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

trace-event-info.c has no libtraceevent depdendencies, always build it
and use it in builtin-record and perf_event_attr printing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c               | 2 --
 tools/perf/util/Build                     | 2 +-
 tools/perf/util/perf_event_attr_fprintf.c | 4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..0b637cea4850 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1748,10 +1748,8 @@ static void record__init_features(struct record *rec)
 	if (rec->no_buildid)
 		perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 
-#ifdef HAVE_LIBTRACEEVENT
 	if (!have_tracepoints(&rec->evlist->core.entries))
 		perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
-#endif
 
 	if (!rec->opts.branch_stack)
 		perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c06d2ee9024c..47522612484e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -86,7 +86,7 @@ perf-util-y += pmu-bison.o
 perf-util-y += hwmon_pmu.o
 perf-util-y += tool_pmu.o
 perf-util-y += svghelper.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
+perf-util-y += trace-event-info.o
 perf-util-y += trace-event-scripting.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba79697..a73c74b99a3b 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -212,7 +212,6 @@ static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
 	}
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 {
 	char *str = tracepoint_id_to_name(value);
@@ -220,7 +219,6 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 	print_id_hex(str);
 	free(str);
 }
-#endif
 
 static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
@@ -238,9 +236,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 	case PERF_TYPE_HW_CACHE:
 		return __p_config_hw_cache_id(buf, size, value);
 	case PERF_TYPE_TRACEPOINT:
-#ifdef HAVE_LIBTRACEEVENT
 		return __p_config_tracepoint_id(buf, size, value);
-#endif
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_BREAKPOINT:
 	default:
-- 
2.47.0.338.g60cca15819-goog

