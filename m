Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C424A9D48
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364899; cv=none; b=WLnj/Ibmo0V6qFVqSwnH5ufWExDzXLRvSfpkW9cSqW2idGFxTLq5DN6JucQgEJBqdKqlLGxCkjP+QTOAXmfwb1XEyd2ehC33nOLkpdlpBjweTtyZjOyAOqaT6dAaJ1vESQMqav6CbkknlqW9GRKKJ7WUnjBHx+GjtEFFb/lBbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364899; c=relaxed/simple;
	bh=alWLNoaHv5gDDolZtRMUWhDIm9pSWIdgd+zCT1YW5H8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qw49lfffjYhmYnXsD3VEceW3R0w47UfhDUevUQrXbDk1FfQr6m5owpho72eumhcio3AHdjAXGFK7CreGDG//ipNcAtp63q4BQUYy85HaXrVglJS+7pM2Lop0LzG0VKK+38kozvvJnk0nlwP7Qz7zoUygRIJtDUTwJKAGH6oEOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnFDevox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnFDevox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2831F000E9;
	Wed,  2 Sep 2026 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364897;
	bh=alWLNoaHv5gDDolZtRMUWhDIm9pSWIdgd+zCT1YW5H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnFDevoxwSZgY19tuA9ypQADCQYbV0S2cZ99Emxj+Dx/XusIdzTwckC3+R7yspGRd
	 Fy9SCq1d5WgjD1Sez7FcuZEwsDVTB4cxgfk+XTRsHgfLAGimJAIhc/8N7DikrSK7rp
	 qJNDvwkY068b8HxiKkmlp2h2cg16R5k1+fhXGbkSdD++cUTfC8GZ9/QOwqBz6Pzp6J
	 E/r83D8e+2OXai7HkYv9gP/bKIDwbbia6053NVoBHh3+lni4sa5kVH2yxCpfXdsAsc
	 SAkxGWvEzjHZUzdQf7yO40W73C7JgF5dCqCng+96rH3Q3/3HMEfB6aMYer9OAD9h+I
	 /gKP0W2ZxzOug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] perf tool: Tidy up util/cache.h header file
 users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902154858.2078885-3-irogers@google.com>
References: <20260902154858.2078885-1-irogers@google.com>
 <20260902154858.2078885-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:01:36 +0000
Message-Id: <20260902160137.3E2831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Use git clang-format to sort header files. Review header file includes
> removing those that were unnecessary or adding explicit includes in
> cases where transitive dependencies were be using.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.2078=
885-1-irogers@google.com?part=3D2

