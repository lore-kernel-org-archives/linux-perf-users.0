Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7C3FB1A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRRwvyFw"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB230C5
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a90d6ab944so56805167b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186336; x=1698791136; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZGWaGIyb2MLTR6FKf9sQ21nNy6Say3HBAADxZHBZRA=;
        b=pRRwvyFwnHwcygLAejayEt2NNSybuNbRUx0dieNKbFFQqJu7pI8tjFYOrawnhYicxv
         1k0s8yf+6VTLk4WCYSzaql5nS7MVqnV5XCK/g8ICGM/5ONMACRtQHl5LAKKoiJSkVzpN
         ZsZSKpI+3/nviSFk61QM/s2HdbcWWOt3eneMrl1frMOC92ZOB0zCHQxiH+B+NMIeWo6/
         OFeWUFRa8I2PAcYmzsGZW5u14sz2uGvKKMCPjejuiVyNyeB+62N037HQ9wkSImkPutMQ
         n/7rf3FqhGekKlkSqe3kylPdv2yUruR3m8WaAT2A3bPBlQtfL+ujG18gdSUrRdMs0DqJ
         +uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186336; x=1698791136;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZGWaGIyb2MLTR6FKf9sQ21nNy6Say3HBAADxZHBZRA=;
        b=xT99b1wQWBh1ZEI0DtNd75+q/8xzNX0bmW/RaZeUe7FhFG1kEn+Su1rXOeZ+whmu7V
         DVGXgl3NOucXI16NPcElG8itBPKysEXGp4a9hI5rTmot2KtwZNptdKbLLCJegeQpghkH
         a2TSNLtlOWcghfnNL4Nr/fcJvCtwLg6Yr9rR9aFeOrtpekEpIRWm0mc0k3G9DE09JOBs
         cY62UzbbCm76nqKNaq+hiegbpvm2u50mBHzwfez1pnVP9ElkGK1Oy57vz2zuI+IEZwLI
         gfibswte04MUrdwfKItddwIt3SRI9SjDv+hgWHzBMMd8pT4GcGLJ00xzZXVblbBHVHRI
         tSTg==
X-Gm-Message-State: AOJu0YwZZSrC9LcP1EK6X6ICBm+W7kV876b+JuldM8pbEJ/ESDUYhFCl
	NEmy+n31YdgnSeDVsUzrUTNYP1CMNAm5
X-Google-Smtp-Source: AGHT+IHVz7pXh1CNxQ6qdbvifEOQamlKLSHKq/wbY1rZuBe6FFyXXl//ZLSKV7rNVjPdUV1Iae1P5nBb37CA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:e8c6:0:b0:5a7:b54e:bfc1 with SMTP id
 r189-20020a0de8c6000000b005a7b54ebfc1mr337662ywe.10.1698186335876; Tue, 24
 Oct 2023 15:25:35 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:40 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-38-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 37/50] perf maps: Fix up overlaps during fixup_end
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Maps are sometimes made overlapping, in particular kernel maps. If the
end of a map overlaps the start of the next, shorten the overlapping
map. This should remove potential non-determinism in maps__find, ie
finding maps by address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 01c15d0b300a..fba95a00ecdf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -700,7 +700,7 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
+		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
 			map__set_end(prev->map, map__start(curr->map));
 
 		prev = curr;
-- 
2.42.0.758.gaed0368e0e-goog

