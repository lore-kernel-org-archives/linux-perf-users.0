Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718012913;
	Sat, 20 Jul 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721472139; cv=none; b=Ks3++8rOaKclsb9w6McJW8l1EqrGOyhbirwE6tZYRFnP7zI80sGFY2t3bBEnZxFcJ77rjYrlATBZ+EWvYThHx+HT4XF8vPsUo1lT/mBjidcl4ttsvurJDc1DTX73NAP9HBJy3QV7pUgVHPSdPWilnNQBJRio9k7I+GkeaGqF8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721472139; c=relaxed/simple;
	bh=/4f141tJHvAWF8tQzzk0NAIKIQKehhhpmiX34/KAy0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqxuvQFAGx2D967qpcC93FGI8X5Q1CvTCcOIQplJBT+2t/vTUFp/yZ1YgKJ6gVUcyzVKyfOJjT4U8tofGERRcLI3VOcE73D6D0qXH3SIIwD0Ti8dpJuFGX0ARmNMpDoZ0iLfGHAI3SbJsAFjNu+/s9w18YFbdm7RXBFRu07oWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eWna8qRI; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eWna8qRI"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id V7XRsonOi95X4V7XRsgB3j; Sat, 20 Jul 2024 12:42:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721472128;
	bh=PtZVKDIVPm219rX235hzdcjRMLlI/guwNur3d/5rJXg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eWna8qRIGRu2hhZOvWtZqgZKzliKcEd6NTg797VGHgizLWszQVvPqrXND33R7H+Ai
	 zKB9R4EkDjW/wkS7P2wbXqYT5TUsaf2miPcNyg3aVXfyklY1bLMgltK2MFIVpp8u20
	 yQMK53YAIJab8b76AdpxqEdqYKzyg1Rs8KvWXEjEdZqagGIynvUPCGN5r0qlCrmH3z
	 owb5RkbzxjaSwO7SDE+4d98lkIBqaN3TYVnw8uNn+qdipyfNvYFk9ZUTFyMKB5ik2m
	 z+FCpadpTZfBLGG0hBVODGgI+7C20PfzWawAfxZ+kE7bnqbSvyGZBGORiVolHnQEv6
	 nNqcGjGUl0LFw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jul 2024 12:42:08 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: Constify struct bus_type
Date: Sat, 20 Jul 2024 12:42:02 +0200
Message-ID: <1f6472a4e9f2ee9e74152c3a3491d015e44137ab.1721472093.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct bus_type' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
 273314	  16956	    716	 290986	  470aa	kernel/events/core.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
 273474	  16764	    716	 290954	  4708a	kernel/events/core.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index af2e3a06b239..ee011a967a33 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11508,7 +11508,7 @@ static const struct attribute_group *pmu_dev_groups[] = {
 };
 
 static int pmu_bus_running;
-static struct bus_type pmu_bus = {
+static const struct bus_type pmu_bus = {
 	.name		= "event_source",
 	.dev_groups	= pmu_dev_groups,
 };
-- 
2.45.2

