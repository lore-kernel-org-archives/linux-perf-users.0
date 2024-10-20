Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A4F9D6;
	Sun, 20 Oct 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729390739; cv=none; b=qGxujD5pMjeleScVewU2plKBJu83h4yG3C+ymlta5KfU2+sqVfKpK/6uMeLsW9OjZie+vhi/gIYm2vnklg0aPIpfo4w+vPz8yIqHTBwp2hrI6QVLAj96U/cizjIzW7VJIc4BAH0Qg56onuCoThpJaQyxSg+y4Z3ZBDfdzsy2l24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729390739; c=relaxed/simple;
	bh=uEidP98ywWJq8H0kIhCZAdHTssdP9Yzu6PBq3aq5i3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VydfJ3EzGFirAvMAxBOPeK3iXjiJFvrkDZzdil/AvNYLlsF+IU9dTe0BH9PwIPAc3aJ+U/l5Vkyqerg58ILvFBooJcq8QMrrcplAtvb40xdLaDZzutp2RRnzx4PfsdEFoWqncZrKSRfnWsGJAZ4z+I8jaOzTwLMUqdKb/KW9txQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0l2WMSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0l2WMSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB79C4CED1;
	Sun, 20 Oct 2024 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729390738;
	bh=uEidP98ywWJq8H0kIhCZAdHTssdP9Yzu6PBq3aq5i3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0l2WMShLcDKlorJKmJdAIxypws1qbiTiuWGczY4WRTJ9uGgh2mTThbc6Z18DC0xc
	 xe7QNwhvmN60it9/mwV2I62AvAfevRX43R0CwhycKZdBv5I79GhpgRMl+RsV4Mm/lA
	 apyCVegNY4nScZx60Y95SumxIQZJbLCRiDqEMZL/H3Bg/IhcP2FRueruFcz32/ZNPt
	 qOujwvAuhMQR6UeHr4imwI9PvGcW3eb8JUNnyRV0EB/JCzF0wSnVZ6VrVXUcMOozv7
	 //ZxWZOug7eB67BKKy37O1/uI9gKFc0vb946IY1BIM1M8Xy2fTKa78THxkVgmWBrqD
	 yOKsb+9/t4HLA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 3/3] perf test: Document the -w/--workload option
Date: Sat, 19 Oct 2024 23:18:42 -0300
Message-ID: <20241020021842.1752770-4-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020021842.1752770-1-acme@kernel.org>
References: <20241020021842.1752770-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Wasn't documented so far, mention that it is mostly used in the shell
regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/20241011171449.1362979-4-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-test.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 9acb8d1f658890e9..efcdec528a8f7243 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -48,3 +48,20 @@ OPTIONS
 
 --dso::
 	Specify a DSO for the "Symbols" test.
+
+-w::
+--workload=::
+	Run a built-in workload, to list them use '--list-workloads', current ones include:
+	noploop, thloop, leafloop, sqrtloop, brstack, datasym and landlock.
+
+	Used with the shell script regression tests.
+
+	Some accept an extra parameter:
+
+		seconds: leafloop, noploop, sqrtloop, thloop
+		nrloops: brstack
+
+	The datasym and landlock workloads don't accept any.
+
+--list-workloads::
+	List the available workloads to use with -w/--workload.
-- 
2.46.2

