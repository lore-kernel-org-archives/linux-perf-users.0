Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BF18E20
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622494; cv=none; b=bSvbRR7ZAKfKaWa+rmpWzg8YnIlx+QUQcVam0TLHgG47tg18/FAzhHCpNcy1KAsRYbKf99MVvFOA96zOAZn89cigipP6wXyHkEfYX7YzT6JeT9gnaGlAOAsSKuB6WNDjyz360oLnAhsw3/mysrAQSSsVV6z26y4T/JpBhAHuWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622494; c=relaxed/simple;
	bh=37j/Z0B+XnloIjgIcP2R6qgOY6ShZO2LUmAQ9rdLv7o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=oU26xclJqpBmYfc5VfCswM4FtFH4e/ZfeL55sm8zn/+JWIVGfG7WhMAFU0vR2Y0eeib/81IwAw0cApRu2u3c7gafbou9gxGr1flEgHE5rAFgYQDlkMkOqf/Ng/EHyDhk06t6vuLrn9LOU05eRx3VuJTxi02hjU/DhhL6UIgg+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0ubfWNj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0ubfWNj"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f7ed6eso18840947b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622491; x=1715227291; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m4VDeNJAoZaS4Xs4WRhklAjJjfZZqn8kn9XarE54odw=;
        b=y0ubfWNjASQagDitG6ZmkKZKJiEMKJN2enAWLPpxtC01j/6S1yhZBWchJqszM+v7j4
         C/cXg33D+E1f4//yci8cjs7khMifiCMfHI29Xtq6b+ZTV4VqM18DsjlZKkTOiwo2NPpL
         ZEdSC0/0Tf0hprL9slYyd2YUU7qwe3Lshd1BwquGH80RA6Iz15aWee7ecTgtKg47B09V
         FvrwuCFldzgKpd/wcPNIMJXv4SnNlDfl8mnw/t9Kqy41GKt+eBpOfboVfIIPtd6ULswk
         IS7s8J5X8FOTGYIP5bWpV1c7sPhLYKF7/p7ckIlCECEcqh2zRVha97DSHqE5lNLTKWd8
         ztHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622491; x=1715227291;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4VDeNJAoZaS4Xs4WRhklAjJjfZZqn8kn9XarE54odw=;
        b=ZZX4QSqW0C9zIAY3rSRVwt514ut7w1XWQCT4b+gLI5O6IkuxCJmGY3NYOivMSY/t2O
         Mc7ZpZ3Vm1jnc2z1KGp/c5elu3VTJXQua5LR4fpmSfngKloacXRKuZv0KqQaePhDsgaA
         JO7AyGd2EqentFJH0j22j0ZwFQSTEO2u+uzgX2XFiVQB7ekslxkedwR2Rk3mDgOzwENr
         DNQ2/IYS8I3FLKdUCLF4x6bkR43eA6NEiY8iRu1U1h195VxUuzn7IyiQjNq/5WAhhhiC
         kDsO2q5HRSzPflwr0JbKEcOIZwJaER9Rnm5vPEh5xUnijH6qfKOfc60dXQY237ETNKTg
         Qvpw==
X-Forwarded-Encrypted: i=1; AJvYcCXyeKrbd0rBc8RfWKhHU0Z1R6FF2GJvCf5IDS/99il03GlUvQ+LV797PjQ3GWUzzU8U2dfTVxmfVFONnVnVfzxb+BO0gM7ma+cLA99HL7pBVA==
X-Gm-Message-State: AOJu0YzKvziCTYx7r7xYILDFYsLK9kiiYTynj/wjUliuIUnhcdzXe+ke
	G+iTbPMMA4YvwvOIuLyOdmwQFkjJDNbQPaNM0YcJAV5RO0B1gzWjLU9lpERHrg39c0x51vvhYxS
	/pl/qjg==
X-Google-Smtp-Source: AGHT+IFq47a1+HUIL9gjy9nk8sbcRRxfuJtc3btqJfIm+Yz6izu0eLOiC4O5aefoRZdX/lBTLZYP+14GruPQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a0d:ea0d:0:b0:61b:32dc:881d with SMTP id
 t13-20020a0dea0d000000b0061b32dc881dmr414597ywe.3.1714622490822; Wed, 01 May
 2024 21:01:30 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:06 -0700
Message-Id: <20240502040112.2111157-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 0/6] Assume sysfs event names are always the same case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

By assuming sysfs events are either upper or lower case, the case
insensitive event parsing can probe for the existence of files rather
then loading all events in a directory. When the event is a json event
like inst_retired.any on Intel, this reduces the number of openat
calls on a Tigerlake laptop from 325 down to 255.

v1 sent as an RFC:
    https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/

v2: addresses review feedback from Kan Liang, by updating
    documentation and adding tests.

v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
    that s390 event names are all upper case. Do a lower case probe
    then an upper case probe, make documentation and tests also agree.

v4: add checks to write (kernel test robot) and fix a typo.

Ian Rogers (6):
  perf test pmu-events: Make it clearer that pmu-events tests json
    events
  perf Document: Sysfs event names must be lower or upper case
  perf test pmu: Refactor format test and exposed test APIs
  perf test pmu: Add an eagerly loaded event test
  perf test pmu: Test all sysfs PMU event names are the same case
  perf pmu: Assume sysfs events are always the same case

 .../sysfs-bus-event_source-devices-events     |   6 +
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/tests/pmu.c                        | 468 ++++++++++++------
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/pmu.c                         | 111 +++--
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/pmus.c                        |  16 +-
 tools/perf/util/pmus.h                        |   2 +
 9 files changed, 416 insertions(+), 197 deletions(-)

-- 
2.45.0.rc0.197.gbae5840b3b-goog

