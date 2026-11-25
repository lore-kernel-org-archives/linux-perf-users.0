Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579223;
	b=zSJ04OLcnE13mVz1Zlot9Bpo4ltVv/XWU68DWngmGThFW37jyzk9UCJlTDtY9jQuVMZt
	 RxSrkkdwJ6KIwJbLW0BZfvEBpEE9EXViaWjmEl23If4AZP5rYcE+PXHQouWaxrtYGOhvK
	 jFXK8wDotIoltx8xY3lz8PWiw0RKCJYO9xvjNeTK2qeGFvyW7yd/MKSaR8lPnLCL6wfS/
	 qhPNCURxCWnvMEbZNYs1aF9DnTPqAQj5QPoBHgZcNGkfZLZGg9npiQ16T0ArfFnDDLlG9
	 BIdTm9lkGyBMdOVUUVNQd0priinN/zJA1+T42MVhF9KKL7c4+f0Lu6VIfDguiJl+SdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=h9Hto31Ei8twsoteptDahJHqXFA5GSu7dTamilsJIHo=;
	b=fosD6wsxXPDHfCg7aH4dt0gGtTn4/S52ooA4GpSiC6oNTCd+BUk2hCBH874C+3qOXwm4
	 FOJgSlpZchW9aV73Pkrthryowv4d3DL2kPhg4wRp5qrYgol4zKFS1o4Vbr9yJtgtBAPMX
	 pjJcuZOEA4X9Yr2NUpja3ae6FmF2r+Kxr6kGKby1FfK/hqYIFQvExmMzQIqY1DjM54IW+
	 qySIRGHU6IKPrtcqqYAzWyZC2n4OFhyXWwUqTgwHWSdSlMoZhWjW3wvftkW5VB/KMqT+n
	 9UDMUpS1Ic2mx5b0nYRc2oaj59rO2WMVbSRGoQEeqA4Kr2sPpOpzipSvpSMBNXcyAMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QNHcF/N0";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC3606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 04:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CC3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNHcF/N0
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b546061d58so11951694c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 20:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579222; x=1796184022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9Hto31Ei8twsoteptDahJHqXFA5GSu7dTamilsJIHo=;
        b=QNHcF/N04NV8ILM8qkEX/s8SIJpCEw58cumyVq3qBS7wxFx5DkJ6YmQ7zpBgCcg8me
         /k7RWICtD5HPtKA9ac2COBlXd4P1hMiCaOeQeGDM3FWWQvG1hJqiGBPHFxQI6W5NtvHv
         hIY1yszW22yzTOhl8EFTHg5AFRQOAXdZSWxv+HwVVcqSMXCzQBD6//B0yfSlSdi47Y+E
         eZ8dkCE0aeRxdHTp/DloqtWL/6l1vf57xSBrxGaduQr6Pe490MljsvdT6h0VGTypqLHY
         90h2Uuzitw0FBu18rlvfmsjoUd9rpe7ub2XjlGCjsutosGJ6iCmgBavvn+7QEI6VJQZu
         1F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579222; x=1796184022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9Hto31Ei8twsoteptDahJHqXFA5GSu7dTamilsJIHo=;
        b=KTyxiegsJHnY8hz7qZRnlVNQOGn5FCEj3XI2UWacPUvtlfwxPgktfM+mRG0sHVXFBs
         f5GGFweEPQRMpJ7PXhOfmrDHKKaEidH9p4pHxv7TPLMr3NEA2T+REBR3YDc7hmrbTEL6
         jysvf42lvEhIT+wIVZj02KPlDzD85g9qQGpJihBAvth0QOpob61YbFVRgr3RctKIUc89
         cfDZMzsxTOFLDI8WYzI8K7zc58zR+Ph3LfFeiDplnti/gptgo8VljEF17hj7tro8IQmf
         EGgOSO+vZUU2uakjQ5N8tgOth2Duz9v7+90j9mxBeExRpTrJJpYmi7lbQqnQWQtNcRIV
         QpDw==
X-Gm-Message-State: APuU4Z955Eir4nD6neuUZzYiT/NbmPpxStjaDhcMmylGAXJczLXGcUci
	nbjR1ar2D9wVlM+EtafZQ2HmTkJ6M4UzE/6KlNv0v2Tl/dlWex4gsO3b1CY+kokH
X-Gm-Gg: AZFdTZf5dsdNZS2RkxKoByTbghBERez4pVk+uxjIRkuYy2uP0m3xzf+PcBFNoNr6Eye
	Bw//Dxk0oldgFyEwXGO7ELJsjZbV7mIR/eEBYK4l2s+MMKfpvy/lfL5PUYvHmBOTakyJN6fAyBS
	xhLqMTrNH5JXKJROZSGyjjcQm/jFmbFhpYQ/fY0YrKMg8UBhGUP+6F4+/n8QrGSDsbjwH/5YVon
	UEalx7TnZPkbXhyNGK1EQuUQsWvnjvRqjjpJVV9tIbvBT2BHgqAUtCsDQfR25Dn6YJ0dZsP7TYz
	chkin/ZwAGijJ5c68OMBNedcIKFKvqeOecz5/yDIUfhpMM9tTodoyJfGb0VgugPv0KfT+urRUPN
	EUEmezMDB7x0QOZznJ3bpAepuce62CJdFqJ4sE+bZgWjIXMNVkLtlB5iSXHrZ2GwDVo/GniY1bP
	J4haaIql4c8gXiuUKQneJSz7M7Uu+REbYv3Iw0bHLLAEv06oJX2klSGoi1Y0cxnd8l46/Aog3vF
	65D3mJ3yERevfq6xYtIx10dWrMC/n/Q8CmZSPnYnrSE3HDXoILrzh5wVrv5+JYoEIOCZ7Zp+aVi
	IGqsKwXRwsqumI3ICbNSuhsB58whb2saeqjahobB0g==
X-Received: by 2002:a05:7022:f50b:b0:1b5:2de3:bcfb with SMTP id a92af1059eb24-1b5568ee8famr18413134c88.25.1795579221616;
        Tue, 24 Nov 2026 20:00:21 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm57094127c88.14.2026.11.24.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:00:21 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v13 0/2] perf jevents: Reject unknown keys in the JSON tables
Date: Wed, 25 Nov 2026 04:00:14 +0000
Message-ID: <20261125040016.1675748-1-takano32@gmail.com>
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

Rebased onto perf-tools-next, as Namhyung asked.  This is v13.

The rebase drops the AMD hunks from 1/2: they are already in
perf-tools-next as commit edd09316bd37 ("perf vendor events amd: Fix a
misspelled JSON key").  So 1/2 now touches only the arm64 file, and its
message no longer claims to carry the AMD half.  1/2 now fixes the 16
AmpereOneX entries that spell PublicDescription as "PublicDescrition";
Ilkka has acked the patch, which is not yet in perf-tools-next.

2/2 cannot land on a tree that still carries those 16 keys: the new check
fails an arm64 build on them, so 1/2 comes first.

The diff of 2/2 is unchanged: two hunks in jevents.py (_valid_keys and the
check in JsonEvent.__init__) and jevents_bad_key.sh, which checks the
failing case only.  (metricgroups.json is a plain dictionary of group names
and is not checked.)  Its message now describes the test and carries
James's Reviewed-by from the v12 posting.

Measured on the rebased pair, on top of perf-tools-next (148690b95cc4):

  - make -C tools/perf -j2 NO_PYLINT=1 exits 0
  - jevents.py over arm64, x86, powerpc, s390 and riscv each exits 0
  - jevents_bad_key.sh exits 0: NotAKey in a table makes the generator
    exit 1, with "Exception processing <path>" on stdout and a traceback
    ending in "ValueError: Unknown keys: ['NotAKey']"
  - grep for PublicDescrition and BriefDescript6ion over
    tools/perf/pmu-events/arch/ finds nothing

Changes since v12:

  - rebased onto perf-tools-next (Namhyung)
  - 1/2 no longer carries the AMD hunks, which are in that tree already,
    and its message says so
  - 2/2's diff is unchanged: same as v12 (patch-id 8be9ac914f80), but its
    message now describes jevents_bad_key.sh and carries James's
    Reviewed-by
  - the measurements above were redone on the new base

v12 was posted at
https://lore.kernel.org/linux-perf-users/20261120134252.1036963-1-takano32@gmail.com/
The rebase request:
https://lore.kernel.org/linux-perf-users/awTB4cryDW4H4no7@google.com/

TAKANO Mitsuhiro (2):
  perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription
    keys
  perf jevents: Fail the build on a key the tables may not carry

 .../arch/arm64/ampere/ampereonex/mmu.json     | 32 ++++++------
 tools/perf/pmu-events/jevents.py              | 24 +++++++++
 tools/perf/tests/shell/jevents_bad_key.sh     | 52 +++++++++++++++++++
 3 files changed, 92 insertions(+), 16 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_bad_key.sh


base-commit: 148690b95cc425950dbba79d73eb4f7938347fce
-- 
2.53.0

