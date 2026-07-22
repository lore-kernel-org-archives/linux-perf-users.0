Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E76345EBF;
	Wed, 22 Jul 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741068; cv=none; b=e958w6a9FVYYeQR6gL9ygTKG/56Mxws3NdM8BC6Anm2mws4PgjrFgwnaAlyvORu3Kv7+j3HPXlEc+z+Kf1pQ30+WS3dcaRy/ZcQgPmH2164N++i+q3sbaLuIiqqstGVDQJvqU1Gw5H6VsoJjnUHXi9kdDO+klL+KEzAQiMyiiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741068; c=relaxed/simple;
	bh=5oB/f5ZN6nIXzfIKW5WWeskRkoyN00cWH3ajY24YuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwTjq806bP/2a1B6ze/wgpgJgSZ4hAxf07WaFzGVvuINWR1XywWEzluvoEE7aJsxqqzurr03YwGWMcWj6D1CrehHMbm8GRoQUpcj/DZRKr2osoXX733L3LY1hVkwqmPnxzTAfL1RpJTBJyIZHjUvh8qOTCQ79yyv3o0vPR5wR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mg3I3O8U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mg3I3O8U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076C11595;
	Wed, 22 Jul 2026 10:24:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D1AC3F66F;
	Wed, 22 Jul 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784741065; bh=5oB/f5ZN6nIXzfIKW5WWeskRkoyN00cWH3ajY24YuCg=;
	h=From:To:Cc:Subject:Date:From;
	b=mg3I3O8UWGl64d/oBvF7JXm1Zu4MC+bLV0oE0Kqo0AEKxxYgEu4UhapRadKwpaaJS
	 rn1iMzlFoRiDD3Gp1jv1nX0TYFpKJVLK3TptrYg94yZUX4Esi7QqZahwHOqo1pqTK/
	 0dDRSEusg3lGtUnKQvC/ZUnv5BKrdhkAiw7wfQHg=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf: Generic hotplug/cpumask for system PMUs
Date: Wed, 22 Jul 2026 18:24:16 +0100
Message-ID: <cover.1784653319.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here's my take on finally trying to clean up the longstanding PMUs vs.
CPU hotplug can of worms. Patch #1 is the thing to look at; patch #2
is included as an example of how it simplifies my "favourite" driver
(in fact arm-cmn actually gets one of the least-negative diffstats on
offer, but it's the one I can test on a box under my desk). I'll save
the remaining bulk-conversion noise for a follow-up if and when.

For simplicity I've framed this around the system PMU use-case, since
consolidating their whole cpumask/migration business is the big win
here, and isn't all that easy to do in separate stages. However, the
design does also allow for any driver to now benefit from implementing
the init_cpu/exit_cpu ops in place of managing their own cpuhp state;
only the automatic filtering and context migration is tied to the new
cpumask-specific scope.

Thanks,
Robin.


Robin Murphy (2):
  perf: Generic hotplug/cpumask for system PMUs
  perf/arm-cmn: Switch to generic cpumask

 drivers/perf/arm-cmn.c     | 96 +++++++++-----------------------------
 include/linux/perf_event.h | 19 ++++++++
 kernel/events/core.c       | 76 ++++++++++++++++++++++++++----
 3 files changed, 108 insertions(+), 83 deletions(-)

-- 
2.54.0.dirty

