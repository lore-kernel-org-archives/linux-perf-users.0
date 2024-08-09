Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA996194081
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Aug 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197284; cv=none; b=cHgV1u6RaZJIIJRL5IrZQwVzxyUyV++8aNGMTI8rEf6VczJXIoUtiuy+fPnA2M76u9jaPlEyObaO+k9djWiULcBA1jfoKSTr/IV7oc5IuC8u8aZqn0F/uU3sCKBilZdgehP4sGS4yxhznir5v6M+v2bWqj86yAbeSEBWtPVfhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197284; c=relaxed/simple;
	bh=8nN98tpzOxdJLkBol1d2DI55X2A4qjjQjWbNntYK5SI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQNVB8+s6SNiwgjPg2u9dFUWXD1fs06mO+wzLzyGkzbwu5icngkYTtU9mOraepNUKYHJQASRexNd4Q4xCmLdViTofN2GN/zgmYRkyXd2rLd3gGjbYlH1GnZC9fj8sWa5nOx+xeyECwUYZ9PcuVkVjUTND7gOky4hX6+7MFNNfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iH5Ib4GO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iH5Ib4GO"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3687fd09251so971920f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Aug 2024 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723197281; x=1723802081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EU6S757EEvdN3w56oF3eehAgxdHj+bjsMSmHNikXzw=;
        b=iH5Ib4GORwrmjFpi5rQEzwIXrGyfM3tSro1TBRuzalo4YeEBPSEzoEkQBGyH6L9/ly
         YDdBPPwJispvsUDOdtuZf8l7y9xCeWh27B32wKYyoTV9xxDgcJYc+qRw/kju9BH42ET0
         JqZuW1cLOGNXTWyVpZS0pTxqfKi3uru8uwKKQMQERTfWaX0wYgCoGsU+d5AhkJbxyaj3
         M/Xc3a3rr/1pDi/NIB7Px7ing0BURwDtbLSNMNWnJuCg8W25560f0yAc3QSqHdDIyYPr
         uvWWUZ9BNroQTzRM6V22dev/Jdb5bgSQurw6TL3n6dqBWo+bfPvDsPs47f81Kw4DbAfi
         aKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723197281; x=1723802081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EU6S757EEvdN3w56oF3eehAgxdHj+bjsMSmHNikXzw=;
        b=CnuuA7Q62F2DiIYO4sSKRstn4ws2gXfodPINnayXhFYB3KkaNngZ2eanwV5gn/5gxH
         HPrlnGf8W0XuXynrCGb9JJLq1wdFxIZDX+at32GpSJYJPZccNYfjxt6Y1erezNBHJ8RO
         9sNohFrRHorjWUIFQdJizopHPo78/WTzFbLvXHd1vDzMLdWpcnGLQLL7ewMTCULvvOhU
         v46dhQg9nkTau21JFozNagfT26XjE1ZAMgDA+M4CpW55zQlwXHX8qUWwr/WE3fQ7jNYO
         HB3nOtt8gNZFEUmhetYhFFAAgp3QK12Nw2hAxsPBpv6NUQKIEAFCLb8kjbTcRaiT5QZ/
         y8Dg==
X-Gm-Message-State: AOJu0YyqaZoyKl4QwPWr53k5cboTW1g76j66LZhDjJ5fUFOR5x3i/AUU
	+WbUm1CVVObz0Q1phqqDgPolYRnA579fRQtLjhaGrYHYZb1RiOAP3NwQ6n6iwNacJnEyLYbyuVN
	e
X-Google-Smtp-Source: AGHT+IEbbNulu8afLxaQLN8NWyJIZFYrmXQldYKP8toTLqGaJ8C2nI0Wqby7kdrFsbMk5339zxnsKw==
X-Received: by 2002:adf:eac7:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-36d612f11e9mr959936f8f.53.1723197280917;
        Fri, 09 Aug 2024 02:54:40 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2722969fsm4786562f8f.105.2024.08.09.02.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:54:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test trace_btf_enum: Fix shellcheck warning
Date: Fri,  9 Aug 2024 10:54:22 +0100
Message-Id: <20240809095426.3065163-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shellcheck versions < v0.7.2 can't follow this path so add the helper to
fix the following warning:

  In tests/shell/trace_btf_enum.sh line 13:
  . "$(dirname $0)"/lib/probe.sh
  ^--------------------------^ SC1090: Can't follow non-constant source.
  Use a directive to specify location.

Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 7d407b52bea5..5a3b8a5a9b5c 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -10,6 +10,7 @@ non_syscall="timer:hrtimer_init,timer:hrtimer_start"
 
 TESTPROG="perf test -w landlock"
 
+# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 skip_if_no_perf_trace || exit 2
 
-- 
2.34.1

