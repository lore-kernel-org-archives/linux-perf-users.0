Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA944384;
	Wed, 11 Dec 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957117; cv=none; b=YnM/ZWzGGwUWUlzPaosKUgCTRnmSuF47bkGdNkLWskOoNfMHYwCraifS1hL9Hxw8YnZmZ8rk8etPCebak4Hopr5m3GUsVlllcf9KZ+mlR3UGE+t0kJ86B+XHe745ZXzMUTnchmJ/JfXRnSl5yVKxUue2NkaEogat5BMyRUqPCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957117; c=relaxed/simple;
	bh=pmg1q8xAHu4vdAF64Hv/368zxAhYuswQ0neb07a7oUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iMM8K1z1E8+ngfIhOo1uUwdCLMfw4QeG52ib1DVAUrdwVfgyqXY6nYJw/zNMy1S4yeVf3Fhzm8nMn07kVolTsuNPJxhbDW+tgjxZBHt988Y0TOutNgK6l7cjfkTHP3PmlJAIafgaK0kotpi0ZTzOEqFzTxPiqSifwzWTaXw/k6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUro13si; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUro13si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC56C4CED2;
	Wed, 11 Dec 2024 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733957116;
	bh=pmg1q8xAHu4vdAF64Hv/368zxAhYuswQ0neb07a7oUk=;
	h=From:To:Cc:Subject:Date:From;
	b=XUro13siAleu8Ph9MS7zrk3u+XFCpNK77Ee3S/Rm9nGWP+Uvz+dZah/8r06DY1BG2
	 82dtKSBDUrlY8zsSSUS4b34uX0wjyfu8PduZplz/mGlRu6yiS9xfyDoIOmVVFxzS4/
	 g5EI+/2rWmWSZbckJRELI8B7uXnba31F+ykAizeOkI0aAqThxBrUy063wPpqYF+jzO
	 x6enX/alg0Ao/oznlUyhhp4AJgaScAAnBZn+fmAlcBfzrphsq9llifJlhluc8gDeYt
	 hz4Ac4X83ZiasEId9EC9d25CLHS1cXpcn1PgBDvG+VpgEpa9u3DqRpuJviHPmAIRH3
	 j73xUTJhRXdVw==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH 0/2] Fast path feature detection fixes
Date: Wed, 11 Dec 2024 19:45:07 -0300
Message-ID: <20241211224509.797827-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	This is on top of a previous patch I sent today for libunwind
opt-in fallout, I'll continue checking if what is being enabled when
test-all.c builds is the right set of features to be declared as
detected on this fast path method.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  tools build feature: Add some comments to explain the FEATURE_TESTS logic
  tools build feature: Don't set feature-libcap=1 if libcap-devel isn't available

 tools/build/Makefile.feature | 37 ++++++++++++++++++++++++++++++++++--
 tools/build/feature/Makefile |  2 +-
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.47.0

