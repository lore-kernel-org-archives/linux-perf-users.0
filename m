Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE1101C5;
	Sat, 18 May 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716022662; cv=none; b=c7lZVqgUWLAIE6qlgoQrs3u5ZaHa4BNLSYUxiFP4p7KEOBesBPJpd+E7jrXQutMsoW/l3Ebie9OeYXqAuXjDWTP7k2Bzv6T8E8Ue2lqXeAGqsJhmActf4mHfPDPBnTEISMIbhBbr+IEBj6VfxVMPZirft3oZZ05mnuiDDqyHqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716022662; c=relaxed/simple;
	bh=WPNaaqY2Gy5fgWRxaP1eGpp0fng0wzcYb8gE20vwcHI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bblIGLo19OS04GyAcDFK8hl+qCx8+sxoEEnD0K096QFHZezrsMHWFzjh4OcpdFn3RNpA1VmIXidPtM23k79i1rnL9HGHan+ogwcLpmevbwB4NKH4XaFhIYd0vCVtueu4mEFUhB5+UY5cSCd+X6M5WYVUMMBDtV5siYGQ/2aAuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIweKlnn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIweKlnn"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-573061776e8so5791574a12.1;
        Sat, 18 May 2024 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716022659; x=1716627459; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jaqz2ZrWehON9cGP/EiPqc2gl/vttfWZz5YDeWMDnHw=;
        b=BIweKlnncA8Z6eKAiv9+f9FmbmN7+PlX0X8scHE91VjlFRkpHrxAowac7Hof0CU7vi
         L/D9YRyJ2lFtXSsUEF0091qoyEDwG2NCHZcoD7hDhoSXeruG9guuFDwHS/EhNEqGy9Ca
         8f7qPqLvaRNFRJWuK3M8E2LFsVH7Edn+4Ai2JXn2L9rfJe8ydtP64ChFxrVuKyVFOE92
         mIYg0AqCAKhoyfBUxugnOKx/GevSLDSrT/e+p07I7AWfD5E1J2VhvFXsmLul5pT15END
         cdiEt/Z6W0C+cfz6pHvGsgDuIb0xXGHivVD/mcePBSgWJrlyqfvbTaOvUI+4GcXZRLC7
         40iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716022659; x=1716627459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaqz2ZrWehON9cGP/EiPqc2gl/vttfWZz5YDeWMDnHw=;
        b=h1UWf3GP3OGIuRrSEeS8DwIwvgKkv20OJghd3svYT27g1kV3Czr0R5mFO7fCYnbxoX
         CX9eHCVb1aF6Rp2Rh6S4ve5y1mBqukkrFHL5gCDYo9aCSvkmXN/2PERdZpqIabx1eq/x
         ReqipXASFXOENMH3N/ZgJcq06skEr/r697n+IJ5hy9+HikFR5cvkhmun6vBkWwfG/KhE
         ny9uuowZ1pD1ay8Dv49OHjdQnkkHsk3CzEafdRvOoN/4VQWwNoyAUXzC/sUQ4L8MobIH
         9ITN8xqZ+eyCE6dXy6hFXrR1+ukYPlAZ8JXkZjw5Yhs7E0ebqowSgOPYbUbnYbDw+w+b
         WocA==
X-Forwarded-Encrypted: i=1; AJvYcCUruxxBCgMfRQBLngBjzVj7bc0fFu8dUGLZzyMQZebMxDM2BYiJFpOmD5x0YUT+89sCL1047vND5UUQ54nRSjOBuHWEZoDBerwAgaOB9W4zwA==
X-Gm-Message-State: AOJu0YzEpW5PVoVU35SQuens2Jq1cGpZHHyV3lrX6zFJn1OaJ/5fbRLZ
	37RXK2FpPvbKQkJDRlvaVKUkdtoLWYIcM2vwwUJ27oaMIE5WBA4C
X-Google-Smtp-Source: AGHT+IGhYC5wF2sUrqeQat7DamHTsP3VdzluHpndjkaM7PLD/NCLxMPf5puD8CMq1rtLYBSl50+mwg==
X-Received: by 2002:a50:8e18:0:b0:574:eb69:fadf with SMTP id 4fb4d7f45d1cf-574eb6a1d01mr7501077a12.36.1716022658064;
        Sat, 18 May 2024 01:57:38 -0700 (PDT)
Received: from gmail.com (1F2EF1AE.unconfigured.pool.telekom.hu. [31.46.241.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6557sm12791372a12.13.2024.05.18.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 01:57:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 18 May 2024 10:57:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events updates for v6.10, #2
Message-ID: <Zkhtfutbppql4/p7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-05-18

   # HEAD: 9d351132ed706ae24325809afa821cabf6d72568 perf/x86/cstate: Remove unused 'struct perf_cstate_msr'

Changes:

 - Extend the x86 instruction decoder with APX and
   other new instructions

 - Misc cleanups

Note that these commits were delayed to after when/if x86/cpu was merged 
upstream, due to this merge dependency:

  10ed2b118116 Merge branch 'x86/cpu' into perf/core, to pick up dependent commits

 Thanks,

	Ingo

------------------>

Adrian Hunter (7):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map
      x86/insn: Add VEX versions of VPDPBUSD, VPDPBUSDS, VPDPWSSD and VPDPWSSDS
      x86/insn: Add misc new Intel instructions
      x86/insn: Add support for REX2 prefix to the instruction decoder logic
      x86/insn: x86/insn: Add support for REX2 prefix to the instruction decoder opcode map
      x86/insn: Add support for APX EVEX to the instruction decoder logic
      x86/insn: Add support for APX EVEX instructions to the opcode map

Chang S. Bae (1):
      x86/insn: Add Key Locker instructions to the opcode map

Dhananjay Ugwekar (1):
      perf/x86/rapl: Rename 'maxdie' to nr_rapl_pmu and 'dieid' to rapl_pmu_idx

Ingo Molnar (3):
      Merge tag 'v6.9-rc6' into perf/core, to pick up fixes
      Merge branch 'x86/cpu' into perf/core, to pick up dependent commits
      perf/x86/cstate: Remove unused 'struct perf_cstate_msr'

 arch/x86/events/intel/cstate.c             |   6 ----
 arch/x86/events/rapl.c                     |  16 +++++-----
 arch/x86/include/asm/inat.h                |  17 ++++++++++-
 arch/x86/include/asm/insn.h                |  32 ++++++++++++++++---
 arch/x86/lib/insn.c                        |  29 ++++++++++++++++++
 arch/x86/lib/x86-opcode-map.txt            | 315 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 arch/x86/tools/gen-insn-attr-x86.awk       |  15 ++++++++-
 tools/arch/x86/include/asm/inat.h          |  17 ++++++++++-
 tools/arch/x86/include/asm/insn.h          |  32 ++++++++++++++++---
 tools/arch/x86/lib/insn.c                  |  29 ++++++++++++++++++
 tools/arch/x86/lib/x86-opcode-map.txt      | 315 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 tools/arch/x86/tools/gen-insn-attr-x86.awk |  15 ++++++++-
 12 files changed, 630 insertions(+), 208 deletions(-)
