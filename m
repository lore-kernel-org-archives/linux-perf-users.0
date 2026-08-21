Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081723CB571
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302386; cv=none; b=jiDId6z1DMvRSZXaINHyFM8cwOYUg2T1eZGJx6BexuuVoSpKQCOrWdiXdZnmxga290EKAbm5XX9Os8Xl1+EmTYtvw7SN+X/w8fJVprK/3Z+paID0YiCP4q7prz65ue2lY6lDE2Laoy3ELF+WyXOp8tcEB0bfGvRH8nkq8rnOOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302386; c=relaxed/simple;
	bh=VVaQ5e2XrkZGHnzVk7vx9/hrNzFxo4j83r8Wz1CGB4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUjiknYswCjVeNrxbTSLhDD0cF4iW1vvcC5Sv9umoo2GDCmjl/XDUI/qRqC4JTlU5af/z+6HsN3uKjMzXiuKWFfDAcUj1i4rbWoQ7ghrLfa/0wd5CliYYGYsVKeDwBe98fdqzMT2iB3NNf73tcAdnaZbbLb8c9OB07flC/9oqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPeGMRrK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPeGMRrK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so3122745e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787302383; x=1787907183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=juyu0i0qm66YFUjd7wDpGgiTAsAN9FL8SfSNjB9iwmY=;
        b=DPeGMRrKvhApEVeocxZO5LqJ0PX3obrNQeK/TuWrxW6UMdVMahmEfVNgaHxxy3Ry+l
         Aj3O++ejMFs3he+9kAWWWUVN57tXXEmIKQMprfUUBu9Lgi9yXJhOzATgp39RvHp5nKVm
         8pUxuoKSvJO2vwP2vEzv1KTmvywv1oQuWXvfhXS7PGKTLYakXJd2caOCjxbKW33bXN+Q
         IeYvqbmUK9XSb3O3zq6G4uCATknuAhvqCjc/60UDs60a0+x/eRLIRpKinuQbMHSDwF5Q
         gM5LOoohrKbpy79uOKGwPTzFjwkv66bSq//F8Ib6MKNJQKLc8xHvF+S27qHDItOOmBCd
         cASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302383; x=1787907183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juyu0i0qm66YFUjd7wDpGgiTAsAN9FL8SfSNjB9iwmY=;
        b=HG/Ku+B5bf6QaRjjid9TgfnwVwhSk5iEImGaC4h8nPWXBrY9vFuT0xAnp3RKNGl94l
         ntcuBuFqZvWWHDt3NnZuxlfeC9gPFs3iBh3i47ckL5vY8SvMY56EGSChxzCLxPlHiW7u
         H5TDmqoZJFV5ABKWWIFCVjf4fcaDg+x+jzb3MLeEeWICNkL/K21+TgJcQwDoS2q4xFW2
         4alY6LLQcB3Olz5x4gi62KTbTmDbwn9DJ3Sj4rlPv8w6mvv8VBUePLqpTcjfDB8I4ruq
         3pO0ipohv971cEr7206Di8g54DRIFvVIjY1hYAgUlOBVynxm+3qmzpEUjEI2N079KZnn
         LWOg==
X-Forwarded-Encrypted: i=1; AHgh+RppJ13VK7mgoFtL7GciwjSgyk5Y4VlMa46DKIF0AZUvLe5Kvrj1XHrIoAbtFRSlJhNtCj0Ul+8u2IDuMQ9hpvDG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fSUmI1PLIQYPoJCtObK6XZck/YiAV0y65d5bwLviAzfKtRZU
	vCWxGwZL89Ks0/JDCMmJamHL2sh/YkVKo1/Rk/w821Nbw/l591vC9WDL
X-Gm-Gg: AR+sD13CwCEth2RR5gQ1coOjqSXmXN0kjWcIBjz3b+t6odz9Nqs4KpTsRKCxQXjL4DC
	NlNN4uNkNzOaZMeiRWi/7Lv2BGT2FG1GUDLNTsD12w4P9f4u7OXkahmAXFDnXi8ZgeR4LtUqJpn
	waINVonyCOkJeqVCIV13qGxkJTlS5JXewWWZgMC8l2L/EzZEwzZfgVbnVjEr5eNgnkoKO0ufn+M
	Jt/rmALFvvWVumfzVNErYTOkCZkCGo/aT/60d04j64juXZviWYBVtrbazaiMH9wCdVd7B0Mqrc2
	VRTqvjXzIZSKlzYzJ9CZRanRiZLkHXnxAHqJlT0uTdwheAu1h/MbMOD3NRKTV0nDEH2+xnAeWKg
	vfMdWVPmNfuuzl1zq1EtJQD0JHHirmrwNC1jUaaoiB2qaIRZVHnO2NjFQoqZk9+cqmQXqHIbv1T
	ZbsmDN0ul21bzmOwv98tY/ROO1AEbrPjTXYvaiEpnQ/utDAE6B+JcwhahKLzjOPNMrHjiD+mKyE
	YaHaFQ+1GDh8opPScUWb0s=
X-Received: by 2002:a05:600c:1d07:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-499b857fa7bmr53738355e9.15.1787302382894;
        Fri, 21 Aug 2026 01:53:02 -0700 (PDT)
Received: from amwld-tmagires1.us.drwholdings.com ([149.14.21.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b7d23sm17004585f8f.22.2026.08.21.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:53:02 -0700 (PDT)
From: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
Subject: [RFC PATCH 0/1] perf scripts flamegraph: Add --asm option
Date: Fri, 21 Aug 2026 10:50:43 +0200
Message-ID: <20260821085044.982835-1-tudor.magirescu@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flame graphs report samples at function granularity, so a wide frame shows
which function is hot but not which part of it. Obtaining that requires
perf annotate, which reports per-instruction counts without the calling
context of a flame graph. This adds an --asm option that appends the
sampled instruction as a leaf node, so both views are available at once.

While testing locally on x86_64 I noticed that when recording using
--call-graph fp and :p event modifiers, the top stack frame of the
callchain and the sample information don't agree. In my case, it appears
that the callchain's ip is exactly one instruction after the sample's ip.
perf annotate seems to ignore the callchain information and only uses the
sample ip to record the distributions, which I replicated in the script,
so that both tools attribute a sample to the same instruction.

This approach has 2 problems:

1) (Occurs only when recording with --call-graph fp and :p) The sample and
top of callchain might not refer to the same function, which means that
some instructions might be misattributed to a wrong call stack. Is a fixup
wanted here, and if so should it live in this script or where the
callchain is built?

2) A binary object might contain 2 or more symbols with the same name but
different code (e.g., when defining 2 static functions with the same name
in different translation units). In this case, the approach cannot
disambiguate between them, so instructions might get misattributed. Would
exporting the symbol start and end for the sample, as already present for
callchain entries, be acceptable? This would also remove the objdump -t
call entirely.

Tudor-Stefan Magirescu (1):
  perf scripts flamegraph: Add --asm option

 tools/perf/scripts/python/flamegraph.py | 120 ++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

-- 
2.43.0

