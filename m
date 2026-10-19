Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444833;
	b=BRMHs7wI9mf050XnXj482qh2coi4pn2fXpO8NtzwNcC7mS/lUNer2uWVNFcAMZZNQBTt
	 eh/YQShRP5jn6DA3KPDxYAqgarNetsfU4cQi+x/BW/g1HK+ls6nkjGJG/rSbN5H7sIxC/
	 /h7cfo433khS9pVnc6wW938socD18sA0dhuIrVhF4P8Xr3UCgSh0ZtIx23Lb/j1kN4Tqi
	 /PAB7Ih3BS70LKNmpomzQiqVpHENV73Qzr7n2A4kko1dNK7RitidH/o9PFsGN9Ar4Ee5X
	 SR69bJTX4bkHcIJ/0XxKUBtUKDMlT1Xt9dILuyuV3RlS3jyXzW39rdDB335xZgmM6jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=a9nGiHEGE/ethkm4nwdGSIfsDZebiNvAoo/1PpN/d2Y=;
	b=T4t7HTnpv+Y3GaVuWiNKKcbd/EllULBV42kaK7+04qn8UI8RnPtNP2tTnTiCIFqRXqtd
	 c5NKmQzQkSMl0TVlES0rK50Z8f5B6SwFqZ7hQ+nbcXU7p+hfNuRZUjAiQZEt0BHtCw/HL
	 4mFjMsjMLXnWizi6CdbdGVax1cvEJmo+3lM2mdS4ffq+YCQZ35pEEWS4xDgzjp9pgU7S/
	 0M/2DJcoPyKVYt7lh3ZSX0wSGwjOOreLblDra6tPmv5Ozu03lKh+BZjKx+GB8cI7xAnud
	 HDI9dZ7uv/RGsbejj5xpDrnGzvb9BciEZL1iROd2w6gUvXM45YxnMtAp+lRM13+8O6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ot9BcSTR;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE169606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 21:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE169606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ot9BcSTR
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so1439565a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792444832; x=1793049632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a9nGiHEGE/ethkm4nwdGSIfsDZebiNvAoo/1PpN/d2Y=;
        b=Ot9BcSTRPFSCycD31/akOPwFiA7j3uWcueEHQZw2ejy/vS+7LzzlJ0gk0TL39C0RGY
         hBQLkQIiSW3S7KhsSn2bp3nUrRvQIUeUmStxjQP48JBOB6rTtlWq34NiWfpWmOv65r+B
         ZIQTLOlw9xjFwlFrIpzF4whV36UFViF+DrEmpvl8PqMLe596150DGxKN62isuHz6TJiv
         zoWMV4UFJEmWeFRBCl02XY5L2WhIrsVqwFHnFmIU47qsDDG0M10qz170rYRqDl9cgeMy
         ooq0WwHB9rH1k9yOw0Vxy5TdHhtojIYw8fomnu+JcXQHmxsGJ2EfcJW4IATDM0O3NIfA
         TKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792444832; x=1793049632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a9nGiHEGE/ethkm4nwdGSIfsDZebiNvAoo/1PpN/d2Y=;
        b=NgH8swvVtIXng7Uwd4pASdWpLdUug2A33XINfoZusj7CW/PYytWauGzGMrbiOz7FAB
         a4FRH7fGStefzYDui0A57iRB++nqQpBZUblSGEfIa+Yji+88B98jRBGkl+as61ii+ye6
         DyqwYsB+PbG+bg7FMaL4lboMcyIT13TnTK2px6ChclxAJSCejVnw/e+Az8xKW1AypIWz
         MdXi21Q/x9f2HiiMl+g1PwBejv/0uiHOQMuWEkGNgfAEw9HlFSdOKDAKPfIbE3OmS6Hx
         8pDo9vgk20oKJzLicYR6imD5AMEJFKpxERkggPLvosij9ZzgZ6mwxKkE6mhJsY+yDNDw
         23ew==
X-Gm-Message-State: AFq9FYJyYtDBVTUdEESJ+3eDUEdWhNT8FSlZv4im86QyUalNfR1Djylt
	I8/XPktpw6I2S53Ifp3SudwNCtmYBgiwZMJtIyWZ1WkLhRMp3K+RzQOC7C47R+Tf
X-Gm-Gg: AYBFou3VqFOnoNbtZrZ+Ka5yKFEZ3mEyM0oKlH13pl5d0yAzJC0q+oba43bf6YJG6+t
	iogwtxRaNvLwJ5k/EI4q5Acb0aLMU8KtayHjohrIEyERmS0WvwLoZMIbeDGOCHeVzEHBaTebQJV
	rEn4YDbql79KZ4QKgPQMrKNcnU6jxflM3Psw8PWW8MFcrwsFoe7FhXl9WoWySqTBjcqRO3rSjrm
	JGNruUSHN4HLjEU12tGE7qrvVRQXZJz+ib2G4PDONAs/RnJf8KX+mt1lo1fg+PSktTDUx2jn2l4
	BJ8sGj40dFFPcS/pszdA0Es1IDdD3paxBnBqfkTwFbHfVRpm3vUytByvmk8yw509P9APbDGHS4s
	YNtBMQDzT1RKvblSC/aMpuIhgxhzCJTBKxkHoJD/Yz205g/hrCDvnMJ0p9wA3/KfQkGrVw250hp
	o685NNb6z9pFYfVq0GBya4XyL25jgPhEW8NzkiyvMptlp3jzZ4OIOOyXZlc5fZV3ilpRyUitQ7d
	6QuZWQFY1DVnxL1CcVHv9YzmbXZ+8XSyAQDEbG3blAoKxloBViUmQmVhv0=
X-Received: by 2002:a17:90b:39ad:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3acef56d59emr7934717a91.46.1792444832023;
        Mon, 19 Oct 2026 14:20:32 -0700 (PDT)
Received: from celestia ([2402:1980:8cc:45bf:2ff5:22f4:3884:844f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60fee653sm839652a91.15.2026.10.19.14.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:20:31 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Manali Shukla <manali.shukla@amd.com>,
	Jim Mattson <jmattson@google.com>,
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
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Liew Rui Yan <aethernet65535@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: perf/amd/ibs: [BUG?] ibs_op sampling silently stops on Zen3: MSR_AMD64_IBSOPCTL latched, no NMI delivered
Date: Tue, 20 Oct 2026 05:20:19 +0800
Message-ID: <20261019212028.119312-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hi Perf Community,


I found an issue with ibs_op sampling that I can reproduce on my AMD
Zen3 laptop.  Under full CPU load, sampling PMIs stop arriving on each
CPU, one after another.  Reading MSR_AMD64_IBSOPCTL (0xc0011033) while
perf is still running shows the hardware has latched a completed sample
(IBS_OP_ENABLE=1, IBS_OP_VAL=1, IBS_OP_CUR_CNT frozen) and is waiting
for an NMI that never arrives.  The CPU never recovers on its own.

I am really not very familiar with CPU, so I would appreciate any
guidance on whether this is known and what to test next.


Environment
===========

- CPU:    AMD Ryzen 5 5600H with Radeon Graphics (family 25 model 80,
          Zen3/Cezanne), 12 cores, microcode 0xa500012
- Kernel: 7.3.0-rc5-mm-new-damon-1 (self-built from the mm tree)
- perf:   perf version 7.2.11-1
- Also running: stress-ng 0.21.01


How to reproduce
================

Reproducer is here:

    https://github.com/aethernet65535/amd-zen3-nmi-lost-reproducer.git

The essence is a system-wide ibs_op record on top of a full CPU load:

    perf record -a -e ibs_op// -c 100000 -- stress-ng --cpu 0 &

and then watch the per-CPU PMI counters in /proc/interrupts once a
second.  To rule perf's dynamic throttling out as a factor, I set
kernel.perf_event_max_sample_rate=100000 and
kernel.perf_cpu_time_max_percent=0 before starting.

Reproduction is fast and consistent: the first CPU goes silent ~20 s
after perf starts, and all 12 CPUs are silent within ~5 minutes.


Observed behaviour
==================

Found that per-CPU PMI counters (/proc/interrupts) stop incrementing.
From the most recent run, time from perf start until each CPU was
detected silent (zero PMI delta for 3 consecutive 1 s windows):

    CPU 1,5:        +23.7 s
    CPU 2,3:        +31.6 s
    CPU 8:          +62.2 s
    CPU 9:          +68.3 s
    CPU 10:         +96.9 s
    CPU 6:          +166.9 s
    CPU 4:          +192.5 s
    CPU 0:          +198.5 s
    CPU 11:         +220.0 s
    CPU 7:          +271.3 s

The run then continued for another 120 s to confirm if CPU comes back;
none did.

For each CPU at the moment it went silent, I read MSR_AMD64_IBSOPCTL
three times, via rdmsr while perf was still running.  Decoding
IBS_OP_ENABLE (bit 17), IBS_OP_VAL (bit 18) and IBS_OP_CUR_CNT (bits
32-58):

Live control CPU 0 -- IBS_OP_VAL=0, IBS_OP_CUR_CNT keeps moving between
reads:

  read 1: raw=0x231f0002186a  IBS_OP_ENABLE=1 IBS_OP_VAL=0 IBS_OP_CUR_CNT=8991
  read 2: raw=0x10ca50002186a  IBS_OP_ENABLE=1 IBS_OP_VAL=0 IBS_OP_CUR_CNT=68773
  read 3: raw=0x15fa10002186a  IBS_OP_ENABLE=1 IBS_OP_VAL=0 IBS_OP_CUR_CNT=90017

Silent CPU 0 -- three reads are bit-for-bit identical:

  read 1: raw=0xc80006186a  IBS_OP_ENABLE=1 IBS_OP_VAL=1 IBS_OP_CUR_CNT=200
  read 2: raw=0xc80006186a  IBS_OP_ENABLE=1 IBS_OP_VAL=1 IBS_OP_CUR_CNT=200
  read 3: raw=0xc80006186a  IBS_OP_ENABLE=1 IBS_OP_VAL=1 IBS_OP_CUR_CNT=200

perf report --header-only excerpt (trimmed):

    # os release : 7.3.0-rc5-mm-new-damon-1
    # perf version : 7.2.11-1
    # arch : x86_64
    # nrcpus online : 12
    # cpudesc : AMD Ryzen 5 5600H with Radeon Graphics
    # cpuid : AuthenticAMD,25,80,0
    # event : name = ibs_op//, , type = 11 (ibs_op), config = 0,
      { sample_period, sample_freq } = 100000,
      sample_type = IP|TID|TIME|ID|CPU, read_format = ID|LOST
    # pmu mappings: ... ibs_fetch = 10, ibs_op = 11 ...
    # cpu pmu capabilities: max_precise=0


What I think I have ruled out
=============================

- Not perf's dynamic throttling: it is disabled (percent=0) for every
  run.
- Not the kernel stopping the event: IBS_OP_ENABLE stays 1; the event is
  still armed.
- Sampling does work normally for a while before it stops, so the setup
  itself is fine.


One more observation
====================

In earlier testing I noticed there is a workaround -- enable NMI
watchdog.  PMI counters start incrementing again after it is enabled.


Questions
=========

1. Is this known on Zen3/Cezanne?
2. Any recommended next step?

Thank you for your time, and for all your work on perf.

Best regards,
Rui Yan
