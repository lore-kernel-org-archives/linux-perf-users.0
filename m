Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333347;
	b=TSNVFbuhEijDfprPy7RNDqZeDoOigFjwS4+ibqIFT27YxlHT7ybA3IIRl68YA0+4ZUo9
	 qBm3VM/8QoBpTXcjnwUsTP9iVgItdM8XjhsgA7End2eACqxXheNdWqMYvg/1XZi7oxMVB
	 jjvuFJHfNF58J/MppEpJ3wvo8McVBC8LSI+aWJNUS51+qqUmfQXFgDv3SCM6fAPnDU2A4
	 qIWzqJJso4UhwpsJLIVR1/3LsIQ/O61em/vjSh0DZhG8Vw5Od3jaYsiofwVYp85kQ0BPV
	 6Ks5IIl+RXGf17n2e62LE/r3QOgNdqkEwiYI1PaHGm2gFsk5IV+H2YxLmtYF8e6LAzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=KLY6uZGPwiFF8FKR5/rBjv6CszZW/cjkjocdfXqgdv0=;
	b=mUvYsmaBvwdIr8gKR69uYX3l8xYCytKUTTG1Hq1YUZ317r8VhGTNuCVF2nL4W4kukBNX
	 nge1iG6tYGd11Hw3eunXFr3L4D/it4YV4uZxcZEjS6gCH9wJS+07f0jfilG+L5xTuAVNs
	 ysMxEvLj4Wpg2un0mdJ2GFTDT2OWbXOdw0mVKHZtB2TTfgxYO+CyqfRgfLybU4yjStuOa
	 xf4ZLKXUv0ZvEK2r6aa6wEoHiWgq4OHBJBJaxlUbnRKg2ul3XZCZ0vWhHGVLZqUph6j9P
	 RPvPlBrKwMtvRJCd4u0+TvbD182gjrpmo+KSD+27JP/dISZa2h8FTi2Tc1T4LsEk0Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u5Kf2M7/";
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E7606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5Kf2M7/
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6790844c9b0so176736d50.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333345; x=1793938145; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KLY6uZGPwiFF8FKR5/rBjv6CszZW/cjkjocdfXqgdv0=;
        b=u5Kf2M7/6YIjELzCkl70tvynJLj7pohStzpqHIHK4Kwkj1GSq8J1avE+hxCX6hwNtq
         PGkpB1aA/kq14+FiDjIIYUsw82b6mguQwSK/O55ncJvZlsY8AiCG+qmp5+g1H7UTePl1
         yoWW4LxfNH7JbHWa+3NPcjpwd5LBUvQVyCEOcvSQ8aAblcc2YCxyR9YDUpP+U9MCaVCs
         Ng4udMJXLudlObRCsvBcfWyQ9Y4P+hA1KiYD5kojXeZYYpqYKWgeRG1cSVr/cdWYtBTf
         Ms9KcRt1yhbTtBzlqpyQUCxzWsUNCWFQ5HhFv+Zb+i8V7aI8ifH1diPu4C1BUKIx1Btm
         /b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333345; x=1793938145;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KLY6uZGPwiFF8FKR5/rBjv6CszZW/cjkjocdfXqgdv0=;
        b=q1vqyl1YVDK/dXK3imHXlIRjBFU9CiTD7xUyeRxuMVEkiONCnP+gX+sVQiTCkubxyC
         3FEfe8qZIkJ1HTgQcjtMN0O/gDZ992KTHa6R+DWWsLflIKjzMBoh4UNEJ7g90ZSZb3ZE
         S+w62EkOweeppyqvqgm0ROnxRoPMAV9LUr2rmDHMzuEBGWRr69m96WFmspdDW8mC1oHA
         nHBLvP9/z98bfK6e8nm8SvLNtVL8CtC2NsvH8CyheHw/lyBcTk66ZdH2RqbqLtLv08v6
         kzfDVCksoi5KYnhnJLkFGvi/UMoI20/5OHXUb+z19GwNWvyxRk7OdplTiF7XUdP1r+Ik
         V9zA==
X-Forwarded-Encrypted: i=1; AKwUvBzLFDWKs4jZHPvZ1apUb5oj1Rf6Z/QbSJKfjml1WZoOJzWmW9RptHxKvhETc01LHm+WUpyqHirxxznajbYEaXHn@vger.kernel.org
X-Gm-Message-State: AFq9FYKbcg7xoKVBD8XYcTMWAmMQWk1xl1QXPzpHbsniUmGNP5Z5fNIb
	4PDz9GxcgqDjovVSiMbBw08iTzzJzkRzgWa1wJxza3TN6u7nRADu6NngMCskpIxk++E=
X-Gm-Gg: AYBFou1ugG0MLokUGaU/M8Q6cCw5QGnkQYJCYvN8uxRyEV7iFKcs6nRdVCHUq1cnADK
	EBTK0SRsKJx4jjMe8DMyCX8qOJcNWpXz7UZTNcF7kFINjeLkLMGndMdfANp+7BnHuRwSzUBl7KH
	oiBgnHWrxHKvKik5nmF7d/Cm2wWAkGOTcenXNXpamR532cov/NHMiWlHgtXuGp2/3VjUJ6WqTCK
	GOb0vemK31QYYYXbIPztyMb+ru763zE9qyMqbP2xe30D3VJ7xlmtKMv8EoNE3JpBBBDNndJZ8Kg
	JAngTeywiBXKTInrmjPJzzSh4lVTuiTjDWXoVk+yukNMAZJJLTtyQAXkAmirt68BtfZoZc9OUb6
	sQcs2VpOqsMrSDKOS5ORS+WB9U/OmwBWV11Tdm/eMINGb4S1B00Jse3uhkU01fEFtYE4qXvt0Cy
	EaM6eimcpJT2YGSUv+/n3jgt7ebyN/lDQiD+umd7kjaC9bjMIm6Go80ZAu0jIOoGISnjLFrFClL
	jxtTHnu4T6i0a/HuAPkjKq79eicX+fkpNy6CYJchaPY6i23NhK12M3YSomJGDo77hmNvHEhBl5/
	UYNq3nhe5l2JRWCwlzFyoPlySeTjYgzurAUwSF5c+rIPOCa8xlTpMCvq8PyZjcwe8GYUYtPbEn/
	+as0lDa5h+g==
X-Received: by 2002:a05:690e:4007:b0:677:c605:b736 with SMTP id 956f58d0204a3-67ba4f3da5bmr934225d50.43.1793333345148;
        Thu, 29 Oct 2026 21:09:05 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba756e5c2sm310717d50.23.2026.10.29.21.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:09:04 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 0/2] perf alpha: Decode ProfileMe samples
Date: Fri, 30 Oct 2026 00:09:02 -0400
Message-Id: <20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7Zi2GAKuvAdhUcoUxgBtWiQaw
 t0teACXL9/P2yBSYIpwzzYItHJkNydQlwzMoOeekLvEoIQqpFAlegoW9egHjT44yyNNhKVIWVW
 1lKsc0tQHsvw+b+vmx/HVPsksx9fRGDguLnxO7yqP3h/FKlGgvRVGVnnZCSEf/aR5vBo3QbPv+
 xeAhpVnygAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Fv5bg9fYYkT1GcbeqWxYqtphm6wHQyvs/kxSvur0KhY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeSMQZyjbeZxW4VnuYW2aFkJC5lIgQR9fLZfNaEraYp
 G+5VBvZ8ZGFQYyLYaaYIkvcekWWWW07lvqclv4FM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 Ahk6RvEQOT0Gjczi4tLUIt20giKHvPySxJLM/LxivfyC1LyC9AK9tMy0koyM/KLiVKARenmpJaa
 ujm5GhgYmlo4WZk4WjqYmzs5Ohk5ujo7Ork5GluYmBs6WjiauluYMXJwCMNdEJDP8sxBiPNWsVN
 ydf+S8//XDTQtfCR3fdUgpU+PmxJMPv+x7sp2RYbaBuMlazjVazw7tiQm/UHVxT72e6/P3J5i31
 T84p6MtywoA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carries
the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
PERF_SAMPLE_RAW data, which says whether the instruction retired,
whether it trapped and why, whether it was a mispredicted branch,
stalled before map, or was killed on a wrong path, and what PCTR1
counted while it was in flight:

  https://lore.kernel.org/r/20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com

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
Changes in v2:
- Patch 1: copy the raw data out of the sample and convert it from
  little endian, so that it decodes on strict-alignment and big-endian
  hosts.
- Patches 1 and 2: follow the new 28-byte struct alpha_profileme_sample
  from kernel v2.
- Link to v1: https://patch.msgid.link/20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com

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
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org

---
Matt Turner (2):
      perf alpha: Decode ProfileMe raw samples
      perf python: Add alpha-profileme.py

 tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
 tools/perf/check-headers.sh                    |   1 +
 tools/perf/python/alpha-profileme.py           | 162 +++++++++++++++++++++++++
 tools/perf/util/Build                          |   1 +
 tools/perf/util/alpha-sample-raw.c             | 145 ++++++++++++++++++++++
 tools/perf/util/sample-raw.c                   |   2 +
 tools/perf/util/sample-raw.h                   |   2 +
 7 files changed, 344 insertions(+)
---
base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
change-id: 20261028-perf-alpha-profileme-8010299be323

Best regards,
--  
Matt Turner <mattst88@gmail.com>

