Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9238FA3;
	Fri,  9 Jan 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961671; cv=none; b=Sv4De2hxh9UevfTJjvQp9TBqLhTakRFGa1Qd0WxkvXTLC+rpMRQECEC8mdwnG4+DwiivPvYgdPNupD+Ntlo2P3JNQ2qwWNn4vfIzSEMo/5m2V6jUo2nir8R140+SxDaMgXcYq0PwqfQ/74rz7+gHdRl4jGot7K9n2zhhhkNciYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961671; c=relaxed/simple;
	bh=EK8Q0+gIuY651/wrVS+mKU9cHGexI4l0i0FDbt48SZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uZ928QimnUH7b4V5S8xdx/BW8rOOQZ/TDO+tSJVK8TGGi+9apbYnxGNlij+Bx+nm4xFDHr22vlm3NECGybQ614gyG0zqmi+/UR03XDwGIn84RiNxoldtGK7FCkfRKaC/cniAEABUT1JubsBsmkwHAYSJ8VHushv9fqqdN/fFPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=gfmC/yKK; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="gfmC/yKK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=dySXZaLTvjGlxYc7Plf+XLsKspteg+0RHK33eTwJb3Q=; b=gfmC/yKKYKFOj9
	cz7Wjj37jJaWpVqhzEQLRsGBRoMze9M4CO4/gwoFEvCmNlETal7mA9dTyGL+dipoLuhiQ765QPzAk
	HOUmLtSFjNu9hXxIm58pFWxRpzHDPTyILV6qHfqM5KklqKTrpmLvY+UUceSRKfwfKTtAkEAMxGnxL
	yYGHjzXBlFf2ZvjUq90byuBEYsDMQqaBxxPTlpIWQqo2ZXpxo6b8KJHokjfL4pw7q3gQB2DNx8Xsh
	XlbweKFaRqJ2RS7s2NQHc8WOkJF5zMp/UjRikxorIMwi1ciU1MCaLc13BKRexx8c1WdapqKT+jOb4
	BzY87upxdDJm4kOWu0Iw==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1veBaa-00ErvS-29; Fri, 09 Jan 2026 12:27:36 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1veBaZ-00000001d1E-3ApC;
	Fri, 09 Jan 2026 12:27:35 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: mingo@redhat.co,
	peterz@infradead.org,
	namhyung@kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] perf/core: make nr_addr_filters attribute static
Date: Fri,  9 Jan 2026 12:27:32 +0000
Message-Id: <20260109122732.388307-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The 'dev_attr_nr_addr_filters' attribute is not exported
outside of the kernel/events/core.c file so make it static
to avoid the following sparse warning:

kernel/events/core.c:12170:1: warning: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?

Fixes: 6e855cd4f4b52 ("perf/core: Let userspace know if the PMU supports address filters")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dad0d3d2e85f..b79f9be8f074 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12167,7 +12167,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 
 	return sysfs_emit(page, "%d\n", pmu->nr_addr_filters);
 }
-DEVICE_ATTR_RO(nr_addr_filters);
+static DEVICE_ATTR_RO(nr_addr_filters);
 
 static struct idr pmu_idr;
 
-- 
2.37.2.352.g3c44437643

