Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563161096F;
	Sun,  5 May 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907670; cv=none; b=dSduynOa7wiTLrSZaOkEVqiZlv6tLjHet2h/i30ipMFopOShDRK54JVJ4N4/c87L9cNvi9eGAhCSRw13Sivzw5nLl+/K1h44u7ktUDE1lrs0+e3jo3yDVDUbG3ff7nlyKS54fVx5yuFc5G7hxM3Zb6VAY/dugXjqO+diAJ3iVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907670; c=relaxed/simple;
	bh=9eAXx8y5d8kDhI6LAXR0fz77K7tCB+kZ9tgT5yKzOe4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uj75wYBZ/MANQBbstFjzk6qzYWM/2TArca2l0UYH/CCOZktn73n3kq3hJJ2fX8R/bojNoc8y0i1p71+17+WrzgzIHt5i/bqLo6UrlQb3vsy9un5gW5U9iOjc+uZ7WglbFEJ9ajYzKYJUNqs+FqI/299q1qu8NPtB+376dRtQ24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qf0Gs6tE; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qf0Gs6tE"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AC5C214C2DB;
	Sun,  5 May 2024 13:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1714907659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4LHR19hAFTP2QYCStLYSuCHVAdmTGJHkSdXxe3Jnvj8=;
	b=qf0Gs6tEJbxr+ECx26CXin6ca2rLkO+gHjNsltw0Rt+uhwodyBvCxNJ89W+qBSdLnPwdMI
	OT/VS2Xxd1Xv7yJ1/5RofZDUmDSWYQfqXqj8QzqEQFVOwt61gYV0WiS8fm6kYqLvHzRBzw
	B2YBHzu7IBQ/m1uGJmk0XaDwaoJlBYumGnDgj07Clj3YU34BgO5mmqsu3TgMkwut77c+MC
	Fb6MNuWlnhgVagaog6yjatbBE+ycGAvxbgl40xyImydYQqF9AgNCvz9xeP5FA1rC+f4N5g
	TtJMb+PPYHd3AlrfPi33WnoaAjBeT+KXcVYiiARsnfJO+srOvdDlinyeQc3XJg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 679dde65;
	Sun, 5 May 2024 11:14:12 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 0/3] perf probe: Allow names to start with digits
Date: Sun, 05 May 2024 20:13:56 +0900
Message-Id: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRpN2YC/23MQQqDMBCF4avIrJsSY2JoV96jSKnJGIeCkYnYF
 sndm7ru8n/wvh0SMmGCa7UD40aJ4lxCnSpw02MOKMiXBiWVllpasSCPd0+BVmGV1mYw6IdWQTk
 sjCO9D+zWl54orZE/h73Vv/Uvs9VCCmPRNda1TXPRnYseX4zueY4coM85fwG2KTm8qAAAAA==
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=9eAXx8y5d8kDhI6LAXR0fz77K7tCB+kZ9tgT5yKzOe4=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmN2n/IyRsM+n+wtwdIZ8pvgEFgsboo3ARADr2j
 N1XDpfVPd2JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjdp/wAKCRCrTpvsapjm
 cMefD/4oJILrvU8XdYUq7zmeVntt8buSR6LvaaqCczEds/xjlCHtdFnQv6sZ2ZbhDZc9rM3Ules
 V0gDnm8rchvFIvDP2LmZfWUS0TSIc9sV3Rk6pSiM2E/RTh7pP/m11pQ6CnQO/F0nXYKzd9vuoc9
 UoPxklQ+7ZQtNGpTz3thKcSyMDJ9CbxXBOFUoka2+gZDsuPFvQQM0ykXAb1x9wGwamosyzOi+xC
 Q9Q9kVtWQ+vX6S9IBMVmZBMATE0mJt7JulYFJ2LASNMnAnVzd/MUhTwVcipQZsKUsf3n9+EC1Q4
 MmtkNTH0lzcqlbPFG7p6Udkcax2GVg7D90mfJYAl8U47iIFDvbQshwVJ8fXSj4NowJ3PYybDhZg
 Fsmoh0i2d8iPwFOZNdQaxU0r2t27pJGf3giZ80fa/oDdGv38XOCaHWa6vbAOh5bSTZNdHlwQ3HG
 OXcTg/j7FCzQI31RqkvoYZ/rcXNf+HjBnFphtzMNH5wHgtjCeyEuVt13ZSlvrSdW6dT/eB0NuBq
 0DQjIyb45APb/jnIiyXZWGAvnwBiQML7AJA6EQkWqdAWyARTtDmfrESVGCKrXRJzr/3hVmI+BiK
 ICezt8cV9i/E7uRWk4hfk1/jK168M/2/4m/+LF5Pp7pNceHxZPt7GIlgfYWc2ooJbsx9ihKOro7
 M+pRnEnhjGqu/TQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This is a rebase of the patch orginally sent almost two years ago here:
https://lkml.kernel.org/r/20220612061508.1449636-1-asmadeus@codewreck.org

At the time I was asked to add tests, and Jiri whipped up something to
make the test pass even for probes that don't exist on most systems but
that ended up never being formatted or sent... I asked what happened of
it and got asked to send it myself, but obviously also totally forget
about it myself until I needed it again now.

I've taken the diff from that thread, adapted it a little bit to the
current master branch and checked things still fall in place -- I didn't
see any obvious problem.

Thanks!

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Changes in v2:
- update Jiri's email in commit tags
- (not a change, but after being brain-dead and Ian helpful
reply I'm confirming patch 3/3 works as expected)
- Link to v1: https://lore.kernel.org/r/20240407-perf_digit-v1-0-57ec37c63394@codewreck.org

---
Dominique Martinet (3):
      perf parse-events: pass parse_state to add_tracepoint
      perf parse-events: Add new 'fake_tp' parameter for tests
      perf parse: Allow names to start with digits

 tools/perf/tests/parse-events.c | 11 +++++++++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  3 ++-
 tools/perf/util/evsel.c         | 20 +++++++++++++-------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  | 38 +++++++++++++++++++++++---------------
 tools/perf/util/parse-events.h  |  9 ++++++---
 tools/perf/util/parse-events.l  |  4 ++--
 tools/perf/util/parse-events.y  |  2 +-
 10 files changed, 61 insertions(+), 35 deletions(-)
---
base-commit: 7367539ad4b0f8f9b396baf02110962333719a48
change-id: 20240407-perf_digit-72445b5edb62

Best regards,
-- 
Dominique Martinet | Asmadeus

