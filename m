Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884B15099B
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246823; cv=none; b=BYr3icLiVTbNGIUJpI9pYqPOh/bdMADhBY6SSJAFIac9ampP6OUqTPdlozKPcl/Xw3CVgc+qDSgVV5v4iiJUdMCO6nKxwi+ZPCFcWFWNwNCcW6dEYWM/X/ygDUEsbdDrSPGvCZ9/DOXMa+NGXc4dgTbPm0E+5NUjfNakl/uHJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246823; c=relaxed/simple;
	bh=4z+TAZfnEXP+wK181XogNC0YGUtMTQKD4Xp740hIaSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDlz8QJ83bViYp2xXoBIk1iQzqRi4VeDNUOCbrEXNMx9Uw5HF6jb13Wvq1TQj06VbPRyThmikgN2mGgffRpoiEMSR67et1R4iJgIcgZqyAvZkSg4zZGOgd0TFatfTKa143+NCA+xl1C9FegNXmzMd0ojeepO0VJvpL3Yb7q5QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC48E153B;
	Sat,  1 Jun 2024 06:00:45 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06C3C3F792;
	Sat,  1 Jun 2024 06:00:19 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 08/10] tools lib: Remove strstarts() as all its usecases have been replaced by str_has_prefix()
Date: Sat,  1 Jun 2024 18:29:44 +0530
Message-Id: <20240601125946.1741414-9-ChaitanyaS.Prakash@arm.com>
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

As both strstarts() and str_has_prefix() are relatively similar in terms
of functionality, it is redundant to keep both. Delete strstarts() from
tools/include/linux/string.h as all its use cases have been replaced by
str_has_prefix()

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/include/linux/string.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index e02292fa1fab..696e064e139b 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -32,16 +32,6 @@ char *str_error_r(int errnum, char *buf, size_t buflen);
 
 char *strreplace(char *s, char old, char new);
 
-/**
- * strstarts - does @str start with @prefix?
- * @str: string to examine
- * @prefix: prefix to look for.
- */
-static inline bool strstarts(const char *str, const char *prefix)
-{
-	return strncmp(str, prefix, strlen(prefix)) == 0;
-}
-
 size_t str_has_suffix(const char *str, const char *suffix);
 
 size_t str_has_prefix(const char *str, const char *prefix);
-- 
2.34.1

