Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A2353A94
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966693; cv=none; b=At3C9pOrhdrSVh4fYjBlHAj73+ihFzim7koRdhh8viRLKcOQt4DkoYv+cvq0G/u6mDX1xhV7CXLMdUEidD0TPWzdG27CXxjmC1whGiwPpQBGtrWqRgTvu7lNENzrBg2iC1iSJFt1zpWnGNlJ5xakYbmDVneqaJEREnow3fmeQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966693; c=relaxed/simple;
	bh=wQYtH8yiSuIe9XCgzqMWrveE9a2zm7sd9q/vR3bHoHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kj7ay5i+QEr5vB5Indzfa8IrbwH6E66pN11vlaMH7QHx260xbCPtZD9TFeWzv4rGk9alv25sP7o1PLYiW6KRpHoprSIXFdyRs09ZKu8HU8z7ji4/uc3mFl8WUPje1pfYjZjno7+4g5rRqPC+9OWlMpvr3QWkXuvrlwlVn3ZmBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsCpZ10x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsCpZ10x"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848d21bbb55so4217074b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966690; x=1784571490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g93yozj2a2UsXZGSV6cm1beuU7ZM/lREB0pM/NnNey4=;
        b=VsCpZ10xp6LEBU7ddElXmX7HgRLYSwauYnY5cFaYPUVoLzUtZrvHqznaBGk6YN5rjx
         MGDrUxuhmc4fCaPEVD+2ZvdxG4qRx6Xu7KcE3iPgpeN9SbenMXA12Cn/Rc8m1ds9hiP+
         ffwJrWlMQ/dQG0a7qt/KjcHnFJsvM7sW4ibJQHt/2PJGv9fyTCaAmaxdXQCsKkjsmQeD
         aogc8z4vzU9Ps3KJdY+YN/YfM0LwRsrNoLvsLWITzOW5ASVJQdyGImSBNHdt/am9xY30
         m3YxessGtxoF5MWbGT9ugkvBlNOWMObt00OtpfP51Jy3CWsBOvV10xe2MX51FeMAkp6b
         BOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966690; x=1784571490;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g93yozj2a2UsXZGSV6cm1beuU7ZM/lREB0pM/NnNey4=;
        b=iEkqoEffj7w1dqLLMhESclHWspIg7+3saaYjc12YXqffJ8wXXE2qVq/ZdtKZ+ByEix
         lYOYMS2JHG+9znkDZJdoRle9wCLFJy/IvMJD+7xQ/47mY+Lfy04XT8zKHTdNTyMo//Hw
         CGAaDjFTxhIMNXffzsEXPWnE98u/ViFtQK9o1CA+OwqSR9DYRNfhSkEDCuYf8NgiS+BZ
         dxWrtZ9ahEQBhaTOYvyq1mqhI6i5FeOcPL8CAmmucTK3tvXLXEG1SpjivrNlmav7MGB0
         Hjyk6BV6Jpn28YVb52Kr899c45JIlESvBXshc+5BvkudTlIDkTU3ZDt0BlhwjvnIST7g
         C9jg==
X-Forwarded-Encrypted: i=1; AHgh+RpcXUpimdpNzMDlHYEtTrJtyKCBLb3RAqLygUZ79xAeKnov7wpHH+LrwZQDDaqMK3Us3RXFV0VIlT6DjaIYop96@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCiDQoeY6J4284qIELuU17gDuMtvp3EpHs9p2u4K1ZTOv2A9z
	PkLX0FrBDYGv06w/9bEdVpB4mptKPG2WYVFaINkfxT0LS2Z8VhiSu1SR7aTLb+kVdR1zSU1fRck
	NL5UDsw==
X-Received: from pgc20.prod.google.com ([2002:a05:6a02:2f94:b0:c96:6f3e:49c9])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3397:b0:848:2f84:737
 with SMTP id d2e1a72fcca58-8488990b261mr9638059b3a.74.1783966690224; Mon, 13
 Jul 2026 11:18:10 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:55 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-11-ctshao@google.com>
Subject: [PATCH v1 10/12] perf vendor events intel: Update pantherlake events
 from 1.06 to 1.07
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, perry.taylor@intel.com, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/ce70546e9ccca4181d142057171c5bd820c=
8756d

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv               | 2 +-
 tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d88a22d9de72..e4cc479a040d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-BD,v1.26,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.22,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-(CC|D5),v1.06,pantherlake,core
+GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 5d5303c02954..74209da5bc27 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -1334,7 +1334,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0,1",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX) Available PDIST counters: 0,1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
--=20
2.55.0.795.g602f6c329a-goog

