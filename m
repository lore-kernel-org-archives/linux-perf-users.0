Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370254;
	b=dsryAa6Aa7zRWlhg+u9aldIJQO+Tpbj5KYLI1AXNHkB5GAkiy07fGKFAKxCZmkEwtzlz
	 ZgLKTGO6SfincZXXC5p9V6pkuX31JF7goust3q8sHPpOpbF6m3cE1TT32DusPXmM4kkBH
	 Vq+Bf4ZFTgEJICgtcYQ4CkEUKWuK2kqpUds7ot7TugBhZk14LafdQ2GGnv/9LgpVDCl6U
	 O707dcMjEGGnRTDxomQb/x6F4ICHrE7Ubc+TI0qZTZ6fbQCySlZEg5eIG7WKA2GnEvHao
	 3DfUQpMAQMqb30YzQfGkIXDVX4ISDHQS1rVBfeT9hf6oe0pAk4dM/6Op4ZRqM1bJWNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zoL2/7JQxDTvuJVaxISLhB6m4cChWTGyX92zpA8Fl4I=;
	b=LePpntL9G4bynW9Qs2nLgARVwxVGinoWLpAijMfoSfNff648xDiuaM+FM1JM34SeWRgf
	 N642x9QxzsElj4xzu3xISheRs+Uf0q9PUHg2jGoiipP7BWd0WvuckRL8QDA9qZNhU5Ip1
	 FWeoPuUtUaLx/yO8zFNpyLxPvRk3AcC+gwMK0J0mbnsPTwNx+m8DRB/SaAEuT6C//9jwN
	 ODyPIbatilrQX2HEKTy8FO3HEIEg0qHO0ofnEMVOn7ew+JqVV6XP3MlwrbeK76TqWmIIb
	 oUO2BCbW2y8/xzftbq+Yarm4/++p8rVwo9DLoWHhph0lW9UOPBGaVFiGdnwqyjhrX7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Bi/ey2zW";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1360A260C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 04:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E1360A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bi/ey2zW
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1438d9363fbso1634182c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 20:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370253; x=1794975053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zoL2/7JQxDTvuJVaxISLhB6m4cChWTGyX92zpA8Fl4I=;
        b=Bi/ey2zW7C/L5ukzt09f8eL2gNGClkVSCKGwwQpcTOP8mxsBI5MKJBzTl2/RT1qCp/
         SghG/hBIE5vp4TqSgVbPe8RIBDa2RDBplLFageBqB4rINR9I+HiqX3p5Orf0N0SzAISR
         UYK/s0QCi4YWsCxbaKm9D0e81vFYIQFpSlnAGiQWLMbYQn0Ofow3l/dygShiWBH5bXJH
         CYj1zKGQAmlMQKreXZrb0hu/ddK0gLcplUvOw3Dprq7+eQkKc6VZnPBJWYQMFtaDp01n
         odYXdgkjEoGkWOnZpJX1JGcCbYIICuVrz8MA57wsW2Op7grfdXaxAgMFcfxR1OcOe3E7
         4cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370253; x=1794975053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zoL2/7JQxDTvuJVaxISLhB6m4cChWTGyX92zpA8Fl4I=;
        b=utsYVxBfPaI+DSEv0gi9EjNyB5FBdAk2eo7cpsFyGV74c8++F+i71gmrfDJEUBjWh7
         9Ux70p4fHG9tT4pzfkNmG/n2b84LQx52bvWg6xCyO0I+iJkgXIYP10UCTg0osi8RkbOE
         LttGiacUdEU6oNSJvCJDCk35/y0WT0BuQcnRzHCm4YpQ6phOwUAfOgYJ3S98l91DUPAg
         /JnqgAcRltn3ewBMvQzVmJbJxv9M8lp06EFIgUdfgoqbp9MydmJsF7tAcJP3pMF4ZNge
         2G1RvIZ4aZNOncZWteXRhKKaX38x3jkd+jP7oMC+1YOSO2jrMA7o3//al7uIy6ImgcrO
         162w==
X-Gm-Message-State: APuU4Z9G2pgyrRrO3e473xnzaiqzIwBWQDE1ywx3vyOlzo0NcnVYdCY0
	MDMXhFVM5mGlFFyIkyZekvpcIHIIACUWdHU0JrHXaBbx+9nG5x3akvWcZ2GKoOyn
X-Gm-Gg: AYBFou0BtHCIxNdnFt9ehw94vlynQGtEkwIvCSoggZlJXg0LbRingdZm4hNA+GuTPKe
	uZKplmtVyL6WI99Rsd5vTuR8PFVsjseSPe2A/eEm3AV649GnQahv1/YHK5UEXMMpHk1oqQZcWZS
	4YgtztKsPBSwf2VpraE9kwpnbyomRmuME2gEDZEO4ifJvnkRBYz4UJV2twrSPKHjR6wI79EShic
	hyBd6nluLuVz1vMHc21W+17PuYviQWc9BXHMlCtA9bk+6JElSq5tqsVkQnJJRtK8Vvrrpf6h8cM
	5mdpDIzuzgSumtygLKm5J7ft03FoNDjjdYgfhj9DtZXNJwv5aw0ynifVhBhvVIk0u29/jIUX5Ny
	lJqrtBDbOPWNB7TqbUyYKgedrF4xMzKaR+yR5scVYSQhkDKulv/Xw3dPWy70TPwPT/qe5CrHGE/
	5ECmE0grFaPIm1bvuCLh3fDOnCuC1ST2Fyy9n/6/FNHla5Ty2srgfIbP7pvWhwy6WzXY0NUxoKf
	/A593QqiW66Naskx0nBNpFcxk/PI2HPwo/6wVwgpGmPnDOVXMsweAUdBRlvah4/pId4Z5H7PGzs
	Ic0HyT5pjxHYnx+x5duI
X-Received: by 2002:a05:7022:f519:b0:185:6c8c:d860 with SMTP id a92af1059eb24-1b3c03387damr1031195c88.5.1794370252750;
        Tue, 10 Nov 2026 20:10:52 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm11451201c88.2.2026.11.10.20.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:10:52 -0800 (PST)
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
Subject: [PATCH v4 2/3] perf jevents: Make the model argument optional
Date: Wed, 11 Nov 2026 04:10:43 +0000
Message-ID: <20261111041045.2031464-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041045.2031464-1-takano32@gmail.com>
References: <20261111034333.2019831-1-takano32@gmail.com>
 <20261111041045.2031464-1-takano32@gmail.com>
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
v4: the check's try/except moves into a function, so the name it binds
    is not a module global that makes every local `e` trip pylint's
    redefined-outer-name in the pylint-pmu-events target.  An empty
    table list is an error only for a build that named an architecture:
    --check still reports the failures it collected, and arch=none
    writes the empty tables it wrote before.  Both raised by Sashiko.
v3: metricgroups.json and the string table are read before the output
    files are opened, so a table that does not parse leaves them alone.

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

