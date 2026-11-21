Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244346;
	b=WGysOnSF2IEbWUnzs65OwWftdOTe5HAkdQnsj4VIF/93OX651G2xu3wjIaKPQ/NvZAyZ
	 cFAruN4FRmWIjqrktMyXkUUsenpMqHoRJgxITiSZ1Z0On7Pm9fcJB43cLpZf9Fo7x5Uv1
	 FiTLBqIP8YD9bIPsSWOo2iJELU0vj4AjOl4f7NmAmoYM6p0YGraPIpL2qABw53DPp5bOt
	 pD+jcIUBSwrbmYnMbh24vrMm2ZyphOcp646l++/c+/kFndd0D3hbjvArKG0OTgPqnOkVB
	 jPWaYF6mJqLbKS4a8W5VpLM9Q/JDzhOTZuFrUf0Q2iyu64q6B5kljXSmIj1tBd9XFEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YaOrepU6AaV9bsaJ1eqR9wb353r378iiA6um3H27iXs=;
	b=S/uYJmL+EfqdpbkQuJyOleO8sT87VdgA++vhBL2x4lT5a4aVl3IN+DQghHmfYGqQUjtt
	 ph0yorJlCQ2NBn0CBqMEFLtc7TpwKBDUJ9jIb6I1g+ynWIScWCbNGIinEWy0Va13kJ1yw
	 /jewUaqIRAu7QhpVVzWq//HZx/uHbzuiWcvxNXMG+LaaQCf2XKpIMzMfiQyihNon46y0/
	 QDvkoua0yLztImGYvNVTipXa2BLEdS6bRKvmp9PzlTuBKju1H9kX41m/m8+FVusJi+mz3
	 30M7TShHWbbMDpEC8o4w1hmyxYRJ3ufY9UCgQSX1gHkToEe7/qlhCY+AaRrh70Iaq3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NWlG9GPF;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D1606A32C
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60D1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NWlG9GPF
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-38355b03cb8so1604643eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244345; x=1795849145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YaOrepU6AaV9bsaJ1eqR9wb353r378iiA6um3H27iXs=;
        b=NWlG9GPFXRrhC8HnN8Fpxhynk2bHNo+O3biLoOEDn5YG2Xz+N2CNW7biIP8VqFnp1/
         M2i6oBpBXZXV7BlrLOKwPOclFTtaocGAy3Qg5K/4OQnNuZiHSZ0oO3YZqRz7+GBVVbSr
         39A+KXkX71ecY0RH15tch1YysYPHUoD4lURF+bAsZVF6VeG3dipI0rpuDOqWwMtlcFTu
         mS24FJeYYgkjYaZQDqYrL2YzBIdS3eXwXR3cm1JYnLL8o6gJ9W9R0l1q8PYuPt9mjmQC
         ejRWH7vh0y2UJEcwSAT0eaGNKtU5oDu9cLvpg+Pe6eWXN3PZ18tmohriQWZuEVsuHQjA
         sU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244345; x=1795849145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YaOrepU6AaV9bsaJ1eqR9wb353r378iiA6um3H27iXs=;
        b=XdUW4foLS3U24hx0i+7UFEE9veRiq+skcja/5A2kYpxPY1AUPgLaUWFQu7V+QZUooM
         w8cpSoPyOz9A71O6HAon6HwRdlUylYhEEYC94EKmvaoozV9tdfmCNRyQ9k3zzyxsCNKK
         ZfHpX3uAJtm7KhxZtotlTFxJeGpB9OHUP+t9bnhePYD7hzVBuHfNCcXerBcY/qCo9Boc
         ZUtF3ImLpkIuBNMLks4uFmdIWZ3mj/6rMGcVb93J6mPTkfs46a2g9rTe1hrOeqC9GyCv
         Wi2Hzh+7htX7+oTz8+0vBNIJCpZaYkO+S7MG1Xo7Z8/hOv1714AkLfE+UV+pmiCeZq1h
         Iosw==
X-Forwarded-Encrypted: i=1; AL+hErE51hsI5mS1+s3xubntdXClbBMwm1bQk42IDa8cV9avWmYUDBK9sz7cFc09vbCLHMwGo+UfJS+LImPH/Mx6+vD+@vger.kernel.org
X-Gm-Message-State: APuU4Z9XNwB8tH2nf9gjpXxBjZ69DxtYWIQi+kQy/ml+z56MwJx+N36w
	iZn89aV3U/6HPqSlbEA317NZ6BYJ2h20IdHC6wiK0Xnx0Xpi8/jLqJ8dd3CrEa443fZZSWSBp5E
	d7KOV1sSHWA==
X-Received: from dled20-n1.prod.google.com ([2002:a05:701b:42d4:10b0:1b3:befc:72bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2508:b0:1b2:3497:5998
 with SMTP id a92af1059eb24-1b5568f03abmr4870446c88.36.1795244344566; Fri, 20
 Nov 2026 22:59:04 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:57 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-9-irogers@google.com>
Subject: [PATCH v15 08/23] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Factor out dso__is_bpf_prog() from __map__is_bpf_prog() and update
dsos__find_kernel_dso_cb() to skip dso__is_bpf_prog(dso),
DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
In machine__process_ksymbol_register(), also check
event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF before setting
DSO_BINARY_TYPE__BPF_IMAGE for is_bpf_image() symbols prior to inserting
the DSO.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h     | 16 ++++++++++++++++
 tools/perf/util/dsos.c    |  3 +++
 tools/perf/util/machine.c |  9 ++++-----
 tools/perf/util/map.c     | 14 ++------------
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f6c60bafcde1..009bd3001ace 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -1022,6 +1022,22 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 	return is_guest_kallsyms_pid_name(name);
 }
 
+static inline bool dso__is_bpf_prog(const struct dso *dso)
+{
+	const char *name;
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = dso__short_name(dso);
+	return name && !strncmp(name, "bpf_prog_", sizeof("bpf_prog_") - 1);
+}
+
 static inline enum dso_binary_type dso__dbginfo_type(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->dbginfo_type;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1574c8885d78..a7f6a98acbaf 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__is_bpf_prog(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5b4550e97172..4a3461d79593 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -791,6 +791,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
 			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
+		} else if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF &&
+			   is_bpf_image(event->ksymbol.name)) {
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
+			dso__set_long_name(dso, "", false);
 		}
 
 		map__set_start(map, event->ksymbol.addr);
@@ -802,11 +806,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		dso__set_loaded(dso);
-
-		if (is_bpf_image(event->ksymbol.name)) {
-			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
-			dso__set_long_name(dso, "", false);
-		}
 	} else {
 		dso = dso__get(map__dso(map));
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d5319ffa88a7..5155c95df85d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -248,19 +248,9 @@ bool __map__is_extra_kernel_map(const struct map *map)
 
 bool __map__is_bpf_prog(const struct map *map)
 {
-	const char *name;
-	struct dso *dso = map__dso(map);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return true;
+	const struct dso *dso = map__dso(map);
 
-	/*
-	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
-	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
-	 * guess the type based on name.
-	 */
-	name = dso__short_name(dso);
-	return name && (strstr(name, "bpf_prog_") == name);
+	return dso && dso__is_bpf_prog(dso);
 }
 
 bool __map__is_bpf_image(const struct map *map)
-- 
2.56.1.750.gf70dc682cf-goog

