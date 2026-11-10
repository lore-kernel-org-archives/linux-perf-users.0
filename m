Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794279903;
	b=fIGSzbS0o5MSvaR+1/za1xFRkcq2kPfvxheN7DoOB/sIK0TsEKMoETLy+aOouumgYFOz
	 YoTqGKYwzyFSAZFd0/giE0dk3/Zho7dmZQwDPBGSZErcr84TCyBu8OHblqdtMRr9RcJX3
	 xw70laLZf+VA7UMc5Iw+u3sMj5zTyMZb2c5CpLzNyCJPw5MWdDB6jMIcwA04GTmxkkqOt
	 4oQY7tRRQDHuiSUXICkFSNfrV++zp35SxYjgWLUIJ+yuuN2PqFdo9TiB1zLKjcZcvVoKN
	 jNMsR6ToueN9cEeiaRtZAPnU73PKs8W4XSq8zOlW0KoJqTf1/grqNio2ztet/zVQ71A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279903;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FhgIbf74ii0aoairS6dk2/fiibwc/iueYL1fLd9erDw=;
	b=TtR31NyBtmlUoamBTHPJNS4dprmpSbfCPG401LjVfsUV5y5IH8FxJ0kzjRaAfpUheWUv
	 TpX977ETX5DLokR/Uf7stt1rg7PNyDaDX0ACNGNXVmn0qHvBZAt8872qO0t4B2EMoc0C0
	 oAHpGwe8Jxzhvqy+sDdruUzaF6OJAwco0ftWOV7R4BdzJ3cmT+CGCb/2ZfYwXhYgEZANm
	 9dK189K4SZbf05GwCKZbfQDrGAqiPSlK19Cf2pbmONrjJ+MlME1TqJiRKdFo4V059C0rg
	 1lUWr4MpBaYyGKHK648bxt1sN98TdJ8Ca/9gJxiQDx4gnjWyZNISpUmz710h7lStMAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msFydHBi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294A606A321;
	Tue, 10 Nov 2026 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msFydHBi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794279902;
	b=fhzL2WI5Iyu/7udvswoskby5K/JKEDyYeKEHObHMhCLaKXDD0PYJf9rrmfYbKgwR3zU3
	 TG/wqeKeyLAaB6v6WdMjos61oSEihUKtqnJqcr+xN3WRxQHjhw1GRGEa7EsBQEBMN3tfY
	 CkpCxsLKUYQF/AtFNHtEA7HTa39u1d/c7V03gFfUxQ7c0vyiggYLy4jk8ZPMQGQVQjHwj
	 PEpCZPXIvPmvVxSlmO0/Db2pxJbwvUeq+pAXApt307peylx8QdViiWVoGzi4HKyDaesQX
	 Rl7C6Mk2IYR47lkfmBqSOKIRCoUlQ0ukKJ1oFKT5WxyH1oNB1yv1s5bUZjjuMrj9DCQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794279902;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FhgIbf74ii0aoairS6dk2/fiibwc/iueYL1fLd9erDw=;
	b=fiAAlKt2tVyvIV8/a5yfirc8TR82WfqBnNRF5NOW3fagFrq1OOMRCpq0Y1BaXnNk2gJS
	 LqF7WcvtFnDK+gHT8DUUOgh74BTkBgpEBoIJgWwdS3HjDGSYjAeNB50+ZIBqmkJ8820N+
	 qD0iSgpzn/PJL7M3vp6ZIylauSJpqw44i9bgWL7kzprFSZ542VONULHNP4g7B6NJDG3d7
	 pvhgkWmplt7jqI9YRLRIs5/Lr3v7nngUiLTHDSVT2Sn+RFjN5qpbQmw4y6eX1DQrIfZ+P
	 DJaur5gIt5T9j4AHgqyHPLi06s13pz96hON2eyWmw6+nlEDWz65ayaGIcdrHShZ9QiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 486711F0089F;
	Tue, 10 Nov 2026 03:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279902;
	bh=FhgIbf74ii0aoairS6dk2/fiibwc/iueYL1fLd9erDw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=msFydHBipMijEno8AX+quUfnrnhztqBBNx6lcSA3ND92Da4/HT+tWp52/3OtQU1mW
	 ITBTnzoByc34NrUgO7fdZGOQU7ultJ/mahLZ990Ndyq3NRuw8qcdBZ9JHh3UBULQPm
	 RAiOtt6mI841zlhQafuJo091ylkUkHFgVtmSeRE9hn/JhfU788UlRt95Q4n6zfNEL8
	 nan4MviWmNBiDh1uZ4yRlnl+hQfgdQiX8ZD026tvF3uvL9g4gJ0D+hj4f33p7fUcyp
	 kJtFWK7ZB6UT53JrZatACi4XCskBB5bzLzweKojrgvrstrrDb0tLAnoZ1sJ6p2w06v
	 M180EI3TXY3XQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 980224879F;
	Tue, 10 Nov 2026 03:05:01 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 11:04:59 +0800
Subject: [PATCH] perf parse-events: Don't report unreadable tracepoint
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
Message-Id: <20261110-tp-glob-errno-v1-1-6c2cb609c590@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNNh1a8ijhYjRqQVlIRQXp3i
 +Mb/n8hswpn6JsXlG/JkmIFtQ3M+xQ3RlmqwRrriMjgdeJ2pICsGhM6b3kiDr5zAWpzKq/y/L9
 hLOUDxtgMZV8AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794279900; l=2440;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=Z9hAImHuDRxUoABhn8rkY6eaA7NrOxV85HdeeidRhWg=;
 b=oEMG3CJWJVJ6V6xWRWQ+xm27XiPnWV0rDQ0DoRdyme5FYv07EkjpJK+G1VWdGqTW9BQg0BhdR
 mUh0IjxB4ilCbxHELMbXP4SC6lD3BUX1q/rOxu6Uy1WP8IPc765LZGY
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

When the events directory can't be read, a tracepoint glob like
'syscalls:*' is reported as an unknown tracepoint, with a hint about a
missing CONFIG_ option.  A plain tracepoint name reports the permission
problem instead:

  $ perf stat -e 'syscalls:*' true
  event syntax error: 'syscalls:*'
                       \___ unknown tracepoint

  Error:  File /sys/kernel/tracing//events/syscalls/* not found.

add_tracepoint_multi_sys() reports ENOENT whenever nothing matched and
ignores the error returned while reading the directories, which got
lost when this code moved to tp_pmu.c.  Report that error when there
is one.  As a normal user 'syscalls:*' now gets "can't access trace
events" and the remount hint, and perf test 5.1 is skipped again
instead of failing.

Fixes: d002aab87de8 ("perf tp_pmu: Factor existing tracepoint logic to new file")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
Found running perf test as a normal user.  Tested on perf-tools-next
13a8d580433a.  As a normal user, 'syscalls:*', 'sched:*',
'syscalls:sys_enter_open*' and '*:sys_enter_openat' now report the
permission problem, perf test 5 passes with 5.1 skipped, and the rest
of perf test is unchanged.  As root, 'nosuchsys:*' still reports an
unknown tracepoint, 'syscalls:sys_enter_open*' counts, and perf test
5.1 passes.

The issue was found and the fix and changelog drafted with Claude; I
reproduced the issue and reviewed and tested the change.
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


