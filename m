Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245437;
	b=mAyLiATE1s3MPZLQaNxfaPcv1AsQNxGaE7XZ9xiPlWSqtDdSQisAJiMMIBaxZAJbnqkP
	 p4zYH7DIZ45WkpPOCXrJidDFLIBtuvrf3FqiHMyBLDwYkO3T6ojLSIMs492QewZqjkIo/
	 to993lGlubfnbkgz1/sYnEQv60mMsNVj3fg/0fGG4tn9DtFuxhMBP9FJSNUPhbvU5KpwQ
	 CoAsL7PRlg71Zh9WuMp/enPChNoPJeAldPTk3Tpe54niWZIcHfhTejloYsyP4MnZ9yO4b
	 697Xv8X5mH2yxNVZwlm+6F4C/hAK9EG5WW4BtUnFG/PAShqjl1/+4tC/k4LWc3j9w/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IYrYl4ZoitwuOrErYPb74jC37YmtutoFHOUpAkQZfng=;
	b=3nLhcP7jn5eSR7KTiysdUIBRFuK3Tzcp3V1l2nUZVMGaEEj/oIIv7N5BuiFw5NuwlL7d
	 FP9/5bCRdNUTEgtAGVT+xxitD7w20EBHod18WqhBEae0kAmZxbaGn6CjW6nWr7RwMzJS7
	 4jGGmn1OUOIutzmqR7D5rwf5sq5UpAgw0PbhmQR2/YjMzcgOEE9evdKVDtVJczNORbrg4
	 5BEV3Huo59UPvCLnpmRQxlF4XsAkMJxuSY/CHW5pMW0gL9Sf9dJrOKJo4LuAYzANbfVMj
	 RCN10nIbBv68+q/K+5B/d92+I64MaCwS/Sj2/KAVM7hmysMAfbOQyeaVKcCZiDrY0Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WPxLbK7J;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5784606A333
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5784606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WPxLbK7J
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2659668eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245436; x=1795850236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYrYl4ZoitwuOrErYPb74jC37YmtutoFHOUpAkQZfng=;
        b=WPxLbK7JsYV+ydwpNZJci40yh+my4rEUFfob2MH+YMq7UpFJIZM3CA9clHQ6KDtZI3
         zUmG3nNrnnHnCGqaPZmI8+drPvAiAUhHc6eqgaXY8wtzHLdcX3tqQHWMs/27Yttnj6HB
         d0P1wPJQLKeOZSh0U8UpZVTAOXqjSXJcL86qp/MSnrGcaXBVAalbKgBl7Eninv0259nX
         to0axvdVl5XR4dRjjOU4xZyvC+dC0DZbTo4ghv492Q8K3P+xfivqCXNMbb4trbfCMIEP
         exvaarlv5DRARr5Ip+/t4eDi/LP8EcGDAVnRDviIq2kUPR9Iu1O2o/XEcwH77pJ4VyLC
         ta+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245436; x=1795850236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYrYl4ZoitwuOrErYPb74jC37YmtutoFHOUpAkQZfng=;
        b=UhUV1T4E9PqrY82LvnhJg47nXcB0KYzeWk0YFy+zJxTK+xRYiwhy0bN/obBW0BJC4s
         tcRJqz5I2KsEsoWV+QRv3+YdwipnXnCt7K1mhy3Vct6321RTVzV8AFuGKGx8J4sSm2my
         9mZQC90Ja81OqiKy4W+vt1f1J4xZJGy3pvS1z6+YB3IYNF56Qq72Cp7IniwbNr8nHTOM
         5haO3o+0/tcfSP/b8tNpKipVWOb3mzzlZl4EYRJjoIQUFXWgsqhnw9pwG1DeE6yw00Li
         9jiWlccX8Cnpuci1GS8+xNCqRWwJeizVdyyzI44s0KcJWhjaA0oray9zKRYhLoNR4ViB
         UfwQ==
X-Forwarded-Encrypted: i=1; AL+hErHNIZVs+Uh0ZEUZnpo6Mr/bvBFR0YLGdQeu3U3nnh5NeNZC+6AZpxTUUbNaff7oAB8w0VTpiGjoQM7bZVDy/2SD@vger.kernel.org
X-Gm-Message-State: APuU4Z+3cKo+UvyDE8dp5rx60Xk9qZAWdHB3fzhdesRq719tqvDpuZh/
	QPkPejJLXSFVIgWrMgCm2EXc53+xjFeuuLEVvMbtafvjgoI6kBpZ42ZvrNE1Phnt+aBGRDsyUSV
	Bw/fUOWCjwQ==
X-Received: from dyba9.prod.google.com ([2002:a05:693c:63c9:b0:385:b68b:304c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:280c:b0:1b5:6441:a323
 with SMTP id a92af1059eb24-1b56441a60fmr1027535c88.9.1795245435640; Fri, 20
 Nov 2026 23:17:15 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:43 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-3-irogers@google.com>
Subject: [PATCH v7 02/10] perf maps: Add tail fast-path check in first_ending_after()
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

User-space map insertions (from /proc/pid/maps synthesis, runtime
PERF_RECORD_MMAP2, and jitdump) and BPF ksymbol registrations all flow
through maps__fixup_overlap_and_insert() -> first_ending_after().
Currently first_ending_after() has a fast-path check for the first map
(maps_by_address[0]), but no fast-path check for the last map
(maps_by_address[high]). Because /proc/pid/maps entries are synthesized
in ascending address order, every synthesized mapping starts at or after
maps_by_address[high]'s end, yet currently executes the full O(log N)
binary search loop.

Add a tail check in first_ending_after() so non-overlapping ascending
insertions complete in O(1), and add a unit test in tools/perf/tests/maps.c
covering ascending tail insertions.

Using 'perf bench internals maps':

  Before:
    Average ascending insert + lookup: 63.370 usec (+- 0.476 usec)
  After (-6.9%):
    Average ascending insert + lookup: 58.970 usec (+- 0.609 usec)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c | 46 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/maps.c  |  4 ++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index ff6d25f9c043..3e8418ec6100 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -253,9 +253,55 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	return TEST_OK;
 }
 
+static int test__maps__tail_insert(struct test_suite *t __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	struct map_def ascending_maps[] = {
+		{ "map_c", 1000, 2000 },
+		{ "map_a", 2000, 3000 },
+		{ "map_d", 4000, 5000 },
+	};
+	struct map *map, *found;
+	struct perf_env host_env;
+	struct machine *machine;
+	struct maps *maps;
+	int ret;
+
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	maps = maps__new(machine);
+
+	TEST_ASSERT_VAL("failed to create machine", machine);
+	TEST_ASSERT_VAL("failed to create maps", maps);
+
+	/* Exercise tail fast-path in maps__fixup_overlap_and_insert. */
+	for (unsigned int i = 0; i < ARRAY_SIZE(ascending_maps); i++) {
+		map = dso__new_map(ascending_maps[i].name);
+		TEST_ASSERT_VAL("failed to create map", map);
+		map__set_start(map, ascending_maps[i].start);
+		map__set_end(map, ascending_maps[i].end);
+		TEST_ASSERT_VAL("failed to insert sorted map",
+				maps__fixup_overlap_and_insert(maps, map) == 0);
+		map__put(map);
+	}
+
+	ret = check_maps(ascending_maps, ARRAY_SIZE(ascending_maps), maps);
+	TEST_ASSERT_VAL("tail insert check_maps failed", !ret);
+
+	found = maps__find(maps, 2500);
+	TEST_ASSERT_VAL("failed to find map_a by address", found && map__start(found) == 2000);
+	map__zput(found);
+
+	maps__zput(maps);
+	machine__delete(machine);
+	perf_env__exit(&host_env);
+	return TEST_OK;
+}
+
 static struct test_case tests__maps[] = {
 	TEST_CASE("Test merge_in interface", maps__merge_in),
 	TEST_CASE("Test fix up overlap interface", maps__fixup_overlap_and_insert),
+	TEST_CASE("Test tail insert fast-path", maps__tail_insert),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 675fe0223faa..dd3b27b568da 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -858,6 +858,10 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 	assert(maps__maps_by_address_sorted(maps));
 	if (low <= high && map__end(maps_by_address[0]) > map__start(map))
 		return 0;
+	if (low <= high && !RC_CHK_ACCESS(maps)->ends_broken &&
+	    map__end(maps_by_address[high]) <= map__start(map)) {
+		return first;
+	}
 
 	while (low <= high) {
 		int mid = (low + high) / 2;
-- 
2.56.1.750.gf70dc682cf-goog

