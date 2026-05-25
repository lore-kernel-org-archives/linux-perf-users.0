Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2513F0773;
	Mon, 25 May 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723669; cv=none; b=eOUnKB9yW18bNdctel99sJgRuMu9MqnlIA45qkZV8WXUauRJC7gmDE+fvdlA7wDClaY4IdkLVDDWLsQmDzY5PVUTVHAHy/wyM4IGFez//ZNLeomk6CCEVZGjyeXx2leMcvoP3HxzMK/+PTCdIpOCuiyOizK7Wx8uYOa2MUIbaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723669; c=relaxed/simple;
	bh=aRDUkzDvPosd0hc9HVo8AihmClV6bMYls1nTE38u3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txQjmsek5Zt8HOYSzAGyA6xNSmjdrmDJQPUq9krXVbLtqut9DxgIpM67n+7FUrE/oVJn9BuiNeLVw07et+nQpRCYpABrBC3wC23bdqgfe9tD4zqI05GH3LO4ZCmiou16F/Dd/lzjTW51AkC/aNmSjIa/zC6XowptXu7bly1ZI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHi9Qs7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHi9Qs7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD00D1F000E9;
	Mon, 25 May 2026 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723667;
	bh=VrQ0Fau464UE87C8hBjXNZ+GXwezIWrTThVUCQ39xMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iHi9Qs7Tf1enK+/ke6fo3jtIGgati51Awm0uBd952pP7kdWRGdmByTcEIle9OVZCu
	 Qt9TcDN+SUB0RWtDNMj8QiKOXNdt/9NqWKu13fqAc7M0tJGYpRDCrGv+7T7yIRtSzZ
	 Hevz6falnToHmRdEfrRiuJlKixXOrBCMYmxVt9A8hnyxZxuvAAlrua0Yr2YA25cwOM
	 gYznr+fN3OEze/H/p+dedc4TAw6L/vf/0aSV566IwkIy3OURH8bLDKHVraripLwGfX
	 VdfyVj2i5dnaH2fuTxyueiYACRwuAzU+Zc9iaAkHc9aRwdWnhkRHEEw7ycd7Vqm/Xu
	 ndKCQpPNCTziw==
Date: Mon, 25 May 2026 12:41:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 29/29] perf test: Add truncated perf.data robustness test
Message-ID: <ahRtkPbduiIsj0Z-@x1>
References: <20260525010550.1100375-30-acme@kernel.org>
 <20260525020422.EAE1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525020422.EAE1C1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 02:04:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Unchecked `mktemp` failures lead to unintended file deletions and false positive test results.
> - [Low] The use of `dd bs=1` forces an excessive number of 1-byte system calls, causing unnecessary performance degradation.

Addressed with:

diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests/shell/data_validation.sh
index 36b3ba508e4f2753..5c3e6fced6fce0cb 100755
--- a/tools/perf/tests/shell/data_validation.sh
+++ b/tools/perf/tests/shell/data_validation.sh
@@ -14,9 +14,9 @@ cleanup() {
 trap 'cleanup; exit 1' TERM INT
 trap cleanup EXIT
 
-perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
-truncated=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
-stderrfile=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
+truncated=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
+stderrfile=$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2
 
 # Record a simple workload
 if ! perf record -o "${perfdata}" -- perf test -w noploop 2>/dev/null; then
@@ -42,7 +42,7 @@ for cut_at in 8 64 256 $((file_size * 3 / 4)); do
        if [ "${cut_at}" -ge "${file_size}" ]; then
                continue
        fi
-       dd if="${perfdata}" of="${truncated}" bs=1 count="${cut_at}" 2>/dev/null
+       dd if="${perfdata}" of="${truncated}" bs="${cut_at}" count=1 2>/dev/null
 
        # perf report should exit with an error, not crash.
        # Capture stderr to detect sanitizer violations.
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 351369ac4dc2c0a2..5b1fa1653d2a48cc 100644
