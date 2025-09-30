Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16186EEBB
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248575; cv=none; b=GUh9m3JeEPnfNxnDDkQ00E8giJuHKti7oUYnB/y18rLOyzb4Bq7yQFF9QSjCjFr7tTTfJuyW0eQPcULjOX/ro1fP4a3DLi6V7mlBE9/EtOssKGT8Ex+IOJ/m0nSEFKy8KC+hBwBNIbtu/G/cxnv9YOkBIuNPIvIrdJdYWox7v4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248575; c=relaxed/simple;
	bh=M4oom1ijzWl2FeAA5l2kBcWXO885CaZvLMkPecTzJJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tENYHRaynrPZsV+nJmxGhwStTmaGt2J4H6RQ0FDCYxAz8VdiuIxZ75/TsqPx2AUo7tFDe9VeAKfHQvcGEwGqInvUOi5I8IHgH81K4/ddVRVaZ7ReNEfrgEubz0wClpLRKA3Ql7ULv2GD+4gJWmyxsQnNuY3G5uoHrXOhaSCqQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSwheQ04; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSwheQ04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mNDt41XrAAtt+ECGLF+OM1iMzVaAt0atcN2dL0R9cok=;
	b=fSwheQ04LX1RfbgwrJKxRIh9UtBjUCYzqXFJIdcW1eHWSfJjRcxQ4DOCBmC6uH5+LHrLlX
	krNocEs+dVstAAFrd436paRlQSK9IFi/WVDifimOb2ltEPN3Xp6wv+li2rLQYhNgGxjwa8
	0kXk4UfPkPcL/nvnELVt0vPg/XWuXxY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-StUmlutpN0e0XM4B4I-Dzw-1; Tue,
 30 Sep 2025 12:09:29 -0400
X-MC-Unique: StUmlutpN0e0XM4B4I-Dzw-1
X-Mimecast-MFC-AGG-ID: StUmlutpN0e0XM4B4I-Dzw_1759248568
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ADEC18004D4;
	Tue, 30 Sep 2025 16:09:28 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D72C730002C5;
	Tue, 30 Sep 2025 16:09:25 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v4 0/7] Introduce structure for shell tests
Date: Tue, 30 Sep 2025 18:09:16 +0200
Message-ID: <20250930160923.13728-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Nahmyung,

The series of Veronika's patches as a part of upstreaming effort of perftool-testsuite has been rebased on the latest perf-tools-next branch and should now apply cleanly. 
Patches 01/10, 02/10, and 05/10 have been dropped as they were already accepted upstream. This revision should address the problems that were previously discussed.

Thanks,
Jakub

Link to v3: https://lore.kernel.org/linux-perf-users/20250721132642.40906-1-jbrnak@redhat.com/#r

Changes since v3:
Patch 1: fix long lines, fix coding style issues, fix skipping testcases
because of missing $DIR_PATH in path to scripts used by the testscases
Patch 2: fix coding style issues, fix typo in function name
Patch 5: fix coding style issues
Patch 6: remove additional buffer and sanitize the name of log directory in
place, fix coding style issues

Veronika Molnarova (7):
  perf test perftool_testsuite: Use absolute paths
  perf tests: Create a structure for shell tests
  perf test: Provide setup for the shell test suite
  perftool-testsuite: Add empty setup for base_probe
  perf test: Introduce storing logs for shell tests
  perf test: Format log directories for shell tests
  perf test: Remove perftool drivers

 tools/perf/tests/builtin-test.c               | 129 ++++++++-
 tools/perf/tests/shell/base_probe/setup.sh    |  13 +
 .../base_probe/test_adding_blacklisted.sh     |  20 +-
 .../shell/base_probe/test_adding_kernel.sh    |  97 +++++--
 .../perf/tests/shell/base_probe/test_basic.sh |  31 +-
 .../shell/base_probe/test_invalid_options.sh  |  14 +-
 .../shell/base_probe/test_line_semantics.sh   |   7 +-
 tools/perf/tests/shell/base_report/setup.sh   |  10 +-
 .../tests/shell/base_report/test_basic.sh     | 103 +++++--
 tools/perf/tests/shell/common/init.sh         |   4 +-
 .../tests/shell/perftool-testsuite_probe.sh   |  24 --
 .../tests/shell/perftool-testsuite_report.sh  |  23 --
 tools/perf/tests/tests-scripts.c              | 267 +++++++++++++++---
 tools/perf/tests/tests-scripts.h              |  15 +
 tools/perf/tests/tests.h                      |   8 +-
 15 files changed, 585 insertions(+), 180 deletions(-)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.50.1

