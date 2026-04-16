Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652D1E520A
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338071; cv=none; b=V+hG7QaX04v4uIYsBwiwn9HoWIj1+VSFOqQ40X8enB7wuglnDILbTNYMMmjpHTvCT+kmOT4wj/vkGEcHyNXKCtySXsX0eF1Hc7YKO5Ts1zmMEglv2XEm16H3KnqTErX+unp3BhaDOga2yAl7OB+7X3kInlBgJAFUbHhl89v1mlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338071; c=relaxed/simple;
	bh=AF7Zn9W7vZeNLYaBfskZjcCr1YmObJhV0cItChgdnpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDWmcQHXa22Fo6aJQylwtO9pgbG/REGmbEsnKBKnztadxyBk8FSbVRQEKsvu5myRAHHr8Z03nzCi3jtDqVNoa0Nks6G2CjbbwYAJ55EMwBiku81vzXb/6nvmZftAYRcnINIKMDvcXOXiyhCfAaJOjrxy//CRDCyg/NWA4lvYYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIofvJxX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIofvJxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ldw7ky6R9i/RnJ3433bhormfKlugUydOvIaE0r4lX6s=;
	b=NIofvJxXo/ggqs4U4XtbJLPnZx6fEZinMdSTKYh5gqyJ9JMgKcDac0F1vg69L/VtlxjHvA
	SAte9PIDGey4f51GVO1j5zmVht4Qt3fWNpJ5JBJk//Vrv7m4ksaM7DVR4/qPTWdfZE+eei
	YJt6K8ekFVGASNYpacHpfbz5wymOG40=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-rvMjNDKGN9SAVPh3qPdqfA-1; Thu,
 16 Apr 2026 07:14:25 -0400
X-MC-Unique: rvMjNDKGN9SAVPh3qPdqfA-1
X-Mimecast-MFC-AGG-ID: rvMjNDKGN9SAVPh3qPdqfA_1776338064
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C57CD195609F;
	Thu, 16 Apr 2026 11:14:24 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFFE9180047F;
	Thu, 16 Apr 2026 11:14:22 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 0/7] Introduce structure for shell tests
Date: Thu, 16 Apr 2026 13:14:12 +0200
Message-ID: <20260416111419.385010-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

Sending the next revision addressing review feedback from Ian and
Namhyung on v6.

Thanks,
Jakub

Link to v6: https://lore.kernel.org/linux-perf-users/20260309155728.98026-1-jbrnak@redhat.com/

Changes since v6:

Patch 1: fixed fd leaks and missing error checks, added documentation
for the shell test infrastructure (requested by Namhyung)

Patch 2: fixed race condition by marking setup suites exclusive, added
NULL fallback for setup.sh description, fixed indentation

Patch 4: replaced VLA with calloc, fixed delete_file to not abort
nftw on failure, added comment about intentional log retention on error

Patch 5: fixed premature loop termination on dots in test name

Jakub Brnak (7):
  perf tests: Create a structure for shell tests
  perf test: Provide setup for the shell test suite
  perf test: Add empty setup for base_probe
  perf test: Introduce storing logs for shell tests
  perf test: Format log directories for shell tests
  perf test: Remove perftool drivers
  perf test: Fix relative path for 'stderr-whitelist.txt'

 tools/perf/tests/builtin-test.c               | 175 ++++++++-
 tools/perf/tests/shell/base_probe/setup.sh    |  13 +
 .../tests/shell/base_report/test_basic.sh     |   6 +-
 .../tests/shell/perftool-testsuite_probe.sh   |  24 --
 .../tests/shell/perftool-testsuite_report.sh  |  23 --
 tools/perf/tests/tests-scripts.c              | 359 +++++++++++++++---
 tools/perf/tests/tests-scripts.h              |  17 +
 tools/perf/tests/tests.h                      |   8 +-
 8 files changed, 513 insertions(+), 112 deletions(-)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.52.0

