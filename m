Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E71D88A4;
	Mon,  7 Oct 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310300; cv=none; b=s840vbLusr3QMDsNQ+KMEFamdz4mn8BKq2jOCtU57eZsa0BCE+I111+SHgZqPgxc8XETjDdnx3trzIZ4vFjKLFw98huD+0MdZDDM9f7tCFYDgaqgyYO3210RnO/XK4EndTs0dUzUFIOTl49RIbGXeDTKCmMhx5LscnA46josWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310300; c=relaxed/simple;
	bh=ephwfqqSwMeRkEkj9idjCl7uv+fLynMsOvLznB9wqsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJbvSKeCLQRLowCZzXt/R4CjhoeRR10TYGkF9rDoWeTSe2atAEmJ7E6642SrjNhnrBFKi7Zp8Isjj+XsYcz7Ci8aNyvlI8tzi1lYPWeaughwsEQU1aJvVbWG9Oq5Cmalr97hr4lTZjxK8e8QxAtKK2VsXI/+8wKI2K1gQ3qfOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A09E4DA7;
	Mon,  7 Oct 2024 07:12:07 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AA233F64C;
	Mon,  7 Oct 2024 07:11:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dima Kogan <dima@secretsauce.net>,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 2/3] perf probe: Check group string length
Date: Mon,  7 Oct 2024 15:11:15 +0100
Message-Id: <20241007141116.882450-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007141116.882450-1-leo.yan@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, the probe group string length is limited up to
MAX_EVENT_NAME_LEN (including the NULL terminator).

Check for this limitation and report an error if it is exceeded.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index cad11d95af4f..71acea07cb46 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2872,6 +2872,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 	else
 		group = PERFPROBE_GROUP;
 
+	if (strlen(group) >= MAX_EVENT_NAME_LEN) {
+		pr_err("Probe group string='%s' is too long (>= %d bytes)\n",
+			group, MAX_EVENT_NAME_LEN);
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	/* Get an unused new event name */
 	ret = get_new_event_name(buf, MAX_EVENT_NAME_LEN, event, namelist,
 				 tev->point.retprobe, allow_suffix);
-- 
2.34.1

