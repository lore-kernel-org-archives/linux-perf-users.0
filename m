Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40575C5F8;
	Tue, 23 Jan 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005928; cv=none; b=RdNQrP5RKwKOD5AaZ3oAKhZpWvIuildav0+ZVwjyDXdNRRgQOquAhu2PJSGp0NfksTxxMCcY8XZNJMoqC1sCoB/P85/TuRHtlwiymlBuTMIxf9HH/L0V+7u166Huo3oHZyDx7Zp3w4bhMqfGsPj/yExOQ5yJAjDa0HzP3Jfd1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005928; c=relaxed/simple;
	bh=YGE1daHDtPYZs7zC99WV4cn2vlXjvAdbUjEsLpZJ46U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEAsEZPgSu+VmFxZYdrZcPuZBiQRsvmrmD2GyE/yPk7WBIBgJcxepxxvVQV0Ofg7MAmO1egn4Srsl9WWz/V3ccDbum0JYj6qDEs43TI5ILjRNr/JtJNAuhochVr4LVniGPXzseqdxzi6piHSJeKqKmcSXBU5Ex3K6f/haI5bkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C656E1FB;
	Tue, 23 Jan 2024 02:32:50 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A1643F5A1;
	Tue, 23 Jan 2024 02:32:03 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	will@kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH 0/1] tools: perf: Expose sample ID / stream ID to python scripts
Date: Tue, 23 Jan 2024 10:31:36 +0000
Message-ID: <20240123103137.1890779-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the perf python scripting engine so that the ID and
STREAM_ID are exposed as part of the sample so that they may be
correlated to the corresponding throttle/unthrottle event (for example).

NB: For scripts where perf_db_export_mode = True, this may be a breaking
change depending on how the script is constructed. Each field is passed
to `sample_table` as an argument so any script that is written as:

    def sample_table(db_id, evsel_id, machine_id, ..., cyc_cnt, flags)

will now fail due to the changed number of arguments with:

    TypeError: sample_table() takes 25 positional arguments but 27 were given

Scripts that use:

    def sample_table(*args)

or some variation thereof will not be affected.

When `perf_db_export_mode = False`, the script should be unaffected as
all the arguments are inserted into a dictionary.

The export-to-xxx.py scripts use the (..., *x) form so are not affected.


Ben Gainey (1):
  tools: perf: Expose sample ID / stream ID to python scripts

 tools/perf/Documentation/perf-script-python.txt        | 4 ++--
 tools/perf/util/scripting-engines/trace-event-python.c | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.43.0

