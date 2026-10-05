Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6235677D;
	Mon,  5 Oct 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182060; cv=none; b=NeI2gsRCcO8cxGd1F+L7lcpFsVq9riouYG7PVob0lPWyUmBeNdeZDQDauudlKV0ka2dRMqK+h0ZoauEnKC8Tm+VqMse2whlqlmObppku8hw3C7ZIvnDvnzukbxC230VxwADsTz0d7fOWg80IGShlxy5WohkJEk+/oGDjvukgUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182060; c=relaxed/simple;
	bh=+iahA6FY8T9iawzE3Im28pjNeLHqV3cJ6/i00TEhN5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUcD5KCrKkIXiYu/v7MIvmU8L9W3PIhDNiXwYmsJmjJqehRq7bQBaTZxe+rvNWsnFiVAluLxCmWGflqrrDuWzNznUaqN/n17gLCTjBAkHmUXYXmf+qO9XBcsveB5cHN91YaOH+0wklJEUshYQFpbVm6qQmFCL+4HZ/QPlN6gkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3nlNL+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3nlNL+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7CD1F00898;
	Mon,  5 Oct 2026 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182058;
	bh=Ki5E2qaJ0V5oQAeX8c4xKNOkY/w+Sv2nj6sBXz0B96c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3nlNL+uuhzw/X6sQZs0o4jXbTSWxEiWNHrWW+NC+7W2eAcMgJy7j0NPt79W8DRmY
	 3hTcvMrX79kolFHnzjkrLBaRqXUgkpOsYMWMFTByv9yd75BXhJc6Mbld+pp+AdEW6s
	 7o8QJQJduUSpo1KDYglv2nwnj2v/VFSHSaC2+bh6j2kKtwsYjVQ/Env0nsDTFc++Mf
	 Loow/VFqoBMUR52iVodk0LgEQ9Vys5TlbnGvQ+IUt2V02kclKzL1f2e9QMLytrEIjz
	 mCOv1hof7DnQgKgZP+0qB5a0XrgY9miPFATejcr81HHHQ5cePl9VMVFgJDmsQpo9zW
	 Kn76zF1dBjaAA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 3/7] perf symbol: Update symtab type of vmlinux from build-id cache
Date: Sun,  4 Oct 2026 23:34:07 -0700
Message-ID: <20261005063411.114244-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005063411.114244-1-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently dso__load_vmlinux() sets both binary type and symtab type to
VMLINUX.  To precisely track the symtab type of the kernel dso, update
the type to build-id cache if it's loaded from there.  It won't have
any functional difference though.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5d98888d068c741a..cf099cbd29f268ec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2079,7 +2079,7 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
 	if (filename != NULL) {
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
-			goto out;
+			dso__set_symtab_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 	}
 out:
 	return err;
@@ -2235,8 +2235,10 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		filename = __dso__build_id_filename(dso, NULL, 0, false, false);
 	if (filename != NULL) {
 		err = dso__load_vmlinux(dso, map, filename, true);
-		if (err > 0)
+		if (err > 0) {
+			dso__set_symtab_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 			return err;
+		}
 	}
 
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
-- 
2.55.0

