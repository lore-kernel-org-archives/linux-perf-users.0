Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3A3D96A;
	Sat, 12 Oct 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747881; cv=none; b=Uw+JVR/w1/F2opxmTmODrt77XhcOMZck+1kvQTzn1yKpk71MRgFK6yIEH8m1Yt7rxVZa0jjLavmqLKRgNB7jYdY53f7AWmKIKm49E9jDzUdvSMsOvRXzdRFOiECcpOZUKMtJl+7IFMSANUtGmjzvNufgODVT3+J3tdZhIJTT+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747881; c=relaxed/simple;
	bh=GvEG6pNIjU8VsVChUPijBr4l4luht3AhCzaXUGL9IMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qihMO+qHZHXW3wi4ZAEu1RAVCmbPjn1luwoTzFprPUU+x9wJxPiqupDXcPwiDsxHiib954IaAc92jIXxVoBI9cJvpB/x+PGUuFxox3mKLaHOa5SfaGYfOcfaFvQEClwhipODb89LJ+XlcvGayqv+9kEk46XPbvCBgiqfCJNm3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0EF8DA7;
	Sat, 12 Oct 2024 08:45:07 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DB5E3F58B;
	Sat, 12 Oct 2024 08:44:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/3] perf probe: Improve logs for long name string
Date: Sat, 12 Oct 2024 16:44:25 +0100
Message-Id: <20241012154428.888373-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series [1] tries to use hashed symbol names for event names. This
can avoid failures due to long symbol names. Somehow, it is preferred to
specify a distinct event name when adding a probe.

This series follows up on the comment to improve the logs for long group
and event strings.

[1] https://lore.kernel.org/linux-perf-users/20241010234818.ab279974ef597f02b61ab850@kernel.org/T/

Changes from v1:
- Used a patch to add MAX_EVENT_NAME_LEN macro.
- Refined log for long event name failure to replace hashed event name
  (Masami).


Leo Yan (3):
  perf probe: Use the MAX_EVENT_NAME_LEN macro
  perf probe: Check group string length
  perf probe: Improve log for long event name failure

 tools/perf/util/probe-event.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

