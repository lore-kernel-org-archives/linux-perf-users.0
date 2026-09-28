Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662413DA5A7;
	Mon, 28 Sep 2026 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574665; cv=none; b=ONC1ztWnq1xDI40/HWLUpU/Qi1RXIdkn5Al9ELSHYhx9k864M1tfFEfoiqAOrndLAFgQOKghYDq+216oBiDq6iARXBilIAbpcxVaU2lGcOhMsnk2+u8BOX9JiCxiaBK5H33CrUNu35SfYt0WPlU2sZ52BrmC8mFcCRpg/AfPa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574665; c=relaxed/simple;
	bh=LZwhDx+uikbckC2FMiNwDHYLXg6HrD65ANkSuirD+2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB33mKRZVvzdcFsPb1alLtK2RSUTbB07AZwMp7Fwd3akJ7Oybe3VPIuTKOVqRsuML4UFGNVsRZ6Sr+Onn4cnnNWUCb4Jb2p1Raxi3JgGrQuulpB8H/x132wK4IrIGJmvWMSn/ZjcjH0+RygJT60CRqE2Of1eCiwtWv9BNow3WaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxaxUYgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxaxUYgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB25F1F000FF;
	Mon, 28 Sep 2026 05:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574661;
	bh=UtQts/xQkNQlB6qr5GQSzlErJ9SYAgRywq1BsJudLJ0=;
	h=From:To:Cc:Subject:Date;
	b=cxaxUYgGYpz4s/BtRL2C5BCm9mfsmG9nrtYttnVGeJ/UnH+n7U81IKIjkVs69po3q
	 ZL4E/w4rdTAyfXJ0R2g68/UmcfuhO0jNAVIIX2XpNBPORASCAOkQMTn2PqIfe3MJxC
	 Ivmtbt/XaScydYdKYpXUKQFzZVXkTGAe0fziPFAb07XRkG2C/qbs0XlXDA1hphlQSG
	 y1sB24eygCwjaoVqV2D5QTkKI6z9DtK4Fqk4Ee1Yw/6H2+UBgRC4rodknGMTMPe2dk
	 hUKtq8LWBNQ5rEa0scRl3Ynbs/86vf1KFRqwe4j9hrsaAdXMeUUmbNmppnt46XC0G6
	 Y/fgl2Ebb0vOA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 0/8] perf tools: Cleanup dso debug info access
Date: Sun, 27 Sep 2026 22:50:47 -0700
Message-ID: <20260928055055.95144-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a preparation for DSO file access cleanup work.  IIUC DSO
access has three types - symbol table, binary data and debug info.
Those information can be placed separately like stripped binaries and
split debug files.  I've added dbginfo_type to DSO to track location
of debug info like others.

I'm sending this out before it grows too much.  This patchset focuses
on debuginfo open path.  Once it looks good to others, I'll update
other places accessing DWARF info to use this info and cleanup other
file type accesses too.

Thanks,
Namhyung


Namhyung Kim (8):
  perf tools: Add dso->dbginfo_type field
  perf tools: Factor out dso__find_dbginfo_type()
  perf tools: Check system path when check debuginfo
  perf tools: Export dso__get_filename() with type argument
  perf tools: Add dso__put_filename()
  perf tools: Avoid repeated failing search for debuginfo
  perf tools: Looks symbol file first when check debuginfo
  perf tools: Update debuginfo__new() to take DSO

 tools/perf/util/debuginfo.c   | 51 +++++++++------------
 tools/perf/util/debuginfo.h   | 13 +++++-
 tools/perf/util/dso.c         | 86 ++++++++++++++++++++++++++---------
 tools/perf/util/dso.h         | 33 ++++++++++++++
 tools/perf/util/probe-event.c |  4 +-
 5 files changed, 133 insertions(+), 54 deletions(-)

-- 
2.55.0

