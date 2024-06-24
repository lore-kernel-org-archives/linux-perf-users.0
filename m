Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885013D52B
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234555; cv=none; b=V7se8WQ7lw+ZU2PChNpOvUvEIXe3ibt6+ntp66GViWd2xoLDxYayEr55JT3R9DvSQ/+s3Km/Pvvrr6d7hVJNven4tixq7D2oiI3ZABXpsE3xEqkJoAtGN3c0/YpREcUwzNdVlKlHt51HtV9rkwbucx5imHVJMBgaE5du0KOf5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234555; c=relaxed/simple;
	bh=4rWfRICK5eK8fOcLP/5DCeUQuit7BHgHTSzzgvJhVX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AEpzpauz6wbr4G+HT0WsFWX9cHrKEjx9nY5rC+TPj+AQQ5HEiiQDIZ4EQRPm+0RKh4Lz00mdPt3qiBfOHpXLDxqf+6C9EXhL/nmVLQVp39hr+tqDP+G3FuDlFAlsO6e5dE8y9lnYsZzbGHkFv0zWPMWk/L+LbjLQyUxhBo20JGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2P1anos; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2P1anos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=nxBDlPqzJrazIw6DRXeyc4SH5oI3KAb/OqPdxq8NAT0=;
	b=E2P1anos0RZx84rnk0if0GKO57S5WHoUA0KMenBo2V9cr/v+6TyqZm4f0Ejfk6sGofjOH8
	6j7jKDZtIfn0JJi2Rk2TY+5AyCi3HwGd8zS6dViOvpZ466SjVJuHDYXFf/r60l+B9WKSjw
	q6XUxHRd8iNfsSMLoUDjv7vz8ohuAkA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-4D1RS438PBuoq4novJ8NDA-1; Mon,
 24 Jun 2024 09:09:09 -0400
X-MC-Unique: 4D1RS438PBuoq4novJ8NDA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D3E419560B5;
	Mon, 24 Jun 2024 13:09:08 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62A9A1956087;
	Mon, 24 Jun 2024 13:09:00 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 10/11] perf testsuite report: Add test case for perf report
Date: Mon, 24 Jun 2024 15:08:08 +0200
Message-Id: <20240624130809.1612-11-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
index 000000000000..973012ce92a7
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

