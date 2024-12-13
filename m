Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0184197512
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123881; cv=none; b=oyqkhsEtT0Ni1UU75Lw42TITZZWB/ZcA1W8xSe0uwTcttcDxUxLCl4LKUQ0rRkqExill0mIsVS3NgyRl+yfw0cyokyFk5jUVYaMyQLzY5wOXUHZ1ocgL56tKLiNqr+EB40VdLY8uR1Yp21QIXYy+RuNNJT203jiF6qh9e1az2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123881; c=relaxed/simple;
	bh=2AeeJI7hTLZBkAiyK/DWI/sFdQ+nhO6KpS8lk3LdjMw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZG1WKkRAzdXZTnvnNSNQnatTofh5ULLNAcRiyax/4qhyFwuQLWElyubpPdMKjwY9Fwql9ce4VxqNuDtq0hiTIyvYQCCT16PiXJDPzadiuj5omxROUCkQWLJhst49HV0HCMiKuPb/o6RPduw58pbkwaYOT1gzDMXwEH9h5Xdr8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ywx6XmXO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ywx6XmXO"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so2734046276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123879; x=1734728679; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO6MitYTG3PPlOm9eDgi+DN2s8ThN2cAWOELNwnMFAI=;
        b=Ywx6XmXOlGyb2ROuRL5cX+rWOMyxHMIt+9ORbsIOOAzXmhzkC7ppw0YX/mh3jIELFn
         uIw7zWokZk0e81aaAIs0ttHziMaN77lMvDAxstfFMKD6fkCz896sg8Lw09T2L0PD2pnn
         XsqVM+J0D/KLFpKBz8hcym1D0bXI/pJwDIHFvY3kImtyQU8RbtnE5E2jMf2t6TOMYBw3
         kXjZCmCTfx2Cp7xUQh0Gz39SWphyD92GJmw1fq5+ET+JIOJnZat5NSfQkeE688/3aTDM
         A2CnxGjmBQhBXeBGCGsHw9bmiCIv5DUZpXUSmYt3Auy5gOFVGCr8uALtQEZB8VdZUdo2
         EY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123879; x=1734728679;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO6MitYTG3PPlOm9eDgi+DN2s8ThN2cAWOELNwnMFAI=;
        b=aCxEOIOX0Dhf5a4h+jO7YuDtsdldvmlBh7+60z+tMpWo8nMbTOtXVZP4EsDMH7uVZ1
         4u6LcgvFlZUs7Mk1LD/PdCyhhyMjuYRmUwQbXYaRRE4QhAP1KNnawZD/cSy/c7TRJrTs
         9/L5c+yS13JVm9Oncm4t+Kg7EjR7LShmvbxta9I/0LhcRt3DcI6Fbr3fpusdYzfVNDdY
         8ZWgElAuu0WRlPMFpdizFdZo/TGWtrxo0bo4stl5FZWJLyBAspGQLrIj5HqOsYOp2OBh
         Iblo0xeSGM8uV28SOJIbGZI0K+IZx39SsUCU5toxuXJjD6sfjCKjCTu0BXTWqfI5hFoY
         yxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsL+Nl9XfZoB0eyHEC+W0A1dPpArdPRUCTK0Ruc2qt2wvyMunfFjGBKYSCmjHS3ZcWHMAtTkgKcyoEs3pu1W/g@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5UNPyUjkRxYXmkAPhIndtIkjVjLHMWUBFCEKddfLDylRrS1j
	8VkWklhZ10Wo+30Fx/ndYAASPFEW3PH4yvs+ltFizk9wbnltT1s7uPQ61VPZGM0uRmMVPghemr/
	//YojFA==
X-Google-Smtp-Source: AGHT+IG14QG/FvZm1o/zP6GcRY5++gc+EhOPsoB8hincRJ7FgCV5ULq+tkuBgEV+o3KlfVnsbI/svufofT6h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:aab4:0:b0:e39:fc33:e15e with SMTP id
 3f1490d57ef6-e434f94c734mr1534276.8.1734123878723; Fri, 13 Dec 2024 13:04:38
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:20 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 3/8] tools headers: Update offsetof and container_of
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update to match kernel definitions in `include/linux/stddef.h` and
`include/linux/container_of.h`.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/kernel.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 07cfad817d53..10f74f021d55 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -21,9 +21,8 @@
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
 #define __PERF_ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
 
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
+#undef offsetof
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
 
 #ifndef container_of
 /**
@@ -32,10 +31,14 @@
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
  *
+ * WARNING: any const qualifier of @ptr is lost.
  */
-#define container_of(ptr, type, member) ({			\
-	const typeof(((type *)0)->member) * __mptr = (ptr);	\
-	(type *)((char *)__mptr - offsetof(type, member)); })
+#define container_of(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
+	((type *)(__mptr - offsetof(type, member))); })
 #endif
 
 #ifndef max
-- 
2.47.1.613.gc27f4b7a9f-goog

