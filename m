Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A8204C23
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459465; cv=none; b=BqEdND7F5bdXsm76ckw29m2V1Tj1dkSNZrPSIEoG1sGTu4pv6Rgszb7se47uLO1LDFc9YhSl2rGYjhVNtDcRDWBaxdulwYdFi6TqQlpshSUA6j6o6GqvugstbLL4MCDwW3p+vy6JwzuTSISS32VXfdks2g6CrgkbD04e926PxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459465; c=relaxed/simple;
	bh=2M8Z4oeAs3TxDQ/FDZqdElhrrWV5I/M+9OsI0NA04/Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nUIhKj4P2tORovSdrO6nAMw5AEsfS/GZUsNlERDSHNFXWyxHaF6ija53krCvMkr57Woue5ek6l1Z3Kt/PFeeE9GLUVh306jRPNdhnippzJL7bBTk0YPXDWG+P5808yTWElOveisC0twSDRSNOW4THp/Vj/nzL/ozNpFJCDSKbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fE7WU9SM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fE7WU9SM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so6124528276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736459463; x=1737064263; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXl/4sCW/KKr/jAegTBssmpp7/LzQrix957XB2rDl2U=;
        b=fE7WU9SMa2VFYU6x3AGQxXPcFd5qi38NZE6mLl3j6qSOvHugoPRJCfE/AS3i5C5a2Z
         xR+9o1IO5Kcj2AdHnu910F3Kd9nsikNitfLJNaoiaRWXbt6C7W43Lfe0tGq1VKOJVa51
         ajc8JyDJhm2Foh0IxW5rG7zveStSRJ93Nni8G0zt31FZLVE4Kwkebyh45RBCqXjrP28/
         uSliHE94J5BxpFVhec+V9RCvcU3hhQ46ui4NmWnaTtdUcD3NF193sp0fb4blTfOpSGxB
         fWPx6jGg+jSsjQWwKEqdoe4rRKu73H0Vfr72nz57Exc6/DKxpO72v0RUwVfIvdjLhlBW
         wJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459463; x=1737064263;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXl/4sCW/KKr/jAegTBssmpp7/LzQrix957XB2rDl2U=;
        b=S3Ton+1k/UXPJYopB8LyDYXmwCdosccyZryWj3qaHu+GrJPPtwF+vse6fzwmMTAqEb
         bVRc+Q4yaOH5MVmwC7l+p89ewz3xS8dnuyTD/F67KM/B+2WntRv997FuPEnDOp4DvhRe
         T5f8dU46E0yJwLVtncKQMV4IxG5kaj/Ktcd8mx50Vzl7zor88rNmOnDG6aps6gfFANSx
         RFjQk//UCX0h0tpUnJgiqEXB3IZYuHoAVUOJUffLDFjY8UC6IY42XvLUvwEAJk1wzYYM
         Liu4c+Z49sAIEMPgipaeyOkATYbmtHI6h2M8u8ASqiFpLxPMeXu5ap58pceeUm/j6tgd
         PBhw==
X-Forwarded-Encrypted: i=1; AJvYcCVy92K3Op5lQoAmDm4EsTTDS+zopEHuPqmyfEaT6Y6sL5TKi1MsLJY9W8dhTJNbN+uXp1Xj9C+sqABPxEnoudqp@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4MHUKFavCyW1bbxcUU9Dr99z1p6AZpKtth4O/i/bwIayo31Q
	kZYOgCVD5YNeo6y9qHn1VPkR7E3p2jmdy8qx71HwKbCbjenW6BJ2WvtQi416kGsXtOhaoiadRHr
	DeycfQQ==
X-Google-Smtp-Source: AGHT+IGCF/OA/mA3vx2QKdGrC37iSEna+juKgDnRJTwyHyBksYLpjoZmL/+MGNQrD0/f/R+9RKaSeqHjfRT0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a0d:de85:0:b0:6ee:fbef:239 with SMTP id
 00721157ae682-6f543f26fc5mr186227b3.5.1736459463225; Thu, 09 Jan 2025
 13:51:03 -0800 (PST)
Date: Thu,  9 Jan 2025 13:50:50 -0800
Message-Id: <20250109215055.454888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 0/5] perf test: Add a runs-per-test option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a runs-per-test option to perf test inorder to better diagnose
flakes. Each runs executes as if it were a different test, the tests
appear together in the output:

```
$ perf test -r 3 lbr -v
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
```

v4: Fix crash in dont_fork mode caused by cleanup work.
v3: Improve perf test documentation, including for the new option, and
    add some example output to the commit messages as requested by
    Namhyung.
v2: In the v1 patch Kan and I noted cleanup that would make the code
    cleaner and less indented:
    https://lore.kernel.org/lkml/20241109160219.49976-1-irogers@google.com/
    Add patches doing some builtin-test.c cleanup and then add the
    runs-per-test flag.

Ian Rogers (5):
  perf test: Rename functions and variables for better clarity
  perf test: Send list output to stdout rather than stderr
  perf test: Remove parallel option documentation
  perf test: Add a runs-per-test flag
  perf test: Improve verbose documentation

 tools/perf/Documentation/perf-test.txt |  20 ++-
 tools/perf/tests/builtin-test.c        | 223 ++++++++++++-------------
 2 files changed, 119 insertions(+), 124 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

