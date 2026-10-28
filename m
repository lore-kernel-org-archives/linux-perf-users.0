Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211026;
	b=0q1ZjnMJ2GtnzoE/TL+LqOjiYKo73XwIC3yXL7mL8vZJJ0pc9JBlrMFA6gEUarENq1vQ
	 8RwCAxmhFs9/zo1lspQOpLngWcrTy0bw4+t2/ACksKKPQL9JwpMuM5aSYgwYQUUyRmec6
	 Wro+kA4uQ6F8LshP/hx1ZxCxbYRpqw5B7XgN1n/p4GmA3UevOTYI/MH7kcAzRzfQSPArE
	 gkEI8cGL8NIQS38YArRVEUF3MijoZy05+6zEf3ldCRxQ2XVvM/z279dHaAc2l9Z7GP668
	 V/FBGWk32FxDwW1n2Rhkj6LrnQsbbdVTPy2nV7ye8RLG/s8ZYuUlt+8eZ5ZfSrXl3wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PEsFmHwDP1UG6mxKZCd7t69d9iU/+Kdp2tnQbYYT7Gg=;
	b=T4p41Jiv+4+s0x0B8jfPCb/nTgxtyUOpzJQSWazPdYSndiZjCCxlO0srnzf626ZhSld5
	 w/E3vA6bVbQzV9NIy0+pOMbEuOdk6mhCyXdwBwopMdKHmd19ANIViTqbCg+T0HTkG6+BG
	 qvblnlWzEovBWQ4077Z5/yUi8i9oYBL6DfBGiT9ey/Ke38rdGjr3y5rUddf5zBTCZTaNU
	 GfHDOXplifPSYbY/lwtJ3IlGysSEAUF6kN7UHc42L5k4s0E0G2cg5cTpzZH4+LFbtnu3O
	 8eDm+srsrfBEspyychngVps+Oefu4ejHSKOGLKT6fRE3DZ985YTS2wvbc1VgLtnLcvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FbA57hZA;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9A606A322
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF9A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FbA57hZA
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8a83d2706fdso12101217b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211025; x=1793815825; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PEsFmHwDP1UG6mxKZCd7t69d9iU/+Kdp2tnQbYYT7Gg=;
        b=FbA57hZA3sh5y/MJczD0fiHrpyfQAuF6nkWZpF/4+/7zalbgapirT19ufYH3iP8GBY
         2uBIdBGonUh5K2Y83Thx5xtOgcd/wSurpGrcJbgRO7QjU2LRfTEzS+T5219WJOEDU/Sr
         u22+5t1GBYYquB7BiUx5z9fKqntdM7yX8HhIbW5Uw7iVurJxEmJw2quvzBVPFfJ+Jnb0
         /l1vuDGKLQQQa+Xcv3eLPzwOtj0+ffa0hzEeiUx0aex1LT+E14exiVCHWa3tDCcx/8H4
         HdY3J52FOvsGr0kfNUeFz+lL6vygtCTV4BnYzxEEJw0FdbOrXr74AC4ApmgE5DWznKXh
         N25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211025; x=1793815825;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PEsFmHwDP1UG6mxKZCd7t69d9iU/+Kdp2tnQbYYT7Gg=;
        b=mjPgNBcT7FGKV8ZPTkv7aHXAfsXhxSzxsljyFgpiM7HvCjmWOXg1vZ8k4x1eNAQ4Uf
         AMUDrQd5VJcAHyQGES3y9ZtG/q9kLyr72YMGrazxxaQfK9vudJhb8TMe9QvuKJnIP7b4
         oSMGxJHZXC9VEozj+ZgfwVmGtZ+7CLQ85sLOIn5Te+f3R4a3yiO0cn8VCG+sRYx4J80j
         dAtvD/WxvAWyfojtMK+YbgY/7x2FkR0HDi5ECJX4+BEdEgD3iapjp71PYT6zY75wi72O
         ON0Fu0bshI9iOCtPib2Fq9qFSiolLiIRj1x/uuMYr6mZFRdmNtxS2bMv4sAfxYXPiQBT
         rktw==
X-Forwarded-Encrypted: i=1; AKwUvBwEiKKMeoq3bW7n4KkM0w47QTJCzKZvj9bAzdKqz+kaW8qaC96R5PItIQEw8yNiJFrbnXQ6bkjfhaaQaqMboZy0@vger.kernel.org
X-Gm-Message-State: AFq9FYJsxg9YJUO4Q5LsFmIXAqUBGls66J9xlKkTfFm6MzYq861tT6PW
	3pShlQYyl033HPjYvcA3r6iaiXIjEvGipy86hFtiessW1eCNUNedVDmW
X-Gm-Gg: AYBFou1X1TJkA/fNdFdOibPVeavQco040x2f+x5NqdipGkWnv+OfSea8Z4kd4nPNat/
	71q6W6kBuDgXMhndCif83HRHEQ3Nh3D0vFj3Pcn6zaEclkoE+dQg0mP5R6gm/d9W7Z9raWtiypM
	/p3YJAdBVALG1yYAEHm1Tt+Lo1C3i1kah3zn3PHzSLYpOcLkAyK1x6k1omzMcbuzyDPKfYk87k9
	17z3tfS9pHKSZoNFd6ilRzYlR30hvWOoQK0AW8mhjtWAYAr7N6FjeYXkHHEpbgimIUqIy/VK5yA
	ljq7UcWitWEww95nXV7LnqQ7jW+AWtzcxzkFZPRVxK379skgMkITHI28XHq/xOcWVx7Kgn1A/u4
	zkgzeM/kxudVshMVoO1LUMeylzFNoZ6qlU25ZODeJDivL13CI7BIfzzgM4IIbA0dBWXhhuudyTh
	CpufoD+yJLpnvvHtTPbzkM4sL4zzrpYWtT5O9sE9vzJLgvERPDUO2FppkmXKn+tNsvCpSUc+RFO
	USaPwpJAY2zRRasXDbqL/Xp04yJhNCvqVdv2iM4SKMfYXvQPupGfbGE26ncATCWTg9vKzlUwr4O
	06fyYhG4FVgv3v74x9TlC+zPKWdL6sNfyTOo/B48SbAT0BfS8osJdf5nvdK4t4WDiIjraTQSnmJ
	5UIVmmSoM4w==
X-Received: by 2002:a05:690c:a0ad:10b0:8b0:dd32:d6ca with SMTP id 00721157ae682-8b1b5c31f83mr14171727b3.59.1793211025228;
        Wed, 28 Oct 2026 11:10:25 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5c7d50sm32883317b3.30.2026.10.28.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:10:24 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/2] perf alpha: Decode ProfileMe samples
Date: Wed, 28 Oct 2026 14:10:23 -0400
Message-Id: <20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPnchRhD1KqUPUSe6YjVsbBHEu
 5vWx49h/oMiVBCpyQ5SfCXKuiTkj4y60S0DWPpkssaWubEVB6hnN4fRcdDVy4w3uDJpq+sWhS0
 oXYPCy/7PPl+346ed0G2/Fp3nBQCWlD54AAAA
X-Change-ID: 20261028-perf-alpha-profileme-8010299be323
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=0q1C3YhEO9HEq0KCnLp9he/zxM/6Cz1+kQq6ZA84tOU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIeWfWr2wrH7tnrtS9r1sr5v579vmC6cUvXtVP7hV723
 a+I2rU+reMjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCu+W3N8D++16ld7v
 xMsao3S/3XT5hbv7s3VnPb9hZlg5UCugUs5TEM/91md1aVOnYejPAvO3Wnh3HFWf7uYq4Vh9+Ui
 bBUT/99jwMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carries
the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
PERF_SAMPLE_RAW data, which says whether the instruction retired,
whether it trapped and why, whether it was a mispredicted branch,
stalled before map, or was killed on a wrong path, and what PCTR1
counted while it was in flight:

  https://lore.kernel.org/r/20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com

This series is the perf tool side. Patch 1 decodes the raw data in perf
report -D and perf script -D, as is done for AMD IBS. It copies the new
uapi header from the kernel series into tools/arch, so it should wait
until that header is merged. Patch 2 adds a script that sums the status
by symbol or by instruction, in the style of DCPI.

To try it, with the kernel series applied:

  perf record -R -e instructions:p -- ./workload
  tools/perf/python/alpha-profileme.py --pc

I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
branch tests random data reports that branch mispredicted in 21% of its
samples, and 0% with sorted data.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Matt Turner (2):
      perf alpha: Decode ProfileMe raw samples
      perf python: Add alpha-profileme.py

 tools/arch/alpha/include/uapi/asm/perf_event.h |  27 +++++
 tools/perf/check-headers.sh                    |   1 +
 tools/perf/python/alpha-profileme.py           | 162 +++++++++++++++++++++++++
 tools/perf/util/Build                          |   1 +
 tools/perf/util/alpha-sample-raw.c             | 133 ++++++++++++++++++++
 tools/perf/util/sample-raw.c                   |   2 +
 tools/perf/util/sample-raw.h                   |   2 +
 7 files changed, 328 insertions(+)
---
base-commit: e74880764bf94b738102b4b6b6e8304d0c8375d3
change-id: 20261028-perf-alpha-profileme-8010299be323

Best regards,
--  
Matt Turner <mattst88@gmail.com>

