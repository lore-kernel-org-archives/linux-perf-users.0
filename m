Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF357FE
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165612; cv=none; b=qKc6rhFQ2v0ZbXhYppNDq9mpTkeEqlslRtvbyH9NVigYolnfx68SuBtoRf++koFkUXrPKD17oZ9tcQEwBh/7BskNU8fOPUC3mrs032J2f+mX7gmsetRnlCh7b5ZE5iWdfvKFd6VKEiBe/WhMbZEctIFEz/lDfEQGBWo8KO5quAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165612; c=relaxed/simple;
	bh=DiQfpMa8lJ3Yy3nDuKHD3YLgV6KdpxbHfUerTaEQnlI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BxlX3L13PdcvaGoXqqL8YZdoHefEUgr/y4r+z/930calj2ZHKkj3YLIUOOSUDxagBtAsnU2frG/oRIxI0MRqlg6QWN0l44eMg1rk62u5X8OpOkiUaZw0hPbzQQxAhocpoaMKD1sC7qRk6RKWCXlB6v+UBqjL+UyvqsZ6IbBEpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wglfz99P; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wglfz99P"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so680897276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165610; x=1709770410; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecAegdmUWetUlYDMpDDdMbez8oRVEzxOZ5mMUPLtCLQ=;
        b=wglfz99Ph503gggCqEWf6l8bg9PHfCGkgPO5b257uWlpqz96sfTVGW7N50UelLjs6x
         PbpTnOkYh7NRkI58nOW87nGfZGxVws+lQ1fgG47FLB/F7BssO8CsBM+B5WTnDK8chhGv
         tgxcylGPPB2hYyqjFGlUl9xYwGjubOsq5gUpOjUDOPdisJZBMdHqFIDq/d/Vq9Gg7aRm
         en0SmQf3Q6QFmkLW3pax5/uFkoPWkwyCScjnL7WexX6WHvJWjnvt2un0hOeDfE1/qs47
         6qwlsX+srBGXHHAWWrFnHM00kflB5/d3YsSTR+XCBFhkQ0eoY1PD4GJvw2bHYi5op4Hk
         CgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165610; x=1709770410;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecAegdmUWetUlYDMpDDdMbez8oRVEzxOZ5mMUPLtCLQ=;
        b=A8zFSeGSyiHsLOCuhOB1ev/kiiZTtv42z/fqMJ3gWd7CrE6ydvkDFa14nyUynh/a93
         eAwvKq+IyHTMrNYoaQnlVMv4Wxd3FHcCkeekr3d955MP4oH3/iEF3ImwwA3myZKKr3oI
         NCpOZqlzcE/inMvSy9xXZh5T5kfxjHchDRwtq+CQJSfjL9y0XYzn6CjvP7rYreANAtOv
         1kjixs6ih/kXclpZ25Nj42BT6tCLE6XRNPWcAJajbmtJRHEYPxLHUeO/7KV4pacmopZN
         W06C5/wPyzIQ8I2m63UI7E9FzN76RzFBp2SLAFzZFwRKjdp2t86cq8Dp6Om70I/7psce
         2U7g==
X-Forwarded-Encrypted: i=1; AJvYcCW/L80LicFcXgb6qRljYZI9G9Jme9JDwUWlzVAJh4PzKxUnuRlenZINCunqQkoODTP4L8fxxqORSFdptWtKzA5P2vyCBw4S3DBJJ/7BzX/0Xw==
X-Gm-Message-State: AOJu0YzssdZ/a5z/fIpNEZuvG8ugfM6aH9u4FCuTSOdzHkj1jwZsSqFk
	sjjxC8B//yywkYH81yv8XS3Ncn3mfSORyVD8Ky/Qig4S/FhmJuLpg4608yGeSYFIoAwKikh+4Mx
	X6RmeJQ==
X-Google-Smtp-Source: AGHT+IG9uKix1jZ1tmh4G8sUS/J72z7l+3YfBXm14IKg6IrAneTpgyesYVQPG0UD7H1A4Kw4BhGTf9aaSILt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:72b:b0:dc7:68b5:4f3d with SMTP id
 l11-20020a056902072b00b00dc768b54f3dmr190345ybt.11.1709165610530; Wed, 28 Feb
 2024 16:13:30 -0800 (PST)
Date: Wed, 28 Feb 2024 16:13:23 -0800
Message-Id: <20240229001325.4157655-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 0/2] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

Ian Rogers (2):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64

 tools/perf/pmu-events/arm64_metrics.py | 163 ++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

