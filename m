Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671F1DFD0
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246813; cv=none; b=eVkF7vXCnBep76JDKJXFUPRFtpPbR99psA5sQK0oo9x7TWvcJs5NN8XT41xAIehocjxhtqiUNmKXzGGT4PBK7oO0Nbpa34OnRISDhxPbwpzw/F4z355pA6LmWdRm8S5BbhTB2+/h2u6dznmi5RPKaM3z2gd5XiC/He9rs4K0hRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246813; c=relaxed/simple;
	bh=Q34RBrp8uw6JoxYwFTs08BU8Pcvf1eY0DnYthbxsTUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1m8APvaRrL2+Sfs2NzClOoDDtvXnkKhuHKbbct3GnC4Ju0fNN3STpLj75hPl5ybhjwsNh5aC4IpU8yjAIL9sVGthH1eNWocfsiWKs03bMv1ZnJc7ElloJmDV/Q6dazMTo05wzFJ/fik45b7um5Do+0jmLA62wDC87oBUAuf6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C81EE1684;
	Sat,  1 Jun 2024 06:00:34 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DCEF23F792;
	Sat,  1 Jun 2024 06:00:08 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 03/10] perf util: Replace an instance of strtailcmp() by str_has_suffix()
Date: Sat,  1 Jun 2024 18:29:39 +0530
Message-Id: <20240601125946.1741414-4-ChaitanyaS.Prakash@arm.com>
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

One instance of strtailcmp() that is identical to the use case of
str_has_suffix() has been replaced. As the other calls to strtailcmp()
do not seem equivalent to the str_has_suffix() use case, they are
retained as is.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..72305ffa5b6c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -564,7 +564,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
 	ret = debuginfo__new(path);
 	if (!ret && !silent) {
 		pr_warning("The %s file has no debug information.\n", path);
-		if (!module || !strtailcmp(path, ".ko"))
+		if (!module || str_has_suffix(path, ".ko"))
 			pr_warning("Rebuild with CONFIG_DEBUG_INFO=y, ");
 		else
 			pr_warning("Rebuild with -g, ");
-- 
2.34.1

