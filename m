Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378E3C197A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305851; cv=none; b=WBrPPZNQyyGM0J5vOxaWJCGaY8N2Kq3zSGwdYZv9P/1ROjsHYxYrWLgfZ16maMeLVSeXjKjz3G4DhKlTiQSelNJoE63LjM4uigYcVbgNPUqag/fD96WrohTyxBp1X9b3wWBSCBFlsCP1jWjuqudB86CPvRb00KzDlW4hnqLsHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305851; c=relaxed/simple;
	bh=hTtpEBw7jKIcjY7yaQ70nFXkc/cF+RXIpKKxVOaWao0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EsXdKaQKHlI+QDfrRM/0bUG6fEU768XJVWjDMGtu8Zt2yMbL2bvTTgD37ioQFOnvHWU+Wq/GJ3U3kdL349aXOK/9BTqJr//g/61zrmurOW4tR3om+bW9LUjLwJnoqL0Zel6/cdbpjT6HNd/TeJYqE/VJjw6sbwlb+JgMYL+OpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sE7npEEI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sE7npEEI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-472326ca506so503993f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305840; x=1787910640; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=27jPqemDZWiFrcLFyMte224uGDPPz8OSE0ekfP8Ctgg=;
        b=sE7npEEIFNXaBEQBnrZeq+cuux/TnO1OFl3P40Q6lLUSp4ednzNOP+MhtGEsXthyBd
         wJh8HwkztmmQP6tGqmbO8VfqmDhL01kw+5f4vHj08gAaGvBYhczr8jYs+msrJmpAF3rp
         x6g3UyU59Z6tJcldPTGp/i4kYQ/fdcKhCF/Jn4bKUjbbuBILiW1F+pIkGy9IlWl9dRC+
         vUAUjGWYc0XUHMvCEt8aHZnShNa0k6qxGGNqg3WQocfD310jW3PFV6Y5QkJPFg0nHcUl
         YNPLkRD0iNOEicf29L4ykQ2wx22XAWdercubcXkWOw20P6iFWqHma9rplg/QFHXKTbfV
         1YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305840; x=1787910640;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=27jPqemDZWiFrcLFyMte224uGDPPz8OSE0ekfP8Ctgg=;
        b=Sx8+/I+a/sRS5dd6QLvsKAZ7SsaMI3raZ7zsb6zC5muG8d6g1mnnAnUy18WRfp9Y72
         b2wzQ4B0aBS5WzfAnNoSv2+gv0TV2BTo/FQ+uALWqBIBmngsMoHwflfY+oJeaB15/k0a
         U27DEDbvk2I0hSOJM586TFD3NcsG7KhtBmiORARcqQOitR3eOdxmE2HswVjR0hCaENtg
         D7vrJmPORy61xlDT8oinWWJbWtMNqbYj6y2O99Vl2UT0MYmBNVOqZ6IkpHddupExne2X
         B2duvZDB7/23Pk3Au14BLU03vjgmDR4FyIMml7f/MTMWvlb0zAFh2pefus0TQy+apy54
         7hbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+sIST08Ohqk2++aI+v7AnZg2PyAUaTr3wvilXUhD1CqjKG2SgekG2/EqqHrlOfUv31RFxVeL/G+mmM4jXgqK/@vger.kernel.org
X-Gm-Message-State: AFuF++lo0RzmFhN2H2AE7FViqwyrUarP3F/6WtYiY4AvWJmn1uXyKOAU
	vzbjgm1C2bg6aYmAB1v/riea+VTKhM3QPUdsuxBJ9LrnRa8QiIItRqxjhLF6I5axOvw=
X-Gm-Gg: AR+sD11GrHIRBOpm+BhQ8Qp5b1IQs5r6r9uBpjCSxSXs24xP9vWj5YlJPzoC9wgGp/5
	0XSSjli5QqRmhLmhmGZWP3fCxqqSCo+HFad1X257SNDd1+MprCopCLShSNOvfsF7m3P2M9ThUNP
	MOo7+5SZ+jDaHY8yr5Zb96k0vOpzm0y9bReEwiFVuh2Vhqy5tJl3a4IDDL4DJszPrjSEyPwU1gW
	4KaxtABPyG8dZOqxxRdC6r5GtvyennvucONbL4XZsbelY6FeYcqCeUsQdOawDvbLGuhd+9jWjSW
	0bpQJHGwqOL+Mkn6ZoFTab3/eFqsx2NgJV5nuaq71BBF0q4nyg2/dTdB55P0j5sqgTWIguASpuW
	DB3ralGRwEnkcb1vtzWW8DQN+5nr3EzV6uym4hlI2rv8v/N6R7KPHwteRaPkM+oqE47yc6kCRpC
	mER41Iuuputu/xfsoylWLmiXDo+gXCgzSYX1aq5dZPSOa1NnjINP4VZA2KNo2cFc+q3DTN85ZGN
	U4=
X-Received: by 2002:a05:6000:1841:b0:47f:8fc9:6eaa with SMTP id ffacd0b85a97d-482c0b634a7mr6645342f8f.8.1787305840664;
        Fri, 21 Aug 2026 02:50:40 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/6] perf: cs-etm: HW_ID improvements
Date: Fri, 21 Aug 2026 10:50:28 +0100
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUfiGoC/0XNy07DMBCF4VeJvGaksUk8SV4FVWhqj4kRueBLQ
 ar67ph20eV/Fue7qiwpSlZzd1VJLjHHfWuhXzrlFt4+BKJvrQwai4QWPnmVDC7D8vMePey1HLV
 A4PhVk4D2aD32RsJkVfs4koT4e/9/Oz06yXdtTHmMT2Xu7obF4WnULexp5VLEwyEJypKEPbRLG
 FDIvDJTQJkv5h87cxZw+7rGMnc06n5042AmQtOHIMSEE7szOdcHNyEZ0pqsOt1ufyyUl74GAQA
 A
X-Change-ID: 20260706-james-cs-hw_id-output-failure-1d06d042ef96
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The driver might not always be able to write HW_IDs, but we don't need
them for unformatted mode anyway, so fix that in commit ("perf cs-etm:
Synthesize missing HW_ID mappings for raw trace").

At the same time, give the driver another chance to send them in commit
("coresight: perf: Retry failed HW_ID writes"). The other commits are
semi-related improvements and fixes.

("perf: cs-etm: Respect --no-itrace option") makes debugging broken
Coresight perf.data files easier.

Applies on top of "[PATCH v2 00/14] perf cs-etm: Per-thread mode fixes
and snapshot wrap support"

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (5):
      perf: cs-etm: Don't add global v0 HW_IDs to unformatted queues
      perf cs-etm: Free partially created queues
      perf: cs-etm: Respect --no-itrace option
      perf/core: Return errors from perf_report_aux_output_id()
      coresight: perf: Retry failed HW_ID writes

Leo Yan (1):
      perf cs-etm: Synthesize missing HW_ID mappings for raw trace

 drivers/hwtracing/coresight/coresight-etm-perf.c |  52 +++++----
 include/linux/perf_event.h                       |   2 +-
 kernel/events/core.c                             |   6 +-
 tools/perf/util/auxtrace.c                       |   2 +-
 tools/perf/util/auxtrace.h                       |   1 +
 tools/perf/util/cs-etm.c                         | 143 ++++++++++++++++-------
 6 files changed, 139 insertions(+), 67 deletions(-)
---
base-commit: 78148c85297024ffe7a709acb7cc4fc907271176
change-id: 20260706-james-cs-hw_id-output-failure-1d06d042ef96
prerequisite-change-id: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e:v2
prerequisite-patch-id: 1aa32269a3a7dc76840dd8a24cb5a8715507e898
prerequisite-patch-id: ef471f468351462f67efa58a09a3461306ac5a0a
prerequisite-patch-id: c78946cf4ec1c7722570865403a3562625bdaa33
prerequisite-patch-id: 0b953eee0252db3c7ba3ef1e3397048a94482ca2
prerequisite-patch-id: 27da72c2f01bcc68205bbcc14d5019369c02cb83
prerequisite-patch-id: 365c6d5f71c754e4c690b5ebed3453565bb5b809
prerequisite-patch-id: 64e9419a41082a2db3daf255baf0fb40efbae5dd
prerequisite-patch-id: 1dc2e6ef8e76b369736b4c88560302861b2e4faf
prerequisite-patch-id: b7de38ec4d90f5b45d56390a4e5919a1d6439951
prerequisite-patch-id: 3548d5b161cfb8c11a166ca2b3228ca4821f1ca0
prerequisite-patch-id: 97e66600218a2b32e5b21d0abcb6321590f98de9
prerequisite-patch-id: 292282b20bd8ad7d096ee7ffbc55dcfb75455f53
prerequisite-patch-id: c80259b47850ba65c985c85a29c8cf4948463d59

Best regards,
--  
James Clark <james.clark@linaro.org>

