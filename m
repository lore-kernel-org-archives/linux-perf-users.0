Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794361737;
	b=l+U4teiqH1ICh74kO7n+TWlOsg4fk/yavYONJCwVa5ox9NlLj6pX7zyiXEs0qjyeMS+o
	 f7uNUpFs9THeiqioHvkVjTKINYv55Z30XTp/GIaqM81xiRbPF2slPKSv3+CdPi0PIHn/W
	 0R9yNMVQb6KgSe4YCpXW2Cussznti+s5ww0whg/6dtpBHE/47Zu5x1ZR5HjSCJC1i9/T/
	 RaoAlsLGT5b1MF6WhT6ZP8y8+xVVZC++aALX6TLlcBIxD8k1ZMBUsNNHTLQNickYYjdDQ
	 ZD0V5nh8oRBQXQej1M/+ozcdrMM0qXaNe1zHWJmdnl1n1QsNFqJz9Q7Y4nI+yLx4CMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361737;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rdK8pogkcDADwcKV/q341boHK0olYf2gsa/z6bYGdYk=;
	b=ABQVBxCG9YcM5DTAkCDudH4uOoSzWcCMj/kcybUX5S+LN26uV3txlFH6vk+LJocJKQZ1
	 EcYiGvh659ehtBdUPJfpUGvuzQ/DdL0uee0q4bg0u1NbYqe2Y7BH/JftISboqFn7gLh82
	 qkZvRqxqJWsqTQxl93978yVYlnVLUh1xnW3WMP9mLm7uYPPU5sCHN8Gxy3BMI7xtfhH/F
	 CFCbdGQ5bsg0/4vbJOJCmf0FOuz+bQwNQ6vy/BkFIjVKjjsN/guc1gbiW/e8xPX9k4W9w
	 t4b2Mrnlr0sq7hS6XOqi748fdUMsGWp2HU+DH72K0MIi8lDmqZ6Hm8xOM9tcf9Uh04Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F45mwB/D";
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4D606A321;
	Wed, 11 Nov 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F45mwB/D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794361737;
	b=iOKdR+OhPf1pfp3H4q5LEu//QU4Exzgai0C2fltBhtaXZ6016savzqIALCS5SsXj2+GF
	 Z1Ir429myTbfOcdVMO5z5WLvRb7KBAaPeBlsewjYEZjg8DjVVEwztTYe41Jen+txfxoVy
	 0Woyq6eqL7vUV9lLfRzJw3BYfKCK8EBYelPl8KAu0vJd0hCKFRmaopitOACzzlgy4mSz6
	 JVUZOy4ny+3ny7uocT/RuGG/ih5hlPXQR+aH7yGtyV+BoizNfmLBD5IpVD+fQ/6ieRBQV
	 B8dzf6GPAek4weJsCtnQ1rjSq2A4QJaHKOBTY2Ox/Cw6jpn595pla1WLlzmaVsifUww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794361737;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rdK8pogkcDADwcKV/q341boHK0olYf2gsa/z6bYGdYk=;
	b=HlBW+fCSkaKz0YunfIweDVDQw7CBpW7HIHJV+qiTAx7ChLAEe6+ZrvUoeHqC7gkUeTzm
	 b6nhP1pgtBKOrWjrhXW7cwWlYRhWCHsDI0ECIsBYd8/mxhG3ZpqHZgpwMjymL0NQwUA/7
	 Kt6qgYct841NFsq6ufddOF05Iko4SM5J7gPQTZSqxUujcfrlmG0+t7FfNlOS1+iC1fCbV
	 IN5Ixc03OECo7UmUjGnyxmUA4gTXQ7CIiNsZzokLQDYKif5fzqaOj7FdMunP8230tsLx5
	 a4S/x/8z8ON9g6Oxe/OoOS6pfwSaAkhRKrlUn1J0MHOcn4DmHsHyrIGWX8Shnjnd6Eg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 897D31F0093C;
	Wed, 11 Nov 2026 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361737;
	bh=rdK8pogkcDADwcKV/q341boHK0olYf2gsa/z6bYGdYk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=F45mwB/D6222erR43dR/hvQO7xVgLtA4JEP+uZ90jNrUntDIpPXbgc+/Zvp6ourWT
	 brlzmyPgTEx9V6Rg3ONPl2YvPYJH4Wez9RNkpmOmrQSus+R50vqha5s/QAD0WOs15N
	 4kYU7lUZahLXEgVO15cFZcq4iM4bLm+EoZECLf1VChr04LaEtfG3j6z/e9Ik+UOJSn
	 R/tocHENAmLmotosNLFiGdTbKVKDQAX/TQjb3N3nHEF5NxKF3e4ZY7KNlOQrPI+pXD
	 MkKMP6knBdeZl3qqC2VPuaUoMzcN0nopA27taZE7dTbSjRvrgi4ODH03PDGHjqkNYT
	 LxptwQ1pFZmVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1439648D0F;
	Wed, 11 Nov 2026 01:48:56 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 09:48:50 +0800
Subject: [PATCH v2] perf parse-events: Don't report unreadable tracepoint
 globs as unknown
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
Message-Id: <20261111-tp-glob-errno-v2-1-ca45efb07d31@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQrCMBCF4auUWTuSCZhaV95Dumji2A60SUlKU
 Erubuze5f/gfTskjsIJbs0OkbMkCb6GPjXgpsGPjPKsDVppQ0QKtxXHOVjkGH1A02oeiG17NRb
 qZ438kvfhPfrak6QtxM/BZ/qt/6RMSGicdtaozl06dR+XQeazCwv0pZQvcthdzqoAAAA=
X-Change-ID: 20261110-tp-glob-errno-672ea1eb786b
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794361735; l=2091;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=oKOhzpzzihzjzROHP90IK3skpmdwiZ3od9qtUe5u8x0=;
 b=X16E1srTe/q4EZ1klblgXdNEd7t6M0s9GxwKTspiFMc3meJyyDw7zwYCiW72kql09RdtaBgze
 FAH1G29AinGAnydJqtp1/bdG2+cEBUnrugBG89z7HnMtlYT7dfFzdwa
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

As a normal user, a tracepoint glob gets the wrong error:

  $ perf stat -e 'syscalls:*' true
  event syntax error: 'syscalls:*'
                       \___ unknown tracepoint

  Error:  File /sys/kernel/tracing//events/syscalls/* not found.
  Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.

add_tracepoint_multi_sys() returns ENOENT when nothing matched and
drops the error from reading the directories.  Return that error
instead, so the glob reports what a plain tracepoint name does:

  $ perf stat -e 'syscalls:*' true
  event syntax error: 'syscalls:*'
                       \___ can't access trace events

  Error:  No permissions to read /sys/kernel/tracing//events/syscalls/*
  Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

Fixes: d002aab87de8 ("perf tp_pmu: Factor existing tracepoint logic to new file")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
Thanks for the review, Ian.
---
Changes in v2:
- Show the output after the fix (Ian)
- Link to v1: https://lore.kernel.org/r/20261110-tp-glob-errno-v1-1-6c2cb609c590@gmail.com
---
 tools/perf/util/parse-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f3ba70d4f76b..8a6d5a13863d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -572,8 +572,10 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 		ret = tp_pmu__for_each_tp_sys(&args, add_tracepoint_multi_sys_cb);
 	}
 	if (args.found == 0) {
-		tracepoint_error(err, ENOENT, sys_glob, evt_glob, loc->first_column);
-		return -ENOENT;
+		if (!ret)
+			ret = -ENOENT;
+		tracepoint_error(err, ret, sys_glob, evt_glob, loc->first_column);
+		return ret;
 	}
 	return ret;
 }

---
base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
change-id: 20261110-tp-glob-errno-672ea1eb786b

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


