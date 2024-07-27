Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAE1B86E0;
	Sat, 27 Jul 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722103174; cv=none; b=QmcBrLU0O1q/vRZZ1hWqoK5K+PCVXmynHtjAaUfh/6qVzodd9rxtXh919IQ4ujPliNKLjx5O950OJIHA4OAp5AYX28S+Gw1UctPt0oNZtUqWMUBVZF027Dob7WYc/x3vJAsPrnZYpV7VDysPtVy5VLQLCPf4GTfysg8qDRuEZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722103174; c=relaxed/simple;
	bh=yacrdQusfkCcIMqDSB29R/hnX5iOsHJv7Je8DcSsUOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5J1zOuSmZwqbnBezGPGgrpWS0wKU02MvYYtOh6W7Q2RaVlZ1JhVNiTN6JyL8r+bBRLyAS8LSQiTK8YXxU/p49v7K1c/x7V7nCWf7YE5SUiNKRg+qdbEMxpBQQ94SUQrSptJp+f+20VBdlgJgEHUp8aX9QOZmncmfP2ndT/UplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hh+AqGgJ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hh+AqGgJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=gNCePMHY9CyJAzGQAAO6F3n4UO9QnLvv118Cz3BcFFU=; b=hh+AqGgJy3h0hzG7
	oc8LgJ5i4SO2oP2xgJ9DNYoAAe9MKiO8JJSJq3WCm5eAOcBi0FV+HCc/DmEH5JwB2GNRc0DkvWp4O
	XwGZj+vyOExF+OGYHEKFQUBvUedWMsLUSEOAifs6CRGN5/dWTYwzepQGVAN4fB8vW1oRiEoPvjrQW
	panKT68edKBU4/Cz5n/6Jj3S4vS5GjQlwOQovA2QFxyzq6suMaDr1qJwj7Yacn8uhXn8dPxV7Wp9S
	LosL0xi4SVnTqn0/GnXX6AzUJg2qb/3xNAfSApuZNMijbit5RGqaQxZ4cZPneBYdxhsWQBHvEj3tT
	5KQmJ+ZOUoUqhgIVpQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sXlhQ-00DZBB-2y;
	Sat, 27 Jul 2024 17:59:20 +0000
From: linux@treblig.org
To: irogers@google.com,
	kan.liang@linux.intel.com,
	acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf test pmu: Remove unused test_pmus
Date: Sat, 27 Jul 2024 18:59:19 +0100
Message-ID: <20240727175919.1041468-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
test APIs") added the 'test_pmus' list, but didn't use it.
(It seems to put them on the other_pmus list?)

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/tests/pmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 40132655ccd1..0b2f04a55d7b 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -18,9 +18,6 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-/* Fake PMUs created in temp directory. */
-static LIST_HEAD(test_pmus);
-
 /* Cleanup test PMU directory. */
 static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
 {
-- 
2.45.2

