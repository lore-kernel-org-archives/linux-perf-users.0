Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A412D772
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994969; cv=none; b=OZcqwRVqbx7zgeLF4lawczXM8S5qkyPkD2+rbDGNN9m1voifE/sZzUEgmn6nb/1eCZy8uk1iJ8B+W/7VgTKZKX0k6SBWaPbSXsvMXsj+r6Y4Mk+3jqRApcL8Uz8mU4WLFMnIfYuOwhF1WGRjO7TY3ZzCmWuFzReB77eL3PE+mY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994969; c=relaxed/simple;
	bh=Ja2wyTqd6TawugghFGrlGAbkXGQU1r4jistN0Fpp3hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=F3KZU8kdI64eUsBwb07YXQLvKN3Iepa3dPonFtICzYtPNKfIV73XFfpdmlGkyAdMocL/Qogw1EDghqDuI8IYPZU6mGfZ2H2hyoECI6ESd1hRV8eAaRk1htMFEBcx4n47R06xbwf9i6qS5io50LcUjbailVCsEncr0sKURNMkIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NagW8Omt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NagW8Omt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=RGB0zeVyPSdtr0KY627eXELrXuq4JNgDew1+NFMFRBY=;
	b=NagW8Omtj/2i5JcXzZCiw3KDqTcF6aF5jqme6KvnUlfMMOeYUXZAieV4RKA3aDt8j/Yw+U
	Z8NYFoGKb3grnucXGUSpPnJ1TrUxD8+kNsH3aAcCSEvOmAuq3nL0J60ZSwRxNP1F0j93jz
	Q+ox8XVJBkDFLfOmWIS4dwHgX8D+egw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-SiVggSSiOsuT82yux9C0FQ-1; Thu, 15 Feb 2024 06:02:43 -0500
X-MC-Unique: SiVggSSiOsuT82yux9C0FQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2176810650EC;
	Thu, 15 Feb 2024 11:02:43 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 34D242166B32;
	Thu, 15 Feb 2024 11:02:40 +0000 (UTC)
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
Subject: [PATCH v2 2/7] perf testsuite: Add common setting for shell tests
Date: Thu, 15 Feb 2024 12:02:26 +0100
Message-Id: <20240215110231.15385-3-mpetlan@redhat.com>
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

Add settings defining sample commands later shared by shell tests. This
adds the possibility to globally adjust the default values for the whole
testsuite.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/common/settings.sh | 79 +++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 tools/perf/tests/shell/common/settings.sh

diff --git a/tools/perf/tests/shell/common/settings.sh b/tools/perf/tests/shell/common/settings.sh
new file mode 100644
index 000000000000..361641dbaaad
--- /dev/null
+++ b/tools/perf/tests/shell/common/settings.sh
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+#	settings.sh
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This file contains global settings for the whole testsuite.
+#	Its purpose is to make it easier when it is necessary i.e. to
+#	change the usual sample command which is used in all of the tests
+#	in many files.
+#
+#		This file is intended to be sourced in the tests.
+#
+
+#### which perf to use in the testing
+export CMD_PERF=${CMD_PERF:-`which perf`}
+
+#### basic programs examinated by perf
+export CMD_BASIC_SLEEP="sleep 0.1"
+export CMD_QUICK_SLEEP="sleep 0.01"
+export CMD_LONGER_SLEEP="sleep 2"
+export CMD_DOUBLE_LONGER_SLEEP="sleep 4"
+export CMD_VERY_LONG_SLEEP="sleep 30"
+export CMD_SIMPLE="true"
+
+#### testsuite run mode
+# define constants:
+export RUNMODE_BASIC=0
+export RUNMODE_STANDARD=1
+export RUNMODE_EXPERIMENTAL=2
+# default runmode is STANDARD
+export PERFTOOL_TESTSUITE_RUNMODE=${PERFTOOL_TESTSUITE_RUNMODE:-$RUNMODE_STANDARD}
+
+#### common settings
+export TESTLOG_VERBOSITY=${TESTLOG_VERBOSITY:-2}
+export TESTLOG_FORCE_COLOR=${TESTLOG_FORCE_COLOR:-n}
+export TESTLOG_ERR_MSG_MAX_LINES=${TESTLOG_ERR_MSG_MAX_LINES:-20}
+export TESTLOG_CLEAN=${TESTLOG_CLEAN:-y}
+
+#### other environment-related settings
+export TEST_IGNORE_MISSING_PMU=${TEST_IGNORE_MISSING_PMU:-n}
+
+#### clear locale
+export LC_ALL=C
+
+#### colors
+if [ -t 1 -o "$TESTLOG_FORCE_COLOR" = "yes" ]; then
+	export MPASS="\e[32m"
+	export MALLPASS="\e[1;32m"
+	export MFAIL="\e[31m"
+	export MALLFAIL="\e[1;31m"
+	export MWARN="\e[1;35m"
+	export MSKIP="\e[33m"
+	export MHIGH="\e[1;33m"
+	export MEND="\e[m"
+else
+	export MPASS=""
+	export MALLPASS=""
+	export MFAIL=""
+	export MALLFAIL=""
+	export MWARN=""
+	export MSKIP=""
+	export MHIGH=""
+	export MEND=""
+fi
+
+
+#### test parametrization
+if [ ! -d ./common ]; then
+	# set parameters based on runmode
+	if [ -f ../common/parametrization.$PERFTOOL_TESTSUITE_RUNMODE.sh ]; then
+		. ../common/parametrization.$PERFTOOL_TESTSUITE_RUNMODE.sh
+	fi
+	# if some parameters haven't been set until now, set them to default
+	if [ -f ../common/parametrization.sh ]; then
+		. ../common/parametrization.sh
+	fi
+fi
-- 
2.43.0

