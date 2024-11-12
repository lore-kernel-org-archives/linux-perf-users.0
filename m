Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44420262A
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427270; cv=none; b=AnfYSB0HU+RXYrkTEnkYQKSu93D1yJNKWlqfK3vMrl6Nx57wAGSJs+tBGSohcOkDn9URZ2DPYFuIdKshz+cjE3tecnoQFk5neOP+tWbLJpWDP8HPk7X1EX0HylRFiEeNcHx8f6dWWTtWgsZXfxg5fLnUP5Pn8xarHia69FoodgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427270; c=relaxed/simple;
	bh=UAcGazzCp6/O/W5MzKvdpcujovBvjqAvNrpyKPtJrfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAIhV7TP1WTdDvD9IHsTad+BL6YM3Q9zNCxBmHe2aN2kAO2gCYHsw6nXRP1c0oaWRdGdNIrf6FZ1micMDc6XzVv+PluTAKmi/oHtaxem/6rnrU3fkwq6WUiNhoSIkx3o4uWf+rdQHy/9GaFuZcB65fzUbZGspPc7zjXngBJC8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=smRvCkBx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="smRvCkBx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso2528849a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427267; x=1732032067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOEI8UezSMAVzR/zNgR5LZjC5DnJu/D/ladTewPTC3U=;
        b=smRvCkBx2EbvbhaiGiZ+XqJy/17grEqFfxRI/NJ/FkaShRSsS36QK/46MxON58zCAp
         vlJWru4j5J+voyFyLXTTBjYseI16ThByhl4MVmtrR5r6EgOmbOE2EFH1JwHodfF1qgBI
         rD8BpdWF3x7UNx8ZTMZ9rIM1PRSpAogDvGLJDZYYwxqWxzZDKiyFS/dv7lkg10u1BbEE
         GXPMWNPvQMP6xSIMDkWYEcZZs5g3y5ghaGBbz81l1rwOpKrIl1GZeKYOFEGHijQf8k03
         Us49INxr8jg1lCmReVRIVPUtm4KZPDUwsy1MoX9hnDAXrIRb9KVnW/e9J3fZ1o2L1T+C
         bA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427267; x=1732032067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOEI8UezSMAVzR/zNgR5LZjC5DnJu/D/ladTewPTC3U=;
        b=jgLzrxGbBYMPICrN3zrHvYXgqucY85PvtHVfIKpSGYV3EerddFbEg7kOacIdO+Zhnb
         bzosevBJutqoCcCK7lMfyr1MRT0f33RFRBvmPNzzQn8ymTVTkVyNHciQ+k35OLZAhlZE
         UHWKBayfuCOrzsTOhA8UaMAYtiz5nRWW1COgqbjBxjYXOXnqxzjBtwm37dfKbsfNfKBK
         oRbvjSZMHrrqoYYH65y1zrf+SCcnILDnxN+UlREfShMRoJXf25qvhIZZK88/j+He0K8p
         JGY+I68nkUyV8qiUDorrQMM+D/w18zdbuQ5GwkhbPwzkvG93ISzU3uk9VtvgKLysu/AN
         AlOQ==
X-Gm-Message-State: AOJu0YzLXbWqXgtVLM5E5RPGXlzCA8McUkWK1v1QCnt4mgzsi4NSEoSY
	RONsMKvra1Tv1mZJRSYYbwMWBDqRgDQ2AOual/cABCiTN/DeKlOkij0n5jLn7QwZR2dtrmcmR3s
	Rj9w=
X-Google-Smtp-Source: AGHT+IH+CZ2kdawDB1g8i2yUpqSeBIFmuQev+NUGYW0XZmJCMTwAMWirfE2v1Z0EXkcL3is4/Zg/4A==
X-Received: by 2002:a05:6402:4021:b0:5cf:1214:8146 with SMTP id 4fb4d7f45d1cf-5cf12148226mr17482294a12.4.1731427266960;
        Tue, 12 Nov 2024 08:01:06 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:06 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] perf stat: Fix trailing comma when there is no metric unit
Date: Tue, 12 Nov 2024 16:00:40 +0000
Message-Id: <20241112160048.951213-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit is failing on Arm and I think the fix should stop more
trailing comma issues which keep happening.

The second one I just noticed when looking at it. I don't feel strongly
about it so not sure if we should do it or not, but seems like the empty
metric-units exclusion from the JSON should be consistent if we're going
to have it at all.

Changes since v2:
  * Do more documentation and tidyups around struct outstate

Changes since v1:
  * Don't skip printing when the metric-unit string is empty but pass
    NULL instead of an empty string.

James Clark (5):
  perf stat: Fix trailing comma when there is no metric unit
  perf stat: Also hide metric-units from JSON when event didn't run
  perf stat: Remove empty new_line_metric function
  perf stat: Document and simplify interval timestamps
  perf stat: Document and clarify outstate members

 tools/perf/arch/x86/util/iostat.c             |   4 +
 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 242 ++++++++++--------
 tools/perf/util/stat-shadow.c                 |   5 +-
 4 files changed, 147 insertions(+), 118 deletions(-)

-- 
2.34.1

