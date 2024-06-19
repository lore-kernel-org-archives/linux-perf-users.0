Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472476413;
	Wed, 19 Jun 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829299; cv=none; b=kJ3+a4H/20/iv6o6TLzolAq8R/Og4Xk51fUAsHFWXhrQMQxULdxiRigFER6cUfw7EnOyz6YuQV/iaDVZiVR61nX76bnQYk06IgEENldv26Nqn3HJbrM5npp4yuQ1j2qx7XhDjeneQ8OugO7avRlGS/KjPC/dYCJ1o6CPLaL2l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829299; c=relaxed/simple;
	bh=eoZsWCyz46BwfGOG4rsxhKZ0GxuqzP0HRwkUyqxuPqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bin5T1qMFrmwLosThsiEKkO+abJsJTqzlR6ESEbwpms7bMvaHQWgGt+RPv2PTL8nnvw7XM3mnkh/JBtCqnohksLbGe3blEkKqjSgsy3VAHq5k4EFXe9jHWMuBjTZ+qG2pgSgDjsbQ3B1AR6CTsMb7LZR4v5OD+CsDBWKhNWVBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQaLe2JL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQaLe2JL"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso202640a91.1;
        Wed, 19 Jun 2024 13:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718829298; x=1719434098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DS3cNh/vcalK9KkDVuzjtEYuT0eMhqV0xIlZuHxLSw=;
        b=DQaLe2JLeRRF33MpgD20Ly8wgNUkPC79sCD35mbRo6XOk/EGC8fnTmImunKmlk6O/w
         SLHPFOO/SyAFfecKsye2xBg1rwIGlc3V+WJRIesk1M4j4UmJaKKvZq2bN/qhDHmzv4ZT
         pkSC4FIye6LrFpTKUGaUnxVRH4RcEb5Mee749aBMiK0aXJcCuGkpTO+PxF0IAHWRX8Q7
         bD6hsIeMo2k77q006SH2vxlZH6zAmFrfbK/Xp7MKgSqUDAMP4L7tLB85iR/Cmk6M3F8q
         sp9j2jRNlEBz8O0iQAUF3Tuk1G1lRpY2k4SHP+1b9d+Mrxj7cXhsU7Zxl/6kKPJp90ys
         c0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718829298; x=1719434098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DS3cNh/vcalK9KkDVuzjtEYuT0eMhqV0xIlZuHxLSw=;
        b=RpG4eod0AJQuNPYn+cy73K1ByMPV9ZfhYzOCDeI4XuTNDDfEITKKJjoTx6KT7YA6y/
         xtlRK/GCf2D2jFpj43l0capRkn8CxM174gSou8P0EmwdGf8jszSBgMsQgQdisCAEsPgB
         lsuWA5ymvPMz6+pch2dyhwUec9JJ44u/YOWhXCU/PUvCvcjp5L4xrMJsDEmkXD9einha
         9O8tCUWE/YYX/wPy4PRSTcwsYPwNcfbDAHOmkOrWqoRzxQdq6O7SBQHKFnG3F2fO1X6F
         HpbZKBEFkH7SVAOxSAUx3iXsfvDlyGKbaUrenooRBI6DPPLTLNMq1zb+3nBqIhBSQwHx
         r6iw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZe0htbuutdgJZuM5Zm4thP1deA81p11ida1jKd0F1ksoNvDkNYd6opWEtsqjYaqp3H1rczG74cJU9Tq6iX7vrd6VEkAKLleh9qXaXSnYBo/GYabA9ysiS89UIg87oxCz2fmwCspYDs/+nyk0zw==
X-Gm-Message-State: AOJu0Yxs0VQyp8HaCKk0HIIs4nke2DTy5l7vkUYTKupLHMZn2ziQck2D
	7zFbmpwJ0EQ84yD8wOJV9Ev1yqgM6c82jFNUzkCnRehngVV87D8f
X-Google-Smtp-Source: AGHT+IFeG+EapPWgZ6mTFZ7yoMrOyJtLSgvcivUB6RyRNZ+Et8z7BvAK5o11a1I/QNJNzA7V5Rhh0g==
X-Received: by 2002:a17:90a:e2d7:b0:2c6:edb4:1c96 with SMTP id 98e67ed59e1d1-2c7b5cc6e77mr3870786a91.23.1718829297722;
        Wed, 19 Jun 2024 13:34:57 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5ad1f1csm66188a91.51.2024.06.19.13.34.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jun 2024 13:34:57 -0700 (PDT)
From: yskelg@gmail.com
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: kan.liang@linux.intel.com,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] util: constant -1 with expression of type char
Date: Thu, 20 Jun 2024 05:34:29 +0900
Message-ID: <20240619203428.6330-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This patch resolve following warning.

tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
-1 with expression of type 'char' is always false
 -Werror,-Wtautological-constant-out-of-range-compare
 1620 |                 if (c == -1)
      |                     ~ ^  ~~

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 25857894c047..bc603193c477 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1620,7 +1620,7 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 
 static bool read_until_char(struct io *io, char e)
 {
-	char c;
+	int c;
 
 	do {
 		c = io__get_char(io);
-- 
2.45.2

