Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49633689D;
	Sat, 12 Sep 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182704; cv=none; b=m2wZq44geLdyDlUpmI8urf8foYhN83SiiMVqXLlT+0MllBHM0UBoBstG+MPhLwhyukuGLoccRpuKcCdF6+DxqGOI/BeufZ8Y5/fwUoT77qvH/wM0JqRCGRVkbqBpC7JbiEZTbfSOzLw9MSSEdzfCXjzKNO9b0L08eNN1WkzWEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182704; c=relaxed/simple;
	bh=KC6iZWZGdUGo3O/9hpZ/QWa8c9IIU+HS3Z/oAP0HHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nr/xOM1L2J0ot7qJAsH2IGVsNP3X0K+dgrDtnvpYgK/9tB4vBhC833jy0/EjOxqaKgcpFu3/0Dcq/vowHG16mEqBsSGVO6dM7r24AQjmkfb4CGP4xrQ2C0q2EPhAej/oszDsE1R9C3jl0wATagB0I5dlwxRnRj03uE61EE2PAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jnh5VZu7; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jnh5VZu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P6
	NIREsGY9qC38ZlJ4QZGDepu2Hx1H3SgrmUj+D5rco=; b=Jnh5VZu7wo8CZ7WBVD
	wdEJmUuaKnVpzm/gRpu74pE5JtMrOMbm9b8Av4wdZBGsrv1RrWrYMVg/CMpquLvj
	rk1XVMCNqs42nSeccDh3H42iZGlRJlO2qlTevpHwWGiDOd+oHi96dt9HJBMiK5or
	Cs50mipOFiGsFF4h4W7V59VDw=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3X5XRwqRqA0HGAA--.31859S2;
	Sat, 12 Sep 2026 11:11:14 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH] perf synthetic-events: Check schedstat domain allocation failure
Date: Sat, 12 Sep 2026 12:11:12 +0900
Message-ID: <20260912031112.1814574-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X5XRwqRqA0HGAA--.31859S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury5Ww1rKw1Duw1ktry7Jrb_yoW8Ar15pr
	4Duws0kr1qgasFqa13JayxZ34rZa92yF98Kry3Awn2vrn7Xr1YgFW8ta45tFy5ArW0vFy5
	JFZFgw1qvFykJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWxR3UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRKoCGqkwtKvmwAA3Z

__synthesize_schedstat_domain() uses event after zalloc() without
checking for allocation failure, unlike __synthesize_schedstat_cpu().

If zalloc() fails and returns NULL, dereferencing ds->header.type
immediately crashes with a segmentation fault:

  Program received signal SIGSEGV, Segmentation fault.
  0x00005555558aed8a in __synthesize_schedstat_domain ()
  #0  0x00005555558aed8a in __synthesize_schedstat_domain ()
  #1  0x00005555558b889a in perf_event__synthesize_schedstat ()
  #2  0x000055555563c397 in cmd_sched ()
  #3  0x00005555556583a1 in handle_internal_command ()
  #4  0x00005555555bf739 in main ()

perf_event__synthesize_schedstat() already treats a NULL event as an
error and cleans up, so return NULL when the allocation fails.

After this fix, an allocation failure returns NULL safely, allowing
the caller to exit gracefully without crashing:

  [ perf sched stats: Failed !! ]

Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/perf/util/synthetic-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0c150193cca8..24559691b88e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2776,6 +2776,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 	size = sizeof(*ds);
 	size = PERF_ALIGN(size, sizeof(u64));
 	event = zalloc(size);
+	if (!event)
+		return NULL;
 
 	ds = &event->schedstat_domain;
 	ds->header.type = PERF_RECORD_SCHEDSTAT_DOMAIN;
-- 
2.55.0

