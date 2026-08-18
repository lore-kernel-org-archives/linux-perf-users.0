Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A23822A1
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094606; cv=none; b=uJXtLq5GTWmrrvqp6o7OkuVw1EYgdWfeWJfiMfqvxquMIPtWMqiTgL/Im8JBZ14HOX3LR5v7tOq2HTw3Z4H5KXIpnFpxXYErSTLEu1sThVWYd5ia8S5dLEBfCsrBxhMPk8+Eokd5eGibWxwrMWGb5ubR+cz5ZcGrqFsCGKw5HXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094606; c=relaxed/simple;
	bh=hUxFAcGzvPoQ6sHKONlKPImxYadC3CiwzBYIhZr3yFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8AeuVQZG3MK0+dxP3bbDUi8B2pUMs6FK2/kDr6PxiKF1CV6K5Whft5rYTc+cQXnB2aGwDAsoYCqkVM2XxGbc8CzMpPIqIc5NjuofRCRwG835WwG37+1LREGb/g+qSV2BAZff3CQAkhiK/u1I91RSMKX2X+9Ia8Qf8Q1uQ7PgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS2NEa2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS2NEa2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9191F000E9;
	Tue, 18 Aug 2026 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787094604;
	bh=l4tk8S7LDU8F7XnPCJPoK09EJs+Rho8Z5aSA7ic+6gM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OS2NEa2UfMVXTfX11roWlo4yLkfGNNUTGcAzi+vgsiEK44kFvTh5jA2hhnKVzszeV
	 qMrxaZ+HtGE+SrpxamrjBaLgifoOnb+5jv3B/GudSFMloItfSv8E/VDiquWBUOlmYz
	 lrqNy5fJL14z7KhAQygzbrc2P9hseQOTIVGxXFL3sn7ysZSu1PXGiyqX8SFOrZ3zrJ
	 3p9dUGYjmqQ/ekwAc5i7OjeiIoXEs9AE9mxv6QEbMUeExOvCNrnTIHQCoTNxNRDMci
	 fZ2PRNPWzR7cB0kXl0/qouRIE/ooZT5wqyylcwnGs7FNWmBAauUk2VuShasE36t+SH
	 AsBff3v1Ti49Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] perf tools: Add test for weight annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818230229.1491871-5-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
 <20260818230229.1491871-5-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:10:03 +0000
Message-Id: <20260818231004.2B9191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent failures on intermediate commands cause test logs to be d=
eleted without error output.
--

--- Patch [4]: [PATCH v4 4/4] perf tools: Add test for weight annotation ---
commit fa7661757e0ece36caeb06128442cf38d097b4dd
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add test for weight annotation

This commit adds a shell script test case to verify if the --stdio weight
annotation functions correctly.

> diff --git a/tools/perf/tests/shell/annotate_weight.sh b/tools/perf/tests=
/shell/annotate_weight.sh
> new file mode 100755
> index 0000000000000..6b8c105c048b5
> --- /dev/null
> +++ b/tools/perf/tests/shell/annotate_weight.sh

[ ... ]

> +if ! awk '$1 ~ /^[0-9]/ && ($1 + 0) > 0 { found =3D 1 } END { exit !foun=
d }' \
> +	"${report_out}"; then
> +	echo "[SKIP] PEBS weight sampling produced no nonzero weights"
> +	exit 2
> +fi
> +
> +perf annotate --stdio -i "${perfdata}" --symbol "${testsym}" \
> +	> "${annotate_out}" 2> "${record_log}"
> +
> +grep -q 'Percent Weight' "${annotate_out}"

[Severity: Medium]
Because the script runs under set -e, will a failure in perf annotate or
grep cause the script to exit immediately and trigger the cleanup trap?

If the script aborts here, it appears it will delete the log files without
printing any error output, which might mask the failure reason and make
debugging difficult.

> +
> +# The second numeric column is the rendered average weight. This asserti=
on
> +# fails on the original regression because calc_percent() left it at zer=
o.
> +if ! awk '$1 ~ /^[0-9]/ && $2 ~ /^[0-9]/ && ($2 + 0) > 0 { found =3D 1 }=
 END { exit !found }' \
> +	"${annotate_out}"; then
> +	echo "Annotation output contained no nonzero weight"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818230229.1491=
871-1-ak@linux.intel.com?part=3D4
