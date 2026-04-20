Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BD3A6B85;
	Mon, 20 Apr 2026 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706249; cv=none; b=VVPH9PxGk9g50jy9snZZFnX810PmpPGWNs9QyOYJmtHyubO8oOnHVXt2tjVWxrHPUjUiT1juc7XsF4pmYu8iHYPaMi7eHv5Pbu3KdW+n3A6PAzHsdJqMmr24vn0WTcRtJ3ktgElVkXBQ/qcrjwjOmeZi416IwFBDN8YdHhmevUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706249; c=relaxed/simple;
	bh=fAtgfDnQlrAhdJL0D/l9O7uqwoiPleTxuU/8C2kzeRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0w8k4k2XLFIzm6CtGm4//9ZZTHof/YmYITuG3dfXzuJFu7YgBNR8HXtgwSx9NWxZfWCHR+XMK49Ra5YV1FKUNjEDM1td5W0KtzowbAq6Sczm6+1ZFfRimVXRr9iA8vSBp1XJPX+0bEcYrerJTpytzMI+DqfizDJdX0r+6xEzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=tW3yHB7v; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="tW3yHB7v"
Received: from fedora (p3620132-ipxg00f01tokaisakaetozai.aichi.ocn.ne.jp [124.96.189.132])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63KGXjxq043500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 21 Apr 2026 01:33:47 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=NpBhwTLvJtZZxXwnLOfamyMbZalhbdGTHgxjie6TEIg=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1776702827; v=1;
        b=tW3yHB7v0+9mdaElCGqyFVWYJZWuuZE43adHxAHGtQhdGmH7VfpkyB1rnl3hyTx/
         3Rt8C0HFOGtH1MTgC7j+pqkKyJfa/qQJKR6c9pNpHioMerEj4eSEszXnv+TvlGNH
         UKLgfSVk4QrKb6G/o4+MDJrr+dT2ti1Oblif00QW4oicDGkByre2wXm5tBHbUUbI
         yzIuKDEtfzR+iYxTIo0ZUMFjFialVpNB/fqUEfqBySv9XZmxf9XTKBzczIXyxjoo
         ouiyoCP1rDp7vPJ+Y1e6wUJlRd6Vk5fUX8WYixYWefnk7uYKxgQuR1gzJZI+P9AK
         IPMUU3GKJg3EooxhCnf3rQ==
From: Kenta Akagi <k@mgml.me>
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 6.6.y] Revert "perf unwind-libdw: Fix invalid reference counts"
Date: Tue, 21 Apr 2026 01:32:22 +0900
Message-ID: <20260420163222.23517-1-k@mgml.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit eddddf4ed7f69697cb54e714e773f764c8d3b67e.

Upstream commit f815fc0c66e7 ("perf unwind-libdw: Fix invalid reference counts"),
was backported to v6.6.128 as eddddf4ed7f6.

However, this commit depends on map_symbol__exit, which was introduced
in v6.7 as commit 56e144fe9826 ("perf mem_info: Add and use
map_symbol__exit and addr_map_symbol__exit") and is absent in v6.6.y.
This results in a build failure.

This is a revert of a backport, so there is no upstream commit.

Signed-off-by: Kenta Akagi <k@mgml.me>
---
 tools/perf/util/unwind-libdw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index bd027fdf6af1..6013335a8dae 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -133,8 +133,8 @@ static int entry(u64 ip, struct unwind_info *ui)
 	}
 
 	e->ip	  = ip;
-	e->ms.maps = maps__get(al.maps);
-	e->ms.map = map__get(al.map);
+	e->ms.maps = al.maps;
+	e->ms.map = al.map;
 	e->ms.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
@@ -319,9 +319,6 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
 
-	for (i = 0; i < ui->idx; i++)
-		map_symbol__exit(&ui->entries[i].ms);
-
 	dwfl_end(ui->dwfl);
 	free(ui);
 	return 0;
-- 
2.50.1

