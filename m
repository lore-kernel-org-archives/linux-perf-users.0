Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82048280A5C;
	Thu, 24 Apr 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511096; cv=none; b=qt4jqnhYv05XvtGQl30jRPRd09YdQyl5eXkAZpWWM1YAG4eatGxL3NPyDrQamkLosGr3ELxUBohaegTYTqIeuY/ZuBNus+nXV+nQ3VUJthvUYNYc7dVOJZ3dy2LOPrvNc+d8ELPbnHqJFkLosreu/7bjzkDVPkibGMQlC8Q157E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511096; c=relaxed/simple;
	bh=lGbigt4yXPuc/0KEjUr68E4pZ/LwXWjCGLHBhgq6++c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMLOREcFWyX8M1YXeni+fEcbxeX7wjMCtoKBFO+tEMZSx1u/wZw4cSMa6dJc6E3tS9xkOv89SWFNlP5LFswKju4RbhrS9jiqmk3zxjl67XPi0xZKIHsKzncwd027z3meb+hrwVZhXZ0eUxbsv0+rmuoWq/N8A1RmInadNF9G+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOuE8Iua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOuE8Iua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F27C4CEE3;
	Thu, 24 Apr 2025 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511095;
	bh=lGbigt4yXPuc/0KEjUr68E4pZ/LwXWjCGLHBhgq6++c=;
	h=From:To:Cc:Subject:Date:From;
	b=JOuE8IuavC22Y62ZpZ5IL5mrJMavaJeWracRtZhCRITQ+VEuspPRWAYOiXIp051ZE
	 HkmW8PlVwZpqpPaOhJqJU/hVNBjjOisClg1AyGBMd2orMnFZbtOvsFdG0ztSF6PL32
	 1APA+UJ3ElPBOlCDr/C31aF2vxucPTjaOUctVCflhqZuEisqMPF0OvlFFGua4iX4Qh
	 FjsmhO50qi+duYFy4fodJbSe1zAAJVeaJIv0Z8zdKAaWCW1Kix+xwRLkLjm+y+xU3A
	 6EBxzauk/4mHYA17iEiq3hld8yyauSZER8g5dFtGWZW6o27/GwtM/JWO0KQri8Y9Ci
	 DLmof7WWg0V5w==
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 0/4] perf fixes
Date: Thu, 24 Apr 2025 18:11:24 +0200
Message-ID: <20250424161128.29176-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A few bunch of fixes against perf/core while staring at perf latest changes.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	perf/core

HEAD: 623d84ef5ee7d4cefa546de630fec805e4634335

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      perf: Fix failing inherit_event() doing extra refcount decrement on parent
      perf: Fix irq work dereferencing garbage
      perf: Remove too early and redundant CPU hotplug handling
      perf: Fix confusing aux iteration


 include/linux/cpuhotplug.h |   1 -
 kernel/cpu.c               |   5 ---
 kernel/events/core.c       | 109 ++++++++++++++++++++++++++++-----------------
 3 files changed, 67 insertions(+), 48 deletions(-)
