Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2263410
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799264; cv=none; b=eCZ9timd/x6ugsaLjzMhxxHh2PsDFGhtoy3ZR85yW5h3KLv7Mde4p1Ko3erpBacI3KwHHYa+69VuQxPuiHRUv0k0BLiqCbkL9RMXNIR2GcW2d0iwAdP4hlpVnoc1FYS9IVYbFse69ExmowJ+prWH6EK0fVtQTpCj4s2gh31G1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799264; c=relaxed/simple;
	bh=kbFBHdCad/TTKVPzgQtSH7M2inFZrQ/NSaJSVlW2wnY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HAeYl+ejX0xuehRVTEWOqIPZpLgBdO/C3J0ucnQaK7k58Jq22EU04YQkXTIOD58fH6F137UkWCdc/LOJugPL2Dj1C/dVDvA1vuVM2Ko/6oc9mazw6Le5+A+c17/1OMywakm1n/33gRsnz2nG3ReWGtjR+oKgIWAfDfTsKcKZIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHn1+0D3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHn1+0D3"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1014046276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 00:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709799262; x=1710404062; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=EHn1+0D3CqRrvYUcV3hcdNNe5+9M1U8npj4JP4ojSfe4mB0JKiR976eigwMTB0XZjl
         APaGNMNKIxvGhzSTgbFPFE6c040n4Vq2Z8Z2YOGjNh7NR45lYOQSJxPhLqgi/w7+494a
         tUOlbPeNSYqD986ILPWQG5IbcE1puFsLXpOBrV3KeZFl2n2pQ/NMvmoVXHrIDYFPiV2C
         RaZzPv2NbLDyPiwgtjHCnPmb6U2wZPbJ0jSlNwpuulhx/8ya6OT7cGVlvl4pYRprnJ+c
         qQUf3bmoCmYFjhNi2LJGRUzmZ76IXulUO0mYwJDPlBWlV9a8Vi/S/xR+rQsW/KwA4BRM
         uZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799262; x=1710404062;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w11Yp0wodb7GDuRE7Pf73tA+Sknph1YJzxldtQ9IWAs=;
        b=CsAWu+6G0xICtHIHDjNCibGYQA4stoYX7jtQLt1+4RnO9bg4zO9fBtTV1IzBD2eL/f
         FHJpL0XRDVoz7sahnNvKkAHKLrhdAX42l+noGNg4f0OsoZiQNiqvoLhYoJQEHMZGrBQu
         0U5fimow+c89kvdSJIhKv9eaJ+nNzBvKEjz2nwDXX+g+FQH1jJ7BvwJ111KccbT7QMXs
         VG6/W7f1U0AkP9TNM4n/PAenVlAOKAAUfscp7abBqCmQ9tMY37JmEqwlf+GPOXkNNKT/
         Pr+kdIexEvd4mQsSkH89Pc5m64nkcQYSfxtPhdC2y9UxeEEsnXd9WzLSvlD1AvMdJwO6
         HvXg==
X-Forwarded-Encrypted: i=1; AJvYcCVp9IUoGiaB4Zlf+HX4yI99iDcUmSQvd3yq9j5JSgE61ab29Z3QrCk1UFhy3cWI9jgeDHfyobiHajJ6Ps4og6byTk16LM5VaUQs/Mls5u5D6g==
X-Gm-Message-State: AOJu0YwESuw+7GH1pg0panhar1JPzioKcotBjZhgyBjbw/aLeMMLZP0w
	rsNTAqtSsBO4+LXQu2xM/x5ZMFUGmQbP8TXflSvuDCumcibH+7sbmRjpf9xq4LZprKav9Z4mLLD
	ULhFbvw==
X-Google-Smtp-Source: AGHT+IG3XWpl+hiZSDVvdAJyxW1RmoGtmXv0tET+3cQqV/HaljGx3Oow9DCUkEVyU8iWOtIbidaNFDxpp/DS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:6902:1549:b0:dc6:e647:3fae with SMTP
 id r9-20020a056902154900b00dc6e6473faemr761880ybu.2.1709799262344; Thu, 07
 Mar 2024 00:14:22 -0800 (PST)
Date: Thu,  7 Mar 2024 00:14:07 -0800
In-Reply-To: <20240307081412.3933750-1-irogers@google.com>
Message-Id: <20240307081412.3933750-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 2/6] perf pmu: Drop "default_core" from alias names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"default_core" is used by jevents.py for json events' PMU name when
none is specified. On x86 the "default_core" is typically the PMU
"cpu". When creating an alias see if the event's PMU name is
"default_core" in which case don't record it. This means in places
like "perf list" the PMU's name will be used in its place.

Before:
```
$ perf list --details
...
cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache]
        default_core/event=0x51,period=0x186a3,umask=0x1/
...
```

After:
```
$ perf list --details
...
cache:
  l1d.replacement
       [Counts the number of cache lines replaced in L1 data cache. Unit: cpu]
        cpu/event=0x51,period=0x186a3,umask=0x1/
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f39cbbc1a7ec..24be587e3537 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -518,7 +518,8 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		unit = pe->unit;
 		perpkg = pe->perpkg;
 		deprecated = pe->deprecated;
-		pmu_name = pe->pmu;
+		if (pe->pmu && strcmp(pe->pmu, "default_core"))
+			pmu_name = pe->pmu;
 	}
 
 	alias = zalloc(sizeof(*alias));
-- 
2.44.0.278.ge034bb2e1d-goog

