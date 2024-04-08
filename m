Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC508820
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557421; cv=none; b=ine99qaBGoK5J/eWaSdmwivB3vlX59J/awoxSghORrBqNJV8epuYk1M4DetdOZKaWpeccXfqUJB+1PyR1/sVv5JVoW/khNsnO7WkzfS7LvAgok9YLG8UzK8ZuervFQMT8EV6zqeoWjCN1Mnuc4EglYSDKtGbCs9iSNPXalNXsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557421; c=relaxed/simple;
	bh=5MH1u1Y9OYHux05OGmvA+sdvu9It05ftXdtCAbnPF0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWcbxJG34dCgVVm8zXAIH/dPgJ5stwk7mgh3KEzOFNfkeryl5aXz9+gZ5NpjMIGF8peJI5GihiXBhzskR5+nZ6VtocwywTmeNKn++Xcy4ePaOwAnSt2K1IgVhU8WuvHOAJ953pR4eK527C9CdkIFnxXECQ7OrgNofFeXESxX3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39E6412FC;
	Sun,  7 Apr 2024 23:24:09 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 450223F6C4;
	Sun,  7 Apr 2024 23:23:31 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 4/8] tools lib: Adopt str_has_prefix() from kernel
Date: Mon,  8 Apr 2024 11:52:26 +0530
Message-Id: <20240408062230.1949882-5-ChaitanyaS.Prakash@arm.com>
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

Add str_has_prefix() to tools/include with the intention to replace
strstarts().

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index e43c8f78d63c..e02292fa1fab 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -44,6 +44,8 @@ static inline bool strstarts(const char *str, const char *prefix)
 
 size_t str_has_suffix(const char *str, const char *suffix);
 
+size_t str_has_prefix(const char *str, const char *prefix);
+
 extern char * __must_check skip_spaces(const char *);
 
 extern char *strim(char *);
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 9cb515048239..76b15ee6493e 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -252,3 +252,19 @@ size_t str_has_suffix(const char *str, const char *suffix)
 
 	return suffix_len;
 }
+
+/**
+ * str_has_prefix - Test is a string has a given prefix
+ * @str: The string to be tested
+ * @prefix: The string to see if @str starts with
+ *
+ * Returns:
+ * * strlen(@prefix) if @str starts with @prefix
+ * * 0 if @str does not start with @prefix
+ */
+size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t prefix_len = strlen(prefix);
+
+	return strncmp(str, prefix, prefix_len) == 0 ? prefix_len : 0;
+}
-- 
2.30.2

