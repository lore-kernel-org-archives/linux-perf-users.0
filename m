Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323862;
	b=t3RZBKV8J/qTakViV7sU9eXPeKMwB5DXQQYh9uJVnuwueS/M4Ptlihey/Njaz7vw+zUd
	 HgTDaS3WFfsjwa3tqs7ESSZAXcJyVCTkAwEvcFeu/NK5AvpmtpP9vBivjdRr1cycN/rbY
	 bVhA8A9pD49W72R5sxBKIQ/AYTEYyxX7OajIgC1NgRcOpmF13Y05kcsSPd6hwKR1a16nJ
	 S6/supSImrKqBdVr2VA0vTAgvFIFvU9QmrjWyxKg642+zpUGf0MVkpPM1W8BRYRMr4nOl
	 SQhrZmi4W1VKhL2GgV3diH2YJDP3vQDp8bcws/7GtLoJTpmwICQm9qeGi5KTCtYF1Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3+RVnA1KvRuho7W5JEL26qwdJaS2/5G8Cho/yb352Tg=;
	b=GVWqLKW/wLtb+jM2Z+tHV6yb++f/CiiGniLci5N1ieIx4b6g6B43DHS1LBiOXuA+/OLg
	 RbHBUd52u20ZJUebgKDUDAD24S7hwBQXIoPIyiPjOdWQnFsUxjomEwjfQAkZ2RgRkdIM6
	 ARu6HqjB/8Ld7PQnAFjLtMIlCZnl/IF+6Tfv/pcdmkH8YMQyAjs0glwA5ZfOErf+27DAw
	 akHgDXQcwsKxC8rm9qm2XvXSpwYjmxZ2ujUjmi0se8Vun1qVY38dXctJfEc/UEjpSLHLO
	 ThHsmm/pkrB8tj+pgJbRX3m+wQzODA9/0qh06Q5wgGTQhPOrdXvxombcvOuRzSC3d7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pYIb4A2Y;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77F606A32C
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 05:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A77F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pYIb4A2Y
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2579574eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 21:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795323861; x=1795928661; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+RVnA1KvRuho7W5JEL26qwdJaS2/5G8Cho/yb352Tg=;
        b=pYIb4A2YDUgJW3/cv/didT2UkN8udEvUHytxfzEl1B31hB+GgmwXH8wJj0m6xuDi7J
         QqjMDwaqmJHnt8WG9tOMlnmIjy/9oSSL6mceZlFXp7ohjcVh4PXq3T168T4fTQvKEfcL
         Qy4mSVn/jYIB9ivzPzZX3t4rFPr6jIVP3CCug3whPKI6fFVWX7gTW9WMZOTtza2xqr0q
         vx0rPnzFum3cbzD2Q33o96As3JqNQtMLmI0vdRoePYEs3efQxhHju8imvklYLS8OAQy/
         UkLoTXH0yHWkOJTa1DZFhCeJW6TiO+1Eizxj/g8/xbOLnlciLL9LQwrRb91Xkt5R103i
         RitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795323861; x=1795928661;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+RVnA1KvRuho7W5JEL26qwdJaS2/5G8Cho/yb352Tg=;
        b=2af5aUGBFwGSd6NtENyv+/YhHnnnd8Viqfg5EYOPKUkEWssNg1uCbXE89Q2WzS/FYp
         BAlxorFQ58ANeoKn+mUX4TuTAhxr8EKk1GhHpueV1te0mqseQR3WPWXXvVmwbciAztuI
         e11X2E73VrUXYbqUVYhWyDcFJlVwS/om8HGR75wF2yh59iaYxWeVFpiEFWGz/5ISI6SK
         a1+U/VjDICBSPETFyHLVMlsFZ59+bm5dMAWSaiCA6K4E452bvt6dnCziAKTf3HeeU3V7
         aUr47shWXuNg9jKqrN73mqpFxmejuwZvYPTgUJBgX6Ly2RVmiT4savTL7kraLk+ozyoR
         o6MA==
X-Forwarded-Encrypted: i=1; AL+hErHQ3gzB+/Ib26eBaR6TwkSEDfDNVZA3yanPc6ka1T2FycjT+v4N2cNsZ8EILT6nVcn39FqQ8Lrdry1+cKnD+qY4@vger.kernel.org
X-Gm-Message-State: APuU4Z9pLeqsVjy14BNqvEmuNXk/3sydFld0oCs9S4g6oFW2oOIKTy/n
	rTOUXeARGQVRTyGHD2xyCaCVrLoHeP9BZcfKPwtxTSJIF52mfMaA97hLPWfWzh9fY+xpHXhYl4q
	VwHUjWP4h6g==
X-Received: from dycpv11.prod.google.com ([2002:a05:7300:de0b:b0:383:7418:1e01])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1884:b0:374:ba43:ae2e
 with SMTP id 5a478bee46e88-3856f65eccamr7554250eec.14.1795323860261; Sat, 21
 Nov 2026 21:04:20 -0800 (PST)
Date: Sat, 21 Nov 2026 21:03:57 -0800
In-Reply-To: <20261122050405.80335-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122050405.80335-3-irogers@google.com>
Subject: [PATCH v8 02/10] perf maps: Add tail fast-path check in first_ending_after()
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

# Conflicts:
#	tools/perf/tests/maps.c
---
 tools/perf/tests/maps.c | 46 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/maps.c  |  4 ++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 054e4fafef3f..7f48f944aa67 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -392,10 +392,56 @@ static int test__maps__remove(struct test_suite *t __maybe_unused, int subtest _
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
 	TEST_CASE("Test remove interface", maps__remove),
+	TEST_CASE("Test tail insert fast-path", maps__tail_insert),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 672c0ace5a00..770ce43a4ce3 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -907,6 +907,10 @@ static unsigned int first_ending_after(struct maps *maps, const struct map *map)
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

