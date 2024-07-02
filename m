Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD794CDF9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918586; cv=none; b=Vv/TXelSLuqrW1+pzUmKwtBSiEnQCK8rofC1MughfmLx0Rvnn4MBogW1Wiqqm0YWvI2oyxdQuJ/4J6rsMH823zONBJ0RqqF6p7M24HzNW9LuH6PuxZnU8Z0jVvTsER7BTxH/BTaqrjqGs66tH5MhlpNGQmkajTdTJjtwWetQ8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918586; c=relaxed/simple;
	bh=UIBS9cstmBRcf9WdXlKpcA+y3BPKP6+45wJgPPNYER8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvBozRmQgGZMZvtCD4xVx4CEs/lJ4Te2scdFTmYFlzINfXPht6f5rnYxo0ZUgM2yRRNrJpiwJ3hz85+NhsO3KS+PkyfUsyUkTRgoKVownR81asLibJZEj9WoYRXpGOGkHnY7hSRaytjq5ReO1L1Xh37jbkBKO5qdjkBsKzkXKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INaOIZJs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INaOIZJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDlIdqDFblR4EFjv9XjR6nIx7XUGrArFg4UvN8mf5m8=;
	b=INaOIZJsXe1nwiMwqcU5lHRzIQj1yGkc4vRaP0YNXw5g1JdGMud2jm0uIjsjodAriVzYZQ
	G8Tze9euvheBR2ekUe4v3sld9SBxBEe+lcBx2UmMXyCANrMd5ZvykD9jh55/6PfvOYNRjC
	nodaI3TDYpjyLBVCSkC2g3n2FkFzPf0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-ouqQO9CEO_6mkXjFvNifcQ-1; Tue,
 02 Jul 2024 07:09:39 -0400
X-MC-Unique: ouqQO9CEO_6mkXjFvNifcQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEF9E1955E74;
	Tue,  2 Jul 2024 11:09:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41FCD1955E80;
	Tue,  2 Jul 2024 11:09:34 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 00/11] perftool-testsuite 2nd batch
Date: Tue,  2 Jul 2024 13:08:38 +0200
Message-ID: <20240702110849.31904-1-vmolnaro@redhat.com>
In-Reply-To: <Zn3n0JwfdfFdjbzj@google.com>
References: <Zn3n0JwfdfFdjbzj@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

Hello,

rebased the patches for the current perf-tools-next branch in v2 as it
was not applying.

Thanks for the notice,
Veronika

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
 .../base_probe/test_adding_blacklisted.sh     |  67 ++++++
 .../shell/base_probe/test_adding_kernel.sh    |   3 -
 .../perf/tests/shell/base_probe/test_basic.sh |  80 ++++++++
 .../shell/base_probe/test_invalid_options.sh  |  79 ++++++++
 .../shell/base_probe/test_line_semantics.sh   |  55 +++++
 tools/perf/tests/shell/base_report/setup.sh   |  32 +++
 .../shell/base_report/stderr-whitelist.txt    |   5 +
 .../tests/shell/base_report/test_basic.sh     | 190 ++++++++++++++++++
 .../shell/common/check_errors_whitelisted.pl  |  51 +++++
 tools/perf/tests/shell/common/init.sh         |  31 ++-
 tools/perf/tests/shell/common/settings.sh     |  28 ++-
 .../tests/shell/perftool-testsuite_report.sh  |  23 +++
 tools/perf/tests/tests-scripts.c              |   2 +
 15 files changed, 640 insertions(+), 56 deletions(-)
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

