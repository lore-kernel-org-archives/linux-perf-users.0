Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FC3EC83C
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269445; cv=none; b=t5e32/dZuCc+zYP1mERDoNbbv8sLhUuBgjIBcdTs08xmWNdvS8l3E8WCHx08bLmH47s6H0Na/F4fO0cWWt8BPezSRSKo9Vd1xX/5C83LVhpGhxg2M52WzfGR+1kas7msIDlEJFU91Zx5rFYvIUw5K85/tn7FJob0xXLPygEukLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269445; c=relaxed/simple;
	bh=HB9PMQWC3W3hrXhFfQ8IpuOLnJXhZEQXPDyY6DII8f4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vd6aV9qo6hTFZojT2iHcmEcQXAtGzpLeGaD1CxW6mBRcgfNSfRMdVTZjYdDTAXZwYvZVmrhrFE0ndlpLo3gMS1lTnNTGjDqkhzXGydTeBKGR1jN90Rvtr+7/eJE3hRccEvE4e2vkaLT6px6Onmx9YPjFv9VvJfTWYds3bMyBmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1C37VRb; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1C37VRb"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so102617c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269442; x=1790874242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8UwmhUNUhoCryVaWfgY+Re2UwtZ6hcLCD0chqhwHEFc=;
        b=G1C37VRbqaqN8bVyAoEE+GOgLyNkdPK1/2n/tQ6i4q7/a+E0GK6BC4B66cs+Y8rJG6
         j9lQQjsmtz9XTsQY24ZiGO1WieyVJrzKxj6aV9jaMXWhqpzMWEjYBMRfM7IBA57fceGN
         WbuYrMsDXOpUPjLAVmsM12HZd9OdT2a9V0AUtJEnNc4lcL+D/sAd6Agkbma5Wmj1Ada9
         YjPDRxoxRb10+8EAfjVgNS1VsRnDtiR6gFs9Bu7XZnTbx1GI1B4+Coxc+sFGBXHBJoal
         BPwOncCZRxOUU5eHUpsLw4rlea+ttSYGDt/OMXaAsb4hh8AM4MQeIlP4TLRO9wgo6Qah
         tpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269442; x=1790874242;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8UwmhUNUhoCryVaWfgY+Re2UwtZ6hcLCD0chqhwHEFc=;
        b=iyPoH0xGVd6htGJdJEyEHFeH5GkODAxjgP2GACzKiUngJ4fXI59cxePrd9id6XpuLO
         D3MGMWMWW5yw/a9r7fVJ+Qjovah5Y7HKR/KEZHFgpHBs4AlU+Ft14N8lBvhcgZG4wnnZ
         8QVuf1fEMwC/qzMAc9uduQlu7Z6NjzbdYMnt0gZorTSPR2DXnbonPYKAXCLvfiWrDeyf
         Gs+TbZz7rzkcYfRnfsKGzQD5oH7ctIifeqFNmpKBqiI5uT4IzFok6hovgdvE+u9oj74/
         SEMVv3Lg7W0I2KtBHCyGps9KlcVixJrwWFNghu7FEaMoNe9mp4x8MyvxXCCS4Aiw3qTG
         bAUg==
X-Forwarded-Encrypted: i=1; AKwUvByOepsTyB8Ct/tWXGYkaE/QyM7yLZGfQ4jQcD85Mt8t3a4FytfzzfDPeQsNCC1iuVwu3bKa10IWzEL1PRK604Pv@vger.kernel.org
X-Gm-Message-State: AFuF++kicCZEKco7It2yZ97+z75l0mCct+xFTjdWEUyVZYIiTWtNjVYD
	63aM55dsdyyyaFyqUDZ6DOJ0XlStpQg92DY8M81y2eny1vDVpBq0c5/f7pOSV8MYiL7lHOJSema
	80Un+WAC+hA==
X-Received: from dlbbt22.prod.google.com ([2002:a05:7022:996:b0:143:8c20:9c79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4515:10b0:145:156:8e72
 with SMTP id a92af1059eb24-14504007746mr2570153c88.26.1790269442209; Thu, 24
 Sep 2026 10:04:02 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:22 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-3-irogers@google.com>
Subject: [PATCH v2 02/26] perf vendor events intel: Update alderlaken events
 from 1.40 to 1.41
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147c7=
776119c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlaken/cache.json | 4 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index b39c73614b86..38851c1580c1 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
-        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
+        "PublicDescription": "Counts the number of core requests (demand a=
nd L1 prefetchers) rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q. It also count=
s requests that would have gone directly to the External Queue (XQ) but are=
 rejected due to a full or nearly full condition, indicating back pressure =
from the IDI link. The L2Q may also reject transactions from a core to ensu=
re fairness between cores, or to delay a cores dirty eviction when the addr=
ess conflicts with incoming external snoops. (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event). Counts on a per core b=
asis.",
         "SampleAfterValue": "200003"
     },
     {
@@ -12,7 +12,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ANY",
-        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition, which likely indicates back pressure from the IDI link. The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
         "SampleAfterValue": "200003"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 866b5fba7124..748d1ee1605c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.41,alderlake,core
-GenuineIntel-6-BE,v1.40,alderlaken,core
+GenuineIntel-6-BE,v1.41,alderlaken,core
 GenuineIntel-6-C[56],v1.20,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

