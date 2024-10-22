Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282933DF;
	Tue, 22 Oct 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556994; cv=none; b=F8rZwaGWWzIyCXw56hmEHq+EmbTO7Wgi4ucyOYvcmZAEqGpNkTZRGDRhlh7qLA5crzjhsN4KVYvnJSOFKnMph476lbqv+yUW8MlMya9IKQzjh62cdMN1+o68HJETFy0asR5c5WjZjpSIXWNe3ncpiv8gqitvlm91vhIAIIYVF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556994; c=relaxed/simple;
	bh=0trWI6aKnWXJRIWmRiUZ02jhbTAEw4gb5S43ZDWA2Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntxQwDF+fojDGiwpvi2Ue13JJv2lrkhOept37165dHkUuzsbOMWXLMKZI4R3HBBWWD5ExkQpiKP1s6+VdLS8h6OqJVqSDUUtdz/TCozffyCB+X0aZZSrdZVn1Hzkn1IQ/rojd63SSp5rz0PFelW7Syo+LY/eWW4KR1QQfKK6l+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZyfV10VO; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZyfV10VO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=l86PKJYHxpCVury3Aip81gz2MyfrzRyWfLwP5FGx1m4=; b=ZyfV10VOpcsErRx3
	dclNRyJhOtR67Qv2rRG0dLLfh7DfmeOKfPMdT0wzG7Q2VPFc8YMxNl/24qxcp5UbE76MwCdS3nvcc
	HVh5U1ZgcM+cw+J2whjEe4Bs08NC3DeV9U6iYk9rWdhX81kN+9sbG0iG6eu5Ml1rbeUlqsIMA0lIV
	ypo+dnF6vsdZTt79HgtPHAxOUtHTAeSyoGMQLV0A2wCkTo6gYPgbLt03EqJPD73RVtOkWJ1Fs2H61
	F4m63XY6RrrugX2z5yJNLAyskjM1PA+/OhYkCFx4rjFbs4ShYxQK9swCP9QmN9CLNh7MhnRCMcbWE
	T+j+Ns+vrKjset+x8w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t32mL-00CePD-1l;
	Tue, 22 Oct 2024 00:29:41 +0000
From: linux@treblig.org
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf: Remove unused del_perf_probe_events
Date: Tue, 22 Oct 2024 01:29:40 +0100
Message-ID: <20241022002940.302946-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

del_perf_probe_events() last use was removed by
commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")

Remove it.

It was the last user of probe_file__del_events, so remove it as well.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/probe-event.c | 35 -----------------------------------
 tools/perf/util/probe-event.h |  2 --
 tools/perf/util/probe-file.c  | 19 -------------------
 tools/perf/util/probe-file.h  |  1 -
 4 files changed, 57 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 698a92875374..e8e381bddded 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3705,41 +3705,6 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 }
 
-int del_perf_probe_events(struct strfilter *filter)
-{
-	int ret, ret2, ufd = -1, kfd = -1;
-	char *str = strfilter__string(filter);
-
-	if (!str)
-		return -EINVAL;
-
-	/* Get current event names */
-	ret = probe_file__open_both(&kfd, &ufd, PF_FL_RW);
-	if (ret < 0)
-		goto out;
-
-	ret = probe_file__del_events(kfd, filter);
-	if (ret < 0 && ret != -ENOENT)
-		goto error;
-
-	ret2 = probe_file__del_events(ufd, filter);
-	if (ret2 < 0 && ret2 != -ENOENT) {
-		ret = ret2;
-		goto error;
-	}
-	ret = 0;
-
-error:
-	if (kfd >= 0)
-		close(kfd);
-	if (ufd >= 0)
-		close(ufd);
-out:
-	free(str);
-
-	return ret;
-}
-
 int show_available_funcs(const char *target, struct nsinfo *nsi,
 			 struct strfilter *_filter, bool user)
 {
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 4850e52f274e..61a5f4ff4e9c 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -167,8 +167,6 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 
 struct strfilter;
 
-int del_perf_probe_events(struct strfilter *filter);
-
 int show_perf_probe_event(const char *group, const char *event,
 			  struct perf_probe_event *pev,
 			  const char *module, bool use_stdout);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 3d50de3217d5..ec8ac242fedb 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -366,25 +366,6 @@ int probe_file__del_strlist(int fd, struct strlist *namelist)
 	return ret;
 }
 
-int probe_file__del_events(int fd, struct strfilter *filter)
-{
-	struct strlist *namelist;
-	int ret;
-
-	namelist = strlist__new(NULL, NULL);
-	if (!namelist)
-		return -ENOMEM;
-
-	ret = probe_file__get_events(fd, filter, namelist);
-	if (ret < 0)
-		goto out;
-
-	ret = probe_file__del_strlist(fd, namelist);
-out:
-	strlist__delete(namelist);
-	return ret;
-}
-
 /* Caller must ensure to remove this entry from list */
 static void probe_cache_entry__delete(struct probe_cache_entry *entry)
 {
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 0dba88c0f5f0..c2bb6a5b9dcc 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -44,7 +44,6 @@ struct strlist *probe_file__get_namelist(int fd);
 struct strlist *probe_file__get_rawlist(int fd);
 int probe_file__add_event(int fd, struct probe_trace_event *tev);
 
-int probe_file__del_events(int fd, struct strfilter *filter);
 int probe_file__get_events(int fd, struct strfilter *filter,
 				  struct strlist *plist);
 int probe_file__del_strlist(int fd, struct strlist *namelist);
-- 
2.47.0

