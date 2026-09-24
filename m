Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1D3E7BCC
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289035; cv=none; b=e1uUcGmfFYXjA+iwjT2Bo4J9En0hFmFIwMVSu9kZ76vx+8t9+z/oPBevaFltpYOquXSc+8sHuLboT+yMYVbdPId+PwKJYnctMaK5Cp9MraEMqnwKkHDfrTvRFYvl4dxXvyAR7mWv4/dbys3r/RooudA0UPg9eMll3+xhN1ZK8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289035; c=relaxed/simple;
	bh=+mr+VJpLYRxwLIiH7S3upWYUWRhBpPrZ7pjKfDdo3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UyPeDmIm7RchC04kr8sYRQDarG/UQTGaKfS7NwLbd3eAgms0qOT4we4EgXxi6ClQ7a86P8CTcoWJfNIQV0C8WMu/xTgQygeR3cwB41O7bljkkHLgMvWbFrM1ZQqDubFPmcfDCA8cfAqTV3ZBLiKIGe/G4WCwKFEPN7VDoAHNH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI/mQ0tv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI/mQ0tv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790289032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UM4jpX1qU3ajEEzQvJa77n6LXkHHyRrcNRei6G+h7Dc=;
	b=ZI/mQ0tvw/QEcXB1Rl68CyhCqPfALwZhCY6MOeoL3X+U87YSCXOsnmMtdvAXq7QWWxyQq3
	ZVA69owkjbxZdoocj451Hs1Z7dpcwDtCNRa7gE0cbfE3YKtPDnkdMWKqvhkT6PVXByjdVQ
	oifFa5O4+I91uG8APUxv0a8nxa+CHfk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-MKOS5_cXNhKJ5CmR9HoXNg-1; Thu,
 24 Sep 2026 18:30:31 -0400
X-MC-Unique: MKOS5_cXNhKJ5CmR9HoXNg-1
X-Mimecast-MFC-AGG-ID: MKOS5_cXNhKJ5CmR9HoXNg_1790289030
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E796719540E9;
	Thu, 24 Sep 2026 22:30:29 +0000 (UTC)
Received: from Carbon.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C8B8180057E;
	Thu, 24 Sep 2026 22:30:28 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: acme@redhat.com
Subject: [PATCH 0/2] perf test attr: Fix and re-enable the test
Date: Fri, 25 Sep 2026 00:30:25 +0200
Message-ID: <20260924223027.799654-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello all,

I have noticed that a testcase formerly known as "Setup struct perf_event_attr",
later renamed to "Perf attribute expectations test" has been disabled by
accident during the move.

That also probably led to forgetting to update the struct size, which is now
fixed by the second patch.

Michael


Michael Petlan (2):
  perf test attr: Propagate the return value from the test to the
    wrapper
  perf test attr: Fix wrong size expectation for events

 tools/perf/tests/shell/attr.sh                   | 1 +
 tools/perf/tests/shell/attr/base-record          | 2 +-
 tools/perf/tests/shell/attr/base-stat            | 2 +-
 tools/perf/tests/shell/attr/system-wide-dummy    | 2 +-
 tools/perf/tests/shell/attr/test-record-dummy-C0 | 2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.52.0

