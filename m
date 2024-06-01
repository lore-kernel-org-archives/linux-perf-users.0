Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E401514F2
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246818; cv=none; b=F3mzPpP+aXmpw3Zc4YUDMRHKpC46UMbgMgajOT43ecrYjQ4Z41ZSX0aTIpJRIn8xW70MP3lKpAza5Vyc8Vhuqgs8PSYBv5/CMQZO/Kam/8b+wOf7ChozoUwwqmj2cTEKL7yDpdDjIqYaEYYi4eIw/e1Wc/IYydvFFP8nGJdkFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246818; c=relaxed/simple;
	bh=/+WhEUcn0n6V1n58Q10mKyUdHCmrZPBMjWRHNc7SRWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMeFHw7oWq+duDMvLwQ671ev6GsJs0zFEMHzmt2Pv1l5ywMydT8lIUB5c9iF8UuOqeLA/wnE6FmjHSJNOsI71m73mAAyWKGW9Uru/um1d49NGp7r1pYPARcJIFMHYIaMvxszjIEEy0RFODdj6K5esbTyPmDPxiJhQKVMSvcGtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FCEE153B;
	Sat,  1 Jun 2024 06:00:41 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F5423F792;
	Sat,  1 Jun 2024 06:00:15 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 06/10] objtool: Replace strstarts() usage with str_has_prefix()
Date: Sat,  1 Jun 2024 18:29:42 +0530
Message-Id: <20240601125946.1741414-7-ChaitanyaS.Prakash@arm.com>
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

Calls to strstarts() are replaced with str_has_prefix() in an attempt to
standardize string comparison functions between tools/ and the kernel.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a33d9195b7a..1c5ffd44ab79 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2535,7 +2535,7 @@ static int classify_symbols(struct objtool_file *file)
 	struct symbol *func;
 
 	for_each_sym(file, func) {
-		if (func->type == STT_NOTYPE && strstarts(func->name, ".L"))
+		if (func->type == STT_NOTYPE && str_has_prefix(func->name, ".L"))
 			func->local_label = true;
 
 		if (func->bind != STB_GLOBAL)
-- 
2.34.1

