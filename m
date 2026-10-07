Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56734AAC50
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370396; cv=none; b=ExyJ41Pb0DRIxiOS6KtYOs5YtOf4P9VWdbUQsY+4mF6DpLe8GFxlQeB6hQ/qXvdsvO8oc9QdAZD8Ae0qzvxazNpenVCmlTcZOTKDxzv6lN+ZKyH8j64sGLZWGp/xC+k7yCTK5Vz8qvhPg1FOdsZThsoDUJOnc4XDtKGWvF5Lf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370396; c=relaxed/simple;
	bh=HjCSuVSMm1ll8Py2YDNsvLJB7VSvJEowexPLvkzGFfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F9bhGoZqAVqy79c7iBqlBh6hwE8iTNX2Q/XdRgvQQ3suxQjVKhU9eOm992JfKCUyeUB67lMRz5gamevPpW6StXJzGZGlJz5NMVzToOYToqXd68gsTMhfZW3Jj4maxJ3770fjDiVveI0O/nq9uXFPtTCG0wzCsaUX+c6ufYe+IkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AXLOAJF0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXLOAJF0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c14a06c95so1369275f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791370364; x=1791975164; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NZeoDWuLeHkfSjqfDQhymjIVrj1yL1sXaCr2GcXJWFY=;
        b=AXLOAJF0zba58KoMlWfjE/OEt1tB2v6wyZ5UZOs23FOtA/aExtBu81oexhpX+m1xAu
         lO3JqyvtGhgcaChcsdgAEYMZowhzArNV3JH4ibonjbFEv/4Qy6ZtjmWbhIGmlqrTJqca
         WQ/4zk8FZWBAVngVNHcUhlKKJlxENaGhEEGbYBj/2e82N2b60B6UmqdD6nftd6oAagY+
         YsTAiwLNHERjraD5mMRvNWLVTYTDVn0kwqTLYStPb5eOplpMzfbQVw/1zYXzfB3w/GfJ
         FS4QTF48Bp4zetdTpdACm7uXAA9RmP5Dwf5WuuELmOS54CbfX1URfgz7wvBjFytngGsV
         kA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791370364; x=1791975164;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NZeoDWuLeHkfSjqfDQhymjIVrj1yL1sXaCr2GcXJWFY=;
        b=teozHlishOkhnztmK00iSWVMGMAkdumi8exwFpSguwpz5+oFHTXaalvDfGX7DI4BS0
         He670cTs2NkKHlsfNV2isRXVmWA0l6G6YXZTaWuf/n50cWa/WebZB4UfhzOJFlU7D77R
         gjgpeB4EnkAsv1EBWkVI3OEEWtiE+wQniJ4j/7kYFOCg6gwKhGtnPMjKcNcOBB3YAbI3
         DYYxUiKIwgNG/3csKNSqcYY6ZHEFaFocg0bh0IGkvsY9Q0YBQMFdv2sr1TaRiZxTRqPg
         Bm5GU5EyPKSnCIFaBHxGJZ4cRsyYgmjxbXpbhhSbeBpoukJPmi+sjq6gyjUuqMe0Vxso
         1zJw==
X-Forwarded-Encrypted: i=1; AKwUvBytop/3QBnnmqh01W9wJa1jmLR0XqIyYkN5E4cpQ6YfVin3DbtbHHX2d1To2hmUIc3+c/Z65MyAAUV7CCvwQAdj@vger.kernel.org
X-Gm-Message-State: AFq9FYLPFguelvE3axa+GRgM6zotR5UH6L0M7XbcmXfSI5ne2Wumb0gO
	e881f0Cqxc3KBxfS0bs+acT+HXib+r0/wF4N0uXEx7b00zjh07WqWyC4vGj0XQs+Sxo=
X-Gm-Gg: AYBFou25QFHMGEqLAC2GcluZ4xXOrOYUnTRStucDd3ynWcyoYvqGFNBSjt2A4CHbOwe
	0WYLMkN6zO6DVw3D95uSqc7DId/rB5TxJSiliKHSuk6ZgHgZVshKyWf3KwRXry6/bQduNO2r+dI
	UFfP2dr5T7ySfJ7+6zM+1B0tT9cstkof9YLFVHcAYG5sdWyDJdi0uYywfo79UzrfxTIXGCWWWnJ
	HS2ECMqAAh8Uka8fGQRoKgCCZUZVVXaczxC0KLSww6/V9pV3ucuMqstAXwXKseuJ6VWhk9RvLvu
	jwWg/zUrcSYQSEuzD5iBDcNzz0OvE6bn2tpCTrivHHiAdrZqlgcrZUDhnkoE3RSK3W1Fph0yjqp
	GtkFjnXbJJ66rVV4r/glKFiN6DKlHYnulipHr76iIVKEWzIXmG1wfiNEKX4VauSN3SAUHtoPL7J
	S3QbKykb7eC8tpMK4KXYrYmhmS2xxNM/Ww7vqSx1o1i1QgE0uNc2pJ4jVmWqOBJBHVKEL++KjIz
	Q==
X-Received: by 2002:a5d:64e2:0:b0:486:fb08:2353 with SMTP id ffacd0b85a97d-48c72885618mr3221413f8f.31.1791370363566;
        Wed, 07 Oct 2026 03:52:43 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d31767sm5182781f8f.51.2026.10.07.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:52:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v6 0/2] perf tests: mmap-basic: fix user rdpmc detection
 logic
Date: Wed, 07 Oct 2026 11:52:11 +0100
Message-Id: <20261007-rdpmc-detection-logic-v6-0-d7ed6a85f864@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwkxmoC/4XOwU7EIBDG8VfZcJZmSoFuPe17GA9TGArJtqxT0
 qibvrt0DxoPxuM/mfnlu4uVONEqnk93wbSlNeWlhn06CRdxmUgmX1soUBbObS/Z32YnPRVypd7
 Ka55S7S70qAcXRm1F/b0xhfT+cF9eawfOsyyRCX+0rgMYAKBrrLFGg2zl22fEfGHyEUvj8nxQM
 a0l88dj4aYP8L8xm66UUwp6bfpzsHi5pgU5N5kncazZzDfTAti/GCNBjsq4wethRGx/Mfu+fwG
 eCX09PQEAAA==
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

Changes in v6:
- Also skip on EROFS if sysfs was mounted as read-only
- Don't perf_evsel__delete() on NULL evsels
- Don't try to write or restore if the read failed
- Use existing "goto cleanup" pattern instead of continue
- Link to v5: https://patch.msgid.link/20261006-rdpmc-detection-logic-v5-0-b25c9d49baa1@linaro.org

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

 tools/perf/tests/mmap-basic.c | 188 +++++++++++++++++++++++++-----------------
 1 file changed, 113 insertions(+), 75 deletions(-)
---
base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
change-id: 20260817-rdpmc-detection-logic-d3f7a49cfb46

Best regards,
--  
James Clark <james.clark@linaro.org>

