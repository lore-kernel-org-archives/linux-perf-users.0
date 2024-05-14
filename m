Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B81869
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648308; cv=none; b=LjqDSvbd5n6FtmJYxUwy0qQJkFKNDYxD4zP3XlcRiqOx0eWKJC4BThTcHQU9iPfovgaFUL/IH7ekA/tYD/K89yxhKFqgIUDd7kSY5ADLBqtUXPkkZ+bSbCOi1+ZSPb1FoTPyWVz08bGAJHe24NuUKqznJC7o6wsCF+vtScYFw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648308; c=relaxed/simple;
	bh=1aJXaxtR743Y5B2wWmBdyGVJQ50lqnRotVWf2SJQcWE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=pk/poGCSsTqQy9057ucSt675McSMDWEusV5o38TSTFFbsg4Q8pW7ZOd6XmUQh1EPvHCPxJn+mZlxhF6GlkYrqU6NATj1mOuD7MMqeKH5W8EJnqT0638RLmBtfexV4xR16QRmviwnqZyyucJMiWS6hE8ICSa8Daihbo5IeNM4/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY3KfLib; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY3KfLib"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61d21cf3d3bso83781447b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715648305; x=1716253105; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s2sukg1GCI2hJZTn42HZ21UbBfW3BzwbxeWrkeRgvm0=;
        b=oY3KfLib6Fw3cbz0cUIrGb/Y/EUDGhuwXsaakVu2rigI43QgAFzX7Gk/z7U7zlyPUJ
         RonUSWQumII0GCb4U3stbZYgb3T4Y65ayCVzaZRKHZirO3UwjFFc00LbCoKhP6zlKbkU
         +ilH23GIHoqWWNRMvub2nQ5cNsmA8Z6fJc/gyv/D///7H3kb4qLZlmNtsTAtE3Q80kps
         v1j04nsDjfVFxeXowpIsach5aHVUq1Dfj3htKDf3d+eic3VVwz//8RjvypvnRk/qir+0
         RldJIwC9nDr0d97wNP5ys7e1HNvUSuqkVmLmfggSn5CCAshari5WrQZMbziBYXiuS/js
         15HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715648305; x=1716253105;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2sukg1GCI2hJZTn42HZ21UbBfW3BzwbxeWrkeRgvm0=;
        b=bk4PNzlRNfZa1x1oO0kvzICcd1ND2Fox2C5KsNnAGwVlrNwsoq2AAXebs0fnG7AVrj
         TZt9YZRZpw4mZwAP1Ep07BdBp/yrQ0iEFT96mQcUbH62wuipHOU6TvBUpCjXZvmr1js4
         KMz1+vCW+VR+2zCTQhWGR2zwjoYcPz9K4jvt3/Vel/9cFnUL8rVRRyuH4s6t8MzrAXoP
         nRVDnqVczv6k8AfemUbnYde3Va+5eim3Sh4kcCt93vlpevFyF7XlNC1hoqfLbmK7nEq1
         +wGh8QmGQ4wLXFR48QXWmjQQCw88EG57wS5IzH1M0eDdZmIjbFO6We+zC+i5qKq3sYV0
         oMqA==
X-Forwarded-Encrypted: i=1; AJvYcCXtMWNdzN2So89l1g5zvOA3Dedeb2MZx/OmDhaizJi23WwzDeB1ceGrrqR7UmEFR7Pjg3ePkjzVKEWElYFi5A/q26bqV2LiQ8SWjZ+nWyL7jg==
X-Gm-Message-State: AOJu0Yx+HZA2E6PUv+fwXtQshl4hcGiQ4FtFK/H9dZcsglQ0VH91O6VZ
	HJKQlui1eHm/EfLQJjo+Pm9J6WqZZa+yLQT8pM/b7HTpeWtamtRjppN17IwIN5Rua2YU631aDg9
	f3Zy7MQ==
X-Google-Smtp-Source: AGHT+IE3Qo2riARh11Xyb99Kg7W53h01T1aY8FeLCppXhR7pjJUuLClid4ORP2BqinJmJiPrlX4wHcGhjCZ4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a25:8d03:0:b0:de5:1ea2:fc75 with SMTP id
 3f1490d57ef6-dee4f2deb83mr871815276.7.1715648305354; Mon, 13 May 2024
 17:58:25 -0700 (PDT)
Date: Mon, 13 May 2024 17:58:17 -0700
Message-Id: <20240514005817.2902473-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [RFC PATCH v1] perf Documentation: Describe the PMU naming convention
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
---
 .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
new file mode 100644
index 000000000000..3f7e53e82de7
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
+		uncore_imc_free_running_1 have an event data_read,
+		opening the data_read event on a PMU specified as
+		uncore_imc_free_running should be treated as opening
+		the data_read event on PMU uncore_imc_free_running_0
+		and PMU uncore_imc_free_running_1.
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

