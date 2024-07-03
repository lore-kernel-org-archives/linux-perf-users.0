Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3E18309B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027287; cv=none; b=YzNuIlVrx4Spz1h8pLliwa0Dv43RhlOs/ezdPiNPNdCWkRX12bxmI90oY+m/DgkToIGIkNGrTCNYoNwn7+JmsOgHja2ZA37MYQj1Xi8TyEryCIO4v8cjzNVf2nAs6HZ6JyVgMn7rqkRwGrNFqLL/RZKhEjKm8yCJtGhYpn39qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027287; c=relaxed/simple;
	bh=XSLtNpQyYpFfkguGPVVIRjjiBCkd6K/LCJ4NTdjR/E8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MGXIMXryeP5gF+TJ6TANgiz2qlq5sEOnkGFLRL47nKRVPTv+DofJf23MFHLw8ectBHBKN71L5wFh5cAS7bClsulg1TT+bGRT4q23IFs0kvtEFTfKZCSNfdXtTZjRypgk8r+pxoO0Xgd50JesajmqLVlOrAlteOxLirr1ANJ+PgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD9XWGHh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD9XWGHh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6502e4c5aafso9078907b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2024 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720027284; x=1720632084; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6DICyukWO//hDnJTxN/2aPKt92AdYPiZHqQbb+7vPI=;
        b=OD9XWGHhhMPHEVGWrmlRhfoDbz7rSOnPRMDu9h3+lvu12+COAXXiDah5k3ggnG3kW7
         YoZhA7q4qMmmPDZJ3Z6NGsoJa/NYH+k1Ntp+RUWjUE70h0wqpX5++riCEoH/WS+XWQwV
         Qy5eDfwhOqbYAN5ZUjFP1GP34R0gtUShemRnbp5Td21ukDB25ogv4LFIC+DbXQ90Qlb8
         AMr43m0dQSBgJQLCVIexCy1DKRiu8b9SgQ843XRfqsrb1jvYhxvjTIN9oafE7XuNXet/
         YSjGbPN7JxeQ3ES9j5HqmYeqQYy08Nf9kE1opxJs+X9sVPY1ma+Xt8cdA3M7oVZKLVFU
         4fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027284; x=1720632084;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6DICyukWO//hDnJTxN/2aPKt92AdYPiZHqQbb+7vPI=;
        b=H+ZseskWmrqOuaRoxhg9cDAzhDKQPz90gWo++k+RpoQLSWOM7XOlIHO9Dyf0fOuMCH
         hEUgL6WtK1yZScTBQ9rQXNgFn7ccibQHJX5Nxa6gpPCpGpQ+zLz4FwyUS1b9Gn/zCQ9k
         AtPvrds6hzSOR9c+P+GoP3WL/9a8yP6S1PS4glFr0sOPYzmzGOfIlimVVeTu9Sxq13gP
         wFmsYWJTumyQ5TuRhwpAvUw6mBsnK3ZVgbtPVnT84e1A1c2s0XeX3mMi/f+ysMjssUIA
         u+QZF2JZc7Qh//07ymbJ0w2akXMI6UlnGhhT6NuevUewwUFm3JJYNNp3w2SPiCmblmMD
         4n9A==
X-Forwarded-Encrypted: i=1; AJvYcCUxalWFg8IDHHurt5FoPVsYTFOygsWfdXUpOi/cZfXnNoWDaHKJEGH5Zq/m3PyHKtRgJBZrEponaylITfLUi6cv7E73h45rVEY/n8pUmhjvug==
X-Gm-Message-State: AOJu0YzrDEaU+DNxXgYZOQMY26uYGn2iNR89klE608qBjibRQNj2wFyB
	67GNQF0rX+Yj4oxlVEJCrvD162P98Er3d5IASoLLCOnEl+Kv+hKZADvRZe5HigQQZgUy6Usa4p0
	ZmpsifQ==
X-Google-Smtp-Source: AGHT+IGv2CIYh9To76MKX40LCNyELwQzrEHoDJAI0BU1AT3bkehsbRkH7SSJrQqkR9ENVbfP0BoApbYrhh6S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bdc2:f28d:3877:f0f2])
 (user=irogers job=sendgmr) by 2002:a05:690c:c0a:b0:618:5009:cb71 with SMTP id
 00721157ae682-651818f0323mr197937b3.5.1720027284599; Wed, 03 Jul 2024
 10:21:24 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:21:15 -0700
Message-Id: <20240703172117.810918-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v1 0/2] Try to avoid some qsorts
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steinar Gunderson <sesse@google.com>, Matt Fleming <matt@readmodwrite.com>
Content-Type: text/plain; charset="UTF-8"

Reference count checking doesn't work well with rbtree due to the need
for counts on each child and parent edge. As such the reference count
checking changes removed rbtree and replaced them with sorted
arrays. There have been instances where sorting has been shown to be a
regression:
https://lore.kernel.org/lkml/20240521165109.708593-1-irogers@google.com/

These patches address a further 2 cases in comm and dsos, avoiding a
sort when the array is already sorted at the cost of an O(n) memmove.

Ian Rogers (2):
  perf comm str: Avoid sort during insert
  perf dsos: When adding a dso into sorted dsos maintain the sort order

 tools/perf/util/comm.c | 29 ++++++++++++++++++-----------
 tools/perf/util/dsos.c | 26 +++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog

