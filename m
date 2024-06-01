Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D281509B8
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246815; cv=none; b=bj2zg8RiiaxznNx5NA3jRgHQLWO8xD+ZxEG1tNn1URJ3lMpGbsZBDXNOXPc8Hw92F3ddTI9sQXhC1lRrEGYLbuOwEAivfXOYpdnxVgAUcEKS71wCkfQ0axeTXvihA5DG6Cb5q03fkIcWFF5BYrFEXdqgpBbRT9hRqbT1ChdWwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246815; c=relaxed/simple;
	bh=+NjiC/m42PX6z+f8azT6IT0aEdn/8wVJp90AiPgTejM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKbch4yV3JP8RMsBy17ozEDgaV/jAWAZKg7ihXJcxW2M6WiZMaWEIPpkIf1kz+JzGFd/H2nf1N5kciwsuXfiL0i1oqBQ6vrDtBfZ7hm5ZZC4hQRPszo/SsAN00HWQ2LID8Vre+BMgvG0uF7Ezpc5JCfHLeTfijsT+QzCBNqTEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CA60153B;
	Sat,  1 Jun 2024 06:00:32 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B899D3F792;
	Sat,  1 Jun 2024 06:00:06 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 02/10] perf util: Delete ends_with() and replace its use with str_has_suffix()
Date: Sat,  1 Jun 2024 18:29:38 +0530
Message-Id: <20240601125946.1741414-3-ChaitanyaS.Prakash@arm.com>
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
index c16224b1fef3..ef622d71195f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3301,20 +3301,6 @@ static struct script_desc *script_desc__findnew(const char *name)
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
@@ -3358,19 +3344,21 @@ static int read_script_info(struct script_desc *desc, const char *filename)
 
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
+	suffix_len = str_has_suffix(script_root, suffix);
+	if (!suffix_len) {
 		free(script_root);
 		return NULL;
 	}
 
-	*str = '\0';
+	script_len = strlen(script_root);
+	script_root[script_len - suffix_len] = '\0';
 	return script_root;
 }
 
@@ -3646,7 +3634,7 @@ static char *get_script_path(const char *script_root, const char *suffix)
 
 static bool is_top_script(const char *script_path)
 {
-	return ends_with(script_path, "top") != NULL;
+	return str_has_suffix(script_path, "top");
 }
 
 static int has_required_arg(char *script_path)
-- 
2.34.1

