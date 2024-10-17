Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDB1C230D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146977; cv=none; b=Phh/h/VilHskWiJMZiGKJYRGkxaBLQvVP+qRIjmSeLh6SXei6gk+SgGDi4B2S2PjjgnuBA4wkIMYh6MmhuQ0TIxs9Ftk89qmyuBmCx8LF/v8mGu8XvI/Ujg/K5OIw16TVTzvc1pTi8d+wlV3Akg3kGOFOW+ZaGKkSOe569WZ/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146977; c=relaxed/simple;
	bh=NsEtgw/CJP+vWxhnvnmyKpgsDQikpVmmCdzQcCK46q0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aVRw5e7xLdHK7hTdKWauRAQGCs/u+yJXjcdvT3oKJ/f7JROfla3p4EpaCKkq8wr5DvjwaVtCr8WaXJKSv6DAdVOqB+gp7bMRxJbjO7uH8tm026SrZk1KIzEgeXPuoZ7W0PP1736js4iNFnDzvSHQsoXZ2u4oFj8Jz+1FrHHZ/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbkLaDZG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbkLaDZG"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d660a1afso13024927b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729146973; x=1729751773; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP+cSsClwrfeGY5lVINq2DuZ9v0AJGV/q8mYM74dFsk=;
        b=xbkLaDZGVTZFjYccd55qBuyra1VC6PrhdyInyfCbBTTvDVy2OhpgB0h7+MZp9cqqtw
         rh1dVymQpxu28Jn4uSveyA+5KvKEFNESlPLahqbw6FLO/Y/FAkEasBnkPDBTBbD46Q42
         w3ZhoGTDmsfIjlRM3ZS7ks9UQ2FCcgmZFRNlZXeEXbLHSUKqfY2o4PdiLUDKPkWja847
         tHTb1vFbJC9cMSnJkU7owgDTjb+dpmh3Y0CijCYrH8Ub/8qU8sxqmyojWI4MaQhCI/dK
         QcvgxYVNQE/HVAALdx56Bv/M8eU+7FtSoqU6dC0w5NQgrCHQ9MkkEaoxJuTbLPC0uXPt
         0Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729146973; x=1729751773;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP+cSsClwrfeGY5lVINq2DuZ9v0AJGV/q8mYM74dFsk=;
        b=cOItX6c6CusKgoxAZDZa0BeCeOJ28Ng2K95EYQlrAbcBU9SSPKwx3mfwjd/wAW9dUS
         KEQu+fYNQXDjAK72aYJRDPFKxXryTDKSICZuYVzKv+awQjY2qP+CacHgLz0yYNx3hbsP
         TwCFrxH+eNhhDkgbW8oyQTB8sXL8/dUlcVH/Wj9wit9iLZQikXtqx1xYHLIz7GjQIv39
         C+HWxT6QPxJ8GR86iMC1f6pwoBJutVmuGDBCeAbrdkbqq3Hp/72bI4bk2hhPF9QAkRyR
         S2QwBZrDhjQPq6GhW0zmCPSnKvo5sJpQ10yM3UyBSTaHle7QWSP8t6xrTzQ4DMZGH8KG
         006Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgFCEJRujD1gWDTZ1Z5LgUXJ2iEUIZ0Yghf6bTSWFXHWANdTxLQ56lWlnAC8ZekepYe0MXBRaZtZcznGOy80Kp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvaldw+CPNS/9UjDKQX8vB0YVj4+fyseXY+L79bwusQqlWARFl
	r0pCeHm3W/9s7e8tQgzdUCggb3QMtPbjlz/1KTBxWcNaQy04ufLr1/0qQqfhmPG/G+M2POsm/PO
	ksRL4nQ==
X-Google-Smtp-Source: AGHT+IFh/DwzJxNwyNBb88Qd8pE9dOxJnoqNpWZY4e7FOxNmTYaPoDIFzsaEM3UF2fO9xSxiLmo6I0/JT5cJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e0a:b0:6e3:345e:5f89 with SMTP
 id 00721157ae682-6e3d3bdc32bmr1475887b3.0.1729146973536; Wed, 16 Oct 2024
 23:36:13 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:35:55 -0700
In-Reply-To: <20241017063555.366065-1-irogers@google.com>
Message-Id: <20241017063555.366065-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017063555.366065-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 5/5] perf docs: Document tool and hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a few paragraphs on tool and hwmon events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-list.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 14621f39b375..d0c65fad419a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -243,6 +243,21 @@ For accessing trace point events perf needs to have read access to
 /sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
 setting.
 
+TOOL/HWMON EVENTS
+-----------------
+
+Some events don't have an associated PMU instead reading values
+available to software without perf_event_open. As these events don't
+support sampling they can only really be read by tools like perf stat.
+
+Tool events provide times and certain system parameters. Examples
+include duration_time, user_time, system_time and num_cpus_online.
+
+Hwmon events provide easy access to hwmon sysfs data typically in
+/sys/class/hwmon. This information includes temperatures, fan speeds
+and energy usage.
+
+
 TRACING
 -------
 
-- 
2.47.0.105.g07ac214952-goog

