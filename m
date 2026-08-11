Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF6456E17;
	Tue, 11 Aug 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468344; cv=none; b=WgdJdeKXADvMNHObBVRjCLQ3QrXoKWZm4kcVq+8d0ZvXn8OkcX49aNDolICIKX8BTRTl/3oGPWbauWHxPwqC5bSKnXLVjBcA2LtXiVbPIrX0jRFvRhakEB3PSWieNRZUpgTcp7q0BU3hq4uxrhvVgPNDqB/73Fx1AC2XXqg70/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468344; c=relaxed/simple;
	bh=mZZC7s2C29BbJPGOfHLgVI5BZY4Pb9KhphfBeyw98ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv/AMWPYpyqFDiVaWjlqBcn5mBpYJs78tocyWVyZJPd2XlqN61LFVneqSa24IPjGYIUdq5knXtxiIsT1JvL4IBDEdZmENKgnYpqeJ7uE0ca/91fMCQTgGW8eqykix+wmyTML5BogmQuZJgAtT9g/mS5PutJAykgaWggWKD/XONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgvpeqsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgvpeqsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9371F00A3A;
	Tue, 11 Aug 2026 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468342;
	bh=ddvN6mzZQPpjb1j9jQPuMJz+025tgjfM+zZlsoNai0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgvpeqsIp42S9n7rMPgGI7wDetYDvq4HLF88M8clh9fm9+oOWGgfPxJhcnZwBjEs6
	 mkcu1LUX4kJl7PJIu/8q68CLginJPOWSpW6uSWJv2cp+4MpT9UdEKY7QLJBqzrKKhP
	 5xfeJQFGKgnNurkvqpw+yA4sQr168+Zcz/woyzZ5ILt5yjjrTS8DeA+48xRvNUdZ1u
	 0o8zGRkuR8Jk3jmh5hsVBwqu3eMQlJ1+NhTD1bo7looCip3sIBsSntff5DzXqIn3if
	 cxDxhWbqe46Cpc3dnLUaxYr956QP8fVFCuxrA6q9F/YSvr0NEqh9GJd4a1BXj3AzRE
	 2J2XtW0FvZJZA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno in file_read()
Date: Tue, 11 Aug 2026 14:11:58 -0300
Message-ID: <20260811171200.30096-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811171200.30096-1-acme@kernel.org>
References: <20260811171200.30096-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

file_read() uses ret = -errno when dso__data(dso)->fd is negative after
try_to_open_dso() fails.  By this point errno has been through
mutex_lock(), nsinfo__mountns_enter(), and multiple open() attempts
inside try_to_open_dso() — it no longer reflects the actual open
failure.  If errno happens to be 0, ret = 0 looks like EOF rather than
an error.

The fd field already carries the negated errno from __open_dso()
(e.g. -EINVAL, -ENOENT), so use it directly instead of reading the
stale global errno.

Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 124193453675ca18..845a384a4d56779b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1029,7 +1029,8 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	if (dso__data(dso)->fd < 0) {
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
-		ret = -errno;
+		/* fd already carries the negated errno from __open_dso() */
+		ret = dso__data(dso)->fd;
 		goto out;
 	}
 
-- 
2.55.0

