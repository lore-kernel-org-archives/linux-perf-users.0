Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEA25949D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346494; cv=none; b=Wkxq4UTJ3GsWTvlKt8Ow1H3yNJ/OjO9ut5eJEz2W4j03YZx+a+YuL+J9Nx3n7I2+jg38viZdZGIqTESraMcTL3t9/RD2HY+6/0r/GHD3mFot7zuDr5XfcxPpTqj+nKt3vP964kEo2jwHKw1k0/4vBlJktz9bblTbXdW9C02Zxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346494; c=relaxed/simple;
	bh=EbaQIPivd3k12R9u+2jbA4uZjrTwxRKMILMWyBbew2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNvgqGgkTr3XxQL+T7yapxFQDAb/6rPK4/zDNILQkQAZgkKCZ0oqYiUQjAvh1rgGMiW30/wjWnjTfNtTlf7/WaTm7SfxgA2yuK61r88s/SoMZE1077g4dqk7Uu3XExl4YUA6XPQXmokdkR+i4bOrWvbN3pfzwNc1W3Rqqve3V6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnlLQYTA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnlLQYTA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43624b2d453so172705325e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346491; x=1736951291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DTjVFlw3a1BE3G1k/Oc0pCRnQoWK8WuT3gO6hdQWPM=;
        b=hnlLQYTAdsXICHCzSALVIWGTCGPfK3iT+bq6XprmbQosiylioVU0GpsSshmSD3aBS8
         fxKoJ6IJn6a++l34pmWF/JfdUPWM+XjQO+ijaNhE9PcgCG2hPahbbiMqvEA8xMF5jtpv
         WYHFaIbJ8RutA0LgYVGB/6Yeff7G4eosb6O0bmDNXUgNg1uY+cLJMpoMPtGs7qyVWaBl
         f5vH1lP69fmxlEa5UOV7Wd3KA05Ph+/MqcVI7d9xBay6aitryEg16ERoSmlGBmdR0DOW
         YIHyJixCPVp+XdZcbAf9SKV6KvcqpblusPgmcJ26XEQ5g2BuJISOx+uWrVE/j9+F+JJY
         LuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346491; x=1736951291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DTjVFlw3a1BE3G1k/Oc0pCRnQoWK8WuT3gO6hdQWPM=;
        b=oU0XUmIkF0YnplIrhddR8ChZRB6PfzUGgww3Q3IyInXWOulI9jT6AnU289XM27qh40
         PDKJdhZ1rRYqwf29MWGpezFns8XU8yizsZlFdtHYNrjStqBU4joEnjX5LRKsbMMUuUB6
         W2HUKtV3eNicCE1m5WtfbfGi17UxrSjLfcRcEkdjyZUNotH5faH3vbHmirPXylPJ3Kmr
         tXEQSv2q2t2an7yG8CW8RXlDtSXbiyPISGHuyNaD7tF93NZPF+83W3DvIJXRIpQSsPZ0
         hPScxwnRQzN3RQ57wAizjQmxZXMSneyxfnvVgXTH5VJEA3ZSPtdNKSndunJCscOf0lxy
         U1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU3MWdrjiwx/LsxZ2M2qReR6C3Y6USg14yI8ad8NiXZl0g3b33zZUDrJVpRyGdW5mAdxeHhJ49P3GxkVcNzZWt+@vger.kernel.org
X-Gm-Message-State: AOJu0YwU76cuytC3gOecgZzn+ylnFxKYHjPjuv/zVI5wZwoSEhOy0iC6
	HlVV3zKGsQLEabgI2/JBypDZ3g+MVBKQuyHa0eG+5/rgUPqb1PJ7dq7k4GJS5oAavootkcsQqlm
	S
X-Gm-Gg: ASbGnctaVZv0LZsH0QGRYlOr3jiwAfXkBA4ABa5koGHSyxpDN12hXSeuWUEojqnwaMO
	8ALb7c2nHeP5Va/D3rGdQYmsJMyqLi8JChqzso6Q3Tu0u1TSKb3lmy9roXG4Egb/+4e4HyJk8nc
	LdJkEwxO9QBglD3AimfATAGBAijz0V8akQEehU5W/gbIV4OB/cFAr4pbeLfy+YN4KyFjjWhPswj
	CKu3ItxUONKbFx5eGrTe0FF2ijEWKLg4y3v8hLSg2Qz3fOvqripYC3L
X-Google-Smtp-Source: AGHT+IHz31vPgvjsP1ktI6cDJs5dwXi6jyonWjrDKCklrI15yME8jN2ZsQTROIywKIjV9MjHGbUrWw==
X-Received: by 2002:a5d:64a8:0:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-38a8730560emr2565669f8f.22.1736346491235;
        Wed, 08 Jan 2025 06:28:11 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a28f17315sm47577178f8f.108.2025.01.08.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:28:10 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/5] perf: arm_spe: Add format option for discard mode
Date: Wed,  8 Jan 2025 14:27:22 +0000
Message-Id: <20250108142731.400605-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discard mode (Armv8.6) is a way to enable SPE related PMU events without
the overhead of recording any data. Add a format option, tests and docs
for it.

In theory we could make the driver drop calls to allocate the aux buffer
when discard mode is enabled. This would give a small memory saving,
but I think there is potential to interfere with any tools that don't
expect this so I left the aux allocation untouched. Even old tools that
don't know about discard mode will be able to use it because we publish
the format option. Not allocating the aux buffer will have to be added
to tools which I've done in Perf.

Tested on the FVP with SAMPLE_FEED_OP (0x812D):

 $ perf stat -e armv8_pmuv3/event=0x812D/ -- true

 Performance counter stats for 'true':

                 0      armv8_pmuv3/event=0x812D/

 $ perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
 $ perf stat -e armv8_pmuv3/event=0x812D/ -- true

  Performance counter stats for 'true':

             17350      armv8_pmuv3/event=0x812D/

Changes since v2:
  * Use existing SPE_PMU_FEAT_* mechanism (Will)

Changes since v1:
  * Add a new section and some clarifications about the PMU events to
    the docs. (Ian)

Applies to v6.13-rc6

James Clark (5):
  perf: arm_spe: Add format option for discard mode
  perf docs: arm_spe: Document new discard mode
  perf tool: arm-spe: Pull out functions for aux buffer and tracking
    setup
  perf tool: arm-spe: Don't allocate buffer or tracking event in discard
    mode
  perf test: arm_spe: Add test for discard mode

 drivers/perf/arm_spe_pmu.c                | 22 ++++++
 tools/perf/Documentation/perf-arm-spe.txt | 26 +++++++
 tools/perf/arch/arm64/util/arm-spe.c      | 90 +++++++++++++++--------
 tools/perf/tests/shell/test_arm_spe.sh    | 30 ++++++++
 4 files changed, 136 insertions(+), 32 deletions(-)

-- 
2.34.1

