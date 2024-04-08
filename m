Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285A2F2E
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557441; cv=none; b=Gc4bEoi6nNOJHuVejuF5juVqVyMZG3O37Af0/dJuGv2L8sETHd8XOYRNMisi9oN2Yst7AcPXXrp08f8OLCDJGuj+nPNMDdGdlf66vo2No849pVU60FlDLsEelU5G6YI9uru8IA4c+TYUCKJxwGbDABRn73FW7NOKGDTrGSgomGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557441; c=relaxed/simple;
	bh=6lZrQn6CpVUXzEvvncQy53wX262yg5XyOvqsvSaaw2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9Z34TgRtN0bKZL8kImpo+sR+1pmBmBeg4gnuqZ5bQZX04sqdlvJqEO1JRE5Uj6UH8WuV2nJ3L9wr/jzmmkGd298SrzmNsib9omYLT33rGXxrLeQS4e339H/hqfnNn0DB6zboBr1n3KhYYT6nhDhJFGGSj3Ri6LTWaJ6bP4a8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0062B12FC;
	Sun,  7 Apr 2024 23:24:30 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 306CB3F6C4;
	Sun,  7 Apr 2024 23:23:54 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 7/8] perf tools: Only treat files as map files when they have the extension .map
Date: Mon,  8 Apr 2024 11:52:29 +0530
Message-Id: <20240408062230.1949882-8-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
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
 tools/perf/util/symbol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9ebdb8e13c0b..812684aa42ce 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1792,7 +1792,9 @@ int dso__load(struct dso *dso, struct map *map)
 	const char *map_path = dso->long_name;
 
 	mutex_lock(&dso->lock);
-	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
+	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0 &&
+		  str_has_suffix(dso->name, ".map") != 0;
+
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
 		    sizeof(newmapname), &dso->nsinfo) == 0)) {
-- 
2.30.2

