Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F05221F2;
	Fri,  4 Sep 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552955; cv=none; b=aimKFstpdKLqgqNQx39hQAdIKb1G6rKoPoUaMeq7dVLk2tNVv3/4RkHwblggRQEUmmzfZxI14xg0Ah6chKJ2WFea9/0dhyd9QcZ+bp28ltkH4qTFa1YdQrAfTI2SZYDHewXXuEX7pCwKF7DBcOXqrCf7Lwi6ZomzV+muzBT/Zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552955; c=relaxed/simple;
	bh=+QaayzHzc/PTmRKobplaOyg9dzfWbNlR/9cZ0Ek7O1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZcmR5jWz3ZhUk22YhhPnXB1iYKjbC3QoexW1eUYpe2N1JU+CvBCpYni4JMFD+rDLMkM3B6jOqF16OE0WPAUumt+RLvx4VADipRapYcTn9OOE3A0/kwL6mmr/H4YLzMlfRODY5ozc/OU42hg8D3h2JZziodmDkx2RyFzYneiU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJk5UdS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJk5UdS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174851F00A3D;
	Fri,  4 Sep 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552951;
	bh=mHan3VoGa8yJBYv7XhRR9dgHhrDeC1dnkOEoq8404Cc=;
	h=From:To:Cc:Subject:Date;
	b=SJk5UdS8cfjHsmdv9/rR78e0788ukGInV194iaw+y0g6bFl89KPdNHXEOiy5P0eht
	 mEmRsm0RSlgxjEoYMrvivknbuMKyxs/JiDT4VFGou0MxCvB54UMHe2N+R/+5ruufsF
	 DVCgdEaRW5RDGzfhde0/EuRHMLaM5O1Ew+k8mUrknHiN+eVf/qk4xHGuksYs41i2wq
	 t/vTlsI+8B/MrC6uuzYH3kplWoYeM1ka3YcyVOQMtblD13LiWl4t7JG4uCn549lkJz
	 LqvEHyaxvFlsKL5iN3aWSRc4OpA6ecnA+AfF8WULNsaHYYNMzy4EkOiYXM9wk3tL5H
	 qAGhU28b85K7A==
From: Thorsten Blum <blum@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/core: Simplify hybrid PMU registration failure path
Date: Fri,  4 Sep 2026 22:13:15 +0200
Message-ID: <20260904201313.271421-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=blum@kernel.org; h=from:subject; bh=+QaayzHzc/PTmRKobplaOyg9dzfWbNlR/9cZ0Ek7O1I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmz1aKuWrPGvDt6WmTn8rlKuSqT7nT3eU3JZ+s6nRd08 926U34sHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRL6yMDId5ffTuPHv61qng yBGPPbM31nnP+Tj/Q3OhaYH2kwQ2r30Mf2WaC7ccOb9SwtZ+RZ3gB2EDLV3m6NVcLodnik1IWrl 9MTcA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Handle perf_pmu_register() errors directly instead of breaking out of
the registration loop and checking the index separately. Reuse the loop
index i to unregister any previously registered PMUs in reverse order
and drop the extra index j.

Also log the failing PMU's name and error code.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/x86/events/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8eb14add44c8..0a8fcfd52ad0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2256,7 +2256,7 @@ static int __init init_hw_perf_events(void)
 			goto out2;
 	} else {
 		struct x86_hybrid_pmu *hybrid_pmu;
-		int i, j;
+		int i;
 
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
@@ -2268,15 +2268,13 @@ static int __init init_hw_perf_events(void)
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
 						(hybrid_pmu->pmu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
-			if (err)
-				break;
-		}
-
-		if (i < x86_pmu.num_hybrid_pmus) {
-			for (j = 0; j < i; j++)
-				perf_pmu_unregister(&x86_pmu.hybrid_pmu[j].pmu);
-			pr_warn("Failed to register hybrid PMUs\n");
-			goto out2;
+			if (err) {
+				while (i--)
+					perf_pmu_unregister(&x86_pmu.hybrid_pmu[i].pmu);
+				pr_warn("Failed to register hybrid PMU %s: %d\n",
+					hybrid_pmu->name, err);
+				goto out2;
+			}
 		}
 	}
 
