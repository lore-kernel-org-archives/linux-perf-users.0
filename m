Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107C150992
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246825; cv=none; b=TO0UuT2oCNegjEh1rggzWX44uVvQBs7CGHeLjE1hhjo08rTIb0Vzd9/s3cVoyqr6vMuWXPZV9Iih6qjQJe6m58VRhUsv5VGMF2F8VqdlGQsRlu87Kqmcs0RQECkpo+0aD55cSAMAlTgZhJN+go4ezX7/G+cYqpwwmrNX1cWvVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246825; c=relaxed/simple;
	bh=felYmt/YiNqNU2mvIZWxvnr3ezHnl6Dy/qmVtQfLnZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSvZPw/KyR8oetkfP5k+HZkG2tofaZxeyS6HjMmna/mf0HwqKcs1ieiEU0PpOa8b+JY02vF7Q0h1fexBwEbO5pTjBTepB7It/0oANuWDHmufcfUpV0pWcz43C6vQocpB0eylrABTTOTOS+hmsrUbm0cyhiImbibV1qd9lQkakhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 236A213D5;
	Sat,  1 Jun 2024 06:00:48 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D88F3F792;
	Sat,  1 Jun 2024 06:00:21 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 09/10] perf tools: Only treat files as map files when they have the extension .map
Date: Sat,  1 Jun 2024 18:29:45 +0530
Message-Id: <20240601125946.1741414-10-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

Strengthen the check to locate symbol map files in the tool's /tmp
directory. As the existing check allows non map files named in
"/tmp/perf-" pattern, it leads to possible dwarf library corruption
when perf is built with NO_DWARF=1. The try_to_find_probe_trace_events()
function behaves differently when built in that manner. Extending the
current check condition using the str_has_suffix() function to not only
validate the pattern but also ensure the file is of ".map" type allows
test perf probe of function from different CU to pass when built with
NO_DWARF=1.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/util/symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9e5940b5bc59..fbcc189edd8d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
 	const char *map_path = dso__long_name(dso);
 
 	mutex_lock(dso__lock(dso));
-	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
+	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0 &&
+		  str_has_prefix(dso__name(dso), ".map") != 0;
 	if (perfmap) {
 		if (dso__nsinfo(dso) &&
 		    (dso__find_perf_map(newmapname, sizeof(newmapname),
-- 
2.34.1

