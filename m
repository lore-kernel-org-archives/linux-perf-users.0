Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495D4BEE2F
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005670; cv=none; b=Td0mV+FbVxu9qLFqwTue7HLh/mrtlImMzfljuFYGHqAcuUO0XeVJe0HkSnXnw+Ix3sRMGdm1s7X490S1GRive05i1vuC+K9jkISnd8vg8afAWQBUy+a4uE0eMxrcReTBxAOKe1dJUdKilWJRPUzhRW546mQ9jiuI2JzcJvR57Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005670; c=relaxed/simple;
	bh=nHVksdY8w4wF3N08fRE1ytwkMeXTDgOSdB45U/VyuoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHhS/K/J2j6DawEzg3nDEDdvx+Q1DQnKPVmdQNv3Dyvm582GpVP6Off7UsRnNrpMuVMmC1M7EGu9gdT4kOHkrvBQptHZPfJTyqFqvDZnCrto2ATF2f0rsTR+bPgxKKcOrBXILnKzOAz0yz0U6SASM1YiUO1AHN/L8J/NxNUcLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HgyGkpR0; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgyGkpR0"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1920579f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790005665; x=1790610465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pOnOOGEA+4+JPvESbiYqMHc15VbAUTSR17XouVJ46Ss=;
        b=HgyGkpR0V8r3OeGpaQSOmgrsHFOaIYS6UCItXj8uaAtfKStrj/0BslYIphst7UooTS
         5mcHLtpUYuuy0XdzyKLZQ5/rGyAbcPk4aX9IhyXZYge6GZlRa9mZ1M54WyjLLftYUGWD
         t9qKtpAqMlfKXFs3Qqg9DqyDS3r1UPA0WwvQ1QupNvNyFzDNoY7sgpbCgcnUEB0WkTrp
         /e4xP5c0/A9tJ9wkDai0OCQaIHrXwoHX78YRE4TN0iikLxfwvnAisbuC7XBCZMRof6wh
         NxXPJaGy+ST6cJFl9qTy/dMiLY5XkIiZ2uqb+S531E6+Sg80otehLilUj4ar9Wi//Yf5
         yh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005665; x=1790610465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOnOOGEA+4+JPvESbiYqMHc15VbAUTSR17XouVJ46Ss=;
        b=ffAeAaht86eJ74O955S3cP3rdVR3wvnV40nDdyDI1At9IeQFUBEo/gtHZXufNmVqFh
         9c/9Ew3fJjWoSuhMmTKhLKS0ofDp3I2QUI9Sgw7Oig6fejoekv6dWWam3AjS6ope9Pee
         4z32q3ofFxaPTAymAj74c0z3GFInuh3/noXQtRuqKtpjCIOgdfN8eT0DWLcM/Mm8JrK5
         1eDF9NEJiZQMJIhatgPLL5C742D30Z/WQAdHSjD4GaiJwN6tfY/bIdBShtYYHsNoqmy3
         UDQaFazlU/wQ4eZNOe77gSHJaWkJ7UfV2BO2hIpGEOSN8RtbUTS+4KiVd33sPvUm/JIB
         /tBQ==
X-Gm-Message-State: AFuF++njtY30UbGiQVR6gd/LHyN9RJp9485u4Ya3KP8jOt2TsRaAfm9O
	WeLX9lyw5VMC11ef0E6JUBWnCB8ej0oDKyyNqZ1OO/T3zS3p7HdLyGdNu5B6ELiI0a4=
X-Gm-Gg: AYBFou1x8QhD+YyDR7B6mZX6vMHklMgGlMWggMmUcbJQQO772NcAUHu55gk01EP+fsQ
	Wlto5syOAYblFHFor+AofxLGQillTECWj451eYmQ96UFF3p++iSk64ouaq0/sHvl+peO57mjjzw
	vjTq4x9KXQ5ZFEmVdhISb/P3oemzz0fBVNchMN6QJ29dekS7dK7FoDm5g4aFIWd2IjH5/vdVDC3
	HLKz320OSIriOHfHW60D9T2sSEiP2B4yAiwe17l9hd2FhGs2DRBkqW+iPcoD4C8C0EIVY4Pv7Pf
	dgLrkXRtawcLhTbs8j7y/1Iet+0hohqIVUai+qGMvi+41NbWsee6nvODQyJRmykjmPktqnK3Y7D
	w+iTxhWNKtbINe1LSPzQvjDR3HuWGn5JTKYOpFOygBViW5POF88ogNKCSeQsUlD81cEKfEB+J9P
	y2Wvu6FYBcFNqb089Pd6O2R8UU/J+PXAwPdjvu7Gl7uYd7ycM4nRKElgLX0g0Ech6fxWqkEO9rL
	aY=
X-Received: by 2002:a05:600c:620e:b0:49f:ce78:3560 with SMTP id 5b1f17b1804b1-49fce7835e0mr135252035e9.17.1790005664767;
        Mon, 21 Sep 2026 08:47:44 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd103325sm279287355e9.9.2026.09.21.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:47:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Sep 2026 16:47:29 +0100
Subject: [PATCH 2/2] perf build: Follow sourced files when running
 shellcheck
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-james-perf-shellcheck-source-v1-2-adcfc107c997@linaro.org>
References: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
In-Reply-To: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Shellcheck follows sourced scripts when -a is provided, but only when
that file is also provided on the command line along with the one being
checked. We only ever provide one file at a time to shellcheck, so -a
does nothing.

Improve coverage by following sources using the script's directory as
the base path.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 29cfd44c427f..76a17d3614a6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -258,7 +258,7 @@ ifneq ($(SHELLCHECK),)
         sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 072), 1)
     SHELLCHECK :=
   else
-    SHELLCHECK := $(SHELLCHECK) -s bash -a -S warning
+    SHELLCHECK := $(SHELLCHECK) -s bash -a -S warning -x -P SCRIPTDIR
   endif
 endif
 

-- 
2.43.0

