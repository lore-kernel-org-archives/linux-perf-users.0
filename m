Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703163;
	b=Je8lHWYo2eCGyZRybcXMOQXJs6EvdnaTIh67yOV/sbxyUaisUHv1h/s9X1KORt5Sf8St
	 tihilcKFwdvS7/W37HnX0YDzdiQGeZafr0Z74vnyLlvrQo8wqlxt8WMwe48DH7HyUlhK1
	 NHplmDRARiFpgAx3Qo9MK+E04IiHPtc3pca4GvIBFqjIevRwiAR0I7jJh6zlbpkfQcq96
	 5U5f5lv/OwmkClDsAph/MxzSasxZJzpEN/Ne9bzIby4FXyNJu7RoTqvH/Z6VpWRkgSyr2
	 yb4ta8+PjY1aMFqZ+87TfisTNN1ajY7qhyzjb61iOYTLbIF/zedughmOBkPLC2BjeBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4GrWQhdlUN8PHyNIAm8fqZHJSbDfpomlm+th0sM4Aj4=;
	b=2OP9+oIQs4Y0g0yEGwmPtN1zpq2l4cVEPbqcKET93vwdnlTixQ2N5wA/nSARRsKCsaXj
	 Bdvn1feGhF/OeqWk8bQJOZH4FgLRSuniWrvDHMIqpwWIj/Xaq1nZPVxTngyCtun8RQyaQ
	 HNL8FfyuK0ojJFcloHz8uWFcdjT10ggsdiRnAKEoL3jesUeSqrBgfYqPfzxNYKWE0GHjb
	 1gXlFobS+OgM9ajJyvgpvUayRWv96uIR3Bbqw7uLL1xZ/vKBx3gzvEphvH4sz6okbZid7
	 Shj3AF0vDHmhyNE2hNn0UNX6UcN9230vUyVr5SVX308PsmJ9moG3vnYFWPcs2CAK27g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zpMsZLld;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A098606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A098606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zpMsZLld
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso121149d50.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703161; x=1795307961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4GrWQhdlUN8PHyNIAm8fqZHJSbDfpomlm+th0sM4Aj4=;
        b=zpMsZLld4xitce8pr3dzn0VlBsHrJENUQTpe4b1oBHHu+eNxusDc8Ew0El03W9fZWW
         aAVGy0BnBHgdk/NEGTfqb01gm7XdPdHtZmBWWvdaJTBDPp0UwV6wrfuUo48DMX3ogGWG
         juiZJhjMR5nxJ/8Ws2RD4u2qoCO5R7azV2kBbxqJlmDdKC3rgn/ICBIqWxvlEpIN2QvO
         vFJF0LfKb4g9on1As8gHew0w/PrAV/sge76xEcPXyC52CQKi89i65MyOrvOHy8fsa1my
         t7DN5nodoVTxapOkY0R50vQo7Rtm0NyaDwJSC94UcyCVbGllIv954XUzywIcDV4Wv4XS
         Xe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703161; x=1795307961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GrWQhdlUN8PHyNIAm8fqZHJSbDfpomlm+th0sM4Aj4=;
        b=XBtXqFZc77OEXG90LJYKMr0Njl+rZbP47q859RtbxVs5lpnfNRu0pShu7HfqsVPsGK
         G/G7aA9Pgp30r9sIrDgiiaFlgHbXuBRJYze/OhnXsHDAgOwxDgrG82fqQsSO8BjpghT6
         9rYNSDAOlajTD4cB1HC5vdZSaf3If7Unenq3By85nfUv4EIdWpkWWT3n24qM9AqauK4q
         5QSxgwtWaeDVQvUevuOnpY/JElqtL/EWCli1kdB2C/yOeb+oyMpG/nLHGJ2V2Q59ObUC
         r/w1LMvxM/s5RMadUT40Af5KgAr6NXuY1IG96FZmrtqkf+B1urBgb+nyO7STS+TsyA3e
         KjRQ==
X-Forwarded-Encrypted: i=1; AL+hErFMO3Q54wGlS3r4kLsG+zfKurvfFx6/K/exg0mXuHyxzXWdTFML/hKWMMhgBTCcxpxHH9mu4LRqMOjS0QpiIqQL@vger.kernel.org
X-Gm-Message-State: APuU4Z+nLq+HJuyiVrOBkTtY4ScgIGCI3azeQGAtzRJMao9VNI78e1qD
	wmvP5lN6SOgjJ4j0wtnv5VAULI3SyiuVQ9cw6zXSqe/dWQXQf6ZhW3H6
X-Gm-Gg: AYBFou30fslXS6KbEHzLRV9+Dd20+XtmuL/Ee+pEz2UJ54kE5ds6dL1OEFYWegoWCU6
	QrV1yMzchYL1zfQwIhgRf9YKZ5YK9/3l4HDY01AN/ZESM1HUnlLwjxmiXmrt+GiLkXD1DOucSJB
	WPih3yDdMAaZjsF+BTVLp9o3r+sD09gA4oNMUiWvK/ucnBiOSCvPy3hh47dReIdBIBkAlJHJ0XL
	rfxD7QKVMhyV2yWVwWBsTWIhWXAq/sH8dgnwf0xizueO97SG370bPZROzYyNJORvwBsWd891p9q
	fSFf5/JRT8SxaB9DeVb/ffAsTiFYoBtHlDIzFmdR7NPjbxFNIldmc2ayEiJNHrX08uDyKro32CX
	2aK8Toan2ochoPc1uBZAe5Ev/iN9giJ89wEJdVz7YpUBMbGvySvgG4uOcNs3DYkqPmxsIS0Wak5
	xwhAUisqwG6HslrqM3HlYPhAOPLViTc6mcM5lFQ5NvxIPE0ADBvWMUyUkNPU62woGGNpKVn25xn
	CUKwlIUGn5Gu/JOVOXLV0OJdG20wkLCTLG90LdPQ6PEZlR/BcYN/uGzL7KPnOlLr3RUdlq2L7L7
	nr2+fAF0M5Omf7bom1ahJ6KSZCTFxJs313/2NmJZxsE021Mu8ABwBITr
X-Received: by 2002:a05:690e:807:20b0:679:b98d:9b7f with SMTP id 956f58d0204a3-67d893e4231mr2208264d50.11.1794703161195;
        Sat, 14 Nov 2026 16:39:21 -0800 (PST)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm189602d50.19.2026.11.14.16.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:39:20 -0800 (PST)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: adrian.hunter@intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH 0/4] perf python: Add a script to open profiles in the Perfetto UI
Date: Sun, 15 Nov 2026 00:39:12 +0000
Message-ID: <20261115003916.1873857-1-lalitmaganti@gmail.com>
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

This series adds a perf script that converts the samples in a perf.data
file to a Perfetto trace and opens it in the Perfetto UI
(https://ui.perfetto.dev):

  $ perf record -g -- ./workload
  $ perf script perfetto

Unlike a flame graph, the trace keeps the time of every sample, so you
can see what each thread was running over time, get a flame graph for
any time range, thread or process, and query the samples with SQL.

The samples are written as Perfetto StackSample packets [1]. The few
protobuf messages needed are encoded by hand, so the script only needs
the Python standard library.

 - Patches 1 and 2 add what the script needs from the perf module:
   whether a frame is in the kernel, and the clock from perf record -k.
 - Patch 3 adds the script and a shell test.
 - Patch 4 compresses the trace (zstd, or gzip on Python < 3.14), which
   makes it 3-4x smaller.

I compared the output with perf report and perf script --no-inline
(the perf module doesn't expand inlined frames) on x86 and arm64. The
samples, their periods and their callchains match for:
 - cpu-clock, cycles and {cycles,instructions} groups
 - recordings with and without callchains
 - perf record -k CLOCK_MONOTONIC and CLOCK_BOOTTIME
 - pipe mode (perf record -o - | perf script perfetto -i -)
 - system-wide recording on arm64

DWARF callchains need a separate fix to the perf module, "perf python:
Accept events larger than union perf_event" [2]. Without it, the script
exits with an error on --call-graph dwarf recordings.

[1] https://github.com/google/perfetto/blob/main/protos/perfetto/trace/profiling/stack_sample.proto
[2] https://lore.kernel.org/linux-perf-users/20261018074528.974953-1-lalitmaganti@gmail.com/

Lalit Maganti (4):
  perf python: Add kernel attribute to callchain_node
  perf python: Add clockid attribute to session
  perf python: Add perfetto script to open profiles in the Perfetto UI
  perf python: Compress the traces of the perfetto script

 tools/perf/python/perf.pyi                |   2 +
 tools/perf/python/perfetto.py             | 675 ++++++++++++++++++++++
 tools/perf/tests/shell/script_perfetto.sh |  98 ++++
 tools/perf/util/python.c                  |  17 +
 4 files changed, 792 insertions(+)
 create mode 100755 tools/perf/python/perfetto.py
 create mode 100755 tools/perf/tests/shell/script_perfetto.sh


base-commit: a1c3b14c28ebfa79dd56e2743c2fbad0c02a7146
-- 
2.56.0

