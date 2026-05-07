Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9935F18B;
	Thu,  7 May 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138801; cv=none; b=g+7GrkjRdekcMfvML5B8piqvrYwLKZpLfbI3EqWY5VS4opzgClTftiFuv6IBzCXCu0de0xHesLO2yFrd8C16xZMPcuq1lkhUc2id7zMkXggxszxXTfEs0ycM4S7n6ps+Y9ujlOZ80ccWqhAqqfhKjflK9jPG0Wxuer4xXIvSxQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138801; c=relaxed/simple;
	bh=vZqA9cAhuBFLO+64bSaU4f5yvGMLGVVYFVQOut7Yf/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdMTyL9GelMJiQTu9ltuklpcBIKENzCXaVkoFWLEQ4oGUuX73WKzdIyzQSHNT3OfXotJGAToBgyK4nkgnCfAdRJG6in6m5Qe1Pf321N1QOglG294swlmwZPAfiu5EfNf3X4lY1VMdIiGQUqtK/Y7bcct2AJSyyEfZsRiksmUudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIga6+gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIga6+gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D306C2BCC7;
	Thu,  7 May 2026 07:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138800;
	bh=vZqA9cAhuBFLO+64bSaU4f5yvGMLGVVYFVQOut7Yf/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIga6+gdxI3lM8vCdW2AJb3vy9NPTAE7sKaZ7Z71nv7DFTM6u0czCAg7dX2eyfwQn
	 yrDw+Hn6Q9LoY152NnDDftG+pg8nsyQXE1HBTgzNweuEN+GDXBhAId5g4oRCBjS1Ts
	 q5N+uOIw9FIgiT6t+g68ouegxloTUcFTo9HgWp94+tQe/aMtolAhBN21ut+BQdXWmx
	 ZZJ4yTaadu+6P8x9zaII0Ou40TbePDJiciHOQT1xff52sRFV97bmHLk/umbYsZhKr+
	 JJeWc1wuAVZTWKyW4fjDe/DGF6ri+bUzV16oWrFz0iP+Zawmuq8x4EFdV3G0R32dmy
	 U4+/0rmE7oXmA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/7] perf trace: Sync linux/socket.h with the kernel source
Date: Thu,  7 May 2026 00:26:26 -0700
Message-ID: <20260507072632.37152-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507072632.37152-1-namhyung@kernel.org>
References: <20260507072632.37152-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

 c66e0f453d1afa82 ("net: use ktime_t in struct scm_timestamping_internal")

This would be used to beautify networking syscall arguments and not to
affect builds of other tools (e.g. objtool).

Please see tools/include/uapi/README.

Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/linux/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index ec715ad4bf25f5f7..ec4a0a0257939a53 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -415,7 +415,7 @@ struct __kernel_timespec;
 struct old_timespec32;
 
 struct scm_timestamping_internal {
-	struct timespec64 ts[3];
+	ktime_t ts[3];
 };
 
 extern void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss);
-- 
2.53.0

