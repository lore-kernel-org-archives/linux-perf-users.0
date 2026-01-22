Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F270410D08;
	Thu, 22 Jan 2026 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056237; cv=none; b=RRyfAQy396gOBLhkbJ1yIGsfd82DN0JdipKft4kBK0TTrW8YMowQxc0IwIeZ1Al7QOPI9SsN3o2yXqp8uE7lr5uJxnMLf3ImFvVHUBAEiQ5G28RC9+CNTP6LgPgElZBX3MuUStuFgizIFmT7W3witF39QR9uaGKml6l0lqgj7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056237; c=relaxed/simple;
	bh=8VJ1DtFQoyRMQesE9ZwUeWuoAW+DkAUqz4herz9ZE7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwNgAasuHtxlh4sLvLDwUNYeum+tvgbgRKQxX35sW73MU37F9gf9mTsIO6Dtvd26RyyqK3R27sJEsRF1G5mk9chL3PpkxKgcfAcql2GJGKFdlNRtU9WsQCjwuyyepJMbdsehg7euE96wwjlq9ejkMzFbwNS5YqInJFoZekUGd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CavUUPni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CavUUPni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DABC116C6;
	Thu, 22 Jan 2026 04:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769056236;
	bh=8VJ1DtFQoyRMQesE9ZwUeWuoAW+DkAUqz4herz9ZE7M=;
	h=From:To:Cc:Subject:Date:From;
	b=CavUUPnisSSzrm0Znt7K0OacqzcKZMGWGU5QtQbCEe8GHUkuoqL2Me4nFtLOfS3mU
	 3JU3ETZe9PeNz1c2edXp67Ma86GKT3xFTNRwdB3YbtINVu+GdLzAcWBmHs+OIeMDj+
	 xcRMytUBWOdzHEh9D10SFZSadC6KT8LWs8iBfINzMIE0pXN/LgZflh30inqFj1Orne
	 wEpQzznSo/i0ICzPUGqA6BsmUB0z07RFJGB7lox4esfaY0zRJkcUU08fv/qaulG3Hf
	 wGQDgzl0QYTPuzfeZKY202UjhvlCRTHOyHsBTj1lwUCeK9TKJEmf7J+rjltmvDHrtB
	 bVU01S2j5oG/w==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.19-rc7
Date: Wed, 21 Jan 2026 20:30:32 -0800
Message-ID: <20260122043032.3466118-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.19.

Thanks,
Namhyung


The following changes since commit fe072f651083c612278de82ce08bccdfecf574b3:

  tools build: Fix the common set of features test wrt libopenssl (2025-12-27 20:26:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.19-2026-01-21

for you to fetch changes up to 1eb217ab2e737609f8a861b517649e82e7236d05:

  perf parse-events: Fix evsel allocation failure (2026-01-06 14:54:24 -0800)

----------------------------------------------------------------
perf-tools fixes and updates for v6.19-rc7

A minor fix for error handling in the event parser.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Faisal Bukhari (1):
      perf parse-events: Fix evsel allocation failure

 tools/perf/util/parse-events.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
