Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7715A87B
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918843; cv=none; b=JXax2bCAHVw4BWus5sE1X4Cp71e6XZrxsMYO90Z/4Xfw+EBHF7i864+2anYuC67U7v0IfEVab1LNW4134asRURFORrKnS1EV5Nhu/xpkrb67aC6Qj90ouBXqZfKRz9eMTUCy3ZH3WLbrqnsKLkbfcjOvF3hFdOSZRUCo3oB2PyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918843; c=relaxed/simple;
	bh=gHzMCEZlww5sK+YPZiTLf7uMK/heidVYtDRbhcNp2BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt2GaOl9OUTbviZAOxBqEd7qLcsCdv7yjiHYuwXfAv4YIFTzntYL1iOnC6M+KQD+u46upk8+SMuzoRZYvKysZPome8ECgKaOM1IYaHLjF/p7lSIu4whL8C/9bB5+dk4Q+WUdHZUWfdJkoqbsIv/YEpncagQy6+tjF+rIVDLdXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdRMQV0t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdRMQV0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a661Udc/cBIiV730pqdSaDW//QCWTkixQ0QtSICxOnI=;
	b=HdRMQV0tImtd+M5gce5Iu8rVKmm/9JUkDIy3+icCFnfMG/QkQT5K7izkmdEk4/2MFmzdpU
	Hc8BDWlFsIeJi2Fb4UlnDm6CZzvgiTEnS3hKsVDSC2MHmK0UuP88kg3x2sBdH+WoXjZl4+
	dvCgrK09XuaB4q6gcp4yDsZGOmSx+lI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-quHyUNHLNWOY5_WdqJi66A-1; Tue,
 02 Jul 2024 07:13:58 -0400
X-MC-Unique: quHyUNHLNWOY5_WdqJi66A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A265C19560BF;
	Tue,  2 Jul 2024 11:13:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10A6D1956089;
	Tue,  2 Jul 2024 11:13:52 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 08/11] perf testsuite: Add common output checking helper
Date: Tue,  2 Jul 2024 13:08:47 +0200
Message-ID: <20240702110849.31904-10-vmolnaro@redhat.com>
In-Reply-To: <20240702110849.31904-1-vmolnaro@redhat.com>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
index 0000000000..c57d355dd7
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

