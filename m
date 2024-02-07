Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F4692ED
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Feb 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345442; cv=none; b=KLB+pYb6pGZPpXcOt6BEEnMWNl1zUFJ+E2ojZOFHmO80cULOb6dqLWgCDyI59PnjqwZuALFsJXRjmrJWrxoK1KLCcjX98Wvi20TMpI9G6Q2ZBsxvo/BzZZTp05YRIRu3Y3vEntkUg3kl3t4O2XIIc3iIBFG8hVNdxptmM6vKlgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345442; c=relaxed/simple;
	bh=QOZ3AXSow+69/jSpTKwTzsRv+NqoTfrDzrJ1ZUXaoRk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZyQ/sB75gYYCk32apOjtgUpIYI35k8PpE1FODRtKQa1c25hVGbCktkMCJZ+9kum6ZMeuR11Dr0koq9W3cWoRIAloAGGDvK6BWwe+wzweF3I5qQSQvLsSQOjs63k1q5wfLddC3hVwzuH8On3Tsyh5CwOTJ9KhqLBjdmHIG+n7ThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRNiyyzd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRNiyyzd"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6bad01539so1673145276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Feb 2024 14:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707345440; x=1707950240; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvZ5WUWTj8QrlPAJDzYrQkQZ6y0b1KQREpo25gbb83I=;
        b=cRNiyyzdmB+oZrqLdqiwlC3u8oyDF1StzYlMviQhJ8GkD7AN7/N24xJaOu5e6hub27
         sl/agywiSWb8moNlaIw9Dr1gnpMFkjRs/KkiGQS54kSvR6ec2lrRuQhwr8aX9AjAIKq/
         2KGgIFb4ZNxpM2fjPZf5SYyyPvrBZ1JKI+YEbuxRRZ2krwZPJcmZqnTMaopR6e0z/g0p
         ttZbDsGSUivaFGi5ZrqubdvmiC1H5Wkz0SZNGCFMExJnMe2Fbfw/7Qxz/sVVpAtIxdrO
         /2pfR+1jEGFar1SY3BMbkVj9S5guYQpYjDx8YTV9bUn+hpyvkr2JzhPKXLyYxXEg8eUX
         GeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707345440; x=1707950240;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvZ5WUWTj8QrlPAJDzYrQkQZ6y0b1KQREpo25gbb83I=;
        b=ToO1XYz2iRWzMA6MeACIZR5EeKr0GNWCNAKidZEfvYjwdbITy7WYot/JojKYVqzSJg
         0slvH7eRNyeesC88TWPrjhPkNw1tcuQBGl94C7GAgkFs+NY1Wb4MyhMfzPbeZy9Oe5+/
         0c+5aTFhJJVRlGiJEOIubJ3u2TDNPHnQD6mfFrj8Gp1W9YnM2fRbpZYC7UtdB/kQ2FBA
         Yli3ql2CyKdv2aD/VUQGQ8WHQG0iCtFpr2HhiiHWP2wGFyeqPmvosYVwCEaMhMOrsoFA
         Gp77Pz6IlunZ8AKw776THxNDPVFjxWSECH05ava3doX935LIbMUwsmaR5d6mt3HSSk3S
         Z5CA==
X-Gm-Message-State: AOJu0YzDUF+VBuz9LhI66bF4NO9iZ6htsbngKu23AvSWNcyRxU7DSH3f
	w8GLjoWgBcCCmJFJsDOeVNKSWerp4bEZd6mkvmGGe/V1UMVB5I4nYlWbvEcAjx6oOWT4tSjNlaZ
	hO8xxBA==
X-Google-Smtp-Source: AGHT+IGB8BWCXe5U68/XAhtHPMxrwQQvYrTIPYLgx2ttoL7m8m9PF41iREr1/1EAE/thjFA5m1nbUYn5BKby
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b420:757c:5706:d53b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1a46:b0:dc6:b813:5813 with SMTP
 id cy6-20020a0569021a4600b00dc6b8135813mr230558ybb.9.1707345440025; Wed, 07
 Feb 2024 14:37:20 -0800 (PST)
Date: Wed,  7 Feb 2024 14:36:39 -0800
In-Reply-To: <20240207223639.3139601-1-irogers@google.com>
Message-Id: <20240207223639.3139601-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 6/6] perf maps: Locking tidy up of nr_maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After this change maps__nr_maps is only used by tests, existing users
are migrated to maps__empty. Compute maps__empty under the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/maps.c    | 10 ++++++++--
 tools/perf/util/maps.h    |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4911734411b5..3da92f18814a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -440,7 +440,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 		return NULL;
 
 	/* Assume maps are set up if there are any */
-	if (maps__nr_maps(thread__maps(thread)))
+	if (!maps__empty(thread__maps(thread)))
 		return thread;
 
 	host_thread = machine__find_thread(host_machine, -1, pid);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 0ab19e1de190..e59118648524 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -541,7 +541,13 @@ void maps__remove(struct maps *maps, struct map *map)
 
 bool maps__empty(struct maps *maps)
 {
-	return maps__nr_maps(maps) == 0;
+	bool res;
+
+	down_read(maps__lock(maps));
+	res = maps__nr_maps(maps) == 0;
+	up_read(maps__lock(maps));
+
+	return res;
 }
 
 bool maps__equal(struct maps *a, struct maps *b)
@@ -865,7 +871,7 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 
 	parent_maps_by_address = maps__maps_by_address(parent);
 	n = maps__nr_maps(parent);
-	if (maps__empty(dest)) {
+	if (maps__nr_maps(dest) == 0) {
 		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
 		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
 		struct map **dest_maps_by_address =
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4bcba136ffe5..d9aa62ed968a 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -43,8 +43,8 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 struct machine *maps__machine(const struct maps *maps);
-unsigned int maps__nr_maps(const struct maps *maps);
-refcount_t *maps__refcnt(struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps); /* Test only. */
+refcount_t *maps__refcnt(struct maps *maps); /* Test only. */
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
 void *maps__addr_space(const struct maps *maps);
-- 
2.43.0.594.gd9cf4e227d-goog

