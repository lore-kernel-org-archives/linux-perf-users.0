Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56661C8FBA;
	Fri,  6 Dec 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518117; cv=none; b=OdvdLOHXEW+6/qvvPnRhmxUlucYPvpj6FOAchELBDfbKykJj7mi2HoMjl3Rh8lmyfYaIEbH3Mt1LOECE108PDq1bmh+gIw1arCttCeleCfInAj1LrScahSzXqyVsQH2z9SJct8XAcpK3bS1AgXxB0PgnPCe26S7VV11CIv58xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518117; c=relaxed/simple;
	bh=1gXGfu/XfOuw+0JXMbgs0mxdzCJarwIHnsAVFUUKryo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haXFf8ZQ+LsyFpXnwNVoXL5TRINaou/zfJsXLkXHpoS6jxyVf3XHNj683DkeV3Chdwo0UETjtMm2Cb5usYQ5s7fSg8eXLgxL20+3k6TnIZZid2rLL85PpfKxDG16G1TFJkDKSIKPOhMhUox5dQICbSTLc781OqnTaWCAmrjwY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyqtLs6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyqtLs6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F3CC4CED1;
	Fri,  6 Dec 2024 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518117;
	bh=1gXGfu/XfOuw+0JXMbgs0mxdzCJarwIHnsAVFUUKryo=;
	h=From:To:Cc:Subject:Date:From;
	b=GyqtLs6i9ha9mHsYaRu2FTsDbaimPD77ySMIHnpYqvWLD4ldzmBUtT8tjZtFUNFqZ
	 NVcl4yxK1VXuGI0L59lBbmP6L+03J20BIrit7f9BQVvLnBoVCSjNEmh+glI+2OUUOV
	 F+WWN1k5y6nZhRDmiDqtCiYWvmOebzvMJdzUw6r6DnnspdQWsg5APLB5iGItJx1tYj
	 FdFuGV0Km+tmqD+kFQ6JqX+xp3k/7u0qn6cd37n0jGJ/qdQ3msInqJVaOy1z9BuS71
	 VBGDLE7O+WwowUvUtqJpa9wM/IZN7hQZaKr54L+YR3ocUD2bn6DDKlUUi723T3tWjB
	 vgVb+tKJD5z9Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Cc: Francesco Nigro <fnigro@redhat.com>,
	Ilan Green <igreen@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/5 v1] Processing java JIT dumps from containers
Date: Fri,  6 Dec 2024 17:48:23 -0300
Message-ID: <20241206204828.507527-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	This is trying to move the needle on supporting jitdump done
from a container while perf is running from the outside, that is not
working right now.

	I tried to collect as much details on what is being done in the
commit logs to document further work that needs to be done to support
such a scenario in a streamlined way, but what in this patchkit at least
helped in a real case, allowing us to get 'perf annotate' to work and
confirm suspicions.

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf config: Fix trival typo 'an' -> 'can'
  perf jitdump: Accept jitdump mmaps emitted from inside containers
  perf namespaces: Introduce nsinfo__set_in_pidns()
  perf jitdump: Fixup in_pidns member when java agent and 'perf record' are not in the same pidns
  perf namespaces: Fixup the nsinfo__in_pidns() return type, its bool

 tools/perf/Documentation/perf-config.txt |  2 +-
 tools/perf/util/jitdump.c                | 15 ++++++++++++---
 tools/perf/util/namespaces.c             |  7 ++++++-
 tools/perf/util/namespaces.h             |  3 ++-
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.47.0
