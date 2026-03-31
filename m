Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C42FD7D3
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983266; cv=none; b=uHHjw2g1cQ+EuOrp/p6B9BX0zGthcPwnS3NbTpm+D2AnuExSGADO98mt5ICQF9r2ylirExVN9/29ah22kWp5jxE3/HRo9GODqjvpPlETnP/lFHEfKexG2g05GfOmJmRBNjhz90fJ40wghvx9y2NZbAigS+XTeW3CUnTy114L6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983266; c=relaxed/simple;
	bh=39p+pFBt1FuOdxug1zjt+xv5bCcNbxHxb8H5c98uclk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nDIcIfbw6nJb2vWYyBPUd60OHsVzKmF/QTDuHCpIoip+P0bEeeZrRmZddN808kKNQH9myj3i8jibPq6EmumY2UeERchKXgKvswChIwLuRk25RXjnidRWwjFL7osyynoeRB/uHhqazgRqtK8iHJSC57crFt79HCcJ2VHrMx9xpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojedZjHQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojedZjHQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c8ac8e422dso1102981eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774983265; x=1775588065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrJuQzsjjh275HHgqwlw5BHacvr8h+qV8Y8i4ke0wR4=;
        b=ojedZjHQotl5spCggUFTZ8Zm1viN35ne9l76wpvLow00NLYAr3KMyckUUViuQ6lBce
         sLgy3nMBTtVg26cOMX4sSSv4r98j/gSywK/5o7AUzdr+JRUWV76g0yO7pI3zqMXU4/81
         MqF7yyLPBY6ZJw2bd86rJGGdpDE5j4/sZy+FMspR05icVc8rK5gf1RTDxvlcfGgFiq4V
         5y5+IkskIlUS82BW9f6AcBBZh56tQGuAQNywv0lBNGWCpbME/NacZjuYteZblO/+d8I4
         RYHVjQeNdoI1xj0clRTRSFL5l0ZUXgkTor8Ylka5BeCdoUofuIqU0DhV5bU7SthTSQmF
         /9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774983265; x=1775588065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrJuQzsjjh275HHgqwlw5BHacvr8h+qV8Y8i4ke0wR4=;
        b=SUmCOU/5JDdyaQXswAp3yj4olNs6Pf60dgO8T8D2YADv2egdkdnUeJQn1ZTePAT4cs
         5RXRAF0wZz6J6x+4f/qQAr1q6CDwOvQNAe+YyYF0iPiIu101lGuxpk2QF/vTOyd/3zBU
         lhFRZbo7dNPo3zoi1u6pv49bqexbfh1heJIKzXoqwr6+Ie3Lt/t2ek1TxRt/PKVF1/sP
         KNlGyY+Bgmtva5W3IerFuyjUbNbaPlHcqISZVy+zJM5Etwf4UWXMqjthkB+PRQS8ECYn
         RIBifRLdQXm7vcu+g53Zya1Knqht2EDH0akx1HrXiAse6+syBc4gRFeEpB4bcAKBggKT
         fI5g==
X-Forwarded-Encrypted: i=1; AJvYcCXcf2Fh7iW+UYXmlTmI7DzdNKJGfj4v35U/FwyyuEdqVwkkMhfiA4gI3rcP96eybd/yJ0XLu+riQVkXAmx7EKjP@vger.kernel.org
X-Gm-Message-State: AOJu0YxULJCyKOurEDdhvhOVwiQxE8Cz22pXD9nz2wZbLTqTfzBvR8lB
	TY/etfMYn8YPd+LeSD35845N/6mjtjLlWG+hTRRcKOmdMYhWbIWa1HJ9gLAXrsf0tY75dkF6bLD
	AyN0Gmha2dA==
X-Received: from dycnu7.prod.google.com ([2002:a05:7301:1747:b0:2c6:8e1:498d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3013:b0:2c5:76d1:7f97
 with SMTP id 5a478bee46e88-2c932fb2c4amr232579eec.29.1774983264317; Tue, 31
 Mar 2026 11:54:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:54:17 -0700
In-Reply-To: <20260331165207.4016392-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331165207.4016392-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331185419.4085479-1-irogers@google.com>
Subject: [PATCH v3 0/2] Add tests for uncore and perf metric event sorting
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, 9erthalion6@gmail.com, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	collin.funk1@gmail.com, german.gomez@arm.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

A thread changing event sorting highlighted a lack of testing for the
more complicated uncore and x86 perf metric event sorting:
https://lore.kernel.org/linux-perf-users/CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com/

v3: Address sashiko nits on using evsel__name and ensuring slots is injected.

v2: Address indentation and other nits from Namhyung. Add Zide Chen's
    tested-by tags.
    https://lore.kernel.org/lkml/20260331165207.4016392-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260325183045.1229502-1-irogers@google.com/

Ian Rogers (2):
  perf tests: Add test for uncore event sorting
  perf arch x86 tests: Add test for topdown event sorting

 tools/perf/arch/x86/tests/topdown.c     | 134 +++++++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 122 +++++++++++++++++++++
 5 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.53.0.1118.gaef5881109-goog

