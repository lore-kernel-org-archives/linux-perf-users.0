Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D91BB6B3
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792799; cv=none; b=TTqoqoW9ZWA0QDyUEQHZ6jOvfD7WFhsVlpQ/GfDevsX04LtaMyNuAabk/JSbPQGqG27ave2IGXl/k0FfW0d1LMeZj1IcR9rpQASjjiut2QdRVzPL2qv1JYb7K9m67BzPRy43u4Qn8OiIVBcueOBNQBShck9f3uvuYY8xwGfFRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792799; c=relaxed/simple;
	bh=Nsf5q/N8dz9/bVwsbHEG6u/AQ2WW9kA/0zRBzVC5bno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ5hI1laiQgOV8dkCoBtv8PbnxTpYjGcu1+/79GRM/1w1orwHza28PLc9FwvhwYjgF8hb1oBcxiBOy0tgdl66G7uoE6dEWcSp67iBTuNHPXOVMvtWhZUW4WKiHWb28QCtwT3k+8chLUcWOiE7famG27H1usVYYJ2NdRmyH8wdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJlJfXBy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJlJfXBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fjb1vXwbw5CxOEkglBMqT+vuUCg40ue+j5JZVS1sfSo=;
	b=WJlJfXBycyLEBEJ0kWoGP4BLIU80yWx9OA6bVgtuvrl30Fvuz/w1PlC+IXmfdEr0BGxtyi
	r2mHHupuB5A5cDOIM7ZdclepghsTlaYiosCPVwMhuXICKhXF1UhIGkI145F9IceRalVinW
	RPGOYwKbrrOcL3i1C3xZHqDKBdFS7mM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-8J1iQdmcMXicbhqdEVfwGw-1; Mon,
 13 Jan 2025 13:26:35 -0500
X-MC-Unique: 8J1iQdmcMXicbhqdEVfwGw-1
X-Mimecast-MFC-AGG-ID: 8J1iQdmcMXicbhqdEVfwGw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2C2A1956051;
	Mon, 13 Jan 2025 18:26:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F4B19560AD;
	Mon, 13 Jan 2025 18:26:32 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 00/10] Introduce structure for shell tests
Date: Mon, 13 Jan 2025 19:25:55 +0100
Message-ID: <20250113182605.130719-1-vmolnaro@redhat.com>
In-Reply-To: <Z4UwHy-Kj9XDI9cf@x1>
References: <Z4UwHy-Kj9XDI9cf@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Veronika Molnarova <vmolnaro@redhat.com>

Rebased the v2 onto the perf-tools-next, should be applying now.

Thanks for letting me know,
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

