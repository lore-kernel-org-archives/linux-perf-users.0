Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39A198845
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732230; cv=none; b=khEZxMP4mZD/1LnGSzJObbG6aOvnGIhB1IQykaRbyBOBDvy/nmfxS3lfcP5u0K94Ns/Mp5zARrhIrqo6eOwrybM8p1pkiy0PFtYpDS1yFLEUwLlWZeyobP+DA57lwLBSSoPHcfI29MksTrNZnmxjPbj7dP4cx3vZ0q6mkaLuDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732230; c=relaxed/simple;
	bh=uoQVYGn5mgfMn5NH2AMPBb3xvr6EIs+oY3xH1flZfVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvgGI/41/+F5ls8E8uwVfbsBs9YwQtImDWYvouBHtREj0QTeACzU5tWd9mx6pMN21WXMknuotxIbuRNe/IFJ9EZBCVoSExt/XJKL8T7d7z6VA/Wa2uOrd1VkA/M0n5wu+KjKewloi1V7ozsaxOrEuWA4W5Swz3qIMtY+0Gk8Pks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQhAz2sd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQhAz2sd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PRQVIh7NQYvmmWjkuNVV0kAfGfz1GhRREuACgSPFGYA=;
	b=TQhAz2sdlBUL2UWqzjjvHditZL4KVlKYpMDg3Wwm5HJxNCdPM2b3fnJFq4WeqzgW3plmzw
	+f7/lqq4jZqmQLpHXxKd87jqHUpFkGf/45fZSuMoQAuQrTJlUtZwvTTvvS3sWuT9u3aUOV
	eikv7RTLe9D6VayzdI8iqosvVZ2so3M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-DVACJA0AOEe9n_bEdCd7ag-1; Fri,
 20 Dec 2024 17:03:44 -0500
X-MC-Unique: DVACJA0AOEe9n_bEdCd7ag-1
X-Mimecast-MFC-AGG-ID: DVACJA0AOEe9n_bEdCd7ag
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9877219560A7;
	Fri, 20 Dec 2024 22:03:43 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 603A319560A2;
	Fri, 20 Dec 2024 22:03:41 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 00/10] Introduce structure for shell tests
Date: Fri, 20 Dec 2024 23:03:24 +0100
Message-ID: <20241220220334.69198-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

Hello,

Sending the third patchset from perftool-testsuite upstreaming effort,
which also contains new possibilities for shell tests, such as a two-level
structured test hierarchy, a setup file for the test suite and ability to
store logs.

The patches do not add any new test cases but instead provide the needed
environment that was temporarily replaced by the perftool test drivers.

We wanted to provide the possibility to have a shell test consisting 
of multiple subtests, as is already done for the C tests. The logical 
structuring of the test cases was a part of the perftool test suite,
and we saw this as an opportunity to introduce a structured approach for 
the perf shell tests.

A directory in the shell directory will be represented as a test suite 
if it contains at least one executable shell test. In case of two and 
more tests, the subtests are are visibly differentiated from the test 
suite by having a subtest index. All deeper levels of subdirectories 
are still searched for tests but do not create additional levels of 
hierarchy.

Some test suites require setup to be done before they are run, such 
recording samples or setting up test probes. This can be done by 
adding a "setup.sh" executable file in the test suite directory, which 
will be run before all of the tests. If the setup fails, all of 
the tests are skipped, as it is assumed that the setup is required 
for their execution. The setup file also gives us the possibility to 
name the test suite. If there is no setup file, the name is derived 
from the name of the directory.

Lastly, we wanted to provide a way to store the test logs after execution 
for debugging purposes, if necessary. The test logs for perftool tests 
are stored in a '/tmp/perf_test_*' temporary directory. By default,
these logs are cleared after the test finishes. However, if the env
variable PERFTEST_KEEP_LOGS is set to "y", the test logs are retained
for debugging.

For now, all of the perftool tests are marked as exclusive, preventing 
from running parallel. This may change in the future if we ensure that 
they will not interfere with other tests being run simultaneously.

Thoughts and ideas are welcome.

Thanks and regards,

Veronika

Michael Petlan (1):
  perf testsuite: Fix perf-report tests installation

Veronika Molnarova (9):
  perf test perftool_testsuite: Add missing description
  perf test perftool_testsuite: Return correct value for skipping
  perf test perftool_testsuite: Use absolute paths
  perf tests: Create a structure for shell tests
  perf test: Provide setup for the shell test suite
  perftool-testsuite: Add empty setup for base_probe
  perf test: Introduce storing logs for shell tests
  perf test: Format log directories for shell tests
  perf test: Remove perftool drivers

 tools/perf/Makefile.perf                      |   3 +-
 tools/perf/tests/builtin-test.c               | 151 +++++++++-
 tools/perf/tests/shell/base_probe/setup.sh    |  13 +
 .../base_probe/test_adding_blacklisted.sh     |  17 +-
 .../shell/base_probe/test_adding_kernel.sh    |  57 ++--
 .../perf/tests/shell/base_probe/test_basic.sh |  23 +-
 .../shell/base_probe/test_invalid_options.sh  |  15 +-
 .../shell/base_probe/test_line_semantics.sh   |  11 +-
 tools/perf/tests/shell/base_report/setup.sh   |   8 +-
 .../tests/shell/base_report/test_basic.sh     |  49 ++--
 tools/perf/tests/shell/common/init.sh         |   6 +-
 .../tests/shell/perftool-testsuite_probe.sh   |  23 --
 .../tests/shell/perftool-testsuite_report.sh  |  23 --
 tools/perf/tests/tests-scripts.c              | 258 +++++++++++++++---
 tools/perf/tests/tests-scripts.h              |  15 +
 tools/perf/tests/tests.h                      |   8 +-
 16 files changed, 489 insertions(+), 191 deletions(-)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.43.0

