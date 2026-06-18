Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6D3FF8A7;
	Thu, 18 Jun 2026 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795794; cv=none; b=OFPHPrr7m7p4lVrAwFTK76qQXjdOHmdVQJIaK9f4UwDG9n4klTv4oHqkbS3YQQF5AhTypEeYWosCZivC0Zy5t8xxrWooE0zLtW+KqB8UJQw+hYaZC/PsUVUX34uyE377GWa+XonCsoSncQH5tRbnVXmzWrnT+GLC8QF2OnHkaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795794; c=relaxed/simple;
	bh=bTzEo2L9A8MjRx3VdeLSJ4Y9XQxxLKUNttSDG4sq8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qkxuuqqr5jhEBGyCWX4SQlcWSChH2g46qDZSxru0YYtWryGxYIHC6P0OZ4HANLqe97jb/DGoCU0tWQ15c9pEZ3i/KucC7/ky17S/3EvcejViA2zSisHRJZaUcspnDuNnKk4vo+A8q/FeHsIdSoulYZjkyg5zJtnVg19kNQRSTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gmen4jcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gmen4jcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4911F000E9;
	Thu, 18 Jun 2026 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795793;
	bh=Q+QcMJXwpptHRS1Oa8BswUBGRa4pACaKeZN1LqXhd6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gmen4jcWaCUg1e/TYOs8Bbsr6HV+ROOyLcor5Ld/l3QmEdIGP6f+gXohk2obbNX6P
	 7lW4AvyrRxTl6RNHaQhlfU8G6uTq0ETyWAhWhCt3uaR0TL7MIoTkemyxngVRK3Er/i
	 shHhBBwqVdtw6mbUWa7NCOpFCFDli95kbgx+sDpeHJzgM5whUZGOtgRBmsTfOaHvXw
	 4j/Boywj/IVSDh7CvqQZx3dnoPE3EnXCnCrndRoLr0+l1zPm5kVwZLtgw8G0J81MnS
	 PR6O8P7/YyxL6b6yBwVImZyG5/lxOFHJy6cFj5F9XF2PDln3UPmR8R98O0q9D2zcXR
	 0PRqC/wUIu5HA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/7] dwarves: Use tag__delete for enumeration children
Date: Thu, 18 Jun 2026 12:16:05 -0300
Message-ID: <20260618151606.82747-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that enumeration children can be other tag types like
DW_TAG_subprogram, use the generic tag__delete() which handles all tag
types, removing the enumerator-specific wrapper.

Fixes: a1b3ec41fcc2433d ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 2af10588ff2f20c5..90e244afb017d7d2 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1333,11 +1333,6 @@ void type__delete(struct type *type, struct cu *cu)
 	cu__tag_free(cu, type__tag(type));
 }
 
-static void enumerator__delete(struct enumerator *enumerator, struct cu *cu)
-{
-	cu__tag_free(cu, &enumerator->tag);
-}
-
 void enumeration__delete(struct type *type, struct cu *cu)
 {
 	struct enumerator *pos, *n;
@@ -1347,7 +1342,7 @@ void enumeration__delete(struct type *type, struct cu *cu)
 
 	type__for_each_enumerator_safe_reverse(type, pos, n) {
 		list_del_init(&pos->tag.node);
-		enumerator__delete(pos, cu);
+		tag__delete(&pos->tag, cu);
 	}
 
 	if (type->suffix_disambiguation)
-- 
2.54.0

