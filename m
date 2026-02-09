Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5A371063;
	Mon,  9 Feb 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662910; cv=none; b=OUp6VmhRLJNTTUW2AjQt1DPM3tC9lDjVHDlz8TAzWf8QFyhktmZIySLzDTN82QPq2/D5CQb5wiAWLFjFlIdKRwoGAz1LEl5MhrGqxscUaaO8Rtds0wwIyvFTrpwZrIfKs00kOdrvmYgbzOINHkbVPldTPoqqIycXJDAHNefdnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662910; c=relaxed/simple;
	bh=JW4QFafI/xPkBvGmEuVQWnNgKRix00nvpBYPY+REsOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XihXU7Onxx6atibEZSrQmFVxQx/0v3Az0bRRKpTKETeLTQICKMKEooEYRAY1mbVDGPG4QWv4maOJRTB/prMj1Yc/NrCJ9dQn02NuCrEjZZtbD8eV3404mqcMSU9mCNtT6UJCaHFieGicYli/wl9VJAj0NxUYTCnbuC9tWDp19ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/dzUqs4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/dzUqs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEA9C116C6;
	Mon,  9 Feb 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770662910;
	bh=JW4QFafI/xPkBvGmEuVQWnNgKRix00nvpBYPY+REsOs=;
	h=Date:From:To:Cc:Subject:From;
	b=o/dzUqs43xGxPAiAJ+N22H2qci2aFpwY3IFqnc+AQtOqrqzqO6fNJFk8mXfJb+xsp
	 Ar+H1b2G3E1DYf8g6KBHdYZo0LLbNp2t/Bkemr/eCnWPWBu4fMiI9RiCBboLcaIRAZ
	 fzYMTJKzxd9BbvDOvv7BaSueyK9RIQBweUBHw/1EkDqBsxVBlqo+uFtOBRf210Bp8G
	 XifBmAsjMEEZZ5B0jAUWVxDzqXErwrrTZIERGxE3lhUsdchliTiRDY54ATOSOVFtoZ
	 gsnwc2Oh0FO5xfkCKP1rkK+5BiGolgqwt2yM+3QrxAcUm6Q8n9rk6FuInkvulSHUil
	 WRFiyg9VD1fGw==
Date: Mon, 9 Feb 2026 15:48:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf test code_with_type.sh: Skip test if rust wasn't
 available at build time
Message-ID: <aYor-0BmwjNvKs1N@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  $ perf test 'perf data type profiling tests'
   83: perf data type profiling tests                         : Skip
  $ perf test -vv 'perf data type profiling tests'
   83: perf data type profiling tests:
  --- start ---
  test child forked, pid 977213
  Skip: code_with_type workload not built in 'perf test'
  ---- end(-2) ----
   83: perf data type profiling tests                         : Skip
  $

Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index a230f5d4c42c3e6a..3ef72a10850d0734 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -4,6 +4,11 @@
 
 set -e
 
+if ! perf test --list-workloads | grep -qw code_with_type ; then
+	echo "Skip: code_with_type workload not built in 'perf test'"
+	exit 2
+fi
+
 # The logic below follows the same line as the annotate test, but looks for a
 # data type profiling manifestation
 
-- 
2.53.0

