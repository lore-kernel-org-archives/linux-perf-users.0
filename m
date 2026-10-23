Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761633;
	b=0gjYITBAAu2QRZAL4vL4SAtwG27Z9Tgc8KVhe5jM5P+tQIyXzEymfM70NvlX/pchnOgg
	 arV5Rc/aNyl3Ursy+TOUpLDJlkS47TBlm44ggGyTpdoCoRqUsyLmTYagnZb07HpuE888e
	 c9Eftvyi+BGzJyK8e0Bdh0ivsN3LbAn+fG54gjACgk+6/DufCc0IvpWfPiePukfDzKt8K
	 2NkwCBexDrkOmM7a/1pQHDhXkJDkMw2/wAjRFIJcUfmfTS6QJq3YkkATbL8mUbCpMtRQh
	 xObjbgMOxGivUG7xJ4VOHPe2RsnIkYdQvKhJCypR2pRbA/trEW8kB8uwoAk8siE23Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761633;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=V1mLWCGmeJc93BS20+mJMoDkpC6a5IrhpYP1YJLQCQA=;
	b=BI1fOLtJvAedWvrpI2bLILCLnx5p+x5RZT8xtpvywX3842PWZKtk9PHwgxwKVOKmkS/c
	 IXUeDTJ09ThbximF58NLFKoPl7Aw8qtRe55LhVZHabGELInGLE4631joek0OIaq8cp70e
	 o7s3xPfQw73JOexzT0WVeyJ5Z1o5nS0vTMrZOfIBiluJAjkB0/RiP3Rd5MijJEzsQfAQV
	 9X/1xpyTjE0cTBsJ1SvSn4raQ9KHlekRR9R8DpBt8TtkfwE+fGfjmJ32QY/1tdgfCslqm
	 JqmlfBm6FVm1xmfAZOXUBROasR7J2Ejj7rC3keFKv7vHiDEtkeGo06P3ZwpfMbgPeKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cnlsapbs;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED0606A31A;
	Fri, 23 Oct 2026 13:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92ED0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cnlsapbs
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98A7E31DB;
	Fri, 23 Oct 2026 06:20:28 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA7063F673;
	Fri, 23 Oct 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792761631; bh=lbdn4umsAKqk2rOG6kncTbMDZ+SZ/6zgbCMGzebS3rE=;
	h=From:Subject:Date:To:Cc:From;
	b=cnlsapbsOio6QAaBUJ/0yk3AZFNA6eut1/uaDj03JIjhCe5occPlJwbL7BGH07zN2
	 7fi3yYXje0xl/cgmer0ctZrgW3A8E09Pmg46x5+ugEz3apGz4PqbTRNwVBDma825ZI
	 6D4026QjXJ7777uyPa+PLbvBV5hph4vycaPYjcT0=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf python: Fix pylint warnings without Textual
Date: Fri, 23 Oct 2026 14:20:23 +0100
Message-Id: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdf22oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNj3YLUorT4tMyK+ILKnMy8kvjyxKK8zLx0XVMLEwOLNIMks2RLQyW
 g7oKiVKAqsMnRsbW1AIU/VgFpAAAA
X-Change-ID: 20261023-perf_fix_pylint_warning-58408f0b6c91
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alice Rogers <alice.mei.rogers@gmail.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792761629; l=766;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=lbdn4umsAKqk2rOG6kncTbMDZ+SZ/6zgbCMGzebS3rE=;
 b=VOsTU7VPSYmxyEJR0/RTEiWwZZzwVW1DJwWK/elZA7pdjOXCUzPDHr9cYB343L2p9v+6hspwc
 MOCSh+W+SlCBlsLgeHAv/lihfNFqk0vq3+v6hWN/zhY1Ol3whKYbwqv
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

An arm64 cross build without Textual on the host reports W0201 warnings
in treport.py and ttimechart.py, causing the build to fail.

Initialize the inherited attributes in their constructors so pylint can
recognize them without resolving the Textual base classes.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      perf treport: Initialize the subtitle in the constructor
      perf timechart: Initialize Textual attributes in constructors

 tools/perf/python/treport.py    | 2 +-
 tools/perf/python/ttimechart.py | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
change-id: 20261023-perf_fix_pylint_warning-58408f0b6c91

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

