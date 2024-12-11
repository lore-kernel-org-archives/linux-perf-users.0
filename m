Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52A1F2C4D;
	Wed, 11 Dec 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954436; cv=none; b=rPRfjULq8ybiHBCOASAAnoLDITlTYmjg/FkhSs8PW/U0u8Wn5RNGh7HB28IYJq+gHyPjjuqLfH5R7KZIxKvDa18X8+uSu2K36vQjK2eptWOKvO5Q8Ww3l99dgYfgvaMHhfED5sG3qnb7s4CJJTVL38Zwu3vOaPzuMfTtTOkXoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954436; c=relaxed/simple;
	bh=e6fI2ZVl4IzPXnFdTWlY97syscDRQIiFgkHg3JcX4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iE7rHWW024XcEiTEGT3gjtHiQYfjYRozmAFhEPV/neq+xc+I7K5oOGeT2u3CSgzLxueOADUUOf0Z8YnQXOJGFbWBU6roJpnPKHvHsm3MBj3JWWk1nzUNOr7oRO4TWJLupkBf3ffA6GbR+nUXxh59rxy0GqNH4nJ9YzpyxM/kwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu4NIT/W; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu4NIT/W"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso3739045a91.1;
        Wed, 11 Dec 2024 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954434; x=1734559234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=Eu4NIT/WdrSwiRF0EawoU0opIzyCOdLXoHX8Ueq6Vezt2ie9q/qfycMf6Zb5/YUSTk
         +WAJs9uCB2GgsK6F6m2ToFHzOi08IMlWYwRj3GruVKryaygL1Fz2GGs/8H/PdbfhFAct
         ousBZ/jevRnEVjHx4JtKd+4iU09xxF1xpcUMuQK6dKtF0RgCY1x7gWCH/RcQQ/1cMr9L
         qJtqt8VJ5kzkhm26mdE4ZVJRuXyyU9p0CgiIc43+/PMBhKaVzQ8yWrRhWTw5g/FV9Pee
         /RWVvep3qCEtAMnrVxwBmUQrdeN/Pl/titSujswvU4b07qPVQwMieyvkcvzYAdkrNRSn
         HmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954434; x=1734559234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=lYWGZ9yJm08APaRbp1guX5l46kZvrwWxoE3pfkAn8l9bJ4uUFJ05rg4tgx3TSEuO30
         xviVJc1Qxb/ZkKCkBjUrCj2fdT860XHD5lpj7j0aqTcHT38ZFVPbQKZZBjqjvxHf+UYU
         oFGvLHT5R8PPLGPVAba5oa7aa9LNmFFhuuV/cCA2JG78D5dxo9hSrTa1X2TlV/dQT7Tk
         H/D2ndXdvwnwNOnl47cucoMNAcPu4ZldYRvmtB8GpT3n8DLwRMAedXN6xRfNDoOdGf+d
         4mtWI/xkJ/a9vgeNnsJK2qMDnAUHRyQyFLSifGba+fJN94P10GuFC3PHRgP1Rf/dqkcR
         iK9w==
X-Forwarded-Encrypted: i=1; AJvYcCVpGiWbZGeGIyaIm+WkGgXf4qDGjtuHwK0BYf+w/+d4JuBNOy5XRRavU8iRJh/XdWi5/fjCjPJsaIx5TW4=@vger.kernel.org, AJvYcCX8hl04uZVu+QEhnefpmK1jw0e3lESgJ0HQZbNlmHb3+zI1Bv3h5TMTtiMo0zLhyWv4i42xHFVtoG90ejjUxQd22w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+uVRebiiY+bhSsGsZql03RXLeDomaANlhYtwg1pQsLWkqJCA
	aRAFqb7GmX+MEpyh1OFatv3RJVqY5t5yJGgtj+WcBi7jvSmsEsPs
X-Gm-Gg: ASbGncu8q256RaRyBvHuYda5p7D2ZDqdvYR14c2aumsxUmvHenzNjNgDGpyNgOYmzUF
	rUgkKzGvgfvvSQrrGl8j54fJ6DsfPUCFy9gaazypfgjAEgsCgF6asUUNeMGNzvCuslv9XAzj0s4
	Zc9+JobwgptJxKEmFeX4q+yRIy7J+giXzhS5DiqgoIyN1v28Nhfq1T12QQ8pmrDfsoBYTennO1G
	vHspnlfqZhPZpu/yxXjQ9DVVnYpbV6cjhb7OqDCJsopPwcqShNw4D4qFxY5mRmCJjszR81pynXk
	F/XCiwi2nQ==
X-Google-Smtp-Source: AGHT+IERYp4Pl0GlWUBTyplf2m5GLj6yolBx/7piUJgiOxDHy/hDpbKoNNumrhiIOdKte2mO/W3B6A==
X-Received: by 2002:a17:90b:3b4f:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2f127fbeb87mr7298016a91.10.1733954433817;
        Wed, 11 Dec 2024 14:00:33 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:33 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v10 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Wed, 11 Dec 2024 14:00:10 -0800
Message-ID: <20241211220014.931479-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a check in evsel.c that does this:

if (evsel__is_offcpu_event(evsel))
	evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;

This along with:

 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
			      PERF_SAMPLE_CGROUP)

will tell perf_event to collect callchain.

We don't need the callchain from perf_event when collecting off-cpu
samples, because it's prev's callchain, not next's callchain.

   (perf_event)     (task_storage) (needed)
   prev             next
   |                  |
   ---sched_switch---->

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/off_cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..2a4b7f9b2c4c 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 
-- 
2.43.0

