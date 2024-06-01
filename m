Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14341DFCF
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246814; cv=none; b=tcJP67p/s9SaAFYnVrsD4DYbv5utDF++PC0M3nNYKgbumFS6q7mT43uAyzD3S8INQkc9M3vstG1N7nlu3/AHmX+y7d9qkIDituZiFgeOTBninxxGhXsay/KUuYRxd3ILVYXb4XLdoQqrOs7Nw5qxkL5C7eeMeeV4A3Hwiy0Q1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246814; c=relaxed/simple;
	bh=7nLgiF07diEz3KMxku9/AhwJrUqzt+HD9jM0dLPxCqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APaGoyttDX0B0f6y8rlSk68jCFAbwy6iCUpxCSBhJG6VkiY0BRNXWAVuh+ffgbTZcNYOtv3sPMXGDmD596CYTDtlUgMBKwSuDZbvGS6f4gHrr+pY/cdox/oxA7MRj+Zs5lhL5swLGieOZUF/m5n5KwGKceGTpQg6+qsa43uk6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77A1E13D5;
	Sat,  1 Jun 2024 06:00:30 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 951C23F8A4;
	Sat,  1 Jun 2024 06:00:04 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 01/10] tools lib: adopt str_has_suffix() from bpftool/gen.c
Date: Sat,  1 Jun 2024 18:29:37 +0530
Message-Id: <20240601125946.1741414-2-ChaitanyaS.Prakash@arm.com>
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
index 8b6892f959ab..5be69588dbe8 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -226,3 +226,29 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 
 	return check_bytes8(start, value, bytes % 8);
 }
+
+/**
+ * str_has_suffix - Test if a string has a given suffix
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
2.34.1

