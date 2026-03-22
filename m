Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C77367F2A
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Mar 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141118; cv=none; b=bhscp9pxF83ZMhT+kdUUlOHcMQi1kXcXjWeOGkALky1LleeUb8sL3HOuzPoV0DsIHQY+J+u1aEpJlY37/LilVP3vmZ7wKwEHHHDDNXnRWw94RkoMc4B5yEEgEZZWc1bI/MHDTPcjY7Ho12uY0tHjoa95diLK0xwh+HFCcwI2Y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141118; c=relaxed/simple;
	bh=mUhs77h48VhgtyAjhTyDJ3FwTWR5hwo6IbQbkY4le6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QO+hxrvXAB4ZoKZuVs3FqtBMpE1qJO9OsqAa0XNGq6gpNxjIFvM22/sga/B+B6P59J0npSCzYIEqKVfaotJsXWjaTaHpwU8iYZypvQ7kBqhiqi3trazhqDbQ1gDHleUCQDVKtn+3suIRZkRnbre5XZTtc8SC7UBstnyKOhGlcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqLYrW3W; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqLYrW3W"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128edc72e5bso2038516c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774141116; x=1774745916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5v2cdYDygdPGNKQ1eUv8N21CjI6pyt8oIsrmu7TsyQ=;
        b=RqLYrW3W0npk2e3Ve5rZhkWYdxhV6Siy+RF5KolfIF+n8ceaj4wbhfxfsXzpOYqcZh
         VHvj+BTK8I0LA21nh4V7S/olWcpfKhaC7p5st5rUo4WkIwkZ5JnZtqcj86K7DIBuuaSF
         NrhXiaRXYAuJjtcIO5q8tsiOKzQ4B2/NKTF8NJ6TW4SuOZ1Vw5BMTQQFmimhIOPNV6ZH
         su2Ms9oz0NI+dtnh0ADI6deQh4+N2O9K2oHQbQLbCiglhf4T+WJoXB+Yj+kHx2xtxSK+
         Nth05p5kwyz/Pwf370ZpCMIdmeKvG392QiGKKtoW+GoNbyjS4TBx1wQ3Se7Yy3gITrl+
         Aapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774141116; x=1774745916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5v2cdYDygdPGNKQ1eUv8N21CjI6pyt8oIsrmu7TsyQ=;
        b=PhHiE0/n8Lvl+PK55dN5809m2XItcl4YxHP95VXIx6UhrtyVoBUQbpqRdGrLOO1Tn+
         hhQ3xLiuZk/jeeeTL2GE4yu+75+iXoxHKbWLtKzP+obMU7E9kRFepwfL9yn9jnQ/Do8u
         JWKjzplfmILSfYTek1svoD0SgeEYYkbunH45O6//26cZbhW+cGhmhIi6D7S5EHdHOiDF
         A3OH14eZoyvNuV7lDy7BYoH3YO4Y06ZYCEPk3nKmuXpNkc8RNCKvRN/zTZ+jzOjwWyhI
         O3HJJCjeQrfK5br74w6jlHq6CQu0Thf/3C1OEJeXSR7JTZb4d9B9lZ+dg7V0db0Z5Ffo
         FZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+AwaR86wSvCOANST0RPEFUsPRGqwl7eWQEySdxAnbeqcHBM3hSOfTjwyc789k6ey1OhPBwQcwbzdVC4RrDEx0@vger.kernel.org
X-Gm-Message-State: AOJu0YwBl1p2YTsHGw+nM+yWErUK3q4d1ciurHpoY9rdMUKf+pQZK8r3
	y4hJOHaXETnF+U1tXoJvteH6rgBfuw7P2W2k3EnN1xJRFgbtw1x8HZ8spW0ah7fqB5X0ydYLzhb
	uh0vTswZQUw==
X-Received: from dlea1-n2.prod.google.com ([2002:a05:701b:4201:20b0:127:82fc:dd48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:327:b0:12a:7181:2f1c
 with SMTP id a92af1059eb24-12a72682797mr3457147c88.17.1774141115504; Sat, 21
 Mar 2026 17:58:35 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:58:20 -0700
In-Reply-To: <20260322005823.981079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
 <20260322005823.981079-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260322005823.981079-2-irogers@google.com>
Subject: [PATCH v2 1/4] perf build: Don't check difference of perf and libbpf hashmap
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org
Cc: alexander.shishkin@linux.intel.com, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

The hashmap code as-is violates the C specification meaning
-fno-strict-aliasing is required or fixes sent in:
https://lore.kernel.org/lkml/20260321024446.692008-1-irogers@google.com/

We're looking to not build perf with -fno-strict-aliasing:
https://lore.kernel.org/lkml/20260320224248.536449-1-irogers@google.com/

There is also the continual problem with hashmap using errptrs rather
than errno introducing subtle bugs as shown in commits,
  d05073adda0f perf trace: Avoid an ERR_PTR in syscall_stats
  96f202eab813 perf trace: Fix IS_ERR() vs NULL check bug
  9f3c16a430e8 perf expr: Fix return value of ids__new()
but there are additional fixes on the mailing list.
https://lore.kernel.org/lkml/20250805063209.3678359-1-linmq006@gmail.com/

Let's allow the perf version of hashmap diverge from libbpf's so that
we can fix its issues.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/check-headers.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index da3aca87457f..36b91cf1ccce 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -215,10 +215,6 @@ do
   beauty_check "$i" -B
 done
 
-# check duplicated library files
-check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
-check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
-
 # Files with larger differences
 
 check_ignore_some_hunks lib/list_sort.c
-- 
2.53.0.959.g497ff81fa9-goog

