Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989651714D7;
	Wed,  5 Mar 2025 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141934; cv=none; b=g2hqOIISrHpLPgSfNnUTQwW9qeSRskHFyadjcZBnix0ZDOU3ZEH9RGcLvU2955L/v2XFOLTT/MWuqOrLGbm3268LkrKRFrnBvebfL3UhA7efaQSngBO+xsoxURGr0CAAZUMEVE9zN8y4VctjFHheDNl2RkTv6raqDLzbkEhSLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141934; c=relaxed/simple;
	bh=Out9fujKZY7E+2ErtrAbPh7QSx7g7JPdsjq6wS3Hi20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9WGYNRNn/6sCwBFBzRFHHktDFZFybuRA6uAW1WHoHYmV4zElsrK+tB4grITfMCtnUkxenRbO8ibtuLUXCeIFzEmnYjA+hY/ihLru1IPRXLmnxf3F1l1f8XEkXN2UWi8ZykOugHYq9QtOYJ94ZSt6UWXZ915sfi+94+RW2dxSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GpI+iCs/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GpI+iCs/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7K3osJM253do1jAqztfeLAHC00/QWvo53rMx2Ds5h+o=; b=GpI+iCs/qi5aZdI/
	NJ/Es3UzAjMMODjwiCwoyj4e9Ttom0LobF+uQ+W/cG/E0riK2KYM4Od8Uhsb6V7CqG9D9UgyvNaDJ
	iW+xqSVnlf5JwQTE2s7W4xpQd+g6ScdFu22EWc0+nj2HpefTiWUU+4DHtSdW0ReA2SMGib47Mdl/c
	AugC8HphrUTZGnOAW+/suyDb+BJ5/+/bNPtUtEGI77/FZotM77W7h18eStSigV+blhIzfsa9eECLW
	kzUZsQD3V9QFUXQkGtzlofWQs0oDhFmoUqJIrZZ9NacdEyqYr5Jwilz1dedpghSmC7DT2zxD0Ha5r
	02KWr8NEzeVIDmZlnw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXj-002ic7-00;
	Wed, 05 Mar 2025 02:31:31 +0000
From: linux@treblig.org
To: irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/6] perf: Deadcode - the P's
Date: Wed,  5 Mar 2025 02:31:14 +0000
Message-ID: <20250305023120.155420-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is another set of perf deadcode, this is my set
all starting with 'p'.  It was built on top of 
perf-tools-next as of a few days ago (7788ad59d1d9).

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>



Dr. David Alan Gilbert (6):
  perf core: Remove perf_event_attrs and perf_event_refresh
  perf util: Remove unused perf_color_default_config
  perf util: Remove unused pstack__pop
  perf util: Remove unused perf_data__update_dir
  perf util: Remove unused perf_pmus__default_pmu_name
  perf util: Remove unused perf_config__refresh

 include/linux/perf_event.h     | 10 ----------
 kernel/events/core.c           | 24 ------------------------
 tools/perf/util/color.h        |  5 -----
 tools/perf/util/color_config.c | 11 -----------
 tools/perf/util/config.c       |  6 ------
 tools/perf/util/config.h       |  1 -
 tools/perf/util/data.c         | 20 --------------------
 tools/perf/util/data.h         |  1 -
 tools/perf/util/pmus.c         | 29 -----------------------------
 tools/perf/util/pmus.h         |  1 -
 tools/perf/util/pstack.c       | 14 --------------
 tools/perf/util/pstack.h       |  1 -
 12 files changed, 123 deletions(-)

-- 
2.48.1

