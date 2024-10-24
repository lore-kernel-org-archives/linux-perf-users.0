Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B01AAE19
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755220; cv=none; b=Ykh8Mp0biQEsSVYuYhNP0z036mcaNKGdxLPOBanuHkti7YywzX6rttTWn18G9087pNtK1U5KkE/EN95Vi6P0kgauD3V/5dSP9KYwOJU/LrVJlalVlND+76nnQnNUyUmPDecdOcVEp8oPTqCPrPVL4v497KRq0NIWGXwGdtJLPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755220; c=relaxed/simple;
	bh=0odQGceZNBTkUJ7F9d7VELVpW9gytwTlwU17UG1a/+U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iQSbtsEfnmF2zY4SGg96FQnAFqvbLUaMtYk2jsAasvFMrcWVGRHih1TzAQ8WfvuUvUlRBZIn87LjRB6C/IUFmk+nqHyIzfyiyykQP7R30CVXQcouHxJ4vrWMz2ovoCiZxkit9BUMvrfVIlUlk+Ipn7v4gwSBbQEFxAkff34dhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAhqF73g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAhqF73g"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so12554907b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755217; x=1730360017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iAkrxns4o/btTyHCpeR4AXaTsboqF9Bu2tTm7l0wyc=;
        b=DAhqF73gMsdPuRr+r90hmQB7GUvP+OwUu4nVIinIp1c3c5cYUQrBT+8BekrsAR9cJw
         8qY38NEzOVk4ea4HJEBP/VygbFGZSko/kbLlaymTKZllpsM+jaPp1YX7OfUXMq6Rfnj9
         AAmkoPdsewrsBXF5I7wcyDEGSpH7z18fLEwNu1vY4+M45f6KV2hguf4IOM0wh6nc3gDd
         OIEFqJBJBodc2sVkXD/zL0c5Boe/jg1/LLaXvY7Z9IqxlwJmhWgqcdGES5/n1gutlMuk
         5hkDk7vU7UILqGLf3Df5lAe+4MR6/Q64NEGPulkTEPF49jH5EYEQZ4V/Guwy21o0mX2C
         ZQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755217; x=1730360017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iAkrxns4o/btTyHCpeR4AXaTsboqF9Bu2tTm7l0wyc=;
        b=it2aj+AVPUy8rWV5FqRwUT2jOYd+07hxdaXaI6kFx8WpA0tbLWbRz2vL7ywEFqUpOU
         +yPP5+viNhQOGsgBgyQJNvhjMIksaZc5PZCprrD6aiLI6n0IQMK1pcZuzUphzOHTgfMd
         Nh1eoGBbDK/w4Hz9/qF5LKcITEbS3L2hlBt84FEnVBIqs7PNRCIY4eYdodebPzqnIgRf
         wfWrSUFYvKgaBjneDHx2YjMUxcsKv5Lltqjlp7OX4pWYS7p4TAOBSrhTDaJbK/wJ+VWn
         EWU2ZFd++d8nqfqkM3nFHdrVPzhgtRV8l3rskcr2MMWBRqu4hyG6NtSnW2Py6ZuWMc4l
         3C2A==
X-Forwarded-Encrypted: i=1; AJvYcCV/8kDwi+uSdroJAockjYHgHiz/KokGESVsLtkp6OMVRgkeYpQfQ5hbWvqDn3MJm5I4+8slKWNDRRoSOKS2UaZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/D/C1XoDAIDT+iOSUcXgHUTNKramWydMLH8iJeH90/fmwvA1
	hQKz9s5bbMFf1OnVnEmVi4UWE5Rb11ZUVNez0yCaUWwpaq/Y37ZWYq3ZsAmgVq+eg8Z1l2gkdfo
	RtBvtOQ==
X-Google-Smtp-Source: AGHT+IFFtCAXX1qu6Kjrfshreh94FSiauh3ke22NfApbqYF5WQtwb+Vjg397ye8X47fUQ6CqaBJChB4TkWZg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:690c:4804:b0:6e2:1842:c2e9 with SMTP
 id 00721157ae682-6e8662f961dmr528997b3.4.1729755217042; Thu, 24 Oct 2024
 00:33:37 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:18 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 04/10] perf test: Avoid list test blocking on writing to stdout
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
2.47.0.163.g1226f6d8fa-goog

