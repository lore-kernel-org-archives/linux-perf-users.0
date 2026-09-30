Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC894DE70B;
	Wed, 30 Sep 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799654; cv=none; b=ICjPvU8ZFiUmP2q9ZxbfpOwT7k+bxcBFWCPhAhaYyfChtpn/kzhLIeSh+okLxCDkyF3fLRUwR3UW4kjwyeMv+Cx3V82AiayMIXanwlIMZW5OcBOnYp/ZH6SdhP9QHlp9KYSu0ZPLPUtCFxYi5O9TzKnpzO+6DOggiCAEnI/fnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799654; c=relaxed/simple;
	bh=mJXb1CYIqK4AsS834i6sof1vL6Jqu8U27uRRKuT4BLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG01DTZDMZbTB1EATzzZoykjFPWtC/ydTY3hWkeC5hZIN9SlVzHBe/9yJ7B1z2EnGA9/xwBq2+L6mbi8ApPApnhleD9RbHRyK9pKi9USA+OymXjpVRPK6MrHmq23F/pLJl7YT1m/m1cX46qwR+jkScSpfpdOKthFGS/N5asn+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoGxCAG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoGxCAG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E221F000FF;
	Wed, 30 Sep 2026 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799653;
	bh=mQynPCgYV0pRF+s8X9xrcuJxLtzPOpczaBeV0jQ1fi8=;
	h=From:To:Cc:Subject:Date;
	b=MoGxCAG9N+AekbTdAmj8troBbe7u+ie0IwfXyRC561iY4ZLq0o1CVbPilgEjo7p/e
	 m55iqq2rr41vwX1ZUgjmwIygCnGbsw7SQDJF+Gv/jdThvSs0rFfpdAAHRJYOT8iv0i
	 /fvDoFnWuOp+1RuqXMruX5mwPMnKdoMnjuAqhGmQwsG7hkW7a6zek15L6qeGKqgkeu
	 /H7tOafW9oiQB95iR+KITf9l2RPAPHAlt1kS3wgXPEjO9BKGyM7gKZqhgWrNjmv8bo
	 nGxbbtlgT2I4CiZE0NG8oztElMHx/r3HmIy5c7mI50ZNgsj5+/+StPB6ahatzGHSP9
	 3C/+/p8iA3BIw==
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] perf/x86/core: Simplify hybrid PMU registration failure path
Date: Wed, 30 Sep 2026 22:20:18 +0200
Message-ID: <20260930202016.111577-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=blum@kernel.org; h=from:subject; bh=mJXb1CYIqK4AsS834i6sof1vL6Jqu8U27uRRKuT4BLw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl78xnCNQ4u+5ZkFXn6XNSvc30Byg+aD+2KnyXE+qfik EndPZGtHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRl9MY/odqP4j94r/i6vc2 LwUj8bjZ5Zo/ukw/Be3W/qsxLfRG7zVGhm+HDiTtmy/y89CUzTzlV9K6tpaG+l98ZzP9duDiQH0 nPk4A
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Handle perf_pmu_register() errors directly instead of breaking out of
the registration loop and checking the index separately. Reuse the loop
index i to unregister any previously registered PMUs in reverse order
and drop the extra index j.

Also log the failing PMU's name and error code.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/x86/events/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9b1a9032e36d..6c7f9c8e3b24 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2714,7 +2714,7 @@ static int __init init_hw_perf_events(void)
 			goto out2;
 	} else {
 		struct x86_hybrid_pmu *hybrid_pmu;
-		int i, j;
+		int i;
 
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
@@ -2725,15 +2725,13 @@ static int __init init_hw_perf_events(void)
 
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
 
