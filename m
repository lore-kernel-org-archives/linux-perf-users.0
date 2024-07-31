Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760516E877;
	Wed, 31 Jul 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470108; cv=none; b=Ih/4Jn4BsseKuBaTKkNtFY/rgKZTESufngqUNnQ4D2v0dQEVha71l2/wPa73Ve76UQ1g9rt5AV/lha3JOu/J09Y/BozTonXvB0++tHVEoLE8oXp3X9v9w2L7HHVJ/fZahLpLy2bPjrYjhE/gw8YbFi6hC04hRig++lSbKZh6Mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470108; c=relaxed/simple;
	bh=Lnh83Kp3wIX0XLYy0d/LYvd2p6g4X2YXSQqo+aqe9pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfNrHZ9gcsxkfSbyFEObyAUob5kxFICbxKg+FWPnZzRg2uuuybR16lyPoOJC+LUYQJNCooQ1MU9P0aDE1rYtlf8kxmrT3y/1KyqKN6dwsj0EtM7Pehska+7oVtmxQvwxe0KVOgeUR9ZSUNUf33tOoLj+h8OzLIFj8CUBlw8Yul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut5PPvTd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut5PPvTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039F2C4AF13;
	Wed, 31 Jul 2024 23:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470107;
	bh=Lnh83Kp3wIX0XLYy0d/LYvd2p6g4X2YXSQqo+aqe9pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ut5PPvTdX1+bkHfb2qiGc4NxK/9+kbJBM7Kpmdw84qq0zqsVFx+am180C6ft3wPQN
	 9No+VSqZynwiaOEAYBhwe9JaRpoLeFz7Ex668t7+dXFv3RyLu3CirAHTKN2LY3OCOj
	 rAYNcjhovZ3jYhNTn1WwX5kAHY58kY6qM7H6LHOZ5Gsnb5fkSTAkBIzs0S2EWA/IXf
	 owTkA/m/gyiU1j+JKXnltybmNrIMw/1HZ3p1JfxtjLqrUmrl7CJJcFflalkWzT22jB
	 o2y/QHvUJwgul5gbyDDWnRDo/ZIoCknzzaKPeEYcJAi1tr+uLFf0zqXQoFTyGMCm2r
	 z1NpyIaEXh2Sw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 2/6] perf mem: Free the allocated sort string
Date: Wed, 31 Jul 2024 16:55:01 -0700
Message-ID: <20240731235505.710436-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731235505.710436-1-namhyung@kernel.org>
References: <20240731235505.710436-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_sort_order() returns either a new string (from strdup) or NULL
but it never gets freed.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 863fcd735dae..93413cfcd585 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -372,6 +372,7 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 		rep_argv[i] = argv[j];
 
 	ret = cmd_report(i, rep_argv);
+	free(new_sort_order);
 	free(rep_argv);
 	return ret;
 }
-- 
2.46.0.rc1.232.g9752f9e123-goog

