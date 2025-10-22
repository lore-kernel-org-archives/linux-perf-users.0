Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D41F09A3
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129542; cv=none; b=tzyGuH8cjYu/zqNpXCz6Wf1QCpH5ixu9df3xOPF64YQUpUUusctGnrCq+5MqSpP4h1tqmEufeuDKFhLwD+KGHV8hKSTVaHVeiy4ADI/CH2qtwLHfmAz2ngvLTk0dvAkdtykWk41JtwdQn+VT35BmJx8AT00cjHF82DB1DHUKoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129542; c=relaxed/simple;
	bh=fH2qE4z2R9nG6ICsDw88KbQ2BeHjA6h90I3Uf4mFaho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wx2MJDGPH3rIWSHcwd2o5H7vDXdCjb5yvaf/aunA6HgjYcrHJx+ytLc3UgAXKtMETy7xBcZB7sojmfuNraPytYYHcrYDDT0zfl8CtryFhvaN/+bkGUv4wefWImfshrOreZ35X+7HScYVWpv/jwG115Zh7E49h5kOmQn3IYLuR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3ufqTr8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jmVxpWK9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oLt37Wwy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ySFGeMdm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3ufqTr8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jmVxpWK9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oLt37Wwy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ySFGeMdm"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1C7372116F;
	Wed, 22 Oct 2025 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761129535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EkHE8TZpCym2hPkSeXljdO60kEKl/a+V0MkzQJl2IWA=;
	b=B3ufqTr885uBzTtazvNrefAS6mguBlLMXpSaLq7Q/jqQCQ2j9g8aw4oMG+oj7EzOBeBOxx
	LS1yvIyi7rHXRpFmC/TEcPW52dmHdGNNvZzfaY+QlLcJ2QahiUoJ31w18C49XO4YH+w5J0
	4Z5OaKtkPMgjdhENf9kszABZCQHf80s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761129535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EkHE8TZpCym2hPkSeXljdO60kEKl/a+V0MkzQJl2IWA=;
	b=jmVxpWK9eW7SJSNVzFbVxLAKnS5rQoMFuM0PW8rwFj5Bfpwmei/ppwA/4dQCLufI+3gvKx
	wpp9ORgyBKu+QHAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761129531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EkHE8TZpCym2hPkSeXljdO60kEKl/a+V0MkzQJl2IWA=;
	b=oLt37Wwy+7TvWa9w/NJEtvI0NwYtANlzJockTzEG5WSwrMCYWM9yazxvOXhpoK56bVeU+A
	RtZz2DYuT2V5J9iI5Utz0JIhI5fNeeYbjH2ka+BmCsLb5AtD7d2G1hACue3f4ufyL/VtTq
	+l70afvghy50TLqEtZ7B5+VXKsD9cR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761129531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EkHE8TZpCym2hPkSeXljdO60kEKl/a+V0MkzQJl2IWA=;
	b=ySFGeMdmJcW2m4iU6oMRbfI23ITFdvrBytvO+lVHe7RF+GETuUUeejWrYvb7GO4eNnAFKg
	vj8cJeaFapvTdMCQ==
From: Michal Suchanek <msuchanek@suse.de>
To: linux-perf-users@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Tony Jones <tonyj@suse.de>
Subject: [PATCH] perf hwmon_pmu: Fix uninitialized variable warning
Date: Wed, 22 Oct 2025 12:38:35 +0200
Message-ID: <20251022103839.19550-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The line_len is only set on success. Check the return value instead.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/perf/util/hwmon_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 416dfea9ffff..5c27256a220a 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -742,8 +742,7 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 			continue;
 		}
 		io__init(&io, name_fd, buf2, sizeof(buf2));
-		io__getline(&io, &line, &line_len);
-		if (line_len > 0 && line[line_len - 1] == '\n')
+		if (io__getline(&io, &line, &line_len) > 0 && line[line_len - 1] == '\n')
 			line[line_len - 1] = '\0';
 		hwmon_pmu__new(pmus, buf, class_hwmon_ent->d_name, line);
 		close(name_fd);
-- 
2.51.0

