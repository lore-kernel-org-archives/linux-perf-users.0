Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE15168A3
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW665Let"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B57FE
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697706703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Mh1b7NoAePazbnIApMd8URhSdRHZek/pDCHfDJ2p8SM=;
	b=VW665Let368RavRVFD9Gk+ISsv6sKRsHF5mRCg5pJIP3EGcFW1d5DARyCKEUe6RbIaWp7+
	XUs3BlFLKKqeX4auysmHhSvlBHWO+MPq/15qjaA8xzfFzswmPVIOEPlvR7vWECZ17rq+LP
	2RzWY8YaMAqeYkwIaEKXd5p/+enFxwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-7EcMQAwzPh6F0eHXyQMlNw-1; Thu, 19 Oct 2023 05:11:41 -0400
X-MC-Unique: 7EcMQAwzPh6F0eHXyQMlNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EE3E185A79B;
	Thu, 19 Oct 2023 09:11:41 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C65202166B26;
	Thu, 19 Oct 2023 09:11:39 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com
Cc: vmolnaro@redhat.com,
	carsten.haitzler@arm.com
Subject: [PATCH] perf test: Skip CoreSight tests if cs_etm// event is not available
Date: Thu, 19 Oct 2023 11:11:37 +0200
Message-Id: <20231019091137.22525-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

CoreSight might be not available, in such case, skip the tests.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/lib/coresight.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
index 6c3d34ec64d8..11ed2c25ed91 100644
--- a/tools/perf/tests/shell/lib/coresight.sh
+++ b/tools/perf/tests/shell/lib/coresight.sh
@@ -10,20 +10,22 @@
 
 # perf record options for the perf tests to use
 PERFRECMEM="-m ,16M"
 PERFRECOPT="$PERFRECMEM -e cs_etm//u"
 
 TOOLS=$(dirname $0)
 DIR="$TOOLS/$TEST"
 BIN="$DIR/$TEST"
 # If the test tool/binary does not exist and is executable then skip the test
 if ! test -x "$BIN"; then exit 2; fi
+# If CoreSight is not available, skip the test
+perf list cs_etm | grep -q cs_etm || exit 2
 DATD="."
 # If the data dir env is set then make the data dir use that instead of ./
 if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
 	DATD="$PERF_TEST_CORESIGHT_DATADIR";
 fi
 # If the stat dir env is set then make the data dir use that instead of ./
 STATD="."
 if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
 	STATD="$PERF_TEST_CORESIGHT_STATDIR";
 fi
-- 
2.18.4

