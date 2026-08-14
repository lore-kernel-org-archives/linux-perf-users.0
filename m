Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED490395AF6
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672247; cv=none; b=BzX97QaP4Fg+8L21PqSQnTC0dcpmPdQJ02KENxonVtsQuTLKDDs7hehu2Z2YSV5vXPjxqa/+QDh4ujMRR+oe8nKbQIVrZvfrW6JBX7XdcrAbt6at3CcOqoyuwZ8F71tY20nXLCG1EJRL8WewaW+Q7x5Yapty1/qFUm0KJf8y7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672247; c=relaxed/simple;
	bh=GIvQHnZj78xYtLc/iPaVMVVUxLNBh09H56Z0z/ZID/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VHSv3OLiAAOQDcePVW0DUpm2zVlQTYBRNYt9cFRoxY6XAth/Hvl7eQ/AKz1axBqiLPM4FS0XmC5gXCOenZN2IqOsUlkwYShwyjINVyAuNMxG3+dYbciF6Jj4QYt7p4oSVyba7KxQOHiPdXFjh+Ic4oBD1WtSEGxSr8MrQD1MD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BleIRbQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BleIRbQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D5C1F000E9;
	Fri, 14 Aug 2026 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672245;
	bh=UwCckznx2kBfs39C3l0RbeNYZLDFFUW44JGYM1ZepWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BleIRbQCiJTUxjps5/vX7CZ+FchEhG6LG0Btjr80bf+3JnpkJCATVoRPE+owH5qnw
	 WLkBs23/houf8t7sV+1vEH4frgsEtCvXFH/VLKHqLbumC8qd9vSlzptbz7cfB0dBVA
	 aovqF3Hcr7BQI73j7eRIZ/ovwHyN5bVMNAKZvdOJL9Fg0bCHAv6nKsUH+2yalB20YX
	 v6Kon0MPjhTGIR9Vr2KeAzcur2GO1DT2IQ4Mh9RebsAb8dGLLnDPl8mythQVZmnmpf
	 eLq/66XkgYMKO9TuvgjhbBCmqWMW8ZGC2U3GHDNfTx0dDWYb9hELawNYrsqVBEzhSG
	 a2djVhhxrI78w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] perf tools: Add test for weight annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813214143.253418-5-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
 <20260813214143.253418-5-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:50:44 +0000
Message-Id: <20260814015045.04D5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Brittle and silent test assertion due to unisolated `PERF_CONFIG=
` environment.
--

--- Patch [4]: [PATCH v3 4/4] perf tools: Add test for weight annotation ---
commit ae0853531b9364f64586279c41d3ca0652fe3e71
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add test for weight annotation

This commit adds a new shell test case to verify that --stdio weight
annotation works correctly. It uses perf record to capture a precise PEBS
event and then tests the perf report and perf annotate tools.

> diff --git a/tools/perf/tests/shell/annotate_weight.sh b/tools/perf/tests=
/shell/annotate_weight.sh
> new file mode 100755
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_weight.sh

[ ... ]

> +perf annotate --stdio -i "${perfdata}" --symbol "${testsym}" \
> +	> "${annotate_out}" 2> "${record_log}"
> +
> +grep -q 'Percent Weight' "${annotate_out}"

[Severity: Medium]
Will this test fail silently for users with a customized ~/.perfconfig?

Because set -e is active at the top of the script, if a user has settings
like annotate.show_nr_samples=3Dtrue or annotate.show_total_period=3Dtrue,
perf annotate might change the column header from "Percent Weight" to
something like "Samples Weight" or "Period Weight".

This would cause this standalone grep command to fail and immediately
terminate the test without providing any diagnostics. Does this test need to
run in an isolated environment or parse the output more flexibly?

> +
> +# The second numeric column is the rendered average weight. This asserti=
on
> +# fails on the original regression because calc_percent() left it at zer=
o.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813214143.2534=
18-1-ak@linux.intel.com?part=3D4
