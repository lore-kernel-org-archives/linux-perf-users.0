Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98443CAA59
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412722; cv=none; b=A9kEB0RjZGI0fEzBbA2EFaZoBcDRC/AGbTw3iakdtJ241L6nZIe6bpBErzdG0ARgqOp5kvMJ9q+t6Wm1M25fD/oegVhsknTCSGH1O19BorueiMS+6DOkFm9ILNrb5phlEblB25PDa0nmNkft30TEmo96wjWeyUl8ATU6pI3d8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412722; c=relaxed/simple;
	bh=4O2Lze7yUBO2zJJ5j+F1wuqNTwYxRtll/C64eUgBaXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nk1ndX/PFJHM6AUCZ1RuAW8MnXNdGVoCz3oK1QX8qNkHG1pgyVg0BhmRUX4RF4LB+4x00RY1+jywR781ttCXMudXlhYFWCvpyHWbhoL/kKneb3wvTn5cBSOsY79W3saZArABjsDzkIq7umDMxke5eJfE1UJja0f6x1+pDs9vsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJf7c/zB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJf7c/zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772021F00893;
	Tue,  2 Jun 2026 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412719;
	bh=SFK0drLxYdKi488BrFgWK1JmM3QoZz7em8uZ3NqHYo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJf7c/zB8BFLNX/qPsjj+49YrHV0bZSLH8qtGQDqAipVLks47dJOQoXAF4xRWY5Ps
	 ZFf8vmAtSFYlUZrE0THqm5Ye0XLgGzAvAJP9eMhF7JyFJ/qF/goz45TCm81wdZMlIk
	 0KTPpTAXZdpLYC2Uy5B6stbqIA3JCtZuwEktI9Y4jdYPfVGtVVppGclfTIOx1nVH9J
	 M0FzBni8ZPdNOD2viAKfqSAE5Or1ZF2OJnbEEfltT/bO/PGj3h+A5MCYKbAKYWXJ8v
	 TEaPoagZC0AUdp0oEsESV54wdsj62qQbiPXn/1iWbKnP+yAG7IDWhbYXGZZ/CAI5KO
	 L1oYSlgEwF1EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/18] perf test cs-etm: Remove duplicate branch
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-11-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-11-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:05:18 +0000
Message-Id: <20260602150519.772021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Undocumented global root check inappropriately skips the entire =
test suite for non-root users.
--

commit e286213d8a9568ef4b5ffeadc05f64626a70b603
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Remove duplicate branch tests

This commit removes duplicate branch tests in perf script and perf report
modes for the Coresight ETM tests to improve test execution speed. It also
removes the perf report test from system-wide mode due to its large runtime
impact.

> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/te=
sts/shell/test_arm_coresight.sh
> index bbf89e944e7b1..8ed2c934c87d0 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -20,6 +20,12 @@ skip_if_no_cs_etm_event() {
> =20
>  skip_if_no_cs_etm_event || exit 2
> =20
> +if [ "$(id -u)" !=3D 0 ]; then
> +	# Requires root for -C and system wide tests
> +	echo "[Skip] No root permission"
> +	exit 2
> +fi
> +

[Severity: Medium]
The commit message states the patch's purpose is to remove duplicate branch
tests for a speedup, but this adds a new top-level check that skips the
entire test suite for non-root users. Is this intentional?

Relying strictly on UID=3D0 ignores modern capability-based access such as
CAP_PERFMON or CAP_SYS_ADMIN, as well as permissive sysctls like
kernel.perf_event_paranoid=3D-1.

Could this also unnecessarily bypass per-thread trace tests later in the
script that do not require system-wide privileges?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D11
