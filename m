Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6873DA7C9
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927654; cv=none; b=JOfh3bTrhrrLoP432wD9gafp3Db+Qu/yLne8IgTKIDCnCEx+w8Dd9xz9S33SuVDPHwEr1VDzmW33b2fvVWqQHbUwwRH1N0h17x5xQsQu4o07GPrdav7XJOZJTcRe9+CWLSsEKt6rER4S409mL2h7UmoqsFt+jyp2c3RrSDYF5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927654; c=relaxed/simple;
	bh=NvVaZuTiqo4nhPYlRPnLw4qoY9n3uCs0iDruHZXLw44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u/B6Y9oNw3ra4ASsBkseVhCNA/DnPIR4zskSZXRAektXr9df3DgXo1n3h+QqkkWAsEPBBX5tA68XNyREriCaoQlddTLoOogrmSMXSfXcV4YW8ZC8Q1Ps29nhxNK3rAgXSed6TFRZ38tRaVufSEfORl8ZdDge2wQuukq/efSW2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbHhG83n; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbHhG83n"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a46ebe2beso65139437b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776927651; x=1777532451; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsWji0MqctKLH5RWyMnSGJ4CeDIPIJ8NnIIk/Ffp050=;
        b=DbHhG83nRoGi5F4SyoT+LJWDcghoNvrqBOlcxEmYoXIkGs29QWZZ4UkLxEcJQqrO8X
         0J5nG2YRbPXLvjPjAOACrBEC06XBCZ+sTZKQ4/8wUdXoT3XRr9YxZRwvg8g04sSW2p5D
         qYKrCv0+jaWfaIcG19nufvB0nNa+718KuCwqUaK7rGwwiiIjsSjWDkuuKmGYefORVWvU
         Zc8qH+ERcrlT4begguMmir7Lj9t/zZEJVx2pqqsYl6duvK9f5YmGXYLrAGF+JRfZLG1o
         FzaS1idglOHQeEPyTF4fsa0fTY1hqXRiJBpo8izrD1416ry3mypXpYeizWr9jbOW257W
         xE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927651; x=1777532451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsWji0MqctKLH5RWyMnSGJ4CeDIPIJ8NnIIk/Ffp050=;
        b=jnCsnfb7mnbUMJ0G2CGUsGev3LoC5nP1QG24UyUkWA4BLbBR+Y5CV1dMwc/mztcJqz
         j6FNnWy50OH5AfwD76zfSRAmGoIhGyh5SZWfHbGEP4kFN73yT5qWmiJ8JBT7iJUJxtvE
         xtkGGraF+RWr7NW3aa6XjiPXj42kyCuVG4tGHQA9Kd9tldm8GxC8FTHpzEJDSzHBaiLa
         Wn9yKCp/4eZ854K8FmRDpYcAZNioINDc2YEFlBSFm0wwtulqSreooIxivqzn24Pwi9u1
         0bD1A2odca9GVkNeZI0xrD0Y263m9aJioY7MNHH0kHxqg04wjQlXv4cPhextm+OiZcX2
         787A==
X-Forwarded-Encrypted: i=1; AFNElJ+fNGQ0s7Y6sbNNvNtrqHfvwL+Gpb+KwnBiVPUUK00PUEvojsrsHiFw11tQKuHPbOA7HTSfq1NqO8669C/RHcfD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LhbQq7hHlToQ3CcKeKPSj+z/F42RfpeV0sIf1l7wHBrecU/Z
	+avfCkgjEtvQgAF0vrBlQefj6bYIcAWlG40vGA+VzP9Xsj1Iw7mFJC2s
X-Gm-Gg: AeBDieuRyQ48BISSk57kdW12Ghy5+Vkkb6xSlkYKAS+KgmugrfOe0IZQZuuypPT0lBI
	xj64dLqX+FSg6FSxSRTi/FLAKka6z0KGua7c/khj6j4T8Dg1NPKNP8tcklRJvE2QXsRtIbAvfC/
	kTtPyV1VbyFFQirzwvsCKLIN3qGzQEfFHswg45Xxq+1K3N0ygEFMolFci1qDH9ZfZ4YibcKr2H0
	xUn1XvT9kpm7uD1EMLoP29oR+JkidGzVxig1V9KptL7MvLLvK0f3GCnXWBaAhBn2aw/nKYdCvwv
	mrbxYtdnbzgQB5JCUe+f0ZvaFIHJLmjpmQtxDd3l5mJL/3r92BdlPSrJCOIPaD2rs6N3FdT9wlW
	h22q7ona+t1pXZs7ka+srbHIQS/Au4ufJNke9ahHUSuJYA3FDL09p88ikjrN5b/5ksbCMRhlCKx
	+Ox7tdmI79qHYosbo7SIxTBhi+Rhli
X-Received: by 2002:a05:690c:d8d:b0:79a:7cff:7b81 with SMTP id 00721157ae682-7b9ecf8a0b3mr260371497b3.27.1776927650884;
        Thu, 23 Apr 2026 00:00:50 -0700 (PDT)
Received: from localhost ([172.216.252.33])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bb005abc7asm29906347b3.38.2026.04.23.00.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:00:48 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:00:41 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Guo Ren <guoren@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] perf dwarf-regs: Fix off by one in
 __get_dwarf_regnum_for_perf_regnum_csky()
Message-ID: <aenDmXNIKdwdtMzn@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Change the > comparison >= to prevent an out of bounds access of
the dwarf_csky_regnumsp[] array.

Fixes: 8cac4013b0c2 ("perf dwarf-regs: Add csky perf to dwarf register number mapping functions")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
---
 tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
index cb44b774f8d9..4c586a5cb763 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
@@ -118,7 +118,7 @@ int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags)
 	if (flags & EF_CSKY_ABIV2)
 		idx++;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_csky_regnums) ||
+	if (perf_regnum <  0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_csky_regnums) ||
 	    dwarf_csky_regnums[perf_regnum][idx] == 0)
 		return -ENOENT;
 
-- 
2.53.0

