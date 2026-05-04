Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD62C08A8;
	Mon,  4 May 2026 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777876090; cv=none; b=QHrT5AfQ++M9nnm7gJdeAEOxwQ7hftSfVQcrO5/3xocrFsgRnopX5xDr1Tplo6FfbuGSTOUBxzEB5nN2bVJYNAGn7oaxFF0mNKMASy2H7kaJeqbwnmDrxO3KgEB5XZkJclwek9+WgbXdDcjfLZ61IQ36ug2leMIDB1JcRJ8/qZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777876090; c=relaxed/simple;
	bh=Z5RAWhE5vW2yumhtVaXsNGNbbG5QXnPn8xVlw/KdtNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBpf9lfWVZ33ITOBbdkAfPEKHJwQW7rTM7TDiABwIbRcow52JPDl28ePUZsZhC5JtS76omicKHtDwIMs8eJg6Et/j8YMoc6uI0fkFlzPJGEPuErsl4bmz+hw+V0qcl9Tu4Ma8xqpy49wuBijNla6FUQbi1TOZmr0jydiBUJQA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY4MQHj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY4MQHj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532CC2BCC9;
	Mon,  4 May 2026 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777876090;
	bh=Z5RAWhE5vW2yumhtVaXsNGNbbG5QXnPn8xVlw/KdtNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DY4MQHj+kj8ozRAkfKxIgVhvPckOu1vXPFyB/jV+C2qMy3L2KBWIAT3sa4a5edlnV
	 BxT74EhDX91pdwaz7re9S0CfPUdpQ06385GWvzznq0mesj+61RYBeKyXu5XjaqdNIY
	 S5CLtPB6M96q87XwNBp7a4/tM1aRa4ni51jiVFNLyuXIMRo2CsRhky1ia55wqXtUcO
	 npBOnHhzIC07d0wZbufweidnjGCirZ+aZFxiS/NDbGvSVXS6so94Z/1CrN1sBDyE1c
	 8IsGXvMXN1RJgVPRrD78oHmE/P9oz0lttO2VhLhUx0TdRxLwhcRdZrdxuN/Wmqw/Q1
	 AEQ1vDvuIeZPA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/3] perf build: Remove NO_GTK2 build test
Date: Sun,  3 May 2026 23:27:58 -0700
Message-ID: <20260504062758.92001-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504062758.92001-1-namhyung@kernel.org>
References: <20260504062758.92001-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4751bddd3f983af2 ("perf tools: Make GTK2 support opt-in") changed GTK2
build as opt-in.  So NO_GTK2 is meaningless and we need to pass GTK2=1
to enable it.  Let's update the build-test configuration for that.

Also make_no_ui is the same as make_no_slang since NO_GTK2 is no-op.
Let's get rid of it as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) new submission

 tools/perf/tests/make | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6587dc326d1b272e..dbd7c86a2dccba6c 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -78,8 +78,6 @@ make_libperl        := LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1
 make_no_slang       := NO_SLANG=1
-make_no_gtk2        := NO_GTK2=1
-make_no_ui          := NO_SLANG=1 NO_GTK2=1
 make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
 make_no_libdw       := NO_LIBDW=1
@@ -118,7 +116,7 @@ make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
 
 # all the NO_* variable combined
-make_minimal        := NO_LIBPYTHON=1 NO_GTK2=1
+make_minimal        := NO_LIBPYTHON=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
 make_minimal        += NO_LIBBPF=1
@@ -153,8 +151,6 @@ run += make_libperl
 run += make_no_libpython
 run += make_no_scripts
 run += make_no_slang
-run += make_no_gtk2
-run += make_no_ui
 run += make_no_demangle
 run += make_no_libelf
 run += make_no_libdw
-- 
2.53.0

