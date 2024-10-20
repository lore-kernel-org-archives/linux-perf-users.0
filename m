Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA823C9;
	Sun, 20 Oct 2024 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729390729; cv=none; b=X/uihYPmOXlVKhF4rKoqZdl04JRqlevekLdowi6aPcyndahcyEnQM0gbvUs0X5+NzHqcoJoBmcUNRb+zyXqIXqKmjvjVG1ZGunRMjKdu07B4HY6DgHG+a0P0yTbylfpPNGaKzXLnf4mfphb2f/s8JWG9AAfsUyyAnOha/5bPYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729390729; c=relaxed/simple;
	bh=EHDr1rjqv0qx0crxpdJcP44h7DjKgdMrGFEL7vsSbIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNSuzn4sFf6qYPiZ5Jp12hZ9piSm++JtLuopJse1WGxDvOyTTu0w2jT86jUp7XzKCN9OfhrPoAPxQzAOWHrwW47/nEp60ZN5l3VbxnxWWydTM6BBSMTQplC/QJutuoiX0aWbwug+3y/nE7HVBHG5VjFyGnvaGxIlD/LKoBXQwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XksiAX/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XksiAX/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25F9C4CEC5;
	Sun, 20 Oct 2024 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729390729;
	bh=EHDr1rjqv0qx0crxpdJcP44h7DjKgdMrGFEL7vsSbIo=;
	h=From:To:Cc:Subject:Date:From;
	b=XksiAX/P4bn2lQXtQiwm7YoujSD9nNnY4V/Pfur9oB+k+JDxLJT2Zxwz+1rs5Lmox
	 pSUBVamVOEWpZmd+qx0qJIzxhVxBoExZH8R271Oe2HoaqA6eaKNrtp+Irf3entcR1M
	 lXy31NaTPayRyYgi/V03sLtX7cEcDw6XUR4LQP6uAQXhjc2ggwt+To8uxdORCs7iLl
	 SKL8OC++Nctf80amLYoKA8kdlgcP5EpSPh0UUYfxiV3SphC3GSUaEjhxaEi6SEdVft
	 412dxrUGLURDfRxqnGvD/BAhyuGKlZsN57W15DnKdSpNrFuUE+ojClEC9apC5kICv3
	 PxAVya9/6ZXjw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3 v3] Expose the 'perf test -w' workloads functionality
Date: Sat, 19 Oct 2024 23:18:39 -0300
Message-ID: <20241020021842.1752770-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

        I noticed that the 'perf test -w' code wasn't well exposed, so
add a '--list-workloads' option to list the existing workloads and document it
in the 'perf test' man page.

- Arnaldo

v3:

- Fixup references to --list-workloads in a patch subject (Namhyumg)

- Fixup references to --list-workloads in the 'perf test' man page (James)

- Add an entry for --list-workloads in the 'perf test' man page.

v2:

- Use --list-workloads, as suggested by James Clark.

- Add info in the man page about the parameters the built-in workloads
  accept.

Arnaldo Carvalho de Melo (3):
  perf test: Introduce workloads__for_each()
  perf test: Introduce --list-workloads to list the available workloads
  perf test: Document the -w/--workload option

 tools/perf/Documentation/perf-test.txt | 17 ++++++++++++++++
 tools/perf/tests/builtin-test.c        | 27 ++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.46.2

