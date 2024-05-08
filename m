Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A257895;
	Wed,  8 May 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175331; cv=none; b=NJFz985d+D3yNgQV+fse/AQ3UOKls0xyv92V/P6b1Hjp2YXdi4LGWP/UgkxiHc9fugpGXDu+eHQPmqTRKzDei+MVlJ8angttJqbQ3O78rADY/DONp4iksaH4UEfj1FY/sStxJmns6TflAX/6C/Q0vkDKwrvEwgIIsO/+SUNQYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175331; c=relaxed/simple;
	bh=CfXeBIxV4C+jL/jNnDU/oY1PsdSnY5Ju4YlZNOkgAhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8zJtepCmGrEZyCX5A0xC2eSrPc3J/e+6ianuPRz2v+98G3kIUORtk8z6RjZr4JazPnh3jipuQ4ysbp8Tjgb3dt88vMO2pdh08+vRkL3eYCoE/8xy6bCFZwgoV0GzJMsYCXlmPmuARM/HEb3lAdJkIFsPqTlWICyT2ri2HVzLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59e4136010so643975766b.3;
        Wed, 08 May 2024 06:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715175328; x=1715780128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKCbsCY2oOpekUYkO38CaKdBUC+VYKdnXLVoDUKEhPo=;
        b=STtYQxhQnIGJXqeJP6jK6b4US05Rt2/d2E1r1gI01aEssMhWXQrvPhvsyDLg3t6Y4l
         roHyJP2Z05tQhnCBXUJpcjZUgAWBKlfw6Sps5v+1cMPhHwhVjvx+EmlYcw6q8SZnQZ4E
         8smsRHA1ThtIfQvK20aqHbxduZzzoq7L+gZB4v8kPdxdtnm5vgLPDYvW3i/t1QKJvM6H
         VQazGN+bn281VbPp4uvN8qxb9Lv/Q013Pangz1pSS9ZJuAcb7jXh+cIxvh0Wz67KULot
         bpAAFK93cY0Skpfw4z64uXnJOv9iFkZwUMQZlBAy/s/xaClh8NrbRx/xvym19YEXloXR
         3+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU4FukMbkapZSGIs/s+peNRF4eZVU9m24vrdz+bfAWR7qiYzwyHOKt9GqcIuH+EH+O9UIoork+L9zu//lXN2a/ZaeouMOhigCcll7xALGlDRpeAZeUqpaUAWpUKJ01G1tBB/siVOY7aQrS/JEqS/g==
X-Gm-Message-State: AOJu0YwbG2hwRPLDWuLvKHtuvy3xw3HXiNTM+OPdTcOG5dWb92uOHYDM
	xm+yL8Uumb+d1mvtG6gjoGo/teuFz0hpmiPqrlkEU4oHsyE8BCoW
X-Google-Smtp-Source: AGHT+IFnzjwfGL/1AUmtxFrhIm1P6yn//An62MfUcS0RTzT66gF5iszhTFzHplkEaVPO8EHYWJy4JA==
X-Received: by 2002:a17:906:eb09:b0:a59:aff8:c713 with SMTP id a640c23a62f3a-a59fb94ba5bmr174164766b.10.1715175327541;
        Wed, 08 May 2024 06:35:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id ze15-20020a170906ef8f00b00a59ae3efb03sm5245485ejb.3.2024.05.08.06.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:35:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: leit@meta.com,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf list: Fix the --no-desc option
Date: Wed,  8 May 2024 06:35:17 -0700
Message-ID: <20240508133518.3204221-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the --no-desc option in perf list isn't functioning as
intended.

This issue arises from the overwriting of struct option->desc with the
opposite value of struct option->long_desc. Consequently, whatever
parse_options() returns at struct option->desc gets overridden later,
rendering the --desc or --no-desc arguments ineffective.

To resolve this, set ->desc as true by default and allow parse_options()
to adjust it accordingly. This adjustment will fix the --no-desc
option while preserving the functionality of the other parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..58589f67e800 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -491,6 +491,7 @@ int cmd_list(int argc, const char **argv)
 	int i, ret = 0;
 	struct print_state default_ps = {
 		.fp = stdout,
+		.desc = true,
 	};
 	struct print_state json_ps = {
 		.fp = stdout,
@@ -563,7 +564,6 @@ int cmd_list(int argc, const char **argv)
 		};
 		ps = &json_ps;
 	} else {
-		default_ps.desc = !default_ps.long_desc;
 		default_ps.last_topic = strdup("");
 		assert(default_ps.last_topic);
 		default_ps.visited_metrics = strlist__new(NULL, NULL);
-- 
2.43.0

