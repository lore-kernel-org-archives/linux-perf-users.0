Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173915B0E4
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852834; cv=none; b=org+vxpjul3ONS77GgaNHP2hEYOw4HkMbt1Hvls3SrbvaMao+Khs/NN5cRJLoZlGO0AadVOns0cFFLPJeywTmoRCTVo4IGyr+bZHibMTdFKc4R9CSmFw13tn46ecuabMXuTxyomMZ7/GsPu+iY6qj9KngM9XQgKp8ox0K+cP8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852834; c=relaxed/simple;
	bh=kRYprtY9BPYMcTbRMPQpYQKMqRWSyo8AJ74TBjibN6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6PbDTz66WO0aQ4LEh2aIDWCMQAso6bmcRGWXq6rJpJoy4llRuZWEN7yBunOJP7wW0wqIwDwYTs0F83H1wuplbjk6Dcq4PF2iE6JpvE9ETP5HFx2luPjmGoJpDrvq+WXeoEIPBLB1bTyPFMsncOUQmN445/NpsO7Keo/egc6TYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aN61vXRd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN61vXRd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724852831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VjWNH+PldJI5/bt/V+sqxJdxQZEZZnfm0s3//uHANdg=;
	b=aN61vXRd+mKAe6hmY6fOnpPCq3OAShu1PeGV7KyycLD032Z5c8f3HOqnFuNKKtc1BOA58z
	irzcDlt0eCFhw1MmqaPBlxCXa0QopIWjLMzTpdKSG/j2/7DA8wUP+UBc5wgvF19R9xt1Og
	hkV47kZqFsNcyv80ze4n5Th1f+jOrys=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-kdfYF392Oj-mHHzPrV02Gw-1; Wed,
 28 Aug 2024 09:47:06 -0400
X-MC-Unique: kdfYF392Oj-mHHzPrV02Gw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1C511955D53;
	Wed, 28 Aug 2024 13:47:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.63])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BA4319560A3;
	Wed, 28 Aug 2024 13:47:00 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	rstoyano@redhat.com,
	mark.rutland@arm.com,
	kan.liang@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com
Subject: [PATCH] perf test: Restore sample rate for perf_event_attr
Date: Wed, 28 Aug 2024 15:46:54 +0200
Message-ID: <20240828134655.29267-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Veronika Molnarova <vmolnaro@redhat.com>

Test "Setup struct perf_event_attr" consists of multiple test cases that
can affect the max sample rate value for perf events. Some test cases
check this value as it should not be lowered under the set minimum for
the given test. Currently, it is possible for the test cases to affect
each other as the previous tests can lower the sample rate, leading to
a possible failure of some of the future test cases as the value is not
restored at any point.

 10: Setup struct perf_event_attr:
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

 10: Setup struct perf_event_attr:
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
index e890c261ad26..3db9a7d78715 100644
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

