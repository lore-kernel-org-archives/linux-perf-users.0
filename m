Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF12DC32C
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305776; cv=none; b=gJxsr1lL5OupKiYdu8Feoz0DZeva1ImlNL+Uqh4He3G+VQG+Mf2XfwinUxnHCf1gcbe6s3DidZT/sEoRKW56vYcxbuufMUjXUbMSWEQ4xOI5/gHvr48t003R9Rv13Owr2eOt9C6RzrV9llOj4pw/L9JTFe1qtfzRwKTD3EaTKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305776; c=relaxed/simple;
	bh=Zl8zJhePqsl4XxqWo/nMyVaX7NU6Mei8MsQZ1ECwbYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSA0d4YtLkZsYG8p0bliMD1Q2slD0hL5fmXRwt3BLVBEo1/ds3esiUWCkT19DY0uIfQ6gIsAJZ6yBEErGkl1uS7xtqgHq94iLtim7UJbePmNZpdPYesIiE5n4h1CHfqJv2Z1fX4aVc3qJWLMDi9HQudkyhnZP+JlTNjXt7Ejtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tty1qgR3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tty1qgR3"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f84023916so659166f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305766; x=1787910566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eAS2yWgoyXdx0wzQOuU1GOQ+foCx6winuzdwJ7kHsY=;
        b=Tty1qgR35pkmgsE8YoRqwfUBbbp3yjlXpd8IcF5RJWQ+zGOlG/dsOCBTPCCqG2ClPr
         RxQ1SzYDALOs0KadEnvJM320jcnlkK2wbHI/dEm6SsFQTmn5hjmhPOxNjrFoTiY+DnsY
         HHC/ZZdt3NnNTxXL69mseUzfOV4/ndWNAdjJ1i5Q5n9G07ASbCzx0bLADwU5viMf1XFL
         nRMefWvjDjiQlMWTzkVeJKmE5gtoUSGMzr7MJcc7xqfkR3Jwdvhx7EPOEMP4bU2vLxWu
         Fc9U4AUt4FbNoohRnQ9Zy2UFjbh1wyZ/unO2LjVQvEhh+2314ZIys2sJkxJMDITQvYU1
         x8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305766; x=1787910566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8eAS2yWgoyXdx0wzQOuU1GOQ+foCx6winuzdwJ7kHsY=;
        b=QpIIWO0Lm+K/er//mJB66GfZILgUKfOr5n8q0RyFznYGIhgisYtRgOXF+e167ii0L8
         q0rPLTg5wboYf5DqOODN55aymx0zSrmzAUI4JomXb7QOoz51CW6zuOf3mtJmP1LXAR4D
         kD7Drnj2qbwxbSHARLjwMci8ZgfBXjmzuqcNuGzOP5qr71Qvoo6g6yI30ZL5JwlShkBL
         G3HJcxIvBqpJ0gk8E3fk7SdYO4oi3pODiD99e7ARj8ffR2ncv/TBTaK+K3kfMI29Rqwq
         R5IPxBxFIzKHsTJvhagct7s+QJiIM0R1ef2ZfexMR18DXJCgRl7Hjgle87oCG0npMcmD
         MUsg==
X-Forwarded-Encrypted: i=1; AHgh+Rocz/4Rti+euFyN0N1JFlVeBVeW61pAU5Z5Iru3Ktw/0WFWTx9tlevntVnjHetbJEYFp5uEu9NVDqLFS0XFqbwQ@vger.kernel.org
X-Gm-Message-State: AFuF++l3MrLfdUgIvS2wDlWCI3cBzDexqT3JQp2NiMCvoJZKYYFnrEO1
	kwTtecVEP7UbsvehzDxLHd7XMsOznktHv+3OqOONpklsRI/Vimd5h4+FKnQjg8Sa0Ysfhm5/RnR
	EyIOi53s=
X-Gm-Gg: AR+sD10uBKh9ZqYoMyKCAQjXK2BO1jpBHmqOLgDq5H/wOQwfhTAAOqBjbY1zmG16AHV
	t6Q9zHWANcRn+eqePD4lfShsFhAfV0lrYgBbiqz+EJ+xeGNVgB6e7u7GVKeOe15qZ/s5rp5rWqn
	0/S0A6j3uHT2KMR8Q1Uv9gPGEHVlQKiTOTaPTbJaVrU053m1MvAqg9djVxmrPNHEX/+zs/gdIb0
	4iirK5ETumt7EynlBq5Z2cWUy9TJ64zZ4LuOCBf5KvcYFSFxbrYuN7lDAwzyYqdYB6r18BWG1Tt
	nnUfX+vQb5F2xUsiSQCfx7iEJkGTrwDtUQber77n3vFEJ2lP7FLzVjoV3Bmkf7ofGkSoVRPVLpK
	URc5JHDauRdGWlQdx4W5LTh3uzAQr3+ITUGiYvSL0w+tgb+PHxHCJv8K7YyZf8UaYH7Z8eDrDcK
	DDyuwKyW1W46YKnQFcmUvI5o+EIQU2rb3vnXmh+i6wLzS54bdrfa8y4rs20d8GYRUbCpqc2gsBo
	ZlG
X-Received: by 2002:a05:6000:26c6:b0:482:a36c:a5e1 with SMTP id ffacd0b85a97d-482c0b44b1fmr7088817f8f.1.1787305766006;
        Fri, 21 Aug 2026 02:49:26 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:48:59 +0100
Subject: [PATCH v2 01/14] perf cs-etm: Fix nVHE per-thread decoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-1-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

pid_fmt is unset in per-thread mode because we don't need PIDs, so we
can't use it as a hint to determine which EL the host is running at.
That results in falling though to the next part where EL1 is treated as
guest, which is wrong for nVHE.

Fix it by only returning a guest machine when run from perf kvm where a
guest image would be provided, which matches existing behavior in other
parts of Perf.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 114b3cd2da49..d423f1cb408f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1071,6 +1071,18 @@ static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
 	if (pid_fmt == CS_ETM_PIDFMT_CTXTID)
 		return &etmq->etm->session->machines.host;
 
+	/*
+	 * If guest processing hasn't been enabled, also assume everything is
+	 * the host.
+	 *
+	 * This matches Perf's guest handling in machines__find_for_cpumode()
+	 * etc where guest machines are only created and used when perf_guest is
+	 * set. This also guards against accidentally using guest machines when
+	 * pid_fmt can't be used as a hint (per-thread mode).
+	 */
+	if (!perf_guest)
+		return &etmq->etm->session->machines.host;
+
 	/*
 	 * Not perfect, but otherwise assume anything in EL1 is the default
 	 * guest, and everything else is the host. Distinguishing between guest

-- 
2.43.0

