Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132D69DE2
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701200; cv=none; b=h6GO1n8V3zPCueU6dQWHr3tFDjRWcNbck8hyh/jWwhxNv15ys9ylK5UQoUKBY8+yeXLxwsUt6TiomKDHpWCH1auqSDPJhVRKuZi0LHLK09S3nfCnhofdwsEIxs6wedCqqk5MOBV4oANlR1fyE9DvgjUP1ISqCtvUe8zP8wy3kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701200; c=relaxed/simple;
	bh=Ja2wyTqd6TawugghFGrlGAbkXGQU1r4jistN0Fpp3hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l1Iv5MM9t+/JcGqZ/v+bUGIWiA1mxdjXABG5TAh7JqgBHrbcHZqieLqhmhP2zBLnsTf9EiZFrZJmf68wS9nwOJBL/R498bmi691pv1n9D5p7mltxfmL02eGaevHb11oG2fMt8h+tKllNwRaB1N1P4guPGUSu9L0O4dBXnzhZlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+gJXbjT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+gJXbjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706701198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=RGB0zeVyPSdtr0KY627eXELrXuq4JNgDew1+NFMFRBY=;
	b=E+gJXbjTDpBKNP25OVKy6wSywPgVUSYrGeoTQGKxZDiA8FcNDX6llIgpN3x35wOA3cUtZn
	mIc7ILlCGi3j6EPktDpmYpVCX2GRzB3bwtoGb4wEf5pe1//Ht9RiAgA/39Mv6RtmmvjXxl
	4KFohu/wwSuI5j42adl6cNmPduOOugE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-NvZxB7fPPxe-xoy0CXaaLg-1; Wed,
 31 Jan 2024 06:39:56 -0500
X-MC-Unique: NvZxB7fPPxe-xoy0CXaaLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CE633C2E0A9;
	Wed, 31 Jan 2024 11:39:56 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A90BAC1ED63;
	Wed, 31 Jan 2024 11:39:54 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	acme@kernel.org
Cc: mhiramat@kernel.org
Subject: [PATCH 2/7] perf testsuite: Add common setting for shell tests
Date: Wed, 31 Jan 2024 12:39:46 +0100
Message-Id: <20240131113951.17077-2-mpetlan@redhat.com>
In-Reply-To: <20240131113951.17077-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

