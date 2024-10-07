Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA51D54C2;
	Mon,  7 Oct 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310296; cv=none; b=ryesy+CZDJ5oi6TyjLTUteqN9JxVl1ksfa1KhIhgn4Pyg684q9esX3tdeeJGZfOiXSz6/bdCrXy1Z8iXTMpkL3s4cXjPPfgalRy7F1quBjWHTrm6hQQk027jK3gVCOjAJBtACYb7D1JLI49z/Qv9xr6YGIZSIBthdbu7hEdZbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310296; c=relaxed/simple;
	bh=1r0wV3Q70DkvjLucdamGyjYuXE6C/Xto1NOeE80gs98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nVExIgE9+61nkSlnMRwDb3B2Up1aw0HKdz+ZzQVWkYhqF0K6SOvMisai/D5O0Kv/0PsU1bdQm6oZXCgJ433he6ZOVj43NkN2vDz1KcJnkiZ69fEEu16wOmS+AUJrYjJCE4d3R9JFy5Sf8rut4NaJzpJSxNHJFOC83wqjZlwP684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496E2DA7;
	Mon,  7 Oct 2024 07:12:03 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C72A23F64C;
	Mon,  7 Oct 2024 07:11:31 -0700 (PDT)
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
Subject: [PATCH v1 0/3] perf probe: Support long symbol
Date: Mon,  7 Oct 2024 15:11:13 +0100
Message-Id: <20241007141116.882450-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a probe supports event name maximum to a 64-byte length. The
event name comes from the probed symbol name, otherwise, user can
specify an event name.

In the case when user tries to inject a probe for a long symbol, e.g.
mangled symbol name in a C++ program, the kernel buffer cannot
accommodate it if the symbol name is longer than 64 bytes.

On the other hand, this series relies on the perf tool to resolve the
issue. When the tool detects user doesn't specify event name and the
probed symbol is longer than 64 bytes, it will generate a hashed event
name with 64-byte length to avoid failure.


Leo Yan (3):
  perf: Dynamically allocate buffer for event string
  perf probe: Check group string length
  perf probe: Generate hash event for long symbol

 tools/perf/util/probe-event.c | 71 ++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 6 deletions(-)

-- 
2.34.1

