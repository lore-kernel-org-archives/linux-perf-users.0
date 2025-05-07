Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E074B1E63;
	Wed,  7 May 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606276; cv=none; b=g+EZJl3a/cl47TAp2kPaK9DMWVLFthhkxvbhQnsEjAqz0SA7QwYZOW2OeYLKdiskTgfeMijvvwf0hghSah6QCD29/ExOwRtOjLLAoTBRJBjY5yX+BsQevxv9VYhiQSdwbxMFbEPn2UD+ElKo24G1OT9CqVz0RC55w7s+g/zYU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606276; c=relaxed/simple;
	bh=K1bXuCNq92ymrxxKhU8GBp2FS/Yerp+VX6bV8D9y6ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MyZKhpxAAr26EKf/PhlOJd45JxGf18AS0RFdmlgKAhKWOtOqrf3tFM1bEk1vIOgxmrqLoCW3etkWZAH7NEBJwPLXzrcWqXJlz00K4onedEHkftBKp1vcu021BIZCyrvEFT4GrRpfX2T4L0stBbrU2TjhcNImrLV1hhk0zvOGqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Mji8B/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Mji8B/"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so13325655a12.1;
        Wed, 07 May 2025 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746606273; x=1747211073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeSPKvH+WVEgstVbSqgAOmvbvcpZiw2WDpxt7LDDVAM=;
        b=H0Mji8B/1xY9NSlqVbv79bCbXFl55pEk26AY55EaxiYOp7kRM4cEWFHDv9ulN5VrqY
         ngovbFMLBoFcCNRIw0zQEVauLsy6Nxx0mnqbNUxbCiqKUmlpPH/Ck5BZIZwR+9dIu4NA
         r6yrfmx6n+t+CKpLQmRQDkkmq1wIJvyr3d9U9jHhlrUuu+cowhbOoO6XeKYoJilsyrJT
         GczvMgdxcYErqKgnMv9zUscLwgtt+rxy8m+54dmoGBsmoz43Q0ehs6raq+o0LtDvDfh7
         RiCWlfla/0sFF8ILGIBWV7wGAqcmkw6GZ9ght5gpdhU8817dPbVp/Sp6b0wZdQ1ueoq3
         nkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746606273; x=1747211073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeSPKvH+WVEgstVbSqgAOmvbvcpZiw2WDpxt7LDDVAM=;
        b=oVrj7jSqacW9vY7m9r13+mSAuVYuVwq7p+pWoS/k+tIBjqIQJXPiuuhm5XRWN7EA5m
         Jhm9AA4h7VIp7z6hArbjLBGODF03+Y41jJP4OPEqDfJHT4DMIoGoSwDNjaQDOOFo+P78
         lpu8ammJdDNQms1vWhMDGDuInbg3WsS+7LVLbA86C1NP06DjpvJnO1DkBQI1owL+ddze
         FwZRS0qh/j8seXFp5rGU2VraU7oiZsScjcNV8knMaRRyWiqPtp5lgOt29SFLKUvtgV8K
         sPe4OuB/s6FNc4Yc2NjndnfBPsbTPrNBVcdtvms2Y4xZ6wYk/7iZaAIpYJMKsVjb6uKy
         AXng==
X-Forwarded-Encrypted: i=1; AJvYcCVYRGtDB8YCurBcTqGWkHra07bAwQ/ias9dW3UoAM/JMWWuiA/LTmGu+/IkykiS1xFRtrpMIO5dKq6woInOYKsZlA==@vger.kernel.org, AJvYcCWw3e1yWyl0jTQd+yP4UH3piMlaI5ZbJHbQYQE4+cZWg7rEOfnWsL/tKwJ3UQqM3lKDB8+lm0ybW33UXDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iKZ40jJtKU0UmqyvP4RAqIAMZPapLdvJ5w/XIbODkOU0nOue
	GB2a1qpjCPQ0ch8GG9kaoIqW4NV6+2DJVd8HMg2zHumDkIZ8gcMr6rw2uJoXIAWQZA==
X-Gm-Gg: ASbGncssLMjcpu9sEeLW4LIaGTnp/iPc+JvM5mxH+nSOLJGWfgEDn0nQ89yQJnK4iVV
	yFr7iaQbtWNKQP/MXtt2ho93Bd0Y2XA9VZ2Z6AQff7B5ISdeW4WF6snZ0DdvcySp4+8eUuqw6Vv
	cQdbPKiuwWQZPw0A3E9c3UatXgSDDPcWiy+o1/w9CJq3FOmLArbkoEGa2abl5wesJBcDh7xY+Ie
	aQau+7FauL5flqyaADj3fA828KxptsGL50u4ZV94jRfRvefEahYz085pqxYx7y0iC23rZQMnwiV
	v92sttkqWr5qTmpmjM0tY2ywHO2z/ZIe5ucP2R0=
X-Google-Smtp-Source: AGHT+IEz0ehkkfHliEKbCARiajPMz8+n5lQFFMi3ISzajdliDRj4KQwVjekIiFMF25Y5rCc0yRQolg==
X-Received: by 2002:a05:6402:13cf:b0:5e0:9959:83cd with SMTP id 4fb4d7f45d1cf-5fbe9f4888fmr1748076a12.21.1746606273036;
        Wed, 07 May 2025 01:24:33 -0700 (PDT)
Received: from localhost ([87.254.1.131])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5fbf11d9ad2sm805024a12.41.2025.05.07.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:24:32 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf test amd ibs: Fix spelling mistake "Asssuming" -> "Assuming"
Date: Wed,  7 May 2025 09:24:21 +0100
Message-ID: <20250507082421.188848-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake ina pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/arch/x86/tests/amd-ibs-period.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index a198434da9b5..7c77d86f369d 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -896,7 +896,7 @@ static unsigned int get_perf_event_max_sample_rate(void)
 
 	fp = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
 	if (!fp) {
-		pr_debug("Can't open perf_event_max_sample_rate. Asssuming %d\n",
+		pr_debug("Can't open perf_event_max_sample_rate. Assuming %d\n",
 			 max_sample_rate);
 		goto out;
 	}
-- 
2.49.0

