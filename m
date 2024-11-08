Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5020DD6B;
	Fri,  8 Nov 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098516; cv=none; b=Nuy6I+aoD9vIWR55nkKFyCbhqLBnHBxgTnwq6Q6RkAqE42HjVhE4/rdWFkz+GSnvH3VBNA6IgkQLPLjtS7jIb5KCFvESLTLhUo6t78biaap56wOeBqBvh38TYuzAapFfW6hHJd2WcyC8AzwDcFXwH2trEl4IV/0VLJkmZinCw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098516; c=relaxed/simple;
	bh=0VqBggAnZ/aVhISlLbqJYsAchqRZWleo8grj8tMqfR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MllxY+H2kdrlTPpSQNR6s5HCHlY2eiHL9rw8TWxYtAk4rhTu5IkYhqIVWA4/XHhZP/ULAhBnAkksefxEX2qkkiaRSHRbgJiHx3IVHmrQt5X87fkUga4CwsVRdbBYtI1uooItrrGsqIP0ANR1fw5roYABKoZkxEzxhqFyDgn42N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlWLEr+q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlWLEr+q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72410cc7be9so1803135b3a.0;
        Fri, 08 Nov 2024 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098515; x=1731703315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZRYkmRoEbjG+5LuN5e7Pt9MK9b3QAXDr4tvqZiKfok=;
        b=mlWLEr+qDFN34JThQzbdd8K1DMJVXkI1w7j2ZeqwzkFZ0K3u2nBsNSpm3n3zpcMBsm
         uLC6Q69uLHJRnZZMaUkwJ0pUpEuA/yreH3yWzrL7vQ+TTYpmn87CAvh0QiGWhG6BfQp5
         6QMSDQqFDLgw0GBwC8urTkqr91Lc2EwZ1C8w3O6tY6qxj/fh26itwB8h3CjmjYrxyyIA
         Df4STQW4rM1p1MDDSsRhZeIfnCnu1Gt0PKQWycG50nYL0moTFcmZntJHLp9U/AInT7TC
         Zq4Z2G/M2V6iScdNhvn23Jg9yhmh1vo48u3EHjNRzwJIxccvQUv9zbKdiJiX5sgH00UX
         zZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098515; x=1731703315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZRYkmRoEbjG+5LuN5e7Pt9MK9b3QAXDr4tvqZiKfok=;
        b=PQN/PNHqXZnYzj9rKJ9kuL6iI3YtJuoYjbdh1p7zWxHh0AwgxdRioSkc8jIJ1rra9F
         4P+XfdZ5y/lvhIfHmbreZhve2ESGbpw0HvSKOlSQQnRYY8dUj8D5+rg9DGxi/UKnyq8F
         tl+4YGgp8mTJ+tYgqnkMILtN7ViO8PtRImqXJI0DKlf9JImT+CbiB1FQ8MDikO0AJZn/
         18Z1kl7AlWM8tWHmTE5BmUYW0cysj7L6KT1rAf7VhoqCibDriBdaJXX/F8gzyKV9C1Rk
         KLjxuah9mBTXt9VLAqN5pfp/Tbt8n2P7y07Yoh9S+id5WIGI+pfA0VKbqEyoz3JsDXR+
         gmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK4JdDwylHNIYWRm8T0LiCrBfqEcKTW6053bA/nUtzVGj02iDJzo4fmZszBZEq84EmMoiqzdbz/118NBO/cB8eug==@vger.kernel.org, AJvYcCWHmI9vvR9NkXD588uA7mtQ2Zyzo/RS5TukzCr3uOf3tlOTXAnguHvyINFFSw8hMssqLl3DIpqG8mMrlQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9tv2GkY55DowfPsTFybGEnD6UOnDL11r5n1k+7BSgjRE6nAk
	N/jjbFcviDatSRD3Hu0iLXAhvaLPbeDXJ28ZPkAKDWzsQ0DPrKv3
X-Google-Smtp-Source: AGHT+IGIa/88RlgSbxAoFHUVQCbqiGmeWER8IHl2X4IZPbUl60XrkyMZRNKtZuiaLqmDhFxZIIlEHQ==
X-Received: by 2002:a05:6a00:1488:b0:71e:6ef2:6c11 with SMTP id d2e1a72fcca58-72413286757mr5883731b3a.9.1731098514740;
        Fri, 08 Nov 2024 12:41:54 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:54 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 07/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Fri,  8 Nov 2024 12:41:34 -0800
Message-ID: <20241108204137.2444151-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
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
---
 tools/perf/util/off_cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index c6edc0f7c40d..f07ab2e36317 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 #define OFFCPU_THRESH 500000ull
-- 
2.43.0

