Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21FA40B110
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289040; cv=none; b=fw0+wE2i4ts8n0f68uNHJk2vXH/4BLYoGsaWn8ZHLKtwmKCTc6Rn7U1jDl0xviQQz8Fe9Az6egNASttJN7hLye8Pqii7fgRSYD3+5huwXlvex2GFeU7E6SIynxO4+rq8XTIb3EQIi6ENfAGaS5ZUufuyj7xvjot2eDD3vojEdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289040; c=relaxed/simple;
	bh=9omshHpKkNoUwGjOTOpoy5QCsEF0VbdWRTdNS/MkbZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wi8MSG+ahpfy0wWGvRFthXnuwWDc2jjIbzKhqapJemsaHY35y5mff+s+yK9mFJKpbySA2+gjFY+/ZaJrYJ/xKQzp9QL00wjMS+7rTGaaaBSHzhox+R9xH/EIvks6n1a6ABiy4MfGX8iHWDv9YVsiLz4YCU3d7d04UKVQMRuT5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YF9w0vwv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF9w0vwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790289037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMTh9/PlsM4qvp9H7i00Q7Rmik4yWXHZqaCN5rbOE7Q=;
	b=YF9w0vwvsGXQibQHNoN1Z8Mv81XEyCkhRAB9OSqyUEO8iWB3vrEwYe741Yt5rzDCEzio8L
	oDO86y19Gkc47TTUwdvCtk8gmlHb2Mo+ABmQ11tWKVjgwYmHqdcelCE6Rn+wOo6epHPE4i
	cRDhepfGVfuR0vSSRgdKU1f6oIKiLdU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-IKfuAVzsPbiROTNkZaAEZQ-1; Thu,
 24 Sep 2026 18:30:34 -0400
X-MC-Unique: IKfuAVzsPbiROTNkZaAEZQ-1
X-Mimecast-MFC-AGG-ID: IKfuAVzsPbiROTNkZaAEZQ_1790289033
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91E1A1945CAC;
	Thu, 24 Sep 2026 22:30:33 +0000 (UTC)
Received: from Carbon.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 251A11800370;
	Thu, 24 Sep 2026 22:30:31 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: acme@redhat.com
Subject: [PATCH 2/2] perf test attr: Fix wrong size expectation for events
Date: Fri, 25 Sep 2026 00:30:27 +0200
Message-ID: <20260924223027.799654-3-mpetlan@redhat.com>
In-Reply-To: <20260924223027.799654-1-mpetlan@redhat.com>
References: <20260924223027.799654-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Although config4 has been added into struct perf_event_attr, the size
expectation for the struct hasn't been adjusted. This hasn't been
noticed, since the testcase's return value has been ignored after
rewriting the testcase to python until previous commit.

Fix that.

Fixes: 80cdf208117a36de82a30d210b3b8df0f193e75b ("tools headers UAPI: Sync linux/perf_event.h with the kernel sources")
Fixes: cbbfba4847b8a5299d36e002bf864b21bb83295d ("perf: Add perf_event_attr::config4")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/attr/base-record          | 2 +-
 tools/perf/tests/shell/attr/base-stat            | 2 +-
 tools/perf/tests/shell/attr/system-wide-dummy    | 2 +-
 tools/perf/tests/shell/attr/test-record-dummy-C0 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/attr/base-record b/tools/perf/tests/shell/attr/base-record
index b44e4e6e4443..dd76fbdb628f 100644
--- a/tools/perf/tests/shell/attr/base-record
+++ b/tools/perf/tests/shell/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=136
+size=144
 config=0|1
 sample_period=*
 sample_type=263
diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
index fccd8ec4d1b0..d769e69bb4f5 100644
--- a/tools/perf/tests/shell/attr/base-stat
+++ b/tools/perf/tests/shell/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=136
+size=144
 config=0
 sample_period=0
 sample_type=65536
diff --git a/tools/perf/tests/shell/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
index a1e1d6a263bf..9806de3d9c9e 100644
--- a/tools/perf/tests/shell/attr/system-wide-dummy
+++ b/tools/perf/tests/shell/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=1
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
diff --git a/tools/perf/tests/shell/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
index 91499405fff4..23e00e7f8ace 100644
--- a/tools/perf/tests/shell/attr/test-record-dummy-C0
+++ b/tools/perf/tests/shell/attr/test-record-dummy-C0
@@ -10,7 +10,7 @@ cpu=0
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=4000
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
-- 
2.52.0

