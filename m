Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C61C5F30
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Jun 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276795; cv=none; b=W9k1R2wpzyCPXEE4G9Z3bt2mfj/OKAbtFNRT5EOR4WImZMSKVeV1tJ56+Re/8zGrb2dSZ9PQRg8AwRrPFUCUdVDnOrK3mt0se9RglkHlAb3bzXWJu3VokVjfjPJbUiAUTWM4WIEQu49AVwvq9mfaNreVth/s4VO0SeBpT1e+Zhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276795; c=relaxed/simple;
	bh=SfzCslTg7FUskHtU5qkqJT8Z1pqMrqj5+kjaJG91nS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=p1K5dXpHreVy+HDI0AGKIxnBQvH0U9hWanOn/VVATHJdzXZmImyO5LQkECbobFCPnN9Pcry509tFjiVmrsJa9vtSHAJZLSo3YBBhTtaKk3fBzDozRu3sl+uwKrYjEKy/bSBA9o4HYGmjOEgTbW7PNcumH4Mdqnz9SkqvTnkNkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAEfyFTW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAEfyFTW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234dbbc4899so44839665ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276793; x=1749881593; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sJD5E+0Fcbf3IjrC3jfxv5TUMepu7Kfa9Vz+4EtPR9o=;
        b=EAEfyFTW5ycJR/YNaQlihNhPHyXwRAjmavu70csiM07ZAEX655LA5Bd+JjGrFk3jC6
         OpkUw+HeiNfMKZ1Ip1bBi3PNf+gxfmu1ibjHD/8xlnRZ8199RVvi2PhQhZqLCTtoOkvi
         L3ISN9IEzFiJDYUbWxN65ODDXLlD9vErfOiEKPgZ9E8MNApLWKvprcWtiCBBcp9h74R7
         t0w97Wnsnxb0y11DggMKiUI5XUcw54twLupI51CDDA0W6gWc/06LSLLombTlO3S/B0ao
         yuz+eBVbs8Ry/Vjnv2xzwzZ7cnXaP/2xOEj58S68hnrBNDZm6j7Avm2NFaqNsckSHHy5
         irbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276793; x=1749881593;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJD5E+0Fcbf3IjrC3jfxv5TUMepu7Kfa9Vz+4EtPR9o=;
        b=EfS+74UFLEgdQ53wd5UIsHbD4YBUSSQtgeXaC9nRywD9ARwV/oMmu0tiVwHZ7vN/TN
         Nb9F8jWBeFTQjsA7taYdyes8/VrvZL1i8jgimIT518jyRIh3aeyrhOORhGn0s5ynXfXr
         wUFiy+MDVSPKvRp4eCkus+glm0U77eekISiJgNTQKNZW4K/PwcpsLegT9KRyqBSaDbWE
         6AvHpKqkrWK7u40dmHyln34rnksQvFOwLlWbUHYItxn5D2yhzY5hMqSIqBlAXSzgVoMl
         0UO3glKZr6sTK+Yr+0qznGx2flZ+t0SRUlUFMnKB1V6JIcWeXK+fOuxXAy2Llmlz/r/x
         HDOA==
X-Forwarded-Encrypted: i=1; AJvYcCXGJsoiySD90PYRxeUEH7FwhOeTeVHAEcx76nqrKI7KuLWkHq9t8/tDIORoc8qQrFZdwyfNarWusGoB93wzigGS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Dvr1mUs35a1vP3ALFL03VJB/8uUfdJXES8UvjGrHlChWoaF/
	J2ltMeRTH8ds2DTdPdLDTwRfZxL5sqXwbHROVijqPC9ZgdP5OLqmDI+VApnezo97vgpKSccPGu8
	2BLxq8bJR/w==
X-Google-Smtp-Source: AGHT+IESG86lWsGrnXT531aY5QwFbMGojtb44hgC7bu7eDmJoYZRQjG61FmihcJMS90FqH1Z2wMc0nypTnrs
X-Received: from pga1.prod.google.com ([2002:a05:6a02:4f81:b0:b2f:5c37:666b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f711:b0:235:e757:ebd1
 with SMTP id d9443c01a7336-23601d18701mr96634415ad.28.1749276793580; Fri, 06
 Jun 2025 23:13:13 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-1-irogers@google.com>
Subject: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pipe mode has no header and emits the data as if it were events. The
dumping of features was controlled by the --header/-I options which
makes little sense when they are events, normally traced when
dump_trace is true. Switch to making pipe feature events also be
traced with detail when other events are.

The attr event in pipe mode had no dumping, wire this up and use the
existing perf_event_attr fprintf support.

The header's bpf_prog_info or bpf_btf may be empty when written. If
they are empty just skip writing them to save space.

Ian Rogers (4):
  perf header: In pipe mode dump features without --header/-I
  perf header: Allow tracing of attr events
  perf header: Display message if BPF/BTF info is empty
  perf header: Don't write empty BPF/BTF info

 tools/perf/util/header.c | 46 ++++++++++++++++++++++++++--------------
 tools/perf/util/header.h |  1 +
 2 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

