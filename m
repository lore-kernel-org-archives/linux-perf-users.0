Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B222FE15
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333443; cv=none; b=NR7v1kUDcg5RKhS+35UYI7vOJdpxcYZeq9H8A3jBxwWgzCjvZOiTKsSkgGzJ8k7OVbjNZoTgBRwVGRV7fTklgkPpOlW4msCC5EaW5t0OZnZBHD4YQe4dD9rvRvB9IXA6RrsXnQ7qzmHWhxgyYiglT9QVeTBPWLDekuYCfAUf0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333443; c=relaxed/simple;
	bh=ioh+RrOLN+gJV2heq4myKOswgBP4J/2ilyblwg6F7dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uCVkea2+A7iganBxU2FcOi9YPVp0MrOedgycovNtsWmXSevx+OFTjK9D0SovWAAQ5sSSbI/x9PnkmJjvgWb/klIxRMBG6pVf8nsr/Vz6LMid24o/XCGkIGL0++RL0SkG5BSGTJibqXyl6m3iMBRDBG1gY7QLfEampe+hq9aAV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNqXUAAp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNqXUAAp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so1846527f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333439; x=1757938239; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rvTf8Il6f/mqfra/iGYvNWp4kf3icOzgbKsdoIlAr9k=;
        b=fNqXUAApn4ClwGKAeOao1enLjqBWJOKEJFRAAqJuqQAb9nPQg6+P2cPP3QweqC8cDI
         BOYRi09D1KXQ0NmTOZfyTAv4qeCIr3cxisGbeQuCZeZU5vOlR+TAK8PAnX+7/Lv1csDC
         YFJzWFTE9L/GnjmKE0YX/DDqhSVfou5/gq1xOL6bKTdSAmFz+hxmUGZhk1OvJLTdZ9Xz
         6rZWmupHEiHu+0/wlWunnb53Lv/IjwSOLaT0dqtInXnTuIL6+te9iW3AwCnyzQOlq51v
         ILVjUv6E8AXiR8hsgNHS/wgkqKeUyllenbLS8n/zGrCbVPjAsMpNcbFzoW9VTL3GqOaL
         zw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333439; x=1757938239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvTf8Il6f/mqfra/iGYvNWp4kf3icOzgbKsdoIlAr9k=;
        b=tPbs1JIXsOWOq8eOXxwR4Iscz2M/UR9e0nkOIDjiKL0R4xs1wuBIUjHQRdr6XUNxKm
         23JojRuxR+5iIY4iPeW1oySw++krLbvLVr8GgSsKAEnCa8cq8SyeJub+p4PYuT6HsX0n
         B/pCPsvnTQY4hgxrfXnxgKV6/kCbstuC/WQf3q2VotRLfhc5cPXm+9qrB3DUMrScJAn3
         BoAH2z2JHVhs3R4I0uRr4d3Gd2AoPI52mQLrb1QXQiwzEhq+Ra4wJuGM5FZZTTSD97Zo
         j4ud7JG0jVDjWxLF/5MzTOUCXk66966DZvW2MsEKpGKGUW5nImz/UtY369sSHPqVkstm
         D7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyPwOSYMwpzbaamYPKGqgVeDcB3OKNkx3EDX8XsyFJ7DdmeMkxBTx+xuJnkdHfEwb2cxpNf/Tbndb3S99pn/JM@vger.kernel.org
X-Gm-Message-State: AOJu0YwkK4636A47JZqr2+DWEY6CNs4l8ZmfS0JZHF2KOF+tKkOFzT0m
	YkEkZeytOqFvcJlFxEZKD4lrOyF1KuhZgIqGUQaQCU6RicCL9lFM2DnD7iuvhu2Cg6jxr2VEJ7M
	8JMztVFEzJw==
X-Gm-Gg: ASbGncvnDoYxBfc4mWShI1sJeh0LAgd2IMuz0k5pIAO8H3eITDIPm2/d2GK+T9bympJ
	BLPOSchfEkuceX0AzfO5Jk4sL7a9BD7oOwCv9bZ3MVxpcChvFwcDYLLnuQi/CMUr9Jkb3DdJ95/
	tbQJI3Sae1buFzt7JFqGCRaPpelvfSKlkOF/IkB0xttOuEsLxQIpnCBxl71xdl5lVmco6xIxorr
	S1zDR6+y9H//3ikV6q3EYgwHrYyV7h/Y84vT550BjaFuKatX8UiWwq7xjWm9mKKU20fm2p5IxuL
	hwNcIdK5GebOKcAGmGXyHXF2gId6X5VZdBbbfL3jGY0GQFH/JMQbqfG5xTUJcFNVo4iQiZiJWCW
	4WF/pZFb9orOaxIqOxGyRWymzMfOzs/ALPOlH8OLKcg==
X-Google-Smtp-Source: AGHT+IFEyhgsQFK+8cAvwVvaOJyzzhjwcI+1heh5zPX3kbpjk/o0y5jOw3y2xWOVWDMeF85EgycT/A==
X-Received: by 2002:a5d:64c3:0:b0:3d7:618b:293c with SMTP id ffacd0b85a97d-3e641c4d63fmr6143479f8f.16.1757333439535;
        Mon, 08 Sep 2025 05:10:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/4] perf arm-spe: Improve --itrace options
Date: Mon, 08 Sep 2025 13:10:17 +0100
Message-Id: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnHvmgC/x2MSQqAMAwAvyI5G2il1uUr4qFqqhHU0oAI4t+t3
 mYOMzcIRSaBNrsh0snCx55E5xmMi9tnQp6SQ6GKUjWqxtVtJBgoepRAH/Axoam0dqW14+AMpDZ
 E8nz9365/nhfqGFC9ZwAAAA==
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Most people also want all the SPE samples (instructions group), not just
the flagged samples that are put into the various memory groups. These
should have been shown by default but weren't because the default
interval type wasn't supported.

Also when looking at this, it appears that the downsampling was behaving
in a way that would discard samples from one group but not another.
Improve that and the warning messages.

I don't want to put fixes tags on these because it's only changing the
defaults and the behavior, but I don't think the previous behavior was
incorrect necessarily, just copied from tracing techs but not ideal for
SPE.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (4):
      perf arm-spe: Show instruction sample types by default
      perf arm-spe: Downsample all sample types equally
      perf arm-spe: Display --itrace period warnings for all sample types
      perf docs: Update SPE doc to include default instructions group

 tools/perf/Documentation/perf-arm-spe.txt | 14 +++++---
 tools/perf/util/arm-spe.c                 | 53 ++++++++++++++++---------------
 2 files changed, 37 insertions(+), 30 deletions(-)
---
base-commit: 75a7b9d29215c5aa813b9620f3c56817918f9f8c
change-id: 20250908-james-perf-spe-period-4711a566cba4

Best regards,
-- 
James Clark <james.clark@linaro.org>

