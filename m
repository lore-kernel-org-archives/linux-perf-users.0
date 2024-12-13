Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249F19EED0;
	Fri, 13 Dec 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131977; cv=none; b=iCXY5Ypn8h615yZaG6ykzHg0iRaR5NYVDjKLpa5uNoYMKwugu4nELe7sZ/DO8Zy3l9U2vFbVdgLsOBwNHX/FXvZy/JE4MU8Q8H3RXeVIo3kLeDjjwDO5rJyB+UBt9Lp5JneQWw/o+klZdHKpWAOKAammA/dEC4HW2h6OimloGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131977; c=relaxed/simple;
	bh=I7L++QuCltZdWBBLBF2u1VL/gnj57Hinet4TijkF6fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JElBd+jST42DbPb6IpsvPiWa14JK4rdATq+FsNUfKAShRMJOADd/jVagqMppsW9vLGswEXLOYWxRv7HiFzjUbGeV15CN6uJRE24PmKv0m92QlHftdvPVVButLF3VgXNy8ctY1eynheZKXjHtjpsGLGsN/YGnjSU0Z5beNAL73Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/tZTo23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/tZTo23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E9C4CED0;
	Fri, 13 Dec 2024 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734131977;
	bh=I7L++QuCltZdWBBLBF2u1VL/gnj57Hinet4TijkF6fc=;
	h=From:To:Cc:Subject:Date:From;
	b=R/tZTo23ApV7rVtEa5naOfHwSoHWy7CIF6Jd3MEY0OIFYcCnHtk8XjyXv0u6UlgbU
	 Hl8lkG9tYq0fAt0CmhKsuZy3mrG8bSHn40nsN6yWyoMImJFa2Ad+PfHqHBAQEHf/kO
	 51EInIPriBdfflTg0F2lzjlr2xJJOUvM+8nO+mzL+13f32kFq275Jsyhp2KW/XRrVT
	 1bllo6hDZKflUOjVMHdYeyFnIX3XoeZWn/KotvGI9IPd7sqg+pT2ahuaCwvuxs5CEc
	 oFEJn+UiqKk6SnXH305m8HML/K0B2nHZfanDOro+hfOn1igm84rt7wPNRLevrh4Eip
	 fdt1cUBTDx3pQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: test: Speed up running brstack test
Date: Fri, 13 Dec 2024 17:13:12 -0600
Message-ID: <20241213231312.2640687-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

The brstack test runs quite slowly in software models. Part of the reason
is "xargs -n1" is quite inefficient in replacing spaces with newlines.
While that's not noticeable on normal machines, it is on software models.
Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
much faster. For comparison on an M1 Macbook Pro:

$ time seq -s ' ' 10000 | xargs -n1 > /dev/null

real    0m2.729s
user    0m2.009s
sys     0m0.914s
$ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null

real    0m0.002s
user    0m0.001s
sys     0m0.001s

The "grep '.'" is also needed to remove any remaining blank lines.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
[robh: Drop changing loop iterations on arm64. Squash blank line fix and redo commit msg]
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Originally part of this series[1], but I've dropped any Arm specifics, 
and it stands on its own. No reason this needs to wait on Arm BRBE 
support (which I'm working on now). I don't expect to have other changes 
to this test related to BRBE anymore.

[1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandual@arm.com/

 tools/perf/tests/shell/test_brstack.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 5f14d0cb013f..e01df7581393 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -30,7 +30,7 @@ test_user_branches() {
 	echo "Testing user branch stack sampling"
 
 	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
 
 	# example of branch entries:
 	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
@@ -59,7 +59,7 @@ test_filter() {
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
 
 	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-- 
2.45.2

