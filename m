Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05418C19
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557408; cv=none; b=AyJGXHivqcUwxiZNizZIK3+Uqx84bT1+Ex4MF3N6achOfzKVcDZdkPddC0n0HeTlibG1qL2qP8PodQ1RrIaMf6CQWp/nVeslrx7eV3zYE54yAL90cbhHwD4ctnVlRADlwqgKYjT9CRRkLoNU4FgDpc6+aV5LKc3Hr5uGYtdl58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557408; c=relaxed/simple;
	bh=ihpKRxw2ESqM+8ukW4kmzFgrfLFqCKymCnlYsjQtElk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNGdrqw4uELEnkIwYsy99uNSmYy5I9dubgbaVhP7XEJ6yoAn9pr/CBJsgoLN6u1PbBNHeaeq+WxPepbuGBSa0VPP2VjdkjVPpQWfU3Tt8/P+HhhdUzYrsT/H/DATl8mLcbdN6nXWLUBB50OU/tXwKg988OZ5KcSuXpzcZKH8cgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93E621682;
	Sun,  7 Apr 2024 23:23:56 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A03E53F6C4;
	Sun,  7 Apr 2024 23:23:23 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 2/8] perf util: Delete ends_with() and replace its use with str_has_suffix()
Date: Mon,  8 Apr 2024 11:52:24 +0530
Message-Id: <20240408062230.1949882-3-ChaitanyaS.Prakash@arm.com>
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

As str_has_suffix() has been introduced in tools/lib/string.c having
another locally defined function ends_with() to check if a string has a
given suffix is redundant. Delete ends_with() and replace its use with
str_has_suffix(), and update the error checks accordingly.

The return type of ends_with() is const char*, whereas that of
str_has_suffix() is size_t. get_script_root() has been modified
accordingly to accommodate this change.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/builtin-script.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..6cedd9cdde21 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3263,20 +3263,6 @@ static struct script_desc *script_desc__findnew(const char *name)
 	return s;
 }
 
-static const char *ends_with(const char *str, const char *suffix)
-{
-	size_t suffix_len = strlen(suffix);
-	const char *p = str;
-
-	if (strlen(str) > suffix_len) {
-		p = str + strlen(str) - suffix_len;
-		if (!strncmp(p, suffix, suffix_len))
-			return p;
-	}
-
-	return NULL;
-}
-
 static int read_script_info(struct script_desc *desc, const char *filename)
 {
 	char line[BUFSIZ], *p;
@@ -3320,19 +3306,21 @@ static int read_script_info(struct script_desc *desc, const char *filename)
 
 static char *get_script_root(struct dirent *script_dirent, const char *suffix)
 {
-	char *script_root, *str;
+	char *script_root;
+	size_t script_len, suffix_len;
 
 	script_root = strdup(script_dirent->d_name);
 	if (!script_root)
 		return NULL;
 
-	str = (char *)ends_with(script_root, suffix);
-	if (!str) {
+	script_len = strlen(script_root);
+	suffix_len = str_has_suffix(script_root, suffix);
+	if (!suffix_len) {
 		free(script_root);
 		return NULL;
 	}
 
-	*str = '\0';
+	script_root[script_len - suffix_len] = '\0';
 	return script_root;
 }
 
@@ -3608,7 +3596,7 @@ static char *get_script_path(const char *script_root, const char *suffix)
 
 static bool is_top_script(const char *script_path)
 {
-	return ends_with(script_path, "top") != NULL;
+	return str_has_suffix(script_path, "top") != 0;
 }
 
 static int has_required_arg(char *script_path)
-- 
2.30.2

