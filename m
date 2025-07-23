Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548818EB0;
	Wed, 23 Jul 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268476; cv=none; b=RDFJHE7vNhQHxqm0Q7wpaigJjmIkubFzFskaAWPXj0E64YngShgXK7aEKuo/bWxA9LLG5oqFxJVCyMk/k/h7qaPjBr48YKhIoeJ3sTBN9Bn4PG6XpnRVLfQYQQdRkC0ByWPOTRmJNjXFH64vOLg0bWaqruTC2xn8dWyfvz6QK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268476; c=relaxed/simple;
	bh=KKajWv6iXD2DJpbp036dw7aZbKM62MvOz8OdjwDW124=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLq8nLUCW80rqiqv6hC8Kz8dNOpP7PGRUS0CH9YQSThUl+S3PM4nYfA2KDC/ER4V9yT9oVtij+FkBKor8QuK7x1AzVZQhtrmd2Vqekyhq4IMAFX/eBnS3bRNQhS7qIdViAyq1Zy28VMaWbxDRI/uQJ8Bz1bjDE15orH842GXIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7WqLMq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7WqLMq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944C9C4CEE7;
	Wed, 23 Jul 2025 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268475;
	bh=KKajWv6iXD2DJpbp036dw7aZbKM62MvOz8OdjwDW124=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7WqLMq1gn6eEdTj3TMTutLL3KlZCoLBMjOI/EgQYTXCGlZq28Z4K6pLpJU2Qz1YY
	 Gh0CgCymRDVvjRrezkt4AdoMTM3tdUCA7mtRcTVJsD0K/6An6QRzxiNGC85SKmg4Q6
	 QghHba9i5AD6EbfhZVnJK/dVInLRJ/PNY/rPXXntKEc5YJEvfIUP2hIp+4wEiQH5cj
	 5+BwuYPkmNtrIP9lXHDg/VkMqDeR65oWkfjNalenSPudGEeELE4pSE01RdvrNQ2/qu
	 kYbjM6aFejmagJMp51vOcP8IBlusSTFRVCp3T0+2zoT/h7oxXpuzJvvV+h6k6LMxJh
	 BO2miA8JpLqvA==
Date: Wed, 23 Jul 2025 12:01:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] arm64: uaccess: Add additional userspace GCS
 accessors
Message-ID: <6e4cf749-d146-4f41-afec-6c07b025be93@sirena.org.uk>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-5-jeremy.linton@arm.com>
 <aICwaQZxK5Spjj8G@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pfS6fkSTDr7lad3R"
Content-Disposition: inline
In-Reply-To: <aICwaQZxK5Spjj8G@arm.com>
X-Cookie: List was current at time of printing.


--pfS6fkSTDr7lad3R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 23, 2025 at 10:50:33AM +0100, Catalin Marinas wrote:
> On Fri, Jul 18, 2025 at 11:37:36PM -0500, Jeremy Linton wrote:
> > +/*
> > + * Unlike put_user_gcs() above, the use of copy_from_user() may provide
> > + * an opening for non GCS pages to be used to source data. Therefore this
> > + * should only be used in contexts where that is acceptable.
> > + */

> Even in user space, the GCS pages can be read with normal loads, so
> already usable as a data source if one wants to (not that it's of much
> use). So not sure the comment here is needed.

The comment should probably be clarified to mention that the specific
issue is the lack of an operation that does a load with GCS permission
check to match what we have for stores, it'd be a bit of a landmine to
have the operation available without anything that flags that it didn't
validate the permissions (even assuming people read the comments in the
header...).

--pfS6fkSTDr7lad3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiAwPIACgkQJNaLcl1U
h9C1HQf/SesyTkkHOj8BBOtDMpXqeILfxSDN+1YY9sPtQnVWuBzz/BNXvVGV8hKN
WowF+nRWnOeP6E9pP9l3iApYCIMK5dYebcLOVVipocUI0q25/gy+HRLs6cyLKT07
NYwlIXJyw09hqYru40+rmqtvXn1vAYiulM+H76WUOjTfhrqUHceh4ZjYx0pVzcHe
2SDiw7M3K6m8VlWHuhIMx30P+82hAet2hhdxPXC1ry8tFx2Zm00KGl1Nl1KJ3ps8
CICn1km24uu2V3zU2siImytm+2ICHBZsHM1lasvSrCT8yo+bQX8h0zleTnda+xYc
OFPi+6eatJNwJXE4rZXOejC7vw75WQ==
=F1EQ
-----END PGP SIGNATURE-----

--pfS6fkSTDr7lad3R--
