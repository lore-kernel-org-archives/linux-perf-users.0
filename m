Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FC39733E
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794101; cv=none; b=rvDFfbjDA96lpGT1G2BWTBfNX/DRLVM2M6SrrIOua0nO9X+NNvWADj+GnYnMpT1462nj5/v3alcP2jXzUsYuWjil+iYVhwPRX3sY7B7URetKAGC42OCVmXD3UODzo+Y3dLCYdSDq6k71xigzflhKaNVWmlECtQLin1pDo6nBOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794101; c=relaxed/simple;
	bh=vQXfq0gYmCNESGB8jMRQCwKlrdaoe1rrMyRzxNgZvdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XF8Rffe7G7UfctJAuaJrP41RQX+rRrHwQTh6h0QFd8Pr5Q/kE+kVHiouKLXHEYa5hLUhJAz/W7xNc8ai6PjrxkEubVBVoM3vqWTYewlv4m7cde08U8chpxi87x5GMn7On1gDXEiKgPxFRTGP2FLNbsxWG13XGZ85aeyXIg93uV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPswd+bs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPswd+bs"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe62837baso6106073f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779794098; x=1780398898; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tvNdoKgZb+Yh+wKgqesQHx29EoMvUjDvacbOY8GHhw=;
        b=PPswd+bsmWUeovWDfODZ2kfkYrb2gklvTIvXesEY3iQEellQo2NE4idlOmskQgJo0W
         qKyJQ1XQXEAuZ4GzQI2lEqfEOE6uixPri/IrgWlwB4Jb/mOpXHOhC2nxQsFWiqnHbFyd
         FGqfYnmq9VkrVwrd0EMyxs0mddRf2miAgaGEagYgO8LHjdrLYjFDgGRJM5m/W+/efzKe
         V6U2ElchHJeOJufpygH+aw5pql+bRpmIPWBOF1FCn0Q+C1YOf2oWjYMbUBkKwVKA5bO5
         OokZSjOoSG03Ed3QX7Yy25qU2Q/V/OIdxzA4UHvODsr7KXoI4OvefR3ukS0zpgLonpUo
         aZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794098; x=1780398898;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tvNdoKgZb+Yh+wKgqesQHx29EoMvUjDvacbOY8GHhw=;
        b=AQ2uf0Q1D7f4NPkzz3wOGfsHS8CQSOk7hsKf58+hOqhrK4rEnBEb+EW03SafY6l7H1
         l4IC7TtwwWGvSsidPoVPnIv9Lm+CGJ+LcQgOUfjd+v4RefQgAMFwDbuVLESnTfYohyaC
         ImJuB0GBv5Li1k8a/3lgmAf5onX/a9tXcBt8DpOjt6SSMAJSMTvDf+oFftym8fHLIEtg
         s4gGSRMtFAqOTwzA1NIdLv1S0T5ngvNC4VKESODdh4xYlhcuIwjQF/Cc3XPpTMfvT0Sr
         743kEHd2RVgfumh+zE1LcyqaqMqMVnGSWX8VeiQBJqHidfy0f1sYU3lcT1mB2JmqvKYj
         iUHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DdYnn7hoWVK449ai2RHvS+XLroXq6kSX+4IpojFYAcs1dzR88tNmHaZIjV/NeaoLWpPalQ/1ETq8kOSOOsdsB@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrrxDpVvevhiDdT8GC1ZGLajwmCWMFRsLv5mpngQlpfD2c5BE
	o4tqM8gn4X8yUGbu9wV/7NznNfGcQ8ABlSOL69LYWn0hdlpCizy4Vm2nLFdjXAQVt+0=
X-Gm-Gg: Acq92OFGSIePUPOYGHXCMv9k7yWQVRMQijhcBgqy5rAEpmoz7u5PcPxCMvg1rp7yJ2S
	majEFRZv/Rqt1ceym5J1vDvUX5SmPn9ZPDjFDmkfxZIlO4aF/CBbUooF940uCSw0gHZSTYH9PY3
	96Z5bGL99h4R1VH74MRhe0515cw1Sy8e/73EQliLBJh9GoQ8/C+wQq9K9QJBEJW/7BO6SG7lbfd
	Qme1bF22CCS7mxJVblYois7OTmwzsNMrc6kNjXNdELVTaj1fHRJN0wX9SgQQYKLa0xrg/7UKtFZ
	Bj9E2xjXww+/hgyF3PfCbmaKg8XTaYIgsDzMi86nMKiJtO7SOdQvlyylpnWAX9hMkY0+Xc3+yN8
	cvRUkCamexKaHxITPLWbtj0+VSr3PDO68UzOTdRL+vYt5bG7LA2eluNqEgLlKVG8YzO9XBZKlPa
	YEVdo6hV/N/9xKQB2P1jJpv5nbE6mW70Fh
X-Received: by 2002:a5d:6f18:0:b0:449:acdb:3009 with SMTP id ffacd0b85a97d-45eb38a83bbmr31657204f8f.6.1779794098571;
        Tue, 26 May 2026 04:14:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f598sm35375627f8f.6.2026.05.26.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:14:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf cs-etm: Queue context packets for frontend
Date: Tue, 26 May 2026 12:14:35 +0100
Message-Id: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuAFWoC/x2MzQqDMBAGX0X27IJK49+riIc0frVraZQkFCH47
 l2EucwcJlNEEEQai0wBP4mye5W6LMi9rV/BsqhTUzVtZWrDm/0islN2n3AmTsG6j/iVX3JyZx7
 D0D8tOiykjyNA8/2f5uv6A0zxUuVvAAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Amir Ayupov <aaupov@meta.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Fix thread tracking when decoding Coresight trace and add a new test for
it.

Unfortunately the test has to be added as a separate binary like the
other existing Coresight workloads which needs a bit of makefile
boilerplate. Ideally it would be a builtin Perf test workload, but Perf
has a lot of dependencies and generates a lot of trace when starting up
which makes tracing tests very slow because all that has to be decoded.

Hopefully I can find a generic way to enable Perf events at the
beginning of the workload and then I can migrate everything from
tools/perf/tests/shell/coresight to Perf test workloads, but that will
have to be done as a separate change.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (1):
      perf test cs-etm: Test thread attribution

Leo Yan (1):
      perf cs-etm: Queue context packets for frontend

 tools/perf/tests/shell/coresight/Makefile          |   1 +
 .../shell/coresight/context_switch_loop/.gitignore |   1 +
 .../shell/coresight/context_switch_loop/Makefile   |  29 ++++
 .../context_switch_loop/context_switch_loop.c      |  83 ++++++++++
 .../tests/shell/coresight/context_switch_thread.sh |  48 ++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  18 +-
 tools/perf/util/cs-etm.c                           | 181 +++++++++++++--------
 tools/perf/util/cs-etm.h                           |   5 +-
 8 files changed, 295 insertions(+), 71 deletions(-)
---
base-commit: 09d355618f7ccc27ffc7fc668b2e232872962079
change-id: 20260515-james-cs-context-tracking-fix-754998bae7ed

Best regards,
-- 
James Clark <james.clark@linaro.org>

