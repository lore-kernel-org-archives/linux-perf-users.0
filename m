Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CB12B6C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557410; cv=none; b=XD85xkdsirZIndyP0noxQMo9HEq9FpJx+PjOHxG22AsRJ5eBlS6RwnmGzITVqmrJQQZ0hUnrv8jMBvuo7fvi2vAysVFP8Ur/QOVnSCwj7nYr8PTDqMOwGrNycWyVEm7gA6AsrEBk9HsmzfFbkk/z2lm01Yuri8csylupp/GCZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557410; c=relaxed/simple;
	bh=1we/IX6J6Rv/H2sWpUHprnlJZj3ikUR1jPt4Rl/8k6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tbb2OTvbz0oN7jJ/aqYbUeRMJCcBgtQK8HlC+aQ038GHg6tYBgdXFfgY3/PIP8AUrqbbHSymDxu0e1Y8ObnPzoAfBYZhmQwPbte+QbQQHyeWrlJ/t74kGqiU7vIaTXSkw5Iqum1YylbvMQlWcv7muiLyHrJa9G1nrS5g/uo+awQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7264A12FC;
	Sun,  7 Apr 2024 23:23:53 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19DB53F6C4;
	Sun,  7 Apr 2024 23:23:20 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 1/8] tools lib: adopt str_has_suffix() from bpftool/gen.c
Date: Mon,  8 Apr 2024 11:52:23 +0530
Message-Id: <20240408062230.1949882-2-ChaitanyaS.Prakash@arm.com>
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

Adopt the definition of str_has_suffix() from tools/bpf/bpftool/gen.c
and add it to tools/lib/string.c The function is modified to return
strlen(suffix) on success and 0 on failure.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index db5c99318c79..e43c8f78d63c 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -42,6 +42,8 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
+size_t str_has_suffix(const char *str, const char *suffix);
+
 extern char * __must_check skip_spaces(const char *);
 
 extern char *strim(char *);
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 8b6892f959ab..9cb515048239 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -226,3 +226,29 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 
 	return check_bytes8(start, value, bytes % 8);
 }
+
+/**
+ * str_has_suffix - Test is a string has a given suffix
+ * @str: The string to be tested
+ * @suffix: The string to see if @str ends with
+ *
+ * Returns:
+ * * strlen(@suffix) if @str ends with @suffix
+ * * 0 if @str does not end with @suffix
+ */
+size_t str_has_suffix(const char *str, const char *suffix)
+{
+	size_t i;
+	size_t str_len = strlen(str);
+	size_t suffix_len = strlen(suffix);
+
+	if (str_len < suffix_len)
+		return 0;
+
+	for (i = 0; i < suffix_len ; i++) {
+		if (str[str_len  - i - 1] != suffix[suffix_len - i - 1])
+			return 0;
+	}
+
+	return suffix_len;
+}
-- 
2.30.2

