Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85C37B
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645658; cv=none; b=R+NkTDX0/laXmR/BxYGq10PPHNE6yWDHrB2WLnTLzW5Huk5gTdLioWZhxVxQHzBzonlndFmxB2YBYW4DHCQRWFIvuPq48+wfwlQJ6EuxPZKrhki5l7c4IT60IaQENgZnNyFv2XLneiZiXQSmws6QtVY5TX6wvzehEk3HimqhEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645658; c=relaxed/simple;
	bh=H4Ltz56e0ZLx1rx6NCOIfo5A4T7x+ukzpJ1TsvEhnYg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QoDHj/1hovRpqeiwpdV28bE8BkDfZazSrHw6S6pOPsBDgmbU2i89R8zIsWOHOI5NtKAqn2hY3N//ZEEe0J2EIgsNMzJohUhgjYq+E/9AnuDlFVjlHTD+5SxlUQ6R1tpuV5giEwtnCtlcD+8hoD88LEhrSHSs2axs6Ep1GRKdN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuHvIuxL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuHvIuxL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be3f082b0so86533877b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715645656; x=1716250456; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXc5sMECqLyRKcbNINgEdeLmZDnFaOhVgOI9sZNJ29M=;
        b=uuHvIuxLL8N76Tt0QpsLmYxsHwtcISCMHSivCXZV4oPDdA7BjHzMlW7QRAXk1wlZK5
         GvG0ht0GJ9+i/5E3QGSteaajxAi2mj4hDIS3CkEMYZi0tPE0ClbwMi5c8Nnt4anEOaJw
         eYbXFTQed445y1awjdphB6M25hgw+kBeKSkzSoA5a8ZKz3G8kgh3C/8Un00peAjKN0dQ
         E5iQnpRq5YYPMl6e1Szzo4mCvVuWWkxqVqsTLVI6bx+1rrPXmyFTAI1OolLS/lfBGdEQ
         h3aeCigrO0DvVIjxm/6xCCWWW0/L2aNQ8R0pfS6mRUopwjF+UUZIF0sYHnAPccYBm4V3
         GiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715645656; x=1716250456;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXc5sMECqLyRKcbNINgEdeLmZDnFaOhVgOI9sZNJ29M=;
        b=DKZOQQtRq2Ft7CPBkNR8mr43yHLwPY9BK8UV0g4PGemfHNFM94ksarEZGhXPjJNt7y
         2KGofQPd6iqH0qkTxA28+wuAeHYgcbsk4ldPRXCVWvYhGKVjnXjudT6Q7vswU5FbdVKW
         hXlsbyW05uNvq5IYUU9ihe99cRh1zQ3H05ktRoPzerZjHVeSCIcQhIa8TZbvzBEMbRvG
         AlqiirfPbkD8PTZb5bvQHiDLa4DYC5R/0Er3Ggd4EBHkl159HnM2gfSruRqvjNx/KgsT
         NMUVVgLcqIOb3sv8q3QDCbhFpSTy/t1Dal8ZOjLGmOMV5xxIGJ55iSH1EmUWBwwBrSrK
         lnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3uFztXHeuYWuwf+vjlitCA6FH9VepTbxbAwoBaT9gHdDIVF5euqytaXZ6+2NvnVNQ6lK1iaRK03AM2PDSzPwrYSrIthgYa4nf3RZefOAhqA==
X-Gm-Message-State: AOJu0YzK0PJZ01p5oeZ8m9A9g6xl5v/jy1EHEPywO8Cs9Utav4qPQhx5
	xH2P8+R+jB3FzamKXb+9QABZI+NyejtTWSDEFo9sO+IKf+kay3AZb9VOuHQH5WDF8SiFAwwaZH/
	pm8ioQg==
X-Google-Smtp-Source: AGHT+IHLSIDckp9FGiCB9B8xou3caJHCrjo8tS2qOskoEoK80K8YTo7bIXEOr/HFvihvKqshyWnhvYko00uX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:690c:4507:b0:61b:3b02:6901 with SMTP
 id 00721157ae682-622b001dd60mr27773957b3.9.1715645655981; Mon, 13 May 2024
 17:14:15 -0700 (PDT)
Date: Mon, 13 May 2024 17:13:57 -0700
Message-Id: <20240514001359.2882951-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v4 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address
suffix. Current PMU sorting/merging code assumes uncore PMU names
start with uncore_ and have a decimal suffix. Add support for
hexadecimal suffixes and add tests.

v4. Workaround GCC build error by using unsigned types. Don't consider
    short hex suffixes as suffixes (e.g. cpum_cf) and test this
    behavior.
v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 17 ++++----
 tools/perf/util/pmus.c | 67 ++++++++++++++++------------
 tools/perf/util/pmus.h |  7 ++-
 4 files changed, 152 insertions(+), 38 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog

