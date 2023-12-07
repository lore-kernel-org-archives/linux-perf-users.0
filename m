Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="av+IemWZ"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C3D4B
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:17:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d42c43d8daso1227077b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911849; x=1702516649; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwUZYyK0Ujy/qNX/TFIi+04XnhZ1QaUR4WIBvLcrqEc=;
        b=av+IemWZ1ObNifkU9XUiDGYnbgA7KZxdubWFjauvMpPdmtrrEpccv3lLGrt4XC1sVd
         Zhu0Ul6FryaOfFSG2KLabjS9r2qNlPFE2cT2d7sViiDxThHn+0HFBF9umBj0qBm/MvY8
         GCq7rJgTUfeQTkRMqYYap4RAydaUecwaibByJCVEktb6tZDPQxqolOoMIFEclm/rQEP7
         7VB2X0j0WoSJROu1zwCOz01dRaB2zYOBb5nhhYDsg9rTyO7doG0WOdm5vfKdBOPAhgOC
         tmH/NBZSSEM0N9o/1fEmwN/ivoxeGmzoFNsIJIqkE3JsWWY+NT2UMIa1ydPz11Sjlj+8
         WbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911849; x=1702516649;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwUZYyK0Ujy/qNX/TFIi+04XnhZ1QaUR4WIBvLcrqEc=;
        b=ftE/KychLHcKDcf5krRYIbo9UpiLKnV7c/zeJYnXUwNJpsWQWmnasLvhJQ0CAFRi/4
         r9qyH1GG77dOWvHZWZ3OSmZnUwip2pwk3dP7u1Ceo7uIMta2Xwer+/AJBMq54kyc/ArJ
         hgJk8lxsYNcJCpVIqOiqy6TSfSv1SydjIclB99D2gDRrN4V+jApjQYlvsVluBeP6VvIM
         Lb7WP+7VOTe9arI2LkuXaWSvhY20VrDk7fLdxwq63p1ND24sF5X23WXjxhZFPFx+xAcr
         u+e1PDVf/tEeNrBvlyRtL4qcF9Tqbnxs9YD03dPELBB8u0YVkxtcYKDyyhQ+9liVAuhE
         SaRQ==
X-Gm-Message-State: AOJu0Yz918qmUnZuaNrTzFT1EqL7bCSjzA3WSY5J+18S9DNEYl4km6EA
	EQPeqUG+fxW6r2qYjG1rSyuZ6qE1XyVs
X-Google-Smtp-Source: AGHT+IHvn4MNpMVKgpm4EqbTDNH7nndDq/7QojZH52C5pszqDkaNVs/YfjgX2hoGBWPXTOfpK9M5fqytqSL0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:b658:0:b0:5d3:ffa2:56ec with SMTP id
 h24-20020a81b658000000b005d3ffa256ecmr126424ywk.1.1701911849559; Wed, 06 Dec
 2023 17:17:29 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:35 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 01/47] perf map: Improve map/unmap parameter names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

The u64 values are either absolute or relative, try to hint better in
the parameter names.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3a3b7757da5f..49756716cb13 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -105,25 +105,25 @@ static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
 }
 
 /* dso rip -> ip */
-static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
+static inline u64 map__dso_unmap_ip(const struct map *map, u64 rip)
 {
-	return ip + map__start(map) - map__pgoff(map);
+	return rip + map__start(map) - map__pgoff(map);
 }
 
-static inline u64 map__map_ip(const struct map *map, u64 ip)
+static inline u64 map__map_ip(const struct map *map, u64 ip_or_rip)
 {
 	if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
-		return map__dso_map_ip(map, ip);
+		return map__dso_map_ip(map, ip_or_rip);
 	else
-		return ip;
+		return ip_or_rip;
 }
 
-static inline u64 map__unmap_ip(const struct map *map, u64 ip)
+static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)
 {
 	if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
-		return map__dso_unmap_ip(map, ip);
+		return map__dso_unmap_ip(map, ip_or_rip);
 	else
-		return ip;
+		return ip_or_rip;
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
-- 
2.43.0.rc2.451.g8631bc7472-goog

