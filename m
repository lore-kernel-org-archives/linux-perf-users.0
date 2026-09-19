Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45295547058
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850848; cv=none; b=fbxtWymmJg3K6iUOC1pz9uxylZ+s8hq7Mso/khYGacWHUQ05GxJdZtLUTWVfA8oXy+9/FwlQ4QBj2NCXNaaW3uCR/RvYyC2qzDoAR0eItNwVrHgGrrGkODxdSpsMtVNEYpStX7QhzH3Gy7UseF0htyH+ztsRJzOTnZEdYUf6Jzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850848; c=relaxed/simple;
	bh=eFwdikKCRAUcjiuKmNqZhLH+cdIS/YtG3peyMdxne9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gBqI3Kz2T769gUc5wERToutXcaxbuO/J8xpHn8JHU2OcKJH3n0I/ep48yDZHFPZ1nQjZHzGK3JhHRJasGYD3uCJUJpASPXoElYFVfhLmDVjopHkfRnW8Dl+5ec2brkyHtoSPgTVhL2PSfevsuZ3NpDse0fqcHdoTrEiScuruBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5s/d/Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5s/d/Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B3C1F000FF;
	Sat, 19 Sep 2026 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850846;
	bh=7pBw3EllnNmt70VbTJqeeaAPu7WJZu6Oqx2Ny0Rqnzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a5s/d/Csj/qKNjyGrEjSiLIs+cHu2UtbbvGs7hYQa+nA7tbLF6XIa8C/gylR+ECWu
	 4XFGCIXTkmC/biHIKWCWqetR7CTpfc1udVG8/WsFuZnay2+KSj3wRhq7JncEJTYY6k
	 sNv+OBt089v3464c7uI3Tk+WTMHGiqtwZ+jVeMEsx57tojQQ6lAF9CfckYcPBryTsf
	 VW0SaXh8NNReMlBhuqlp7cUBj9N2IvlL1eU+JqW0zBOn5KqE/bKsDwwDsrWdCQTFUE
	 B/nbN4zvfqVrvznqitIgl5PmBDbpW4Pt0wcj7jVc+xIqaIN7MMujWv2QUOltOJDKV+
	 mzxBOvZD8L5hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-8-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:47:26 +0000
Message-Id: <20260919204726.C5B3C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected by the
> kernel on hardware without the privilege filter, so per-thread 'perf mem
> record' fails on AMD:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter exposed as the
> 'swfilt' format term, making those events usable per-thread:
>=20
> [ ... ]
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D7

