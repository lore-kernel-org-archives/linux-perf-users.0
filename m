Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504D6FC3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918850; cv=none; b=ikNqKTRqG7W+OIK6p37xp50MbQ0ozeBO/Ae2Utm4sZV1FlYBxp1X3xm/2vlGq2xFVSvVDCTQocAXpZVGyvBFweGsks+k1ABDGWrjVpaYI8cmECwws6P671KSMEocjSSWkJm+w1lnoH9UMtk/CCuZo5hizEcb+T06gS2VDK8kR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918850; c=relaxed/simple;
	bh=9SJ3FtrERhb1vrTy/aE11WAkfoPZFeUahtdAvgWHoEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw7Fii/bgBgDepo1Lp5GdHqnZoXD9+PxPPK3QijTGXDvA6DvaSM9/lT8Bh11rzcQjRguwV2A/Bw/XHIhm85i/+Z5qGai8hj133/lpV3WaS8hbxGvNpah651Ai6eqFaJEPZA/1Ur6hTQjjBhFax1w7Mf/4QGsOppYiWWIdSn64qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHQwDyQk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHQwDyQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8XsR2SmGZ6J3EcqXot0zngG7l3Py0ahXR2UjDVgv0Y=;
	b=UHQwDyQkafKQI8UkSy2UNLyKGh71DYR3LBJPCc8/iLNmIkY4u7SM15Na/QwK+Ppn1JV2NT
	TUfWCpj+TCnzQ6+mmWY984/DZ5RTKijxF2haZDcuwSKu/Ov+PNFsM14GQvwHLe2de5F28+
	fGY1qL5qYz812mQE1wH5T21YrffoKBs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-1DVhZYanPUyCgYAkkp9mdQ-1; Tue,
 02 Jul 2024 07:14:05 -0400
X-MC-Unique: 1DVhZYanPUyCgYAkkp9mdQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B68D194511E;
	Tue,  2 Jul 2024 11:14:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B58ED1956089;
	Tue,  2 Jul 2024 11:14:00 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 10/11] perf testsuite report: Add test case for perf report
Date: Tue,  2 Jul 2024 13:08:49 +0200
Message-ID: <20240702110849.31904-12-vmolnaro@redhat.com>
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

Add new perf report test case that acts as an entry element in perf test
list. Runs multiple subtests from directory "base_report", which can be
expanded without further editing.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../tests/shell/perftool-testsuite_report.sh  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
new file mode 100755
index 0000000000..973012ce92
--- /dev/null
+++ b/tools/perf/tests/shell/perftool-testsuite_report.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# perftool-testsuite_report
+# SPDX-License-Identifier: GPL-2.0
+
+test -d "$(dirname "$0")/base_report" || exit 2
+cd "$(dirname "$0")/base_report" || exit 2
+status=0
+
+PERFSUITE_RUN_DIR=$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
+export PERFSUITE_RUN_DIR
+
+for testcase in setup.sh test_*; do                  # skip setup.sh if not present or not executable
+     test -x "$testcase" || continue
+     ./"$testcase"
+     (( status += $? ))
+done
+
+if ! [ "$PERFTEST_KEEP_LOGS" = "y" ]; then
+	rm -rf "$PERFSUITE_RUN_DIR"
+fi
+
+test $status -ne 0 && exit 1
+exit 0
-- 
2.43.0

