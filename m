Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2826B96E
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035482; cv=none; b=Yih8SljXlCNvNWmrFDYrTImJhtrNxmvdw0gPEGhKDGnB+zQXmbwmsRjDDsIjSaSenuRV9Cr/yHhmwjo6JVHzaVf8EXWmHOq8+bl7R/Kasta+mDrMiap3517v2r6sYSM00ua1Uo04lctJb8/2rXebQHoXqqXo0XL0dw370CoyNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035482; c=relaxed/simple;
	bh=rftYB7Je9QanXS06aJQAV64mnCyECLTT1AGVyG3u3zU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kK+pOP74tKGPa5uM9tfrw+GjAzRxmnRmYdAJ63xUxTwK2G/DUTsNMFIkTdnE6Ro/fRz9g68x0V0+5ZxkY62uBjRLmXWiTRyQ8sFnim0/D8LGtveIEy74Naszbet2PhpnMJPBRQaSbqDtAolAkt/rKYC9ccYGCYQi35o2Adz4v+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKANfbjC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKANfbjC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af59547f55bso62194a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035480; x=1746640280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P29K1kujZoMXWie6DZ8D+w5WeYejq+SDhNJ0Ah+HhrM=;
        b=SKANfbjC9UG3Z/6g0Dj9tzS2d7Cw8Uy3vkJB7e7GJ0UlD/Kb76BjHp0ahgh8oVC/B7
         T2ocnueNYviuWnL1B2tPQorFUQbDUs6RDHy5KAkZKmWZbIkraCnALSy/uEOCMuO1tOE+
         A+rD/mHpD7ipNr2mPSaTlnK6gzdTUKfAGP3L1XYXJ0/cfuXl+ZvMd9aHav0fZKyKei/G
         xIphRDn/7/n51AoauOJgcSs4geLpw76HTRccuucIbI4dJDhsQF48Y6iwKAeOtYWFjms5
         6dLLhmarUndGUaln+xi7kFPrExoVVczX3nsIvGPbQCv5fKV3MqqGZhTsKt74fokrhn8b
         WNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035480; x=1746640280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P29K1kujZoMXWie6DZ8D+w5WeYejq+SDhNJ0Ah+HhrM=;
        b=dYncTLL5ngFAHPHfHf81Zals00j0PfnnqYWwG1G3nqea/7aad5psV/2d5QksDbvkD9
         jVpxZKfEhqlHpyvcpSCjne+aQ58IhCi+TklY9UVCZRI/NxTzuzsjteHvzMDqVepcRR5L
         fex9MWcUeU+cgquVwijvCDZpoypP1DCE4Mr2ga38DPzwZVMNOU0ylaZqKL1ZByuIJ+Dv
         PYDKCg+IsAYVDxbNekIfut5eItMe7CQ+IHjPtxvn9DyudtbF1EyLtM4Lq/XqDueWKVV/
         0okEFNmMHzTI7ze71ZuuPxuNIxuFIHpGvHx40M8ojyuvNjCjvO/gdttifzMKGzz8iRdS
         uK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW11sm9MFwB6sI5UmOVVqBMnRY2Au6fGkBU9pzPwSvPYkvKr74wqQ2eZto05N+xSYHOdDJZvehzIP6kz8Z59LWt@vger.kernel.org
X-Gm-Message-State: AOJu0YzCfgMj5sc9+Hliu6vFAhgayeohDB2WAVT14u/KUPLjOsE0M/6O
	Ao66EPi5RgEJFMWQ5awXzHJ4TfYLMednsW2iYEctkIOY0Rghfy5PeFti5ERfp3bLm4PA039Ca25
	7SjJAzw==
X-Google-Smtp-Source: AGHT+IEGPWI/bLU0ChmanZkkVccc6w0xuZletv87Ryews2M2tIKd7C7dL8CS1bxtiFThWozumCMb4ytAPaSq
X-Received: from pgg7.prod.google.com ([2002:a05:6a02:4d87:b0:aee:6db5:c8ea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d50b:b0:1f5:8622:5ecb
 with SMTP id adf61e73a8af0-20ba87895b6mr142585637.34.1746035479906; Wed, 30
 Apr 2025 10:51:19 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:59 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-12-irogers@google.com>
Subject: [PATCH v2 11/47] perf arm-spe: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  4 ++--
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  2 +-
 tools/perf/util/arm-spe.c                     | 24 +++++++++----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 688fe6d75244..58107970b215 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -117,7 +117,7 @@ static int arm_spe_get_data(struct arm_spe_decoder *decoder)
 	if (!decoder->len)
 		pr_debug("No more data\n");
 
-	return decoder->len;
+	return (int)decoder->len;
 }
 
 static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
@@ -187,7 +187,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			break;
 		case ARM_SPE_COUNTER:
 			if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
-				decoder->record.latency = payload;
+				decoder->record.latency = (u32)payload;
 			break;
 		case ARM_SPE_CONTEXT:
 			decoder->record.context_id = payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 13cadb2f1cea..a6d04ad50db6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -63,7 +63,7 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-	return 1 + ext_hdr + payload_len;
+	return 1 + ext_hdr + (int)payload_len;
 }
 
 static int arm_spe_get_pad(struct arm_spe_pkt *packet)
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2a9775649cc2..561bef7b4628 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -786,7 +786,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
-		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
+		if (is_midr_in_range_list((u32)midr, data_source_handles[i].midr_ranges)) {
 			data_source_handles[i].ds_synth(record, data_src);
 			return true;
 		}
@@ -956,7 +956,7 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		 */
 		record = &speq->decoder->record;
 		if (!spe->timeless_decoding && record->context_id != (u64)-1) {
-			ret = arm_spe_set_tid(speq, record->context_id);
+			ret = arm_spe_set_tid(speq, (pid_t)record->context_id);
 			if (ret)
 				return ret;
 
@@ -1344,8 +1344,8 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
 	}
 
 	*ver = ptr[ARM_SPE_HEADER_VERSION];
-	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
-	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
+	hdr_sz = (int)ptr[ARM_SPE_HEADER_SIZE];
+	*nr_cpu = (int)ptr[ARM_SPE_CPUS_NUM];
 
 	metadata = calloc(*nr_cpu, sizeof(*metadata));
 	if (!metadata)
@@ -1353,7 +1353,7 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
 
 	/* Locate the start address of per CPU metadata */
 	ptr += hdr_sz;
-	per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
+	per_cpu_sz = (int)((metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu));
 
 	for (i = 0; i < *nr_cpu; i++) {
 		metadata[i] = arm_spe__alloc_per_cpu_metadata(ptr, per_cpu_sz);
@@ -1405,7 +1405,7 @@ static void arm_spe_free(struct perf_session *session)
 	auxtrace_heap__free(&spe->heap);
 	arm_spe_free_events(session);
 	session->auxtrace = NULL;
-	arm_spe__free_metadata(spe->metadata, spe->metadata_nr_cpu);
+	arm_spe__free_metadata(spe->metadata, (int)spe->metadata_nr_cpu);
 	free(spe);
 }
 
@@ -1451,8 +1451,8 @@ static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
 		hdr_size = ARM_SPE_AUXTRACE_V1_PRIV_MAX;
 		hdr_fmts = metadata_hdr_v1_fmts;
 	} else {
-		cpu_num = arr[ARM_SPE_CPUS_NUM];
-		hdr_size = arr[ARM_SPE_HEADER_SIZE];
+		cpu_num = (unsigned int)arr[ARM_SPE_CPUS_NUM];
+		hdr_size = (unsigned int)arr[ARM_SPE_HEADER_SIZE];
 		hdr_fmts = metadata_hdr_fmts;
 	}
 
@@ -1466,7 +1466,7 @@ static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
 		 * are fixed. The sequential parameter size is decided by the
 		 * field 'ARM_SPE_CPU_NR_PARAMS'.
 		 */
-		cpu_size = (ARM_SPE_CPU_NR_PARAMS + 1) + arr[ARM_SPE_CPU_NR_PARAMS];
+		cpu_size = (unsigned int)((ARM_SPE_CPU_NR_PARAMS + 1) + arr[ARM_SPE_CPU_NR_PARAMS]);
 		for (i = 0; i < cpu_size; i++)
 			fprintf(stdout, metadata_per_cpu_fmts[i], arr[i]);
 		arr += cpu_size;
@@ -1731,9 +1731,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	if (metadata_ver == 1)
-		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+		spe->pmu_type = (u32)auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	else
-		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE_V2];
+		spe->pmu_type = (u32)auxtrace_info->priv[ARM_SPE_PMU_TYPE_V2];
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_nr_cpu = nr_cpu;
@@ -1752,7 +1752,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	 * "time_cycles" only if they are contained in the event.
 	 */
 	spe->tc.time_shift = tc->time_shift;
-	spe->tc.time_mult = tc->time_mult;
+	spe->tc.time_mult = (u32)tc->time_mult;
 	spe->tc.time_zero = tc->time_zero;
 
 	if (event_contains(*tc, time_cycles)) {
-- 
2.49.0.906.g1f30a19c02-goog

