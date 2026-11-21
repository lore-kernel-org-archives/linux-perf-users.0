Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245435;
	b=c1JeKIaqTt0cisRZHkew9kOjLl8Dm2ImnLPxcjZDOP8hN6LskS2WBZbL7TQsWujBWAjv
	 lgHW5Ai0Ab87NSp1m1gy+lEqG/hfi+i9UrOLsQkbUQnZdroyn0UOnUCPkOmzN+IoG736Z
	 dtu3lRMy2Oji4/vt7FBPf7sObKlKX9MTnc40kndZOT+NmNbapUuyNQ95W4JhLEcH7uoja
	 qAbns9JSxEJDk7DonCCtBJIQbIh2hVYegzF7kbyRno2JuoJ1i/8I3Cil4ESqN900kUA9R
	 vtFsmhQK/YrX8998E27oHM2L9/j0oWJL5nERtoy2pgnLiBAd4j8AscSzKTnymKCDF5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pH2BPzLxsd8NvvUmkGMcSjMobCCeF4ip9zrDbmpxIGM=;
	b=VbzjLScRSmgnpvEGbETqD/UGr8pQPC4kuRfiurXxJXyVDPxCb3GsOiq4j/aRue0KmaFd
	 Sj6m93t5f1kVW1ExEEiU77ZOY6bAOjOPsyfmpUNtAVUzPMB5t0I0opH9d6JZVR2r+NvJq
	 J9qHULay6XLTEjGUoX7iK9DVoUo4JAx9PIh/oxJ0Vz5gnOGroxhUV0Fp3LRQuTFRALFI4
	 j7OzhDp5feFFi5EUbtmWYZ0mHDS9lJKRfCFZZgMDvsE65DMIY9M2LSTYGd2mK+O0kUAtw
	 Zl+kTpPIVY29Um4ImrTznFYAeghX/1x2PSQy5/n1nOMs3mgmticrWli2+ToqXSQJHSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AyoryBAc;
	arc=none smtp.remote-ip=209.85.161.70
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDC606A330
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CDC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AyoryBAc
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6f8edf0c859so2704449eaf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245434; x=1795850234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH2BPzLxsd8NvvUmkGMcSjMobCCeF4ip9zrDbmpxIGM=;
        b=AyoryBAcRunfyWWAGqFDErv0RmvC4RgRkn3jugqZMjtIJ9iCPdzd50JCSf221odRMI
         BQjbPO6mToI62dJjz1rb6REi5XkXBmQsBG0sd/cPto+9Cfyft9J7tlZnQec8psjk9x35
         z3hQCWMa6Jnq5GiMDqNz8S21PmU0B2i7GZagWIpMsb/gopFnd4CBWujiw265AYtDoUG1
         KvhPD8BRn8BdTHzO7ADyrD67xmNSfnTBmOjlXMJrUi/tgrVkdfAhAGBgtWulk5KST00l
         2XILaQ/LDp0NlaLygFNsnRvGb7FezxZS3XIr/B8lvf6zloxKctYZOxdBp1Fjw0PP3/z/
         VNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245434; x=1795850234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pH2BPzLxsd8NvvUmkGMcSjMobCCeF4ip9zrDbmpxIGM=;
        b=Oul/MNdC2novBDMShTmyOte6XLUO/owmvWWa0F4Hz/sivdJ8axHZ4+BfgVZ6oxW8kN
         fanyYkaqJhJgOqXGePnEClq1gUlK3lvS5L/0bv+eg58yQtRMszscHlmSK08HCzNWo16N
         nzbAjGiMTkukDG2a9I+bdSl0AgQQaOygQYPzm77GH8WFGb73wfnZyzdywXnpOmWo+0WH
         9iOslViFP62tTC0DzPasBh+6ERNLzZo8d/dcozMikcy0fPze++EM+tWf+7XZvJaNYa6P
         e/Ko3id9dQtmIYZUmFoWzpJQjmCXdschZxeP0QyctAnraRzvcFt8W0bjvGO0QtGgBaiw
         a7LQ==
X-Forwarded-Encrypted: i=1; AL+hErFWp4wCteKl2mSOnxSOrX7t6YR8ATU+9ocRjiP6LC/NVR+7EwMQLEuAfyprZZbasRsE5GpqVlN6J1OxvHL/p71a@vger.kernel.org
X-Gm-Message-State: APuU4Z9a6i1NKB/Pl4qGxaXKR2D7sajtzIrUiyS48td5vbV/kt8Df4qE
	IyWZ+EvYU8/TBrS+IeG+yVZUzg8puqg6N5HoxdsmBU/th0FPFv4Ti4x4KfEzfwyRZvv5iKRNhpG
	5ZPhVClCTXw==
X-Received: from oachw30.prod.google.com ([2002:a05:6871:cc9e:b0:49e:13a7:3e26])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:60a:b0:71a:f24a:a3ab
 with SMTP id 006d021491bc7-71b32773f58mr4894729eaf.44.1795245433543; Fri, 20
 Nov 2026 23:17:13 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:42 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-2-irogers@google.com>
Subject: [PATCH v7 01/10] perf kmem: Fix alloc_func_regex leak on error in build_alloc_func_list()
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In build_alloc_func_list(), after regcomp(&alloc_func_regex, ...)
succeeds, the early error returns on map__load() failure and realloc()
failure return without calling regfree(&alloc_func_regex), leaking the
compiled regular expression buffer.

Call regfree(&alloc_func_regex) on both error paths before returning.

Fixes: c9758cc45699 ("perf kmem: Implement stat --page --caller")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 8693c6b135ca..1404b523a785 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -364,6 +364,7 @@ static int build_alloc_func_list(void)
 	kernel_map = machine__kernel_map(machine);
 	if (map__load(kernel_map) < 0) {
 		pr_err("cannot load kernel map\n");
+		regfree(&alloc_func_regex);
 		return -ENOENT;
 	}
 
@@ -373,8 +374,10 @@ static int build_alloc_func_list(void)
 
 		func = realloc(alloc_func_list,
 			       (nr_alloc_funcs + 1) * sizeof(*func));
-		if (func == NULL)
+		if (func == NULL) {
+			regfree(&alloc_func_regex);
 			return -ENOMEM;
+		}
 
 		pr_debug("alloc func: %s\n", sym->name);
 		func[nr_alloc_funcs].start = sym->start;
-- 
2.56.1.750.gf70dc682cf-goog

