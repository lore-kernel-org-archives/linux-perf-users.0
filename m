Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E149E5E5
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304481; cv=none; b=vEbXqbzznnP8HJU20xiGHurx52n4sBzINDUr2e45e41XLU5feZ4Ud+z3vteo3arcs4m0h260b33H73APyG3VboXrf0IAe/7kRWpA7YFYdyxK7jAfMIdqavteyozFN5kg41n97ZAMwSZ3U+Z+acRv6XYk0POEvdGeAGxhShHhmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304481; c=relaxed/simple;
	bh=J9diKMq50ntprMqAl2AB3oYHuq54kfniR6ah9ouSWYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HBJucRgptFOEUK6F5eKUl83pCt5t9bDCct5frEI1I6fEv6PxctUkJgishdEEqXor45hV3jz/VdkgU281RAYMfEk/qq49d2p1kIFIm5RCjD1OCr2iY+bb3JELcvkT/LUN+HgilgWyUh6l2O0rS73P8Rk6YUOh56Kf9WKqO6y3qTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJaj4Uaz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJaj4Uaz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so6953185e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791304478; x=1791909278; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S6NNYhIzBaDa0aocfk5znnJoVbSEEYZymIRyHYxXuYQ=;
        b=iJaj4UazbhQkseY9Jc2MlletW6+QkxNuP5n4aBMs0J/jJgObhM15Pa/LlSP+fYZhYK
         SdkWkViWfpn6GNi0nLziQU1Y2CCvNPpZ/xlL7m6vcWNFXabYh9oUShE1iQ1+8CWN138A
         HI48f4n8Cw002W5usHx7vv3bMXDNCBDoVhAy5PPsdrCY4hF8KelKo7HgScXarB3r4cU3
         726vnrOjRNHL7Tb4dpHH98v0mJe/BG/1bkBvc255fcj5p80Fhtl0mhGJlL/Z+PbzX/vt
         ctYN+b1Ytsb4LQcR+TVqSyBG2HsCTefHLlO+p4NT3nyPK2ykGL1fWq/ROceK7DSRI3o9
         JyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791304478; x=1791909278;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S6NNYhIzBaDa0aocfk5znnJoVbSEEYZymIRyHYxXuYQ=;
        b=k5h3vRpusGUDCLyeDT0OAZ75sjVpOK2tw32gIJD38CZl+fODlowMklwnUZsztT8H3b
         /POINZp9yog4zy6NvvmVc1dqPwtYTL0VzhVsUwEP6oTudn58vWKqobtyA283IuIbDZo6
         EW5hVUwcTBCk5i/+gi+MmO6/WEe2MJaNRiiRKl87D53rOYDS3h0QE8y2NgA9Bq4VhMfW
         PfLPWkIvb9Da4dHDM8TOVSHXdFmjgChZfaay5U0ygX4exIzgvGtb6KTv80Sq7pW5QnRf
         Eq3/ST6sZMWCFRwHhdAUxZS+ZZYnkzPgfhdMyGXD1fd1OVRbCqoGu362IHpF/A3AUP3r
         Ik1g==
X-Forwarded-Encrypted: i=1; AKwUvBxBg/PRGp978VGAJzCJM+rtGAqhLVsTpjYPZx/a+HSNu35OJWQJTqWE8mrMUTG+1l4xeIVr4XfTXjEydxw5m0+w@vger.kernel.org
X-Gm-Message-State: AFuF++nAVJ/l5cD4nhvO9UAolhnkca4h/ADZNSMYUNVjQTd2bQFihWcd
	k70jE4C4ErrVIA0gYNRjHDJStKvb7jw40WgfGB0sSXG2vBjykD4X0okBYdDJfwdx/7U=
X-Gm-Gg: AYBFou0OVZ/oM0Ie17GrI1obhl2rmHmBLxU8gYBMJ06PpwCr/jV0uGl3UHvqUj6MOl1
	FHA2SbPIruayDU11SuNqN70zQ0AhRuDXspBMolOnpin5fc6idvgVcjO59BwYY8K8D1IiGhlDkUt
	H8Rfwhrz/8KtdxOi8B97wxnAxQOHVF0GoIpTRXkOLVt3ofliZvOh80X76DKlXIqWSuhQkVPCGS1
	97A4dCo84mB3iYxfO6KnBGn4xDkHZa2MOsqfh3zQykkAKQw+HCfrD1xSnrKNXQ+CgQTQDtmsdA7
	n4VcHgMeFu8PaM3hccBKeauENfvPlEZdfEsXKwKPewpwNXxDeICTM3dDYWj9oUlCM+bJzYf7MsH
	g7ZtiW3z0A8bRhahEMR08Uh17EN6+4ZdyxHV77i5jBN5lcfE2xXpl3uoBA6bSM1f3qSbUGXL73q
	Or5b4qtX/dL31IXNbJnZHejGXypAHu3CitWihfWdQCFXduzTeHhIArVhuDxBqUab9KjzvLDgADW
	w==
X-Received: by 2002:a05:600c:3b98:b0:4a1:7d08:780e with SMTP id 5b1f17b1804b1-4a17d087812mr26088725e9.1.1791304477858;
        Tue, 06 Oct 2026 09:34:37 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm78918555e9.3.2026.10.06.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:34:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 0/2] perf tests: mmap-basic: fix user rdpmc detection
 logic
Date: Tue, 06 Oct 2026 17:34:11 +0100
Message-Id: <20261006-rdpmc-detection-logic-v5-0-b25c9d49baa1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAMjxWoC/4XOQQ6CMBCF4auQri0ZoRRwxT0Mi1qmtAlQHBqiE
 u5uYePS5Z/MfHkbW5AcLuyWbIxwdYvzU4zikjBt1dQjd11slkEmobqWnLp51LzDgDrEWz743sX
 OTalErc1DSBZ/Z0LjXqd7b2Mb8iMPllD9tDwHqAEgT2UhCwH8yp8fq3xD2FkVUu3Hg7JuCZ7e5
 8JVHOC/MauIlM4yKEVRVkaqZnCTIp966lm77/sXU2lw9fYAAAA=
X-Change-ID: 20260817-rdpmc-detection-logic-d3f7a49cfb46
To: Ian Rogers <irogers@google.com>, Michael Petlan <mpetlan@redhat.com>, 
 Qiao Zhao <qzhao@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

I'm sending this to fix the comments that I left on the "V3 resend"
because I don't think Qiao sent a V4 and it's been quite a while.

There were also some unreported bugs that I found during testing.

Changes in v5:
- Keep rdpmc_supported variable name.
- Keep enum instead of int.
- Remove #ifdef __aarch64__ in the capability tests that made the
  cap_user_rdpmc test diverge. Now cap_user_rdpmc and pc->index are
  tested in the same way for all architectures that support user rdpmc.
- Disable running the 'enabled' version for unsupported arches which was
  equivalent to running the 'disabled' one twice and to be able to
  simplify the test.
- Link to v4: https://patch.msgid.link/20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org

Changes in V4:
 - Don't remove pc->index check. Without it Perf can silently fall back
   to the read() syscall and the test is useless.
 - Test the 'expected disabled' case for Arm in an ifdef to workaround
   platform differences.
 - lseek() before writing to perf_user_access otherwise it's ignored.
 - Support restoring arbitrary values to perf_user_access because RISC-V
   uses '2' for legacy mode.
 - Rename rdpmc_supported to rdpmc_expected as this is what the test
   expects, not what the system does.
 - Label pc->index as rdpmc_event_active for clarity.
 - Add comments and simplify the commit message.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf tests: mmap-basic: Only test userspace reading on supported platforms
      perf tests: mmap-basic: fix user rdpmc detection logic

 tools/perf/tests/mmap-basic.c | 182 +++++++++++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 75 deletions(-)
---
base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
change-id: 20260817-rdpmc-detection-logic-d3f7a49cfb46

Best regards,
--  
James Clark <james.clark@linaro.org>

