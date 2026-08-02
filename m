Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F59224B05;
	Sun,  2 Aug 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680441; cv=none; b=f/nJZZPSaAS+f2LS/4ZtVJPMQIt/iV0Xp62KvQEEcvSaS5auLv3x+DhCfehX1PFT/D2+2d9zJa+0M8lyUUOnUZ7+dvLA5SjWNanEM1SNU+ekLfVk9gYv1eFgoP4zXAHTvpRcgwD/nIcITeI8RHUW6ORNUBDrjZQ+IAEqAgU/Ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680441; c=relaxed/simple;
	bh=E38mqzmh1ULxtmnYx9Qc3i6+YDscehl26iNbPiYoEJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/P5Q7Em6pN+AoDyVYhbl7g+dFESPTd8AsMkgmLQSk3Il9+UFES0pyqVobVzYuqm6Y9bCPhUAyB8zPwjxXFqSrr7ol9nA9yOK8o0skJZKuTxUt59ZyvHbJk5A41DcNlaOcGsA/zU1+MQ/5+oJlaywFb478qckoyHx8a9tN9dN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjG0Q6Mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjG0Q6Mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28671F00A3A;
	Sun,  2 Aug 2026 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680440;
	bh=hFRCYB4+70KmPZstmIqVO54bQF/LilRXRcei29A8Vdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjG0Q6MnGud7sJsRQPmlYSm8X7dUsdjLAC1vysVfnI8PzmGMyQVodh9gvYEhHBfr9
	 /okK/9niuJf/86bOsjHkpikVLLoXtXcO8SZg8HwVeeuG+9tg7Pe7Uroxci7vgy2nix
	 Q4fix7unO9Th+FTqXHoX8cdC2p26jtxHguqd2eE+t9jXzjvQpQQadqVfeQEnJGVauC
	 T9UcZ1u+0hXBXNCjQW33Q5NmzuH5bvASkPvo7xcnrgCYhDMNn4k3zCsrgM/ORlgQSH
	 zBjCPmgigT6/l+VXlC5NrDyBn7iy7Ef0nPHLf5kyzNHuO/mruMauyGp1oC95kJd9lk
	 UVfAjCQD2PkWw==
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
Date: Sun,  2 Aug 2026 11:20:20 -0300
Message-ID: <20260802142022.154219-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802142022.154219-1-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
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
index d9c008465f377e79..207f8744aac97e8c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1026,7 +1026,8 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	if (dso__data(dso)->fd < 0) {
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
-		ret = -errno;
+		/* fd already carries the negated errno from __open_dso() */
+		ret = dso__data(dso)->fd;
 		goto out;
 	}
 
-- 
2.55.0

