Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557491F954
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 04:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649432; cv=none; b=hWhVzzClu8DJQRO8oyMT8ztt9b/nSqW1N1OfwXU0f6q0vo4habQxp1pwbFPFT2QMxXdI12sjr99eTnl838jLNorpr+7YCUNc8abX44j4vUuF79Lt6+6Q2MohtWTwiQ1yES2NI5mLCxniYLt8molya+IIZ4WYGFbdmefvKZPqfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649432; c=relaxed/simple;
	bh=US+QMTUc3wd/lRECrzRRq/Jrw2igRhAZggK2xtNfDeY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=P+1D0CGRQAcr7eQbB7i4/wcguAc25zKTF6IE67IIknc7pbufCYKv7COPYn8P7uuLesQj5H36UxMfijccXabawQ2TBtQ6Y85I5HITeLQtGd5E5zcokUZpjiUiuegZ6CO4ZBFhylOWtAz+9ulHpvPHkkh9hIg9ZlLKz5DIRiqQYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmimBJ7f; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmimBJ7f"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627eb3fb46cso8576377b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jun 2024 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717649429; x=1718254229; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sU/hwIG64bV5IWEExdmUt3ZFDG1ToaRtz2uIVfkz1z8=;
        b=wmimBJ7fLk5+f1TRLT+Lo+L18enf0LdIMzDnAOu0l0KOdsIYGFD7Ri4TTe+HMD1gGp
         IRDrtzp4m+77BczAgZg5Cl9EM7EfIankbNEdQBmDHnbJ1maCM1dk8klE2XJiRWsaFa8E
         mSynZjTse3NBZ+5+MCjekBed/yDMpbxN8ifpa57u8uZKWZG7CPvBdW08xbjuB5hKTR6k
         dVGcILF3nEgFc1HeffEFpKyB7rxvJ87e2M2o3nFn4froxee2VeMrMMJq+HNpMwdtP/9c
         abgthRPK1dCvFD3iitDEAU1jNJXL6BREya58PUtDjBEAggXgbDJ41qYBJ7P58L0k12iN
         1y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717649429; x=1718254229;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sU/hwIG64bV5IWEExdmUt3ZFDG1ToaRtz2uIVfkz1z8=;
        b=PeIcJtLsXRVJu2fcuZOvnyN8eOKo7HdWixTi0dX3FISKRmnNYZe6NTOTw1A1zgpdnK
         ZVVd3IQJvzjYqd2y3UkKgxvCbi717mkJ8QELgDECy/UHqqZ8I4F1aNNTihnTqfMnDPpW
         JGXm6EyTKBKBQQ/x+wxQiMOOCQ3ZpcNYacLvuJfRlbpxy6XvH/dVL7/QIPX77L2aT4yY
         mn5gufDcyczfW81+p0WCwLvKXafS+yZKf6owVzfhb/VJMennjzKuP7amsSFdprA9aN54
         ERfB5kDwXXmhbk2ac3fyFvC3ZSp/2LkHQ5fnegYciM/Ps0YtzPGuBpCMwJjdUQmgltja
         sObQ==
X-Forwarded-Encrypted: i=1; AJvYcCUowlHwaW0ziue9sqY7RR6V7EVHhInxA91T84y6UfXi3A8VdVgS10qrJlbsq4LG5twD0mGrESmL7olxSeO8Xg0xqI7xl3PhawZ4NfwcKSI6YQ==
X-Gm-Message-State: AOJu0YxZbn31Ki/obYvzUgn6s+3C0ZgXbobza9aYrdkInloyrqfcgEDK
	noKWTbEdWesEKVtti0rsbvycxy1+UCYgbFZhYDkGGGvFJlj02t4Uz0nIAoSt44eTx6VTvKahJPw
	7yecD5g==
X-Google-Smtp-Source: AGHT+IFIdAmSjHSPbLuhpCiNynPVxG4bwwIVKPhcB5sVsgFMEOnEMx0c8t1g9bC4Cq84jxLbBT6+FwEIvit+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:86ae:b6a7:27de:e7df])
 (user=irogers job=sendgmr) by 2002:a05:690c:6604:b0:61b:ec22:8666 with SMTP
 id 00721157ae682-62cbb309e50mr12877617b3.0.1717649429253; Wed, 05 Jun 2024
 21:50:29 -0700 (PDT)
Date: Wed,  5 Jun 2024 21:49:59 -0700
Message-Id: <20240606044959.335715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Subject: [RFC PATCH v2] perf Documentation: Describe the PMU naming convention
From: Ian Rogers <irogers@google.com>
To: Randy Dunlap <rdunlap@infradead.org>, Tuan Phan <tuanphan@os.amperecomputing.com>, 
	Robin Murphy <robin.murphy@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

It is an existing convention to use suffixes with PMU names. Try to
capture that convention so that future PMU devices may adhere to it.

The name of the file and date within the file try to follow existing
conventions, particularly sysfs-bus-event_source-devices-events.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
new file mode 100644
index 000000000000..79b268319df1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
@@ -0,0 +1,24 @@
+What: /sys/bus/event_source/devices/<pmu>
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Performance Monitoring Unit (<pmu>)
+
+		Each <pmu> directory, for a PMU device, is a name
+		optionally followed by an underscore and then either a
+		decimal or hexadecimal number. For example, cpu is a
+		PMU name without a suffix as is intel_bts,
+		uncore_imc_0 is a PMU name with a 0 numeric suffix,
+		ddr_pmu_87e1b0000000 is a PMU name with a hex
+		suffix. The hex suffix must be more than two
+		characters long to avoid ambiguity with PMUs like the
+		S390 cpum_cf.
+
+		Tools can treat PMUs with the same name that differ by
+		suffix as instances of the same PMU for the sake of,
+		for example, opening an event. For example, the PMUs
+		uncore_imc_free_running_0 and
+		uncore_imc_free_running_1 have an event data_read;
+		opening the data_read event on a PMU specified as
+		uncore_imc_free_running should be treated as opening
+		the data_read event on PMU uncore_imc_free_running_0
+		and PMU uncore_imc_free_running_1.
-- 
2.45.1.467.gbab1589fc0-goog

