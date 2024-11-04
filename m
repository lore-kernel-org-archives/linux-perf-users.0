Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E481C8787;
	Mon,  4 Nov 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743205; cv=none; b=cESk/JPTQeHJgXYIqvfn69NnebedyagBnx1SXyV4hTwnbSVYyhtLqWizblx7PqQElY95DeVCMoMRtSg7/GFThm/s6xntcfCMJPnhF+FZkB8ueuPkzm0dDOWpY+mDl44YecdUXjcBtGke3xFcY4KoVKW9UrB/glKs6VVIgLqAzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743205; c=relaxed/simple;
	bh=J6XRU7patGuTpoGyLE2ZmGVyioGWBCLFujnLnvTVChM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULTOQPGpXMKl1mVxxYRdEs1PYFEr62egmFkKJa3KgArqaAVmRSMgZIiadrXGjoI0VzlWAHBIig4ULrINNonEdQWGCITOgas7xQ2jbdQFOKVDmLkd8Wj2qAG+Kv0V9ZScdhuTEphQBPpiKKN6QvXyqHB2WRG2+x8DBVT98b1fdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8nrHRot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8nrHRot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0551C4CECE;
	Mon,  4 Nov 2024 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743205;
	bh=J6XRU7patGuTpoGyLE2ZmGVyioGWBCLFujnLnvTVChM=;
	h=From:To:Cc:Subject:Date:From;
	b=N8nrHRot6YfkiuK/Qm8vR04QOsF4S3C28GqHcjXTihjRqh8ZRuShr+E1BD/W42aLV
	 sZK9Oy4gQOvg5SNAaT74/aK3+p1sUu2aU5S7yjrqj7qed4fnUwOJm33Zm31bTpNqZX
	 B21NJemzJcJLWuvmpR/EYxVShEKKCF2blT22ne+rpfqdy/LCg3SUaL7MTFfYkDKS51
	 ujbAlH9BuHBU2TbDSOZhH+r+iJ6Zr3MXxWqmaqt98n1s1GnVYtfDsvk071DVQ4QnS5
	 lszL9+DrNXHV9hXvfttjac5aCzeQPhlrGzfaznIqC6Tn4IFrtrFW0Mu/pPXIx02wWz
	 NzuYR7+EcWnbQ==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH 0/2 perf-tools-next] 'perf test python' fixes/improvements
Date: Mon,  4 Nov 2024 14:59:51 -0300
Message-ID: <20241104175953.535202-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	While evaluating what is needed for having shell tests that test
python functionality conditionally, i.e. so that we don't try to test
the python binding if NO_LIBPYTHON=1 is used, I stumbled into these
problems.

	The first patch its more for documenting that strange system()
behaviour and to check if this was something that would have
implications in other 'perf test' cases besides this python one, maybe
somebody will spot the problem, but at least it seems more compact now
using 'python -c inline-python-source'.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf test python: Robustify the 'perf test python' test case
  perf test: Don't build the python binding builtin test case with NO_LIBPYTHON=1

 tools/perf/tests/Build          | 2 +-
 tools/perf/tests/builtin-test.c | 2 ++
 tools/perf/tests/python-use.c   | 4 ++--
 tools/perf/tests/tests.h        | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.47.0

