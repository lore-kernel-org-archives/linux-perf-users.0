Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A615C0
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138249; cv=none; b=IVzk5UvqCIkRA5dfT/lcS/3BrmSF4h2tGzupzQtjh1GbkldGAG67Oq3WH78jp2QmjDtccf/jSoPjlgIZ81SqBuuHOre5j82gx8vBwAoOdvMQHksgRdzuPjCGPdJ3M/Wmo09uz9zCGXzNx1nynvxhRfy7QpEAd/IpoGOC97sBjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138249; c=relaxed/simple;
	bh=nWzK2sWZ6Z8nHMEPrWRkFV6YjF5AHdbQe+FRvNSlQfY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=IShIq5fxrl0D0Ys0a0rV7UOy+nfA5YhHOvTYYmwFJySn4NDFnGXVXGiNjOMXvs2h4GjFbSsicfqLDAB3wT9px+Z6Sd5pWLYbLke5TWrfAj5LBknwma2d4P3F8v/OJsYHzguCxx7VHe9yezO9mU424GSY9Zgm6bZ0WK8V7c7W2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DmtPbgqw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmtPbgqw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e225c289c90so5648873276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727138246; x=1727743046; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upRWoGqTyroyxo5Zs70wrDT7qOnjToEaTm0XO6j/m9M=;
        b=DmtPbgqwm9rSXOfRLw/UmEdYild691eeXFD7zbN+btqHmejmEx8ZRTx7enkXomwzAI
         IDp7GuWAlozeh664KyQ9ExksbdxNF9phvTT9ukpDA8f3EPQeq/I++DpXMG6AqWjl1aq3
         LlGJy4wZxFA9s9DBWqhMhSiOHaIxbdWaEUctdYHOCAVwVFSXs0xXIhSzo2bSDbKw87l0
         CQipUvz/vdrbT5AK4eSwpBBKtcuVdSA50vqdIhqwZpk9/DxXAI5B/pnP6zJanagtSKct
         iMtjYhPocqgLGzLl4q8SthSladoJaPTyrFbab+SlcELfKZvT79Iy5YjFHEOnzNEBbRZC
         mLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138246; x=1727743046;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upRWoGqTyroyxo5Zs70wrDT7qOnjToEaTm0XO6j/m9M=;
        b=HdsdI4YPnTVKa8Ixz+7JCrKUKpFwiQ1xeG7qYDvORRcnyms5jXflE1kYjp7GZIc7xX
         P4sWFEwT3KCnzJ5Fo2+h2rjqe1qOU+Q+64GUSGafpV4Wl2O/aVr7MDWfaej/jx0OB+Mp
         MHKLJ+qZn+iFLPJFrWjgqe6Nal0M8OAnqQ+/RQjcnN4yrhIztB2cUmx641ThAoPPosie
         KfQBFk/Gy65IQkltJ8xkztyuvH2Ggb0nRTsLxMqTLHMLh2AWYOzcpHni7EKMMyldmGsb
         4truiySbCjrDxyeMJXtIPBW3+L6eoIwVsVblinueyC/1uOqzidYcHdT3E4Jt/QCc9iNw
         tpSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTr/TQJ3p8JNFnslTBl7Q17teMTngBLjbX7DSS36kNuznzgyG14psAh1ZTNAXSm6p5XMc+gVhOUBCUsbAI7UMM@vger.kernel.org
X-Gm-Message-State: AOJu0YybNu2R+pFrzOVcpAuCm9U8Bsk6kTR4t0QL2PBYTlbAowB+H2YA
	x6gL3fyQNATO9n7F7eFz5lbiSU2ZlwKxbX9oGVn2c1K5v4iL5VJElBSedmRQYZJCM3w5lJnnjc0
	8BF4t8g==
X-Google-Smtp-Source: AGHT+IGSP3mTlfIixD7hCnVJrlETi6KEyVW+ABwML5thN0IfChfL6UiHcL1MQts56QEVsxOGq7XYw+d+ejuy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:d38b:0:b0:e11:584f:c2ca with SMTP id
 3f1490d57ef6-e2252f94f85mr36895276.6.1727138246208; Mon, 23 Sep 2024 17:37:26
 -0700 (PDT)
Date: Mon, 23 Sep 2024 17:37:17 -0700
Message-Id: <20240924003720.617258-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 0/3] 2 memory fixes and a build fix
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"

I was looking into some lsan regressions and a latent issue with
libdw, creating these fixes.

A thought, we should probably simplify the libdw logic but rather than
do it here I'll do it as a separate series on top of these. The issues
I see are:

1) dwfl_thread_getframes is used to test for the presence of
   libdw-dwarf-unwind. The blame date on this function is
   2013-05-30. As the function is 10 years old I think having libdw
   implies having dwfl_thread_getframes and so we can just merge the
   two pieces of logic instead of having different feature tests and
   ifdefs.

2) similarly, dwarf_getlocations has a blame date of 2013-08-23 so
   let's just make libdw tests test for this and make having libdw
   imply dwarf_getlocations support.

3) similarly, dwarf_getcfi has a blame date of 2009-06-24 so let's
   just make libdw tests test for this and make having libdw imply
   dwarf_getcfi support.

4) in Makefie.config feature-dwarf is a synonym for libdw support. I
   think using the name libdw is more intention revealing as dwarf can
   mean multiple things. Let's change HAVE_DWARF_SUPPORT to
   HAVE_LIBDW_SUPPORT and all similar dwarf vs libdw names.

5) We have "#if _ELFUTILS_PREREQ(0, 142)" testing for elfutils version
   0.142. Elfutils 0.142 was released around 2009-06-13 (via git blame
   on the NEWS file). Let's remove the #if and ensure elfutils feature
   tests for at least 0.142. If someone were using an incredibly old
   version then they'd lose some elfutils support, but given the 15
   year old age of the library I find it unlikely anyone is doing
   this. They can also just move to a newer version.

From the mailing list I notice also overlap with the last patch and
this series:
https://lore.kernel.org/lkml/20240919013513.118527-1-yangjihong@bytedance.com/
Simplifying the libdw support will address some of those issues too.

Ian Rogers (3):
  perf disasm: Fix capstone memory leak
  perf probe: Fix libdw memory leak
  perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT

 tools/perf/Makefile.config     |  6 ++++++
 tools/perf/util/disasm.c       | 11 +++++++----
 tools/perf/util/dwarf-aux.h    |  1 +
 tools/perf/util/probe-finder.c |  5 +++++
 4 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.46.0.792.g87dc391469-goog

