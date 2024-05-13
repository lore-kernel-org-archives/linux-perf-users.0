Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841081BDD0;
	Mon, 13 May 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628283; cv=none; b=sDt67VsYSYJ62i/8XViVaikuxMDkiDOhsNpY7vizAwbKnbR0ScW8GSj8XrJumsqF0vaV4ufuPR1lKP8Oi3EA7FjtiglEdOv4rvWKo9TxWu4bIyWEEkbqV6Cvt3qxUg/ikPuv5IO8ozg54LB90qJwgb2nZRz0V2M+5FQBk1obxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628283; c=relaxed/simple;
	bh=dPMmvsODoZpZ/NxdG44eRfZIG7IUKN1u9ef09sZyJK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GioWSBp2ce5z6lRkciyg26ANvMUY8D8dZCnkCKM0WhZ+H69+njsHADwoai0JzY7U+rv8v6QciDqntRQ6E3Z7yJOz0syt60/McpRf/nxkQJ9K6Tq7mOS1eiCaovZx2PiyvNs2fyGEa54KX3FFGH/3EVjMhzxhfnOgk6I7ODqPq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JoD8gseo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JoD8gseo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=G5NpfL0YPCY6XSoxrEaLMX3Ip4IV4/bg/nVptU+9HTc=; b=JoD8gseoZrX4t4KmkMwJ605UGy
	/Vc+qDsB9mjaLtpb3QDmGMDAL3GjascOMT6kMYvm2MwQJU+EFPoCIYn2U2btKXNLgZHQN1jhFYJXC
	ZyMIh4/7BtNCGYFwLhOy9/MTlqzluaSbgQGwyQuD1MxUGtS5uy3/DzeWaUDPl5Wyt0VHaYIEv/+FC
	pz6rTp0xeVs12YtuosrIylB/WwWNvk2MgYPeNr2EndtNipl0KV/YnTgZ8P8l2+dN4GZEL5Eqndeiv
	6p+T8MioSy80h/5jXY25EzrIbXFdRwvooJrEQ6zu1RQUyXv5xVovw2Wsi33XKTgB4raD4Y3iRoc+M
	qqWyWtSA==;
Received: from [50.53.4.147] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6bHs-0000000DzZw-0xfo;
	Mon, 13 May 2024 19:24:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf Documentation: clarify sysfs event names characters
Date: Mon, 13 May 2024 12:24:39 -0700
Message-ID: <20240513192439.18473-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify that perf event names in sysfs must not contain mixed lower and
upper case characters and that they may contain numbers, ".", "_",
or "-" as well.

Fixes: 785623ee855e ("perf Document: Sysfs event names must be lower or upper case")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-bus-event_source-devices-events |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff -- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,11 +37,13 @@ Description:	Per-pmu performance monitor
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
-		As performance monitoring event names are case
-		insensitive in the perf tool, the perf tool only looks
-		for lower or upper case event names in sysfs to avoid
+		As performance monitoring event names are case insensitive
+		in the perf tool, the perf tool only looks for all lower
+		case or all upper case event names in sysfs to avoid
 		scanning the directory. It is therefore required the
-		name of the event here is either lower or upper case.
+		name of the event here is either completely lower or upper
+		case, with no mixed-case characters. Numbers, '.', '_', and
+		'-' are also allowed.
 
 		File contents:
 
