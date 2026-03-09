Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E53DA5A7
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071858; cv=none; b=r3pGCpTDBfGBZfmwnw+7ACbhdaisk1Px5T91EWcML3BgOBSEpgk2g5/o6F1VgxNaTbgBAsA/Zx1YMNrbZpFkbziaH37Tzzdohq4TEIFK+Lorv/24eNh2w6apersumGKUrCgQV8EF/RtaNaAKf9Fpd4o8NIG1i8wa6zsZXR3xQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071858; c=relaxed/simple;
	bh=fLkhu9nBmx7K8AJ6ynrrAwHCAF1k7/MnjzQncRyujPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/YQZDgzvCkJheVZ7sk26N+BXjEWVIb56KM2eSpZ7CP5WZ0Bfki2/4nXG0BJlP5LFnKeTUB6ii+vYsCyDtD2IxV0I/WgN0DBBzVDxIqlC+mJo56uQS2JvEw0gbr7TXdx5jddkzNJpxUH2v8Un2ckLXOoI1GhR+OwrCgrB8+Pe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnHK3HeK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnHK3HeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773071855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z4gbmjPzIbKPwsawUq9GrRYxc3jP1mYSLT83XRpT0vg=;
	b=SnHK3HeKFQcdWmzuZf7dOm10sOCrj8LFMBR+eL7ucZKLZw8Bi9QhB7+sqFrHjGK9w53Nf0
	Lo4EeUK/DOP/cFtK99BKAdRoW1TGgBvb3ky/bT7b2vbKKzNnmcs8BqRjkHXiN0QxSkzGLb
	45iJgTMY6ZWxTisJ2uS9iekZLKtZ+CE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-iEnfNAUfNCq0K77lfh6znA-1; Mon,
 09 Mar 2026 11:57:33 -0400
X-MC-Unique: iEnfNAUfNCq0K77lfh6znA-1
X-Mimecast-MFC-AGG-ID: iEnfNAUfNCq0K77lfh6znA_1773071852
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8080C19560A2;
	Mon,  9 Mar 2026 15:57:32 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD8A030001BB;
	Mon,  9 Mar 2026 15:57:30 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v6 0/7] Introduce structure for shell tests
Date: Mon,  9 Mar 2026 16:57:21 +0100
Message-ID: <20260309155728.98026-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

Sending the next revision of patches for perftool-testsuite structure
setup which incorporates the changes in Patch 4 suggested by Ian.

Thanks,
Jakub

Link to v5: https://lore.kernel.org/linux-perf-users/20251125155648.197527-1-jbrnak@redhat.com/

Changes since v5:
Patch 4: fixed log deletion logic to ensure logs are only removed after
all tests (including those executed in parallel) have fully completed

Jakub Brnak (7):
  perf tests: Create a structure for shell tests
  perf test: Provide setup for the shell test suite
  perftool-testsuite: Add empty setup for base_probe
  perf test: Introduce storing logs for shell tests
  perf test: Format log directories for shell tests
  perf test: Remove perftool drivers
  perf test: Fix relative path for 'stderr-whitelist.txt'

 tools/perf/tests/builtin-test.c               | 141 ++++++++-
 tools/perf/tests/shell/base_probe/setup.sh    |  13 +
 .../tests/shell/base_report/test_basic.sh     |   6 +-
 .../tests/shell/perftool-testsuite_probe.sh   |  24 --
 .../tests/shell/perftool-testsuite_report.sh  |  23 --
 tools/perf/tests/tests-scripts.c              | 289 +++++++++++++++---
 tools/perf/tests/tests-scripts.h              |  17 ++
 tools/perf/tests/tests.h                      |   8 +-
 8 files changed, 413 insertions(+), 108 deletions(-)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.52.0

