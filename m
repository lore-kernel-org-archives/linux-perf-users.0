Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499801;
	b=aEhRX9vweSQoel7OqJSgSvAs/iyQTBY0iBCCk6YH5ehMZYBsMUP34ssWFan8yJo1rWjN
	 QooEFZlfJnkokfB6TDWDW/VNYSUCUV2nrnZNjrYKCULWHgPEEGXT/mUEMXPhV4XDfx5wH
	 sACzrpPQIR+w1+igBMuaSUkU7maaJ2oi682d5XEJlSKCk7iIFkyjNZdJq79IWtcIEtj2C
	 Xn0j4Ks4e6/mwSTlaT4mlw5jcifonxJ99FtFb+TrdFXT01GKPXtOtm1veYJWM5cVgn8nJ
	 33hRXnBhpKbVulUQQY67BebKELTE5Gd/JYMS5XpuYaw+tUBbJpWMDE5rT65vIXqhdCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Ob0WPSUmBwRwGSdc8M8KJDvOLhcyKxkyEF4LxT9KIzo=;
	b=lmVeQC1rkxwxgISkVjTEpv8WjQFZF1uKdPEDiAXF4akimTKGa46gnF7M4ggsD/Ykou2c
	 4wEnvn91kPFLH79xMtey6EU7tmjaObNmz51dG/RxRdGk+fL5FI/Z1Erapo6uPXvTG9xXN
	 bVZiGb01Yngh3t/PdK/GxmuOHvJTbeopy2cRHNCa/4gUKVP7q3f9mzjOGyszj33VvKHb7
	 8JauSYM79pFEEXNPuug4pJI2UejIFjA0tZ45mat+iV84QlVVuVh65CFpApk3HHt43yprD
	 cq2ime7N5x4/A9/datvptrGcsvIlojvvlFLq0mJeboPpGIcRsLOBeGYerw/ZvwWnRdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTCQB2Ri;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA0606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 16:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36AA0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTCQB2Ri
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37600b0db49so947286eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 08:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499800; x=1795104600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ob0WPSUmBwRwGSdc8M8KJDvOLhcyKxkyEF4LxT9KIzo=;
        b=GTCQB2RiUporqHAZQMcUn7I18O22YGrBdBI3wTVInl3GO4Av/3cgqo4zKVysceAkjG
         P9Bjy2RHbUZzQ9d8oGlvMr1gc0Su1JuVdZVO6zoYRYWYfHeUC6owOdOGkMUvDR02Orpn
         fodXz/RDZhO+U0C12laBnzDanfto7ynQApsvUuHphj4H5zYR9A1aMtytRo5Gp3clBdVq
         UZv4QzvYficguwWqEOi0TDNDAXFxrJQSfXkEhaYseQH3ZtUvpmLzOr9ROC48r2LYU47r
         e4HD0MAAiG7IcQibVK9QFwGTsVwAR/fiZqUUGnmOeV+neQAp7ARKc+1Xh12llyYmo7bq
         qylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499800; x=1795104600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ob0WPSUmBwRwGSdc8M8KJDvOLhcyKxkyEF4LxT9KIzo=;
        b=Kb7bthJJ6BEKYInkoz1ia2QvGHRIX7GQXn1vbRytiAGsRI1SZ/qYbty8OlxD8VYAem
         7r4mRvVXuXn6A9uOEWO8u8DdtWE5F9Ykq6deNaHNEHbZeYaZh6lFgRuZ2CbHEHpwhtB9
         1CRFqqx6aTG/rBIelmrAhb1jRn5FRtyj+DVzvbZczvILhS0h0c1DCzwGOAXNUpaCgXMJ
         AkLMPL7trk4oRsC6ibRBT+DHJJAYbe85kQt4xFeAz4LOF7Pw3aQn8jViPJQxAWJAa37z
         yueEtXXnZl6AYB2XewkuafjP1Fpst+QEhCDRuXr0KImvZR4k6oCLTE2GFcjP21A2bctH
         RClw==
X-Forwarded-Encrypted: i=1; AL+hErGQ9XkSUliydy1WY27IhuM/SrGG3aaT2i8wymK7zPRWJKQ79JsJtI6bVVER6ExHYG8jYfaB8zsmaXpdLgDB0diz@vger.kernel.org
X-Gm-Message-State: APuU4Z+wWGULQ8kdcV9Qs5NxoCfJXOB5FudlvqcTkqJz6xL3q7gSJWmp
	rzzHyCnJiXfyOuws2cxuxPDh+jw5MUrhxRCkyK8ze9nxvSiPHuKEtt/r
X-Gm-Gg: AYBFou3jF+vYhKH7FnhVZ+FrW0BA3sNLRwXJ7vzpFCgRP3hIWZ6qfFMe+4o8X6pnfK1
	dpX4+VAMhkVgCHrglzJ42n9GuNX6ZOc2x5/fvlSz9Ib7UKu3fsIJwiE/OrLNG1xwzyOOHdIkJ3j
	masATMLOOIJJM1ip8+c6vSXALqr8rCHQbKWH08eG6yIaMniLYthYyNsXgtRbUo1uXjnXPpMHxA2
	kEi8UpT3O7SJO1ypMvtifk5b4202RdjkTm2Q+X3ZSGWG942FS56XegOow9eORyi1ERKdXynQkGk
	fArDMK3m8h8AyWwn2o5bvYHSBXykl+zB28FcSbw5JGy3Z9CEjlWTYWnYzgBAUEIdTWwcrvTpb9g
	kqiOcvxo1qvnSEZjf7dfYqijMW2bPaFyw6U0WCC/vPsCvYdFzp5gpziHanUKS2nm6aMryCQVDlP
	ZlDm50mJ1uFva5g3gl6BtzzALlxvGVmugGwZFUY6XBl3GcaO1XCS/+ueQcdt0+NqD+UevZfORfr
	bYhp1/spV9DKRl2ZPKpS1+5rLS0ER8W07QM7MdekTzU6qfkytzKyMNwSGp6GhbpGyGE1zvXGVir
	PbhBo6jERGuhoUUq1Uvg+KugLUYWtf28QW3dWgkeKLxfnCs=
X-Received: by 2002:a05:7301:4104:b0:36d:dcdb:70c5 with SMTP id 5a478bee46e88-377e15f06femr3838524eec.20.1794499791032;
        Thu, 12 Nov 2026 08:09:51 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37922d4b494sm622177eec.2.2026.11.12.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:09:50 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH v2] perf vendor events arm64 AmpereOneX: Deprecate BPU_FLUSH_MEM_FAULT
Date: Thu, 12 Nov 2026 16:09:47 +0000
Message-ID: <179449978796.114968.12434513576144881401@gmail.com>
In-Reply-To: <a188c604-46c0-48fb-9cbd-9eacad88b5c9@linaro.org>
References: <a188c604-46c0-48fb-9cbd-9eacad88b5c9@linaro.org>
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
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Sorry, the trail is confusing and that is my fault.  The single
"[PATCH] perf jevents: Check the JSON keys that jevents.py never reads" from
11/10 was version 1 of this check; v3 turned it into a series and v5 replaced
the check with the fixed list, so the title of the single patch no longer
matched the series.  The current one is v6:

  https://lore.kernel.org/linux-perf-users/20261111150920.2383157-1-takano32@gmail.com/

You are right that it is ten lines, so here it is, as it would be posted.  It
reports 19 keys in four tables on today's tree and exits 1; with the two typo
fixes that are already in perf-tools it exits 0:

#!/usr/bin/env python3
import json, sys
from pathlib import Path

KEYS = {
    'AggregationMode', 'AnyThread', 'ArchStdEvent', 'BriefDescription',
    'Compat', 'ConfigCode', 'Counter', 'CounterMask',
    'CountersNumFixed', 'CountersNumGeneric', 'Data_LA', 'DefaultMetricgroupName',
    'DefaultShowEvents', 'Deprecated', 'EdgeDetect', 'EnAllCores',
    'EnAllSlices', 'Errata', 'EventCode', 'EventidCode',
    'EventName', 'Experimental', 'ExtSel', 'FCMask',
    'Filter', 'Invert', 'LegacyCacheCode', 'LegacyConfigCode',
    'MetricConstraint', 'MetricExpr', 'MetricGroup', 'MetricgroupNoGroup',
    'MetricName', 'MetricThreshold', 'MSRIndex', 'MSRValue',
    'NodeType', 'PEBS', 'PerPkg', 'PortMask',
    'PublicDescription', 'RdWrMask', 'RetirementLatencyMax', 'RetirementLatencyMean',
    'RetirementLatencyMin', 'SampleAfterValue', 'ScaleUnit', 'SliceId',
    'ThreadMask', 'UMask', 'Unit',
}

def main(root):
    bad = 0
    for path in sorted(Path(root).rglob('*.json')):
        if path.name.endswith('metricgroups.json'):
            continue
        for obj in json.loads(path.read_text()):
            if extra := set(obj) - KEYS:
                print(f'{path}: {sorted(extra)}')
                bad += 1
    return 1 if bad else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1]))

Two lines are not obvious and are the reason the posted version looks bigger.
The metricgroups.json files hold a dictionary keyed by group name, so the
filename has to be skipped or every character of every group name is reported.
And without the path in the output a report over 1019 tables cannot be acted
on, which is why the posted one carries the object too.

I will post this as v7 with the list above, as a perf test, and drop the
Makefile target and the shell test.  The other two patches in the series are
independent of the check: patch 2 makes the model argument optional, patch 1
names the metric and the file when a MetricExpr is missing.

TAKANO

