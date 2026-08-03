Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F88416876
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777263; cv=none; b=la3WBndkUZeAryBz8sZ7msY3u2vaeb29c+XYdkemWfvG0waQw08kyJjdJgxOGr5PC597QiPa7fT+IHRJRBK4HTIhctfpYyVdPMBHUUnJQ6s3JtdpV2Ybk886aS/mIrpqAXuw5jUHn4YBDHhC2OO4UlGNwErOYfAn7i433Y3+sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777263; c=relaxed/simple;
	bh=3ARyZ8YwE0T8VWNx+yGfZ4urhJw8OuYUwAcNHAdIGEc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izctF6PPMat9xQAKxSuN/QEc4q2nIe8Qj6+jWTIXodVCc6zTu0qE4+ayNgJFpwiCUCJbpns5dBtxLSF+KNjvKwmZb8hIcsTf3TE1P0zv+MkYnTT3xLZJIQGbjV2To3Im/l5myfEI3MGLqlWA/tgeXoroCG5yHWCruUcJloRyaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJTPYzsw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJTPYzsw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so40845765ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777261; x=1786382061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQ+UNxE6uM8fSSYlklXepIB8FuY8kEOpEwFATNyW7No=;
        b=lJTPYzsw620PD4SeSvh+G4dKVLB9B3/z1ieJE5+a15kaqS6KesSiJd5KpaIuInb/q0
         EU7kg1RUVNQDqFQIhQzrAM1Qla8eqp/+B7NWfnx76mnJzrF9lFIR25Ai+fkVyc0dr/8Y
         TvA0ejIxvJe++6lN8yqkPq7rnNJy6E+lZry9YqvM1RL9qm0EunZElAViUAq/4kMd1T/j
         FSBurRcyXeDotrDSnSqKkwPfobfJp/j3CV42w/PqhkL8z/DgymiCnnO0duSseaPGfXrB
         cpIrhxPZXccXy9URn1HO3vhhhB2ZXTZHz4PCiQq2D/eRk2s682M1jc4bpaUaS1AcERCB
         O8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777261; x=1786382061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tQ+UNxE6uM8fSSYlklXepIB8FuY8kEOpEwFATNyW7No=;
        b=VL6mZtikqXALUHKrCFZsRhiTFp3WYklId5lZg9wsIInK7b2N+zHD8crmNF+pFAb4n3
         g6T6lEkLEvEG9uKtgtjvE/jku2cPM03/ldz3X4sSRYEgvVG22BJfx5gPxK8sQWQFnxs2
         zJYC16Lf3Bgma3gU7Wm5V4X2T8wfaqVGwbG0ALNKnologC/00S5VG9IkGU3Z2c1ch5xW
         DJA7VWKr9hxpaN2lqKi0LeRqJr/qsBSG0bZF9BiNoBTZvsPMy4qo72u47Qp39EXH9n6p
         QC+ulclu9xmcbJMhotw/2amgZtjWnVuUBoLSD8PPQbkKyYLsU+2uAlK3EobAa3Hm7zMf
         59CA==
X-Gm-Message-State: AOJu0Yy/a0HakwNtU5PI0uBYmOqlymH8BrZ6zpY3Okz3ykyGee5EXUgN
	cxg4ZmrHBiVMM09Y80QW4X/tWwtvTvdxDymqG3fji9oDFUw9WXPv4DV4+1HbYQ==
X-Gm-Gg: AR+sD10UgKPqaRrHnblPV1J7OvpCRaFmz4z9jM54EmwbVR3IprIZYxWI6cyKqsHcz8/
	iAZEv+tBqdyZ0QZWORpmCtyd+8SMAL4VnrrUMb+XB1Pz/XP5eCH0zQ6tNkIdiVvTyjB9o9doWBU
	kMlxcdAQzurdoK4mkNkwFMN4gcdoid/ZkFFUHdXD6neQWMVsfLglYTYJRXP3hdnvhtRAR6XRdih
	4vbTijwYsHy3DJM0kcvFDNJEAq5fm8tdn0IQS72oX8FEGgxVo8bwVCGY7f363WTSsEuq3a1yTu7
	5zVYgAgWYxl9EyHu/Nu97CLuhQnm3uh4cP5GSotw+AmpnCv2TxcFyLnDr2cB/Wo9PsbAVtKmhbj
	8ZmulK335Fer01Gt4wGv9pzNfHrrf7U/PdOhMjeTdbqNfXNBUt6TAjQbUG16Dn6ry+oXY3VEFCF
	VjZypEQS4H0eLmLH+7cB56NcQGesaeRVKbVNVVR5xHW4tWRYTI8dKF
X-Received: by 2002:a05:6a20:2d09:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c92a75ec8fmr10521733637.33.1785777261007;
        Mon, 03 Aug 2026 10:14:21 -0700 (PDT)
Received: from localhost ([2804:388:90d2:b659:18c8:3d0f:fc92:3c1b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm54545112c88.0.2026.08.03.10.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:14:20 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Mon, 3 Aug 2026 14:14:16 -0300
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
Message-ID: <anDMaPQdsyn8b4qs@localhost>
References: <20260803144119.185637-1-acme@kernel.org>
 <20260803144119.185637-2-acme@kernel.org>
 <20260803150230.0AB731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803150230.0AB731F000E9@smtp.kernel.org>

On Mon, Aug 03, 2026 at 03:02:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `%m` format specifier is used in `__hpp_list__parse` to log generic callback errors, which can result in incorrect or stale error messages.
> --
> 
> --- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__parse() ---
> commit 318c268818f1c0f5bf8bb06a4099029b27a33ee1
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__parse()
> 
> This commit addresses multiple bugs in hpp_list__parse(). It ensures that errors
> from output and sort parsing are not silently masked, handles OOM conditions
> from strdup() correctly, and properly propagates failures out of the strtok loop
> and up the call chain.
> 
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index c9584dbedf77a..b0f2ba8318304 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> [ ... ]
> > @@ -2063,26 +2065,34 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name, stru
> [ ... ]
> > +static int __hpp_list__parse(struct perf_hpp_list *hpp_list, char *_list, struct perf_env *env,
> > +			     int (*_fn)(struct perf_hpp_list *hpp_list, char *name, struct perf_env *env))
> > +{
> > +	char *tmp, *tok;
> > +	int ret = 0;
> > +
> > +	if (!_list)
> > +		return 0;
> > +
> > +	for (tok = strtok_r(_list, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> > +		ret = _fn(hpp_list, tok, env);
> > +		switch (ret) {
> > +		case 0:
> > +			continue;
> > +		case -EINVAL:
> > +			pr_err("Invalid --fields key: `%s'", tok);
> > +			goto out;
> > +		case -ESRCH:
> > +			pr_err("Unknown --fields key: `%s'", tok);
> > +			goto out;
> > +		default:
> > +			pr_err("%m for --fields key: `%s'", tok);
> 
> [Severity: Medium]
> Will %m print the correct error message here?
> 
> The _fn callback returns a negative error code in ret (such as -ENOMEM), but it
> does not necessarily set errno.
> 
> Even if it did, if the callback or its callees log anything, functions called
> internally by pr_err() (like fprintf or localtime_r) can clobber errno even on
> success. This could cause %m to print a stale or incorrect error string (e.g.,
> "No such file or directory" instead of "Cannot allocate memory").
> 
> Could we format the string using the actual error code available in ret instead
> of relying on the implicit global errno variable?
 

Indeed, I'll use str_error_r() in v5.

- Arnaldo
> > +			goto out;
> > +		}
> > +	}
> > +out:
> > +	return ret;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260803144119.185637-1-acme@kernel.org?part=1
