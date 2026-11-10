Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349379;
	b=uqSqwofgBeeoxfpG6HfJgOkGByhqY52p3jSXr8hC3AGiIKqoY8e67WgmYkRZpUtVgMWW
	 v7atBkO2caYL74fL5o8PVWhQ9Fy5syoKjxZ3/75KcrFKBU2yaHbVrOWi1aJx8WdcYz9/Z
	 Uxogr2DqFPJvTHl5N2jWoElvMD8NU7wbrTJBQlXPhTuIX5NYV82MOojz+XhtifNhWnUH7
	 aguowRVZiZcvziAaY4VcAoAASqinX3kH5/ymKczLKLfqAdoKyCHgJSG6U7dxZ6cgyEAll
	 cyqfktHQKlxosNvpgJ0auZxVdLfeswbH5dOJpQnxgUpcEYqVJ4iLjSu3MxbZLbfxAfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Li9XzaIq9EHWuYpysZ2G/ZMmz4BCmbKyG6C1UIT8yjA=;
	b=bX2rDibPJmPLlFv0dUPtJUqnunxD/UHNTNRS0a4glhGc+YGSmfgD61GORD6mJS2GerWv
	 Dlyn+ohQ8iMXrgjkGJwttcep6UZxtLyJAar/hD4I7tkqSufawROVsQLw0UfRQWue6J2R/
	 uigiDI7IJ9PQQoHGC6fpTyVIqZFpT/lnD4qoBpU/YIyaT7jIwU7+PttCXePl3hO6c7iHN
	 DTdnohCcgRwbdqkN8qkoy50x9snNfXGDWv6QNbH1lhhrzt5rflUXoW4JbPI1pxNGTdpFx
	 v4rufKX3e+d25ogrGr59NDgkb/Gr8Zy/D9qtXlIueBcnOxBf3j2iCQ5lwFDgkNeudSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ftzBUYaL;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEA606A338
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FEA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ftzBUYaL
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36e795af1d4so2160167eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349379; x=1794954179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Li9XzaIq9EHWuYpysZ2G/ZMmz4BCmbKyG6C1UIT8yjA=;
        b=ftzBUYaLImfccBOkzMl9eeHxI4djWT13/GXWj3/OT2MJ3ON5mxoyC3XHGTZ1O1m3lZ
         tn2FVU13XwZdireiXYN4xfCw3bBqiOPK45LGg5dNybM2H4xLcHU90Msw06NpHvxyVg29
         QbrnBwnums2aVIFcjPRtKsK8QNpN6S4Z+MMLWETtlHV77PTGLyb01rmFMGFBL/WfWSir
         a4bJtDX6yNSbtetyW0/OOj0ifwahE0gIYJKbCljKx0Wh2Jp8FHgnI7jTT9ZWju5EIixF
         kLTflBt3lLSsiM9NP1l4IVdrSsiFVqUjSMoIe2zhRR/8fYo0Vibi/aX+ebA8AnJtJ7IA
         /kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349379; x=1794954179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Li9XzaIq9EHWuYpysZ2G/ZMmz4BCmbKyG6C1UIT8yjA=;
        b=dRzPGOPOM0vwfu4e9YQ+UDZplvlk8xEumMCQnWbkh2fwaYVssTxyZHHbVgucwV9krS
         kM3aHGW2KHAXrnGeUWwGFrtnEbqphDcs2OTcqaiuynUS0a3epRnyw8St8X4utQKi7iK4
         2tMoylY92mV90sRn5sfVs8A2p8mOyTN5tNySijKbFQutnRWEeh5L9kwHjy+b0wEU1Udr
         JO7DfzqWNiDKj5KmDqGFrACPze4Hb1DI6O6VZzpiNZQBRIsoxM0bu1jZ+ACRPzbBSjEE
         3iMWxWFk8SGMIWhms3z5ZROtCm22pI7QOwozsizGYyC8+5epdh/ulNVCZs6jwH3o1lCO
         xzvQ==
X-Gm-Message-State: APuU4Z+RCHVj3abUUNJWwYz+pESwlz6TUdhmx7X2MUJHy7j7KMpaePJg
	RG8Vy+0YwNugw5t1C43pCNHErHbwXAgDwlotxKVwv00gksECAnxSFuUpbofuptYI
X-Gm-Gg: AYBFou0EJULfAL/YLE3WJ7EDeIuoalu3LkOsj4KutaQzRPbx2xqvatoZjYLuzGWxG0O
	FD8DfYO4jM/EmyJXi+iYkD1Bjl/bCIYpago9SQPpCtUty6O+kZRDmF559q9yymue9beiU+vLmUe
	qvNbqpN0SdReP65z0NVPEzK2DwO/JpB9EiqgFutc1KhtY5hrczgmOSVBdi3JUpr7FLlHOrA+X6B
	EoaUVSRQF2FC4Un83Y64mL1plGV/PHM3RX6jC4iUayvMtaVM+yQ2sxED9EgXv6Kf5MLRVgCahlC
	3edZgjd3ObifJL+PCST104IeJf2guWHGu+sG9wW3ug8U3yB60Pf6a6ox01IdKas9GIo5sw0w5Rr
	3T+QmxKvA/WPfKfotqk54K64J1jotxPJYpwJCXf6BUi0VZ9E8xCytGV1u1VT4BMoHPeezGeBnXg
	NMEm6fveAnMv8qmKbhP0TDExR4RKdpwGC2+rZMAwjPydgVGTw+Nr5n5SAMA4kcEQKLbG2EUF73i
	aDbswkLurGJHD6udNRi1DUvGM4XeXpEhKT/D5Z57UKO9yBVAVcG4kXzbEOHQMrxh7lu9rCd/Qzf
	QWAuBxFP7dYErw8u0HaK
X-Received: by 2002:a05:693c:4086:b0:36d:38e0:79f3 with SMTP id 5a478bee46e88-3766aea3535mr1407329eec.25.1794349378450;
        Tue, 10 Nov 2026 14:22:58 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm9165030eec.10.2026.11.10.14.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:22:58 -0800 (PST)
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
Subject: [PATCH 2/3] perf jevents: Make the model argument optional
Date: Tue, 10 Nov 2026 22:22:49 +0000
Message-ID: <20261110222250.1864777-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110222250.1864777-1-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
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

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/jevents.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 86060a228b75..844fa82887bb 100755
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

