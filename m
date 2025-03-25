Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924B1991D2;
	Tue, 25 Mar 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927004; cv=none; b=B2BYb4/0xmplry1X6m/GGF199Jdh7OgzhwPtd2RQQULGxaqphJSDkI7sH9QcYvCNbPm9kADVP0hXIgjE13aa+n4+RB12sYSGk1O252HEkOppalMsKJKgHpJTwK1C5u1ooqKeqIH1n7WaH4q0GjQYTzpO3BolcPD0vr9O2wErcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927004; c=relaxed/simple;
	bh=wBXyK5/v+zshiQ5AJ78U67rSVAz/Ur6ZkcGgzsmTp8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WasXoXt3E9/jwhGrcweA5SeIqMJh6Qep94HgPdwMiO5rKP4swIZSYPOY5vUhpQVMBRnm1MNdDVDjiNlgJYKXJZgFPQRSKGcSRwXqFvAJnN4nRvwJTdyr/E5P8aX9XCCCEBD77XwvYKtEWKRzhl9crQoTBugE7uxQUUPtZl+OZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Modie2ge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Modie2ge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BDDC4CEE4;
	Tue, 25 Mar 2025 18:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742927003;
	bh=wBXyK5/v+zshiQ5AJ78U67rSVAz/Ur6ZkcGgzsmTp8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Modie2getBGH7oWwsObJBFzjFv49uLHLKNDG1G/a3eAgXCOBzRiogF11g6dYAxV4/
	 XvODcc00PjgRmLF7zSjwmm0Tpd30g+oSgZG05WokPSNbP7+2y35JjcFtcuEbU6nqZQ
	 0ILc8m0lZ0zNxr6zSU2ib+ByI33v+kIhjh9OboonFyJccND/IPWG6asVgfkH2PtaZT
	 lkYBRX6318Q8hN26hmNu8ChHVoWvrZLzFwaisA98ve70kYEN2+C/m4QJhWL9IAo90+
	 k4Y/SaeRt1nL4ZRvplFOU1/TxTwxbGxeA9RVVaDXEFcSNuHuFe7Sd0OlHR7mAT4iu9
	 u8iIJ9E6D/oPw==
Date: Tue, 25 Mar 2025 18:23:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: uaccess: Add additional userspace GCS
 accessors
Message-ID: <203a89bc-75d1-4ab0-ab42-52616103ad72@sirena.org.uk>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-4-jeremy.linton@arm.com>
 <50a0920d-3e3d-4e96-b68a-a7a0d78c3695@sirena.org.uk>
 <e8ada81d-0e10-412b-8792-035bc63113a6@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XP2AO17pHJsMVVJY"
Content-Disposition: inline
In-Reply-To: <e8ada81d-0e10-412b-8792-035bc63113a6@arm.com>
X-Cookie: Visit beautiful Vergas, Minnesota.


--XP2AO17pHJsMVVJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2025 at 06:43:23PM -0500, Jeremy Linton wrote:
> On 3/19/25 8:24 AM, Mark Brown wrote:

> > A GCS load done by the hardware will verify that we are loading from GCS
> > memory (the accesses are marked as AccessType_GCS in the pseudocode
> > which is then validated in for example S1CheckPermissions()).  Sadly
> > there's no equivalent of GCSSTR so we'd need to do the permission check
> > ourselves to match this behaviour.

> Right, except that if I grab the VMA as a placeholder for the page, check to
> see if its a VM_SHADOW_STACK under any of
> map_read_lock()/lock_vma_under_rcu()/etc and then perform the access, the
> resulting possible fault will have problems with vma locking. Otherwise
> there ends up being a few different races that at the moment I've not yet
> figured out how to fix without making a big mess. For example, we can reduce
> that possible window, by reading the value/locking and checking shadow stack
> state/dropping the lock/rereading the value, or some other construct but it
> seems pointless because the suggested problem is that we might be creating a
> way to bypass some of the shadow stack security. In which case, leaving a
> little race is likely the same as leaving it wide open.

Yeah, it's messy.  The "nicest" thing I could think of was doing a GCS
store of the value we just read to validate the GCS permission but that
has very obvious ick and is in it's own way incorrect.  Since the GCS
permission is always read/write I'm not sure what would notice without
an incredibly dodgy race but it's wrong.

> Otherwise, maybe we can ignore the problem, or just refuse to allow probes
> on 'RET' instructions which seems to be the main problematic case. Although,
> given we don't really know if GCS is enabled until the probe is hit,
> SIGSEG'ing the target process is a big hammer.

Yeah, that doesn't feel like the solution.

> Ignoring it might be a valid option. I guess it could to be one of those "if
> the user puts a uprobe on a RET some of the shadow stack security is
> reduced" footguns. If an attacker can also manipulate the address space in a
> way to exploit it then its probably game over anyway. Ideally, the kernel
> would warn on this, but per the conversation around patch 6/7 that seems to
> be off the table.

I'm not completely opposed to just not doing the validation given the
pain with implementing it, it's hard to be enthusiastic about any of the
options really.  If we are going to do something other than fully
and accurately emulate then we should acknowledge what's missing and
why, at least in the changelog and probably also in the code.

--XP2AO17pHJsMVVJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfi9JMACgkQJNaLcl1U
h9BVLgf9EGjIyA/yyo9Zc1l0VBnDeFJuL1QxPKsgq61Al37wBaxFi6YFTJp6uGYG
0frvA6r4/tMT4Tb1MTCwqp4BrIC9Iow8m17C16HRSDdG8yLxkIJgsH9nWGBZX55w
yLANK/H3BBc06kKKOYJqojJ2kjgFj+0JuD8JoKY4VUxEeUVFgv66n/LNb0+wWw5c
iRdolRJg/KGnQhYBpaWU8+A/HUEO14I/Te0DQCBe3q7DLLJhzruAW5SttcTElZDp
S4SjdGtbN3ES8fUObvqPKXq0KX/3YrsWlRmSQP9K6+PfbbmpksndRfyoNHZU8gkk
FY5l02qmP5eNnHNn3MFJ9m7WbyIcRw==
=agKn
-----END PGP SIGNATURE-----

--XP2AO17pHJsMVVJY--
