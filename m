Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D5471D10
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305785; cv=none; b=L8tRMGRj3XJUHy52uhoLMQagZYObEvEGgMIdGlAywon9bc3rx/YPjweR1SVAkeYwnnN/maJzF6AvhokFChzy2mNcgycj//rdH8+8yUWNW/KSpjFJl3oPGq25IeR7KeTBIGQ+1kOcRc2n7ntEpuC6PVAeKRYflUkXylvL1kQmfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305785; c=relaxed/simple;
	bh=X5HTnmIevEAgh65VlSf446/RisR1ZaaOWZenKgokv10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vt53kNrgl5+97+IzR6OcW4mkhR7VsCytWAYElthjUP0oGYJUcl1+ur7S0M2iiHdDVv1AXuyQjCAVPA1fKV8B/dcqiGzoNq568N7giSPB+DegS0MvHH8ekKZZfGEI49lWI4sz9S3aua5lcqKctGf/EtE4K1qey6Xz77f618o4fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zd2SGbiT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zd2SGbiT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-480001972b8so241012f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305779; x=1787910579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g282Hfq1E3bRiinvQDdFnK2jPyq4jjgh08sJOHY2A+s=;
        b=Zd2SGbiT/L/ZYqaljm8dE28XLrWdMSCZZuW9zBGHFxPtucjNYDEo0uZMhE2udnoTRr
         mwh9/tGdMMeXq7mjuzKbEGdmzIm63JdmnksEWrRAOHUsaeAt6HWg92PDHqam313cFqr0
         +beVeLSw7w4vp9M1+yQMXIG8AB69rfN0qnsicrALwG8p1b97eFXKyljqGsp5ymbFBU/a
         ZIdxQaI1Q8lwZcMrbzRfzd86fRE1XLHIdp+RpZ9L8Dnzv74MVSE2gPk7Pl0xF3DjKTEI
         i5pGLQjUaN+/TkUWcqDJuUyKW+vNr7Hn/yJS3zRkonzhd/O+XAlFj+GrKUBBW6ef1H+o
         cBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305779; x=1787910579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g282Hfq1E3bRiinvQDdFnK2jPyq4jjgh08sJOHY2A+s=;
        b=ijE32UIjj2kvn9hh/brgvy0IgiopZjEujBZIBp9MsSAnVJ6JFrc2tVrdPqIPtEw7gq
         0ibFK7KZhyileBj24q1sqMgRpMtGj3u59d3rorAN8CgvMfA/lcW8Kdg4F9CVl5fNcs66
         GeyXFdKaf8IHoDJDLXQOHpPrwy4QG/dzAMU3AThONI4awdg4GfsKCPrL/uUle7V/wFsw
         4XzDvBnoh6gKbP1oyPQfBbFVixCRj+71vqJaCNyndXpRIh3WZMzq6Rba1Coz/XlJxXMD
         oVLaSyuGSrKYrAz+MDOEAfYKlHb9IsDMKaMaUr9MjXLBG2fdnFxv1yd9WnCYvcGuVG+W
         b9sg==
X-Forwarded-Encrypted: i=1; AHgh+RpPzP169Cp034Tcuy9dhcLBaBS5/QAv1GgHz4Maz/4gc55IbhJzgWzENHKg4Vol1lk/ssVXsLwWGoKANTM9ABdz@vger.kernel.org
X-Gm-Message-State: AFuF++kffoqr5RA0ZFlgeG9xjLM+980+4I9s4H/vepV/xiFdIrErcJx1
	xhF4ds488H4QHqb50tmBJZyZIPaVkE2cgHISqkhsxBF5mvV5ERQII7Q1h5lSpppYs3E=
X-Gm-Gg: AR+sD103WAhMqk+8t4OzDSqHLgApz5IYrox1b+JmeH62hr0VwOycxQz4kx8V+uUZqDo
	+gX3ebM1xMgTH/O6FjUbHp0Ruk6OJSMJ9uwl3hojJhREeFaNzlWA+b8/ZQHpZwuUZCmSN4qPkuS
	DyczdRmQLDuJ87o4HldoT9/LknC9huVcVpEZXTn6LgmSEg9cJFZcatIzC1Ay98v/qeweGF4i5FA
	CXEBrBRBqtoYO6IN8b3EAQ9b+bbcIrv4bxvuNJL/Aayio5SKyJ9ezwQJUJu7px9OpPHYN5vTCNg
	tJbP+B/r2JYpKOm4QBeHV9NtR7lRGY/Ow0F1BMvecG5pBIuZ7DiFE5yoc6D72AooUkTMOeV5rKC
	AcA4XJjhGUcGnUP7aBeXoQyG5m3uezNZFuUKkuXEm1UYFC1CxGXi5FlPv4yXqDwnfTUQXOobb3t
	aX/CGojBa3YpuGDqXzNTwZrxmgxgYPLuKDAAlq+XCmdA1JbF8REZIgGxXcf6y5k8xo
X-Received: by 2002:a05:6000:4310:b0:46e:7f72:b6fe with SMTP id ffacd0b85a97d-482c0b9dbf7mr7147239f8f.19.1787305779425;
        Fri, 21 Aug 2026 02:49:39 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:08 +0100
Subject: [PATCH v2 10/14] perf cs-etm: Don't print missing buffers in
 snapshot mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-10-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The driver produces lots of AUX records for trace data that was never
captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
only an error in normal mode.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d1eb4ec17bbd..6e04602ec204 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3318,6 +3318,9 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	struct perf_sample sample;
 	int ret;
 	struct auxtrace_index_entry *ent;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
 	struct auxtrace_index *auxtrace_index;
 	struct evsel *evsel;
 	size_t i;
@@ -3371,8 +3374,10 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	 * don't exit with an error because it will still be possible to decode other aux records.
 	 */
 	if (!found) {
-		pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
-		       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+		int level = etm->snapshot_mode ? 3 : 0;
+
+		pr_debugN(level, "CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
+			  " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
 	}
 	ret = 0;
 out:

-- 
2.43.0

