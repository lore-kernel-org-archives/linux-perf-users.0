Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC53B2D04;
	Mon, 12 Oct 2026 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782773; cv=none; b=QrmkWagdQQrcbZzVhB9q9sjpKoh4XrqTPJdpcjGERLcN31LOqCRb7TnEBg3S2/aZ6LcdEnm6VLaBpl0l++0cCP16uMyU7BVQAp4MLrP9h92jPqFaHn3BA3cgx+t8B/mVjDDXPVIYEZGK1i4O65rH88Q/YilJPcT8JRLLDcFX4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782773; c=relaxed/simple;
	bh=T00YgdzvshlzwaWv3wcg6owqMsYy3Z7PeNefTIONIBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgfR9fg2/imwdrQgxVZDIjjdL7MCGLqHFT1c/0+R9ViWMZSntgltqZ6282a4kaR+wa9BA36tmpN5JQjbfbS3EpFwcYiTcSR+6lqEdis0FRVq5RPUH5f0TN43ddOyT+x9P2ENZ2PIF4Jyqdj0CTiP0uNfV4LcC6NDh6GhYVsd9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1e2EOXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1e2EOXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D010C1F0089E;
	Mon, 12 Oct 2026 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791782771;
	bh=cPu6vPG5wXJeIsZ5O+YCi3eRJ6uKYDCiGvvFSK6U2wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1e2EOXZRFQIUiDiBc17zdwwcosf80JdRmZ69uGSbKIMRX8CmobjO1A73+lYWq9Ew
	 W6ipTJxDtN3ahalU4aoYS9y9RmMTwV6s7+Vn//hQYQsgy3awzSpaMGKv2Ozyh6wguo
	 wTdXFRhTv2KCrqLweChn7drs5g3cDa4aMM4dBIVxqKHcGJc+t2suObQht20ACEsyEJ
	 2mbBaTQLmP/SkWQkg7ZvBN5FwUfViJB+jvigPJaCSuUKRHul6bbk1mEmfsyhtCVI07
	 Ixjq7CQA/Al/LGO2PBl5AF30Q8FBNlTgGxG2mcA7LOsSUwLTsSEIlud6WRAvJg5R28
	 UGdsM5kG0lyww==
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
Subject: [PATCH v3 07/10] perf symbol: Set binary type for JIT map DSOs
Date: Sun, 11 Oct 2026 22:25:58 -0700
Message-ID: <20261012052601.13920-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012052601.13920-1-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf-<pid>.map files contain symbol name of JIT functions.
As they don't have the binary data (instructions) no need to try
for dso_data.  Let's set the binary type regardless of the result
of symbol loading so that it can be ignored.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a7afecb5816c25f8..4a8c298039447cec 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1847,6 +1847,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 	if (perfmap) {
 		ret = dso__load_perf_map(map_path, dso);
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__JAVA_JIT);
 		dso__set_symtab_type(dso, ret > 0
 				? DSO_BINARY_TYPE__JAVA_JIT
 				: DSO_BINARY_TYPE__NOT_FOUND);
-- 
2.55.0

