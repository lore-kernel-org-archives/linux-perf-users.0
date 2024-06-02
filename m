Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190519A;
	Sun,  2 Jun 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717286729; cv=none; b=hVuVebZnPJ+Jlb8zlpu98IUh+PYo0JniBcI5DLYWEyPhQhnr3vc52M2rCBMypiXsMiAGMKJWm+jtf+0QcN5QGaprGfFNLiTaBhX2jl44RsyfvjqpXLzMuWkiV8LKr+NRR3Mp7HdaJQIu2s0uRPyChoGp+o4AyfmUHPGjpL0OiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717286729; c=relaxed/simple;
	bh=J3k7KIYhmaj9sQPIeTkwdp6Xpu8KSxi9hVoUdxCtXPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDQa7NZyvc2eLtJLedGMfUJnBnJTvbK+CccSegqKPj7WgU61adr+QX+IJvqLmkijr7YD7dcODQ8SBhS1hwzCrQkWHpszTppThd1trzhOdARgst6Gp7TMvKvED/w4Sc7xhsxA6SCnLUO1b8WCFEHOmlVMLwUNoyk4QAiAkUQ9plc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QIWZA9yY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QIWZA9yY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=CAm7j6DSXK0Xy+zVqsxuSOQYxKfr5aZoX7P53UUe330=; b=QIWZA9yYO7BfeF9N
	AksVLLGuJ1C+/mHcO1MLVwTOl5+RRO+zBEEc7xwb1MNetcJ7TGwXthRbfapJct/QOw7RYwXXzPfXC
	rrn32uq7QYyKA1YP+WIFk0OMK1qQb5hzPQ8nFVjRJU296lv2um0q78wgalUeTVYZR7PH3WHUGqgPE
	AgHBrJtpt0h+Gys2dccu17KsWj7z2LJadXxlIhnTCcImvN0AcGBTsYnI/3Wtc8YTKzeg7rlVeo9ul
	+spPRJvBzOsh3TvaqcMwoe+G5gk3udlKYJ3JREIlY3ZRKJTRc0aY52zAbm91eKFWwtYv8wO2UJXbw
	Q35pbP2fdSTaFK+Svw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDYim-003m2E-34;
	Sun, 02 Jun 2024 00:05:13 +0000
From: linux@treblig.org
To: peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf genelf: remove unused struct 'options'
Date: Sun,  2 Jun 2024 01:05:05 +0100
Message-ID: <20240602000505.213032-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'options' has been unused since
commit fa7f7e735495 ("perf jit: Move test functionality in to a test").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/genelf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index ac17a3cb59dc..c8f6bee1fa61 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -54,11 +54,6 @@ typedef struct {
   char         name[0]; /* Start of the name+desc data */
 } Elf_Note;
 
-struct options {
-	char *output;
-	int fd;
-};
-
 static char shd_string_table[] = {
 	0,
 	'.', 't', 'e', 'x', 't', 0,			/*  1 */
-- 
2.45.1

