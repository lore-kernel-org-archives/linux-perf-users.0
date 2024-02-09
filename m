Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0128F78
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511811; cv=none; b=o6ftNdqHUS61CF7pLQev+6Fiz95jXCEyH26arwPqkbktQcZRA7W2Un4n0iHLku7jOJDosMTyWUozgFHcvwUssxn20oxOug7lN21l8+U3kSLjtKd2q5NEjZKUqt2T+4i394u6REbRt/VYObKH3XVqqdyrznI85AQzJTdsE5BIPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511811; c=relaxed/simple;
	bh=AWQhEFkQNqk0DJOWRxIBRwsWcI4uCFqmUyezjrNxX3E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=vD03w1sO14TYbW47ikzcdiSidRw7AKawQYsG1yI4vcUrFQer2SoJR0/cigenHXQH+p5vlzJPTzY3gLZ2Twuhr2nlvf5NKdL/hn2EGB4D+jbTGjcRvmsGj9ldoVf8RNiqc3nQeAdO68z1HEsLVEBDQ/N8GLo8Ldlfy6nJpNpJ1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Af/JiyAZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Af/JiyAZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604a423af12so32340387b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Feb 2024 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511809; x=1708116609; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKzeACn/rbwniRnpt/iV4ZJI2z4DRKLR+RaQopldiAM=;
        b=Af/JiyAZi9+BtALzDTzTQjYPyzlBOHbHrXGy5lwfnnOshBczU+CIkvCK/AKLf0f/Zq
         89R1lNy3GV1i9jPfMiLB4Uee2Q/+ZpsecXM7//Rmgel9MN0aPzKY32jNBpAt/xBUlsoZ
         4/aLYW7bbIUR84vME5rW/RcBsQTkP/nC+Wf0YVBlzaIo6mAtmd8uqHsnqGtrDwP5E/t6
         rF1c8agI0x3/NgWstX+srd4YwUByLuxozcTPUEa/YsngYx75K8MTq94LjyTbQ9WeHM+B
         01NLrjhM4Raq3Ahtcpr/06m9cOrG4u52h3XTrw2TrPRv7YWN2gX8tBiCXjDt/Js5295z
         H1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511809; x=1708116609;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKzeACn/rbwniRnpt/iV4ZJI2z4DRKLR+RaQopldiAM=;
        b=v4wVywG/Nh0V/ARFSBfWEQpZrd14ryCl9D4CkQWhcT5EMirCih/yjADaxllLBjogQN
         YEwSsvPWBnGPZ3JykayirCBPGmD2Rk1K/6ESFPqIiWMa3CqSXb1YGghQhnUDCnlKexOe
         NX+Fm8gIxEMA+5+pUNqPD9/DikS6rJ11je0QmUt1t8yQ9Fa1bLgIbLnDHcdSOLRp1Rww
         Dx7TisWlmRQMoL9hLeh81NVjTURkw18z19TS9ucabHzyT6qRekSyPsgKNrFqARtmSM9n
         1o4tK48FG3UP8G0+XM9ES3J1HVUVMi2s+VxfPSveUvocr7rR1Wqj9mc+vfS37J1/V6NY
         2Sxw==
X-Forwarded-Encrypted: i=1; AJvYcCUhZNCCxyprNpP6kvh24Pq4DzTKRxXq99ZStBAXplfqYc7FxTpXIIMsdHkbc20Kbz2QYmrcf9QkdJFtykRtLvDbaoTGPvmqP+ms0Mws2HqlqA==
X-Gm-Message-State: AOJu0YwqAp0GEQF0C9200E2DE8V12uZUyGOUTEVwfKFIz0bJs+1FCnIR
	/8gQX0ULl7bnQFHRUy/n3pUNYPfDUFclbsFplxJueHneqk5eWwGaxnnI4ZMLHm4QUaqxppH+uHz
	Qfizehg==
X-Google-Smtp-Source: AGHT+IGudD6Op2tEhoXmhrEvDE4Judp8qNeTd/bqcpbNtrTEVT5WVllu2tMEtZdLyG7zohzrrwQF6Qq2jUjo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1109:b0:dc6:5396:c0d4 with SMTP
 id o9-20020a056902110900b00dc65396c0d4mr74616ybu.1.1707511808761; Fri, 09 Feb
 2024 12:50:08 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:43 -0800
Message-Id: <20240209204947.3873294-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 0/4] Fixes/improvements to metric output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A small addition to allow NaNs to be encoded in metrics and then 3
fixes to various metric related issues.

Ian Rogers (4):
  perf expr: Allow NaN to be a valid number
  perf expr: Fix "has_event" function for metric style events
  perf stat: Avoid metric-only segv
  perf metric: Don't remove scale from counts

 tools/perf/util/expr.c         | 20 +++++++++++++++++++-
 tools/perf/util/expr.l         |  9 +++++++++
 tools/perf/util/stat-display.c |  2 +-
 tools/perf/util/stat-shadow.c  |  7 +------
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog

