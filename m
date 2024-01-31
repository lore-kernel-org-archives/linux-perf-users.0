Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468876919
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701204; cv=none; b=B2JNwEKaqF8QIq8g21ViF/96MCKYPw8UhVyyNqKDjTzDwu6oVhttH+RSEZ/u3jAErvbwGkFsML2uVnpQpzRTowHhYoY6ISSBYYdthgDx9NZiDYftnQGXWkYfQiw/3Qo7BlvuF4jJl1EFSSwvXh60hVnDqCpc8SbShVtp+b4/Al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701204; c=relaxed/simple;
	bh=VkC8v9rYvt1miZLyLPK3Tm0EhN41r2X6xLIY3yVMtss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JxBtMnLDoiaYEZeUZ7Biw69sb3JBAhsVaX24TUPHOLKqd/tf5RMYItG/WTZtdE4UMqem5DKyh8jkXQ2fWIsMbEDQEvvjWSv1AsIpEv1hS94AKRuHh9kyuAqLlNTTY9HjZgn0QcJ0Tls5xmlfwZtVRAZG4RuqMlncDM7mjfwX7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGBem03e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGBem03e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706701201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=DySuYH+pPZyx52Q/wPNrdrWDlVm+ileYljUK5Vxs94w=;
	b=FGBem03ec8ZFSShYRv/496aqmunZs/X6TLgrPsQL60dcyaEBK3OjnXCXGoJF945TkhXW3F
	Sv3uCEzTX+q4SicsDAftjc72xN10dbpIHQM55d2RX6THkkcuzyxuq/MOHo9/hvJjeY3wM9
	E7ZJH70EK1rXPwfNQEDLTjHvG0fKQPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-igLSNNraO-eLgdD0mgpQhA-1; Wed, 31 Jan 2024 06:39:59 -0500
X-MC-Unique: igLSNNraO-eLgdD0mgpQhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64623835389;
	Wed, 31 Jan 2024 11:39:59 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F515C1ED63;
	Wed, 31 Jan 2024 11:39:57 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	acme@kernel.org
Cc: mhiramat@kernel.org
Subject: [PATCH 4/7] perf testsuite: Add test case for perf probe
Date: Wed, 31 Jan 2024 12:39:48 +0100
Message-Id: <20240131113951.17077-4-mpetlan@redhat.com>
In-Reply-To: <20240131113951.17077-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
 .../tests/shell/perftool-testsuite_probe.sh   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
new file mode 100755
index 000000000000..84ffa84dc6b1
--- /dev/null
+++ b/tools/perf/tests/shell/perftool-testsuite_probe.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# perftool-testsuite_probe
+# SPDX-License-Identifier: GPL-2.0
+
+test -d "$(dirname $0)/base_probe" || exit 2
+cd "$(dirname $0)/base_probe"
+status=0
+
+export PERFSUITE_RUN_DIR=$(mktemp -d /tmp/$(basename $0 .sh).XXX)
+
+for testcase in setup.sh test_*; do                  # skip setup.sh if not present or not executable
+     test -x $testcase || continue
+     ./$testcase
+     (( status += $? ))
+done
+
+if ! [ "$PERFTEST_KEEP_LOGS" = "y" ]; then
+	rm -rf $PERFSUITE_RUN_DIR
+fi
+
+test $status -ne 0 && exit 1
+exit 0
-- 
2.43.0

