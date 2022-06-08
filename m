Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F9C43334
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Jun 2022 22:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiFHWoM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiFHWoL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Jun 2022 18:44:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880831212
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 15:44:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t1-20020a170902e84100b001689cab0be3so1160820plg.11
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=ekhZ4wBvlPn/dbdAv6DpZoPYJXSrjHhH3vsu1Ns85VYgtvnHjevVS+J3GQ6jXRTSfX
         3phJNq0VEY5NXH5SQCmeb3Wq4ya5jZRnyK3jkeGs7V79agvHEAOec6tOLhKA0RW67VzT
         lnJC1t81mZiCjUex1/HhgnUlDvtebaL8C1CERHhIqNNS5COd4+lb2EudOnc17DiBvm7n
         kxr5s3eFaqc8gnb76bOXNg+jY/wA6p37zN8dLeK7s6Hnqm4Zuf8hGGepLgpmAFXl5bKm
         OJXZ6wLTeFcASLUd9lTPgYjpbXPXUJsUR2RAKHoMZt38KoirvOb8O/Sj4+wiMub0gf1U
         e52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=Yr0vrY5VXjISRKUirGeSw47K8a9f0VeK2Cdd4DYEtR0K6qE3dBvm9FlCNolJKdbppL
         dnbhFDJPh47dBh8tvcOsjlCrIcxw6Qln27hT/Cqr4jcOKL7KIFTshY2/Qau4FFBqNQo1
         FJYayJU9vZYx7oaEKMRwsMXcYg4aDcoDSc0e0atqDLZ63EC3W5gA+aKVNtT5TLyN3IgD
         1Hd3P+swsoZcQSyXNI1IFyH6kfduoCf3s5+DBxFPUPc9OWNliVHT+D7fcsJeE6hySr/Z
         FC8fwtWIJYddDdOtLgqmS/mbHK71aqd3lvHC1fXq8lA9rb43GVtDHDEOPEYTirlfE3Y6
         iQVw==
X-Gm-Message-State: AOAM532sRgKa/Zk1BS98i3RlBjDxrTza6po0x0XiaN09q3HGjLAKqTcP
        w6He1y0PL8xecml6TsjE3yTmPjSRNZYg
X-Google-Smtp-Source: ABdhPJwiZrRqHCYP62YKEXvoVQ53Bbqy96qtS43wIUeLesJ+bttYHn5FJ24TSzmDscTk0ZfS1Ktj1g/cMxU6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de48:5efa:e4a1:2219])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1a91:b0:51c:2ef4:fa1c with SMTP
 id e17-20020a056a001a9100b0051c2ef4fa1cmr13542691pfv.75.1654728250194; Wed,
 08 Jun 2022 15:44:10 -0700 (PDT)
Date:   Wed,  8 Jun 2022 15:43:50 -0700
In-Reply-To: <20220608224353.1176079-1-irogers@google.com>
Message-Id: <20220608224353.1176079-2-irogers@google.com>
Mime-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 1/4] libperf evsel: Open shouldn't leak fd on failure
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the perf_event_open fails the fd is opened but the fd is only freed
by closing (not by delete). Typically when an open fails you don't call
close and so this results in a memory leak. To avoid this, add a close
when open fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c1d58673f6ef..952f3520d5c2 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -149,23 +149,30 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			int fd, group_fd, *evsel_fd;
 
 			evsel_fd = FD(evsel, idx, thread);
-			if (evsel_fd == NULL)
-				return -EINVAL;
+			if (evsel_fd == NULL) {
+				err = -EINVAL;
+				goto out;
+			}
 
 			err = get_group_fd(evsel, idx, thread, &group_fd);
 			if (err < 0)
-				return err;
+				goto out;
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
 						 cpu, group_fd, 0);
 
-			if (fd < 0)
-				return -errno;
+			if (fd < 0) {
+				err = -errno;
+				goto out;
+			}
 
 			*evsel_fd = fd;
 		}
 	}
+out:
+	if (err)
+		perf_evsel__close(evsel);
 
 	return err;
 }
-- 
2.36.1.255.ge46751e96f-goog

