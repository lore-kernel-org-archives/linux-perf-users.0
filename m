Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551721FF39;
	Mon,  8 Sep 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364874; cv=none; b=FnSX2A5sh671cGFMNZ3ZZhT7MH9XRAwpqPRBbOcE4/UxmY/F7QfjMZLR9qZzGBMyWx96nrdXi6KfwPQSaPNQOCXH7kSa7B7DO7qHKZPOB5bbzglbh4On/5p5zgqXVppve0gdod6+oLf360PSGnCQC+Ik+7qPIKWLXHgvrAuEXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364874; c=relaxed/simple;
	bh=U3K50tXK+wACLTvtmTJZSIqUvpPt9aIhT02/EuzFOl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IM3BszaCAOVdg1OsLmvhreGvEnmnVu9ILCdUgUqc0BHHh19sylmxkCjTFLCLnJGjtf1uceDVduCrUFAcW9dcSN+KwULz5fqZqoA7MpIPoLzl5KxeCvXHZ3fWkzNTKj+ANlkt3iV8oBVdJIstsRlVboWygMoBvFicoaJZgPjqrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjdyFi7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjdyFi7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE4C4CEF1;
	Mon,  8 Sep 2025 20:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757364874;
	bh=U3K50tXK+wACLTvtmTJZSIqUvpPt9aIhT02/EuzFOl8=;
	h=Date:From:To:Cc:Subject:From;
	b=sjdyFi7gLY9eb6hARVmhiBIqYckA4mFUbcqaf6abcWWpCTfUB1uc7RWVtVjaDJ6J9
	 TuEN/9efh09Ko06dKsjf/J9gHsdKfj/IMsaEKNhJAhOnjW4WO09FFgO25LQhj/pkI7
	 ZdgQEh9rqbpryAFH42skoAqpC0I5R6u3lUoiMsb9KJWj4RO6041D57+Aef3LJC8kr6
	 cxrfhcIbn369v9iXvgRqvVkV2+7PuSGXN9VhJwp1drtLhbs4g+TdnbnIxPBRNzVaC4
	 rGqv4UrRF3N8vsBhL/ocMeMJBM2ar0Y3EbR7oJqlbE9v76bljj6325/V9+sTNoZMRl
	 Qc5LwEWUFKWOQ==
Date: Mon, 8 Sep 2025 17:54:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
Message-ID: <aL9Ch_XaYTxMzFXK@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I started seeing this in recent Fedora 42 kernels:

  # uname -a
  Linux number 6.16.3-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Aug 23 17:02:17 UTC 2025 x86_64 GNU/Linux
  #
  # perf test vmlinux
    1: vmlinux symtab matches kallsyms                  : FAILED!
  #

Rust is enabled and these were the symbols causing the above failure,
i.e. found in vmlinux but not in /proc/kallsyms:

  $ grep -w N /proc/kallsyms
  0000000000000000 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
  0000000000000000 N _RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
  $

So accept those 'N' symbols as well.

About them, from 'man nm':

           "N" The symbol is a debugging symbol.

           "n" The symbol is in a non-data, non-code, non-debug read-only section.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3fed54de54016227..3d04382687d17d22 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -107,9 +107,14 @@ static enum dso_binary_type binary_type_symtab[] = {
 static bool symbol_type__filter(char __symbol_type)
 {
 	// Since 'U' == undefined and 'u' == unique global symbol, we can't use toupper there
+	// 'N' is for debugging symbols, 'n' is a non-data, non-code, non-debug read-only section.
+	// According to 'man nm'.
+	// 'N' first seen in:
+	// ffffffff9b35d130 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
+	// a seemingly Rust mangled name
 	char symbol_type = toupper(__symbol_type);
 	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B' ||
-	       __symbol_type == 'u' || __symbol_type == 'l';
+	       __symbol_type == 'u' || __symbol_type == 'l' || __symbol_type == 'N';
 }
 
 static int prefix_underscores_count(const char *str)
-- 
2.51.0

