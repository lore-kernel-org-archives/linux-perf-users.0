Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750381;
	b=3TZ/J0sXL9kYkQVKj9Wy2GjWA42Cpo4eOSTTJo5Z+Fd9z7A8C7Y2c+OYs95+KwTvyyJg
	 cR8vpbmLU6Xi51JnBskUjE1adNSaGoQJEtTLik9gPt6QOGviaufFqxrZHSrlW5XGUzbuW
	 VZAl6d+zKBVho1aclESoowQhgE3HSSACF7JTZKHyASVUeauoJtrIVTCraJwFGGnz8ZBAi
	 mS07By1DAg1CIPqD/Sc52Le4r/cg/KOmMh1s2wIENrAlZWHLqjPL/070gHRy/BksJ7JRB
	 FTku7jqnQ8a4y2h+AAzAn6APiIVcZveK69C552uMqvAe7h0r7IpP3YttbXtXf+/MZJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/gVKIE3a0X4lk1FYa+PkYFloniP/UNgT1s7zMDVr3EI=;
	b=OjMVDCeYOW4IAHKegBUD09uH6xHfsVgG7azlnQxBQuuc++CpO4ei2dJyPJxLvctr6syH
	 YfiH4S0a+z5LKl2bNXNzNxjJX0cpAgBJW3mvs44+v94Wi7I46rGcpkoPVt1NcV2uKqqSd
	 yW8oZxryskh69pXfVC3evBNVruJoFRGhrpLZ2m0lTCrKSbO9VEK4B8XfBWlOZGjyk+nUr
	 eQUZNRUCDt01SLbF+51ZSPK0RLNDHBFN7yTe94+oYkZzVpej8iLsKXoLGrsuklsFvgQvK
	 RmK9SgRzKRuJtVnZ4eC7V+Yaq8JTkEtrkYEgWor4Zyp4DVm0HC9ZCqHq+6FnOrJWf1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IWEyo7WG;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B87606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 10:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92B87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IWEyo7WG
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35b2c599f43so1711032eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750380; x=1793355180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/gVKIE3a0X4lk1FYa+PkYFloniP/UNgT1s7zMDVr3EI=;
        b=IWEyo7WGLB7YLSPFf39REJDzcWI3r0tD9PmcQ2/6f1jW95llGTxXxTmfdhfC51obrW
         OdH9cQbY22DC+JO7gXv4qZ70+vieU+2G7uxQluQS/JLlw8lmI49K6Az3EP3ZRpGeXAl3
         cqgCutQzJ1aqDwbjzxFNOk7+hiwUhNHEcrE+cilQR93zST76noUNBFAEJmdTt9D/NNr2
         iPEdP/B3npG7f5KwNaKDb67VqfxLxMbRXiOnUPolTbx+G6eBkeakkmoiW6q49dXxGCUH
         jL5NJox84uM+kCRXJmKJOak8QZAKK7tWHk2dVXUhwu2WFeaasKYEgB/ap0NiSU6fwe5t
         FKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750380; x=1793355180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/gVKIE3a0X4lk1FYa+PkYFloniP/UNgT1s7zMDVr3EI=;
        b=hGdMxTgMR+gzp41Ne1bfVxB3nttwBupWfHNBdhNRp5G1LtzryE+hMiJO3oZU+FTZ4D
         PN/4G8i90F5A5AtlW57VgktB5yQGkuXRfEwS98JUMSd1YA+NN7r+1WmO0ocUpFGqnfQE
         tdHAWnHKy2tPhKsSR/OA3mgb5VSc7U4VCnc4ubBFE2TAeajZRFekx3YC7BlMNZdXqn8+
         lok57l9mkQtDhyiiGoPsfH4kmpGJBbzzx+wLbCtAS8BwGziTa0XcstzalLwHKQ57xUWP
         F8ljo1KqTXi8h6NmYbF0EVswF9dsVqX2//q42mTcLdcT6c3l6lZz2KkHi/Iyppf5EkCo
         IIRg==
X-Gm-Message-State: AFq9FYJ0VbYaUo6rFHq217sXlLMg3JwEiVjpLjnghCI2KUAvaukPMA41
	naHHMgzFVb5hN/wml5tDgAGNFLroPcEsHZRX1+AkwjAmpA6qvMCGDHmaG0q08w==
X-Gm-Gg: AYBFou274g5XwhVhHNyV2G50w7nrI4ob99p14fnGXQvdVWfvNulPn2MlspJ3w2CTsau
	KfY3xZ27Gf0bROkHfd8EYwAlQCrW+HOP0KtrVQzXR/xftmSNzXh3qssiTHiMAxuIYCoOKSrLVGe
	Y3MosV4OqGdyDLbNtGtJ3XmZ/o7Mv40UuNOw164m2e3snK1iDIhKjLk+m7qbgFALOuy8X4Fkhiu
	XTpx5noI1tRsti9MlyBgfPsaCnEavY0IznTTibyTak8mMgByBVIapCGzcMghh7/EM/0pqp9KzOl
	bSjB9BmgejQqqyqOvbzsrVRUwOq5OId9h6ZK9bBrPu5H1N8m191K+71jtCi5zdKG2s/OU0+eA4d
	wgDosKp/YfaP7bl4VjBEk+9qbrmtyoeZlOMlYh5cd0IxSGUrfktbCh40h/eZrGIzafOF0kFgltY
	4x6Y7i/MloEiirMvUbl3Pis6XYldn44QE4aF1+ZIheqO0KwciE1EZND7vG4NbAkj45dHweXt1eU
	iPyi1TImHoNne00vkXN199jD5riy6pjdx3Gke7q3BdO8GM=
X-Received: by 2002:a05:7300:fb15:b0:35d:4185:5395 with SMTP id 5a478bee46e88-369d975b13cmr2360685eec.16.1792750379489;
        Fri, 23 Oct 2026 03:12:59 -0700 (PDT)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c15883sm5655337eec.3.2026.10.23.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:12:59 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v3] perf stat: Start tool events when enable_on_exec is used
Date: Fri, 23 Oct 2026 10:12:56 +0000
Message-ID: <20261023101256.1752713-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023085554.1694434-1-takano32@gmail.com>
References: <20261023085554.1694434-1-takano32@gmail.com>
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

When perf stat runs a workload, target__enable_on_exec() is true and the
tool events are left to the kernel to start on exec.  Tool events are
however emulated in perf (duration_time, user_time, system_time,
num_cpus) and have nothing in the kernel to start them, so they stay
disabled and are read as zero.

For duration_time this makes CPUs_utilized divide by zero, and plain
"perf stat" prints "nan CPUs":

  $ perf stat -e task-clock,duration_time -- sleep 0.1
               0      duration_time

Start the tool events explicitly in that case.  They are started through
evsel__tool_pmu_enable() rather than evsel__enable(), because the latter
also enables the members of a mixed PMU group, and those cannot be used
here: get_group_fd() passes the leader's descriptor to
sys_perf_event_open(), which fails with EINVAL for a userspace PMU
leader, so the members end up unsupported with core.fd released.  Only
the tool event itself is started; the kernel starts the members of a
group it can open.

Skip the events that failed to open, the same way the evlist and the
counter read paths skip them, so a tool event that never opened is not
started and then read through a NULL descriptor.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Assisted-by: LLM

---
v1 -> v2: Do not call evsel__enable(), which also enables the members of a
mixed PMU group and dereferences a NULL fd; call evsel__tool_pmu_enable()
instead.  Reported by Sashiko review.

v2 -> v3: Also require evsel->supported, as reading a tool event that never
opened dereferences a NULL core.fd, and correct the explanation of why the
members of a mixed PMU group have no descriptor: get_group_fd() forwards the
leader's descriptor to sys_perf_event_open(), which fails with EINVAL for a
userspace PMU leader.  Reported by Sashiko review.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/builtin-stat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c50cf230f16e..334b875d6a2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -510,6 +510,19 @@ static int enable_counters(void)
 	if (!target__enable_on_exec(&target)) {
 		if (!all_counters_use_bpf)
 			evlist__enable(evsel_list);
+	} else {
+		/*
+		 * Tool events are emulated in perf, so enable_on_exec above
+		 * does not start them.  Start them here rather than through
+		 * evsel__enable(), which also walks the members of a mixed
+		 * PMU group; those are not opened here and their core.fd can
+		 * be NULL.
+		 */
+		evlist__for_each_entry(evsel_list, evsel) {
+			if (evsel__is_tool(evsel) && evsel->supported &&
+			    !evsel__tool_pmu_enable(evsel))
+				evsel->disabled = false;
+		}
 	}
 	return 0;
 }

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.53.0

