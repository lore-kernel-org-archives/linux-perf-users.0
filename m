Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983233EC
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086221; cv=none; b=YABbVRjorHinvnFl5mVHanNb0g9q6EyW4XTuQLFHcDLefrw01leBxfyT5xLgQyYd87x3WUS1T8TB6shwHvpQgiytF6T+TPTGlAcvRH1N3prKvIA1NawfN4Wt0v6k9HEZqDireOJLWbz+FVkImb0t6HC7BYrpARv5TwNxikZhTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086221; c=relaxed/simple;
	bh=yO1w0O3y8AI4xPZ3YPe0t5k3uM60NJDMIB6+AnwDbDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F71LrjtDYGLswPjIwLFNKz/kZcft5iFMEascuUuF+YcFxvy2hux5ngr1qhzeQqsd90QF3vY39TPaCwG3X7Rzid2n2c1REn8z8+GP6GSVRLoljLsCLUmtnakABFHUTQ0KL+puBCeuP0GOKwF8qjovYHNRE6QwZBmHr7jgivX6PNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8EFF//F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8EFF//F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764086219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nHCIvjhIVOUaexOrTsU0cf8iUnPT+qVtpJZGSzUYFSg=;
	b=h8EFF//FEUFX6Uc/LFvFqw2w9s9YhG0Gea/Y4cxRfX351nf9PjHAhVfHwfhfMP99Z0DQgS
	enVeo6tXMyDr79N/Vdb92PJYyPyrxRTwD3n8vQnFRDzM4WMWQcAa0A50z8mL4GQzL8T+Mx
	8GlBB+2I26pwbdBd8aVNdNyTydrvToM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-LWQHcqKwMNi5Mj7sY0hfWg-1; Tue,
 25 Nov 2025 10:56:53 -0500
X-MC-Unique: LWQHcqKwMNi5Mj7sY0hfWg-1
X-Mimecast-MFC-AGG-ID: LWQHcqKwMNi5Mj7sY0hfWg_1764086212
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B588D195606D;
	Tue, 25 Nov 2025 15:56:52 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D77180047F;
	Tue, 25 Nov 2025 15:56:50 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v5 0/7] Introduce structure for shell tests
Date: Tue, 25 Nov 2025 16:56:41 +0100
Message-ID: <20251125155648.197527-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi maintainers,

This revision of series of patches continues the effort of upstreaming a perftool-testsuite and 
incorporates the review feedback that was previously discussed.
A new patch (7/7) was added to fix the incorrect relative path for locating stderr-whitelist.txt 
in report tests.

Thanks,
Jakub

Link to v4: https://lore.kernel.org/linux-perf-users/20250930160923.13728-1-jbrnak@redhat.com/#t

Changes since v4:
Patch 1: applied review feedback, renamed shell_info -> shell_test_info, minor cleanups
Patch 2: renamed shell_info -> shell_test_info
Patch 4: renamed shell_info -> shell_test_info
Patch 7: added in v5, fix for relative path to 
stderr-whitelist.txt in report tests

Jakub Brnak (7):
  perf tests: Create a structure for shell tests
  perf test: Provide setup for the shell test suite
  perftool-testsuite: Add empty setup for base_probe
  perf test: Introduce storing logs for shell tests
  perf test: Format log directories for shell tests
  perf test: Remove perftool drivers
  perf test: Fix relative path for 'stderr-whitelist.txt'

 tools/perf/tests/builtin-test.c               | 129 +++++++-
 tools/perf/tests/shell/base_probe/setup.sh    |  13 +
 .../tests/shell/base_report/test_basic.sh     |   6 +-
 .../tests/shell/perftool-testsuite_probe.sh   |  24 --
 .../tests/shell/perftool-testsuite_report.sh  |  23 --
 tools/perf/tests/tests-scripts.c              | 288 +++++++++++++++---
 tools/perf/tests/tests-scripts.h              |  15 +
 tools/perf/tests/tests.h                      |   8 +-
 8 files changed, 398 insertions(+), 108 deletions(-)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.51.1

