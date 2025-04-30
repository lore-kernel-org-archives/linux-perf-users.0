Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFD278E7A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035553; cv=none; b=jHcYFw58Cwn9XDS4uG6i/1H0gEfdzqmurMCt9CH0MaQJsm4JoOo+3UoSxDl1Rtt7YrRj2Nch4XqWEATE/66UBmPrADOm8rM/QWvX0L1KKvy7utYygIFia3BaJI8XEtUwi86VN0Ryx7MZtip1jtvwGAW4DZnBGjyeDXATD3GLsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035553; c=relaxed/simple;
	bh=kyIAaqYv5feUAAH9a7cG4X9qbJk9e6Q/D00eURyg8ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k3r0qY5FkvZp02cEWp3HmiubMGILHOT+7tb3vS8VWnbct1bMigCGdX7MfvYM+pnKu/zA11rAoUWNk6kKMZkczs2ucfxp93jHgV40DTnEg+0WVl36lUzzoBaddHORkRI9bB7Xm2kkLZFc+Xiecma1tEHPcT11mCoxw6aAfZxSpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXBDZnhc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXBDZnhc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1d9f278aecso51471a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035551; x=1746640351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xcg6wjMvXME6KKvdjmH0neAjL3wA1v7P5CrDBAB/BDc=;
        b=xXBDZnhce4huloB8X/qdRUg+eWHumjVOohdujdH5z7FMRUtNqFX3iw4XgSDCJG8QmE
         /o3iScg+Mzag8VtG6wZG7g6gOBgC+QQH/4H8wPihIPfqnLuE6gl1qc73ZLKIHqyaQst2
         YVGpahC9EIBHrTxxGO5gBikjbubwPIXdpcosWdW0RcEzEdCqBrKa1ClZb6lBg46tW/9n
         0cAZTKfTO8VUcT3rXP+aqHSiVj0cPR7I6S21+ntiCKN2vD9d2KmOtQAl3ZXnqORQeBTL
         /tg8sBqOVPNkZWZWNdNN9SqUKed/Aacor+rD3Kt/bD30B4Un40QFESSdPdzla8P5aH5F
         nr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035551; x=1746640351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xcg6wjMvXME6KKvdjmH0neAjL3wA1v7P5CrDBAB/BDc=;
        b=Q4Or8C4vAX7RVBRkUZV5DQLPl9jcLFB4q0OwAti7E60LUFAyOhvoU4HsvX7V4wHwGj
         pXWE+5p4HQEMwCy/VhaPyT+TNNPQ1n2ZbAMmvw3BnFjIyi0oPvK+lgCB695TuvbUxDKj
         NiMBgFYPh0aow/tel6c0xJhPdFlNwC5LSzODUymQY9tlA5/+Dq3zwnvY9dSFi1yMMsMK
         1mW2EpIWFgiXztCIZ2zq0n3Exdk44r12rBF2Q60ekYayGeSB4Y7fy1iX4PsTqH80RJz+
         6kgSIxvKVMJrmuY1aFpAIdA3Lv+h12WHmVIuPlcr+yy5vrzvWukaqry/AYD61pjpjbAM
         S13A==
X-Forwarded-Encrypted: i=1; AJvYcCVbXlxVJDM1C+PzU9l24Ix0etO9whHAJo+YOQInrrVVitELioZMmFfSar92miIE/drhPPd+exjn2K77+01ZjYtr@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8Vbt5Q2TrwN/0ope8e8wL5GwnMb556zXm+fhnfHETNwN39V2
	UsiLmv9sCsGDexmJBHM6iRbOVXxYWe7HtrS543rni6g7FnQb7sTuisAVR+l+auacvIVaUREZn00
	z1T0Q9g==
X-Google-Smtp-Source: AGHT+IEKyz0de2SDHs2Wi3XD69kNX3qSVqi0GA9WwmSWKDFlmr/T24Ck2MF0lTbNZtV+tulQOwG0zYD0Vjfx
X-Received: from pgkb21.prod.google.com ([2002:a63:eb55:0:b0:b1f:857e:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:118a:b0:1f5:93cd:59b5
 with SMTP id adf61e73a8af0-20aa41839ccmr5344128637.28.1746035551081; Wed, 30
 Apr 2025 10:52:31 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:34 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-47-irogers@google.com>
Subject: [PATCH v2 46/47] perf hashmap: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/hashmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 140ee4055676..f2719f522b84 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -115,7 +115,7 @@ static int hashmap_grow(struct hashmap *map)
 		return -ENOMEM;
 
 	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
-		h = hash_bits(map->hash_fn(cur->key, map->ctx), new_cap_bits);
+		h = hash_bits(map->hash_fn(cur->key, map->ctx), (int)new_cap_bits);
 		hashmap_add_entry(&new_buckets[h], cur);
 	}
 
@@ -164,7 +164,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 	if (old_value)
 		*old_value = 0;
 
-	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+	h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	if (strategy != HASHMAP_APPEND &&
 	    hashmap_find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
@@ -188,7 +188,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 		err = hashmap_grow(map);
 		if (err)
 			return err;
-		h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+		h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	}
 
 	entry = malloc(sizeof(struct hashmap_entry));
@@ -208,7 +208,7 @@ bool hashmap_find(const struct hashmap *map, long key, long *value)
 	struct hashmap_entry *entry;
 	size_t h;
 
-	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+	h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	if (!hashmap_find_entry(map, key, h, NULL, &entry))
 		return false;
 
@@ -223,7 +223,7 @@ bool hashmap_delete(struct hashmap *map, long key,
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
 
-	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+	h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	if (!hashmap_find_entry(map, key, h, &pprev, &entry))
 		return false;
 
-- 
2.49.0.906.g1f30a19c02-goog

