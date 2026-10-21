Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792551382;
	b=yTJMINKO2R3CoLQdnNy4SU2IWe27V+nzHnydipZV8NUTLYs6Ue9G2aKbZi4Tc86kiFDR
	 UuAnuOe1sH+mNEoVNrafW8zya0Me6ybaV881s6dddaH8252FIERgvLgP5vyfMnoEP6uCi
	 Gkf4+0MgNkLXHlZcsL9fKcxvseWFrYOfJYBV60tkFhlTAZYFDYnhz8syHYbnGrZGSGs+C
	 2hYo5RQHksr7yE1AI8vU9WPGfxkwrWzQimY9WgD4s9sfmC+ofHhFmX+snKb6PKDXjmkjP
	 5aDHPOgY53p98HsdWdODx+JtKwUdLcOiJ2Ig6oFdB9nIn516l8jBsf7N1ryJeUxLqkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551382;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qNlJqB1SXmnFwDnsWVszeKxrpqpw9LC2VveqiRkIhpE=;
	b=opUKYFzyex3ZgUgeKUEMg32pjt36kGdDL2iprc+lebtAgJ9fISo0P1++G8eTESIE4IBA
	 npFE97evcSWmJw1DciDjRCGaFfYouPnj1/UnYwnDW4pvb98fAoHjDAtW7PUXBNAbz4zEa
	 LlgKulMxVUB2LQeDpNTRHhWQeVS6Txn2Rokwjm+dOEBoYjok0Hym3uBXUxSt82sh16MMR
	 TR9dQu8fwgTfAzsGA4MDwCHga8dBDsgMH0gMRofTpewvMJ0CK6TZQbUFwC4iydxZh9Z8v
	 UVlnT6I5052PHi2NWGwTFjqQvEO8/95PyfrUa93Z/iwjuMLkxPlEoBe7fT+XDzBbC0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMRHbb6Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92653606A31A;
	Wed, 21 Oct 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMRHbb6Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792551382;
	b=wvaRl8NI7m0RTSAI0Ygf2b+iyqly8kKY8R4dd6YGVCgBzCCwRSatr0e8jGGxXT/1v71k
	 bysjAJFNZkqgJZIEinJ/IP4BjjVwDd5kjklB73SQV3Jn2nyQWxQxMS9LBymSyxbJEBI5K
	 wGRHT6zJkgJy8ICCiyqZVLAu+ucKsNpQPr5Dl1/b4BjROxCVk9e9gWRTGgjQeML3ZZoDN
	 2b59x0wQjyNp8GqFacxGl6hTUShTOeE7r3zUXDLSdzR7WFyewsuYlT39h68EJl8G9+KCk
	 AWi3Gwl8b87JE0iQfDUhlp+TPcXQHwRlIRgxpA6V2cvUqD8zgnm2O3vPmNPqXnRjwfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792551382;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qNlJqB1SXmnFwDnsWVszeKxrpqpw9LC2VveqiRkIhpE=;
	b=zkKNSw2pNaKXYl7+F/Y1HvSGtCG45Md4PTSlKecj4rKZowTHhrF89VTfwl+hYU0KZsvS
	 4LJqv+TFOmHIeC6DgOsp+6ZGgH+UoVzfm3aEbS4WaUyQiy88EQs9ATHmp+MO01YWUG6xT
	 Xtx6fvuVt+5C6UG1pctXGS6GlDxStlHf9alwjBMPh50LtMfRjzL/+84I49SveYavp1/NT
	 +GBae3jGDp21D/Pl5LnWJ3dz8XvpIIkvclc6ks9twKtjzUATBMcMywrbICky76Y1rHL7T
	 48HDE8oWIxd8INsTTUdFAmjRRQ3xJkzyPIqlc3DN/o8gvBtqYCEBAilo0jrd+kySw5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8B5F51F000CA;
	Wed, 21 Oct 2026 02:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551382;
	bh=qNlJqB1SXmnFwDnsWVszeKxrpqpw9LC2VveqiRkIhpE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UMRHbb6Za3JxZbSlOcS3Amw8VlU9uCxANY9NTwHBg6qwPeXLjjBc3Yd88FqiH+28R
	 n9lanlEB1opAvYpP2r7LOoNkq5+qSTX5failJrCkO08471/iEVzdhcNEr6DyQcMz6t
	 muMfVfgJwO1J9sia0d82pqSZyNIOd/h8/h4YS/NAcIpzdjalQvm+o2Tbl1+epGs4Sa
	 EQt7RQLyXJYUw68pp+8mIplYpEz6ZtgKJY0bgZl+hUFRtf2zsX5WvhcN32u0jKu6T1
	 CXt484RPfWRJiG+LFbLhnKgJYEv8sZZ/TLML6dkd+bjcUdmL14j6J6cw5XjaWN5Sc1
	 jEcdden2YgJcw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DE33A400AB;
	Wed, 21 Oct 2026 02:56:20 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Wed, 21 Oct 2026 10:56:19 +0800
Subject: [PATCH] perf timechart: Fail IO recording when no syscall
 tracepoint is available
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IKP6PUr0UFsqz2koRKB+O9Jx
 2GYyRApMEWYmwyBHo7sXQXZNmBP4w5C3iqDEqqXQklMfFE1ISF7dB7TjZ3UgzWDHu2koIZ3oJ3
 ff7qspXxbF1oWZAAAAA==
X-Change-ID: 20261021-timechart-io-no-tp-4137ca738c92
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792551380; l=3030;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=oqWV2I1IZHKBOUj20ITS6+0GsuHEqAmhyLX9MrxOjlE=;
 b=VkXSHYDY5SISGSSN5JPI6RK0QVYT1vneV932Dk9h/zRPHKY/kbK/9Y/eMYCtXYqNMU2TvW7fv
 BVQgX75/DEhDyiBl4M9QFWhykVlU5Gn8wa/7+ZvLdMgacPCdffRyIsb
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

'perf timechart record -I' skips the syscall tracepoints that are not
available.  When none is, e.g. tracefs is not readable or the kernel lacks
CONFIG_FTRACE_SYSCALLS, perf record falls back to its default event and
succeeds, and 'perf timechart' later fails with a misleading message:

  No trace sample to read. Did you call 'perf timechart record'?

Fail at record time instead, reporting why like parse_events() does.

Fixes: b97b59b93d10 ("perf timechart: Implement IO mode")
Assisted-by: LLM
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
Found because the IO-only case of 'perf test timechart' fails as a
normal user; it is now skipped.  Tested as a normal user and as root
(all three cases pass).  The fix and changelog were drafted with an AI
assistant; I reproduced the issue, reviewed and tested the change.
---
 tools/perf/builtin-timechart.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9eb335d9db16..69cc89232d6c 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -9,8 +9,10 @@
  */
 
 #include <errno.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #include "builtin.h"
 #include "util/color.h"
@@ -28,6 +30,7 @@
 #include "util/header.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include <api/fs/tracing_path.h>
 #include "util/parse-events.h"
 #include "util/event.h"
 #include "util/session.h"
@@ -1793,6 +1796,30 @@ static int timechart__tui(struct timechart *tchart)
 	return ret;
 }
 
+/*
+ * None of the syscall tracepoints can be used: find out why from the
+ * syscalls event directory and explain it the way parse_events() does.
+ */
+static void timechart__io_record_error(void)
+{
+	char errbuf[BUFSIZ];
+	char *path = get_events_file("syscalls");
+	int err = ENOENT;
+	int fd;
+
+	if (path) {
+		fd = open(path, O_RDONLY | O_DIRECTORY);
+		if (fd < 0)
+			err = errno;
+		else
+			close(fd);
+		put_events_file(path);
+	}
+
+	tracing_path__strerror_open_tp(err, errbuf, sizeof(errbuf), "syscalls", NULL);
+	pr_err("No syscall tracepoints available to record IO events\n%s", errbuf);
+}
+
 static int timechart__io_record(int argc, const char **argv, const char *output_data)
 {
 	unsigned int rec_argc, i;
@@ -1922,6 +1949,14 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
 		*p++ = filter;
 	}
 
+	/* With no event, perf record would silently use its default one */
+	if (p == rec_argv + common_args_nr) {
+		timechart__io_record_error();
+		free(rec_argv);
+		free(filter);
+		return -1;
+	}
+
 	for (i = 0; i < (unsigned int)argc; i++)
 		*p++ = argv[i];
 

---
base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
change-id: 20261021-timechart-io-no-tp-4137ca738c92

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


