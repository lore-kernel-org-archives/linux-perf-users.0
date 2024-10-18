Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41252183CBB
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230459; cv=none; b=XlbjgTsDcWwEbjOKUMKuhZ2+UMVK5XANCT21zQzddiGmoyRaZgOmt1+FC18Z6lh2ZBGqxDiaZruYXCeMlR9Ctx03us6Vxh09S1oaYV0VkwCay8L6n4aLORy0jdBsRBesHV4TZM3fvw5f3E9GGS0zvhk/EpBi1rIv8HCtjpASJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230459; c=relaxed/simple;
	bh=8e+Q4WMgAUC2AFJM3Jw3+2noMVxztKU1eVkUFIbNsps=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dcnzNI8mHFMFFtSPZhz7DBPf7HvPEjGCx/ZurGVdpDFaNtuCq3IdF8it1lPsBMjWu2q2dQW2rCIzjqI0f+F9WIYSBLjDjufaEdChqUhODNBhKJhIdHZQ68V2v3SyynZdwIJe6Iz0mWZrzFxmCN6b4pLbes325aE7jaH3sOvAlvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ps08zssN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ps08zssN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so36752397b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230457; x=1729835257; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsQN3YhU9LCKt/5hTOi9Jor4dADGagl+y4jf9jVpPl4=;
        b=Ps08zssN5ONC9+CQaSo4wU5tjyplHArMK1p+w5m90xZycfER+KEqskIcNLRjMJaLev
         Dfj+/47BTpFPIKtjhVoTGmUyr58wnhgE6mnB9mYHkBUuG8aWCk+EyS8VOuy7c3AJvRJB
         Q1b6giwrgyqPGzfYOuQFy243DFe+C85JTP4oNPhXqrhZAh5XpY4mVQpeec1pZUjJTnhA
         LAub9wTS4p6ire3V+mX4NMDTYKw4gJMUkX+mX9HxlgrkhJ69B4D6mlP7SqK+o2ux1anZ
         n0Fj29nUfJYUf7RRQPSStWKkL7A/jo8Su7LYXtZ18bT8qhzKmma8OLFJA6VsFKWTblW3
         PBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230457; x=1729835257;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsQN3YhU9LCKt/5hTOi9Jor4dADGagl+y4jf9jVpPl4=;
        b=Sl7bmkmPA1YG2b/TPM8BJwtT0FKLpNu97EW+E4Kszv9p+x7m/IFw85RfIrz/PlpPpH
         2Tta08vdcSlSfxSn/GEXACrPaVQCkBeK/Tew/wG+ZM9y19mrnvjyB5IM3v+Zs6pfvEB8
         yiD2hj6TkuJk8NtPX51QeD+gwiU1H/V58acCAWH9qDPyzZZZtrTigM6uLd17Ck7UIESV
         tNbaX0MGWsN5pOFD5njbNDxovTTvW+1xIQStMTMD5bIy15OTibaEumqcnHI39TtSixkN
         Yn7uko387ajRJ+2djP5AdPi7iJD+Q8XUny7WJitnUtnUZXlBVmcB6C0JlEzypMluEpRb
         fmGg==
X-Forwarded-Encrypted: i=1; AJvYcCWaymqRRVE6jHhnMHFmSXgJg3YyGtJlHm1LhsUXGoIgAV0F5N8ICRNyQyWx/HCXjot84O4tZDLl2n0QlJv3wFki@vger.kernel.org
X-Gm-Message-State: AOJu0YyoaeRCiI7nczuFSfKGM6XP5FM/gw0AdXFdDFgm4lOFDwJscdcJ
	/aipz4xSlh6f7jWl1krGOL9wOMmqU1Nxy9cebJ3TbD6kJTy8+mPAsisBKL+LA/CP1svO0fJ0cXA
	/YbPxaQ==
X-Google-Smtp-Source: AGHT+IHSV0g8KfPFuSViNtTcPi2t1fku8t5liAXZpggq3Om56o6vHxc+L8l4VTrp8YyleL4IZ9CPDAkYsoM2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:680a:b0:6db:89f0:b897 with SMTP
 id 00721157ae682-6e5bfce3afcmr74567b3.4.1729230457316; Thu, 17 Oct 2024
 22:47:37 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:14 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 4/9] perf test: Avoid list test blocking on writing to stdout
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Python's json.tool will output the input json to stdout. Redirect to
/dev/null to avoid blocking on stdout writes.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 8a868ae64560..76a9846cff22 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -24,8 +24,11 @@ trap trap_cleanup EXIT TERM INT
 
 test_list_json() {
   echo "Json output test"
+  # Generate perf list json output into list_output file.
   perf list -j -o "${list_output}"
-  $PYTHON -m json.tool "${list_output}"
+  # Validate the json using python, redirect the json copy to /dev/null as
+  # otherwise the test may block writing to stdout.
+  $PYTHON -m json.tool "${list_output}" /dev/null
   echo "Json output test [Success]"
 }
 
-- 
2.47.0.105.g07ac214952-goog

