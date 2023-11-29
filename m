Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gotxKEv8"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A71BC0
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 22:02:49 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ccaa0da231so84943397b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 22:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237768; x=1701842568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdtDmuZlpO8R+sCZuGq6XIuCqB6n5MWFW+Mek7m4zb4=;
        b=gotxKEv80wkHKfwOnrYUFZ1P/QiffG8FS3MtPA9e9ms22h6ijUbW+/gk/3Zc3rYqX0
         eZz+enL5hNKX61jBBi0F1WtSYodUp0KpUX0MiQqCsSrT/qXGNmklX1bKK2dXW1i/3Guh
         MM7V904BCR9zGFc5AfXVYQ5S73yHjMZy5c+XG61hU70H/MmXc3WWwh8KYVR4SjJ0Syni
         Rn5Hs4cyevaUfF4b13San60VPFuoeKeaYqYnr/RLHSErNHnx9jmQPu6EDahzQGId4VAh
         azirywDrQQrMois+BFSzJlyIygMrwJDTghbRccfFE9s6SSQCoVEgWC2fXFTexinuJ6R2
         1OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237768; x=1701842568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdtDmuZlpO8R+sCZuGq6XIuCqB6n5MWFW+Mek7m4zb4=;
        b=LpMRGofZAgfWCpj/iefjOT8hYxnRGsAkiTWTK9a+SPiq8hCG8gF+L54H0ZuQ9MyNUF
         nY05bnNAGgrH1VHQIqo+AX6NxE1G8BSjtu+SQLxR6OK4IyQcqlg9wZy3y7kPY70s4p2U
         Bv4hc7XLzqPLKussbvJgzNfd7oCG9RGKB/E3cZFmBeOkFUetsksRbRSnK67MxQ0N1hqM
         mcspMMumZ915iFxJY3Y/R0Dt5Ea7B+SnqypQBz2HNjOKZ/96TCmYvhP+ypCASgMBb3hy
         nYai+EZwYtzKOyCfA4Gs/yxfLZq8lRM8JrbvdPcI2b7cEVf4gIcX2CX2oh4Y7kCViLDV
         EsKA==
X-Gm-Message-State: AOJu0YyX/QjTbErJmGz0XvwhIMAPznAlfDOI9Puaw4VnRj7EAjHw3/Jb
	v3wKtsUL43g/VXGClr2pKqzymeqX8nst
X-Google-Smtp-Source: AGHT+IFWysPah8NVdJGuOS/cub7nCqzkPRr9kIA04P1LJGn4EJzUePlje+77t8xYTmBpNHAmkcV+MNHmEHhD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcd:b0:5ca:fef:82a4 with SMTP id
 dg13-20020a05690c0fcd00b005ca0fef82a4mr623872ywb.4.1701237768039; Tue, 28 Nov
 2023 22:02:48 -0800 (PST)
Date: Tue, 28 Nov 2023 22:02:11 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 14/14] libperf cpumap: Document perf_cpu_map__nr's behavior
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_cpu_map__nr's behavior around an empty CPU map is strange as it
returns that there is 1 CPU. Changing code that may rely on this
behavior is hard, we can at least document the behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/cpumap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 523e4348fc96..90457d17fb2f 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -44,7 +44,18 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 							 struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__cpu - get the CPU value at the given index. Returns -1 if index
+ *                     is invalid.
+ */
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+/**
+ * perf_cpu_map__nr - for an empty map returns 1, as perf_cpu_map__cpu returns a
+ *                    cpu of -1 for an invalid index, this makes an empty map
+ *                    look like it contains the "any CPU"/dummy value. Otherwise
+ *                    the result is the number CPUs in the map plus one if the
+ *                    "any CPU"/dummy value is present.
+ */
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 /**
  * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
-- 
2.43.0.rc1.413.gea7ed67945-goog

