Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6D76919
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701208; cv=none; b=OIQlzizIH9/FuIwLlzKdNA5Wm2lBAoIQ/JTFyjgImzr9c4FG3BfAXkhxys2SFMbY4m2aRIe7UJABn9qh8zVaYlTHifWmXdoJc2dWq8oOf9VyrhheFCNM2exa2GKhcQ5RDy3s/cpEPVmm3BSj4yhnhMTq6U06Wa4MUk2CX3rfAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701208; c=relaxed/simple;
	bh=xQaUnXL564A8q0DolnzGBGBhWfKS4rWBSFxtLFmk6QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BiW1KyCveGjjy6lZds4G+rWFx7ci2X99Y0PA9xOVBy87W6idw+TgrZIwKIjWd+OYwqklryqlVHpwIqfLUUIggwVWYyYeD7wvffWTUz8wg5VwNjQTdVH6zIrufxVmkbZcT6A6M+xi3qib/Fq7fUJHEhWllGyX8APqoucR/LBiAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbgUa8wL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbgUa8wL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706701205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=Fqiyxf5mXZYRvUO7L5nvKegn29f04O1dCrlzvp7gewU=;
	b=YbgUa8wLlFuWEAn0TRJ7qFncbI9A2iMUa1hC1dMpQlpx2evT9AlAbWHrbhuX7Dhhbv+T6F
	hG3D6Pix0tNjgRkRB6biKGktV9W+hjfSL10XPlSYFruPBggIjcaibLF1gSQu2hjN522rqm
	Lzo9JyZBHhJC1CHarx/JDSnjzdXCiOo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-BRpQhy0qNSiIQRXgLpWAtQ-1; Wed,
 31 Jan 2024 06:40:01 -0500
X-MC-Unique: BRpQhy0qNSiIQRXgLpWAtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AFCA1C0518D;
	Wed, 31 Jan 2024 11:40:01 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BA59DC1ED64;
	Wed, 31 Jan 2024 11:39:59 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	acme@kernel.org
Cc: mhiramat@kernel.org
Subject: [PATCH 5/7] perf testsuite: Add common output checking helpers
Date: Wed, 31 Jan 2024 12:39:49 +0100
Message-Id: <20240131113951.17077-5-mpetlan@redhat.com>
In-Reply-To: <20240131113951.17077-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

As a form of validation, it is a common practice to check the outputs
of commands whether they contain expected patterns or match a certain
regex.

Add helpers for verifying that all regexes are found in the output, that
all lines match any pattern from a set and that a certain expression is
not present in the output.

In verbose mode these helpers log mismatches for easier failure
investigation.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../shell/common/check_all_lines_matched.pl   | 39 +++++++++++++++++++
 .../shell/common/check_all_patterns_found.pl  | 34 ++++++++++++++++
 .../shell/common/check_no_patterns_found.pl   | 34 ++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.pl

diff --git a/tools/perf/tests/shell/common/check_all_lines_matched.pl b/tools/perf/tests/shell/common/check_all_lines_matched.pl
new file mode 100755
index 000000000000..fded48959a3f
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_all_lines_matched.pl
@@ -0,0 +1,39 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+
+@regexps = @ARGV;
+
+$max_printed_lines = 20;
+$max_printed_lines = $ENV{TESTLOG_ERR_MSG_MAX_LINES} if (defined $ENV{TESTLOG_ERR_MSG_MAX_LINES});
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+$passed = 1;
+$lines_printed = 0;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	$line_matched = 0;
+	for $r (@regexps)
+	{
+		if (/$r/)
+		{
+			$line_matched = 1;
+			last;
+		}
+	}
+
+	unless ($line_matched)
+	{
+		if ($lines_printed++ < $max_printed_lines)
+		{
+			print "Line did not match any pattern: \"$_\"\n" unless $quiet;
+		}
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/tests/shell/common/check_all_patterns_found.pl b/tools/perf/tests/shell/common/check_all_patterns_found.pl
new file mode 100755
index 000000000000..11bdf1d3460a
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_all_patterns_found.pl
@@ -0,0 +1,34 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+
+@regexps = @ARGV;
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+%found = ();
+$passed = 1;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	for $r (@regexps)
+	{
+		if (/$r/)
+		{
+			$found{$r} = 1;	# FIXME: maybe add counters -- how many times was the regexp matched
+		}
+	}
+}
+
+for $r (@regexps)
+{
+	unless (exists $found{$r})
+	{
+		print "Regexp not found: \"$r\"\n" unless $quiet;
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/tests/shell/common/check_no_patterns_found.pl b/tools/perf/tests/shell/common/check_no_patterns_found.pl
new file mode 100755
index 000000000000..770999e87a5f
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_no_patterns_found.pl
@@ -0,0 +1,34 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+
+@regexps = @ARGV;
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+%found = ();
+$passed = 1;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	for $r (@regexps)
+	{
+		if (/$r/)
+		{
+			$found{$r} = 1;
+		}
+	}
+}
+
+for $r (@regexps)
+{
+	if (exists $found{$r})
+	{
+		print "Regexp found: \"$r\"\n" unless $quiet;
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
-- 
2.43.0

