Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA932BEFFF;
	Mon, 27 Apr 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282673; cv=none; b=YlSrIJugRObz6ao1UwSZ2zeJQz87NR11CjmwCjaBt/vHSBzQtP4/h232TKrLgvOzYbYRvWAq/3dxuqug8TGLcA/tSiuZtfC1V9rAyim7HLXDMGkkKJPbLn4piE4STr2CjlGcZ2Go7+pTS7D8sV1ljZoQyjdTs76zja8ruux2ypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282673; c=relaxed/simple;
	bh=vaECcUqba3/sv5BEYbRzBNU0ualykwMno6xoozer9Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faWjsFstccCMEA1M+Tsa7guioepP6rUl/uvxI1VRg9j+xVc+Bja+i0Jm/KK8F13bn3vPCJLlT1HcFwXhzzTXJAvO9pTscTTEuLEYG452shv6E9hhwRXQn+9UNXq7Z951mya8iAOxXNNFl0JZ/q1mcWxeZRIA9GQfjEZSSRpEyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHHrS-00000000jJc-3Yim;
	Mon, 27 Apr 2026 11:02:38 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] perf: fix some tests for musl
Date: Mon, 27 Apr 2026 11:01:40 +0200
Message-ID: <20260427090225.794482-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Martin Kaiser (3):
  perf test: fix nanosleep check in the ftrace test
  perf test: fix sys_enter_openat event test for musl
  perf test: fix "trace summary" test for musl-based systems

 tools/perf/tests/openat-syscall-tp-fields.c | 3 ++-
 tools/perf/tests/shell/ftrace.sh            | 7 ++++---
 tools/perf/tests/shell/trace_summary.sh     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.43.7

