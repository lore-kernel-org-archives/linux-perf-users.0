Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802712B6C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557413; cv=none; b=EqzWCwVx844aO85AtcGoNSA4/ER4sA6/M6R52WYEnGRVKtBw6U/Zh8YJ6Wv10Iaf61XGbRdHPcI56gsZok6bVz08Vd3zyY2K6lXAN3iN+bQsrDdHgHyMS+Gh6przHfW3kJFVN5/A1xewCEAFzvm2/olF4WQ2baV3f/0cVw3C2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557413; c=relaxed/simple;
	bh=cu2xN6K+KpHQyutR77/COZMpLmgd00lLLqhC4EW+3NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txqN6ezJbpKftQX/xZHIMeVVv1vfJH0CI3aVoGYIxRsWTHN18RRM2U/zQ+VUlY96BPbe3arC+ys//MEalq1DfP06QXu/lDx2vDoF626AFsWU0Xo3m9qDGsD2qM/FJBDseHOQsKpO9P8Zkl9RJctcuR0pZxLwPRO+YDxU5LKETpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864D012FC;
	Sun,  7 Apr 2024 23:24:01 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BFDE13F6C4;
	Sun,  7 Apr 2024 23:23:26 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 3/8] perf util: Replace an instance of strtailcmp() by str_has_suffix()
Date: Mon,  8 Apr 2024 11:52:25 +0530
Message-Id: <20240408062230.1949882-4-ChaitanyaS.Prakash@arm.com>
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

This particular instance makes use strtailcmp() to check if the "path"
parameter is a loadable kernel module, it does so by checking if "path"
is followed by ".ko" suffix. As this use case is more suitable for
str_has suffix(), replace strtailcmp() with str_has_suffix().

The other calls to strtailcmp() do not seem equivalent to the
str_has_suffix() use case. As this function is not being hit in any of
the tests as well it would be rather risky to replace its use with
str_has_suffix(). Therefore, those calls are retained as is.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 2a0ad9ecf0a2..59e700170541 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -564,7 +564,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 	ret = debuginfo__new(path);
 	if (!ret && !silent) {
 		pr_warning("The %s file has no debug information.\n", path);
-		if (!module || !strtailcmp(path, ".ko"))
+		if (!module || !str_has_suffix(path, ".ko"))
 			pr_warning("Rebuild with CONFIG_DEBUG_INFO=y, ");
 		else
 			pr_warning("Rebuild with -g, ");
-- 
2.30.2

