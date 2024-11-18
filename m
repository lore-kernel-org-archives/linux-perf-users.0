Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1B1E907A
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970463; cv=none; b=EBg5NUrNeqXJu5Hl8PHOIZmN3c1FOJoYtgBQAi7vB2RgTkGmHLhpEFWGTww6TtS2F1USqdF9sVxoW4tdYQxT9KxuiEbKRejPUf1GjkjTLKiCuILN6ZM5Gd7eIVLn/z3C3oArZtQKWanzfxHBybFpo3yFe5ej7JGqcsWzygxvoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970463; c=relaxed/simple;
	bh=HXojo0/fTP/zExJdIYj45kNltzewwVI4CI/1w1068zE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NsBeL39l/uuE8i389PKxMOCpAvPkl6QLwYPxwVTYojYZBipP8u3Ru0nbQsZjngjK8RwbqcwrJeaVUTFGdF5G7ymERa4zz7/in5IG3HH3TzjFoCov2bVSbr6igJrLrqjbPQlo85R+bUngZGp0GuRpRP2fzlrKTXhQWVf7gZTSz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etIWfmx/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etIWfmx/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee6e1f2d25so46645737b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970461; x=1732575261; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcPgicYw7lNCwZ4lAX6Rp3LicdE0a0SwYEgY1Pd6MHA=;
        b=etIWfmx/7Ui/YXmuyzC2Ajhf4eUTjT+ZM1rVZBULXdnvMhQqeFnbuv2gmcYY4unqPy
         AoEPfloENysARJLvCwapik2LLadhNJ2uHxfnmduBOygzw1UMGNqsGEHUDPXEgRxj6TGR
         oTIFJlD14YVpT8a90BJ7Kg8PWVmiBTaTtKxQG/tkhItGrjWC1JN4dxTI4LzFHCcUj/52
         95z+BjJWKs73HW91+zUNdTOpu5FXxqQ0vrHsFerQnbxY+xP3iI6hc19tdWYEC/p2hZO1
         3yV81antg5Wh4JlvU5nTmgLrTPNCljq0Xl2tqgt/0egHsWlXbMCIo7LbICQYzjcuPdf1
         zWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970461; x=1732575261;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcPgicYw7lNCwZ4lAX6Rp3LicdE0a0SwYEgY1Pd6MHA=;
        b=vV9HevJEvXXSXImp71FKIzO6o9sf/kI7xHbEF99EYOsqqrU0P1AhI+d4f7nM0Ud2Gs
         oPz69eVdOyaFAamMwLKspzkppiFZuEF8qcFEUA70baUwROR/SuoPrf84sO20FpUaMw8N
         JCk8IMLLM2cHqru6Ep2QcBBYI0xhAvB5lqrPMZuFRYYKrVkSfaNYPaHBh+OniB+L4ULq
         BHL2VPoP+1TvP7XTwD4WWuhI2h3cMxFWnfwSv0MvRK2fc3IbSiw2APTRRruQALfshsZm
         pRfPThUPnVdibCv0lp+RMGTOF5MTIuGFcZL18RH1OFd/MFP2Raiy5OA0B1q8kIKIiF7N
         3vMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVip+h1onGpsYBGGnA9w9spuiNT404rFSVEHbVweFci9CU/XucTs3J/9kABt2dpx2VGboNvEPy2In0iUWFxvg54@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cLYLuwHB3aTex3K0z3l4CCIYLmW6b+81OdOUnX4HfzBeAD9n
	9amx/4y73CRPLW9dzaIb0WKHlejOA3DBX/zhDFAVV//eolklqfARtp7geet6mKxll2hdJ1/bayb
	6Pcg20A==
X-Google-Smtp-Source: AGHT+IGPv4JaCyn7zRXGpIzy8isHlbIcxqrVk715hTkaLLRFHcVSEMYfjdPn9FY18xv6x3jHLXZWo0bjlfhy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6585:b0:6e2:371f:4aef with SMTP
 id 00721157ae682-6ee55c95c78mr1282587b3.3.1731970460841; Mon, 18 Nov 2024
 14:54:20 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:39 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 1/7] perf env: Ensure failure broken topology file reads
 are always -1 encoded
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

get_core_id returns 0 on success and a negative errno value on
error. Currently the error can only be -1, but fixing this to be any
errno value breaks perf:
https://lore.kernel.org/lkml/Zzu4Sdebve-NXEMX@google.com/
To avoid this, make sure all error values are written as -1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index e2843ca2edd9..e890a52e01a6 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -326,10 +326,13 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 
 	for (idx = 0; idx < nr_cpus; ++idx) {
 		struct perf_cpu cpu = { .cpu = idx };
+		int core_id   = cpu__get_core_id(cpu);
+		int socket_id = cpu__get_socket_id(cpu);
+		int die_id    = cpu__get_die_id(cpu);
 
-		env->cpu[idx].core_id	= cpu__get_core_id(cpu);
-		env->cpu[idx].socket_id	= cpu__get_socket_id(cpu);
-		env->cpu[idx].die_id	= cpu__get_die_id(cpu);
+		env->cpu[idx].core_id	= core_id >= 0 ? core_id : -1;
+		env->cpu[idx].socket_id	= socket_id >= 0 ? socket_id : -1;
+		env->cpu[idx].die_id	= die_id >= 0 ? die_id : -1;
 	}
 
 	env->nr_cpus_avail = nr_cpus;
-- 
2.47.0.338.g60cca15819-goog

