Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2515B14C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700230; cv=none; b=pkS6V5qumRDeaWbOVmQpj9Z8Ei37+KV/48ORs+5BUQ0jIMjYV24SeYsEL9vYIMy9+WJgbMpRomsWcP6rqxIzShpJRZEEkcPyyebdSP6DYhhcpr2La0e6HaDWXrnyVirXi6BfMKxmVim3LUWdTucJb1lYgRKLa5dIzNTRQmFwjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700230; c=relaxed/simple;
	bh=RcAtOY3BqIjsxZ/EkLx9cbSXMAG2HJ+eMA8VPs9/m08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aEaUlixJZcNfmm62tUxETqsHmmAZKjNK2bpwMfXpFt8jxUh2NdOmG9+1QKM68gpPK7j5IyqlJxkNFhHlY5k4JpZpdzE8tJOaKvCjgeXUm9/khB0ifAv/IbpALeMoNkDul9rfcWWDDOK2qZI/b3P7xfBciiiK8jeEDEG09V2NAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LVHadjte; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LVHadjte"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa2ea1c443so6331505ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720700228; x=1721305028; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMWLbotKK9Kcv+yDqQHrYwDupJwtZdSLIhFGpeisVqk=;
        b=LVHadjte/h7XYlTcwcYI9U+/gzwWtnQc/9wrfJ5esFeOoj/GDcPtmIZSShn8qst4rq
         MIdmt/L5PoQA6qXOfD6NQ0ay7vIr/Y3S0c8FPj1PTSBkEr71aARovXGvY8d/kpjyc28f
         Sar2DaP7hMflHtT2m0TS+rqh48xsbHd5mfqKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700228; x=1721305028;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMWLbotKK9Kcv+yDqQHrYwDupJwtZdSLIhFGpeisVqk=;
        b=UZr7NeM0EQOD7P/DZPxlAfOTI2bJ1FHeT+zkJb0L2BquNcTX4jraQo0zG/RS7aiWWG
         bssugAqYeKwa0srJ+ei8wTtj1HRHyIHp6TEXKTVQKoRSW3JkzUw/4cfTGP1K7mDZkRG2
         GGe/sDuQidUwIczcVmn3q/psNmi2ogyg+oRukTSyb5LQz/30jq8KrRn0k6QoLP+YnlPE
         n9luoHc/2+6ezhaI/jdieaeZNVsPTBLtqnI7JY+bSnV/nsmOxOvndp29KM2gsYNmvSsK
         m/JExv/Hxs249rwd5lfgSbGxNK7paJFxv7GcsQG8NLi89RF0fc2iVTfW/ez7kiob6NnX
         FC3A==
X-Forwarded-Encrypted: i=1; AJvYcCVdK9DtTdsa9L7PUUENNKe9bh/ckKMIAt2wX9Iccb2PZqde6TrxyAqPKUjL/jCldYX/MIR2eVy4sKjaIrJilbLGGi23CPRLAYQ5RY/9ZI74lg==
X-Gm-Message-State: AOJu0YwfwDZnRTISmDWzBQy6FNZ9E3JyiSu02OjCl5+Khfdu887hp15A
	9+En9eZSQ5ndRbBgHiMvazWoukH8q4VMk+VfhZq1vJE0ErUmR/a43bmHydbTcg==
X-Google-Smtp-Source: AGHT+IEay4VzDWGc7cNbJqKwvD6xCyKm+QF0n/B7mqHkBPs8hMJ1zCGnny6ZKJS0v/G/jgh4m0FgQw==
X-Received: by 2002:a17:902:e54c:b0:1f7:1b08:dda9 with SMTP id d9443c01a7336-1fbb6cdac37mr68496965ad.8.1720700228186;
        Thu, 11 Jul 2024 05:17:08 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10111sm49211985ad.20.2024.07.11.05.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:17:07 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	asmadeus@codewreck.org,
	siyanteng@loongson.cn,
	sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH RFC 2/3] perf/record: add options --off-cpu-kernel
Date: Thu, 11 Jul 2024 17:46:18 +0530
Message-Id: <1720700179-22839-3-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

--off-cpu-kernel to collect off cpu samples using on/off cpu time.

Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>

---
 tools/perf/builtin-record.c | 2 ++
 tools/perf/util/evsel.c     | 2 ++
 tools/perf/util/record.h    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0a8ba1323d64..5be172537330 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3571,6 +3571,8 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_BOOLEAN(0, "off-cpu-kernel", &record.opts.off_cpu_kernel,
+		    "Enable kernel based off-cpu analysis"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f818ab6b662..8ba890a5ac6e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -862,6 +862,8 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		attr->exclude_callchain_user = 1;
 	if (opts->user_callchains)
 		attr->exclude_callchain_kernel = 1;
+	if (opts->off_cpu_kernel)
+		attr->off_cpu = 1;
 	if (param->record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..cfa5e34b78ad 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -52,6 +52,7 @@ struct record_opts {
 	bool	      kcore;
 	bool	      text_poke;
 	bool	      build_id;
+	bool	      off_cpu_kernel;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
-- 
2.39.0

