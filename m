Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB44224225
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794334; cv=none; b=XHxZN1W/mW/5okxO+J3lybNVCg1jzKGfTa/HXJB7MsHxUytBkssCz0X/N8Q3kTYsIcLe+JggO1Z89Q9vqCvSpCt5p/d+rfMc0c3VDPVjnEi1xw8hmKhj2zGXNhETZyYzYgCroA28hoOUvObzKF1cBbDNlIPqEpqfO1qh8rtdcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794334; c=relaxed/simple;
	bh=3YKELvxuxV1PLL+vU0ZK9NzmOjLBL5HGYpAzwG/O+C8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Rv/rBaGrnGq/sIB91MnNJUWkp0CYht2gfd6z0EI3i+5pgzRS6sOZ8VdIvcKXeiZdpjfXA5V6zZeWfVxYFFrQfVcuupKroktWqmp7eRd1mySTDJsfh1Xad9Tby+lMY4Mvfn4Li8FM9B6k7vydwz87q8IkxM4/EzSY7V6fBHw7KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQ6cb4Oc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQ6cb4Oc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4716fc08abso985406a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794332; x=1756399132; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBnlfMNnAXJvRMri5tmfNXUyqLPNFnaI1ehQvuqCmqU=;
        b=RQ6cb4OcYVTVdMBxN2oZGQXvq56q+jDOYtBsiXaPozHpckbPSlj3/kubP729gDMIev
         Ph1pOBd2uJqeC3hVwAjGe7QHGvQg//CVVjjoO36/wEjVNCLFaETJpv/88yj7gAMsd+V/
         Tg3M2ydxSp5SuQX4ppBZ+bzaWigpDbvFizISWfldt25PBJPTMa95SO+62Ii3FoALDRNt
         LYRxaEWVkZu2YzrLJiD/9mp/QY0hZgvWHmT9faOEbHhN7pHaeUJ1zZw+PgjxnYNz/ZI3
         89KLApcgmS3aOQL4OtbeR5lsZkJplGrTlSLobVc2acXs+sfn5QioN1/4CVJwA1zXySw/
         gK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794332; x=1756399132;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBnlfMNnAXJvRMri5tmfNXUyqLPNFnaI1ehQvuqCmqU=;
        b=BoOsbRNlyezBkKn0kza15FgRUXHRlqYndt6+CnTcATXawPPtJqpRRHjQxl14Ot5Yum
         W86LkV+l0nGl43dI0ScCmkecNj0cdcQTziJb6YNXuCTuK6ZmneVKqe/l4cg0MKDNQFZC
         Tz+p+dNbcs51RTHAU9XOilo5Ex4oJPDFthbFLX9AelLH4ldlpQKmbISsPic3+624kqKz
         iVuK5sA+1vvYM3+5m06x1SKr+SJVmZZF1AvCQPpjzapiH7a7kw8SRRp19nMs3A9w9EZ3
         uItd8vJMbUWDUHuFQDT2UIh1bsOn9dthV+Y1SzEwJvu48p3Pb0Z1vt+56X6ZrguIwScs
         FXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7KjB51n4aNPwGvTfp8mnVBuEx6eTkFPS/Q4o0bz2Tk+4vPz5voKKZNaDNCDMl0vFpEEeUpnky36PTnAbtWmcv@vger.kernel.org
X-Gm-Message-State: AOJu0YzQp32Ly6CdrQEwqnLYC28il8vN/jIhDpXLHGak1j7JIwcv1mYp
	UE03OMobMHvzfHcxUxRJG08aFQcsacI2mr0jU3u5F3CXH75r8KCVdfdZYZmSZHFbj2WCgFSgd1D
	FVvanNk2xYg==
X-Google-Smtp-Source: AGHT+IHvI/QHnU0J+1JnVYyGfrBbKwfv6jXDDIgr4Q/WIz4zqzZnImtQy88yiDm7axpXD3oCDs3aSJ3xNyFN
X-Received: from pfbhc8.prod.google.com ([2002:a05:6a00:6508:b0:76e:7044:f5e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a106:b0:238:3f54:78e7
 with SMTP id adf61e73a8af0-24330b219f1mr4841106637.45.1755794332330; Thu, 21
 Aug 2025 09:38:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:19 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-6-irogers@google.com>
Subject: [PATCH v2 5/5] libperf event: Ensure tracing data is multiple of 8 sized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf's synthetic-events.c will ensure 8-byte alignment of tracing
data, writing it after a perf_record_header_tracing_data event. Add
padding to struct perf_record_header_tracing_data to make it 16-byte
rather than 12-byte sized.

Fixes: 055c67ed3988 ("perf tools: Move event synthesizing routines to separate .c file")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 6608f1e3701b..aa1e91c97a22 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -291,6 +291,7 @@ struct perf_record_header_event_type {
 struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
+	__u32			 pad;
 };
 
 #define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
-- 
2.51.0.rc1.193.gad69d77794-goog

