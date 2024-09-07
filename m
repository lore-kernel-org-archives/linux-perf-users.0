Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4004F20C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685725; cv=none; b=MzwhuoChTuHCuQobWLApZaU7SPWIZ8h4of3izBl78xa6Z2FbuS4kMJosroTNoik4R3eFYHv/f0/lNpZQIW+b5Gc4/CXv3m5eY8hwBBOhKDFHs0afF0de+omyzNz+hPv0ocxY2AqAwQgnLMlkr1WKIgzjv3+igv+5c3zEPcBfFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685725; c=relaxed/simple;
	bh=GtXRyRAclVPuKyzrz5Y0RxXirN/zDK2r6Wx7Lfe/Aic=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=htZUosPrsr+f1BVJjSIXNnjc0vbXdBpnjoUDk91dvEsqINUTuMKZPUS2YtO5oPBiVZbIwW/xsQEafzdOd0IzoywIw9d5o3j551JHO85v+e1GWA3yjDiKD4izDgcE0CabjER+CEk8myGz71RKv2tHVa9gC76mCWbd0htlllEGuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHNgr0SV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHNgr0SV"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b2249bf2d0so95624167b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685723; x=1726290523; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ApYaFx0+sxUWqA8R+JFTFM43Yl04Vb2u4ryemp0VHs=;
        b=xHNgr0SVPVKyRp865NREJy4AX9c3abPTA1J+ykmhjnLVoEaypehL0I/MVbRD55IHjx
         i+E+NqEUaNR84rWMq70+TqdJ+Nw47i9zfBEKTaNYJ18wzFnFobRgyKv96rmku4G8Xtm/
         WUh5nDhzB79gZ9aIum9NsTmOHpIoi+i/oGRjyZv6T3c7DvfgjjeqqN2OndFR/I71ejKC
         xQ/cCfYfBU0LsWABtJs87iN3KkQCnhRX3APyBZ9u/kNEnARuQ3PUY6EuyLjXVDW21v2f
         xPmPZxnDDMHwoZzAdPsQ3hMlz5wHI6i9ySvFYxz6sbGV+VAJJ2uQOlEYeIhO/IEpRdWo
         a9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685723; x=1726290523;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ApYaFx0+sxUWqA8R+JFTFM43Yl04Vb2u4ryemp0VHs=;
        b=v2i2k6P7+Ezsr5BpQUhnrN5cU8U6Liozn5AUT2RdVgt/Evezy+s+fdi83/Oz5CNTiX
         R1W1yVjcUrHul4lwdmZKw4Ya/MpvkABwsk+Ew0c5kFxliogaa1AfSFESPzO6vC55kn1V
         Ga6rnrQixrWGkrM27HFr2uHTl2tanyQytWtOEXVjifS4cAk+6n0BmTburUEW1nvScWNF
         /1osfiMgjXTY8ruJnMfQYSXvu50TeHTLmqxU2vEC7FoNAgbnmaTmFvzxNLC5gkuJvPq0
         vz86L1US+aiffrNqsx1hylKsErE2SC642lAw4eUi3bZnweozRwYZC5NGbepMixMLnk8X
         Sn3g==
X-Forwarded-Encrypted: i=1; AJvYcCWMIF39Ye45ER+2ca7h2xyNuHl0ffniKBewPfH53dMeNlTMSfg+8ZLF/v6FdQU4ucTgX93iv/ruS+lw1jgivH5T@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzhcjAOnbJeirQ4hUPhWfJ0phKRhtfNXyN6Xmp31kua6lnlLi
	MV53DqwR3MAh0W8lWJz4CiyED7WIQPGNzrIbW7AvfaARHyonC3BWQb6ykn5tPyyCYbM2Avgeb8h
	dugXSVA==
X-Google-Smtp-Source: AGHT+IEP84F/M2rTb3JNZ7bCbxgU/+jIK+b9LqWkHujq8bu5u0u7fEm7frKSL7le+5SzKQ0eekBwy8lqkNNo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d1:b0:e0e:a784:2957 with SMTP id
 3f1490d57ef6-e1d34865f70mr12294276.1.1725685722506; Fri, 06 Sep 2024 22:08:42
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:16 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 01/15] perf list: Avoid potential out of bounds memory read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

If a desc string is 0 length then -1 will be out of bounds, add a
check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 82cb4b1010aa..65b8cba324be 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -173,7 +173,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		if (pmu_name && strcmp(pmu_name, "default_core")) {
 			desc_len = strlen(desc);
 			desc_len = asprintf(&desc_with_unit,
-					    desc[desc_len - 1] != '.'
+					    desc_len > 0 && desc[desc_len - 1] != '.'
 					      ? "%s. Unit: %s" : "%s Unit: %s",
 					    desc, pmu_name);
 		}
-- 
2.46.0.469.g59c65b2a67-goog

