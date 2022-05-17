Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8484C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 05:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiEQF1d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbiEQF1c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 01:27:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DC920192
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 22:27:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e202-20020a25e7d3000000b0064dc69dfa9cso3253538ybh.16
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 22:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=kZC9vjLshBsXs8V1aS7UF7Ub8JOSABbjIq1MLmPcyk0=;
        b=CnvZ1IkRHWt48aXSXWcPL3tpvERsiJZVsR/J20crf6jojo+jLdKyW5GEwuz562+ivE
         aEj4zBVGtXdnCmpbzLIhb5/OmtUOMYz8gxJG3cYetgdOYnaIBlD/DF8lRgN3SWle73gd
         y8nYUMBw+Dylf+MpmAkwUn55FnXlhejqcO/TkdeageKvyuj7aWFvP5RrMNc/eYsaWjJd
         37gnoJp01I5nHDf/qZ7zcIbScvfk+nBh+hBp7QrLO+SL4i4ncyFBlk2BDN5cNMkqn8J0
         8utKuIMHOFNAsbgem/Gxbcs0k1hFzf/FpCEflihkgXH3cUHip+zI/wFauTuAW2Dq8BfY
         +Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=kZC9vjLshBsXs8V1aS7UF7Ub8JOSABbjIq1MLmPcyk0=;
        b=ULnMO1xYjIazCrniYNf8V/5U/QASnQQC+An6cQoikQYdBuFPm8K3JUjBOVVkJ9UmWl
         o56Kq8Is/dzX9aPo9Ft7L3bh//UimNSwwIBA4fkfobmqyRslIF9Y98zf72Ag0yUfYA0d
         tVkte9OuWAMbI6841AR7PMhsChgbUKIqb9S4qhXzqDi47Z4L8EPbXtFgfmt/gVWuo3Fw
         8timSPGCUQ5O2HCvnpPS0Fs4vhItz4DES87PoSNP8Iweyb0Z0MYeAv0AcTzE5/2bATxY
         5k/6A7PLhrODiC6f9mULHP0dfNn41VC+ghn09DAkcddj/7Takw/BNps90Q8EZBsAkyxJ
         k9hg==
X-Gm-Message-State: AOAM531DHoskJIYkjc6iWJ9oBZgOeR8a6lqS++QynZY1Igg8JVo51oy+
        p7e70oVQoy2p3ng5f/x2176YdRukwQeO
X-Google-Smtp-Source: ABdhPJwjJmjeFgtvINrHxACkKgCiZNS42ZJCXfIya6VTtU3JaogX+ktjEHtQQOJR0ltCDIj9u0JD4XBgRfTZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d585:282c:3f88:36e3])
 (user=irogers job=sendgmr) by 2002:a05:6902:52:b0:645:bd1:970e with SMTP id
 m18-20020a056902005200b006450bd1970emr21062686ybh.413.1652765249968; Mon, 16
 May 2022 22:27:29 -0700 (PDT)
Date:   Mon, 16 May 2022 22:27:23 -0700
In-Reply-To: <20220517052724.283874-1-irogers@google.com>
Message-Id: <20220517052724.283874-2-irogers@google.com>
Mime-Version: 1.0
References: <20220517052724.283874-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 1/2] perf evlist: Keep topdown counters in weak group
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Intel Icelake, topdown events must always be grouped with a slots
event as leader. When a metric is parsed a weak group is formed and
retried if perf_event_open fails. The retried events aren't grouped
breaking the slots leader requirement. This change modifies the weak
group "reset" behavior so that topdown events aren't broken from the
group for the retry.

$ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,t=
opdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,c=
ache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,bac=
lears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1

 Performance counter stats for 'system wide':

    47,867,188,483      slots                                              =
           (92.27%)
   <not supported>      topdown-bad-spec
   <not supported>      topdown-be-bound
   <not supported>      topdown-fe-bound
   <not supported>      topdown-retiring
     2,173,346,937      branch-instructions                                =
           (92.27%)
        10,540,253      branch-misses             #    0.48% of all branche=
s          (92.29%)
        96,291,140      bus-cycles                                         =
           (92.29%)
         6,214,202      cache-misses              #   20.120 % of all cache=
 refs      (92.29%)
        30,886,082      cache-references                                   =
           (76.91%)
    11,773,726,641      cpu-cycles                                         =
           (84.62%)
    11,807,585,307      instructions              #    1.00  insn per cycle=
           (92.31%)
                 0      mem-loads                                          =
           (92.32%)
     2,212,928,573      mem-stores                                         =
           (84.69%)
    10,024,403,118      ref-cycles                                         =
           (92.35%)
        16,232,978      baclears.any                                       =
           (92.35%)
        23,832,633      ARITH.DIVIDER_ACTIVE                               =
           (84.59%)

       0.981070734 seconds time elapsed

After:

$ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,t=
opdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,c=
ache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,bac=
lears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1

 Performance counter stats for 'system wide':

       31040189283      slots                                              =
           (92.27%)
        8997514811      topdown-bad-spec          #     28.2% bad speculati=
on         (92.27%)
       10997536028      topdown-be-bound          #     34.5% backend bound=
           (92.27%)
        4778060526      topdown-fe-bound          #     15.0% frontend boun=
d          (92.27%)
        7086628768      topdown-retiring          #     22.2% retiring     =
           (92.27%)
        1417611942      branch-instructions                                =
           (92.26%)
           5285529      branch-misses             #    0.37% of all branche=
s          (92.28%)
          62922469      bus-cycles                                         =
           (92.29%)
           1440708      cache-misses              #    8.292 % of all cache=
 refs      (92.30%)
          17374098      cache-references                                   =
           (76.94%)
        8040889520      cpu-cycles                                         =
           (84.63%)
        7709992319      instructions              #    0.96  insn per cycle=
           (92.32%)
                 0      mem-loads                                          =
           (92.32%)
        1515669558      mem-stores                                         =
           (84.68%)
        6542411177      ref-cycles                                         =
           (92.35%)
           4154149      baclears.any                                       =
           (92.35%)
          20556152      ARITH.DIVIDER_ACTIVE                               =
           (84.59%)

       1.010799593 seconds time elapsed

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evsel.c | 12 ++++++++++++
 tools/perf/util/evlist.c         | 16 ++++++++++++++--
 tools/perf/util/evsel.c          | 10 ++++++++++
 tools/perf/util/evsel.h          |  3 +++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/ev=
sel.c
index ac2899a25b7a..00cb4466b4ca 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include "util/evsel.h"
 #include "util/env.h"
+#include "util/pmu.h"
 #include "linux/string.h"
=20
 void arch_evsel__set_sample_weight(struct evsel *evsel)
@@ -29,3 +30,14 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr=
 *attr)
=20
 	free(env.cpuid);
 }
+
+bool arch_evsel__must_be_in_group(const struct evsel *evsel)
+{
+	if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
+	    !pmu_have_event("cpu", "slots"))
+		return false;
+
+	return evsel->name &&
+		(!strcasecmp(evsel->name, "slots") ||
+		 strcasestr(evsel->name, "topdown"));
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ae56b062f44..91bbe4c069eb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1742,8 +1742,17 @@ struct evsel *evlist__reset_weak_group(struct evlist=
 *evsel_list, struct evsel *
 		if (evsel__has_leader(c2, leader)) {
 			if (is_open && close)
 				perf_evsel__close(&c2->core);
-			evsel__set_leader(c2, c2);
-			c2->core.nr_members =3D 0;
+			/*
+			 * We want to close all members of the group and reopen
+			 * them. Some events, like Intel topdown, require being
+			 * in a group and so keep these in the group.
+			 */
+			if (!evsel__must_be_in_group(c2) && c2 !=3D leader) {
+				evsel__set_leader(c2, c2);
+				c2->core.nr_members =3D 0;
+				leader->core.nr_members--;
+			}
+
 			/*
 			 * Set this for all former members of the group
 			 * to indicate they get reopened.
@@ -1751,6 +1760,9 @@ struct evsel *evlist__reset_weak_group(struct evlist =
*evsel_list, struct evsel *
 			c2->reset_group =3D true;
 		}
 	}
+	/* Reset the leader count if all entries were removed. */
+	if (leader->core.nr_members =3D=3D 1)
+		leader->core.nr_members =3D 0;
 	return leader;
 }
=20
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5fd7924f8eb3..1cf967d689aa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3103,3 +3103,13 @@ int evsel__source_count(const struct evsel *evsel)
 	}
 	return count;
 }
+
+bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe=
_unused)
+{
+	return false;
+}
+
+bool evsel__must_be_in_group(const struct evsel *evsel)
+{
+	return arch_evsel__must_be_in_group(evsel);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 52dc5fd106b1..84755fabc544 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -499,6 +499,9 @@ bool evsel__has_leader(struct evsel *evsel, struct evse=
l *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
 int evsel__source_count(const struct evsel *evsel);
+bool evsel__must_be_in_group(const struct evsel *evsel);
+
+bool arch_evsel__must_be_in_group(const struct evsel *evsel);
=20
 /*
  * Macro to swap the bit-field postition and size.
--=20
2.36.0.550.gb090851708-goog

