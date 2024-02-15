Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEF82C97
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994975; cv=none; b=dF+isL99dAvgzFz59SWIhchQSWDB90pm9nY+99iU7SUg3nN262CD5fRoBf7HjA63vXi9BMX5t4CFWWvQgsWsQMaNkdZiTLVP3OaLc5W2gosxMlKUSeuB43exPvtcH5cBjfvkVMTwZ6r/sGRagsI+wMzku3jWnT07o1EHCyjtdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994975; c=relaxed/simple;
	bh=lbH0tCi69GYpr2pIaXc//wLL95/w2GxycrOu5jdHhRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n9n3H6avPHAcQgFjC2+dlg1IbDuAlPYdtTyJSC31nC0y1ofAvUap/BV6n45PTQTlgUJyEUV2CvAJ6bUO+cB+Cbu1g6QszbVv3f9rn/jH6LM5zxJ0UXPRWk9ClV1cpYDlJaHvakO5atJjvdNnTNRIKHdMcD/EL10vb4gagyt1aE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SICA1C7d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SICA1C7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=BL1cQ/7e27X26cGhJpbMEVOR81GLedrzGae4WjfIBxE=;
	b=SICA1C7dEHTJ4D62fNZuyuGY/hqiQj8xxPkFrsi9U/FcmlrlPB61BRsVqFoAP3UyKbLaff
	71H84vkVazVhNmwTnloLqniIUWlUln6ITBnBpyWeaOiDRGm94qUgG48Gi65Vkk5FuTqMLK
	fkp/jZobfBlYTGd4ZUwHhvd82Wd3+As=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-YuwXezvNOUm8g8fVkVkXig-1; Thu,
 15 Feb 2024 06:02:49 -0500
X-MC-Unique: YuwXezvNOUm8g8fVkVkXig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DD281C0782C;
	Thu, 15 Feb 2024 11:02:49 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 79CD02166B36;
	Thu, 15 Feb 2024 11:02:46 +0000 (UTC)
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
Subject: [PATCH v2 4/7] perf testsuite: Add test case for perf probe
Date: Thu, 15 Feb 2024 12:02:28 +0100
Message-Id: <20240215110231.15385-5-mpetlan@redhat.com>
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

Add new perf probe test case that acts as an entry element in perf test
list. Runs multiple subtests from directory "base_probe", which will be
added in incomming patches and can be expanded without further editing.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../tests/shell/perftool-testsuite_probe.sh   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
new file mode 100755
index 000000000000..a0fec33a0358
--- /dev/null
+++ b/tools/perf/tests/shell/perftool-testsuite_probe.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# perftool-testsuite_probe
+# SPDX-License-Identifier: GPL-2.0
+
+test -d "$(dirname "$0")/base_probe" || exit 2
+cd "$(dirname "$0")/base_probe" || exit 2
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

