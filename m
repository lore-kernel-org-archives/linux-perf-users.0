Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850728;
	b=QvdkOBNPyC3d9z60lZDf/h4chMP7ZfcG0kFDFnxsRoy9uu7L1UD880GlsaI8fOY8d9zh
	 pZEHDF2wRXjHVQt5NFg87kVm/HskaHgCuEd8ZQDdh9IL7hFKmyCzuEAmIb6KQ2M8aafaJ
	 o/qoBW+iwmfWQNRqkENv3NUKjl0gKvvUzDbQ14ecLdHBvYJddP0qeL/Q587UqqKMSIgNX
	 VHmQnEtDFodeHCwdUfMFn+wBM5SD4vnV3fZD+hweDWDMUtbbEc1NBkPX7iCtHkrYJryyG
	 TQo2Rtp766KQDon3/vqBY5bWtxPKpzzN28S11Um9BH51TzevqdWYP42NdGU5hvDcjCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aLSjTS2pwt9wjNyiWIDUlRh4L7BmtQghZ/YF0bk5FsA=;
	b=oUoAB7hXz3JseFqw7KtjF6KJJ9r3jq6OUG5DdEgyRuNpmFMiEeFBmZCMvUWXAe2k203S
	 CF5xtR67+rJvPJftbl9Oj0M8HKI2H9MOmFQxkLHwcIoDzACTBMSKAV3/eaRn/n3Ojkdo+
	 Nl8zvlTqqlwULufUi+guOgO1TQ+BF8N56qwVH0iNhI/FoxbBJIoSt5HMBogvshMh5kquy
	 n6tQhnkvMAT4mvnNUJbggnmK21ymlJQpYZ0lYJoHKY5xWZ82GuUlkKN9+g9vyMLn5U/FN
	 sgBvxa+KZTgzuZMkx0TEuzpU8mp9XEIpnYAEwhIwG9TnFKK/3MeJDz+Bp52uedfXryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKpxFtJI;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2C606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 17:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D2C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKpxFtJI
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so9799105eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850727; x=1795455527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLSjTS2pwt9wjNyiWIDUlRh4L7BmtQghZ/YF0bk5FsA=;
        b=dKpxFtJIyWFjlQRSKbKIOU1/Oas6D/kgChSi2PmhJsbm5FtEqvv9xhesQJVCf12raU
         sUMDR7DzniiYa7v+4fuLtHlyyZBTs+IIwyBU3sFLYGJYb10jER85jVVeaRQ8ftQB+IK3
         kA69IAlKM60thCxjGq1wIkuG6Wj0GvAtsQmT4LvXz3bHPfUf/g03sCmYarJID/W/PejY
         OHp5N06ca7kZ/adfmhspTE73A2p+/a6KZhg3dKjyt8/+ywmTa99RrY/d+Q2wQLXba4kT
         Ad76ynbx5wpiNG709WvXE1nfLHM4EcsY/tD0vm+jPrufY/zb2Zvay2NqACNzMC6dwzib
         yaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850727; x=1795455527;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLSjTS2pwt9wjNyiWIDUlRh4L7BmtQghZ/YF0bk5FsA=;
        b=x/dWew+P1ogOUU+DpmHevvrzL9TEEz+Ep6EEepFcURbckDr3vhkJbLGxDFir6OSkBV
         ZmZzmYrCN2pQ+5LkTQJs1sG+80/2fhy+i39IWNhXLEbKb7An27Ojvky8SbVQrTXqO13H
         hgi4O0UzOlEI7Lwp7lB/XdZQ/g/hzgcmAIXtEAKeDGRNh1fenGhGQvleusJMnvDGWX/l
         icxPatSwOa5KCtPxuUTl8jm0jcxSVAEJ6BERrmuN8ynZnTEWnVlACgYMOYjuIXQpMe8/
         OWB/JjhfrSI7aE8e7sFCY/lx4KImR2IhKG956pPQxe74rlT84wiNBs2V4q1vPd/VLvvU
         VUlQ==
X-Forwarded-Encrypted: i=1; AL+hErEtiX0Q5xRQ8SHonw1T5pBmDoBsDLMJdvBwu+bFgzFONxcZu0oZ9/bZoNrURLOxUhoJdrfXVT/V1HJud3o0ak65@vger.kernel.org
X-Gm-Message-State: APuU4Z+UY89oCtXi7f7Y8R9LBAp1I6nQizNbXzqPjLSw0Z0aTMSoiaam
	F06Ou9PkWJ8TSZ6vCCtc9HtIQ1ARrRXj3hrx0ySZwM/Y03NrqqV3l9ln
X-Gm-Gg: AZFdTZd/En3YJMzr/A4o1sl2VzhNK2DbJRLZIf1jPHASmj+g6BiX56ffX3TXvz2jT6I
	XDkCjLKjQjxi/gZGhr5M56dAiLBOTOxBagrbKf/AJIa7mx73kGg6hUWbUl4AwjHvbX38cu8mQcy
	ddONoLOr1xXv/oQ+MAlqfo2LCB/11CyFqZXNkA1cqR5rawajxpxuuarv5Jp5QMC3zeBBBWiLUAJ
	xeVNCeH5eVZcYjvkk0Bb5DLokvgqygqv8a7qcF9tXzAcj13XMMIlqa4k2r4JEn97pScTgW1XKAC
	JcYPcykU9A/V2J07Z/b/2xZ2RsgBf835jKykeWzUBQHPmhDfQJiw40PSUgJa8Cq3MW/IUwPxCgd
	CvAtavk/9gWRhTVHLxQwZKSsMgfopf3ytcZSBvIwzW9vOQG4r0kwZ2RyDB0qfxruYeFe/sfk6Zz
	kol/Ey3bDnEQ+HJyZixBKqrGRfez/9KQkyS+mem9a9YkD7TLTFLgMAcyAmw+puCEQkVbYwzT3RN
	mvqQvEXP5dM5VSC6/OIvhKzd2bKGY7kUscmMAx37dAwtGBDMHvpv1FCDHkJ0hQKBVdRCx6fXLDT
	e+gk8E/crydg9emBv2s1f+fJg/gEoe4=
X-Received: by 2002:a05:7300:6aa0:b0:36c:b8b1:a44f with SMTP id 5a478bee46e88-37967ad928bmr10061049eec.31.1794850727398;
        Mon, 16 Nov 2026 09:38:47 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm36635215eec.15.2026.11.16.09.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:38:46 -0800 (PST)
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
Subject: [PATCH v3 0/3] MIPS: SiByte: Add HW PMU support
Date: Mon, 16 Nov 2026 09:38:35 -0800
Message-ID: <20261116173843.911523-1-f.fainelli@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series resurrects the SiByte HW PMU support which used to be
supported with oprofile but was later removed.

Changes in v3:

- Use boot_cpu_type() when identifying the SB1/SB1A PMU instead of
  current_cpu_type(), avoiding a preemptible-context processor ID lookup.

Changes in v2:

• Preserve usercopy fault state during callchain unwinding. Save and
  restore current->thread.cp0_baduaddr so faulting unwinder reads cannot
  corrupt an interrupted usercopy’s recovery

• Balance PMU event initialization cleanup. Release resources exactly
  once on initialization failure and install the destroy callback only on
  success. Also check event type before rejecting unsupported attributes,
  allowing unrelated events to fall back to another PMU

• Keep disabled PMU interrupts masked after EOI. Add an SB1 IRQ flow
  wrapper that reapplies the mask when interrupt work disables the last
  event; the generic CPU IRQ EOI would otherwise unmask IP7 again

• Fix a documentation heading underline in sb1-pmu.rst (Randy, sashiko)

Florian Fainelli (3):
  MIPS: SiByte: Wire up the CPU interrupt controller
  MIPS: perf: Add SB1 userspace callchain unwinding
  MIPS: perf: Add SB1 and SB1A performance counter support

 Documentation/arch/mips/index.rst       |   1 +
 Documentation/arch/mips/sb1-pmu.rst     | 162 ++++++++++
 arch/mips/include/asm/mach-sibyte/irq.h |  10 +
 arch/mips/kernel/perf_event.c           | 110 ++++++-
 arch/mips/kernel/perf_event_mipsxx.c    | 397 ++++++++++++++++++++++--
 arch/mips/sibyte/bcm1480/irq.c          |   7 +-
 arch/mips/sibyte/sb1250/irq.c           |   3 +
 include/linux/cpuhotplug.h              |   1 +
 8 files changed, 666 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/arch/mips/sb1-pmu.rst
 create mode 100644 arch/mips/include/asm/mach-sibyte/irq.h

-- 
2.53.0

