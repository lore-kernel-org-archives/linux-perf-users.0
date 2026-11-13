Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612847;
	b=zLFvHFSoT5slcSxJ2uQTfP/WrPvlGqjaRTOnEK5ZYacOHWDR5iBrRS1/U5ufXa9ouHqF
	 DYfls1IR6s9pI+zdDe5KQNiPcWMLwLIjQZGc7agr4Or3Gkd1pEie6EHEDR55xQ4QUoHc0
	 pAogEE+Lj85JNoQntqko4o3HNmmqScTPu0qu6zJOcl3eQhtpEWGut5vv7quxrcR/b1NSC
	 lhnizwxTCFlNvgu2z2ef0qO+Xb4GsAEPLsiFg7MfZUjxrTxeosv+m30U1qmDpxCNP6IN7
	 gyMxhREfAfTOPq6iqdbuVZJQDGjDgaSSaijo22/ocQ1MgbjIBdDXQWS4A+iY7Tos7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YtlPe71UsmVz9h4+BFpDabZxVBkWd1duDw8VtWzU01g=;
	b=KKp3whP5mGLx2L2sxs3up0VWiTNcFoncUPvryvzjT3VKoH17qW5xPE6cn7JgacrtEvUP
	 U4NEty7DE7bVB7mbCpRjiDeXTEX0MuoXP0E8dT6/WHUAbBliQU+wj/y0IRFOTwJ2cfFXL
	 cgRnl8Kq/MYptvLS3qGUxXhc36x9glCETQw1qRZCqGYI4nKjcPM8tC/FEd9RrNUfCAvBg
	 gRbPK/mMaHeMD4E3x8Zt5qd1wFdHtEJOAbN2nw6dNH3enJGw2GqIzY6aa/8csI+pLTgTj
	 I+2EP6Kk0MfOOFOhbnrCHfNraJPmTHts7u58xz/zEMcKTBxqqs8AciL/5vMsOJqL+Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tACVrlV8;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2D606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04F2D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tACVrlV8
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f6295304dso1351558eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794612846; x=1795217646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtlPe71UsmVz9h4+BFpDabZxVBkWd1duDw8VtWzU01g=;
        b=tACVrlV8XJeZsjfryb//f6qThpcS2cr5CPmVJSIUKq6P8bH5fo5gZO44daC4NdXhFT
         d1abIWSJRrZ56MtxEXnJFckn8bM9+vrbUJnw5b9iE1p17AYCSzO3fWLeCo6LBp3RYP5Z
         iO5DNTyHUxDctkK1mGgP4eYDZHXUt4q/BrqTa0AkuxIL7zFuZnETldAFbbslNegko9q8
         dxwB5OsFyrEYwUiiJ+SjXtal/X47hI2OV/t6aXJK3asAIqlAJP0RFQf68xARsZmzQc8k
         xDN+kw7riRQngvEcj7KueF/7yHCBglad8AD8oRMgubnfg6ApQeWxwUKzcptAo5j8kMZB
         MOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612846; x=1795217646;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YtlPe71UsmVz9h4+BFpDabZxVBkWd1duDw8VtWzU01g=;
        b=vSD+sKOd6rWTCCLlMx5bh5Lipy6+fI/5Sq4QsL3Y19NRRn12NsWTwQO7QZgPMCrAos
         Rzsx030bW1CKFu59tsptrINbQgTAdwtEmyyySIY121RlViuooKztAyGqqE6zF2w0LgYt
         Kf5zMGdi0WXuYl4+DInsTIDfA/uU7c8pyjFoGaJvEavE7eAXjGvhJdcmBFVzcJNrERPH
         8hOBlv5VLrPubhUNSfxXly8Vnydo8NeFt46d1eALDhXWhnND5gg9SXgWIm/meJcxZzNG
         FqtIDGJcAKFffVSBCAvsFFCHuwq3FUiERhI8EN0dtEFkjwQajoA283Q99QEQNr3iw+tx
         daVA==
X-Forwarded-Encrypted: i=1; AL+hErEKIlKRMU1M5DqOcL8icBx138+reSgbwl7cJczqy0euNtd3ZN+iWWSjCw/VQnkm20VeYiJST9+wuP4yntyD2Mox@vger.kernel.org
X-Gm-Message-State: APuU4Z+5svdKHhXXBW8hn6Nj+i9mHL5A/cf1kai1pBw5b+BnRnVbznEm
	z57I/KOc49GKLPwT82mbNMIsXgheYTrxvKiKZeFjSgv32LBLSBID3lvK
X-Gm-Gg: AYBFou1tQTBFTdope+ZqEdeUM39hDYZm4rGJ64wqamTwNz/SLBNm/vNnhDEGzmUvvWU
	dTNChY/Qd7Kx3RAAAJp6FUQ5xqrrJlZBeM9RDMS5DM+XX63Hzv3Akhr+V0UuE0Ma/gPjI1u7kBu
	o3oGrEPk0z2QdRXemATiy5NUQHcv5nd5faJRl6Mjsia8EZ+AGbT3iAzfxD/WLTlKmwL0ZQGuu5x
	/wHTE9ICQptGY5fX3WNQMwEk6D2a/1tVHd/G+Umihd2NrEE0OE6ehBI60LKqn9Wanj5WfI2gFmz
	LTOREp/SV/ct8+MvO6MLQPCyV7UL8bM2WexrqseF1mdMmZxxHqL+donWZaUzNmhrdf2QhVGgeWG
	KcPteKbb6FU7wPKa52xd42cHjnwO9qtN94L+lW6+1fvm+g5OZygYpqmaWGUf6aHrU9dEJGRs7ta
	KTVs9GKBRYEzsQFZ5/zmEDvUIVTjRSTSRArxER961EgyPVCatzEyJD5AkxAw232RJGp8bEZjOxc
	1Dxd6LIhMQCK7uAAyS/ZGEkhalyx55rIPgdFrByd2HjerlGcKLuxZ66p46dNOKGUOgu33WLZQa3
	pfdHaZEN
X-Received: by 2002:a05:693c:8208:b0:378:314:402c with SMTP id 5a478bee46e88-37966e3806bmr3520013eec.28.1794612846033;
        Fri, 13 Nov 2026 15:34:06 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm10726041eec.9.2026.11.13.15.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:34:05 -0800 (PST)
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
Subject: [PATCH v2 0/3] MIPS: SiByte: Add HW PMU support
Date: Fri, 13 Nov 2026 15:33:53 -0800
Message-ID: <20261113233358.538698-1-f.fainelli@gmail.com>
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

