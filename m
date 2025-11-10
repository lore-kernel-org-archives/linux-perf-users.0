Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E378230D0F
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738382; cv=none; b=HZ5K8BjjLqk/07tr8JcwCqdduYwP4DB1MzqRHDTN8HT9pOAPOkm1XAatKvdaFjXKe0lt41FdoGhkIy6nOTq9OovgDfgX5O6lpy/D0+nFtaQBrL+DU8Ek9j4o1jWxCj9DB9DNoUCO4DkxgswZv7d3OX7BMQRcV9gy6VogW+0/hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738382; c=relaxed/simple;
	bh=9LV96d37xehqpithsFIs6MVs8BcbI2EjyS0bItBYfSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AyERdfs/FptBONzTPUJ26UEWg6pwldF33Gytjee6nSq/+37rAu1rtNkRqHku3lOF/lioHpYXQAmdhUcPQnhLUA2HIYCR8kN2dcn8G7H6vk0G3I36o8kPqwc+eRgBQrKxhOC5bM9IY3bNW60kv5A8YjlWy44Onl+FRLpYJf2sl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBPqZ2Kb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBPqZ2Kb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e66542afso38766145ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Nov 2025 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762738380; x=1763343180; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ4U7M3pwjQ17FcfKzTEAaFDLeG/gMTrXfhERhFZ2tw=;
        b=yBPqZ2KbyXqhXOBsg+YNKAsdXOm190LyUSr7c17v8Z3WkyxRDFqsD29/9m18NcNkjU
         0aKmZQe/tkmArR53ymY32cgXwcW53IN+HyBRQncMtgGzQKyj0+UFCEiPTSvuRQpf46ln
         7y9XWn0fv8oQm4SoroxqSpLXu4sHTvzzvk9B3Cm7hTF/FnK3tQDkrurCCgVONG2nseUn
         zl79Bj5ghCHWqB5J3KlNlFpplcWudLqJIPq19HmV2pYMucKomEwY00nlN8SefNN8ScBG
         JWtBU1/HNS/HORN815z1QhTcyErPqqKc7/6/8ILAkbxN0eZSol4pXFVaJKIjOz17HC6h
         60xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738380; x=1763343180;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ4U7M3pwjQ17FcfKzTEAaFDLeG/gMTrXfhERhFZ2tw=;
        b=Hwn8rgD6RFmAfa4FMrYOdhSJIO72vgzbIHWWptYAzFcQ9pNRqL7WnvT8uUaajONqG+
         OGHfEzd2+YJ5c8Wxv0Mv9Nmbu7CXmc0mSuQQTE3s7pWn6Fceaxts1mXY0zSacv0D3x6o
         FrhQF5KkJMQugKTnUBGbHIIkDVrf1+sc1tMG/Ri4RUEvwFiMSqCi6i4dg8EG2kmnRYBj
         kHvfzGnVVtx5k6gyzQfZDEgA0pESV5P7v8iYFFB9XzX+eRKA7aYKWAyvOogzycrvWQf+
         WHhY5qhmGRN6yH8J54Mjq5RIWkbX2WDDc7JJZn7dJ01V7FXAsHvTs9Wba98LdF+rvw3f
         vWGw==
X-Forwarded-Encrypted: i=1; AJvYcCVePF/+PPC+v8NwoTfkrgA1HLzzmE5nCkNTz/I7wilHRL+i8vpfMyUg7Tg7ZcHcp3ABNwO9WfYn6fz5Y46woFDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKMDwxi+fc8ADGYS3Ur34veLvWESlYmsbE7yQAXiiApzEwk83
	+Rcyn/24YHcH4JyGUqmirkfryS+88DwQEsXS4S4CJQIEmr5k3qFM1eDpVKqgHLjTh4zBHgHe53z
	AYap6t2St6g==
X-Google-Smtp-Source: AGHT+IGU/Cy8lULW9NbbWjCc8Ka2MNexQ9YPtC1zURZj2oeBjlfwc8cIuYF/gU8+FCBvxVfINfO1iEo9k4XI
X-Received: from pjzj4.prod.google.com ([2002:a17:90a:eb04:b0:334:1843:ee45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:264:70da:7a3b
 with SMTP id d9443c01a7336-297e570dd4bmr82665285ad.49.1762738380513; Sun, 09
 Nov 2025 17:33:00 -0800 (PST)
Date: Sun,  9 Nov 2025 17:31:49 -0800
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110013152.3099080-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf build: Don't add NO_AUXTRACE if missing feature-get_cpuid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Collin Funk <collin.funk1@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The intel-pt code dependent on __get_cpuid is no longer present so
remove the feature test in the Makefile.config.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5700516aa84a..5decc3d5fef8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1114,16 +1114,8 @@ ifndef NO_CAPSTONE
 endif
 
 ifndef NO_AUXTRACE
-  ifeq ($(SRCARCH),x86)
-    ifeq ($(feature-get_cpuid), 0)
-      $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
-      NO_AUXTRACE := 1
-    endif
-  endif
-  ifndef NO_AUXTRACE
-    $(call detected,CONFIG_AUXTRACE)
-    CFLAGS += -DHAVE_AUXTRACE_SUPPORT
-  endif
+  $(call detected,CONFIG_AUXTRACE)
+  CFLAGS += -DHAVE_AUXTRACE_SUPPORT
 endif
 
 ifdef EXTRA_TESTS
-- 
2.51.2.1041.gc1ab5b90ca-goog

