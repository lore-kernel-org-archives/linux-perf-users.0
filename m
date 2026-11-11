Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368622;
	b=EuT5ctTTOz27TZpGRFhAbFi8RMQL/Rp55oZU9PWCsMsh8OOfjetdNwZ3G62l8BXFTkqf
	 xpuYdD7+EBwAzK8kR0J9OT91EsdxsP3YxLwYF8E+xHGNNQsEB0Ynlq25OvhG8QV579PmM
	 oJYYkupmiD44nQ3UVUWJkwGnKPb1gXsRr7NOdvUCJ+3TVLnoZU0PPIRQ3oQOSP+6aByfG
	 6cmbpWpTyW0vv9cwQLCR0BNgVSsPSWb4tdaA7rtXpvv9SfTgmvgI22q4CTnqyxwdg1g/+
	 7PtepAKnOS/Mz9JaIccFP8poqOP+nDkylmm31f6na7DmiLAf3IFDgoJX/yeJy4R6wRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ytpDuZk2ib/CPtHPIxmj3si9kiqbXk0AIF6ceCx7Zug=;
	b=gfq0slaFtUk40JjZjesYB+CEZeN7B/qy6uab7yeE+h3ECK3zvCxBU1ILHCYaw4ilXFkX
	 GxJ8D1nGhyh8z68MQfbmxzoIhj0dOHFQy+nb2qqRZykGzCIGtbn12gdBdNv/Iv2AsGPjs
	 +RhSIXNwdYyGhRs/pB5V9/DLsBUpGl3i95pD0CKZfD8YVL63WnCfzBHPfw04D4lNqT6AT
	 Puwm7xjhBIhRJpKhj+/jXXlXFUOQma97eVS2bS3SgJ3TF7/f0pSfRC85zWCpUXThBO2sy
	 pZfQ7nZ8XUTaMBQfuCHFMTNb5Yc3JAoyIW216RMyw3Ht8BFm7rIf3eb53D982TRz1nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xe9L6Cdq;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A8606A33F
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8A8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xe9L6Cdq
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so4736885eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368621; x=1794973421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytpDuZk2ib/CPtHPIxmj3si9kiqbXk0AIF6ceCx7Zug=;
        b=xe9L6CdqqMzAu0SyjHpJnPVLf8VdU8tTl3l8LnaMLvniC9vPZEUyUrLLQUmTa+wZCQ
         wm9EzGCZq9f/bipVJ1bb4HkkSuc3qjew4mtkmyOMg4jqzCGHz/3vyW5EPkKLsfO2sQVW
         OkF5cl9k1Q8dzqjTl97TvtyuwlnQ6hM4gw5hPi/Z7BH+i840ZWap8qc45m2+oZl+IY7z
         vN3CW3pddT7yM4slXOdAku8eXUbi9HnmYNQee8whEx5ySd+KgTi04v39KkjqyMe9XRs4
         mc7/+aueBEStZe628/v8wvxYIX6L7SWoWOLXPrqX6y99PdhZKtmqNmZykmUKgLQ+89Pv
         oSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368621; x=1794973421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytpDuZk2ib/CPtHPIxmj3si9kiqbXk0AIF6ceCx7Zug=;
        b=ZY9TiqCbLTUaJL+Ko3E+j1QBrljgLr0Z9fUpIQ3U3nkAvnsPI0V/lucNPkzqBnX4xZ
         vTE3Y74RfOgZVM65xzIJxlqlYixqn/FdS2Z/JVTKi1LFD3xoVQ5nlQFiFeE4KZu3Dmpt
         nmo4AhH8u0I6Hdb6t16oP+RlqIuMGkuluN/TKQHi34nrDR7NMGMVVQ3OjafjhI4AuRn5
         UrQZAvYEJ65pSgHdDKTWIGDKYoTIFKN5ut3WtF0fPCFTucgIYp1bklEOCtQn3iy+/WWG
         GEst5ez8U+yOjaER5e0SidnnqOwiMCohvLfylVBVWpwlbjlvdjzyz4JHLJNMgs7i/zUN
         q9NQ==
X-Gm-Message-State: APuU4Z+8mQQCQPe9T3vEEP9tXzsJ0gkTcxRqb9Gkx5L2zCS2H7JX01Cy
	NtDbEEVNkDhbbVY1xQjZa9wuEYOMVGMwYuu8UHniaZdTjh14OIEDGgEcSBAbZlYZ
X-Gm-Gg: AYBFou3/q/YLrE7vRBsI7jG/KCLw1ZfD6D0muhNLjAeW6OPzOP59gQmLDMrNeNF1rwo
	Ift6JOIqmB4F9/w+7aAQCuQ/W1YhAMsaNXhjCbW3yuQVgRuvv79ZaSgKB/V6rBWl6W9HpqfH7ZB
	jL/hYx+1pwXHd0T1MdqusaDYR4kfz5W9SrKrSSn1osg9XWGRNpe+0HxcGsxcBblmUAbVxrXWF4l
	UIAn0G1dgbGRJM5OSOUv6QlcNKw3RJjQJaJ3+XRQowcOffLkAEueI9rbMKSa3C6BKCHV10l1w45
	HyeCKhYK/CG/QWXLm4SgjBihmN+DOYskiV0hSgWvSC7iFEe3eGwm3k6/lm6dQgZgDOR3JqKTi8U
	yaTqXpXBc+UjrXbq8XI6rfIKa7Kf4VSsKT57rAVjNpCRVNS1u9UC6XAPMbS7xCtbQRyNNoDk/jN
	Y2m1zpxNqUcc/+XwdYKd3ujEIRpXR0aeo/6w5DEatVW8tYCAo6i23KRbSoJg6xnk1mkm0z3PYcM
	7G/UkhZRt+UBThg/Y/pt/O8C8JtFiLZt3sXVDRcu9rACK4cfKYZSR2j8MXEssGUbHXMGJvzvIUK
	Se/9+yH5EaO0/fTGl99RcGqwVHIMoV4zJeqflx5vfA==
X-Received: by 2002:a05:693c:808b:b0:35d:d671:933a with SMTP id 5a478bee46e88-3768607a308mr1671315eec.15.1794368620691;
        Tue, 10 Nov 2026 19:43:40 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm13498026eec.19.2026.11.10.19.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:43:40 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/3] perf jevents: Make the model argument optional
Date: Wed, 11 Nov 2026 03:43:31 +0000
Message-ID: <20261111034333.2019831-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034333.2019831-1-takano32@gmail.com>
References: <20261111023448.1970467-1-takano32@gmail.com>
 <20261111034333.2019831-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The model argument carries a default of "all", but a positional argument
with a default and no nargs is still required: "jevents.py x86 <dir>" exits
with "the following arguments are required: model", and so does any caller
that only wants the tables for an architecture.

Make it nargs='?' so the default is reachable and an omitted model means
"all".  Builds pass it explicitly, so the generated tables do not change.

Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v3: the pass that reads metricgroups.json, and the string table built
    from it, now run before the output files are opened.  Sashiko asked
    whether a failure there still truncates them: with this ordering
    nothing that parses a table runs after the open, and a table that
    does not parse leaves a named output file as it was.

 tools/perf/pmu-events/jevents.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 61f778dcc1e5..f4dca47eb49b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1486,10 +1486,10 @@ def main() -> None:
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
-  ap.add_argument('model', help='''Select a model such as skylake to
-reduce the code size.  Normally set to "all". For architectures like
-ARM64 with an implementor/model, the model must include the implementor
-such as "arm/cortex-a34".''',
+  ap.add_argument('model', nargs='?', help='''Select a model such as skylake to
+reduce the code size.  Normally set to "all", and that is what an omitted
+model means. For architectures like ARM64 with an implementor/model, the
+model must include the implementor such as "arm/cortex-a34".''',
                   default='all')
   ap.add_argument(
       'starting_dir',
-- 
2.53.0

