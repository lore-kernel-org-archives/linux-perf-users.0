Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6561DFE22;
	Thu, 24 Jul 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376504; cv=none; b=fhcshmkVudfSvtjGk6keEy0/5WIW4eG8yVJrMkOW4tg6ahJoppIWj8eZkNxk5JdPza7+CrJzVFCQbgv5hNjxEUgRX5S+IVbGwhK91ojjhULmaDMCmzOflUGVdEHnx78lYYQ7DpWJQ6RicbxDlv3QsRcn7QPQgNh72bSPq1i1E68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376504; c=relaxed/simple;
	bh=hmbP0QQTz5tEu2Ah74mZzpxPXVcjiUnxRzSHt+ipYEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksv7l5ANU13vOfOQ8UuliP0XyrF/YjGPvqj0zqYwdKNTqtbC3uejeZiexc0N0FjjWHyjqKluEg1sFc9iZBRefMox270zUl4VqBy37Ztd5evYoI2eJuB+5hFWcbNcPebS/wdvuuWEBTGXIEQvf2Yl8HfxDnfs/i76ZT0xlO4xIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmD8nzHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmD8nzHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE8C4CEED;
	Thu, 24 Jul 2025 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376503;
	bh=hmbP0QQTz5tEu2Ah74mZzpxPXVcjiUnxRzSHt+ipYEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmD8nzHSLbR6DydqTt3VzCI9LEO1iBSATrIZGYy/7bmbmHARkqPJrC2p6QhoGEkf2
	 Qb/BIMlJOHvKl32m5v64vhdNblFThzFbKZM9VguJkvgQyZwvylelOdNTCxwLSfSNts
	 QfxYlRTq/fYqF7IMHyh4kHESKNBypTLC6eePhphhhyz7ZW+j6oE24BRWzwo+acFLl7
	 15RA7yCu6D7yQHIDblgWqHXuLW6MNBbPlyJZCNNYVB8DO9mEOsI1Hsq0BDTkzkLdSm
	 /xhmgq8/u3KWgTxcr3QgaHBHyjD8F6g4fFzKnCEY1dHfiNMr9RPF4ECtUCCRuFbADy
	 tZxyXwqic2jxg==
Date: Thu, 24 Jul 2025 18:01:36 +0100
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
Message-ID: <2f776bd9-1b18-492d-afa0-94af5585f4f2@sirena.org.uk>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-5-jeremy.linton@arm.com>
 <aICwaQZxK5Spjj8G@arm.com>
 <2a6e1c4b-e8b0-49e2-896c-65c55103b017@arm.com>
 <aIHBQl9V0rMM1pjY@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7mXyxgtij9d66+x"
Content-Disposition: inline
In-Reply-To: <aIHBQl9V0rMM1pjY@arm.com>
X-Cookie: Did I say 2?  I lied.


--p7mXyxgtij9d66+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2025 at 06:14:42AM +0100, Catalin Marinas wrote:
> On Wed, Jul 23, 2025 at 12:14:17PM -0500, Jeremy Linton wrote:

> > Hence the comment to remind people that this routine isn't assuring the page
> > is correctly marked.

> I think the comment on the load function doesn't make much difference
> since LDR is permitted on an GCS page anyway. It's the pop function that
> we actually emulate without proper GCS instructions that's more
> problematic and won't be checked against actual GCS permissions.

This is used in the emulation of RET where it results in a similar lack
of a permission check - that does:

+       if (task_gcs_el0_enabled(current)) {
+               gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+               gcs_ret_vaddr = load_user_gcs((unsigned long __user *)gcspr, &err);

When implemented by the hardware we would generate a fault if the
address we're loading from is not in a page with GCS permissions.  The
issue isn't that userspace wouldn't be permitted to read the value, the
issue is that we are not checking that the value is being read from a
page with GCS permissions.

--p7mXyxgtij9d66+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiCZu8ACgkQJNaLcl1U
h9DlJQf/bZkySnCjsBKlHrkQ7LgdbiWlzRH3L43bJyunuKxDqwI38a2Vh4qmGZM8
bldlwsd/XNnUv5JXtc/U9+P4BJfVkmcDY1wY/FpxEKfSE2UAItV1j3e/OGz+d+iQ
lcDUYn4asBJFCpba2QhIMvgPIFgKJuVQvQCTBxsIsubOesDU9C8w/xQuALkmhVD5
ZHdnIJpeDpR2aNc86Db/yOhkjKrxGelb0H9YGWfjnMpW/ra1Rdo7jwmfNFX7YOhU
C+sVhOFrIljz32Cp/EWOSv25To7MmosIbIBZ+O4WDvgmsDO66GCdeaWwevaBfYLT
YGYZe5Wu0LA7AeLcmyBhHJdG8/uhJQ==
=ZBjO
-----END PGP SIGNATURE-----

--p7mXyxgtij9d66+x--
