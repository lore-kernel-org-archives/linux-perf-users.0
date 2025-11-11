Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C535E552
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896163; cv=none; b=c8maNX1BoH/e6DGGEPAzBsV1wl7DrxkIYy/j8f8Hz3BxZ0qR6mai1XcYCtINXp4E4iACvi7x2h4WOv+kCvcFY8pRD33NOrjVgy29rI+dIWfkCa5F3kOwtYLdtsNF5pBMHiPnYq7QF2sHnkHUp+D33VXMsb3dSSPYpW5VERT25jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896163; c=relaxed/simple;
	bh=QjO8gSjusfZ0mPendJr0+QHEFToVhbHiU4PqR4DkANY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aDrf1u8O4+d6xrpxJuSjeMAz8I7rkz/2/U9GwyET6ay4RGaZPCSf+yzZamQlJwK9iJm1cbVfjvvqSxfXQa+9fqjRP2byy130CvkpEjb4u5qASb3DmoxmwnWjQPisIn5DIXE5PQB3TLZ+/1gLyuQOQ0qyaueT1H1nmMq/lyyfs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMHvR5g9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMHvR5g9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3438744f11bso194882a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896161; x=1763500961; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=eMHvR5g9t6hNK8mQpHF/38hj+CQXzPIGYxdACBMVzlPhT5c3Bajz8uhhGCXCqlITfO
         zWg19/BCZgrJmPpLnNtj+eeWxMVKJaozpwwziGWguASJTTFk2KKbXUv69qaV091/8Nvc
         oWkSYM96oA73NCS+iLDZNkn1M0SUEzUXIBQB7agq6Cf4XNSKdzbnG8QEvRC7kMOYDWwi
         U6470uvpPIhI83o0W7mxf9T2DPvDj8b7Kveyu9TBXJmPeeOXYxIJlSIRkgMVW/tMI1Ee
         a7+PrIuVWad82ojcqQKbYtH7VSvoyNlpxGz5O5eqiUaK/iGcyziDp5cmxhyrwjl34caR
         oa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896161; x=1763500961;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=GduyOhZR27lrNMnrrO+mLGQqNgqVCcu0pPfaZPSKX1uHiilVbjQ4I4LkGzm45ksyXP
         ruxL2FTim+klK8YqPu8lyjnCHBkFATrlazvwRbtSHjOPjZV9PykGL/W62rYDN1xKEjdg
         0wnZ9XUfMUmIzwmXxazRiCcNDNYgKnyci7OagHM7k1tqF/ac9FEtl2HG2ydXZHN9Jl5j
         3Ajce1sTCm4ytLnRCOSJSRiXITnS545SsnpI8/Wt2ueqzxqI6znADl2mXC0VJTaGnNtQ
         a3INMn5SPZmU7Fn9Wl6fidiow/Vvg+u3e8ZmVBGAUeCKB7MsM/irJujpiWBLHZA/hfX/
         gLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlqNcRaYFRLTi7ZLKzxq81cHpm5GRk8Ws0auHt0HHzhdFo+pmUkAUiKKC/6A8im9VegOvHVNNm9JwB6tIlp6wt@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuu+jg2HT649RZkqiS28IwThRoM181wJipCDJ8+r5SRXJr+X5
	RJCIgsEX6QC0muuxa7itTTYPvmud26+2mxTr/+8DqwSQJ/GW90lYxdLLDbKKmJxwnt3iUKsJHLz
	IWEXZUGMojQ==
X-Google-Smtp-Source: AGHT+IGsDfl4twdhaYyKV1djwFY3TzFmwb7L5cYITsoNZUky8W7ncDvZyauJ+wyk7SW0EPD713vT5kKwTaG1
X-Received: from dycpw12.prod.google.com ([2002:a05:7300:de4c:b0:2a4:61a6:6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60a:b0:294:cc8d:c0c2
 with SMTP id d9443c01a7336-2984ed78ff6mr9651815ad.27.1762896160946; Tue, 11
 Nov 2025 13:22:40 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:00 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-13-irogers@google.com>
Subject: [PATCH v4 12/18] perf test stat: Ignore failures in Default[234] metricgroups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The Default[234] metric groups may contain unsupported legacy
events. Allow those metric groups to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index c6d61a4ac3e7..1400880ec01f 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -37,6 +37,9 @@ do
       then
         err=2 # Skip
       fi
+    elif [[ "$m" == @(Default2|Default3|Default4) ]]
+    then
+      echo "Ignoring failures in $m that may contain unsupported legacy events"
     else
       echo "Metric group $m failed"
       echo $result
-- 
2.51.2.1041.gc1ab5b90ca-goog

