Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494382C97
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994978; cv=none; b=PfUt88RMaC5zGmy61KcyvgG89Au546WLjOrtCKl5aJBNRB9b894AL2ydE55/cKA+mFILsm6PWOv8icuRlv4jJ9p+UsseoF02ISZ8V+k1NCcGk8QPpQweqrbEg5WW6bEvSAkJ39jOtl6mCbWngbHaeR0LjVFaMxjD3HiXUsta0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994978; c=relaxed/simple;
	bh=xQaUnXL564A8q0DolnzGBGBhWfKS4rWBSFxtLFmk6QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=njIjUK+20vHzl9Kv7nW3d3zitecaAR42+nLk8BElHGmVGPqpm2qRWlC+4CIaXZwlzpSNB5oZpyNk1P77OHQoBZstLEAQYDcPW+yedBKWKKZkwOTFawhBmQAUeOO1ElA7LGWK+noHnwVtJl1XPX2/vHx8fstYKN8ZKny0wDRZLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzmLWtgu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzmLWtgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=Fqiyxf5mXZYRvUO7L5nvKegn29f04O1dCrlzvp7gewU=;
	b=QzmLWtgunTUCFbhyyXDMqIUjBZKDHDnBhxHV0m26M2+fXX7oNZbYufPCgOqH4UhmP54N4I
	ogCcWpKu/GkQXG4IvG+Q3LXtn71Yv14PPNEMFQCinQIFzNO5woGK/hz6tBM+Y0ULSHq2xC
	YnaEb29Sfmx5Jy2XiN/hAIdGxAlxq9g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-CfP9A0cnMliwk1mRR-zhUw-1; Thu,
 15 Feb 2024 06:02:52 -0500
X-MC-Unique: CfP9A0cnMliwk1mRR-zhUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D8513800083;
	Thu, 15 Feb 2024 11:02:52 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 794142166B5D;
	Thu, 15 Feb 2024 11:02:49 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com
Subject: [PATCH v2 5/7] perf testsuite: Add common output checking helpers
Date: Thu, 15 Feb 2024 12:02:29 +0100
Message-Id: <20240215110231.15385-6-mpetlan@redhat.com>
In-Reply-To: <20240215110231.15385-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
 <20240215110231.15385-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

