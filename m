Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879127;
	b=ptso9hlEh+JPr8mw8t+PsV2HUGZNrpNDkbyLIOdDOcmpbf/95ajui9agLvMZJ4c210o/
	 pM1MhAxVGXtDLTEApFGjmutmlmmZCJqn4FM3BnNCmMiDEBBRDrVq0Usci8RSASTNyEg0T
	 KVFMIPm3EyRJg5LWl01YSwvbuaTzlM0OkYpekIQwyRuzRxyiZnlVI3cBRvp7rA+lFSEcV
	 GGDgPrCiVOxNcUI9sCMLSNGt+mg909KiJyxPWbcPlbN6FfgDhlzdAu6tx5Rt/3yvC3yQX
	 b7Ehuiur2D8yNT5weCZTfDSWylU+VM7eCOhVq89CK/65LXxibZldn9Qrs3wfPFKGDZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=SBB4E1cdIK6ypRojxJrVPdhDpxyA24gDAz038IMcsCE=;
	b=WWjl/yYnxhACjJqlyQ6XEMLjqzsby5ekv8SrJToPfSlrRNFLqumnjOJ8mj1t7HlUgOq1
	 m0wG9XhqnQR8aXqhClqXg/PTSXPt3oxVcsXLVBtvFjp2wT69vB/wKKl5sdRHnNmJHe1Jy
	 WOo0PqFrmP+S9TAtjzltTYXdmYe25o89EpCboA9nq+Okm+pnEVonLfBpMiea99y92h9nJ
	 0XFqc766U9vz4L1pNUVkyOLS5xC4Ukj3GB6rhVF50iliaJGrVHe/6arFtodXcH+a6cQ66
	 2N0w7GB4+kGwYvfPgVHpRcs3OZUNWgqwzpj1yAij5+y33PoHeyEG0N48ifcsi0O5WUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A8uSXyPA;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260760A2611
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8260760A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A8uSXyPA
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so13768985e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879126; x=1794483926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBB4E1cdIK6ypRojxJrVPdhDpxyA24gDAz038IMcsCE=;
        b=A8uSXyPAqFoOTkLLV+iI905Xedk7CkwIA29YdbCgbnIpu7fyhua/i0khkxpQfAVqBD
         auNk4Rko/WVIpHwhOqDla5H4kos0bfgch3DJhSBU9gnjAx1sYF6wwNbees9GDy0+K6Hc
         R7y9gVnfGQxt/ruSLGKhkAPxwDgMYmhRYEwO1iHt91v7aYe19bBfbbF55VzLWEl5mANs
         9xmgd4sv+DQ526W26cvYz4cRiaX7QxR7st3sj0WBc+tQcu81P+tWUaHga0DLsFuTe6nU
         6JxLtzCusP7X9f9GFjry652VhA4umdX30UnlJGGfXFz6CGK1LmN5Y3tli98fc3AqToLm
         eFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879126; x=1794483926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBB4E1cdIK6ypRojxJrVPdhDpxyA24gDAz038IMcsCE=;
        b=sssmlCq9lUm2dHm5NYBsExyjh3xjynSH6mzz9o3L7rd7mmvA2O5NBuChzhmjKVFF7a
         stQTCWQhC+BG4PtlR6UldMVBi4cFLY+4QuEqFeeCb3ICeXQftGN8qnTxnFYY7KjzPQta
         TMbH1PhPGhrWVAFLxneUszL8Cv+EeDREjLcBalqeMANCf9v1vCkg7wVfXuh6Fr9bTu/s
         NrIMFKia61xyBb6OtuMkEyN8jlPBu375cMrrHACbKn31X/DphlhPto9a6r/Xkhp4kNQa
         UQSicvUKY1MfVSd9jIyQTH2I7dJ5iCH2OMCuxCA0jRrZ/OI7y+lWXhf3bsfYAt8XiDvA
         zHuA==
X-Forwarded-Encrypted: i=1; AKwUvBz8VkU8jmg2vom0sj2xg72Q7FS7CAnV/k2JqvsB2pkQiR5PbCPTijaeg0Na/tbyaBmtmAcmilga91WtXo9Ex9gL@vger.kernel.org
X-Gm-Message-State: APuU4Z/IDQHGDfBIANZaBnns0fC6DbS+gcDuqdqHJO1ljK4y1NxbIt/C
	iPqsITczuzJsnvfa9FZzpDZkKSlyz1VSbefg1q0MlbCv3Adk+3KzS6RqXlkWDMvExhw=
X-Gm-Gg: AYBFou1+pfqi00uRq23aa3t3eUDXe7wXujz4Df5OxsvgRQydGr7U7qGLDHnGIFefwgP
	l5SPlBIsvgcYtzJVoGH85jDEXYq7eIFPDr6SmwEV0JwFIXMm0xkZp+ptmq1sEQ3N4DKDINrlUtA
	z9qtbrrTRbhIHnpzpYdHjMdK1s+RIIzy2JVACWN3z3GlsrTlqR4V/Jww8LBlS1WyE6NUvXalAn9
	lGUEaNdFS7E8uUbx0cB7N37EmHSt13sX4JBipYIusxHwBUoM3diQNWNvR+On4+puDjdb07A//O8
	PwRnZnaykmzJEQYCqwmQxXUpj8jHq3qchDrQYK7AP496tb30BgID39kcvaDmDOz1S+s8lU9ep57
	3wrH6YHT06MoJgk3RYyXZQ4Y67f2/fdZDkTHfHNWNP5sN9WwuLvHS6ONgjn+39WgRl26vD9GSuW
	LtFHDe+OCpILxX2ov3I2h0N/hbw2L4Qf7dJuHBUT631JJTfdrLhblV3fMBscMvrYJqEG1qSk16c
	8YbbSNfVJ5FNQc62EzOFjLtGUWfmQF15rEFqN4GC3CXHBcRUdqhwdcmOi3pzqUc++BAWek13DUJ
	SbGvDU8bbkjj0fqhLTuv2AiWcUPo3znF
X-Received: by 2002:a05:600c:4708:b0:4a2:167a:c93b with SMTP id 5b1f17b1804b1-4ac19234ad8mr417649255e9.30.1793879125831;
        Thu, 05 Nov 2026 03:45:25 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:25 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:53 +0000
Subject: [PATCH v4 05/19] perf test: cs-etm: Increase window size in
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-5-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
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

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
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

