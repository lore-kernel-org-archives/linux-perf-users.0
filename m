Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1A5013C2
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602436; cv=none; b=T5NfV2Ta2v8jnaAtrAiejxFU5G2iAd61LKsKGdn8DzPHKEfFbfdypDWkHzlYWSlA6wI//IvOqbDL3XD6wxRGnQ4fsDIi5RSNfftzn0Ucs8LZio9WqgERcqL8AXONbNiCDOjXZQx/5yhqikqk0Tx5PyN4kL2nlESvXW2B8E5tJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602436; c=relaxed/simple;
	bh=3/ksr6dJ9u+8+78rhBbuNe1Illfjcqctrj4X9hAdg80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eb3DwxGJBe8HVVEuDpsJrxvCfBEZpXq1bC/t9YUFZmGyiR9eCIMS7aHcUDnLL/GRNV1MzzNADDBiNPP/j9jxj1rYCEsIw4bgDouIEWsZ8sp1SVrTfkAfJjVvQFeh4TN1tHqa+TtAtgVbBqrH5Osfo6UkRcMWtIU3s5IA2V9pGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdiuIaVx; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdiuIaVx"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94a158dc8so4952765ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602434; x=1790207234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDO7V9sktC4DN+WfGrw9qWRgLecZHvX85rjze0faLb8=;
        b=GdiuIaVxdS4tvSShGZ66mxJBl/CBngyzg9oMNfAFTttijKwx/NMTnnjmeVkYLerXSX
         56q7lvKv+UYhBX+4HmijA5yEt7ri4K8qEL1KPmyNEF0FJiy6sd9Gb6mCvSIoLT4H0t/o
         5yWXrcQlA8Sy+dIT15rwYOPXJelgxm4VG4CGN7pDPHzcfK5AzH1uqkJwrmGZDAg+jW9/
         FLMU6es4Tg6pXuCe1pc8y6FdNKroyntjT8Bpk1nM8gl2t4Qvu1fBhH5aHj4OOg6v0805
         KggRjA96T35FS/G/vcuxRBL8AXpXjIA/pWjLCciLwvTP1AtRf/tYbhmYlkLVq26gu+Gb
         +tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602434; x=1790207234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDO7V9sktC4DN+WfGrw9qWRgLecZHvX85rjze0faLb8=;
        b=k0OorO5xzoXYZXegKtglvOY7CvcSt6EkKOeSSNi9IDiqX8CrMh7Y4qVeiyk+xrpZ4/
         Hz3Sziy+bB6bc1T0RjRff7KNxAhlgbSgSYdAPbgqK97wzEIVqxYxR+2IMGJwDObTIGJV
         SMZq74r9fFtXkSeT5kdAHjY0lPGKWdAja6etdGlmf4v1cKPECfK/E9T1ZQ0uKmmg+mhc
         FamK4KC9xb2PJrU3cJ+mCsJvywKYuN5nTXJf/2JjAifV6dC5gssaVb5MNp/MPox4uuIN
         LzkAgG4aAichDSC4DNZUQtHj33e/woAgudIV9ynoQ/GEY7BkRwQDt+hpWTCLifq9qh9d
         Xn3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVIlH7mHvi3zxOzrIF3HZkTTLV1LcL5OJWBNUDVnLFZId1OVYcR9UDE9yOLGMIEZU9OnCfIEO8OSkSSQgxXDZ0@vger.kernel.org
X-Gm-Message-State: AFuF++koBWKfK6qlf1LJEm81uswlfWSiYs9AgIsAL0f/noeZHVqGAL1v
	XQ+3FKbgwffNdJR2qDLYfDM7yi/zEjeSzkunyLY7Adkehdf2zw97OOTLhFQ82DR5tUdxK80Lv8Q
	w7jE5pwzV/Q==
X-Received: from dlbqq3.prod.google.com ([2002:a05:7022:ed03:b0:143:5dff:1bf6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c91:b0:38e:bfe:81e9
 with SMTP id 98e67ed59e1d1-39e1e259f98mr10463965a91.1.1789602433682; Wed, 16
 Sep 2026 16:47:13 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:48 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com> <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-6-irogers@google.com>
Subject: [PATCH v3 5/9] perf evlist: Toggle merged_hybrid_group properly in enable/disable
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Merging makes the merged event the leader of the events of the other
core PMUs so their histograms can be linked, but the result isn't a
real event group. Each event keeps its own file descriptor and has to
be enabled and disabled in its own right.

__evlist__enable(), __evlist__disable() and evlist__is_enabled() skip
anything that isn't a group leader, and the first two then walk the
group members of the events they do act on. For a merged set that is
backwards: the members are skipped by the leader test, so their file
descriptors are never touched, and the walk over the leader's members
only updates the bookkeeping in evsel->disabled.

Treat an evsel with merged_hybrid_group set as a leader so that it is
enabled and disabled in its own right via its own file descriptors.

perf top enables and disables by event name. A merged member carries
the name of its own PMU rather than the name that was asked for, so
also match it against its leader's name, otherwise naming the event
toggles only part of the merged set.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/evlist.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 930efbb66bc8..22eb01116992 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -753,7 +753,9 @@ static bool evlist__is_enabled(struct evlist *evlist)
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!pos->core.fd)
+			continue;
+		if (!evsel__is_group_leader(pos) && !pos->merged_hybrid_group)
 			continue;
 		/* If at least one event is enabled, evlist is enabled. */
 		if (!pos->disabled)
@@ -767,14 +769,19 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 	struct evsel *pos, *member;
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	bool has_imm = false;
+	bool match;
 
 	/* Disable 'immediate' events last */
 	for (int imm = 0; imm <= 1; imm++) {
 		evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 			pos = evlist_cpu_itr.evsel;
-			if (evsel__strcmp(pos, evsel_name))
+			match = !evsel__strcmp(pos, evsel_name);
+			if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+				match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+			if (!match)
 				continue;
-			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+			if (pos->disabled || (!evsel__is_group_leader(pos) &&
+					      !pos->merged_hybrid_group) || !pos->core.fd)
 				continue;
 			if (excl_dummy && evsel__is_dummy_event(pos))
 				continue;
@@ -789,9 +796,12 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 	}
 
 	evlist__for_each_entry(evlist, pos) {
-		if (evsel__strcmp(pos, evsel_name))
+		match = !evsel__strcmp(pos, evsel_name);
+		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+		if (!match)
 			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
@@ -827,21 +837,28 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 {
 	struct evsel *pos, *member;
 	struct evlist_cpu_iterator evlist_cpu_itr;
+	bool match;
 
 	evlist__for_each_cpu(evlist_cpu_itr, evlist) {
 		pos = evlist_cpu_itr.evsel;
-		if (evsel__strcmp(pos, evsel_name))
+		match = !evsel__strcmp(pos, evsel_name);
+		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+		if (!match)
 			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
 		evsel__enable_cpu(pos, evlist_cpu_itr.cpu_map_idx);
 	}
 	evlist__for_each_entry(evlist, pos) {
-		if (evsel__strcmp(pos, evsel_name))
+		match = !evsel__strcmp(pos, evsel_name);
+		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
+			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
+		if (!match)
 			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
-- 
2.55.0.1082.g2b9226bbc0-goog

