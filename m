Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C631311A1
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234544; cv=none; b=fJOAPoSUzTISyZUAtwnCC5H1u9DgjwooWkllgRwBU4EcluPMTpO9QOyPm3zomcl7v+M6xTSwB0QotzB3He1RJaJK1p5IVWookBFdFZE3h2MAusarxVwIPCutBvhsOEIO+E+Uj5uKgNPOaPIYGB90CISsWHyVVfrItKI2Lkigtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234544; c=relaxed/simple;
	bh=DC8NS0kimxAftoAKWhUtnfeJG/MXAPoeYxI5rX0ToH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AUXuu4JBQpiIFQLTf+QEK4lXAwRyxa+zly/AQcZKHuP4rAWLp3cAN8B0ne4c95K1ZchIDQsmla7UlTGU8tE6AEPWk3BYHUGoEXy5QYmw+5v+l+LG54O+nY4BO6FTF3fHrB5uR0Dl3OBSlgqERcfj9Ifi49R5G4jUE1fjQUVWuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brCn9cOV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brCn9cOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=bWwW/nNACNVDuWN4bN95ZMUVP12K3eOzelmvp4n2U6E=;
	b=brCn9cOVv5SkZx5jInbEDzJSqAO6Ft7SkrTclgHCxmYn9HV9JC8aCDb+bEPR1UWoU8akRH
	ouSxdeBFjx5Zv7Fw2GTN00+MwaVMMdZr8doiOCgKHUSJPcpkleVUrdqA+N7+g02z/JVUNZ
	KLLQDozQx+og9PKHM9XoqSdokBDVyw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-rnVxo8zAM_613gBHPnxZ-Q-1; Mon,
 24 Jun 2024 09:08:57 -0400
X-MC-Unique: rnVxo8zAM_613gBHPnxZ-Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B5BE19560B5;
	Mon, 24 Jun 2024 13:08:56 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E00B1956087;
	Mon, 24 Jun 2024 13:08:53 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 08/11] perf testsuite: Add common output checking helper
Date: Mon, 24 Jun 2024 15:08:06 +0200
Message-Id: <20240624130809.1612-9-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

As a form of validation, it is a common practice to check the outputs
of commands whether they contain expected patterns or match a certain
regular expression.

This output checking helper is designed to allow checking stderr output
of perf commands for unexpected messages, while ignoring messages that
are known to be harmless, e.g.:
  "Lowering default frequency rate to \d+\."
  "\d+ out of order events recorded."
  etc.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../shell/common/check_errors_whitelisted.pl  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl

diff --git a/tools/perf/tests/shell/common/check_errors_whitelisted.pl b/tools/perf/tests/shell/common/check_errors_whitelisted.pl
new file mode 100755
index 000000000000..c57d355dd76e
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_errors_whitelisted.pl
@@ -0,0 +1,51 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+
+$whitelist_file = shift;
+
+if (defined $whitelist_file)
+{
+	open (INFILE, $whitelist_file) or die "Checker error: Unable to open the whitelist file: $whitelist_file\n";
+	@regexps = <INFILE>;
+	close INFILE or die "Checker error: Unable to close the whitelist file: $whitelist_file\n";
+}
+else
+{
+	@regexps = ();
+}
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
+		chomp $r;
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
-- 
2.43.0

