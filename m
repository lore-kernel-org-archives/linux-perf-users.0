Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794369301;
	b=Vm3uFHMMrunswlksbHjcup7eEir3VyuIkJU3MYuOJthzFlP1xgngiBWzQps5uL8Xmp14
	 hMEYr4Y30rusapQaoezQ3HCkUMQw6clMlewIM+lz3wuoAVCk7M95vHgcTGObbARAauasW
	 WM8xDlMFn3iRQolDuuXhTW4d0mPFyuNhuc4ThGkjjvWkyimOT6n6AM6wCU5OyJ2T0HNZv
	 Fl5T5TE3EbJZiNLEjjGBnoL0ZKp29N2SxIeiTtkiKRhU9BtCUBBsNqp/7w8zz15oFCAle
	 4TCkax9lOTIzrFJtg3YsmqomBFXjA3u6zZrIjdR4X9+qYOXq9z0IfN96w8/DTSbIAtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369301;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aD2h9JAO6KKGqjDEvXaAdNPjcuSnCW5ASboBZWnubsE=;
	b=HtsDRTImEeuai+QwQlSzXPpFRNatezfl/6l7t7DqZj3RI86f0899pejkbafuHNu9lggc
	 LWXiaKiOJI4JF4811GHRF/5R0d4l1mU9+E+3MihReSKZlUnKEI9+5mUiS/KA91gJdJc5N
	 RD6Jrd1El04yEddnjrNoScegvDeuKna62PQMUQgVVlZO8NQ1D3/Hg82YS4TFHD7hlnKIb
	 8EPyKY97ZgXk/3WBNL5urpt6QiYlrYTWhe/7DX3M/oSdrIpUdq9KcZ4CMRWfnyXkDDRq5
	 SqdSbinNtqx7FQ0X2tViSjDNbMBEVQqyGMuqB/xBk7UF/axx0uZZYwLH8eBXVnLpX5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PhRbqG/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855A606A31C;
	Wed, 11 Nov 2026 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhRbqG/d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794369301;
	b=mBug/Jf6P4r6g+iq9xzTQqYHkGlT3uPs28qxazV7uk2Chhq8duSd69TqQM8Mw7NnzHFr
	 QMWrtjTmtoe9kMz0o3+oIhr+o+aszJ82QiWzNO1WVYwt/527LPxAVDbAQsrBhDc3Lk9Al
	 DNXXVoiPOI4BOwwoRRGz2nBGWxngGZ54dBPAb1iL0YWxu0qMXYrIyX895ijqyJkPIfJlm
	 vZn2q/8K35cptwVuTYUc0PLZS3feQ/EIpoXnlrJxCxzGsVm2yVoHXPSjIsm1M2Z8ZCam0
	 FEP+JuuV9vmKHyKS6MQKN1XaMcUkuSGeT4KoQEFkn+snbeJRgPRq3FcpKkdC3u/Bo3g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794369301;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aD2h9JAO6KKGqjDEvXaAdNPjcuSnCW5ASboBZWnubsE=;
	b=HcJi6a++38aJ/LGeFarwHJ1v9ln/0Dypd2HOjiI1lxjSlRuYl93yvR4OGRMNtVl8fhkh
	 U3ssrUbFmYBVzFRUxm6BYFOduDoURuTyfbCSRoFN0fc+LNrniLth0pNWVmGmGG14eM5P0
	 U0Tnqw6LspNck1NjysLTg+YXZd6sEhQyHf6ihxsBcwQ/AETVs8gm4gqFtlFI6RGB06fRL
	 qDaHgDM8o1+IErhJbdsDkMAe6KfBiwD6NDEv1L4FWgAXbpfSzFYt6zjv6tX99r3ULZ2lp
	 e5z+3fc5pfgj2PPpcV9nFbUllo2zRqjN+SxDTTDu6ppnQIN5RqoArmh6mhKWP6GyL+g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C02E91F0089F;
	Wed, 11 Nov 2026 03:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369301;
	bh=aD2h9JAO6KKGqjDEvXaAdNPjcuSnCW5ASboBZWnubsE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PhRbqG/duJvk2CPLAJG0ihdIQyUnfrg/s1TPlBdr4OW/65iCxY8YHRZuqeBBNaU1B
	 TDAFYmryXh6BmN4QeNd8vpazz8F9i6jho28dVo8Oku11JTtlhIUgVO4k5T3OxMAl0Q
	 CIcr+BY3xFpg2m4pcCyD9L6/bbEO60z+WVFYqApiFRgUKnl1YWRx0xHq1Er4pu47Ze
	 V9a7a4oD1P87fHTCBF1ftZuVHm7zUjqUfF3NTFqVoxEW1rUSE/vsiUGeg6RaQ16Q8l
	 Ubv5J/Ah6noX26d+3C5/Wqjy3Ylkl9V+FS4MIdJBqeMzyTdGbj8hQNzekG6YBTKEBc
	 OB5Qhp1153dxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1FBD848D59;
	Wed, 11 Nov 2026 03:55:00 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 11:54:59 +0800
Subject: [PATCH] perf stat: Count kernel events in a group led by a tool
 event
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
Message-Id: <20261111-tool-pmu-leader-v1-1-6173b5569f59@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ7CIAyA4VdZOIsBNhAWY3wPs0MHnRLHmLAZE
 +O7i7O3v0m/vknG5DGTtnqThE+ffZxK8F1F7A2mK1LvShPBhOJl6BLjSOew0hHBYaJOyAE1l7U
 0hpSrOeHgX5t46f6d8LEWePkvScCcYYPb6ri5TNRMSyXMnivTmIbT8gfuMMVanK8B/Li3MZx+f
 A8ZaYngl7ay1jAJXINqDqCxBtcI67g0qgdgyPTQg1DYk+7z+QIJ9nYQ6gAAAA==
X-Change-ID: 20261111-tool-pmu-leader-d25fe8153599
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 TAKANO Mitsuhiro <takano32@gmail.com>, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794369299; l=2997;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=VvW12yxTCrB+KnTAFdjmOLOxHwodDVDySkgBau//oek=;
 b=n/Id/pDpNke3bFPw6iGLKQYWvbdCMJGdvHqkDEFmZ2pvyMptXkZ69OZPcSq/GdzE3dlsmmnfa
 Eh8jrX+40duAKZuTY85C568pvrEUK3EX8tIXfEWtgkUoPdAU8TS/vDr
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

A tool event like user_time has no perf event in the kernel, but
get_group_fd() still passes its fd, the /proc/stat fd, as the group_fd
of the members.  The kernel rejects each member with EBADF and nothing
is counted:

  $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
                   0      user_time
     <not supported>      cycles
     <not supported>      instructions

Open the members with group_fd = -1, as the enable/disable code already
assumes, and don't give them PERF_FORMAT_GROUP since they are now read
on their own:

  $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
                   0      user_time
            42637254      cycles
            28279395      instructions

The kernel events in such a group are no longer scheduled together.
perf only builds these groups when the user writes them; metrics move
tool events out of their groups.

Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
This goes on top of TAKANO's segfault fix, as asked in that thread.

With -a, this counted before 6828d6929b76 too, because the cpu mismatch
check split the group up, so the kernel events weren't scheduled
together then either.  Ian, is that fine, or would you rather have the
first kernel event lead the rest?
---
 tools/perf/builtin-stat.c | 2 +-
 tools/perf/util/evsel.c   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..59890916dcc4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -721,7 +721,7 @@ static int create_perf_stat_counter(struct evsel *evsel,
 	 * the group read (for leader) and ID retrieval for all
 	 * members.
 	 */
-	if (leader->core.nr_members > 1)
+	if (leader->core.nr_members > 1 && !evsel__is_non_perf_event_open_pmu(leader))
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
 	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 560741d9599d..5a919303562a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2378,6 +2378,10 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (!evsel->supported || evsel__is_group_leader(evsel))
 		return -1;
 
+	/* A userspace PMU leader has no perf event to group with */
+	if (evsel__is_non_perf_event_open_pmu(leader))
+		return -1;
+
 	/*
 	 * Leader must be already processed/open,
 	 * if not it's a bug.

---
base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
change-id: 20261111-tool-pmu-leader-d25fe8153599
prerequisite-message-id: <20261023085629.1694941-1-takano32@gmail.com>
prerequisite-patch-id: b92ce8b0c6248a4af182670458912b760b98a410

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


