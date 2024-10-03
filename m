Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001F15887C
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Oct 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959929; cv=none; b=duo5yqszoUMNXbM3I1eULpXlWqnES0fm+0kYUsfoHiAyPO7SVs8Ju8Mx73bRarZzV5gjFRHJvhRSzdzLHwdCG7yQVhDciecZdn//VTnnrWZ5FGQFT2QI5XeTgOB+L6AQdpCExUTaeOGcR3HOBEWnuIDL6lXwIORrzFxjoBLfd3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959929; c=relaxed/simple;
	bh=F84YyuvX1DI+go9LeV5YJkuke86ak/U00VgVB46uymI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAoWHrUIRDrCBS/pIgBTuPLWSnvFB7ijknLxR5NQynMyMoBn4A+QzRkyGp48ZjHYVd+4z/i5p3H/ObWg7dBxdg+lKeL5Pt/4t+17AtbPGmzBJ+8VNcttKfPI7Dx6LUxPb3QWf1zCsuCHI/awPpxzhNGHeZFdyWlYlZnE+Xd2Kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9b3REOQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9b3REOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727959927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViLnLhR4eSeV0RSNRnhL/KcIZtZAgtysiL1Ib2jzFM4=;
	b=Z9b3REOQw60l7+Jk+AzSD/hZes94VUsn/nQMriPVis+DUp3RXjBq/PEBkoNiVeu08g9thA
	tjg2Q50+GJSTdii1Ox4kr83SHKKFwJsMXg+v66H9j81azrTNkR5BsuojmxPHvoe4pEp1hr
	ZR93Igc9rcsXcqPrigME4fE6iCKQcaY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-FwMA_oPINxiNOEfoASbpxQ-1; Thu,
 03 Oct 2024 08:52:03 -0400
X-MC-Unique: FwMA_oPINxiNOEfoASbpxQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 300A91955BC4;
	Thu,  3 Oct 2024 12:52:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.146])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29D3219560A3;
	Thu,  3 Oct 2024 12:51:57 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	mark.rutland@arm.com
Subject: [PATCH v2] perf test: Restore sample rate for perf_event_attr
Date: Thu,  3 Oct 2024 14:51:36 +0200
Message-ID: <20241003125136.15918-1-vmolnaro@redhat.com>
In-Reply-To: <ZvyRefEz4lj4evm5@google.com>
References: <ZvyRefEz4lj4evm5@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

Test "Setup struct perf_event_attr" consists of multiple test cases that
can affect the max sample rate value for perf events. Some test cases
check this value as it should not be lowered under the set minimum for
the given test. Currently, it is possible for the test cases to affect
each other as the previous tests can lower the sample rate, leading to
a possible failure of some of the future test cases as the value is not
restored at any point.

   # 10: Setup struct perf_event_attr:
    --- start ---
    test child forked, pid 104220
    Using CPUID 0x00000000413fd0c1
    running './tests/attr/test-record-C0'
    Current sample rate: 10000
    running './tests/attr/test-record-basic'
    Current sample rate: 900
    running './tests/attr/test-record-branch-any'
    Current sample rate: 600
    running './tests/attr/test-record-dummy-C0'
    Current sample rate: 600
    expected sample_period=4000, got 600
    FAILED './tests/attr/test-record-dummy-C0' - match failure

Restore the max sample rate value for perf events to a reasonable value
before each test case if its value was lowered too much to ensure the
same conditions for each test case.

   # 10: Setup struct perf_event_attr:
    --- start ---
    test child forked, pid 107222
    Using CPUID 0x00000000413fd0c1
    running './tests/attr/test-record-C0'
    Current sample rate: 10000
    running './tests/attr/test-record-basic'
    Current sample rate: 800
    running './tests/attr/test-record-branch-any'
    Current sample rate: 700
    unsupp  './tests/attr/test-record-branch-any'
    running './tests/attr/test-record-branch-filter-any'
    Current sample rate: 10000
    running './tests/attr/test-record-count'
    Current sample rate: 10000
    running './tests/attr/test-record-data'
    Current sample rate: 600
    running './tests/attr/test-record-dummy-C0'
    Current sample rate: 800
    running './tests/attr/test-record-freq'
    Current sample rate: 10000
    ...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Radostin Stoyanov <rstoyano@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/attr.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index e890c261ad2695d8..3db9a7d78715f1d9 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -246,6 +246,23 @@ class Test(object):
                 return False
         return True
 
+    def restore_sample_rate(self, value=10000):
+        try:
+            # Check value of sample_rate
+            with open("/proc/sys/kernel/perf_event_max_sample_rate", "r") as fIn:
+                curr_value = fIn.readline()
+            # If too low restore to reasonable value
+            if not curr_value or int(curr_value) < int(value):
+                with open("/proc/sys/kernel/perf_event_max_sample_rate", "w") as fOut:
+                    fOut.write(str(value))
+
+        except IOError as e:
+            log.warning("couldn't restore sample_rate value: I/O error %s" % e)
+        except ValueError as e:
+            log.warning("couldn't restore sample_rate value: Value error %s" % e)
+        except TypeError as e:
+            log.warning("couldn't restore sample_rate value: Type error %s" % e)
+
     def load_events(self, path, events):
         parser_event = configparser.ConfigParser()
         parser_event.read(path)
@@ -283,6 +300,7 @@ class Test(object):
         if self.skip_test_kernel_until():
             raise Notest(self, "new kernel skip")
 
+        self.restore_sample_rate()
         cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
               self.perf, self.command, tempdir, self.args)
         ret = os.WEXITSTATUS(os.system(cmd))
-- 
2.43.0

