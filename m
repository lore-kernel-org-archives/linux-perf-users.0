Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B11EF0B9;
	Fri, 13 Dec 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120063; cv=none; b=kbKi5wJK7fxzoXHmvMA7d7jyO5V6TbrlJ6jLXXSjY9s2JL4/8KPC2QueqIMvmuRpS42S/QHsEjv0KvIYrKfx39NU0XSJM+Dy5zIMCM+1GD0yg8ZJbXe3YjZnzU44kNWA0yO6zHyhbhaktK3uvanyLRklY7ioqJvK5BUl62lPonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120063; c=relaxed/simple;
	bh=AvM0NO3WrFwUfwKf5uWQ9PtzjbzQ3ygKYFLHP0iYUSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cGtrPihwoqx+iSEECKXCERz+p5bQ/zURyPPlthvWGa4ZZwatX5aVdMkwlMZi66RDmfQRCEBns69FGG5fOSc4ffO1G6MdPC4QpX14rM/DjCtfcgF/KDgAahSJLbOoB1iF9bYD3km9VZvZqsBYqRnkpiggmn/rAZK+ODmHZ95n3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqHRGAL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqHRGAL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2ADC4CED0;
	Fri, 13 Dec 2024 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734120063;
	bh=AvM0NO3WrFwUfwKf5uWQ9PtzjbzQ3ygKYFLHP0iYUSI=;
	h=Date:From:To:Cc:Subject:From;
	b=RqHRGAL9OfGbQEEn1RKY/Lhs77RHZH0vuVRx9xT9ZN3k4BzIKQXp1TEo1hBRvEDxx
	 Ijo+59zlTYqIK0e42pQ019m6vVQ3DsP1nIccupudST47+dm70jF5e2hitaZH4bhP1b
	 lE3+v5IR7w5OUQL6M0id6zY6lHWxaj6mjXubZL0jlEfAueoKF1r0LpCaW5B/mPJC15
	 ci2V714BMXFnt+hy/BmkKBck1mOU6LlbpAgdOvpPN85Fk54WuSGKu3EU5gg97Ap8X3
	 CRC2hl6Ipz2/JbR07YWac6m9hgKpFilmMLZz90Z+lX2Ch+rZzeODX9Ock7ehB0Hbag
	 NYpUPpuuwe6pQ==
Date: Fri, 13 Dec 2024 17:01:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v2] perf tests switch-tracking: Set this test to run
 exclusively
Message-ID: <Z1ySfJAebZyEv8qE@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This test was failing when run with the default 'perf test' mode, which
is to run multiple regression tests in parallel.

Since it checks system_wide mode, set it to run in exclusive mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/lkml/Z1yPYqYYs_isO1PJ@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/switch-tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 5cab17a1942e67d7..576f82a15015371a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -583,4 +583,4 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	goto out;
 }
 
-DEFINE_SUITE("Track with sched_switch", switch_tracking);
+DEFINE_SUITE_EXCLUSIVE("Track with sched_switch", switch_tracking);
-- 
2.47.0

