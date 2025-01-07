Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A9154C15
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222875; cv=none; b=O2LgyxRWM7PoD5teaw023+iK+5ZbgDaFJsJ5SK5WayR/SAdbpfGaQFQX3OQp0CCuSvIqjwKMyHb/b0UA3bmNfzhFVlVlP/aUe39BBbnXVMvZJj8WBXl4Xic37hh7EvYoyJoKF2M7vowcrebuzgkYoVxCTsNi7Od4hzIWM2SxWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222875; c=relaxed/simple;
	bh=4zCJ3HPcN5gKu/Wsg5mqzz9IqKY+qHjGEO3bpZXvQyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDtvGC5Id4C1VV5qnwzBhg98BN0q48ZjigNsOVtzFD0CzxRyjd4kiCf+O/F4gedj12KB+wuDLfUVzSs3DlwtNoPYQVJFZC2tP2t8VbJNW/xD9uARgBlFMAlYpYqAkOz9x0jDQ+7/GiOChURBIGxdWMXg3l17P6HGqyB19bktQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xZuYrrv1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xZuYrrv1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so40081555ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 20:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736222871; x=1736827671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3WA9RC/J2CdgcwvvfKOzrREm+E/JTqa3o3ODJz2qsc=;
        b=xZuYrrv1rFbVB5sz2ZVH94abPRzxMzgKWSdaEAvBZFp4vD7+oY5lF+WYPCwgyKm07H
         G9da3PLNcj5nS08stwnOtZJPZNAgo4OxMT6wpfVAnFzAhg/m7RfQQFzsUNYWMEcRtgcm
         +hAjTz46vO64FOn6BvzyiQ2n71kqTJXC6VoDze55L3BHR+0cHGz1d8zYXahcqby5Zav+
         Bm6zre8n3DUpf3f0aNNThSRyAcNygzgT4fDuHwcJH56u9KNa3GMOYMyfvuq4NAut9Xrs
         zGWLjKGHKdSX/4oKAYksUT1jhC4xxt2eIv+BlIp/CJu2+DitGO757dmlpsobS6FgmCrD
         iflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736222871; x=1736827671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3WA9RC/J2CdgcwvvfKOzrREm+E/JTqa3o3ODJz2qsc=;
        b=rE7kGbiRd4hskdewGH9+YVvIPvoftnuebYNUhl4+gWoVMHOn9tGQzEnJ5rWfwubkgX
         wGMiYE6i7vcZx9xMf+9L24L7DOTrzU3V+j6aks+RUm1pXS87mUcnC3bq7xoKx7cHuBdc
         LQTICAEwyUH9QtuZ90wnZZ7/oEAbXFrnRvK4AUgSWvNCGweLIeZiGGzAo5/9IOPJkIxL
         ZAl5KVWSEZDbrhz48xuS90MYw2W/kzwIoB1XX7Gw5AwcI4VYjgMWs/TaW8ljQ8lCfGqX
         ltzaSPCtVP1Qmq7iLPs8Zad7gwG1kXdSgZ9PyWLRD65cys52Ki3GUhv7JiRL1bMRTQEv
         cs5w==
X-Gm-Message-State: AOJu0Yyibz3ABlnk5a+KyOhG7H2LgVWl9BJzeL0Ql/Ce+YDW5w5adeyb
	v6N2gGai4TurNh3Q25dyWvUKq/DBWaiVDyjuOEPSTVC87+2yG2kpNONYXMf11Jk=
X-Gm-Gg: ASbGncvl9MPti65NfP3awPqc/3hiLXaJVlLHwvnw+2U9r2Vll7zTTiWZ57kFRgnMa9T
	ZJoCh0CKTG72DnpwYy8ZS8SVGcTahWfdacHE6mwufukI5m/6vjefDndARPTkir9HlYlQ00XPgO/
	rWhKEbmnBBkebkWyOhdJetoD+VpVR1iOGc24wkoeVys/QeYZ0FQ4JCIGnCORWb1Dr+Ny+6A4yce
	pjwqxcEClEjBlyFBZIx1nity7E5htbp09wOfKwD7CoKXYxyt5tDvV8RILBEH1UtW+g62jk0
X-Google-Smtp-Source: AGHT+IF3RRD3VcmkzOx1BljxfoO5FHNKfhr8KfB+1qgv6dppTmsdMS9hABVyJWGIf4ekNScl8j63tQ==
X-Received: by 2002:a05:6a20:e347:b0:1e1:f5a:c027 with SMTP id adf61e73a8af0-1e5e0846a43mr86645071637.43.1736222871140;
        Mon, 06 Jan 2025 20:07:51 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-92587c62eacsm11698726a12.21.2025.01.06.20.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:07:50 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 Jan 2025 20:07:33 -0800
Subject: [PATCH v3 2/3] perf: Document PERF_EVENT_IOC_INC_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-perf_set_event_limit-v3-2-dbde0e90ddde@rivosinc.com>
References: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
In-Reply-To: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=4zCJ3HPcN5gKu/Wsg5mqzz9IqKY+qHjGEO3bpZXvQyU=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rNiokb1G8LvWR8umjpmgkL/4duliueuLTS7PHdGZ/WT
 XawbPp3oqOUhUGMg0FWTJGF51oDc+sd/bKjomUTYOawMoEMYeDiFICJNPUx/DOVe+LtlqHdMsGO
 4e2lsnplv1dm6vv4ilW5J5dOe/cs6ggjw1nvw9rnX/4NKWKrrpcRTN5rrX2rRTtoU76enuHqqtf
 WzAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Introduce PERF_EVENT_IOC_INC_EVENT_LIMIT and explain the differences
between it and PERF_EVENT_IOC_REFRESH.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/design.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index aa8cfeabb7432d4011005f34a981fa3381caab09..1626ae83785a5773c255cc5219c2e9e0525dda19 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -439,6 +439,11 @@ Additionally, non-inherited overflow counters can use
 
 to enable a counter for 'nr' events, after which it gets disabled again.
 
+PERF_EVENT_IOC_REFRESH will increment the event limit by 'nr' and enable the
+event. To increment the event limit without enabling it, use the following:
+
+	ioctl(fd, PERF_EVENT_IOC_INC_EVENT_LIMIT, nr);
+
 A process can enable or disable all the counter groups that are
 attached to it, using prctl:
 

-- 
2.34.1

