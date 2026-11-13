Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567306;
	b=rJk0NDf3+1YH+qumur460ZJ966c2v2VqEKVqXl6csijBm6ewbh8Uroizap1fadYbaymT
	 5S2ijq68/+Yl9hczCwdCtP+hCr4mGM2if43T4C8SGLiHxO5/oktY7STai8ngoHvXFn6Is
	 nNrAzZB7dhmzRy73OQ+OhvZNc3az6UzYfZ5oZSDNg1jXoNDsVVXTwRn1UImHCpQ68ISEf
	 oIG/aRwD5YxM+um+r+gBlIk57cBwVlBElnKYn3Ib8CYomygzBCRbKEXoxv79ffGSr+glS
	 FMdenjts1l47mbswO4sTvpfTuPoXIbL+BL8+/fs2hvgpp9xOGGJbFCr9+q8V5GeC+EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567306;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=QUYBNBZj+lW+OPNvW2qKBQAyQ8N2obK55MwOVcAaI5E=;
	b=p3hKMDeqLAXDfuoBoHpuf5tEf4U0IkVtz88Q3+zP91JOe2xaX26o+UYKIb0dXfHm5pW4
	 UWgE7BNRK3zxUui0cjqhRJ2CWncqGOAlTQeZj+B6greOMnyCQsYkEUTsxT2lyNL/RkPAG
	 dtTd5oXX+rxAZZMTnqMEFSYzNRrjvS/wFsvbYCScKwPwYgL2Zsc2/kT7RdWgZHN+8gSmo
	 DMH32R3UwGI3Pkyiu/A9tJ0b3W9koOH+3+yFkIkcl6ema+OUnRUElJIOFP1z6KehFhVrw
	 A1BXk1L1Qf1kH5mqk0junZo41Ac8CZls/F/KFgyhPErUKANP1FD6B7QpXjSqAhHrd1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bI34F5OW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E0606A8A4;
	Fri, 13 Nov 2026 10:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D33E0606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bI34F5OW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E5F1BF3;
	Fri, 13 Nov 2026 02:55:02 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1813F673;
	Fri, 13 Nov 2026 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794567305; bh=PcQuDLM+ZyjAtHUeLq4+Pe+fYs9lcsAwvJZO4FQEXHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bI34F5OWssnZ1R6O+UisrYaLXA1gzTBsCX1pYgHc19eZYJwjrVgQMHlt+dJnG/gqt
	 H/V3xdvbBYbfhVtpHRy7KzM3pJT6imwueHIrOLcgK3123bO8l6Nq7LZC9iOGgtpofi
	 49ATo9KkZE6e9inu4PZiIo5wUnpNoWWGd83GEXHw=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Nov 2026 10:54:52 +0000
Subject: [PATCH 1/3] perf cs-etm: Initialize the Thumb instruction buffer
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
Message-Id: <20261113-perf_fix_gcc15_failure-v1-1-eae592c5ff64@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Robert Walker <robert.walker@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794567301; l=1422;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=PcQuDLM+ZyjAtHUeLq4+Pe+fYs9lcsAwvJZO4FQEXHg=;
 b=eh8Mpnhp/Gw8xKFd1DU0kzymunaq3Q280Cqkf9l5gGrIGlfcoEZFxb0b+P8pCaIhLRizoSQ6y
 uFbrLqp3lnfDRChJ3UQerndIOGW78D65sdxX3LMfKYfzM+kuS7BvKTP
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__frontend_mem_access() can return zero or a short read without
fully initializing instrBytes. cs_etm__t32_instr_size() nevertheless
inspects its second byte. With CORESIGHT=1 and -O3, GCC 15.2.0 reports:

  error: 'instrBytes' may be used uninitialized

Zero-initialize the buffer to avoid reading uninitialized stack data
when instruction memory is unavailable and fix the build failure.

Reported-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com/T/#m64fb81c665214b79883d9be815b40ac5f6669628
Fixes: a7ee4d625ede ("perf cs-etm: Support for ARM A32/T32 instruction sets in CoreSight trace")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3e01b401ca6f3a08f44bb69204317efaf2fa18d0..25f12bd110934a204d79244f45317085b7a81666 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1369,7 +1369,7 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 					 struct cs_etm_traceid_queue *tidq,
 					 struct cs_etm_packet *packet, u64 addr)
 {
-	u8 instrBytes[2];
+	u8 instrBytes[2] = { 0 };
 
 	cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
 				    ARRAY_SIZE(instrBytes), instrBytes);

-- 
2.34.1

