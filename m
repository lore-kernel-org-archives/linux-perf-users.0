Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561289;
	b=I2vJ60883hH2WI5oRSy/KUG5T2hjiBdL49oHDzgfBzmEDRQ6WfRoyaLM6K0aTPXaxca6
	 dqxOtZ3WLmI7XMEfSy0/O7bon/3elnyGp3kRkUv65V8/+cgzG7RAtbOGvNykr/wSwmRXB
	 XOUqU2GGN7MbfVWCrVWvY+4sXNJlGwmfO+qHIfOZ4Ruii6y4837MW/0kU6KiZ0qtPKJgB
	 LHE/VvWwH3iY26Ghz1iS13EXUsySJLSZKHkCokb8dTx+PMa1VrICXiQmQUhzPKiaw9tGa
	 Uex9L03ugU/zuwdWFSsjwt0LlceJJYorkCM3bsvdhzBS21kQnPo0l2U/ctwcI18qK5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=xBs1FXrtXmvLjl73reEk9Y3FZ5A8q9mMB6MAEI1cVQQ=;
	b=2C0Dj8bxjpEQr0fEeWowjhu8608Yt8uJ8Sa1MtMukAuJx0t0Afv60BmS6K43zXuyaZOY
	 bvs42adC8hAoYKHXoic1LObl06FoXZYZ1w7YaWi84BwYPVUBJZiiED/lDSYAyVyiP0heS
	 on0sUYkdp975fbRW4Xxy9NStVfERayz+zeH/vfBisn/sYCnLxpaX3oRV3aD70yuzkIhFP
	 9XfGnj5SZFExWOOO8KuRiwB9okMc8b7TqlDnuH7Qc70l3lMOcW44DmYJeVK2scvSmYh0V
	 hgy6JjGh1QpNCcZqseg/CJBSrHQ81IGOs1gNs1r0Dmx6SZK0TistGvQDk6ssZ/NLzNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBmQNLz+;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DB606A325
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988DB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBmQNLz+
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab37e44643so15027657b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Nov 2026 11:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561287; x=1794166087; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xBs1FXrtXmvLjl73reEk9Y3FZ5A8q9mMB6MAEI1cVQQ=;
        b=cBmQNLz+HLi3WUamlpdNyTa5kw/J38Kt1AfhCW4k62E4ah2me/RYSeyCJP92RKsL9u
         +RQu1pDlWUO48yCJH2bjlCagEOjzpu4vtycsUBLs/4Ff6mA1FVi8y6lYufCb4Dz34fWw
         0LRsZDLUnUsE/LQbvStNonTTv13xz0YSVYhhy+JLd0jy7Ohg3jLACEAerdwc1RE6AhK+
         RZqZE9PTrgehqz5XYZWBemRPFTh7h0wZS7uY8GYOLexqKtnQyyDCtDqThGZqkmYfxXVZ
         7NksyUo3nx3uV4U4CY2qdGiCJQZICO+m+h+GjEoMayR029BKmPfsbI2SUpbmSzrwaUTr
         HoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561287; x=1794166087;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xBs1FXrtXmvLjl73reEk9Y3FZ5A8q9mMB6MAEI1cVQQ=;
        b=jJkZiS46AOp/x5c3nLa3QnldRyj5R66mMh2FV5EFmqYSsQxxwtnwnOpuTty0BneIcb
         dfUJsxxr+ggZKFFZtuGVVw3UYDlxQ7BDDYq9bHwzninwvIeEk8av/nbrVuZQGw/+mgYK
         mFo41dFCnuqn/Zdqrhb1lNNg2Khun5nXuCaisRZn3FUBKK+Pdd1X3PuchMwIwELjL60B
         797zfHHDJrkAPBwufR2Dif4EKmEQuV7FkzuhFN8etp5TNRL/l1ACHRImZXNUD8dQJMsU
         A0fnHJGjPls+gIWr0Ik8CIpcdZEuWD1EH/kF/ccs4ulTDom6axUmnJ03vmC8x6ysKyet
         dN2w==
X-Forwarded-Encrypted: i=1; AKwUvBylZ7dOGM/BPMAnM+GBMRI4inmcJgSwTEVuPX7n5tz5plKaOwURgpoCf5mN2KAwGE/cta6v31yQtwswdcjjSCMA@vger.kernel.org
X-Gm-Message-State: APuU4Z9vInopNhTP6VCPnMdd4Ccz0Bx3YUzk895p7os5aDK9SVzo0582
	rAKCfctvZ1WYcaD8TRAZ0+QyeIMSBRDv4ICwPg4NLd7EHjrcAc/nbsAI
X-Gm-Gg: AYBFou3NXke7QGe38h8/vE16Tr7R1s2buAf3eVGUb3ezq176TU+ccZEH55cwMxuw83d
	+ECtCRP3Ew8UqAOKbN+Nx4fgobFrsSEso/Y30sXvztjxGwpuN71tDgtUvAbvmzx5KoPgyPvMlqX
	WGnupI/B34vdhI1itpUWnj6hbjXtN6CsUUmQgOpMwas9FJPhFpxGScyK9+UIAQU/gmnE5Squvnu
	BEa4ZI+gmCPXi2/H3OYEgIBZ6/NS9nLu0dpv5BaQ7l58kxV6zs1UdOx7UBHx2NKjVn4PenC+27G
	AEFR5YFccvUH7WNzdHK9mN39GzWtITd9pdZFvJQRCRIfCDRrmNg3ywObXmzFFH5x4J8g97WlMF/
	bUPSaR8JHkilfhYAkwpwgT/1Jgq8kHWeEJvyG1zMgxTnn8W+eRwiG/jBULYTID2PlKCadg4X8na
	mJJdK8N5tQnORlHK2Dm/tri0Wy/kXKOLSHLhX4kq4vGDo8Ui6ZsfUTELVSFSPz8lYKNb0heGHQo
	z2I//Lw5fDT1K8ZXoM0hBPpgWUdrCeyztM+1a4qZS+ajEf1EW0bOYYtWtMur53rDmZ79SifHiGs
	nEYcjx4QpYnBG/jrwWa1E/7mwQXDBkCor/Hu1S3U8jhpHJnZuJgn4twZ8YZNbN/u+DXE/CC3ood
	J2+Ig1/r+P5xzobqHU9+s3fYtxLB3fy6T
X-Received: by 2002:a05:690c:e199:10b0:8b1:8738:bd35 with SMTP id 00721157ae682-8b2b66c7d3bmr28247037b3.18.1793561287290;
        Sun, 01 Nov 2026 11:28:07 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7124d97sm40257717b3.15.2026.11.01.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:28:06 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 0/7] alpha/perf: add ProfileMe sampling
Date: Sun, 01 Nov 2026 14:28:03 -0500
Message-Id: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNywqDMBQFf6Vk3ZTk+oh21f8oXcR4oylqJLHSI
 v57E0tBcDlwZs5CPDqDnlxPC3E4G2/sECA5n4hq5dAgNXVgAgxyziClshtbSUdntemwR5pjWch
 SCFVlKQnW6FCb91a8P37sX9UT1RQzcdEaP1n32S5nHnf/enGoz5wyWqdplUGlIWPs1vTSdBdle
 xLrM+z8hB19CL4SDDRXeQYC9v66rl+SnbSUAAEAAA==
X-Change-ID: 20261024-alpha-profileme-6e98a977cb54
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6610; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=/Az2sVPaRkBWHHAQXcuOM2BSyo9jWAaOGCDLpGB9X2w=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeTzqSIHn28pcZ4dX31TOaVFYqSYZv3ff2z06rN7aaa
 bvWbA//1PGRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXHEtgZFhypE0/7q
 Lb+6ItaT+D/y2JzNY/9OHUs3cpfxNVZugyujYzMrRoX54dZ8ft8HdDfI3T9pSLNiWHO/NOPfaJa
 z/paqiynwcA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The 21264 from EV67 on, and the 21364, have a second performance counter
mode, ProfileMe, alongside the Aggregate mode that the driver uses today.
An Aggregate mode sample reports the PC where the overflow interrupt was
taken. On an EV7 that is anywhere from 15 instructions before to 12
after the one that overflowed the counter, which makes perf annotate
output close to useless. In ProfileMe mode the CPU picks one fetched
instruction, follows it down the pipeline, and reports its PC along with
what happened to it: whether it retired, whether it trapped and why,
whether it was a mispredicted branch, stalled before map, or was killed
on a wrong path, and what PCTR1 counted while it was in flight.

Patch 1 fixes a constant passed to the wrong PALcode call, with no
functional change. Patch 2 adds the sysfs format and event attributes
the perf tool needs to name raw events. Patch 3 fixes counts lost when
an event is stopped before its first start, and patch 4 stops reporting
user registers that the entry code has not saved yet. Patch 5 adds
ProfileMe sampling, selected with precise_ip or a new profileme config
bit, so cycles:p and perf record's default event use it. Patch 6
attaches the status registers to each sample as PERF_SAMPLE_RAW data,
and patch 7 adds an option to randomize the sampling interval so that it
cannot lock onto a loop.

A separate series for perf-tools-next adds a decoder for the raw data
to perf report -D and perf script -D, and a script that sums the status
by symbol or by instruction, in the style of DCPI.

The two modes cannot run at the same time, because PCTR_CTL[SL0] sets
the mode for both counters. A ProfileMe event is scheduled alone, and
perf multiplexes it with any other hardware events. perf stat does not
ask for precise events, so it keeps using Aggregate mode.

To try it:

  perf record -e cycles:p -- ./workload
  perf annotate

I tested this on an AlphaServer ES47 (EV7). Samples from a
16-instruction loop land on all 16 instructions rather than on 4 PCs.
DTB misses and unaligned traps are attributed to the faulting load. A
branch on random data shows up as mispredicted in 21% of its samples,
and in 0% with sorted data. A 12 minute perf record -a while building
git took 4.45 million samples with no warnings. Sampling every 10000
instructions, which used to wedge the CPU, ran 66 times without a hang.
On two CPUs, this version survived 26 runs that mix sampling, context
switches and multiplexing, with no warnings.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v3:
- New patch 3: clear PERF_HES_UPTODATE when an event starts counting,
  so that a stop before the first start does not lose the count.
- New patch 4: report no user registers for a sample taken in the entry
  code, where the frame at task_pt_regs() is not complete. An interrupt
  nested on one taken there is still not caught.
- Patch 5: a user instruction whose interrupt is taken in the kernel now
  reports its PC with no registers or user stack, as the frame at
  task_pt_regs() may not be built yet. Thanks to Magnus Lindholm for
  finding this and for the fix.
- Patch 5: also move the counter away from overflow when a ProfileMe
  event is removed, or stopped without PERF_EF_UPDATE, as
  alpha_pmu_del() does not go through alpha_pmu_stop().
- Patch 5: ignore an interrupt that was pending when the event was
  stopped. Document that rewriting a counter does not cancel one.
- Link to v2: https://patch.msgid.link/20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com

Changes in v2:
- Patch 1: explain why bit 0 clear means all processes, although the
  Architecture Reference Manual says otherwise.
- Patch 3: fix a CPU wedge during high-rate ProfileMe sampling. The
  ProfileMe counters are now written twice, and a stopped counter is
  moved away from overflow, as EV67 HRM PALcode restrictions 32 and 38
  require.
- Patch 3: set the profiled PC in place in the trap frame of the
  instruction's mode instead of in a pt_regs copy on the stack, so
  sampled registers and stack values are those of the right frame.
  A kernel instruction whose interrupt is taken in user mode gets a
  per-CPU frame holding only its PC, so the user frame is not changed.
- Patch 4: drop the reserved field and pack the 64-bit fields of
  struct alpha_profileme_sample, so they are 8-byte aligned in the
  sample record and the record needs no padding. This changes the raw
  data layout.
- Patch 5: compute the jitter with mul_u64_u32_shr() and saturate the
  sum, so that large periods cannot overflow.
- Link to v1: https://patch.msgid.link/20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com

To: Richard Henderson <richard.henderson@linaro.org>
To: Matt Turner <mattst88@gmail.com>
To: Magnus Lindholm <linmag7@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>

---
Matt Turner (7):
      alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the logging options call
      alpha/perf: add sysfs format and event attributes
      alpha/perf: clear PERF_HES_UPTODATE when an event starts counting
      alpha/perf: do not report user registers from the entry code
      alpha/perf: implement ProfileMe sampling
      alpha/perf: attach ProfileMe status as PERF_SAMPLE_RAW data
      alpha/perf: optionally randomize the ProfileMe sampling interval

 arch/alpha/include/asm/perf_event.h      |   2 +
 arch/alpha/include/asm/ptrace.h          |  12 +
 arch/alpha/include/asm/wrperfmon.h       |  14 ++
 arch/alpha/include/uapi/asm/perf_event.h |  31 +++
 arch/alpha/kernel/entry.S                |   8 +
 arch/alpha/kernel/perf_event.c           | 365 +++++++++++++++++++++++++++++--
 arch/alpha/kernel/perf_regs.c            |  13 ++
 7 files changed, 432 insertions(+), 13 deletions(-)
---
base-commit: 330517c63aa9b48227b6ab45f01003effac77ae4
change-id: 20261024-alpha-profileme-6e98a977cb54

Best regards,
--  
Matt Turner <mattst88@gmail.com>

