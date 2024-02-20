Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EB56B85
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708403426; cv=none; b=Krd/Vd6iXOo12BadiUSFQC1ZZCN2mA2oiTnRLP58tI2Nbgm7tegdH1wNjA91M4B2yyIQ7by7T5DuKlQScgraQqXLXyQPj7PuccyAIM7rwr5EFm9jikqlTIyvz+9VPLhuzHFeGsmKLMQpg8mYKUXpFZoJqoBCDRzJC4K5zbM25Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708403426; c=relaxed/simple;
	bh=g+LhAA4I6SkO3LEiKWyM6bGMALp1zeQ5CbsCxIszQA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJOToXm8R4Z0xVrv8NeD88pBLRTjFWYz942eENhcYDuz8ChpXgb2dYnewSMBvsfxv8yX/YWhRE9oe0ulwHloci2UvTlV5h9X6d1zWDE229hiCjDVRxcCcQUpEArPZpVt0ncC0h3zalfvdn2nm3Z7F6DjpDs0RXPJrRM9eMtmj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17EFB106F;
	Mon, 19 Feb 2024 20:31:03 -0800 (PST)
Received: from a079740.blr.arm.com (a079740.arm.com [10.162.43.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 684AF3F762;
	Mon, 19 Feb 2024 20:30:22 -0800 (PST)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH 2/3] perf tools: Only treat files as map files when they have the extension .map
Date: Tue, 20 Feb 2024 09:59:56 +0530
Message-Id: <20240220042957.2022391-3-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

Perf currently treats any file beginning with "/tmp/perf-" as a map
file, even when map files always have the extension ".map". This causes
the test "perf probe of function from different CU" to fail because it
generates a binary with a filename in that format. When the test passes
it as an argument to be opened as an elf file, it's parsed as a map file
and results in garbage symbol names. Fix this by only considering files
ending in ".map" as map files.

The above failure is masked if Perf is built with dwarf support. But
with NO_DWARF=1, try_to_find_probe_trace_events() is skipped over in
convert_to_probe_trace_events() falling into
find_probe_trace_events_from_map() which results in the bad map file
parse data being consumed and the inability to create the probe event.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/builtin-script.c | 15 +--------------
 tools/perf/util/string.c    | 18 ++++++++++++++++++
 tools/perf/util/string2.h   |  1 +
 tools/perf/util/symbol.c    |  5 ++++-
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b1f57401ff23..c1c38a3df37a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -48,6 +48,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <signal.h>
+#include <string2.h>
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -3240,20 +3241,6 @@ static struct script_desc *script_desc__findnew(const char *name)
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
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 116a642ad99d..94c7af70e636 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -349,3 +349,21 @@ char *strreplace_chars(char needle, const char *haystack, const char *replace)
 
 	return new_s;
 }
+
+/*
+ * Returns a pointer to the first character of the suffix in str if the string
+ * ends with suffix, otherwise returns NULL.
+ */
+const char *ends_with(const char *str, const char *suffix)
+{
+	size_t suffix_len = strlen(suffix);
+	const char *p = str;
+
+	if (strlen(str) > suffix_len) {
+		p = str + strlen(str) - suffix_len;
+		if (!strncmp(p, suffix, suffix_len))
+			return p;
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 52cb8ba057c7..0b9d1579a701 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -40,5 +40,6 @@ char *strdup_esc(const char *str);
 
 unsigned int hex(char c);
 char *strreplace_chars(char needle, const char *haystack, const char *replace);
+const char *ends_with(const char *str, const char *suffix);
 
 #endif /* PERF_STRING_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index be212ba157dc..b87be3f1175a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <string2.h>
 #include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
@@ -1760,7 +1761,9 @@ int dso__load(struct dso *dso, struct map *map)
 	const char *map_path = dso->long_name;
 
 	mutex_lock(&dso->lock);
-	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
+	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0 &&
+		  ends_with(dso->name, ".map") != NULL;
+
 	if (perfmap) {
 		if (dso->nsinfo && (dso__find_perf_map(newmapname,
 		    sizeof(newmapname), &dso->nsinfo) == 0)) {
-- 
2.34.1

