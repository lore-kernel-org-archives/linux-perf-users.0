Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745793;
	b=fLS9S2x2S72IqPPuLpalxhbsXV978cnzgmjJ1+J4Pg0v4qZuMtl9ZFKzTNb7CbpJjesr
	 c0e/GqrP0HtREV3L4tEsUQmHRImfS+5tThxQRqYLgQI04Y07JO2viuKe/wwqHIXLZ3KkG
	 +SQiMop4OhS6HtZc6k6xit/l9KkKw5ZAYqxnJoEi6uyeepk044XM2nSpSTyHd8L5KKfoj
	 0TH+1v8W+FNMdqghDLZhB+eAI1amGGS9wlIQI2QtqP+yNKtGmp/T5X+1qNSG92zKMzSZu
	 MD40vleeCeH4GvsAZNjpOzF3J2mGMxEB5SyZPdu8AUjgMmLrTAr4r88zHWpLWslUelw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MW9KGsZQePKlH0HZnpkH3ZhVJZOpK/B8rTMBwoNEOZU=;
	b=ISUXisZkdHepYKPP6TXW4NbKwsmP+0dEwmoqPfZvOF92NtmAa4DRDIywi41NsjTBW9Lj
	 JduX/B0L5jZE0GxlR04ugSUoNnTejKaiGPaGt00cKcVTefn6Sac5yNbRH2PqICduAJuQE
	 mi+yY7qqrMvGi3g83LZpJUpT2PEZdjtno++CUqNje8BJoLMSJaVestAVmjPHj1VAcL0zu
	 9sw3Vi3EN9egRTJksj0hF1gJ1wjj9I8W0gOzdcjKXhcOO4arbYBc4iHSN01JCY8NHPiLE
	 28xEtpuR55ov/NYD2a1/J0S/RLcfucQvutkh/1PwckQrMmY0PKHgnII0S8OFFa1NIrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0qReEMX;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C9606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 08:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 634C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0qReEMX
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so1515119eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792745792; x=1793350592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MW9KGsZQePKlH0HZnpkH3ZhVJZOpK/B8rTMBwoNEOZU=;
        b=s0qReEMXKyjfRfNA6gN7LbSD6Hbtf0BVMUv5KXr/BGYrfwTUoAaOJG/fz6A+TNQESO
         Rbylfbqu+vm3C1IbWRZxgNZOXVq2xfxxnFBk+0GTj5rCUriKTX691CgmYij+zAXs7OUA
         1FlJUEJ5L0QNsN5CooHVmpU/iRE/5Tsif5tgoRnCNR0K/Hanlddaix5Ob9bgN16i99OA
         WrS5Kj6X0zrqRc6BrCN8vpbaKqy/NWKorJ/Dozu2NhXCmtDzvm8Qgr/fk7u+8vZONxQk
         jG0Arzi5mlhL6tEhpNqAg4zJeldc6G+dsj2cty/NvY9OyTCreD6vev7ZYovIOavYwnMY
         jjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792745792; x=1793350592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MW9KGsZQePKlH0HZnpkH3ZhVJZOpK/B8rTMBwoNEOZU=;
        b=lKhsh+lcCIN80ZbRvEbWyLSqjNkP/rQz0Q6i152msfoKFxYSNnEafjECadBK8MOxld
         oGzNJ3Aj+W7Sb3Uy8eb34DTx//hsZkovAmx+nd6ehsKe98cA7RzhFLO3p8vk7qUCM5+c
         k6M/d+Rxqf2oc3/ug5SnBm5bKOA6qHfqW1+tVCGrEYnC17KwoOQ5UWFoeeYF9Gus1kje
         V/z/3ZuikWIFH4HA/FqKOoTh+AT9rPtWCRNN35ce2jdTm/M0j2KRXl8mUer3BPhcTkb0
         A2mQvpl9xDPUlOaTU3RyMwYeqW0U9+pQXcf4wcwfHoQ00zqhBtMfQ3n8GrdW9vOcwT/A
         oGwA==
X-Gm-Message-State: AFq9FYKme3iRWgmvRr8PBz/xr6h77MJYVjccZzR3If8o9iFquZBg3TNP
	ayo6MEpk9ZrDbLOsIelMYPxRK9kBx2SoSwMIG/AuzrgzxhGhojpDUH2e5dXA4w==
X-Gm-Gg: AYBFou0L7zxZp+3+6aVtDJV/0XG0KbM5GwG9lusLI7CG2a8l1y9Z2Ln6TplsH0mxxwt
	hRBK1uoiL4MoJ3dwmmRTE9nzLTv6gSHvWktqiyZmjXL2249iW1zmbUAZClXJcE3/qG9jpEeZVex
	Y0HZ5oR+/A/ywvJd2WyyzfgD+0JYnlSKADV4Jx+9NpqfDnUHo73XsgXuYlZ4SWJl1I9Jn69GOea
	5P6kZSWAqksxdcc4EDEV3XqO1sFzG0spPVzXl1AYqjsg8gzgBkbokc8Wvoe0SdD4OZV9Sxn3s82
	6gSLzARUJQ/a1ibwW5PbJG4f+Huf6fhHOZvB1fEXqkqbxvJvJ9wMQgg8pOQldRZbuc0yT4u1R4T
	FVN5P56M+Mb1RqntqqAWM6vS5Cx1Fn4E1o51/0vPWQLlkVOSYpULJT1FvhiroxnEi9kkEOQ8wK1
	p+grMJ5N3gYD2QrqLQELynwChIhN3YQZfiejFDdS2kecl8SEE8X+V3j6BX6iZYmg2g9B+/MIohD
	uuQIolCdmFmcNqwkx2Gf/FSeHWp7pbMC0CsVx516P+wNsE=
X-Received: by 2002:a05:7301:fa4:b0:369:d7b0:99f0 with SMTP id 5a478bee46e88-369d98380bemr2646988eec.21.1792745792302;
        Fri, 23 Oct 2026 01:56:32 -0700 (PDT)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c145ddsm5440758eec.1.2026.10.23.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:56:31 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf evsel: Skip group members without fds when walking a group
Date: Fri, 23 Oct 2026 08:56:29 +0000
Message-ID: <20261023085629.1694941-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A group led by a userspace PMU event and containing kernel events is
opened with group_fd = -1 for the members, because the kernel cannot
group a userspace PMU with a kernel one.  The members are therefore
enabled from userspace when the leader is enabled, but their fd array is
not set up in that case, so perf_evsel__enable_cpu() dereferences a NULL
pointer:

  $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
  Segmentation fault

  $ perf stat -a -e '{system_time,cycles}' -- sleep 0.05
  Segmentation fault

Only the leaders of such a group are opened with an fd in this path.
Skip the members that have no fd, the same way __evlist__enable() skips
leaders without one, in the four loops that walk the members of a group.

Verified on an Ampere Altra (arm64, Neoverse-N1) with a perf built from
this tree: the two commands above segfault before the change and print
user_time/system_time after it, while plain groups such as
'{cycles,instructions}', 'perf stat' with no event and '-r 2' are
unchanged.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Assisted-by: LLM
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4cb455f4a7d..32c54cd4acf0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1882,6 +1882,8 @@ int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd)
+				continue;
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
@@ -1917,6 +1919,8 @@ int evsel__enable(struct evsel *evsel)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd)
+				continue;
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
@@ -1952,6 +1956,8 @@ int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd)
+				continue;
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*
@@ -1992,6 +1998,8 @@ int evsel__disable(struct evsel *evsel)
 		struct evsel *member;
 
 		for_each_group_member(member, evsel) {
+			if (!member->core.fd)
+				continue;
 			if (evsel__is_non_perf_event_open_pmu(evsel) ||
 			    evsel__is_non_perf_event_open_pmu(member)) {
 				/*

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.53.0

