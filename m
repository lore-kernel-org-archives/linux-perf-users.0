Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA761EE7C4;
	Wed, 12 Mar 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811522; cv=none; b=MJtDehpYfqi1yCttK219L84Rq6oTo0E2HzmaD/4byEouwLB2pSv6NpBcXbZ2WDHLEOcgGDqePpkywGrZrwkD8K324arJzW6Rw5j93BDJQyqFRqgRktdNaPhGEabwaguN7+gbE672jjtASaBOQBeGOc286t0Rxze8NXA89H71DYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811522; c=relaxed/simple;
	bh=FqpjcHe3CNU4sPGW1mEVPaLKgjB4A7Q+fc2Jt0OVM1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAGyJFhkndy3poN427x5w9rFvB6imFyFjKcDJrGvP1m0QUgQdkS8x86+DVXCgdMcE2Wg2e2JS5Ha1Jn0EsZVgQSUQZlhIlCHq8hphcbs0fIgqrb+d91qZnc2Ilv/wiuUEk/XmdqSQnpCmaBATnom+bJlSE02fCsMEC9onpuKSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5T+VBTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5T+VBTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1ADC4CEED;
	Wed, 12 Mar 2025 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811521;
	bh=FqpjcHe3CNU4sPGW1mEVPaLKgjB4A7Q+fc2Jt0OVM1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5T+VBTa9gbDAjvjkz5oqtINeHldCrny7fRFIg7OP7NR5RQDPCHdMm7wZCTb6wFlS
	 0h2pq6i2Ije0tzyMzbDS2CNHQNFCUXJMv2p3EtJGoAIg87ad7u5MSB7VxlpbXl5hK0
	 YvBbvb+MWCcD5Qr5SzpCcVJdnzbPPg1IbjYCZm7WpY2EVMx/4OlCIFDmuV+AWfS2tk
	 hKDkQcD2s2YabKWgO5jpxE60WIUY0c4ZS4Hmb181m7KlKb7QkqqW+tVNQMwRlGB6ju
	 J4DEdoofgKFSOUY3rY8ZIQUl+gzUp7UQ+GdB7jZSkTnDKYIpjJ1pluSfLqg0NUuxSu
	 IP3P22JlT1Dmw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/6] perf python: Decrement the refcount of just created event on failure
Date: Wed, 12 Mar 2025 17:31:39 -0300
Message-ID: <20250312203141.285263-5-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To avoid a leak if we have the python object but then something happens
and we need to return the operation, decrement the offset of the newly
created object.

Fixes: 377f698db12150a1 ("perf python: Add struct evsel into struct pyrf_event")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f9491b6699764fbc..31a877a8eb8fbf09 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1012,6 +1012,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		evsel = evlist__event2evsel(evlist, event);
 		if (!evsel) {
+			Py_DECREF(pyevent);
 			Py_INCREF(Py_None);
 			return Py_None;
 		}
@@ -1023,9 +1024,12 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
 
-		if (err)
+		if (err) {
+			Py_DECREF(pyevent);
 			return PyErr_Format(PyExc_OSError,
 					    "perf: can't parse sample, err=%d", err);
+		}
+
 		return pyevent;
 	}
 end:
-- 
2.48.1

