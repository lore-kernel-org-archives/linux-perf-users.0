Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158B13A3E0
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234511; cv=none; b=BYpRLdSSs6Pi+eRtXbsjuX2AOa0k1xCAX6C+wEYrwtgPTr4Dc04s2JkR1KToOMBZoJPkScZstNpLDoHGT51l3Th/ePgfmiIGeUfpaorRPYNSgKvgAly+odWLHzHct6YkvbD9sll2glIg7SfI8cwqfGQOynBsFQJBXGF271xzVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234511; c=relaxed/simple;
	bh=i1x6XPt5OjpkMrrTeLxwK5jleuRFbVrDj25my0feGiE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ytcfrw/eAotztDUyGLaJcddBO6EJPdiMjXQOk8YRXro7oORk0kM4r2HDNHIR+z1CynGcAWp9dqJWQm3SdftaAIkow1kMnFf1YUEvTBFTWmCCldhz1s1GSKPAwpbu5NoSUdwGdn30Zqm1X0E3hQzkb/sHHzKtReemXCCZKEF+XIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qy9wjcfK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy9wjcfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=vuzxO720zHdk9hURHKff5rDDH9KgD3d7azEFVtFxXbo=;
	b=Qy9wjcfK7GIeh+tgkfJwoMbRVmi5JhK0RY17k6GkKF0iA6nxN0k6nttdAmFdNuXTufMa57
	+GXaDsrvy3atIqHux1M7/xTuYM47khtehhRrq8QLeVorXdiJjgtqO69A4ixL9kZ2mwLJ2G
	XFMFh1ZQcsmkTVeQGwWmxH2IrRhXBLA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-lVIVGLkfPyuobr4nAMfSbQ-1; Mon,
 24 Jun 2024 09:08:26 -0400
X-MC-Unique: lVIVGLkfPyuobr4nAMfSbQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D212119560B0;
	Mon, 24 Jun 2024 13:08:24 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69B421956087;
	Mon, 24 Jun 2024 13:08:16 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 00/11] perftool-testsuite 2nd batch
Date: Mon, 24 Jun 2024 15:07:58 +0200
Message-Id: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Hello,

posting a second batch of tests from perftool-testsuite [1], as a part
of the testsuite upstreaming effort.

This batch brings several perf-probe tests ideated by Masami Hiramatsu 
and a perf-report test.

We have also refactored settings files and fixed shellcheck warnings.

Finally, I have noticed that the scripts are run twice, once run by the
driver (e.g. perftool-testsuite_*.sh) and once by perf-test's testsuite
construction feature (that adds all executable shell scripts in all
sub directories automatically). This is undesirable, so I have fixed
it for now by skipping "base_*" dirs in the search. I see that this
approach is not ideal, because the aim of the search seems to be to get
rid of various test drivers, unify the way the tests are detected and
run, while allowing them to be in subdirectories, like the Carsten
Haitzler's coresight tests. However, I still think this is better
solution that just having a pile of scripts without hierarchy that
are grabbed and ordered into one-level queue of tests. Apart from
allowing the tests to share some setup procedure, etc., is helps to
keep the structure more clear.

A better design for future might be to have shell tests ordered in
directories, such as

  # cd tests/shell/
  # find . -name \*.sh
  coresight/asm_pure_loop.sh
  coresight/memcpy_thread_16k_10.sh
  coresight/thread_loop_check_tid_10.sh
  coresight/thread_loop_check_tid_2.sh
  coresight/unroll_loop_thread_10.sh
  base_probe/test_adding_kernel.sh
  base_probe/test_adding_blacklisted.sh
  base_probe/test_basic.sh
  base_probe/test_invalid_options.sh
  base_probe/test_line_semantics.sh
  base_report/setup.sh
  base_report/test_basic.sh
  [...]  

The directories might also contain some "header" file that would
bear the name of the parent testcase for all the tests inside it
(e.g. "perf probe shell tests").

Then, no separate drivers would be needed, perf-test testsuite-
creation mechanism would search for the shell scripts as it does
now, but it would create multilevel structure with subtests,
such as:

  97: perf probe shell tests
  97:1: perf probe basic functionality
  97:2: perf probe tests with arguments
  97:3: perf probe invalid options handling
  98: CoreSight tests
  98:1: CoreSight / ASM Pure loop
  98:2: CoreSight / Thread Loop ...
  [...]

... similar to how C-tests can be organized. In case there is
a setup.sh file in such a subdirectory, it would be run too.
With properly designed names, also tag-like (substring matching)
approach could be used to select desired tests (i.e. to override
the tree structure and pick tests related to some topic, no matter
if they are in base_stat or base_record subdirectory).

This plan also counts with processing the current test scripts and
possibly putting them to best matching place in the structure.

There is already a bunch of shell tests and I thinkg it might be
good to organize them into a structure.

Thoughts and ideas are welcome.

Thanks and regards,

Michael


[1] https://github.com/rfmvh/perftool-testsuite


Michael Petlan (2):
  perf tests shell: Skip base_* dirs in test script search
  perf testsuite: Install perf-report tests

Veronika Molnarova (9):
  perf testsuite: Merge settings files for shell tests
  perf testsuite: Fix shellcheck warnings
  perf testsuite probe: Add test for blacklisted kprobes handling
  perf testsuite probe: Add test for basic perf-probe options
  perf testsuite probe: Add test for invalid options
  perf testsuite probe: Add test for line semantics
  perf testsuite: Add common output checking helper
  perf testsuite report: Add test for perf-report basic functionality
  perf testsuite report: Add test case for perf report

 tools/perf/Makefile.perf                      |   2 +
 tools/perf/tests/shell/base_probe/settings.sh |  48 -----
 .../base_probe/test_adding_blacklisted.sh     |  65 ++++++
 .../shell/base_probe/test_adding_kernel.sh    |   3 -
 .../perf/tests/shell/base_probe/test_basic.sh |  78 ++++++++
 .../shell/base_probe/test_invalid_options.sh  |  77 +++++++
 .../shell/base_probe/test_line_semantics.sh   |  53 +++++
 tools/perf/tests/shell/base_report/setup.sh   |  30 +++
 .../shell/base_report/stderr-whitelist.txt    |   5 +
 .../tests/shell/base_report/test_basic.sh     | 188 ++++++++++++++++++
 .../shell/common/check_errors_whitelisted.pl  |  50 +++++
 tools/perf/tests/shell/common/init.sh         |  31 ++-
 tools/perf/tests/shell/common/settings.sh     |  28 ++-
 .../tests/shell/perftool-testsuite_report.sh  |  23 +++
 tools/perf/tests/tests-scripts.c              |   2 +
 15 files changed, 627 insertions(+), 56 deletions(-)
 delete mode 100644 tools/perf/tests/shell/base_probe/settings.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_line_semantics.sh
 create mode 100755 tools/perf/tests/shell/base_report/setup.sh
 create mode 100644 tools/perf/tests/shell/base_report/stderr-whitelist.txt
 create mode 100755 tools/perf/tests/shell/base_report/test_basic.sh
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.43.0

