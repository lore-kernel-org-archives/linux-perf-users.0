Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863716F27B;
	Fri, 21 Jun 2024 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008641; cv=none; b=hKDtAtcqi9GEgvz76VYGTjqanvGGmFZzJ6X2n5qWoPNS2afEildwtvCM0GnGNF2C6xFnvWTMFOTCG7x550dwRPTfmH79rSFtBxKGRY2ilTDW3zt2VrcHVRAejWn5An7yRHiWbDZawm7xzZDvarHDWYCkZhZb11GvA/jA0QTic/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008641; c=relaxed/simple;
	bh=r+axlpKvx5bW+LBnT30m1FMMrTx8JrNdVUOP6zjsi2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9hE+cF12DaptFZn0zXxmMql/fZ9m7/xnkd32XtOiU4d4iAstpcTXCq+7GlgX4ut5Pky4H1ROFLqUpNOCog3ZIJ0CXlj3zhi/9pH1IVHkb3lsIhqikuOeqWdeTDnahA7IsVVKtZgBGk8YYzd7feZsY4OOBKjCzz/LfF0eXlAoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQr0grK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQr0grK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1CBC4AF10;
	Fri, 21 Jun 2024 22:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719008641;
	bh=r+axlpKvx5bW+LBnT30m1FMMrTx8JrNdVUOP6zjsi2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQr0grK1/vwcCmn6T4XIRH9Z0b4uviW4UgKm9JIEe8L5rGrFF7lwHbDsRudXycTZ7
	 ImYOOws+5XD8PGIc1lH8pItRADPD2VBgIc1z/yotrzGP4X6YZTjofFY89XcFwJzJO7
	 tsZxOh7Ax/GjtQ/lZiE6i+utd+gMPELFgyUlwh89j/wCkYgCqa0lpwDaef7QBu4lgW
	 gR1SqRw2C8+HNRf9cUjMO8jujLJwdyWA2AU/yKTaPZCS4FEEqdCeXNgurDbwhaVns9
	 LHOLyFHFjDQSCuD/swXCcf7zp7yBdmwmuU8UyiL3zmcrsB6N3OQQw8po9G2B5MmSNQ
	 PiivpnSeg/jSg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 6/8] perf record: Fix a potential error handling issue
Date: Fri, 21 Jun 2024 15:23:55 -0700
Message-ID: <20240621222357.717374-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621222357.717374-1-namhyung@kernel.org>
References: <20240621222357.717374-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evlist is allocated at the beginning of cmd_record().  Also free-ing
thread masks should be paired with record__init_thread_masks() which is
called right before __cmd_record().

Let's change the order of these functions to release the resources
correctly in case of errors.  This is maybe fine as the process exits,
but it might be a problem if it manages some system-wide resources that
live longer than the process.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e855a7688008..a473000f3599 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4242,13 +4242,13 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
-	evlist__delete(rec->evlist);
+	record__free_thread_masks(rec, rec->nr_threads);
+	rec->nr_threads = 0;
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
-	record__free_thread_masks(rec, rec->nr_threads);
-	rec->nr_threads = 0;
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
+	evlist__delete(rec->evlist);
 	return err;
 }
 
-- 
2.45.2.741.gdbec12cfda-goog

