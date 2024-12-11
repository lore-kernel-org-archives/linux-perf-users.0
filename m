Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210E1E9B36
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907359; cv=none; b=YS9Iy+ZwX5IgJB4tRRMafAKp2J09ZEEMx90DX+mRGBBVkDT95eboflKYjT5IJGH7sz1nokigx/hME8oQgdw+ajIaXy15hnakbz4JUehLPcQ/1VlNuWmrh2DbY1+mFboVjdN78RY58mXea0H0VWRPuvCpqi9MAdGt0xAa7htSasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907359; c=relaxed/simple;
	bh=jU2cTye6u+MqjljYXpav0xuajR01RvYb2NHvhER20GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lIsa/Yi09s8Qm2QVEskD/7zfBrbPPPKkFUT7slhuf72m4pdIUhUvdhTVnH7wZgiVhffzIoNWq0GHQgMyW6Gthj0FcYGUlrPRJjdQzHP2Kl9/Dc0Oy3PCSREr7PdSC0XqNL9gOulhgthRBbgzVw233UtGEQE2a4flDLiR3/OtwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJZIZlWN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJZIZlWN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a742481aso55965795e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733907356; x=1734512156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcHQmIuxvuepl+FXqoONmaD12Al+psUsKwLo0YRh2mU=;
        b=NJZIZlWNYqOiSgjbqzuh6QzfZ12zqaWvN3cJoB7mqGcn+6W0KGd0TV9aU69ezJMMMM
         xbC2Zv6ExScE40T5/nIhbi0gVp7qsieXwJF0Gm8gxcdm2eJ9VF8QBL6JqlKKsvmtpCd+
         mwMY6ZTou+gBhH4InjQe+1QDxhfxUNUjxz6sXTtO+7KjK8e5yzkDfykydzi3LojRisI6
         7NDWdRI+t61bY3ZdQOhMqRugKpDQcmV4A0jPpwkwMzeKdHA7B/OD+v61cAqZNcy0a3SX
         tLiOvnbOr4ExCPXNmwRP4rNgeBrCZMMY/pk2euwNNJgkkq1wpSEDRF5HtifdpnDcIRGy
         B8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907356; x=1734512156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcHQmIuxvuepl+FXqoONmaD12Al+psUsKwLo0YRh2mU=;
        b=LVuLin3KBdmIu82I2IBxKile6JfgNgi8cTD8cRG+Sg0eicHjkVjm4JtDV2OP++GpLj
         BsQY5dV4ov4LLVk9pGtwTxK2Gn2zzwCKrtW3M0Ct3kR6sNoWGYFHK8NkkMxQ+n3yslvy
         zJWnAxI5EIDrw23Dzy9fVgDTFgDeJMef/hVeAIEDsyFV7GHKQEg661UCE6qcRl9BIlZG
         gtayV33gVt0knlrxTBf3Jfb33aW0LjhbUT9WoRwXVofikqNa19/03Nto0qmiAElC2g5N
         eWt7wn25AiAonDK1vavHKiGHQgs3x3F484GXKpicn8W02z0xuLn/RiDNoK5P/Hr8Ezb1
         FM7Q==
X-Gm-Message-State: AOJu0YxgrlcKQR+RgVbiynHdSMIavLV04dkSv+Afy0YllgKex8tFbCe6
	JSZspzZ9FAVBjqS15OV68dBEQh7PqOF+Vler5oXchHSamAtuUlv5qFdx4c8V7uF8spKu1DVTK95
	3
X-Gm-Gg: ASbGnct+FGkjaV7FFvBWj05dUMjZGoZcrU48cjItHDvz+pXG9Uj5emnzRW8pnsdU6y8
	bVHndjKLiO9crYmTMu6FuoXyUI5lCtt+wwRD065V19FuZwajL5iOMz7NzEztbpflUGcmiBpRoRx
	vBzfP0ctj1wzMnlFDJhf8i7uWgQ6UV88+D9wk8XHh1vsn+Do9YHuEx+JGPjv/ZLHDIhBqCED3jA
	lnbob5sbsif8QFmNUba/8ljZoV4CbBG17QUrfPgxw1zgoqJayH6Zeg=
X-Google-Smtp-Source: AGHT+IEIfgzMHSJgClgRVEQhxy9voa2z51hrr/ck8y11zNHvU33CoGimomwfzx17Egq7xD4wppeDWA==
X-Received: by 2002:a05:600c:3108:b0:434:f953:eed with SMTP id 5b1f17b1804b1-4361c4406bdmr14985805e9.30.1733907356354;
        Wed, 11 Dec 2024 00:55:56 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm257204185e9.44.2024.12.11.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:55:55 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org,
	mhiramat@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf probe: Fix uninitialized variable
Date: Wed, 11 Dec 2024 08:55:23 +0000
Message-Id: <20241211085525.519458-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211085525.519458-1-james.clark@linaro.org>
References: <20241211085525.519458-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, err is returned uninitialized due to the
removal of "return 0". Initialize err to fix it.

This fixes the following intermittent test failure on release builds:

 $ perf test "testsuite_probe"
 ...
 -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
 Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
 ...

Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
Tested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6d51a4c98ad7..eaa0318e9b87 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 {
 	char *buf = strdup(arg);
 	char *p;
-	int err;
+	int err = 0;
 
 	if (!buf)
 		return -ENOMEM;
-- 
2.34.1

