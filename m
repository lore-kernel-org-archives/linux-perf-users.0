Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4A282FA
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122991; cv=none; b=TQrm0rzG8U02rJuRNE7h2RH8fRkXCBisX4lb2mXoTq3dL2JpwEYANLy6z/DGSZo6NFPwRzyKEZYjNsLvd/9DBUD4EzENkNjaDhbYr1z0Xg7e2ty2Td/oyb9EEcwRYOJGF7UwpSd5jJtO4sh3ALTZXeXMueIUdDrCJ0phh1cb8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122991; c=relaxed/simple;
	bh=Bs2cKov5g074OfyZxI70AYL69p/8X/pN8AqRpTZvDu0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=d2yRCEhCDxjsV89O77q4nYsstz28ZGUuytY3VL6lgoinQU69rZCZCHjy05u8J/9ApCq20lAixVOBVtUAjtqJXgQrGQCuOqKoPWSrak5ofRhJfQIQCkUOYE1MZS8b8Hd+9QWcmJsMprua5yTk3m74MfqyAzjOKHZTqZoU1WbssRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEGglxzw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEGglxzw"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d6713619so9585837b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729122988; x=1729727788; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bEzJ0iRcDple22huSPs4DlKKUeqmgoCxw4frQ+1aRxk=;
        b=JEGglxzwpMy9T3GD+AGUxa99b/eSh3kfHGlTRiZ1/by9WD9U0cpiUWR88d5Q4Km07S
         Gxjgw5/03t39YkkmxhpnGYEprOSixlCPCsP/BwB1SGS9R9vnetvPug2C4TTpcZkV11Jr
         mDZH7qaZwpOL5pQ+LGBJJckv5X/ZsfUtBpSglRxPec8ZSDmL6sg7pTe05XONG9TLANYb
         zQIt/rkxIio69dOo7VpKlW8ayjz5oKIk0UuxhX7uXEua9HFRt76i4fa28jfLCDJTV82j
         geID3GR63DO4WdcbQS7C3SPo4S3gk+MQDsQDoFBkYT0eo8pPboj2zSDH/4vZkqtkSeTh
         2CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122988; x=1729727788;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEzJ0iRcDple22huSPs4DlKKUeqmgoCxw4frQ+1aRxk=;
        b=iwtO59GmG7aACBGV94EXJX4yRWbIPXdi/FO7Gv94R2eJAk0FkBTZpmRiUXdkfd7hod
         7+1RgU2xoas+kXvsOq9rJ/O+agz0SAFntND0Me8aOwH1P/ok+XRJsRJ/GFlZZzBvUGCH
         FFUdzsHjVsmfymvWOZfZJMVHgBPlixjnbefq5ZUpQVFyaA801C8vkDaM4Y0TkgLWwu98
         BCt4C/T88J6FqdQm2tPPc/1MzpGwgk1xg6z+YjI9tn6eomZqnnKmT4LSkL8dyNHbnqP8
         dqwECbLx48IzoCsHpqSxCcA5R5NW6Ih0h76ih6fXA168eCCamA3X1B5B9CEuaPreLDvV
         cF4g==
X-Forwarded-Encrypted: i=1; AJvYcCU/yVVMZGCYgaahzlYAKsimGEM03laD8Mzn6PBKgDWWyonWE75psM+OdHUMxt3WCk80RE27wfmhaFBJThYRGOYf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoa5Jt+cARtsSqOmIhUFV+0GWhebBhCHRpeIu1n7I87gGMn4tv
	hi2yH2Wij00SUcX+aMmbHM6NSCzZ0Ht6sAVHxKY8q8j7zWtcIPdr+NLuFFrVG90TyssrF7l9nE8
	gglKjZQ==
X-Google-Smtp-Source: AGHT+IHI24jqBASrAtT64uRY0cnhQL9f8zsYp5VuyXMpamVCWXzsRO52catAzQegbSl+MV9plJMSCJY0TmT0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:350c:b0:6a9:3d52:79e9 with SMTP
 id 00721157ae682-6e3d41a64b8mr1096747b3.4.1729122988494; Wed, 16 Oct 2024
 16:56:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:56:20 -0700
Message-Id: <20241016235622.52166-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v2 0/2] Fix 2 memory leaks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix memory leaks with libcapstone and libdw that are detected by leak
sanitizer as part of perf test.

Original v1 was here:
https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/

v2: Avoid broken free reported by Namhyung. Move build fix to
    subsequent patch.

Ian Rogers (2):
  perf disasm: Fix capstone memory leak
  perf probe: Fix libdw memory leak

 tools/perf/util/disasm.c       | 11 +++++++----
 tools/perf/util/probe-finder.c |  4 ++++
 tools/perf/util/probe-finder.h |  4 ++--
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.47.0.105.g07ac214952-goog

