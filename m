Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F6305665
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016783; cv=none; b=oAkOKgRmHZeR1TNi8olkXMpEBwZuc8pitrVHqqSPbgQMOXnHJP7QEH7A486+EoKdDci3AW/UCwogb9FIUyWQ0kveBUrOUG44XSKpQr5gLvPDYu6cp3g1eyXIbUGQi9kOXzOi8kdyhmKlXglMQX77CijbLjEos128P8J/55CiZic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016783; c=relaxed/simple;
	bh=Ku2+3Vo5pKVfVZHaEFhlcphCSxUAfSt0t6l2RjQh0dM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VwgryCzBcxZnCoKUEA0VdcHVNuiYWms+G10tV3vEvlY1aN18a/xn1p7v2WeYEE38h0xN4UlR6Iyyg0EwlY+ITYbl1qMdMog3DTppYw2mbqnFTbzV6HR53qsVDIb0d9wKyu72omYpB6K7XeNJYLIxU8ugJjoq3TJzb6oaVRlo3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN8vsX1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN8vsX1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E931F00893;
	Tue,  9 Jun 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016782;
	bh=YHhm/nSeCqjfYGT6YwtInLbzSuSh6mWws55hDkgf7GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZN8vsX1ukaBVb8WX3yp90WHf9E7d19fbg+h1KXVV1sthxHs++mzIovTWFAyxah5pG
	 TXUvNUxMpuICuUhGXoemWuI/zDvFcRe4jg8kOLTwV4svzaobJowSFXC/f/nDemGAVZ
	 Kqqci3LfoXFZhJpmVjmFrGOCM7hxgTNsUqx5lGrvd2pBKaGggFb57W9SzIlDBUhw3Y
	 7+4EmPjlFE3UQXoH5j7cT1zBZL79sFsuL2UfcplSj9EPXe03fRxiVK3MLmpZ1EImZv
	 Amo64U1gutEn5CaK5X1JV6abS6ufiSEODGziuvoI/aB1gXbPI/ibb7KO9fIXwRMsJo
	 D3TpXTVd2UGfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/19] perf test cs-etm: Skip if not root
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-12-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-12-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:53:01 +0000
Message-Id: <20260609145301.D5E931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] A Time-of-Check to Time-of-Use (TOCTOU) race condition exists du=
e to an unsafe temporary file deletion and recreation pattern, allowing loc=
al attackers to modify arbitrary file timestamps or create empty files as r=
oot.
--

commit a4b1e28698440010ef2bccdf78c5fee8d8a1850d
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Skip if not root

This commit adds a root privilege check to the Arm CoreSight trace tests.
It ensures the tests are skipped gracefully with a clear message if the
user running them is not root, as root access is required for certain
testing modes.

> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/te=
sts/shell/test_arm_coresight.sh
> index 39553702c1f31..8ed2c934c87d0 100755
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
This is a pre-existing issue, but by enforcing that this script must run
as root, does this turn an existing race condition into a local privilege
escalation or denial-of-service vector?

Can we fix the temporary file handling here? Currently, the script securely
creates a temporary file but later deletes and recreates it:

tools/perf/tests/shell/test_arm_coresight.sh:record_touch_file() {
    ...
	rm -f $file
	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
		-- taskset -c $2 touch $file > /dev/null 2>&1
}

Since the file is securely created in the world-writable /tmp directory via
mktemp, the rm -f frees the predictable name. An attacker monitoring /tmp
can race to create a symlink at this path after the deletion but before the
root user executes touch.

Would this allow an attacker to modify arbitrary file timestamps or create
empty files as root?

>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  file=3D$(mktemp /tmp/temporary_file.XXXXX)
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D12
