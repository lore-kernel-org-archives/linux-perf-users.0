Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5617BA2;
	Fri, 11 Oct 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657560; cv=none; b=KxaFEsfnCGq9Jxx2D/iKx7y2MyGw1je0eZTyiI3QTRKvPlVN7z99rStGuqLyAIii3x3KuApY0ok3pmbSgPVaKVMsxtcf+NGdIFCKqXP3giXEaLTFFdQrGY0inxaktfKLT/3I5DRKoXEeFVCk7Rf57y4S7nzWl60j9Do0PkuULtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657560; c=relaxed/simple;
	bh=dp7rB5EIG2tUmUJuz0rnkCMGx0BF1bgwBlzk/fnYN+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIdE5vSx5p+NPMgyRjdrlUYi6odXOtbhcRAzbzdhtKxL5TauwbAAlC9v/PilvKoqZNOGG/k102JtkdGE5gSI7zgNLVxc+iDv0KNWSQdUlTSfAMZZkRzhaLvRwd11u8oPWLdzuAINjalOjlMivOBpUj6+8ZfXeJzBSf2ZRhrbuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhPJ9hoW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhPJ9hoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7396CC4CEC3;
	Fri, 11 Oct 2024 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657558;
	bh=dp7rB5EIG2tUmUJuz0rnkCMGx0BF1bgwBlzk/fnYN+4=;
	h=From:To:Cc:Subject:Date:From;
	b=UhPJ9hoW7220SPelPJu6j8TsZywWumqbUpGWy9dShofeS5A5SVVhLh1KWYvKiVXJz
	 37ZAAefmmhLNXW6U0LXt2Fb8ABPGjy2VtlzQMqHaQcctW1TtamuazU6J/RAW1TAFuQ
	 +blXQx2qmxMU1hyhcmY72/7EPYo6f6JdVXdsJ2esS4sQLlr+D4jcotD8YbfRJmCHa/
	 H29lmN1/lgci2lrwXgoFSbId//9HKJqUTZj22MnaR2rgZQMf3RLeHFtz73epFlTJFN
	 wdiSusC4/9SGdSzDs4/jdXkyuTWKX3RD2OZrwi8XUY2yXA+2F5KlwaS8NhDeD+GXhm
	 bRLCxrDYQbtkA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/3] Document the 'perf test -w' workloads functionality
Date: Fri, 11 Oct 2024 11:39:03 -0300
Message-ID: <20241011143906.1285675-1-acme@kernel.org>
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
add a '-w --list' option to list the existing workloads and document it
in the 'perf test' man page.

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf test: Introduce workloads__for_each()
  perf test: Introduce '-w --list' to list the available workloads
  perf test: Document the -w/--workload option

 tools/perf/Documentation/perf-test.txt |  6 ++++++
 tools/perf/tests/builtin-test.c        | 25 +++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.47.0

