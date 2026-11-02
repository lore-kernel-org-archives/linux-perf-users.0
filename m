Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621750;
	b=u0Rby9E1UXecFiMZGDEqeO10Adnh2gQicXbvcWmbJqZeG1e2Q2Tv3En2BdPiPrXV7uH6
	 aa7d4H/SrUutfqQLdBOISiqMuYfKcYal226TmEWj762PXtDG78S97NcsynRmrmWaixrCy
	 Xs4Hz2ClNYfXXaqxGMOEQdtRuqI+W9vwegKa0CsxTWudgLQ4JixdYFQK4YA2wwimBaR04
	 0o/CJjzYVRX5s4dY1At5JiYVsa9JwvLkibzCEKNYPI0q4tx9iJ1YuyGpexUJetUKg/vbA
	 /bZK9I2yButjfgPizyKTTGfIKiCFAdwP8lc5olqbzA2sFrT8dRrFH+5zmFdolN0QfVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1kx5q/BQBwUxVzCJruBUh0184bcctd1FMQSl+tIj0LU=;
	b=lOQ59Awmcnd8RC+Fn8NopeY4RuM/UK8IDHs2UwikUzDWycYpUFXz5aEyWb2RecAY/gyb
	 JUm1h5YE9xq//7X6jf1s1bOtBBTB17fbj1fWWyV4+9QVGTNjCVZcz/AasSPL6VZUQexeS
	 eUviCPrDinkGwCybPywS7mm2ZxkGSkP2GYC1DIkp5wIpYavCFRfQ19gcUmitlo6WvnSki
	 ob0ChJcS4dlb9nI5ajdS3YBZmQZ4SF0w8B9caMU/YOPLFuXcLAh5Y9+Rb5zOe84f4Sk/h
	 2pc5/FA1bOQaCRvqt6cWIXZRd8N99Hzxu2NmXOM0HuBs4Pi3+SGmTY2XgBOlJQmgtzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jAyjX8Rj;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373A60A2630
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7373A60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jAyjX8Rj
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1436972f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621749; x=1794226549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kx5q/BQBwUxVzCJruBUh0184bcctd1FMQSl+tIj0LU=;
        b=jAyjX8RjikbSFOz5r/4iZSr/XrWjeb8swvY9HDzvFD1DH8Kntoq8ZhuLVTIVkUl2MB
         FWoArT1ZtuATqoAEhlSo7JGby6VeNVxrowZrXhz5PMqHnriraQRM7poLHdwu4wKNeHzz
         cUbEdWg+qVQsum2j+4tW8aTNKNxosI1P0+Y/Jlz0Fb+gVTIEZ93CscZ5tHnujXeux3yq
         i8RZJrj0piV5/3CWkQHFo+lxJ65Rh8TtRlCnA8ftaZDtrHYNtoytBuoGuF8Akc5Y9pQx
         J40nLhmsQ1QpO+GYecxtag2hBmA7JWsH588DsFKM3WJX7PfxI/jumvJWdfGJ3tqjvXje
         DhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621749; x=1794226549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1kx5q/BQBwUxVzCJruBUh0184bcctd1FMQSl+tIj0LU=;
        b=i9cLGsoFzII2kVbCALAg1V6fgtD4d84Lcu2Cz2ur9Gebb8aaOz2BO1kMzVxfnvwzkG
         Jt+bWbfAZponLhyjYoYwCz4iS4fAFPRjXYIoGSJUYs2RXdDSZYtypsCuSv/UxJPdi6l4
         ZlSTx7ICFHBDEfhaFogNDw4EYTUnxGt+ougNE6MvPFHzS+s8zOiIHwyY4f9svQVrJ406
         vanTY/wSZR56FnTIeADqpGCegYvHL2QZV1Nu0nNmJzuXzLcWKhq0obas6BRnr+iEbjFp
         hi3275bJCBL/8elVdCV6SG7v523ab1WHm2LMey0DvlsisGynFGB7bKwCAIXYJPIjkg1V
         ZeZw==
X-Forwarded-Encrypted: i=1; AKwUvBysONNpib3szn+sD7iMO3RljjnV7sS73hZWuYu8Ab1B13soNyQXYKqs1eTvSucIXHGe2tDqzl2HGi5j3RTW4nhN@vger.kernel.org
X-Gm-Message-State: AFq9FYKUEC2JLv+Jc4EwGsUC3sTrZs7gr0cRw2SZib5wfzf2gTJfXfwj
	vnJIXxwRhbXU7AFBUPxR7HW6vOrwVbS7gQNwSnZ0+/DVqFgaMIOAbgr0+kBSaLg9w+M=
X-Gm-Gg: AYBFou0APoz/YiEOVgislIhIel0+SDEIgE77xmRGAqxaDwf7E/5sJ5zYiQtfQk2SJ2K
	QG3b2jIV8RVnDFbKc6zMCUo5umDtjjGlvVvVyFFUa+KfJ+7nxfuP1/CPCETgdYW9L75JXsiWcBR
	r5wzQN6rIWarKHT6Zw3C41SbIOyUSKGPnnQVZWgBl9j7lrm/rnAprCD6j7OJJ5iTf2/jaI0ogeS
	uWr6b+cqabnr35yQh/BZo+bRa2Ix8VJC/ncmr68ovu+ARzofzX1QwDYAjn19EUxGIaSFVKnY0uN
	u9QUmdsTqDWGTLB6t5gbDT2b4mdaP+Jk20GAjzJUO8ZNCSiry+4BOxWqcis58KnwlZQmMMNb123
	IolOOz9ad/VyfALNHt8OG+DwJSZAdpYqGCBc7rarJMck38wJO7b1qS0MAO+XB5GjRyuFwR4WSvq
	mw035csGawvKtFL39Mlqk3euDeSJHF9WIrhWJec4K9Dls7GB9yveXfeqfui/d5IAoDFnL/WZdh7
	H/B13ElVGTrxkG7IwO0Qgs/nT9uaqEEFgL9VMZjCI6JSJbEMudeS46O4I01fwlvcNWPnFdbzvXU
	4tEOvhK/Kx65zRmft0SKmw70LsUdcvZk
X-Received: by 2002:a05:600c:4e41:b0:4a6:42cc:bf6c with SMTP id 5b1f17b1804b1-4ac16acfbd0mr207623275e9.7.1793621748831;
        Mon, 02 Nov 2026 04:15:48 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:19 +0000
Subject: [PATCH v3 05/18] perf test: cs-etm: Increase window size in
 disassembly test
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-5-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

When we increase the default timestamp interval in a later commit, less
trace will be recorded. At the moment the amount of trace overflows the
64K buffer, so the exit snapshot trace is what happened at the end of
the process rather than the beginning. With the new default interval,
the entire execution will be contained in one buffer and the first few
samples are always various instruction and data faults. These go to the
kernel so don't result in ranges that can be disassembled.

Increase the window to 6 samples to ensure something with a branch can
be disassembled even with the fault samples.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
index d298b18154b2..236c4160e480 100755
--- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -50,7 +50,7 @@ if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
 	perf script -i ${perfdata} arm-cs-trace-disasm -- \
-		-d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
+		-d --stop-sample=6 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
@@ -62,7 +62,7 @@ fi
 echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
 perf script -i ${perfdata} arm-cs-trace-disasm -- \
-	-d --stop-sample=2 2> /dev/null > ${file}
+	-d --stop-sample=6 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
 

-- 
2.43.0

