Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304938239F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759476; cv=none; b=ClcNhYEBjKuB7Eld+rEpgns6GGERzCXO/DW+aqqWM2EtAu/UeIbGdQ/7vn4lc4ho1lPv49dN46EahzQnRAMDu6CWO1GmGW5Fldvqz476J29V4KXAR/N1oxQBQ9L9w41F4kkCugRGXAM7Jwgne4OGrGsMwT8JM5usUljgcTuet8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759476; c=relaxed/simple;
	bh=rYwpvk9jW69psfYE6J7z892bhGQtF8PrvF1PrK2uT+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFmqSUqIX7JCGisht8GOVY3DR53ia+CdroLk4Au5ryqSjxt/ZZ+kXMFlfs4wVPEv+LTNjYYF58iJP14rM+NfT0vHqITShMBA3CjBhf9f97HYNxFusv/zTrEXhBTJBaX8jTn8I/QhoRmDdwmCN2mlFLh3z7Z8bulrsUjIiO13tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS6IsMNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS6IsMNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1461F000E9;
	Mon,  3 Aug 2026 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759474;
	bh=jZ4Lqaf91yDZi0DrN8Br37yjA8hLq4WObL2TrZn7l78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KS6IsMNG4P/sGR5hahdaRuXxmM4Z7iWw4vB+3qXslayrG2ORX0hoIRskAq+uHTUa5
	 B1k3XKQsCj8ClLZurbLl/xfNFaTsPKMCwgL9AcaSqjAXsXCX+lRygN4joWo4tZPAmv
	 o7ICEmTfauQ++03hQQDB4LYiVdoNiYRTuinFZrHN3r5VjXHnkTOxB8cCtCECZT0RdG
	 o9QCUjK8Be0NkujWMT6/Emn5KPraguhbVjsGPDkrx+hrVtgHZAcd7R/PrYrQ0beFYa
	 HSgnG59eLy9X4etlxpcPhLy3fYJOURREM63kXMKwqcFOfKkIeMIgB17vPLaisFt2B2
	 Ntzo75SGU7EFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803120452.181273-2-acme@kernel.org>
References: <20260803120452.181273-1-acme@kernel.org>
 <20260803120452.181273-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:17:54 +0000
Message-Id: <20260803121754.9E1461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `__hpp_list__parse()` function fails to break out of the strin=
g tokenization loop upon encountering an error, silently overwriting error =
codes and returning false success.
--

--- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked =
caller errors in hpp_list__parse() ---
commit 9193c764390834e98068c032e1076f1f5f739d5a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__=
parse()

This commit refactors hpp_list__parse() to correctly propagate errors from
tokenization and OOM situations. It replaces the PARSE_LIST macro with a
helper function to preserve and return the first encountered error.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..0f2fb13e705e3 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[ ... ]
> @@ -2063,26 +2065,34 @@ static int c2c_hists__init_sort(struct perf_hpp_l=
ist *hpp_list, char *name, stru
[ ... ]
> +static int __hpp_list__parse(struct perf_hpp_list *hpp_list, char *_list=
, struct perf_env *env,
> +			     int (*_fn)(struct perf_hpp_list *hpp_list, char *name, struct pe=
rf_env *env))
> +{
> +	char *tmp, *tok;
> +	int ret =3D 0;
> +
> +	if (!_list)
> +		return 0;
> +
> +	for (tok =3D strtok_r(_list, ", ", &tmp); tok; tok =3D strtok_r(NULL, "=
, ", &tmp)) {
> +		ret =3D _fn(hpp_list, tok, env);
> +		switch (ret) {
> +		case 0:
> +			continue;
> +		case -EINVAL:
> +			pr_err("Invalid --fields key: `%s'", tok);
> +			break;
> +		case -ESRCH:
> +			pr_err("Unknown --fields key: `%s'", tok);
> +			break;
> +		default:
> +			pr_err("%m for --fields key: `%s'", tok);
> +			break;
> +		}

[Severity: High]
Does this actually break out of the strtok loop on error? In C, a break
statement inside a switch block only exits the switch, not the enclosing
for loop.

If an invalid field is followed by a valid one (e.g.,
--fields invalid_field,valid_field), won't the loop continue, causing _fn()
to return 0 for the valid field and silently overwrite the error code in re=
t?

> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803120452.1812=
73-1-acme@kernel.org?part=3D1
