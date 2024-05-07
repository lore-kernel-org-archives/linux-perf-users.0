Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243816C44F;
	Tue,  7 May 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091192; cv=none; b=PRfJm8ARf2xNtI7CJRYqoyUyNAOJKMvYM2GogANFVN1fuaVQ1C3yke3d7V/U6xtRnqWXJ3NKHOiFimuAi7wm0d/YkAHQDTi0a2k/zvQusyEYL6F6FrRH7DTraZU+YaZkiwxPpAhaF7vyf0YY0PaWoKvooI8or1+Te9HX6vrSv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091192; c=relaxed/simple;
	bh=S06NhcV6PkCL1/+nSbIG2xok/XosV/+ZGsC6A5MxA5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSmHUILM1cLh5bx2UGGrM0veuz1+KD3vXwW6FGRAlhsHgLA+Z+A8NEeBGLBBs+prLtMqQ4wfbtZvfpyFmuYNfx0f84mv3LAkycaeMSeTN7/FHxXd31EjeUIRhy92Pwg5nQajeuzlhKstiVRJRzTw/4uawHNxFMa/9V7vBsWRMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A76AE1063;
	Tue,  7 May 2024 07:13:21 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBB3B3F6A8;
	Tue,  7 May 2024 07:12:53 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	atrajeev@linux.vnet.ibm.com,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf maps/symbols: Various assert fixes
Date: Tue,  7 May 2024 15:12:04 +0100
Message-Id: <20240507141210.195939-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few different asserts are hit when running perf report on minimal
Arm systems when kcore is used, or the .debug/ info can't be loaded or
/boot isn't mounted etc.

These result in some less common paths being hit for resolving symbols
and things are done in an order that breaks some assumptions. I'm not
sure if we could do something to make the tests pick this up, but maybe
not easily if it would involve mocking the filesystem or even a specific
kernel. I tried a few different variations of --kcore and --vmlinux
arguments but ultimately I could only reproduce these issues by running
on specific kernels and root filesystems.

James Clark (4):
  perf symbols: Remove map from list before updating addresses
  perf maps: Re-use __maps__free_maps_by_name()
  perf symbols: Update kcore map before merging in remaining symbols
  perf symbols: Fix ownership of string in dso__load_vmlinux()

 tools/perf/util/maps.c   | 14 ++++++------
 tools/perf/util/symbol.c | 49 ++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 27 deletions(-)

-- 
2.34.1

