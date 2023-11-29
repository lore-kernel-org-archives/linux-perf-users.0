Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jyc6mdJl"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8210C0
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 13:34:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf61210e3so3662987b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 13:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293695; x=1701898495; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=Jyc6mdJlqSGh9xCX+wfM42GM0qBnGD5xq2Oe1Q/ZhFBJ+UfF4AblVf9RHARky/hIig
         ztPcoXUdNalW/qrsjAUmWjj1hjgba/6ZexwnXmIYH+dFR0uhLx89qne/fQk9fvhSBlQl
         voc+aAcSqUsOkDhw4WABVcUCD23kmi5lwkHOLQXwsOYvpbdM2nt1eNRvQ7HlQyyHaYFb
         t1XhYlb4lm/y/dDlECVeDawqQ5QIygMVx9YGt6Bo9Xx+cVXmdWB8fLawvyVMbgAkScPv
         BlkF5ECe/9AnWYT0K3sPU5qPYrzwoDTmhPidNhiA6zLGvMI1c2oqP7BLJDOP9siqINMJ
         Ji0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293695; x=1701898495;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=VUMZ/kF3G7eQrVpHzUGMhThrkRUXJOR0gSJsJSnxEdJTga/JOgstec85SheaL7y6DR
         MHCJZBJ871qVsjabO/qBWSPEFWtm2+iWfIl4ekbnvJpB0wkVGpyO3CDhDYk6uM2k0k8/
         hT/9eKUAodiF+H0M9w+dwqIfBf/sEG7+/fozqyvNcVi8uaQ4K9H1k57z5UFtJBkRCwiC
         etF+TTblaVFfbCR0Zpa5OBA9umPwP2PjyhSDeybZYZ6mIhkmZrrCokIIms0zG0ld6s35
         HqwpsNH2qU04XdTrJ4oRbPx5cmG18m8VOsIyGPxpoX/jexw11FDyfG0Bbrhy/8ZVj3JL
         tm6A==
X-Gm-Message-State: AOJu0Yz+UULMPuwVfS7xIfdjDEBDBpvglql2bPczab+0lh3tqAM55ovB
	xMV745F0GLoiIO69TknCm3x53uYhQ3MD
X-Google-Smtp-Source: AGHT+IEICmGJwWEx/cFWveuWMKJXW7UeHt41M3PhcSdHqEKs3Yz7xCSJsn+fdDN20Xs9JTdY29NEsvHj+K2n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e05:b0:5ce:dff:f7a3 with SMTP id
 et5-20020a05690c2e0500b005ce0dfff7a3mr547030ywb.10.1701293695222; Wed, 29 Nov
 2023 13:34:55 -0800 (PST)
Date: Wed, 29 Nov 2023 13:34:26 -0800
In-Reply-To: <20231129213428.2227448-1-irogers@google.com>
Message-Id: <20231129213428.2227448-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129213428.2227448-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v2 2/4] perf list: Fix json segfault
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Json output didn't set the skip_duplicate_pmus callback yielding a
segfault.

Fixes: cd4e1efbbc40 ("perf pmus: Skip duplicate PMUs and don't print list suffix by default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index a343823c8ddf..61c2c96cc070 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -434,6 +434,11 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool json_skip_duplicate_pmus(void *ps __maybe_unused)
+{
+	return false;
+}
+
 static bool default_skip_duplicate_pmus(void *ps)
 {
 	struct print_state *print_state = ps;
@@ -503,6 +508,7 @@ int cmd_list(int argc, const char **argv)
 			.print_end = json_print_end,
 			.print_event = json_print_event,
 			.print_metric = json_print_metric,
+			.skip_duplicate_pmus = json_skip_duplicate_pmus,
 		};
 		ps = &json_ps;
 	} else {
-- 
2.43.0.rc1.413.gea7ed67945-goog

