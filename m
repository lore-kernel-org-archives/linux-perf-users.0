Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E253C0603
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541585; cv=none; b=BxGu2D5s5AhS6nyBgJy3M45GWTmHDl0DhlG2r1rcUTtLp6vfKEgY4NB2GnWMka5kNoFp+nHHOtv38OI5pf4TtC/3v4/n7fmYIegiUzxzNrhzt2CvHCajAt5GsNSrEAe1lIbkUG3whseqe1uvz7glD3M+UtgJBLZPQNvqsCnM1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541585; c=relaxed/simple;
	bh=lmmb5C5QoCUveOXRC+IAgOLwr1aXMyBbcNWOb+I80LI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5go0tvs9wxXSRobcO4QZ1vVC2K1RnPe5yob+8hpBjKYpwqa3on/COYZ/E3l/qLRmA94ydZ2d4VWiLyHUOpU4UFYLwTL6B4ZcgG8zo/srQFynRYPycmHlHfZtOvAVg4Y96Epls4Syw+sKuoI61Ur8oIO6NKc4JVcnuddCWjKnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5yNTnYS; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5yNTnYS"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so6436716a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789541583; x=1790146383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sM0uXT6ENewXqS+bR4jgxW/5nXPebJj72MQro/DIh8=;
        b=W5yNTnYSkZ1MC9bY8mGbsB6bPhw4nNUmXiYc8u6YG4v3fkVmcaOcoktJAlLmuXWUwN
         KrwT7AL91fn1uEPgpfli567thT+Boan4nWj8hf+12AUN193NkCOp0B47zzRO27Dj0Qxs
         JKALmL7jb8dcoCJfHPwyo0MyzYPPHebLASPPY34uGWDL318iK65zUmfsW9ib8hjc9xyH
         gPfaTxu4MQHyDfIQoqbGrryozucMsnlMhfi5dV255aKd4UKAf9Hu/oWjHZXofDbbIO0b
         9EQHTnbmj1vyApeTTB46kIIXMg4q2vcO6ttcwz8IcVSjVwQv1Kgx0hYSm374eyFqcA/s
         Fp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541583; x=1790146383;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sM0uXT6ENewXqS+bR4jgxW/5nXPebJj72MQro/DIh8=;
        b=LgNy5FM9OW1LACh7G1UDBE+t0z+tx8fV2qBqIU2oHalEUHwWoYcMhpDecw6ldlWUV6
         091P0dm2CXI/DjVlnKgpN69ZFVXp3KvjsLRkPuGyW2kQoy1UtW6jtVKIJILezStU8IL2
         H7J/vC4ZLuQI82B+pHJ4e4Lcf77HZvl+k4ycyI7TKpqmTSEcmLN6kQ6j+gw5MidVycp+
         TXCEFfIlAEqhS34iYudNNPmCV+CsRuFINuzlQqL2p1SUvyKfzD2RV/lQnpgQJBigbmBp
         Yq7+MO9fNmXQHOzaeywNmiMm9+MKhSWpacLa0zlk2oudRy7fV7Cspv2FqXppqnRSgVFm
         YcOQ==
X-Gm-Message-State: AFuF++nJfqQm+CnemiRd9mYTaEBOkT5UtcAhT+Lle87HYFrqhZu6s+L/
	JzMzLNj9c8/u7DFNKx4muUkTWNgZpUTbUkeuT7nXXzQjtHR/f4FjBbQz+f+wwxE2/wFTOAGgpAM
	mi0k4a8gOEw==
X-Received: from dlam19-n1.prod.google.com ([2002:a05:701b:2093:10b0:143:6c23:2cab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39a3:b0:39e:233f:cee9
 with SMTP id 98e67ed59e1d1-39e233fd063mr2160209a91.11.1789541583370; Tue, 15
 Sep 2026 23:53:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:52:44 -0700
In-Reply-To: <20260916065248.3153556-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916065248.3153556-6-irogers@google.com>
Subject: [PATCH v2 5/9] perf evlist: Toggle merged_hybrid_group properly in enable/disable
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
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
enabled and disabled in its own right, and don't walk the members of a
merged leader.

perf top enables and disables by event name. A merged member carries
the name of its own PMU rather than the name that was asked for, so
also match it against its leader's name, otherwise naming the event
toggles only part of the merged set.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 47 +++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 930efbb66bc8..034032955d33 100644
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
@@ -789,16 +796,21 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
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
 		pos->disabled = true;
 
-		for_each_group_member(member, pos)
-			member->disabled = true;
+		if (!pos->merged_hybrid_group) {
+			for_each_group_member(member, pos)
+				member->disabled = true;
+		}
 	}
 
 	/*
@@ -827,28 +839,37 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
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
 		pos->disabled = false;
+		if (!pos->merged_hybrid_group) {
+			for_each_group_member(member, pos)
+				member->disabled = false;
+		}
 
-		for_each_group_member(member, pos)
-			member->disabled = false;
 	}
 
 	/*
-- 
2.55.0.1032.g73a4cd73de-goog

