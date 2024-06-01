Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFC1E49F
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246814; cv=none; b=qvyIxDaKiV6a/cZxGmMmbzpFqrJpsyE+PQqUm+bckCU2q57Vksg9d0Pw4ItHdf0yae93OWEVBqJLtZrLuaAbdBrG1oIgUZhoofqNdjg/hAzCnYShAcnfuB5DqbFRxsQrEb5OPKScl1yasqF3hQAgXLzcf+gRE3Oq7CKd3uKkUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246814; c=relaxed/simple;
	bh=aSBryWowqFCrtjGkBy1WgS8XdrB51D0oYGgGbqhcXQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6lfIIcb0blpkBO8sMT0EeUbBWn+mPs+DRSZ1NwL/9Xvi0XdTq5gIgwoeTz8w6TZNDyD/6JqIeoJ1L4EHrCGJc3wgYaahQUOpRwqkaaAIEvFx4IZtRQ4v6ArBJn2URKH0GyskCAEk2e6kvDH849e139QqQ/eLa7r15+3YH01kHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9AD16F8;
	Sat,  1 Jun 2024 06:00:36 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 141623F792;
	Sat,  1 Jun 2024 06:00:10 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 04/10] tools lib: Adopt str_has_prefix() from kernel
Date: Sat,  1 Jun 2024 18:29:40 +0530
Message-Id: <20240601125946.1741414-5-ChaitanyaS.Prakash@arm.com>
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

Copy str_has_prefix() from include/linux/string.h to
tools/include/linux/string.h with the intention to replace strstarts().

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

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
index 5be69588dbe8..243d79589b06 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -252,3 +252,25 @@ size_t str_has_suffix(const char *str, const char *suffix)
 
 	return suffix_len;
 }
+
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns:
+ * * strlen(@prefix) if @str starts with @prefix
+ * * 0 if @str does not start with @prefix
+ */
+__always_inline size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
-- 
2.34.1

