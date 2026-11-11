Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440527;
	b=nAtW3wuu6+Wl3a+5gqxXJbSn0pT9J37gyPgBB1eJ02wK8FNCRrtpSjR619x1YonYTAWP
	 3ZC77+cJekJFbrxCCRkLHOfCY2YGcwbLtO7lJud4ajin9ekKNuti5zDzAIkOrNI2SyXko
	 9jyZunvRM2D+7FyJVM4/6snl0UaZw9sf7EqcxVUSJj7coI0aQSIu42rDdoMNdksmc4qU+
	 3yXbR937dhkDiG1wekLxcOa27TCioaWjzimXctk7J0urSP7Wd0ByGyGSe4De1qXiVoaMt
	 zAaANPGQcbTi911d0SqptZ0fQI9gnc89BTlQScMMnG2XFfxx31kbjUqduLD6tUsGUXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MlLwmC7eqhyj5SluG/jr8wz+fFfa83Uj4sPyAVlAWdU=;
	b=YaMoyyhdnSbn3QZO7VUl8eEGOz+rzuQR8YAbmLRr8ZQkX5S+3bUInZUTmdlmdd9lCMZU
	 zgXhz0oV5/mQe6PefWpuTRTxXYGPNs7tCnXVC1CITr8oqL3x0h+uk0xPBC9jvlAfAWdIN
	 AxmMQzAg0coV+CY4Svcb/eSBAXzJZXf12QDMHAMLF4tSkbMLmz4krY2gF6mgMR7mapEvJ
	 uXRG4yI66bcuae77wl0y2b2GwYwrU4KA4o9TApS7O4I2Htu0+4zcCW5B3MyWjvO1IssJG
	 SIsucZt9enx7RU4QIL0lMqoOTBlYbsEPshpIKU+2YbXUpaBadzmb/QKh8ROb/BfvSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LxWaKLhO;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F239606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 23:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F239606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LxWaKLhO
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-376a4059061so127523eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794440526; x=1795045326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlLwmC7eqhyj5SluG/jr8wz+fFfa83Uj4sPyAVlAWdU=;
        b=LxWaKLhOfRi65GLeDTlvV8UU5t5kaXs/qlvKWB1L1rpvsA4tUJ5NspotgCTsvD2ovw
         +RQUHQfJtpFCwosuQYFjnjkYPKBCCFWw1wtsIlqilU283K1LK32olZGlgGpJ/OYbpJbI
         +mo09+4hbtab85qRNyQvW6D9Gq9va4SuDk3znCoXSHcODVSskkPj8Cun7wpBjCWsZouZ
         ug3EnZAHhZpT3IfRqki4kClThkAse3An4Rt8JYOf14lXqfJ7d27gdsrQsGdvNKYq98Tf
         keYGE+xk3fMUI9Zt8/VRi8DvraKOVkUf/1Bsv+BJfVjjNr/oZ4fbGpHoXQBIuGSsVrqd
         2s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440526; x=1795045326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlLwmC7eqhyj5SluG/jr8wz+fFfa83Uj4sPyAVlAWdU=;
        b=bRJrCfkCFP5cz20SaI2Czl2kdnKeZgRLbSxRY7wdRjRbw+oQ61vu5YWu5U6LK2v4nn
         9ItWmMSlW3xCp0I9Za2rMeoGfDetfgwaQMcAj63ao87b8sC1Yr/2VSvyMr5hl7/LcEG+
         wYHt7lmaFofG7nbm3sU9p5BY1KFNxzkDsxaDMFrQyZeVXYIgfb19w5DOLqnEWIwyEJao
         PFOj+LqQwkyfypnw9WD4p+eivVdfd75z6KKHIGkYYQ5+LG2xyoRYSintf6ofl2zaxguV
         YJkYvEZ1K8dgcnM7PbASJUxNFPIEGzpfhKt4FtGU3w2CdlSPi9eY4w/JKG7/WFqC0UGQ
         JFuA==
X-Forwarded-Encrypted: i=1; AL+hErG4nUVdfgsug+chvXqjh363p0HAvQfQcom15UykSDXUR4N1BIOJ4An6TDsMx33+Dv1Fapu6i2O1eCTL4W6KSpEm@vger.kernel.org
X-Gm-Message-State: APuU4Z9dh78FeHzO59i7JopIez07q9xCETkFSAnWMHByhF2oxMkByJHj
	myWFYAH1ynf17H9IQpy9Qhzrv6lc3heYQn6RvhmRZdgsMCqZicjGHGCtMBrf5o9+BHA=
X-Gm-Gg: AYBFou138T5O4ZSF0gEtwXxBj1X89dEPJ0LzJ7jM8hP1rH15QNaKEr9cotIZtr9wG73
	lfP67vuMqe7QqLaVk04hOCOpsdIyRROV59GhchlO7CAmSkLGsVPG0VxVe9hCkiubgnp1Xb32LV9
	Z8IFvgVoMp+kYPbBjjmVWWZ/D/wiw/fJl6BRJK/Ira7GrFqnfmIrABvAJwvpLKH89H/ml9meH0a
	cEP2CPRyBw222sJgn1gkeSbogvRa8YScXkRXLV9jYnnR7/E0HmDUuSKYdune7pkGEd1J5+q0Tw9
	UKmJzG1xh3iXs+4eORn3Cs8Mz8PBa/CARCM4k10iEEl3r+fgDHNAAHSAbl6SfjaiKRopKYkLLHI
	H1kZo17cCrBmnd1/mj32SSKib6+Dk4qaesm9DaaPDrDkmXiGPwuGvWUQluLfrySdbiTUbFHrGdp
	fw9mUSVzI+73NUct9jsUUO6HIIUvOR5/nSvL6uvyhgFoPDoZh2BS5bhl1Ma1TvCLcyJyc+P/t0j
	SzCh/jnGDtCS0htXrkKNFDZCb7KbDbfZt2d53hUoTFRKHK82dSVwv6HlC0hzx9g6loGk0hQvXOC
	VydtLjgWndrIKkIju3jyqfyhx+UD6FMG7n1GIFF4KiC3uIDTZ/WtQPskgP4WwBXXiiSsZDfhyhw
	uqHc=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id a92af1059eb24-1b3c01600d4mr5838434c88.0.1794440526019;
        Wed, 11 Nov 2026 15:42:06 -0800 (PST)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm40240128c88.10.2026.11.11.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:42:05 -0800 (PST)
From: Casey Chen <cachen@purestorage.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Matt Fleming <matt@readmodwrite.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] perf hist: Don't update the map of a hist entry to a NULL map
Date: Wed, 11 Nov 2026 16:41:56 -0700
Message-Id: <20261111234156.2276500-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
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

perf c2c report, including --stats, segfaults on c2c data recorded on
a loaded system:

  map__find_symbol
  hists__findnew_entry
  __hists__add_entry
  process_sample_event      (builtin-c2c.c)
  perf_session__deliver_event
  ordered_events__deliver_event
  __ordered_events__flush
  perf_session__process_user_event
  perf_session__process_events
  perf_c2c__report

When a new sample matches an existing hist entry whose map differs,
hists__findnew_entry() replaces the entry's map with the new sample's
and re-resolves the entry's symbol in it.  The new sample's map is NULL
when its address is not in any known mapping, and
map__find_symbol(NULL, ...) then dereferences it in map__load().

perf c2c sets the sym flag for its symbol and iaddr columns but groups
samples by cacheline, so samples from different code locations, with
and without a map, end up in the same entry.  perf report without a sym
sort key never reaches this code, and perf report and perf script
process the same perf.data without problems.

Skip the update when the new sample has no map.  There is nothing to
update to, and the entry keeps its existing map and symbol instead of
being reset by a sample that did not resolve.

Tested on an x86-64 system (2 sockets, 192 CPUs) with perf c2c data
recorded under heavy load: perf c2c report --stats and
perf c2c report --stdio --full-symbols --no-source -NN segfault without
this change and complete with it.  The data comes from a proprietary
workload and cannot be shared; no synthetic reproducer was produced.

The bug was found and analyzed, and the fix written, with the help of
an AI coding assistant.  The patch was also reviewed with Sashiko, which
reported no issues.  I reviewed and tested the change.

Fixes: ac01c8c42465 ("perf hist: Update hist symbol when updating maps")
Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 tools/perf/util/hist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 364754e9d12a..d5763199205b 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -723,9 +723,12 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 * become out-of-date due to an exec() or
 			 * similar, update it.  Otherwise we will
 			 * mis-adjust symbol addresses when computing
-			 * the history counter to increment.
+			 * the history counter to increment.  Skip it when the
+			 * new sample has no map (an unresolved address):
+			 * there is nothing to update to.
 			 */
-			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
+			if (hists__has(hists, sym) && entry->ms.map &&
+			    he->ms.map != entry->ms.map) {
 				if (he->ms.sym) {
 					u64 addr = he->ms.sym->start;
 					he->ms.sym = map__find_symbol(entry->ms.map, addr);

base-commit: edd09316bd3784bcae2b3281a892700e272d5d40
-- 
2.34.1

