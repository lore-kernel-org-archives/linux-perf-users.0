Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C51D7E46
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907357; cv=none; b=klYOWz4eW8f8F+nCrrnyTXKJekKe25Lgwgb1xcP8hx1pGk1TkZOWqOCmtF2TCns162iQb8f0cj7OdY46vgHbtgUhNejIldzCnNlxZHmHzSeeUY1UEmYpPfpjk2rU5egtNmZuuUxPbJNtVsWpL/KIRiMKQ8HO2eYIq9a8l8irqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907357; c=relaxed/simple;
	bh=nB6qolEkW1OV7UB5hv4ubcEoCCGO7cmTbJXTfiskK0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSHqF1jtTXMhxATKDOeJ6Y22SoM21kBKwx0lzDeSPf5ZNHkCl+hePFDYVMSxCoHiTs/BLOQA1jchmBOvrWmM5ViRPwFsogDI/5M/ICpX9fWrQqeElCzc8jVrm7qvmT7X4uIiYhzv2tbGLxtWLtULbXgCm0eFKuVUP3CWa74lIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JETgEpM4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JETgEpM4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382610c7116so3319664f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733907354; x=1734512154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNYFBgU80onPgPmOy3VgL9Wo04wi/d0lespX6ZHjY6o=;
        b=JETgEpM4f3P+ZR3L67fy9V8BDeD7tVvRgLm4MQ8PbyElRQtMALQzQyU8ORq5NWIXd3
         Gk3DVCAQHWs/yQaU9quDOymvvsQJQoxCy6exbg9xp9eS38AbXLcIDmmYyCTbwpBz0m7n
         qA3z+DMIr6Ic/43HiiPDy4fcRr9fxgQmHjdUo4Whf/4miIZSX0DGZVWe1Z1cHWPkX+kc
         3h396vSDAtgmBU7vM1tjhb7+MXxjj7c3JDdgHWpZHKEQCusk+XJ7TVollbWPjkvJMQM+
         twDzMD75w+6TIMc8QzAobG99/83ezzDyBUUhUhLN0PIEpgKdCfPZUOQr71VTUh7rFh1j
         OixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907354; x=1734512154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNYFBgU80onPgPmOy3VgL9Wo04wi/d0lespX6ZHjY6o=;
        b=JMhl7pphmBz1Yq3HqmSLTIXU+6HhYW2QloXqnLe/CAf/xTHZRrtRmgAwHKyzJg/veS
         46MzxZKUfS+ScYad6UjbJd8BOsp++CWCSLYKjIe1r9FGLGe3xzV6f858VWDfbawDofP1
         oGe9WPvzyye1UCzpFhEG8HH7o+cCDMyoGBFJPSRS529ieXgvk1P+j2vzSR8gz2x9Y7vJ
         CzjSCTsQq7MOBU5rRsNKGwpLSv5EwZoWwxI9icEIy9RzzBdNa+SNqsSj1ag1Nbua/xM2
         PS7LROvbbvFhqGmk48IaI8qYkK1eOOLzmcUST3FaHBNu/3nLR/HnD3w4/EGUcJtG1WpZ
         ql9A==
X-Gm-Message-State: AOJu0Yw0ZExgMfq//y+i1CsqgbJ7nPD1MqFMPg58AdIy/ztvHP7ocpz1
	ksHnpDyYGgcNSGYxWF932GDAbZTWJJwLuleiMXKCa3u7XCgb2Rtklju/Q2BQf+/VavDC7AXKnEU
	f
X-Gm-Gg: ASbGncsuSsjq0rtzXQC7FMZhSTXWItKDKdFXTvEoS2dhIqPS8nc96IbdlC+XYXIhaA8
	ahVX/nenFTOdYkPpww25iJYfH68eKntgezUz6eNE8bvqoSneM7qPCCZLOtl//RjO6ZAAd6EZwyJ
	XPj+lGciBKnI+1G1TPZQ0lAL2dI3h5BPZgEekUrGZNU0pLik1fA046DkOUK7c/Npp3HPkKfy3ts
	iJQvHL5LnRhUdO0yUr/8pQsmwHBw108vLkBKHAmzMdVylhhYnk+TuI=
X-Google-Smtp-Source: AGHT+IHrmu2DR2E7aQ2oR0iKyyta3/WNVHfEmAFuLJs4FzC35Y1JlcrBeBL7pt9CkfFjARUp/NL0dA==
X-Received: by 2002:a5d:598b:0:b0:385:f560:7911 with SMTP id ffacd0b85a97d-3864ce4aeeemr1437480f8f.10.1733907353849;
        Wed, 11 Dec 2024 00:55:53 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm257204185e9.44.2024.12.11.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:55:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org,
	mhiramat@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dima Kogan <dima@secretsauce.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf probe: Fix uninitialized variable
Date: Wed, 11 Dec 2024 08:55:22 +0000
Message-Id: <20241211085525.519458-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V1:

 * Split into a fixes commit and tidyup
 * Pick up tags

James Clark (2):
  perf probe: Fix uninitialized variable
  perf probe: Rename err label

 tools/perf/util/probe-event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1

