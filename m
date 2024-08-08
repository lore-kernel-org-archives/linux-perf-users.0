Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270618A926
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113496; cv=none; b=CxlKJ8YNsvT3SqKB13MzuVIrBSimtc86pDWr15jfSZAIusL5aLi03Y71nQpgxZmP1qXnf3Akm+RAM8GTdtDjLQ73iKUMtX1GoyToz2zfX3peghqbJ+nifVhGVgrg+lSZTNPU6Nlg9vVlncUiZoJz1ALcvgI3mSIYpIXG2FRVZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113496; c=relaxed/simple;
	bh=rR17yrg504Ke28r2unGDV2/hQ+tUtHNUJJ4sgFouloI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OByRFoihnKj4m/x+i8EcFuBK8I8chir4o0ecm6qc4mh5poc54YxCsY38h22r9lPJQ6u3XpZcFjbDTtbSV72+LzBrgEU/2dihQ6nHcZ1EGqCwjAJMJgDuz1cgKODDnZNTwArPV58D7/VnS0LqKvQ5MzXHNemixn5Mb+Axjso5qMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxgrlWND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxgrlWND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723113493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L7DMpfvCFqWQFDmhUzUmqiLllEgTPzDZJPD9HmVCjy8=;
	b=CxgrlWNDfVjHb0Jnxchk3GV+DLcgAoCeg3qpWPWtUQehQIIvfrUPbpkUkDJuNSwS45dCfv
	Ddftpq7zS38a9Blw/Ooj8ImPBK5MO8ExL+pHmqxFoyMxHyt9pDfy9P+6+SpP2UH90vvFIl
	3zccVzSvdVejWa2uzw0UdGf6oMPxQDM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-au0ldaNgM9OXsPMI5AhHFA-1; Thu,
 08 Aug 2024 06:38:10 -0400
X-MC-Unique: au0ldaNgM9OXsPMI5AhHFA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C7CF1955F3D;
	Thu,  8 Aug 2024 10:38:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02BB6195396E;
	Thu,  8 Aug 2024 10:38:06 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	james.clark@arm.com,
	rstoyano@redhat.com
Subject: [PATCH] perf test pmu: Set uninitialized PMU alias to null
Date: Thu,  8 Aug 2024 12:37:49 +0200
Message-ID: <20240808103749.9356-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

Commit 3e0bf9 ("perf pmu: Restore full PMU name wildcard support") adds
a test case "PMU cmdline match" that covers PMU name wildcard support
provided by function perf_pmu__match(). The test works with a wide
range of supported combinations of PMU name matching but omits the case
that if the perf_pmu__match() cannot match the PMU name to the wildcard,
it tries to match its alias. However, this variable is not set up,
causing the test case to fail when run with subprocesses or to segfault
if run as a single process.

./perf test -vv 9
  9: Sysfs PMU tests                                                 :
  9.1: Parsing with PMU format directory                             : Ok
  9.2: Parsing with PMU event                                        : Ok
  9.3: PMU event names                                               : Ok
  9.4: PMU name combining                                            : Ok
  9.5: PMU name comparison                                           : Ok
  9.6: PMU cmdline match                                             : FAILED!

./perf test -F 9
  9.1: Parsing with PMU format directory                             : Ok
  9.2: Parsing with PMU event                                        : Ok
  9.3: PMU event names                                               : Ok
  9.4: PMU name combining                                            : Ok
  9.5: PMU name comparison                                           : Ok
Segmentation fault (core dumped)

Initialize the PMU alias to null for all tests of perf_pmu__match()
as this functionality is not being tested and the alias matching works
exactly the same as the matching of the PMU name.

./perf test -F 9
  9.1: Parsing with PMU format directory                             : Ok
  9.2: Parsing with PMU event                                        : Ok
  9.3: PMU event names                                               : Ok
  9.4: PMU name combining                                            : Ok
  9.5: PMU name comparison                                           : Ok
  9.6: PMU cmdline match                                             : Ok

Fixes: 3e0bf9 ("perf pmu: Restore full PMU name wildcard support")
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 0b2f04a55d7b..a4730b5dc0d9 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -453,11 +453,13 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
 /**
  * Test perf_pmu__match() that's used to search for a PMU given a name passed
  * on the command line. The name that's passed may also be a filename type glob
- * match.
+ * match. If the name does not match, perf_pmu__match() attempts to match the
+ * alias of the PMU, if provided.
  */
 static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_pmu test_pmu;
+	test_pmu.alias_name = NULL;
 
 	test_pmu.name = "pmuname";
 	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
-- 
2.43.0

