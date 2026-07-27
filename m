Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECA41F7D1;
	Mon, 27 Jul 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169052; cv=none; b=conGqi5yjJtLAuyTwZt9a6YluWUp02HvcqocfQy257HL8c1VgUT3VHQXB4guL8mNMPnjeWQ7nmzs4hAdrx4gOwB49ew5cARGRONKPKXbQPNiC4xXJhB4tIQWphVLY8mh/4L4SaqSNXd/6yQZixNyhBRFUr6RjXurtQrP/FDawW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169052; c=relaxed/simple;
	bh=ANKgNwbJi794aRCOf/1bolHjmMAYXPGot2UZAo/sUxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU70dxCeXnyXbhrtpUl/ch4kL+Tczwje6R8SpOeZFF6lD93b5BD8ND7JpyEJIPxpQl8Rcl7WWJSUn1v9etRCLwdWe5Onrk74aOxW73sPdIteq9bhmfDLStnv0mU6OlzwHlMh9dqXkaUUOnIQKWty5oJmG39ALmsxDZ7b7Jkw5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ1elZqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ1elZqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF65B1F00A3A;
	Mon, 27 Jul 2026 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169051;
	bh=1HzLKmz9qexP7Tng65zESERxIopU6F/2bLCCio3igmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQ1elZqNy2H6p1975WVJV5tx5IDTxTgMpuePLOdokCXx+ELFpUgy2klPZI4xdBU6l
	 EGrTy/h9R9f+SJqcoUJVGgdxg4WrwQKpXL5Wc1ea8H8/7gFinmA1Jik5B9lRy0SJuB
	 L4CV/+1eSIYkv8B9QrY7hI8DnzS8tGUgWRflpGBd3p1SvMjfRAloHsaJwe8/ZN6FxP
	 6UQO8nYn0RlQSjOUufD46xCiKAHZjWrxx0E+8GDOoWUgsrgYop1U0yE8xsa6qLT6gL
	 2ooXUXO9+k0+PkUV9a48ZwzhYKQx9uJhUrhZsIWiZcFTV+1h0Gxsflpvw4ImmfspCy
	 Esx90iJ+BF0ZA==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 5/5] perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero
Date: Mon, 27 Jul 2026 13:17:05 -0300
Message-ID: <20260727161705.64807-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

arm_spe__alloc_metadata() reads nr_cpu from the auxtrace_info priv
array without validation.  When a crafted perf.data provides nr_cpu=0,
the per_cpu_sz calculation divides by zero:

  per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);

Reject nr_cpu <= 0 early, before the division.  The caller already
treats NULL return with metadata_ver != 1 as a parse failure.

Fixes: e52abceb4b6c2723 ("perf arm-spe: Dump metadata with version 2")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/arm-spe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 552f063f126e6769..401aab529309cbd6 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1605,6 +1605,10 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
 	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
 	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
 
+	/* nr_cpu is used as a divisor below */
+	if (*nr_cpu <= 0)
+		return NULL;
+
 	metadata = calloc(*nr_cpu, sizeof(*metadata));
 	if (!metadata)
 		return NULL;
-- 
2.55.0

