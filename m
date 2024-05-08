Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7417C79;
	Wed,  8 May 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209281; cv=none; b=EkmeZTNXNB9YnrO1Y3Di5rZPJTV3wJfHYyCQ6yuOrEEY1hdrMTABIvXnQ8Azc6HvkccVlAB+Cw9p1Z2/H/GJFttXZXxCoDfKUNQBBkg2X9TYOxamTi66WOthJeI31WLQ+jXrSIG6bZB3qutCrbyg0V1HrTZKIGWmrXFqqlD44Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209281; c=relaxed/simple;
	bh=DtVkRLbSIWWL6W99drJAbKWruAWM/NFuDby/5Rgvx/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rKmtDffC8g6fdRgpOX5A2pL1S5LEM59kRYfMwksltMS+SHCCspXBPLhlHT/1BmwPcObjqwS6cE+hjd6z3dYcGoDV6gQchQKBYzIiYUmPJaWlkD9kA0KopRDvmPhLI2Y4lZBPg5KLO8omlqCPLovNIiB3aW/7UmXtrHBtDYSYnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Zln5e1uK; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Zln5e1uK"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C307814C2D7;
	Thu,  9 May 2024 01:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715209270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4kCd4f1fETSvtBT8U5U5jWRV3zFNJk5hsrFH2PIslo=;
	b=Zln5e1uKwmcX2sFl6Km81P8cCpACYAqJbTQw3bPtg4BOr0/pMuOS7n9WyTUM0EjiS1pQnS
	yFXfBIYEqTDb5IVB4BrLYnz6AO/MQdhxY5rSLUPh6pXrwvLY+3LDlF8ROKIm02S5dYwPAu
	Ne1WEF4cf7EEJJHUuq6MuOKV1mgr/El11jXFs2u9GTZIP1Px1B1y8MaVjS/aB+nTSgfsrj
	q+kwpB820fXVxGhqvcnX7r/QuAvX/7/76A8iV7nojimu+yjLo/B5VEckZqrTiWd3tqADxc
	kRISho/W3wCx5eYv7aHARG0/Ap3Dt+LdCqX8NbjEbkTMtgdJwxFs6fUaGHiBSA==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id aa59b7a1;
	Wed, 8 May 2024 23:01:02 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v3 0/3] perf probe: Allow names to start with digits
Date: Thu, 09 May 2024 08:00:44 +0900
Message-Id: <20240509-perf_digit-v3-0-9036bf7898da@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwEPGYC/23M3QqCMBjG8VuRHbeY+3DUkfcREbq96kvg5J2sQ
 rz3pidRdPg88PsvLAIhRHYuFkaQMGIY81CHgrmhGXvg6PNmUkgttLB8AupuHnucuZVam9aAbyv
 JMpgIOnzuscs17wHjHOi1t1O5vX8zqeSCGwtOWVcpddK1Cx4eBO5+DNSzLZXkhxthvrjMvAIHS
 tjON43/5eu6vgHYOQ+75wAAAA==
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=DtVkRLbSIWWL6W99drJAbKWruAWM/NFuDby/5Rgvx/A=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPAQpZxEW/ojbsturei7d9f/4vmOnm7OrY/SBw
 5VWo8P8kv+JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZjwEKQAKCRCrTpvsapjm
 cCGgEACrxicZKszCnF/FwNjXlR2m8t3fxnsm0c028fPhf2yOQu38JrwNTP6whexWJ7rDSUR5vk2
 HCHwkSFJiwxRkj+bbJ2wNMBaFCudxBSMR0ZmN86w82RbSTmYfymOXLUAS8azeswJVwTkKlSykQ/
 zIFMZC8wJXV/6o81L6R937yUUrNYq+gmXxJlR4AISkr5/wyghh4iYDTACTKzOUwWoFDzyFX6Ks6
 aZfD8aTxPSavrH2BFS2GsVh8MsJjO9ZcspfJaRLhsTIe+Q9dzQ4OTxOSVRXnj5uvkO01WZrqGrh
 5YeSDVw0WLHWNdy5VYTqS+7LFkwmK7kytG8Y65L2d8ZDFXiCqKI0Nq8oMy6ZROia9N3jvGq8K6x
 QBi093eyxZzi1Qb5KGSo5obXn3uWVSe75cdFPYNTgRcN9c0o1siDVwV6W2R8rTl8cuhJD9T0JKP
 UQxwnWXHTAWivzeLc7sTZnFJY+RiTSaCZ1SxTxOrIC++malt57LPb729Q21a002G/Mjoq2JtR12
 kmZ5SEnk3nk/TxxZ0PIqc0p5Oa0k9ZSAHKBN3eDnjrHqCvxPq+qJbTiiJRNKAAESHwUWQXnH69I
 sEhQR2KG1OBsM4Ic3IpQnfoNj1GojKyAALUOwPEovKWNrBzoPVv3r7KV2SDz8yjQK5Oaox45quv
 qXmUJ11GP2+mNGQ==
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
Changes in v3:
- fix evsel__newtp_idx typo in commit 1's message
- rebase onto perf-tools-next
- add trailers
- Link to v2: https://lore.kernel.org/r/20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org

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
base-commit: 187c219b57eaf3e1b7a3cab2c6a8b7909bdbf4a9
change-id: 20240407-perf_digit-72445b5edb62

Best regards,
-- 
Dominique Martinet | Asmadeus

