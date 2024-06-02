Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35092232B;
	Sun,  2 Jun 2024 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370451; cv=none; b=VCm2R3E1oxxcaxKX7an4hKbT5yo2WM0wYzFJvJVqG+/SK6jF2h7UYkeWzdql2fCcFb3Hoh8hf1eWKeCDBZdirT8d0UY5uoBJB/rnYt5ImKdtF7DNaW4gUsQ3O6DC2SXa3yaw4Zrm8KkmmLML9qElzraDsitPA6NUA148JkxPgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370451; c=relaxed/simple;
	bh=m2pHOs+8mizs3w/BcsgtC4LcAv7doMQX/7GNMunWl1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A11zfi2FyRH+Ptpe+Rl7nYNXdqkug9I7Lw1zU2YN1mmuxzmhgN5hw5OwHfI2eFBBFjWgL2/HZAqE4ckp7mY5rsZJXDZN4DxbAt6NOWmEP5Gv/sVLvd5eWcOonj8mWt3PlyFNkYv5i8CmK2aAbippK1q/2PY8DBllEBZzPLolWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amSNSSK4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amSNSSK4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4603237e0so2431845b3a.0;
        Sun, 02 Jun 2024 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717370449; x=1717975249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyDfIrRI6Xr2FPV9NA4UwhKworxEDEXmt1u7Ay0b8XY=;
        b=amSNSSK4Rpg8105r3TiKib1hJ/hE6Y6pCCBuhmPUVWXpV1P/o9jy3WKbbpCKMFUeFl
         yeW6TsysWKAvo+socz+dZaFJRXFLodhKKYGOwhcOvQnbWYfkuci9KsE/TZc46hyfMcCE
         DtV1LZllgUOVCqd8262cw3WCnZ2ODURhQ5VZH1ckZMJHBSEjVi/fIyDUvhJRP6/Z92cp
         /d12hJLbMROYq7MCrNuNiBNIAz7zNgpYRTCnduZPKxwIByIeNXab2lycA2qJSVppJCbb
         W8lSo/gE8a8lN36ep1osQ6u0Rfjnu8gQaCNcK2I5f25by5hDPm0Tg2xDeuJg0O9XXFWP
         62Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370449; x=1717975249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyDfIrRI6Xr2FPV9NA4UwhKworxEDEXmt1u7Ay0b8XY=;
        b=Or5RRQ7g2h2oPAmJIGSxbJXEfilhUxJlw3B8u7JdjDOcBCYzRdIGO72+sImmjJNR8R
         KHy/rSa3hJDl+ZMIlGoshc2eq0LY+xnSfA4+G9+C02Xf9TVBjzQ6nZ2rkzqOXf3jVAEt
         JJt93/9TeI4VRDH/mjKZmjuAaA0H9sOCDTuPc0+nEM6NKF73UuNjjMbiS5XMrb9cZqpB
         DCc3+Iz72xPq3eBEu6leQ6w/d0ihb50MqyOJOaJVRHtW0D9MeJY3zjEX11oCpogChewG
         iLEqU5b6px4B2j5EO3IUx3Wx11GmGXi6j7mGkbFRIjvxZneaVBHld927ldR9d9F/mmcY
         XU1A==
X-Forwarded-Encrypted: i=1; AJvYcCX1F/MRdpFwP57O7AAxsPdoIPMHKk8tVvefioWfYNl9GU5g5TOsuJmGO+gUh3u2obt6VJEQeuRe+hveI4ZYLaB/wLEbKKstsMbOXI3hhYR4UtzQb+g4b18RKhV5R9aCT1m0Cch9CZGeTMYcpk5FBQ==
X-Gm-Message-State: AOJu0YxPQ+0fE71OIhqK5xQ80aorHkKvWdQ6r1e5rcYY2m8M6BHtv17n
	RA3C1y/diDKcbcYUKVSsGeaUAdAtchDnV3e1mu3P0dDCw+ZiUw58
X-Google-Smtp-Source: AGHT+IFJq5LYRcUEEjxAMk6PVmWi+a4oSEIgOthgjSU4iDbv/4r9AFwvWlJKA7pAof2aT+oWuPqi+Q==
X-Received: by 2002:a05:6a00:2e08:b0:702:3c08:826a with SMTP id d2e1a72fcca58-702457ab678mr11180557b3a.11.1717370449066;
        Sun, 02 Jun 2024 16:20:49 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:a70f:559b:bc7c:dcd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c4d3a52b65sm3660907a12.87.2024.06.02.16.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:20:48 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
X-Google-Original-From: Namhyung Kim <namhyung@google.com>
To: weilin.wang@intel.com
Cc: namhyung@google.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v10 8/8] perf test: Add test for Intel TPEBS counting mode
Date: Sun,  2 Jun 2024 16:20:31 -0700
Message-ID: <20240602232041.1730256-1-namhyung@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529064327.4080674-9-weilin.wang@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: namhyung@google.com

On Wed, 29 May 2024 02:43:24 -0400 weilin.wang@intel.com wrote:

> From: Weilin Wang <weilin.wang@intel.com>
> 
> Intel TPEBS sampling mode is supported through perf record. The counting mode
> code uses perf record to capture retire_latency value and use it in metric
> calculation. This test checks the counting mode code.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> 
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> new file mode 100755
> index 000000000000..43f75055fee4
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set e
> +err=0
> +
> +# Use this event for testing because it should exist in all platforms
> +e=cache-misses:R
> +
> +# Without this cmd option, default value or zero is returned
> +echo "Testing without --enable-tpebs-recording"
> +result=$(perf stat -e "$e" true 2>&1)
> +[[ "$result" =~ "$e" ]] || exit 1
> +
> +# In platforms that do not support TPEBS, it should execute without error.
> +echo "Testing with --enable-tpebs-recording"
> +result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
> +[[ "$result" =~ "perf record" && "$result" =~ "$e" ]] || exit 1

I got these build errors:

Thanks,
Namhyung

---

  TEST    tests/shell/test_stat_intel_tpebs.sh.shellcheck_log

In tests/shell/test_stat_intel_tpebs.sh line 6:
err=0
^-^ SC2034 (warning): err appears unused. Verify use (or export if used externally).


In tests/shell/test_stat_intel_tpebs.sh line 14:
[[ "$result" =~ "$e" ]] || exit 1
                ^--^ SC2076 (warning): Remove quotes from right-hand side of =~ to match as a regex rather than literally.


In tests/shell/test_stat_intel_tpebs.sh line 19:
[[ "$result" =~ "perf record" && "$result" =~ "$e" ]] || exit 1
                                              ^--^ SC2076 (warning): Remove quotes from right-hand side of =~ to match as a regex rather than literally.

For more information:
  https://www.shellcheck.net/wiki/SC2034 -- err appears unused. Verify use (o...
  https://www.shellcheck.net/wiki/SC2076 -- Remove quotes from right-hand sid...
make[4]: *** [tests/Build:91: tests/shell/test_stat_intel_tpebs.sh.shellcheck_log] Error 1


