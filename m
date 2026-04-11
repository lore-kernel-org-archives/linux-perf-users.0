Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC6353EF7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935040; cv=none; b=TdvniL22JcT9veYCeczQXTKmSaf+BskvS/vv8OyjiXRUfIKyKym2dglczlvEH9F9QPY+nvpWwvKsyG05buJrEvCRDCAkcPDDC8p85eA4NCiL+rbF8zPv75ZoChC8WIBmiXXMoSkYWiPGKaVULHreAjZiJnQJwk84oFxCUgvMYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935040; c=relaxed/simple;
	bh=n2JtyMg3dnFRI+CN9oMKk3aLsRiKCNqRLI02Htuc8WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UIL3anB9fy65ox92iUs0l34BE9Hzasd3qTC5DDAPaOcxouaSgheLIPyJBAGk3v65/7u+TeJHZpWuDAXEUMawsD4z6+MUITxvVOFoH/2lnRwJlCEZCvxKTOPDFx353OQ0c4RAcWvMdcLFl4/WbC+5JhfGy6RWievAbvuF0CuqAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCuLYba8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCuLYba8"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12bf9974587so2690486c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935038; x=1776539838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=uCuLYba8xPJnMxr837kDI9H02irtkWLHXOZpghFEvoU/meHj92mjVpHRB2SKlpu2fm
         bvI79yRrLwzeZmbyU0myhurYk4JBUuqlA1biyzuHG1Ev9a3lGH4FY6SnPiaKz43f9RP1
         zL9c599LqhAejgm7m3OSgD1DXkir8XSRCgofXiEm+nBm7IvlkJzzuxPlnhTFbRa2kDcK
         fZ8CeKsVEtXfBJBhMWSsDIhueKkqzQoExMRZuddh4T+l18oaiJcNqJVDNwHO5Zj8Y9Dr
         cCWhr1lLtBojsd1mJmQ1jo+8dlj0F+icBmikOj8axS4QHtZP5bx+8252jNSMdQ9i5ETv
         Ivcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935038; x=1776539838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=UEg+XlRgVa5rd8KDxrIpyExtQjkqyv248fas5jNhOnh5eSWiFsBAa/NFnLaiDuMFOC
         EAu7RSBhKnFsrk+ZYlk6QUj4SnP+tsSq1AXnQVDS0pA3O9mvaD2/jgiZfjbsEynAwBqL
         VuwRKseOl9qznJnAfRjQK5ePeqajPhTVBysVvx08iGPIhqMGabbHXIn9uAbhiF2OSbUK
         9rgXc6gRf2qPhdrdxLe6WCno6uixwRdr8Z8JtGdB5ng1NkKM6qcfLdS8j1Vm6l4jhy7/
         aiifSQ83d14zu5meVd3z9abNn2uB62D65TOvZ1dUYZHgHDBpyRYnaVBL4z/d/6kIXuLF
         AgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0moXp90V3lofLDnxQ7nJYknEzy2DcaphYUFCJsudgk5+JjvLXcT+e6nsK1DThnAzt33eiSN5YxCN11VkeG8zq@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRZMIru//4AMI8WKATBokFvlq1eYXoTh99l8xz9i0AID8JlnO
	+oF3jrjN8OnRT2O5kEeaicBRo0C5e/DEN7uKwYwP2ZKr5/EW1s9Gn215qIwlUZ8YdTBUnODM7ET
	8Lu4FbHNvww==
X-Received: from dlbep7.prod.google.com ([2002:a05:7022:1087:b0:12b:f959:6e78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670a:b0:128:d752:e076
 with SMTP id a92af1059eb24-12c34e3f38dmr4685817c88.3.1775935037633; Sat, 11
 Apr 2026 12:17:17 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:42 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-2-irogers@google.com>
Subject: [PATCH v9 01/29] perf sample: Fix documentation typo
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

s/PEF/PERF/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index ca0c407c4423..e556c9b656ea 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -126,7 +126,7 @@ struct perf_sample {
 	u64 time;
 	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
 	u64 addr;
-	/** @id: The sample event PERF_SAMPLE_ID or PEF_SAMPLE_IDENTIFIER value. */
+	/** @id: The sample event PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER value. */
 	u64 id;
 	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
 	u64 stream_id;
-- 
2.53.0.1213.gd9a14994de-goog

