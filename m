Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49F2F12B4
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720278; cv=none; b=tsgQqsusHQ5/O3Tv/cm3hrEB/lduwtrtXxywUJHzbOyXVFT45ybjhbdw75WwkCGLxSfo2H7T74GmymBdJx9xA//yt3wGco06ic1gzVZSBI0BLsCBzgzkZh0biiQvQjX4QEgOnP0c8cmuJ0i5StRFWdHPoYWQ2FMRrMcs0kU2L5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720278; c=relaxed/simple;
	bh=ua0uEFBMOTBb3uoJb6buV9MgTsEsoaNYNcEGlTINduc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZVhlb64p5YWFWmZfXLJgXkdeX/xmjQvfqmdWPCuHQL94BRQfRNTqdSMUBcTUx1zXQv9IwD1L6I6RJfjlDyAQOK6UG0WaHB9Ihq82PPpVeoF4Dy4KF0B46HIMFntaRLQBK33EV4cEtgzSNniVvdRW5fTgWT6C6jYAi8QClWxZJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snAxVbQv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snAxVbQv"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810289cd5eso4659158b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760720276; x=1761325076; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QSw4ow8SL+lOWVzRuPCyfduZDAlfxtyF/2Y5Nj25vlg=;
        b=snAxVbQvTO+FZUJzCYG+1VoZ2TKJQsoz5fiCtH6aVD9r4ZbJY8GWWlPRK1YHvHVGdf
         0MN1sxVFa3co2pfqYJlNR9I//GqATAVn41ImZ7Y9xLccrFgh1J7stuABUlcIAhhzVVbi
         6iCbUzTLRrqhMbEkMo6xEWG0SDsY7dw+mxckAWi1USzDtm/US4wgHROhvR7XFL5tZYQV
         bF+CHDhu60gDk/2mDQTxAKNdWvQs8W1tx+IzIdPuI6FLl4Sn/koKyHRzqecSbxwOKONE
         19OF2GsNCyTtAdfcG7/G3SY96BdNUDpI052eFqF5ergzuP2e1E1UC0+Im1BRWllZ5Lry
         alLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720276; x=1761325076;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSw4ow8SL+lOWVzRuPCyfduZDAlfxtyF/2Y5Nj25vlg=;
        b=dWNkceODy8Z6iQpKC9HP7/EZSAOCIWoKhdV7rY2br3ShaNJncc2ABOpusPLBVRu1FU
         Vd9uCtbWIkPzWhE/g2f8jXsYCqUEIDFKU8V30+fP0tGAt124w94c0NZDIaR4BWS+USP8
         qyiSoqeNMOpkg/LMqPgTQ21CVpbo806hbshRtGIE35Zc+UayjAPJLLh0NzS/sJ0amdRV
         2GSsV8X3lQ23B5NXp2tI3BUU/AJXQ/luFKVOwNNGpRy8Dweyg7CXaWeBcGEkLcDehXce
         6dGd7S159i/eSHmqyWOV7YPdDWHcRf3j7twH9AMan5xdHgR6FBfGDa/ftcqS5pQlyE+d
         hA7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFz6wtc62BCmka0SnV6rGo6zkBEfJlW3ObYe9Ms+/ofqfkJMVWF3567M7DizeOK+RTFTXMZwDSltKXFBsDoUfk@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvZIEluSQNw67f+nfoFyBYwR4bO4byhx+HrTduD1A9wm3Sv6D
	KcFEug2N6XMliPHTFPSZJzAZ/H7l0bJOnlqVV5l258goBuYtWAPR05ppGiumUeI2IpuhLmPHOrp
	GTZwA0aU1PQ==
X-Google-Smtp-Source: AGHT+IGfjrL+hct3mrv+6u3bwjvnZk+wFOTbMml7Ea8QfE0vvXsNXKrgmmggrkZ/GDL0+op+kepFE8GFUP9v
X-Received: from pgmj24.prod.google.com ([2002:a63:5958:0:b0:b6a:62df:89fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8a:b0:334:a180:b7ac
 with SMTP id adf61e73a8af0-334a8616ff5mr6025742637.39.1760720276506; Fri, 17
 Oct 2025 09:57:56 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017165753.206608-1-irogers@google.com>
Subject: [PATCH v1] perf parse-events: Make X modifier more respectful of groups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events with an X modifier were reordered within a group, for example
slots was made the leader in:
```
$ perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
```

Fix by making `dont_regroup` evsels always use their index for
sorting. Make the cur_leader, when fixing the groups, be that of
`dont_regroup` evsel so that the `dont_regroup` evsel doesn't become a
leader.

On a tigerlake this patch corrects this and meets expectations in:
```
$ perf stat -e '{cpu/mem-stores/,cpu/slots/uX}' -a -- sleep 0.1

 Performance counter stats for 'system wide':

        83,458,652      cpu/mem-stores/
     2,720,854,880      cpu/slots/uX

       0.103780587 seconds time elapsed

$ perf stat -e 'slots,slots:X' -a -- sleep 0.1

 Performance counter stats for 'system wide':

       732,042,247      slots                (48.96%)
       643,288,155      slots:X              (51.04%)

       0.102731018 seconds time elapsed
```

Closes: https://lore.kernel.org/lkml/18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com/
Fixes: 035c17893082 ("perf parse-events: Add 'X' modifier to exclude an event from being regrouped")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3aec86aebdc6..1a5da93f4094 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1973,14 +1973,18 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
 	 * event's index is used. An index may be forced for events that
 	 * must be in the same group, namely Intel topdown events.
 	 */
-	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
+	if (lhs->dont_regroup) {
+		lhs_sort_idx = lhs_core->idx;
+	} else if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
 		lhs_sort_idx = *force_grouped_idx;
 	} else {
 		bool lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
 
 		lhs_sort_idx = lhs_has_group ? lhs_core->leader->idx : lhs_core->idx;
 	}
-	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
+	if (rhs->dont_regroup) {
+		rhs_sort_idx = rhs_core->idx;
+	} else if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
 		rhs_sort_idx = *force_grouped_idx;
 	} else {
 		bool rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
@@ -2078,10 +2082,10 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	 */
 	idx = 0;
 	list_for_each_entry(pos, list, core.node) {
-		const struct evsel *pos_leader = evsel__leader(pos);
+		struct evsel *pos_leader = evsel__leader(pos);
 		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name;
-		bool pos_force_grouped = force_grouped_idx != -1 &&
+		bool pos_force_grouped = force_grouped_idx != -1 && !pos->dont_regroup &&
 			arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
@@ -2095,8 +2099,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 * groups can't span PMUs.
 		 */
 		if (!cur_leader || pos->dont_regroup) {
-			cur_leader = pos;
-			cur_leaders_grp = &pos->core;
+			cur_leader = pos_leader;
+			cur_leaders_grp = &cur_leader->core;
 			if (pos_force_grouped)
 				force_grouped_leader = pos;
 		}
-- 
2.51.0.858.gf9c4a03a3a-goog

