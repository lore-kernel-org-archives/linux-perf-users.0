Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201EA16D33F;
	Tue,  7 May 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091210; cv=none; b=Dw4pKPJ4l+r9xjCtHduNBzu241IrbY48vZsO2/sYMqU54/L5X/ZdxAqBnnG22hcpIR+XnDAbyxCQPXPWt+3l3KBEMF6Tn29DknVoy15PV52LOFRL9wTRWy7/hyySslE3hjKL+Tf7UvTGvZvhKjiKgwioPEako3HnxkSdnQ1Jqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091210; c=relaxed/simple;
	bh=inoTy0XjeXCVYFWYhXWKSmRMDG/2+bgKHRzwgIGvl9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duOZBVqt5uDD2GQckRnqVFmuRDZujORD09WVQkXRR6SR+0Rhv1q0fs8mgXRJSivYWFQy9cRRQOJXsxgTsnqrC7OIqzhlTvmTOuvXrWWjLuvNK0z/kN9m2/RU+jsVnZg9otd6/fYV6ziIVXEJv0cjXod8Uo7BGOFteaHThdYamVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6BF153B;
	Tue,  7 May 2024 07:13:37 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D7BF3F6A8;
	Tue,  7 May 2024 07:13:09 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	atrajeev@linux.vnet.ibm.com,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf symbols: Fix ownership of string in dso__load_vmlinux()
Date: Tue,  7 May 2024 15:12:08 +0100
Message-Id: <20240507141210.195939-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507141210.195939-1-james.clark@arm.com>
References: <20240507141210.195939-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linked commit updated dso__load_vmlinux() to call
dso__set_long_name() before loading the symbols. Loading the symbols may
not succeed but dso__set_long_name() takes ownership of the string. The
two callers of this function free the string themselves on failure
cases, resulting in the following error:

  $ perf record -- ls
  $ perf report

  free(): double free detected in tcache 2

Fix it by always taking ownership of the string, even on failure. This
means the string is either freed at the very first early exit condition,
or later when the dso is deleted or the long name is replaced. Now no
special return value is needed to signify that the caller needs to
free the string.

Fixes: e59fea47f83e ("perf symbols: Fix DSO kernel load and symbol process to correctly map DSO to its long_name, type and adjust_symbols")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/symbol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e98dfe766da3..6a0900dcdfd3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1977,6 +1977,10 @@ int dso__load(struct dso *dso, struct map *map)
 	return ret;
 }
 
+/*
+ * Always takes ownership of vmlinux when vmlinux_allocated == true, even if
+ * it returns an error.
+ */
 int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated)
 {
@@ -1995,8 +1999,11 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 	else
 		symtab_type = DSO_BINARY_TYPE__VMLINUX;
 
-	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
+	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type)) {
+		if (vmlinux_allocated)
+			free((char *) vmlinux);
 		return -1;
+	}
 
 	/*
 	 * dso__load_sym() may copy 'dso' which will result in the copies having
@@ -2039,7 +2046,6 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
 			goto out;
-		free(filename);
 	}
 out:
 	return err;
@@ -2191,7 +2197,6 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
 			return err;
-		free(filename);
 	}
 
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
-- 
2.34.1

