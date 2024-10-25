Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E9217452
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877004; cv=none; b=HwbbfcGJqXdQvmWPQGqNleYUM16Lj87Rcn7/d6lB6kG0lLPvsbELC9bFmbywx5mgFsqG6FmK8vMzykoxQBJXmASB9YzySh8WuT7QA/hditASo3J+2IkpxlSngdmfarCk7JWptsgwtWXLWDb+viOO9Zp4p8ppw2AT2mb6R+ib99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877004; c=relaxed/simple;
	bh=f6QE0Qn9b12eCjBKI2V7KW/KAZe5l2VYiK5SexO5YnY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OIJCwaTJUY6/wvQZdQO5X58CXe8RHYA3ko6viSqalEYzOvpEiT+cAQr57RgwWkGXKW31BZdaee1Gef57sd7v0KXIaRwCoMsc2oTL7m6kjSC91OPnM9pXxDRbft7OeYwfHc/kybP9nXPolcF7vRvLOIBdPhdy/KHQbSntCdjE2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXMIeMnM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXMIeMnM"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e315a5b199so42357177b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729877001; x=1730481801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbqflGTx7CldhGCbP/KKXIEFYVyDlX4onDQk9rCC00w=;
        b=oXMIeMnMD10XQtgHxr3wT7uDSV2bIRBQgGkgjWcwpyzQcLvTFRXhOS3d1w24K91Yjz
         sN2Y6K1Hj9nmKpZglcwOu9zOUt3jZ+8huExmNyMzHaOu27THZ8fRLx7ItZdCSlsTyiV2
         0DS0aCkyPgWcCupNxuDm1tpGPzlCOEQwVHz7dnKXx7k0DqyF/ijJQlJboE1o7IXX0y7k
         xU8NEkNPHjsqGvaHlOyLAdJfxoSrcxWPIvRgMK3n/kA3cVLFvxFVK7yeNJZ49/EXDAiJ
         TbYkUlhknbgjlCzqTBQ6K+y6jWqMUQ7AZpRaVgiqsmoy03opZwYZzA1mweYApU6AQ5iB
         N9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877001; x=1730481801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbqflGTx7CldhGCbP/KKXIEFYVyDlX4onDQk9rCC00w=;
        b=tiBAiPRCqmj82RYUet+LP8/7nN8bM8vwDdAQ6IyI/CJpMz830ABDOnpsha9gHgr+lz
         1mDUMNlCGocx9i9VyxxUTk/jDvpFs3a3kjz0htFTF+fMcTzpfkHyQOe2PwYsm7G/LUtY
         PnhrkApPKvN5mYnCmsaMkods0503ANOtOPesoZakjduJUg/5nlbh72azEyymvZjtNtk5
         nA8YZmXJJH9R30/oBu2hEd0g/jKWlafZ8YgnMRLnkNLmhK1uz0L991p1f51ZJgUhPoSW
         9qj7wsPFiTocvMu/kZCl2VVPRekSjus/nntMSzK98sZOM3NCNu5J5ER7+LpycU+tGyIQ
         /PJA==
X-Forwarded-Encrypted: i=1; AJvYcCW5VnXy2K0dkHiSLmHY/rjhlsrpaa8kg5oERFUtdgzoSJwO45IkXt+3qQIKsWRiBbLHv5/p+PG3yaa48K6rKMVG@vger.kernel.org
X-Gm-Message-State: AOJu0YzMw/0BcGbwTjUUh7KoNDC853ob+oN6mduykJu0TrGYNivEhkgw
	LzLzKNkLphO+ebOREuN42BKhGMzhx33+wzv1GDydRqxW+taAlSifD4R1+Dhyoujtwjoc1DKUTXc
	vsS+9sg==
X-Google-Smtp-Source: AGHT+IGANBTbxP9uqUtLEAG/z+bqH1Yapu9/gBtTn5hF7Sva9IgdS4fCS7fa0s1vcAX4O9hvRjxKwcj7Zh58
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a25:6b11:0:b0:e2e:2fe8:2d0b with SMTP id
 3f1490d57ef6-e3087b69f72mr177276.5.1729877001252; Fri, 25 Oct 2024 10:23:21
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:23:03 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 6/6] perf python: Fix setup.py mypy errors
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

getenv may return None, so assert it isn't None for CC and srctree
environmental variables required for the script.
Disable an optional warning related to Popen.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 649550e9b7aa..dd289d15acfd 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -3,6 +3,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 cc = getenv("CC")
+assert cc, "Environment variable CC not set"
 
 # Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
 cc_tokens = cc.split()
@@ -12,8 +13,13 @@ if len(cc_tokens) > 1:
 else:
     cc_options = ""
 
+# ignore optional stderr could be None as it is set to PIPE to avoid that.
+# mypy: disable-error-code="union-attr"
 cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
-src_feature_tests  = getenv('srctree') + '/tools/build/feature'
+
+srctree = getenv('srctree')
+assert srctree, "Environment variable srctree, for the Linux sources, not set"
+src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
     cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
@@ -71,7 +77,7 @@ else:
 # The python headers have mixed code with declarations (decls after asserts, for instance)
 cflags += [ "-Wno-declaration-after-statement" ]
 
-src_perf  = getenv('srctree') + '/tools/perf'
+src_perf  = f'{srctree}/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 
-- 
2.47.0.163.g1226f6d8fa-goog

