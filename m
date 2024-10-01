Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6719AD8C
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786215; cv=none; b=Byf9U6wlfDPIJASkp8JL3oXA8Oo2afsfz/+IFjUlXMfpMqUZDE1s4gj+XOmJPz/1Bx3GOXXsLk2Sly1z5k81WruTGFx9qq6/gJTdkmZhaGg3yWpk6jIm9VslPLf9rXtW9SqZP4AnAqch1zbVvO9hXGIxm0tt9WSr/DMIFd2VzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786215; c=relaxed/simple;
	bh=eybNQXdLpYW5i4NVQlaeatFpoVaiFm2ZnZvyrdS1kq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+1wWml5pF1bKkmW52vQlsKr7JHSCfqJY1iuTq/MDMgIn5FMNC37zHD/vf1xKDcNOjbyciixre7t5ikHKY1/5Q08jvi3KcAO2r7Rwt4cglNSVZDIuM9kKYxFh2e1xAPMXdSRRuEM2SZfY+Ig5ZOEWwSALwIIRxBie1Pj4TZagVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHfalpA3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHfalpA3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso50075085e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727786212; x=1728391012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8XQ29Ev1z3ZNIlBXEVIBzyegIpbEqZs9xlXmgo7XMs=;
        b=RHfalpA3Xzj4Dm6mrIyb3MUhS1cFuW1kNn8jzrhbu+v+pL1ZZmZOuJNTehcymDlg5I
         o0Y1nJ9WFAzgXu/fS02bXezt30pSChNM+kMQtXiNnE9lbLHniOyUkLvKNSr3u+ZXDmY/
         uOhSWlY89Sld7m92HIJ8Ns1efbhfhpYGz9ULPbC9HZ/AYPaQ7NWasTOaYCA9h0UMuxkK
         AdwGtG7B99JqAr3LLZ4lJg9s+B9GxcPJC2odbCgLu8ztGrjhWKS9xADvfoBuFXCPhcaM
         yGhlBGqN6g1OHt5qFm3jeZKWtVvfCUuiJ/QzVfmXF5cXCTfrX6xidj6tgJsCSjP2JvNR
         ClhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786212; x=1728391012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8XQ29Ev1z3ZNIlBXEVIBzyegIpbEqZs9xlXmgo7XMs=;
        b=HF6bB1KuouChcc4JVha11dHaiSESVvjen7fWWRZvwRuPPouCSvD6V4O/8oTyI5n+9U
         pPwrQOoN+dqalNJFzoXhhBMG67ZLM/MKz/kQGI4dE/ZtGDs0fW8meb9gkXXClDSMj8CN
         wC8taBRaHCgoK76QxycwT0TEt6EzJ6cH9qGid9KLbXyXidcaFdLoZPeBzlaENNj6GNia
         6jH8jV+IUSYq3vICCEZtOtQy3V3vlWoonwSoOrR/DH6zfgSFn3UdPGNzkbtQvsrGl5ZE
         OxvOb/ENs7QkjYg8m1QJKImwyONOtu9MEevNQrCtWg6Mp+bwRDaZxOXq5d+2YMUfnQzO
         LY+A==
X-Gm-Message-State: AOJu0YyB9uFIx+Cg4zTWD1nE/UsJQq81ILkMAxhwADPly4f3q/3KbrTj
	ItPXqNAOK4cleXWO9pYfL+l3oOsLIvPqgr40xK79k+59ziBxyZxNSCgKsP6xF77AwFrmsuATXDm
	Q0s8=
X-Google-Smtp-Source: AGHT+IFG7IXfEGF5ftViJBmZVAZL2Iklu38AJ+yFgyVeDQsg/kv1idzpQVLYVhL5YhLAcAFb2dd9KA==
X-Received: by 2002:a05:600c:a02:b0:42b:af52:2525 with SMTP id 5b1f17b1804b1-42f5844b396mr131572065e9.16.1727786212508;
        Tue, 01 Oct 2024 05:36:52 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36244sm180942325e9.38.2024.10.01.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:36:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf dwarf-aux: Fix build with !HAVE_DWARF_GETLOCATIONS_SUPPORT
Date: Tue,  1 Oct 2024 13:36:25 +0100
Message-Id: <20241001123625.1063153-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
which gets picked up in a lot of places. Without
HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
errno.h to fix the following build error:

  In file included from util/disasm.h:8,
                 from util/annotate.h:16,
                 from builtin-top.c:23:
  util/dwarf-aux.h: In function 'die_get_var_range':
  util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in this function)
    183 |  return -ENOTSUP;
        |          ^~~~~~~

Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback function to handle arch specific instruction tracking")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/dwarf-aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 336a3a183a78..bd7505812569 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -9,6 +9,7 @@
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
+#include <errno.h>
 
 struct strbuf;
 
-- 
2.34.1

