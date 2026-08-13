Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C7399013
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665209; cv=none; b=b7QPAp0Y9Hg+7g6xTBOBRiTmVfItFGgCLhArRcx4J+/LGRn8ZBTgacz5qqFt89dqlD3YWOPl62JRXAvB6o8isJYtx52eJ8VcqFS/LzTdo+G8FRPcxWRCZxJ5IRouo6Fw9m1Y4mo3c7aQ/dVuLc1HaAFQquNRUYKtw4Ewk7fdo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665209; c=relaxed/simple;
	bh=f0FeTOo3kLavUbUw4tvjdEgeu8Mklm5znfooVyY8mpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RPkqtZSZLoymvGFM6/0kipG9kKx2/Of8/QP/JRaLMR7WYObxA0trHcY+eRjghmjlOy9RnrEK8I724RAX+aSxdh5EKGLocHh7TF4KD8T2fJ/Ssg5ZEW4WUThoEDcbhWfsjrGTrd/zLN55drdsOi7a4Z3FpQ2Dm/8j7JpFIyk7bDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bklq6Kw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bklq6Kw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608B71F000E9;
	Thu, 13 Aug 2026 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665208;
	bh=f0FeTOo3kLavUbUw4tvjdEgeu8Mklm5znfooVyY8mpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bklq6Kw+dpdzF5ktYS3cAD6+OIf8duwAuyJVvyoOmzaueWiQWquHcERLNmi3yaRxH
	 fhAUXz0qpEfpUJr3AWMKj9dry9IT/8QIlB0GE3L6t0vV4PqS4VAUK9uOu9bG2g5Xsw
	 Y1T2VAdW3mXt0XIZerGJGcv5u4Jy7WGDUkBg2unj+Ys80L4NRRj3gp85LqyA1HWhTp
	 8S88L+6VGGrNjpz2qb3jyurCf0kOnoRfXdErjmV4WhkNe+vf/nv4PZBAGhd/7vSAuW
	 7KjkbkhcFnglfvp4omCRVf3kntk5GUNI6ltYEQEQepj6sVd7syA4IOpURZnnRh4eWm
	 BNP0NaCyDsAcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/25] perf lock: Only pass sample to handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260403204017.2919994-10-irogers@google.com>
References: <20260403204017.2919994-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:53:23 +0000
Message-Id: <20260813235328.608B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The evsel is within the sample and so only the sample needs to be
> passed. Remove the parameter and fix call site.
>=20
> Add an additional NULL check in get_callstack, as prompted by Sashiko
> during review.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260403204017.2919=
994-1-irogers@google.com?part=3D9

