Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE84A0C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484404; cv=none; b=TaBdnUA8I/A8RWMV9arn5bQGyH7lsJ5InGHf/oiKKqJQsgzB5oJqGtZtxD+XpIzVSNVu0Vs40Gwcdk0EWgndUYniqDre14MLW9YmT4jWVP2YyoX4N7hilvEgT+j1VD7fE63W6SY5HnWvaNADGrvAIJC4kbs8PIB58EV9XGOpiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484404; c=relaxed/simple;
	bh=aFmh/MsLSh5wCxM2pAvw5ny9JLcIVbVEpcLvM5PVaIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CMVYYxLFPUUvE/yoRc0ZaL4URsbcuLFgpk7D9xwejjELIQXOdgbXNpVDed8L/vilhZDeFHpflnGSn/rDTg1ghcYdJy3Wz9KXaZxcKjkW+xACjMpWMfjeX/OR21m35tAso4xFE2pPXaQn3ilCItU1huUQKCRQvhTeN+llXWSL4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbxqMKIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbxqMKIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ECC1F000E9;
	Mon, 15 Jun 2026 00:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484403;
	bh=XIFiMRpIVz81b/jS1BtCdfoBVGQCoxvq6fzkudTRT1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbxqMKIyEaQX4G7E5JWUEU5M3gPEkx8+IT+GVw/yq4HBzNch2uZF8HChDcBEUICK6
	 FSzMBwMAnzCrRdoe8nbCJhCwbcL8SHPtc6jwvkzpqTZ8ZK4AoEGPvtTSXfLDoBfxHd
	 eUPK34IXR0vL/e35+tXQ9AkrH2PtfaXce4i0cxufb/H55UnFFAMFo+9rc/jo74KNpj
	 HrbrdZOdAEYEX1QYCQrV4AcQiu3nuk540dPW4tcnx+F1E42rirPvQEoOK2uLwkXNsV
	 EhL4U98giyXkgtXX1P3faFdFafh4EFACPIjnecfKcflOZFWiG6Yu+M0KEXHk9M8U80
	 PBWTYztkX5A7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 16/20] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-17-irogers@google.com>
References: <20260615002812.2234795-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:46:42 +0000
Message-Id: <20260615004643.03ECC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete feature implementation and commit message mismatch: T=
he commit adds the `perf.syscall_name` Python API and explicitly states its=
 purpose is to avoid the `libaudit` dependency required by `tools/perf/scri=
pts/python/syscall-counts.py`. However, neither the script nor its backend =
utility `Util.py` are actually updated to use the new API, either in this c=
ommit or later in the patch series, leaving them dependent on `libaudit`.
--

commit 34710bf51b221ed73f9e2461f04bd4f55e7be47f
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds syscall_name and syscall_id functions to the perf Python
API using the internal syscalltbl support.

> perf python: Add syscall name/id to convert syscall number and name
>
> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
The commit message indicates this avoids the libaudit support required by
syscall-counts.py, but are there missing changes in this patch?=20

Looking at the script, it is not updated to use the new perf API and
continues to call the old syscall_name() implementation:

tools/perf/scripts/python/syscall-counts.py:print_syscall_totals() {
    ...
    print("%-40s  %10d" % (syscall_name(id), val))
    ...
}

This old implementation still depends on libaudit in the utility backend:

tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py:syscall_na=
me() {
    ...
    return audit.audit_syscall_to_name(id, machine_id)
}

Should syscall-counts.py and Util.py be updated to use perf.syscall_name()
so the libaudit dependency is actually avoided as described?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D16
