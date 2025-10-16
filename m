Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A811487D1;
	Thu, 16 Oct 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618664; cv=none; b=ER0s0/cgkQ2T/qB5R5frbCP83NFIXMvfzlZs7A8mzE5KkeDsWhrV4OfOmA9cQ6ADQTPLxVOIJxLQU6MNhJESlirDgEL5lP/cndllACjSmhrIaj7xfpp9baWUzL699qQ6BkU9dGrI1WXTPVfx92vcyfm7FzbQR8oC+A5DShsNBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618664; c=relaxed/simple;
	bh=Cju1Mun0VhBQ6bTCHeYtXnp12FVwisr2zvUZJvvVHpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjo21urXWmV56/1h8jJQiNYz7UU+Nq7f2AaKob06G9+zhjaWXyyg7h8QRShy1OSEiyNSwuhGc2FNIwC+PN+W6V7zbKTbiCiaQ1pBkyunf5OuPjQ/K3fi4yL7uE7vmNd72PfVqSy0t7w0d2VeEGfu0CuCeB3gIS5GXIrIEi715Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BECC4CEF1;
	Thu, 16 Oct 2025 12:44:22 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] perf build: Ubuntu LTS fixes
Date: Thu, 16 Oct 2025 14:44:10 +0200
Message-ID: <cover.1760617634.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series is the result of getting "make tools/perf" working on
Ubuntu 24.04.3 LTS.

There was one remaining issue, which I could fix manually, but I don't
know a good way to auto-suggest this to the user when needed.
Initially, I was greeted with:

    Makefile.config:1161: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-latest-openjdk-devel

However, installing openjdk-8-jdk (or the latest version) did not help.
Apparently tools/perf/Makefile.config sets JDIR to the first Java
environment found.  Hence if a Java environment was already installed,
but it is not a full environment (e.g. just openjdk-21-jre) and lacks
the <jvmti.h> header file, the build always fails.  Only installing the
matching full jdk version (i.e. openjdk-21-jdk in my case) can fix that.

Thanks for your comments!

Geert Uytterhoeven (2):
  perf build: Fix confusing "No python interpreter needed" message
  perf build: Add Debian/Ubuntu python-is-python3

 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
