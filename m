Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872D18801A
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032999; cv=none; b=LNmL7hc8N0YUcYPvhXD1snVqBfsjokUFQZF7NprcU8kPkoLY8a+5Zr2xHNxvqqlBZSASYqbGFUdA2lflLF8cu0InpSAzMDF+5gbpNMdANdB1mXHal4Wd9hy3IZhmeZIX272OVAtXcJCo0P4Tr6IcqFieW9u6l7xwc+DwJtvcUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032999; c=relaxed/simple;
	bh=keMtSMjDnv93jDKJMLt0sqILs5/cqtbnZJWeDCHSVeU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t4hrZDctxW+TDIpFqt5MDNmkhDI3A9lV0Fa1PoQQ2Y/uw69uj1IAUMo9sOExySJrxFUGykJxY5htn3uchDSMM7Zc3yUhujw9xeB87Ow94bervs2usLEkPhgDE+bM9UBoapzvtSf2MogmcaGookstXf3TFfKVTc/smvnZjH4MX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNUyXtet; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNUyXtet"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225429696a9so10440905ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743032997; x=1743637797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZ0fc1ltTj5WbPOlX297bPHnO9yVWtFkeuONJmH1pFQ=;
        b=WNUyXtetYCI8wfb6Vy8CHFNBD5KTMriTusxBPv86hCpsDNBakN99S946+eGY+yV/R6
         acYvo0/ecmyZ4wwOQz94Qnn7hKRWGgWzXxRliJXhEH0jkmMAXTrcQF4nQ9Wddr2VrQRy
         wZA9PU+CpXM297tLVcEKFHWHJ53xyTt8NcIMScjsO0Er6AH6p65idpM+t5hKau9gTxt3
         +HAthYkE7PiWNLjSwnOt6c/qpdiGpgpTUEhdsSskPY4uMcL0wos8Q+k60v22nB6JgdPI
         64JDe8Ps3Xdga58S4TETm5PnOToD+LnwwL2aBi6qhQvmdgwGAL2MEVH5ZosFNIg+gAxx
         BMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743032997; x=1743637797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ0fc1ltTj5WbPOlX297bPHnO9yVWtFkeuONJmH1pFQ=;
        b=kJXCpMQdBjK7gm8+VBVWW9xz77piTQZOCSBTxr7G6SSXGVFAjarCQjI2w/LGpeQLw7
         YoloDh/ZRAc8Df/Z93HXxXqSaB9GDbKYuy56aFbBeYniLI/qjtCy7uXhWFQUoa3dc4KB
         TmMS+LOZAgp0mUx6frlezakgYOpLVYzvxCgn7vklSU4Ft9dXkM4MgfDIrhzgoNWrZ6IM
         d9bVNkr9VQQ3XX5sR3WxHW05cG7B0g12E4z8Xz2dS+VuFRJCpETOmtRsQrr7uf/A8xxe
         bBtDb2y6XC2HHGu0E8aXq8yjPJbZ/466ATIox5Txvyu/IEJV0G7Wr2MRmr8ivDSxXKtK
         4e0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBbIxbSyTx5S8M+AeTvmYHjgEe7eYjEdYeVD2CLFBtzskV6EWe5Pw8NS3Zki6ViKpxbuQZusMHwzJoacjyc46f@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGDVF+R+GLM6xE491p1tx+jXjio/vnYX+QLaMSmWCkZhNIHu8
	gAlvpoL/sfJfjJ1OckJK4WitnhoXQszN3OKvWp1+MByMLZ4gx5EtBJIcDwTmhfakD/eTmkzas7o
	fng==
X-Google-Smtp-Source: AGHT+IHuxfv+OBIl9/J81mua/RNG90Wjmu3VKhxyGeO+4Ev1kYpLPx35UWgI7ReZrLAj2fovQ/an0xqG390=
X-Received: from pfblk23.prod.google.com ([2002:a05:6a00:7217:b0:734:6f4e:794])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e48:b0:1fe:90c5:7cee
 with SMTP id adf61e73a8af0-1fea2f36e5fmr2804813637.28.1743032997293; Wed, 26
 Mar 2025 16:49:57 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:42:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250326234758.480431-1-ctshao@google.com>
Subject: [PATCH v1 0/2] Fix incorrect counts when count the same uncore event
 multiple times
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, linux@treblig.org, yeoreum.yun@arm.com, 
	ak@linux.intel.com, weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's take a look an example, the machine is SKX with 6 IMC devices.

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127430      6,901,503,174      uncore_imc_0/clockticks/
       1.001127430      3,940,896,301      uncore_imc_0/clockticks/
       2.002649722        988,376,876      uncore_imc_0/clockticks/
       2.002649722        988,376,141      uncore_imc_0/clockticks/
       3.004071319      1,000,292,675      uncore_imc_0/clockticks/
       3.004071319      1,000,294,160      uncore_imc_0/clockticks/

1) The events name should not be uniquified.
2) The initial count for the first `clockticks` is doubled.
3) Subsequent count only report for the first IMC device.

The first patch fixes 1) and 3), and the second patch fixes 2).

After these fix:

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127586      4,126,938,857      clockticks
       1.001127586      4,121,564,277      clockticks
       2.001686014      3,953,806,350      clockticks
       2.001686014      3,953,809,541      clockticks
       3.003121403      4,137,750,252      clockticks
       3.003121403      4,137,749,048      clockticks

I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
looks good.

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c    |   7 +-
 tools/perf/builtin-top.c       |   7 +-
 tools/perf/util/evlist.c       |  66 +++++++++-----
 tools/perf/util/evlist.h       |   3 +-
 tools/perf/util/evsel.c        | 116 ++++++++++++++++++++++++-
 tools/perf/util/evsel.h        |  11 ++-
 tools/perf/util/parse-events.c |  45 ++++++----
 tools/perf/util/stat-display.c | 151 +--------------------------------
 tools/perf/util/stat.c         |  40 +--------
 9 files changed, 214 insertions(+), 232 deletions(-)

--
2.49.0.472.ge94155a9ec-goog

