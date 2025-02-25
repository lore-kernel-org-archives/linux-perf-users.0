Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AD376;
	Tue, 25 Feb 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510361; cv=none; b=Krz7mP6sBp1ON4qbDcvdbnBAFQNvbTE5FyqOSqnGbwyWz2ckeRPQ+PTCnyPCXtKwgUd/KY7MQhGrJgMqEl/vamZWvTlDOawv1JRpwFiIsKkZ7GxQeFJs9ucZFH25GC4Cf11xs5w6aBukuXv8bedYExbz5jkcbomhWZ08bWGsXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510361; c=relaxed/simple;
	bh=c2EKQemWeCbMwimmh9/cayUmj/ENMlDDQp/1Uona+gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C33LaQ4mO6TL7P2TSFr+CIx96urth1/Ijk4r2HHEjUjXoiTZW+C1KGqNdFS8ZJfIfxXE+xMq2Sm4aoZBUdIrx3H5GAEgz1gqp/PIqfqaaPzWml7PZ5p0MT1NvDDQX3XXnqV1cK5dIT9D/Dr352GtM/nSxtBF0fdq1mkfvbrLcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2cElnUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2cElnUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2282C4CEDD;
	Tue, 25 Feb 2025 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740510360;
	bh=c2EKQemWeCbMwimmh9/cayUmj/ENMlDDQp/1Uona+gU=;
	h=From:To:Cc:Subject:Date:From;
	b=i2cElnUq9+m38UvdWnWFXlq0vvuddSlmyZ9clfMvxyIIyDjIRen1GZ1dwNMsLUJBj
	 Qx6MsHiB6WLlRcSPknmG5QIeFWXXvd7ls9F3Hv1YKT5kX3jRWHqXaQxKfwMpf41jsG
	 N5/0Ym01s9PclCZIKMWKV78E7SKmfYsv1/Sf/MqNS3bfz7N8OkppYqExYkPQdIQrmL
	 8HcxUYHOzUHXL6c5cCHEqpKUIt3ojwGkQL21UvvTHshtPJo34gMdi+M6ZU5o+9aegi
	 L+NxUEosT3i2aOG7lNDKAGMgHxtwUy3UlH5Hlkd+PnpJKML13957PI/UT/j1ZwWW39
	 VNA7TKVa0hGCg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.14: 2nd batch
Date: Tue, 25 Feb 2025 20:05:52 +0100
Message-ID: <20250225190552.115479-1-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling, this is the first after I got back from
long vacations, there is still the header file sync that I'll try and
get lined up, probably the last pull req for v6.14.

Best regards,

- Arnaldo

The following changes since commit 9fae5884bb0e3480dbb69314b82ed3d8f8482eef:

  perf cpumap: Fix die and cluster IDs (2025-01-28 10:03:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.14-2-2025-02-25

for you to fetch changes up to 42367eca7604e16e170bd6bd94ef61ffdd335f4a:

  tools: Remove redundant quiet setup (2025-02-18 16:27:43 -0300)

----------------------------------------------------------------
perf tools fixes for v6.14: 2nd batch

- Fix tools/ quiet build Makefile infrastructure that was broken when
  working on tools/perf/ without testing on other tools/ living
  utilities.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Charlie Jenkins (2):
      tools: Unify top-level quiet infrastructure
      tools: Remove redundant quiet setup

 tools/arch/arm64/tools/Makefile           |  6 -----
 tools/bpf/Makefile                        |  6 -----
 tools/bpf/bpftool/Documentation/Makefile  |  6 -----
 tools/bpf/bpftool/Makefile                |  6 -----
 tools/bpf/resolve_btfids/Makefile         |  2 --
 tools/bpf/runqslower/Makefile             |  5 +---
 tools/build/Makefile                      |  8 +-----
 tools/lib/bpf/Makefile                    | 13 ----------
 tools/lib/perf/Makefile                   | 13 ----------
 tools/lib/thermal/Makefile                | 13 ----------
 tools/objtool/Makefile                    |  6 -----
 tools/perf/Makefile.perf                  | 41 -------------------------------
 tools/scripts/Makefile.include            | 30 ++++++++++++++++++++++
 tools/testing/selftests/bpf/Makefile.docs |  6 -----
 tools/testing/selftests/hid/Makefile      |  2 --
 tools/thermal/lib/Makefile                | 13 ----------
 tools/tracing/latency/Makefile            |  6 -----
 tools/tracing/rtla/Makefile               |  6 -----
 tools/verification/rv/Makefile            |  6 -----
 19 files changed, 32 insertions(+), 162 deletions(-)
