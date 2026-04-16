Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF653A0B13
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338076; cv=none; b=fLwyzEplXADw8+VYcVYrMB0qrpTvnW6BMkb/G3eFcrGOEfokYvLi8RVYeVgZ0mAEQJPXVSZoC18z4a+qeSlKmvxI9HDKjEP7efO+jOhImjkbK4BXmCx3rMBZpIEE6bAeW2c3iaOOkmAG0a/fORf3tiy0dVRMLtjM8EWAmKkVZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338076; c=relaxed/simple;
	bh=q5rWMHu6mz4J8PtyIZMJ8EQ0nRMshhiUpWhuTyZnyNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHEIW8XJg6lK1dmKK54Lmv3Ibo83XHXsT/bAB/6YgEKkrSEKeAB6hqR75GhcvuEVDbosT+u9Honc109MczEZSCrNvSeiwPfD4lQ3KxpjLCcQ5YcRewRtimpGJI03NiUSDAlANp8NE80FOamiEANUrA8WyFv9T69RuGrTArgrNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtDbavnz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtDbavnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQeyxmkqHOVR1Sm0bJUXqQz5Bf0882ThR5JNApUtYYw=;
	b=OtDbavnzGc1vNyH8Xh3ZzRJHG312h4bZMoH+ZYwfCgYIfAepkgD1ud6bAdoXKOk+SE6b8y
	LUQN1gPDjotu+hWyuUOhPjcA5zD9Nn4IPWz47LP0nYKYyCwZ8HtJcRjGYOcejE6DpoyqYS
	BSVR/3oEh8w2H1S49fZa4xay4Hdf33Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-qhtMses1MVCWUkyViSBwqQ-1; Thu,
 16 Apr 2026 07:14:32 -0400
X-MC-Unique: qhtMses1MVCWUkyViSBwqQ-1
X-Mimecast-MFC-AGG-ID: qhtMses1MVCWUkyViSBwqQ_1776338071
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE50A1956061;
	Thu, 16 Apr 2026 11:14:31 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00EF6180047F;
	Thu, 16 Apr 2026 11:14:29 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 3/7] perf test: Add empty setup for base_probe
Date: Thu, 16 Apr 2026 13:14:15 +0200
Message-ID: <20260416111419.385010-4-jbrnak@redhat.com>
In-Reply-To: <20260416111419.385010-1-jbrnak@redhat.com>
References: <20260416111419.385010-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add empty setup to set a proper name for base_probe testsuite, can be
utilized for basic test setup for the future.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/shell/base_probe/setup.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh

diff --git a/tools/perf/tests/shell/base_probe/setup.sh b/tools/perf/tests/shell/base_probe/setup.sh
new file mode 100755
index 000000000000..fbb99325b555
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/setup.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# perftool-testsuite :: perf_probe
+# SPDX-License-Identifier: GPL-2.0
+
+#
+#	setup.sh of perf probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		Setting testsuite name, for future use
+#
+#
-- 
2.52.0

