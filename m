Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527435;
	b=DZmsOyxsDfupQQPpEf6hHg6ZEcbDtDc9WZON8vEBpEBqFH8S1MFfTmPSW0L9rv3/hDF3
	 CVzKK3rDIdE5URKoiKUJ6W09gr1wAfCShbN96MtIQKB+1B+/pRXFyNXPPrdfEAW4KJ8EN
	 9CwYtr/XnLQXOxVzmB3DWEUBbTOJENivACR7HwPlXwoaAQRd66dyjxcngOoTckznpYNvv
	 VfU4bPmJuz6wI5XE08E1nNSf0HkwaaK0AdeauZu/y98PYvM/31V/s251bLMjVmUQr/vuR
	 iQIR5E8P2KpLlW5Vzk1hR6JOzccUYlabnUiA4eOFgMKWlOj5Q0jcwpJL/C3obG8mX6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q1kvRgKeqJR6EuLY1yBynSJtWsSukBAUvLh/S9hCbu4=;
	b=5d5D+nZq9Wyq/Jkb7he1jJBocItrYypBkKTUsgjLj7JrRDWYaBcaCW0RG0mvC14rmuLz
	 ZrajpVfEUXCCDcg+qs+4s9NEsBjuEwVsyU+hm0e+su9hlizR0MiQSJXLdj4SN+VwKrrT8
	 5Wzt2EehFabI5E0aPhuin4C6apG3sYIA5Ni1roiVsbMDjpiUIPKHDWGsu3IEIC4I1s660
	 zAIXT6PKhXK3VL9+CeIFTC6q9bPxKYLkapx4zkYup7qqMPEMznJgfjSzQ+WreapOk/OOI
	 2QXg8CepBfZ1psqIQ4yR6y+i+T0hvhMiVBfr1YJLAqLYbM5f+5O5gEFo8EAcAKi1KXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXZleSVo;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611D606A337
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E611D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXZleSVo
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36f8cdd30beso281826eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794527434; x=1795132234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1kvRgKeqJR6EuLY1yBynSJtWsSukBAUvLh/S9hCbu4=;
        b=rXZleSVowkCYrx5PW2Wk6LwW1c+xXl7XUq4Z+rZPI3RX4Hptd1Hh4fEQ3QpPlNUojY
         AiRVQUP9ui5ADgaUCGwJGxf0kqvWYffgzQBsWA9W5Z/dArNmXW7QoFiglHkcbuY8Byzu
         HCoNG5ii/SdPvS+h4DiA56nJDccBa7Q8rdDB7B9nQ709LGyfSJ81XDY7rVSzbNoOdFw8
         SFoBPspRD/NDApuF/0e+fmaFgia0kPri/PS4uQgR6cogQhdaE1WfLfgnIosZtv5fTv4L
         JZhBj8sAy8/1NFlpbnrYCfNqWklJBUABZ8EixuPUAaLDqnnufc7HeoJo7uJeCc6yg9N2
         FxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794527434; x=1795132234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1kvRgKeqJR6EuLY1yBynSJtWsSukBAUvLh/S9hCbu4=;
        b=Z5aiPgGKetWq5X+qeA2taPVIWettGWGTbl7dLkjE7j7dOwPIYYZC6/oNtfNf+T/fa4
         DTXbihoFERVyxjhBUwGm1KBsXw39AYHAirHWKv6Ip5de9Yi+60REbaVsktcxRvCC8V9z
         CTFqWciiW9rWmc12O8ZTKmxGATE0kp0iw1dpiplNzH4xNbTTNBF5PpY5IpR3iYO3znPo
         jkVmTR0HU9O0i4FH0ZsIjv8BTDfaD/lz97EkerB0nw9RBcj7Iixiw4UBKJKdcSQMzo3G
         lGox2uwOtP5DLDjeMOO1gVcsn403+oQ7S+4p2yTWihmblDZmdhtgBYyiOP2aoI/KK0ok
         5fMA==
X-Forwarded-Encrypted: i=1; AL+hErFouP8s1PmriGvfGFejybj6Lk7jhlSXanvShXVP4KnDagxmO4GsKYgu7+GKfxYncCA8EtnWNKInUxQ6LuUIxQEP@vger.kernel.org
X-Gm-Message-State: APuU4Z9T0G9gde+dI++taAiny4UOvtdUQe1yLXGx+vYmh4bb3/96Iktt
	QsPkYOAcZU4FRaxa2Z1fk2n8KXYTwh/GtXa5D5Fr65oKZ6PTDedGEyX+
X-Gm-Gg: AYBFou0tG0QvrTjqfkrt6Cr8iirf96BpiHQZBAprAai7lNJnz2/p9GpOQkltuEMrjF1
	4Ma9XFDzoCa+BpgafsqUBlFXak0Yy8UcsKFVU+oWNKOjpD0FDzuuG6d7FjIgYPsEmAqNmEepBuQ
	ZEonQlPC6W3vGEbSEoZgIAuPBvndkWuMlAZAq8O2rgzrZHnE+qWSbP/dRYSHyp697iD5IHSNWaX
	lq9vmHvh7YZRNw1ed/SMye4h94keUbt4otD92LZpJ8n8jprbURIYpnhoeuRJI9vNzAL2SPlGHr5
	SlsR2A7lfvmiQEP+B59mNBqWmonvkFXe9JwhBe1xdwiFr2p7ZAkihDTfivJVhwgDHmREVQl09HF
	knVMAcheykV/6k7H73Xm8e1F40eLEVvrLUt+yp7tdRMbrJXXj2tzbjhlTKy8ulKq2B00vKr59a+
	KE7weEWrGn0aI8wRD51YA3U7wf/TeqoxIgp4uQhqTFxSNawk4UAUdtGmKdNfRXQDeBAfG+94HDJ
	QnZooiLqa1DB0rUVL+Ei2NYaMU7YKLhqfNen7yUuU6qwso+Y5HQJSx7MfUinoifO+OCG2qbXb1N
	NdV6A4uK8clzPb2A
X-Received: by 2002:a05:693c:6293:b0:378:314:4033 with SMTP id 5a478bee46e88-379679e29f2mr632919eec.32.1794527433890;
        Thu, 12 Nov 2026 15:50:33 -0800 (PST)
Received: from evangelion-g ([2a09:bac5:40e4:11cd::1c6:8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm3842976eec.8.2026.11.12.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:50:33 -0800 (PST)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH 0/2] perf/x86/amd: Check CPU hotplug setup and unwind failures
Date: Fri, 13 Nov 2026 05:20:01 +0530
Message-ID: <20261112235003.18608-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMD Power PMU and IBS drivers register CPU hotplug callbacks during
initialization. Both paths need to handle failures in later initialization
steps.

The Power PMU change checks the return value of cpuhp_setup_state() and
removes the hotplug state if perf_pmu_register() fails.

The IBS change checks cpuhp_setup_state(), removes the hotplug state if
perf_event_ibs_init() fails, unregisters the syscore operations registered
earlier, and clears ibs_caps on failure.

This series makes the initialization error paths unwind resources acquired
before failure.

Ayush Yaduvanshi (2):
  perf/x86/amd/power: Fix missing CPU hotplug setup check and cleanup
  perf/x86/amd/ibs: Fix missing CPU hotplug cleanup and unchecked init
    return

 arch/x86/events/amd/ibs.c   | 26 +++++++++++++++++++++-----
 arch/x86/events/amd/power.c |  9 ++++++---
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.53.0

