Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965A19EEC2
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324611; cv=none; b=WRTr5fm/PrjGlXIcEwhPBo/S4YmrMWqR+Ju0+LL9lp5kQnWGmg3srQS1cLXSz1xoGav09OFTnCV2RZBPjGwnlqGafdDJl19QtoVnqx0gFRZ8I6Y+92Zc91DVBYQPqFYQwF7h95GMr1WjA/wo/uigZSawNY1dVcFUeZGaAiWbY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324611; c=relaxed/simple;
	bh=bud5DZIB5EzGmbm9dkkepy83Z/P2SEcQwF28qE9sOEg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u6a6SOnExAB8h6Xk0WcLHKkG37iPbEiw83w0WtqTZSfaienzAcWIHvW1WCTpaU6MlsVMb4hdXNVnlscAVtC8KFNU/9FaJJEqYdZ3K2A1BXw2y66EOlhaEy/xJCmyU8S/mUCFvTI/UrKaNy9Mk6Mh8TaRngGCu/7pkG9RTtRsGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRVSexYB; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRVSexYB"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa67fcbb549so819579066b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 00:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736324607; x=1736929407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pkMTTDFwKP3yU8hJ+jaI5iMZbrCfqxxkbM+cdo2IJlw=;
        b=NRVSexYBCqLwOZfjsX+bMa2+7THb9u6rhWDHqAupElk50UmX0URYJ35JIGVi4EplPR
         mFkpyzBTpYMqZxZtGmX+xubRCZmILChKt5PNvBaNNRsoH20HxyUUD896anV8YxcXkbtu
         gf7VwtsmpalL9WLcXTLY5cOAMy043cFIDc1avDLL1wEEXeEOcMlvHZ8JXjVSFk+TJh1T
         O9mt8Lh4dHk4T7CjiTzd6+FrWipvgeCcI88koqFqvRL85qHeK1qiEnqSoil7P4WMGVFg
         7wmmXwo3TQDAKaJbQV2K5OMeELbMap4B4qCNqBzVoPp8VJkbBOOAxHHc7vnv9aqHs9Nk
         ZGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736324607; x=1736929407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkMTTDFwKP3yU8hJ+jaI5iMZbrCfqxxkbM+cdo2IJlw=;
        b=sFlSXZcRFp4CQoSg5G1t/H/o+2OF2h6x1AUmIZh86l1O/SH17lcaPD2FmHZC0OLvEq
         DAth/lKwrkG/1wyR7MHj2GXfge/A4zOiQ4JS3G71lQ/yeg4WCM13b2A7MWn0XTMgUrug
         uHmndubJMV1IBU5fX8U6KXbHUE25D9UDLwMR7cre1gZBB2f4D/7bLE2XvsQeanU3CyeL
         sxj/zSa9BYFwXqSlBz8l/R7sy8eEG1yqov81BIeSSjBNUfBa8T0aTevy1S29CiSwteM0
         dfnmMLJynQNcwYJ+AIDzJ16QC+lN8+Gf4CWEQNsZey8qIDf1kTPecguoIHuK/BeoeQjZ
         oQcQ==
X-Gm-Message-State: AOJu0YzlHYUozyrKT3lq95yRgakwOrx5iJ1mn+Cavm3uEbhKpmFJhzO4
	QjoFfR6hdSEed8dFRqFVX1EO1U0GYPQLhP3jVdRLze9VCG9PSekHmBghViCqgD27FYc6db6d6yN
	a1uCt8A==
X-Google-Smtp-Source: AGHT+IFDRvA1x+oQsEe3ymNB6mO76XeWaRaa6mac42LAcUeUiu88qnTyzVF0KJxn0u5hNgsLHrgJPtvMb/md
X-Received: from ejctj9.prod.google.com ([2002:a17:907:c249:b0:aa9:1ada:381f])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:6e89:b0:aa6:abe2:5cb8
 with SMTP id a640c23a62f3a-ab2ab70bc5fmr135955366b.60.1736324607552; Wed, 08
 Jan 2025 00:23:27 -0800 (PST)
Date: Wed,  8 Jan 2025 09:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <cover.1736321686.git.dvyukov@google.com>
Subject: [PATCH 0/2] perf hist: Fix bogus profiles when filters are enabled
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Dmitry Vyukov (2):
  perf hist: Deduplicate cmp/sort/collapse code
  perf hist: Fix bogus profiles when filters are enabled

 tools/perf/util/hist.c | 115 +++++++++++++++++++----------------------
 tools/perf/util/hist.h |   2 -
 2 files changed, 54 insertions(+), 63 deletions(-)


base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
-- 
2.47.1.613.gc27f4b7a9f-goog

