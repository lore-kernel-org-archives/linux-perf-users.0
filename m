Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41D2C327C
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104416; cv=none; b=Vot3Q1reOKDaaGrPFfvxA/o4XyMf5Rl/aBfZT6Yj3QBsMtcpC3lhSGmM+0oQNBahxdmpppsq/DuFdxa61dj55ncOrMPmGEu+DITi1mBNzxJxymmmX3LBmQIbKgIXr/1y8JbEqAdeatB+Z6UT6v40xZWl2fFYQ+vmieCnzJX7WPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104416; c=relaxed/simple;
	bh=4IijtH2QmNsDrjdgrlfWy8rHc4PbCYf4fjH8MzbKjJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4uo08cXBoCxgE00Rv2IVPIDTdQz0z5fe2cxOqLGoenzKxoDlPUTCF45dhS9Snzi/xZdcH/IBNo08ehVUxK/LzfeMUpYqivLkFtHCi2F7NwbTNZSBOlGpfFzMR35hg9DZmzuM4hPJ3IcfWyt58ERRo6AXm+WcY3Z2z9ID09y3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dILL8VKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dILL8VKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4c7HQtR5k6EhHDtfsyZmqz9t0/ZV8ZK7UNKA20gH/pc=;
	b=dILL8VKL1uWNmQLuD7ewoql4+6FlgLLcJpCLbn9q2M1ebhtY33+sYFKWYwvjYuDYXbWdlm
	PHmXpe24CwBfOV0jm4weqOVP5OVMdtvkFE2hMwDnoII3XBexngBMTRGOYMgxt7lHZ3ssD6
	2Xq6C9BwCfqwHv5qzXXaTRVimoq/vBE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-7rtKZtefPUirCGV-fTp6xQ-1; Mon,
 21 Jul 2025 09:26:47 -0400
X-MC-Unique: 7rtKZtefPUirCGV-fTp6xQ-1
X-Mimecast-MFC-AGG-ID: 7rtKZtefPUirCGV-fTp6xQ_1753104406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3DA419560A7;
	Mon, 21 Jul 2025 13:26:46 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE74419560A3;
	Mon, 21 Jul 2025 13:26:44 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: vmolnaro@redhat.com
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v3 0/7] Introduce structure for shell tests
Date: Mon, 21 Jul 2025 15:26:35 +0200
Message-ID: <20250721132642.40906-1-jbrnak@redhat.com>
In-Reply-To: <20250113182605.130719-1-vmolnaro@redhat.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Arnaldo,

This series of Veronika's patches as a part of upstreaming effort of perftool-testsuite has been rebased on the latest perf-tools-next branch and should now apply cleanly. 
Patches 01/10, 02/10, and 05/10 from the v2 have been dropped as they were already accepted upstream. 

Thanks,
Jakub Brnak

Veronika Molnarova (7):
  perf test perftool_testsuite: Use absolute paths
  perf tests: Create a structure for shell tests
  perf test: Provide setup for the shell test suite
  perftool-testsuite: Add empty setup for base_probe
  perf test: Introduce storing logs for shell tests
  perf test: Format log directories for shell tests
  perf test: Remove perftool drivers

 tools/perf/tests/builtin-test.c               | 137 +++++++++-
 tools/perf/tests/shell/base_probe/setup.sh    |  13 +
 .../base_probe/test_adding_blacklisted.sh     |  13 +-
 .../shell/base_probe/test_adding_kernel.sh    |  53 ++--
 .../perf/tests/shell/base_probe/test_basic.sh |  19 +-
 .../shell/base_probe/test_invalid_options.sh  |  11 +-
 .../shell/base_probe/test_line_semantics.sh   |   7 +-
 tools/perf/tests/shell/base_report/setup.sh   |   6 +-
 .../tests/shell/base_report/test_basic.sh     |  47 ++--
 tools/perf/tests/shell/common/init.sh         |   4 +-
 .../tests/shell/perftool-testsuite_probe.sh   |  24 --
 .../tests/shell/perftool-testsuite_report.sh  |  23 --
 tools/perf/tests/tests-scripts.c              | 258 +++++++++++++++---
 tools/perf/tests/tests-scripts.h              |  15 +
 tools/perf/tests/tests.h                      |   8 +-
 15 files changed, 465 insertions(+), 173 deletions(-)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

-- 
2.50.1

