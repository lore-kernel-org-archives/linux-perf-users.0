Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510567;
	b=jsEjund9E874vuHOh5MdqeXBQ95ZXkW7hSA0zn4gk6ccuYJ8ADe86yr/HcKgbf+s2Oe0
	 EqAaW+wtegCP85AZzcM68htwdLxCyyU4rLs5h7qNWFYbll6iKx5tiXT8vtfdBnkqO103+
	 774A+UtzKaFw07gX5OBAhiVZI8seaPYrH0WwTmbYkE3wSf9eN86pGMQeV4cj8wKyoNg95
	 7w/OYTexvzRtAIwloyJWc1Al+9LsB1/T9hXiJOIRTMaU5HFsB6tl8vyB9Pw/6azK+ZO1/
	 VKhjS2KJK/y9ePAEN5xe7KGq6aM3yKcjFNRuyUsfa5ntq3c9+3mMN9aR5WsgHI8JxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c1dni8wQl+kQkoRfg2fRmlfc/EYuUZuhfj3zW0/x6MU=;
	b=2cSqrEMx6Z06g0D2XOVGTPVs3AKrZhdYHeej9jdwMNOIDkvX3Fk74UycdvFiL7QCSes7
	 GFe6V2feb7eUYakGfZ1TCFEHVr+ZenfXhdQpxkOut7AXij45gbt3RWzU1esP0hyBvaglc
	 gbMqyi3mvA5KffeNXM8g5LQf8rDttRtmDJFrO7dV9aLU0aCF+EcnOo9QIvNkTUSld+KNu
	 SKHmrguDE/2w+uVuyWQzU41P/OwUt9J1cdBxOTw+eAVT1TwcFOD9kilEJLe5MVL3dbOYo
	 jtSb9Dk2ALN01m1BS5QPVsFmKKTiO20wkYz9XoAQoMQF4QyabPzIc4J4dwTGPRnXvZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PpIKNO9i;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B48606A8B7
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B48606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PpIKNO9i
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3791619605cso431413eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 11:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510566; x=1795115366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1dni8wQl+kQkoRfg2fRmlfc/EYuUZuhfj3zW0/x6MU=;
        b=PpIKNO9iCXFN0JuyGZ/RjZ00OHOtXTxwdAm4SLsStsWOLkqrrwwVw0caO0Ele+3UrT
         GxTZPKtkK51agJTDDENcxoOs0wyewqtU13D1SGzYQB14hbh+382ev0/qIpmG701aBiuJ
         4W8Z7iwA52jkHhetKcadgSjc6RFvrHLBovzVvAIMGDJOt77cAYhORPDFKD+tjbiS8OYk
         7d8uU3QRfp0pX9o+fiwGd2YvMiP9Busry76kmVmG/GIoXyQYHnPZyGQm/GdfBv/fL3X1
         HBrtnY+BdBEIN2CyYcKuCWAMWA8/Jm/pyolaf0VaUdNYJfdJqd1EVuybQ0mF/RGhzbCG
         DBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510566; x=1795115366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1dni8wQl+kQkoRfg2fRmlfc/EYuUZuhfj3zW0/x6MU=;
        b=hhfLZ4DotO14f4PuEguFAfNEHbqY1HTTuGaBlTC9xk9L+84zieKfF9qNPohV+z+Kkc
         Vl/psVEt8/Lgc4cVmm8wv/h/SvsMFDQI7k6ODzGVXUc5KQsvmL/Hfk/Jk8VKTQiWpWLW
         zgGeTxEjC9fEKS5SOmb6ukw2DSUiK8PWQQ0AB1R1EhQgtestrPxdSTpYZ5AfSNw700XB
         Y1JoTSlVn9stjH+k6xJDQ2W14yJL1E9D+i0dwSXrJQsA/R73XMLaV4QsIOZl8e57FYOb
         ZqvyeoabP2PBdBJaXKs1uoLOchejv2nC/v0TflmTgDJPeTDvB96KkFZSD2zvCv0h0e7G
         iyKA==
X-Forwarded-Encrypted: i=1; AL+hErEY9eOjs0eQE15EgMnjbG8yItfYeTSBY3zca3oom4nZae3A42oKWB+7GLlGF7WrcKnCIz/bMrzoRoa4iMUtv4zY@vger.kernel.org
X-Gm-Message-State: APuU4Z+azXXcXz0wqwqLrF90edY8a7Mhs6AhKQu6KDV1+p+U8vSSuNrD
	Ff75/99LjfhLlzvOgll8Mr0fO+hn2nDHudrDwCbslIitFu8fYg48gWAg
X-Gm-Gg: AYBFou0pGsYNlKGQ2InLtpj1FKggBTfUGHsyQAQNYtxqLjUVM7zjxY6x5JKZd3GirrN
	BOx8AB1NBnc3gsxy9y2lz31/rEVvjoEWkk7j4sg0eCVfDc9mIP7QL02sKH5xc7yaHFdZ84geiqC
	rFNu12E6R1TtFcHQM32SjlvzV7xnibiScApBvcGQaEePcRgHmwS3WB5dEg/9LPtlqtHIAe3LFMX
	HTt6oMIa2jilu1Vg/6Gzo7WtQGRjqHjPqmus7DxVXQGP4a1YxEOdLlazeyXZdA8bbFaTMH5XPQI
	UZXveTT9maRwRbQaokpcIPGWg/QCd4LkHEfV2IsNcKu1qYZNje2eBSdBC/T6L7px66GFnziio4T
	jOp44mrMSNbwrh9seNgXN+DsU6YISRQbhUw/uOhqQIp8USzBTh+Xfckvc6gxar2zvSi0JYmGbwO
	92FMBW8MGwGfNanK86jWF1jgxDf/ZMjyve8I9wA39byQiJN7Os7yD9r4pSEKMlFkCTeD29mnRsq
	NsdAo4ve9x5jv3nECgKjanw2J51DovUODS4A+2vw7c03SQyXVGdqaI2W39kbv0bIFCI2ks0/Hl3
	ocUKX2tU
X-Received: by 2002:a05:693c:8816:20b0:36f:350b:3838 with SMTP id 5a478bee46e88-379671247e7mr76378eec.31.1794510566008;
        Thu, 12 Nov 2026 11:09:26 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm395674eec.26.2026.11.12.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:09:25 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 0/3] MIPS: SiByte: Add HW PMU support
Date: Thu, 12 Nov 2026 11:09:13 -0800
Message-ID: <20261112190916.3725141-1-f.fainelli@gmail.com>
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

This patch series resurrects the SiByte HW PMU support which used to be
supported with oprofile but was later removed.

Florian Fainelli (3):
  MIPS: SiByte: Wire up the CPU interrupt controller
  MIPS: perf: Add SB1 userspace callchain unwinding
  MIPS: perf: Add SB1 and SB1A performance counter support

 Documentation/arch/mips/index.rst       |   1 +
 Documentation/arch/mips/sb1-pmu.rst     | 162 ++++++++++
 arch/mips/include/asm/mach-sibyte/irq.h |  10 +
 arch/mips/kernel/perf_event.c           | 106 ++++++-
 arch/mips/kernel/perf_event_mipsxx.c    | 373 +++++++++++++++++++++++-
 arch/mips/sibyte/bcm1480/irq.c          |   7 +-
 arch/mips/sibyte/sb1250/irq.c           |   3 +
 include/linux/cpuhotplug.h              |   1 +
 8 files changed, 647 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/arch/mips/sb1-pmu.rst
 create mode 100644 arch/mips/include/asm/mach-sibyte/irq.h

-- 
2.53.0

