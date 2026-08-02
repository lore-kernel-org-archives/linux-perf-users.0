Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358523C516;
	Sun,  2 Aug 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680434; cv=none; b=kUUnoHnzw1Zp90868lR0akjg2hZCv6Ar9pS4szCx1xUOx9aMPc8zoU33TnnoCIlmNbgjpEM4CdfSu7SYeNwcD729cP1bXmhuuM+o+K5evIGB2Z6Kp5yjtlIkg16Btp/w9WPe/4exCY3u210f0oT/ch/EwS76n/5BiSGoMSrG0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680434; c=relaxed/simple;
	bh=aU6z7QwckH6bvQO/v+gH/GmpjkrwmXuKodsDmnhGVx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD96d/T86RMN6SWdJMAelH+jSRVew53i651qubvR3Coc3pYHdqByAbzqdI4Sx1iuXHmXa12GA1A2vy18LWWtJngxDDWdAEN8mH+0l48q6qVmJr1v3Tgzf5yB9+s4hwl0ntC58CfvfzS5NG/AWcQ3iEkQ2ClRjKRv9l3GGxB7WBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAtGdcuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAtGdcuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77AD1F00A3A;
	Sun,  2 Aug 2026 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680433;
	bh=MlJqZupASTk6ZYzHVpbWwsTkfNh0zHoNLoH1Cv5WpbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hAtGdcuSjvEMm0A37+ien0b0B3/VlSKDig2AIr8Ndi5yU4925RleAOiYgyQ6zs2xl
	 ptYq3JgyLTg0BB7hus3c0lIBo2oLoBzelrD6mZ/6+7WjkdOiuGDbHnzfClg5H2jUBJ
	 OuyRxPQ1Pm2ibGe7zK1v9OlB2RlrSxXgQmhHtFa/+gwtelZZt1I2PPkDdJdK8kedVv
	 p+RjP9FZ2MNkKFQ7DFZ/t+bFOJ3Bz0PO1XStei8hdrSymSOq9QnpZlos0YS8xIM4DO
	 R8JoKFBA4EUTo2L7tjlcsXEaUFrHjFO/zzlogsQBDak1ek1QQa+sRRFhTQr1sR/l0K
	 +Y88Mz5JYoLAg==
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
Subject: [PATCH 1/5] perf dso: Guard against errno==0 when dso__get_filename() returns NULL
Date: Sun,  2 Aug 2026 11:20:18 -0300
Message-ID: <20260802142022.154219-2-acme@kernel.org>
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

__open_dso() computes fd = -errno when dso__get_filename() returns NULL.
Some failure paths in dso__get_filename() (e.g. binary type mismatch)
return NULL without making a syscall, leaving errno at 0 from a prior
successful call.  fd = -0 = 0, which is stdin — subsequent code treats
it as a valid file descriptor.

Fall back to ENOENT when errno is 0, ensuring fd is always negative on
failure.

Fixes: eba5102d2f0b ("perf tools: Add global list of opened dso objects")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 2309196d8df3111c..e087a89066bdbc02 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -643,7 +643,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 	if (name)
 		fd = do_open(name);
 	else
-		fd = -errno;
+		fd = errno ? -errno : -ENOENT;
 
 	if (decomp)
 		unlink(name);
-- 
2.55.0

